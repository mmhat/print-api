deps: ## Install the dependencies of the backend
	@cabal build --only-dependencies

build: ## Build the project in fast mode
	@cabal build -j

clean: ## Remove compilation artifacts
	@cabal clean

repl: ## Start a REPL
	@cabal repl

test: ## Run the test suite
	@cabal test -j

lint: ## Run the code linter (HLint)
	@find app src compat -name "*.hs" | xargs -P $(PROCS) -I {} hlint --refactor-options="-i" --refactor {}

style: ## Run the code styler (fourmolu and cabal-fmt)
	@cabal-fmt -i *.cabal
	@fourmolu -q --mode inplace src app compat

tags: ## Generate ctags for the project with `ghc-tags`
	@ghc-tags -c

help: ## Display this help message
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.* ?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

PROCS := $(shell nproc)

.PHONY: all $(MAKECMDGOALS)

.DEFAULT_GOAL := help
