CONTEXT
- Language: Python 3.11+ (async-first).
- Target: Kubernetes on AWS (EKS), with CI/CD.
- Use cases: crawl dynamic sites (JS-rendered), schedule recurring jobs, extract structured data, store raw + normalized, expose a query API.
- Constraints: ethical/legal crawling, robots.txt-aware, rate limiting per domain, observability from day one.
- I prefer boring-but-reliable infra, but use cutting-edge where it actually helps (Playwright, FastAPI, Pydantic v2, OpenTelemetry).

OUTPUT STYLE
- Be explicit. Provide runnable code, filenames, and commands.
- Each step ends with a short checklist and a “Run this to verify” snippet.
- Assume Linux dev env and Docker.

PHASE 0 — DEVELOPMENT PLAN (output this first)
1) Architecture diagram and components
2) Tech stack choices with 1-line justification each
3) Domain model & Pydantic schemas
4) Minimal walking skeleton (crawl one static page, one dynamic page)
5) Crawler core (fetch, parse, extract, store) with backpressure & retries
6) Anti-blocking layer (rotating proxies, fingerprinting, polite throttling)
7) Storage layer (PostgreSQL for normalized, S3/Parquet for raw, optional OpenSearch)
8) API layer (FastAPI): job submission, status, results, health
9) Orchestration: job queue + workers, scheduling (Temporal or Celery+Beat), K8s manifests
10) Observability: logging, metrics, traces (OpenTelemetry), dashboards, alerts
11) Tests: unit (pytest), contract tests for extractors, Playwright smoke test, load test
12) CI/CD: pre-commit, Ruff, MyPy, GitHub Actions, image build, deploy to EKS
13) Security & compliance: secrets, robots.txt, consent toggles, PII hygiene
14) Performance targets & tuning plan

THEN PROCEED THROUGH THESE STEPS

STEP A — TECH STACK (lock it in)
- HTTP: httpx + asyncio + httpx[http2]
- Rendering: Playwright headless Chromium with stealth context
- Parsing: selectolax (fast HTML), lxml fallback, parsel CSS/XPath helpers
- Extraction: Pydantic v2 models; optional LLM-assisted fallback via structured output guardrails (only if rules fail)
- Queue: Redis + RQ or Celery; OR Temporal Cloud-native Python SDK (justify choice)
- Scheduler: Celery Beat or Temporal schedules; cronjobs for K8s safety net
- Storage: PostgreSQL (SQLModel/SQLAlchemy 2.0), S3/MinIO for raw HTML/JSON as Parquet via pyarrow, optional OpenSearch/OpenSearch Dashboards for search
- API: FastAPI + Uvicorn
- Observability: OpenTelemetry (OTLP) -> Tempo/Jaeger, Prometheus metrics, Grafana dashboards; structlog or loguru for JSON logs
- Config: pydantic-settings, Twelve-Factor, dotenv for local, Secrets Manager/Parameter Store in prod
- Packaging: uv or pip-tools, Docker multi-stage, Poetry acceptable if you prefer
- Testing: pytest, pytest-asyncio, VCR.py for HTTP cassettes, Playwright test for smoke

Deliver:
- One paragraph per choice with tradeoffs.
- requirements.txt/pyproject.toml initial.

STEP B — REPO LAYOUT (scaffold)
Create a layout like:
.
├─ apps/
│  ├─ api/ (FastAPI service)
│  └─ worker/ (crawler workers)
├─ crawler_core/
│  ├─ fetcher.py
│  ├─ renderer.py
│  ├─ parser.py
│  ├─ extractor.py
│  ├─ storage.py
│  ├─ models.py
│  └─ rate_limit.py
├─ orchestration/
│  ├─ queue.py
│  └─ scheduler.py
├─ infra/
│  ├─ docker/ (Dockerfiles)
│  ├─ k8s/ (Helm chart or manifests)
│  └─ terraform/ (optional)
├─ tests/
│  ├─ unit/
│  ├─ integration/
│  └─ e2e/
├─ scripts/
└─ README.md

Provide files with minimal runnable content and a makefile:
- make dev, make test, make run, make lint, make format, make docker

STEP C — WALKING SKELETON
- Implement: fetcher (httpx), renderer (Playwright), parser (selectolax), extractor (toy rules)
- Demo: crawl 1 static page and 1 JS-heavy page, extract <title> and canonical URL, write to local SQLite (for now)
- Provide: docker-compose for local run

STEP D — CRAWLER CORE
- Add per-domain rate limiting + token bucket, async queue, retries with exponential backoff and jitter, robots.txt parser with caching
- Normalize outputs into Pydantic models; emit both raw and normalized
- Write raw responses to /data/raw as Parquet with partitioning by domain/date
- Insert normalized rows into Postgres

STEP E — ANTI-BLOCKING
- Rotating proxies (ENV-provided), session stickiness, randomized headers, Playwright stealth context, TLS JA3 mimicry via browser
- Respect robots.txt, add crawl-delay adherence, user-agent override with contact URL/email

STEP F — API
- FastAPI endpoints:
    POST /jobs                # submit crawl job (seed urls, depth, allowed_domains, render=true/false)
    GET  /jobs/{id}/status
    GET  /jobs/{id}/results   # paginated normalized data
    GET  /healthz
- Include OpenAPI, Pydantic validation, and simple API key auth

STEP G — ORCHESTRATION
- Choose Temporal or Celery. If Temporal: define workflows/activities for crawl job, retries, heartbeats.
- K8s manifests: Deployments for api and worker, HPA autoscaling on CPU + custom metrics (queue depth).
- Add a CronJob for periodic seeds.

STEP H — OBSERVABILITY
- Structured JSON logs with request_id/job_id correlation
- Prometheus metrics: request latency, success rate, bytes downloaded, queue depth, render time
- OpenTelemetry traces: fetch, render, parse spans connected across services
- Include sample Grafana dashboard JSON

STEP I — TESTS
- pytest unit tests for parsers/extractors with golden files
- integration tests: spin up Postgres, MinIO, Redis via docker-compose; run worker against fake site
- Playwright smoke test against a known JS site
- VCR.py cassettes for deterministic HTTP tests
- k6 or Locust basic load test plan

STEP J — CI/CD
- GitHub Actions: lint, type-check, test, build multi-arch Docker images, push, deploy to EKS
- Pre-commit with Ruff, Black, MyPy
- Supply .github/workflows/*.yml

STEP K — SECURITY & COMPLIANCE
- Secret management (env only locally, AWS SM in prod)
- PII scrubbing in logs
- “Do Not Crawl” allowlist/denylist and domain owner contact flow
- Configurable max pages, max depth, robots honoring

STEP L — PERFORMANCE TARGETS
- Baseline: 300 req/s static without render on t3.large worker, 10 page/s render with Playwright on c6i.xlarge, <2% error rate
- Provide tuning guide: concurrency, connection limits, render pool size

NON-NEGOTIABLES
- All code must be production-runnable with clear commands.
- Every module includes docstrings and type hints.
- Provide example config .env and sample K8s secrets (placeholders).
- Prefer simplicity over cleverness. If something is risky, say it and offer a safer fallback.

BEGIN by outputting PHASE 0 (the numbered plan). Then move to STEP A and onward.
