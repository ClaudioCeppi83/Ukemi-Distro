#!/bin/bash
# scripts/validate_build.sh
# QA and Security Validation (qa-validator skill)

set -e

echo "🔍 Starting QA & Security Validation..."

# 1. ShellCheck Validation
echo "🛡️  Running ShellCheck on scripts..."
if command -v shellcheck >/dev/null 2>&1; then
    find . -name "*.sh" -not -path "./build/*" -exec shellcheck {} +
else
    echo "⚠️  Warning: 'shellcheck' not found in host. Skipping local linting."
    echo "💡 Recommendation: Run this script inside the builder environment using ./scripts/enter_env.sh"
fi

# 2. Forbidden Sudo Check
echo "🚫 Checking for unauthorized sudo usage..."
if grep -r "sudo " core/ scripts/ --exclude="validate_build.sh"; then
    echo "❌ ERROR: Found 'sudo' in automated scripts. This violates the Strict Isolation Policy."
    exit 1
fi

# 3. Kernel Config Validation
echo "🔬 Validating Kernel Configuration Requirements..."
# Check for local path or mounted build path
PROJECT_ROOT=$(git rev-parse --show-toplevel 2>/dev/null || pwd)
KERNEL_CONFIG="$PROJECT_ROOT/configs/kernel.config"

if [ -f "$KERNEL_CONFIG" ]; then
    REQUIRED_FLAGS=("CONFIG_HZ=1000" "CONFIG_PREEMPT=y")
    for flag in "${REQUIRED_FLAGS[@]}"; do
        if ! grep -q "^$flag" "$KERNEL_CONFIG"; then
            echo "❌ ERROR: Missing mandatory kernel flag: $flag"
            exit 1
        fi
    done
    echo "✅ Kernel config validation passed."
else
    echo "⚠️  Warning: No kernel.config found to validate yet."
fi

# 4. Permissions Integrity
# Check if HOST_UID/GID are set if we are in builder env
if [ -n "$HOST_UID" ]; then
    echo "👤 Builder environment detected (Running as UID $HOST_UID)."
fi

echo "✅ QA Validation Completed Successfully."
