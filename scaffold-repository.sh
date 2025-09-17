#!/bin/bash
# Use current directory name as project name
# ./scaffold-repository.sh
# Or specify custom project name
#  ./scaffold-repository.sh <project_name>

set -euo pipefail  # Exit on error, undefined vars, pipe failures

# Configuration
PROJECT_NAME="${1:-$(basename $(pwd))}"
PYTHON_VERSION="3.9.18"
VENV_NAME="${PROJECT_NAME}_env"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

log_info() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

log_warn() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
    exit 1
}

check_command() {
    if ! command -v "$1" &> /dev/null; then
        log_error "$1 is not installed. Please install it first."
    fi
}

# Check required tools
log_info "Checking required tools..."
check_command git
check_command pyenv
check_command direnv
check_command pip

# Git operations
if [[ -d .git ]]; then
    log_info "Staging pre-commit configuration..."
    git add .pre-commit-config.yaml .gitleaks.toml

    log_info "Creating secrets baseline..."
    if command -v detect-secrets &> /dev/null; then
        # Create baseline by scanning current directory and outputting to baseline file
        detect-secrets scan --all-files --force-use-all-plugins > .secrets.baseline
        git add -f .secrets.baseline
    else
        log_warn "detect-secrets not found, skipping baseline creation"
    fi
else
    log_warn "Not a git repository, skipping git operations"
fi

# Python environment setup
log_info "Setting up Python environment..."

# Create .envrc for direnv
cat << EOF > .envrc
layout pyenv ${PYTHON_VERSION}
EOF

log_info "Allowing direnv..."
direnv allow

# Python version management
if pyenv versions --bare | grep -q "^${PYTHON_VERSION}$"; then
    log_info "Python ${PYTHON_VERSION} already installed"
else
    log_info "Installing Python ${PYTHON_VERSION}..."
    if pyenv install ${PYTHON_VERSION} 2>/dev/null || [[ -d "${HOME}/.pyenv/versions/${PYTHON_VERSION}" ]]; then
        log_info "Python ${PYTHON_VERSION} installation completed"
    else
        log_error "Failed to install Python ${PYTHON_VERSION}"
    fi
fi

# Virtual environment
if pyenv versions --bare | grep -q "^${VENV_NAME}$"; then
    log_info "Virtual environment ${VENV_NAME} already exists"
else
    log_info "Creating virtual environment ${VENV_NAME}..."
    pyenv virtualenv ${PYTHON_VERSION} ${VENV_NAME}
fi

log_info "Setting local Python version..."
pyenv local ${VENV_NAME}

# Install pre-commit if available
if command -v pip &> /dev/null; then
    log_info "Installing pre-commit..."
    pip install pre-commit

    if [[ -d .git ]]; then
        log_info "Installing pre-commit hooks..."
        pre-commit install

        log_info "Running pre-commit on all files..."
        pre-commit run --all-files || log_warn "Some pre-commit checks failed"
    fi

    if [[ -f src/requirements.txt ]]; then
        log_info "Installing project requirements..."
        pip install -r src/requirements.txt
    fi
else
    log_error "pip not available in current environment"
fi

log_info "Repository scaffolding completed successfully!"
log_info "Project: ${PROJECT_NAME}"
log_info "Python version: ${PYTHON_VERSION}"
log_info "Virtual environment: ${VENV_NAME}"

echo -e "\n${GREEN}Next steps:${NC}"
echo "1. Review and customize the generated files"
echo "2. Add your project-specific content to README.md"
echo "3. Update src/requirements.txt with your dependencies"
echo "4. Commit your changes: git add . && git commit -m 'Initial scaffold'"
