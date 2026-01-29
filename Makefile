.PHONY: init check-env clean fetch-sources build-env

init:
	@echo "Initializing Ukemi Distro Workspace..."
	@mkdir -p .context .agent_memory .system_prompts build/sources output logs scripts configs core iso tests
	@echo "Directories verified."

check-env:
	@echo "Checking environment dependencies..."
	@which python3 > /dev/null || (echo "Python3 not found" && exit 1)
	@which docker > /dev/null || (echo "Docker not found" && exit 1)
	@echo "Environment OK."

fetch-sources:
	@python3 scripts/orchestrator.py "python3 core/downloader.py"

build-env:
	@bash scripts/enter_env.sh

toolchain-p1:
	@echo "🔨 Iniciando construcción de la Toolchain (Paso 1) en el Sandbox..."
	@docker run -it --rm \
        -v "$$(pwd)":/mnt/ukemi \
        -w /mnt/ukemi \
        -e LFS=/mnt/ukemi/target \
        -e LFS_TGT=x86_64-lfs-linux-gnu \
        ukemi-builder \
        python3 core/toolchain_builder.py

clean:
	@echo "Cleaning build directory..."
	@rm -rf build/*
	@echo "Cleaned."
