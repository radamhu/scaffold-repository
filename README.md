# Main Purpose
This is a repository scaffolding automation tool designed to bootstrap new development projects with a comprehensive security-first setup. The main script scaffold-repository.sh creates a standardized project structure with built-in security scanning, Python environment management, and development best practices.

## Quickstart
1. Clone or fork this repo.
2. Edit `docs/architecture.md` to describe your system.
3. Record major technical choices as ADRs in `docs/decisions/`.
4. Add or update diagrams in `docs/diagrams/`.

Stay consistent. Keep docs living with the codebase.

## Project Structure
The repository follows a clean, modular structure:

Stay consistent. Keep docs living with the codebase.

```
├── docs/
│   ├── architecture.md
│   ├── glossary.md
│   ├── diagrams/
│   │   ├── context-diagram.mmd
│   │   └── deployment-diagram.mmd
│   └── decisions/
│       └── 0001-record-architecture-decisions.md
├── scaffold-repository.sh          # Main automation script
├── .pre-commit-config.yaml         # Pre-commit hooks configuration
├── .gitleaks.toml                  # Secret detection rules
├── .github/
│   ├── workflows/secret-scan.yml   # CI/CD security pipeline
│   └── instructions/               # AI assistant guidelines
├── .specstory/                     # SpecStory extension artifacts
├── scaffold-repositoryHLD.d2       # High-level design diagram
└── Documentation files             # README, PROMPT, CODE_ANALYSIS_PROMPT
```

## Current Functionality Summary

Think of this as a "project starter kit generator." When you want to create a new coding project, instead of manually setting up all the boring but important stuff (like security checks, Python environments, and coding standards), you just run one command and this script does it all for you.

Here's what it does:

- Sets up your workspace: Creates all the folders you'll need
- Configures security: Adds tools that automatically scan for passwords or API keys you might accidentally commit
- Manages Python: Creates an isolated Python environment so your project doesn't interfere with others
- Enforces quality: Sets up automatic code formatting and checking
- CI/CD Ready: Configures GitHub Actions for automatic security scanning

It's like having an experienced developer set up your project structure for you, following all the best practices they've learned over years.

## Setup
Run `./scaffold-repository.sh` to set up the development environment.

## Source
- https://github.com/shekhargulati/software-architecture-document-template
- https://github.com/bflorat/architecture-document-template