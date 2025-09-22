import os, zipfile

repo_name = "software-architecture-scaffold"
structure = {
    "README.md": """# Software Architecture Scaffold

This repository provides a **starter template** for documenting software architecture.  
It merges elements from:
- https://github.com/shekhargulati/software-architecture-document-template
- https://github.com/bflorat/architecture-document-template

## Quickstart
1. Clone or fork this repo.
2. Edit `docs/architecture.md` to describe your system.
3. Record major technical choices as ADRs in `docs/decisions/`.
4. Add or update diagrams in `docs/diagrams/`.

Stay consistent. Keep docs living with the codebase.
""",
    "docs/architecture.md": """# Software Architecture Document

## 1. Introduction
- Purpose
- Scope
- References
- Definitions & Acronyms

## 2. Stakeholders & Concerns
- Stakeholders list
- Goals & constraints
- Quality attributes (availability, scalability, performance, etc.)

## 3. Context & Motivation
- Business context
- System context diagram (see `diagrams/context-diagram.mmd`)
- Key use cases

## 4. Architecture Overview
- Design principles
- Architectural style (layered, microservices, event-driven, etc.)
- Crosscutting concepts (logging, monitoring, security)

## 5. Views
### 5.1 Functional View
- Modules, components, services

### 5.2 Information View
- Data models, schemas

### 5.3 Concurrency View
- Threads, processes, async flows

### 5.4 Development View
- Code structure, build, CI/CD

### 5.5 Deployment View
- Topology, environments, containers (see `diagrams/deployment-diagram.mmd`)

### 5.6 Operational View
- Monitoring, alerting, DevOps

## 6. Quality Requirements
- Non-functional requirements
- Trade-offs

## 7. Architecture Decisions
- Document ADRs (see `docs/decisions`)

## 8. Risks & Technical Debt
- Known issues
- Mitigation strategies

## 9. Glossary
- Domain terms (see `glossary.md`)
""",
    "docs/glossary.md": """# Glossary

| Term | Definition |
|------|-------------|
| ADR  | Architecture Decision Record |
| NFR  | Non-functional Requirement |
""",
    "docs/decisions/0001-record-architecture-decisions.md": """# 1. Record Architecture Decisions

Date: 2025-09-22

## Status
Accepted

## Context
We need to track important technical decisions and their context.

## Decision
We will record architecture decisions as [ADRs](https://adr.github.io/madr/).

## Consequences
- Improves transparency
- Future developers understand reasoning
""",
    "docs/diagrams/context-diagram.mmd": """```mermaid
flowchart LR
    user((User)) --> app[System Under Design]
    app --> db[(Database)]
```""",
    "docs/diagrams/deployment-diagram.mmd": """```mermaid
graph TD
    client[Client Browser] --> web[Web Server]
    web --> app[Application Service]
    app --> db[(Database)]
```""",
    ".gitignore": """# Ignore build artifacts
*.log
*.tmp
*.swp
*.bak
""",
    "LICENSE": "MIT License"
}

zip_filename = f"{repo_name}.zip"
with zipfile.ZipFile(zip_filename, 'w') as zipf:
    for filepath, content in structure.items():
        full_path = os.path.join(repo_name, filepath)
        zipf.writestr(full_path, content)

print(f"Created {zip_filename}")
