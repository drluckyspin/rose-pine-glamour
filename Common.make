# -----------------------------------------------------------------------------------------------------------
# Common Makefile — Rosé Pine Glamour
# -----------------------------------------------------------------------------------------------------------
# Glamour styles for terminal markdown (Glow, CLIs). Targets use scripts/log.bash for output.
#
#   make help        — list targets
#   make check       — verify jq, go (glow/python optional)
#   make build       — regenerate styles/*.json from Go sources
#   make test        — validate JSON + Glamour render
#   make screenshots — regenerate gallery PNGs (requires Python + Pillow)
#   make preview     — render examples/sample.md with glow
#   make clean       — remove Python caches and Go test cache
# -----------------------------------------------------------------------------------------------------------

.DEFAULT_GOAL := help

PROJECT_NAME := Rosé Pine Glamour
SHELL := /bin/bash

COMMON_MAKEFILE_DIR := $(dir $(abspath $(firstword $(MAKEFILE_LIST))))
LOGGER := source $(COMMON_MAKEFILE_DIR)scripts/log.bash &&
STYLES_DIR := $(COMMON_MAKEFILE_DIR)styles
SCRIPTS_DIR := $(COMMON_MAKEFILE_DIR)scripts
VERIFY_DIR := $(SCRIPTS_DIR)/verify
SAMPLE_MD := $(COMMON_MAKEFILE_DIR)examples/sample.md

# Default style for make preview (override: make preview STYLE=rose-pine-dawn)
STYLE ?= rose-pine-moon-dark
STYLE_FILE := $(STYLES_DIR)/$(STYLE).json

# -----------------------------------------------------------------------------------------------------------
# Help
# -----------------------------------------------------------------------------------------------------------

.PHONY: help build check clean test screenshots preview
.PHONY: ensure_jq ensure_python ensure_go ensure_glow

.PHONY: help ## Show this help message
help:
	@$(LOGGER) log_separator
	@$(LOGGER) log_banner
	@$(LOGGER) log_info "Available make targets ($(PROJECT_NAME)):"
	@echo ""
	@grep -E \
		'^.PHONY: .*?## .*$$' $(MAKEFILE_LIST) | \
		sort | \
		awk 'BEGIN {FS = ".PHONY: |## "}; {printf "  %-22s - %s\n", $$2, $$3}'
	@echo ""
	@$(LOGGER) log_info "Quick start"
	@$(LOGGER) log_dim "make check && make build && make test"

# -----------------------------------------------------------------------------------------------------------
# Tool checks (ensure_* = silent deps; check_* = logged for make check)
# -----------------------------------------------------------------------------------------------------------

ensure_jq:
	@command -v jq >/dev/null 2>&1 || { \
		$(LOGGER) log_error "jq is not installed (brew install jq)"; \
		exit 1; \
	}

check_jq: ensure_jq
	@$(LOGGER) log_progress "jq $$(jq --version) is installed."

ensure_python:
	@command -v python3 >/dev/null 2>&1 || { \
		$(LOGGER) log_error "python3 is not installed (brew install python)"; \
		exit 1; \
	}

check_python:
	@if command -v python3 >/dev/null 2>&1; then \
		$(LOGGER) log_progress "python3 $$(python3 --version 2>&1 | cut -d' ' -f2) is installed."; \
	else \
		$(LOGGER) log_warning "python3 not installed — optional for make screenshots (brew install python)"; \
	fi

ensure_go:
	@command -v go >/dev/null 2>&1 || { \
		$(LOGGER) log_error "go is not installed (brew install go)"; \
		exit 1; \
	}

check_go: ensure_go
	@$(LOGGER) log_progress "go $$(go version | awk '{print $$3}') is installed."

ensure_glow:
	@command -v glow >/dev/null 2>&1 || { \
		$(LOGGER) log_error "glow is not installed (brew install glow)"; \
		exit 1; \
	}

check_glow:
	@if command -v glow >/dev/null 2>&1; then \
		$(LOGGER) log_progress "glow $$(glow --version 2>&1 | head -1) is installed."; \
	else \
		$(LOGGER) log_warning "glow not installed — optional for make preview (brew install glow)"; \
	fi

check_pillow:
	@if command -v python3 >/dev/null 2>&1 && ! python3 -c "import PIL" 2>/dev/null; then \
		$(LOGGER) log_warning "Pillow not installed — required for make screenshots (brew install pillow)"; \
	fi

.PHONY: check ## Verify required tools (jq, go)
check:
	@$(LOGGER) log_separator
	@$(LOGGER) log_info "Checking dependencies"
	@echo ""
	@$(MAKE) check_jq
	@$(MAKE) check_go
	@$(MAKE) check_glow
	@$(MAKE) check_python
	@$(MAKE) check_pillow
	@if [ ! -f "$(STYLE_FILE)" ]; then \
		$(LOGGER) log_warning "Default style not found: $(STYLE_FILE) (run make build)"; \
	fi
	@$(LOGGER) log_success "Check complete"

# -----------------------------------------------------------------------------------------------------------
# Build & validate
# -----------------------------------------------------------------------------------------------------------

.PHONY: build ## Regenerate styles/*.json from Go sources (go generate)
build: ensure_go
	@$(LOGGER) log_separator
	@$(LOGGER) log_info "Building Glamour style JSON"
	@echo ""
	@cd $(STYLES_DIR) && go generate .
	@$(LOGGER) log_success "Styles written to styles/"

.PHONY: test ## Validate JSON and verify Glamour can render each style
test: ensure_jq ensure_go
	@$(LOGGER) log_separator
	@$(LOGGER) log_info "Testing styles"
	@echo ""
	@if ! compgen -G "$(STYLES_DIR)/*.json" > /dev/null; then \
		$(LOGGER) log_error "No style JSON found — run make build"; \
		exit 1; \
	fi
	@$(LOGGER) log_progress "Validating JSON syntax..."
	@jq empty $(STYLES_DIR)/*.json
	@$(LOGGER) log_progress "All style JSON files are valid."
	@cd $(VERIFY_DIR) && go run .
	@$(LOGGER) log_success "All styles render successfully"

# -----------------------------------------------------------------------------------------------------------
# Gallery & preview
# -----------------------------------------------------------------------------------------------------------

.PHONY: screenshots ## Regenerate screenshots/*.png (requires Python + Pillow)
screenshots: ensure_python
	@$(LOGGER) log_separator
	@$(LOGGER) log_info "Generating screenshot PNGs"
	@echo ""
	@python3 -c "import PIL" 2>/dev/null || { \
		$(LOGGER) log_error "Pillow required: brew install pillow"; \
		exit 1; \
	}
	@python3 $(SCRIPTS_DIR)/generate-screenshots.py
	@$(LOGGER) log_success "Screenshots written to screenshots/"

.PHONY: preview ## Preview sample markdown with glow (STYLE=rose-pine-moon-dark)
preview: ensure_glow
	@echo ""
	@if [ ! -f "$(STYLE_FILE)" ]; then \
		$(LOGGER) log_error "Style not found: $(STYLE_FILE) (run make build)"; \
		exit 1; \
	fi
	@$(LOGGER) log_separator
	@$(LOGGER) log_info "Previewing $(SAMPLE_MD) with $(STYLE).json"
	@glow -s "$(STYLE_FILE)" "$(SAMPLE_MD)" --pager=false

# -----------------------------------------------------------------------------------------------------------
# Clean
# -----------------------------------------------------------------------------------------------------------

.PHONY: clean ## Remove Python caches and Go test cache
clean:
	@$(LOGGER) log_separator
	@$(LOGGER) log_info "Cleaning artifacts"
	@echo ""
	@$(LOGGER) log_progress "Removing Python __pycache__ directories"
	@find $(COMMON_MAKEFILE_DIR) -type d -name __pycache__ -exec rm -rf {} + 2>/dev/null || true
	@$(LOGGER) log_progress "Clearing Go build and test caches"
	@rm -rf $(VERIFY_DIR)/go.sum.bak 2>/dev/null || true
	@go clean -cache -testcache 2>/dev/null || true
	@$(LOGGER) log_success "Clean complete"
