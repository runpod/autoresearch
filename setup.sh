#!/usr/bin/env bash
set -e

echo "=== autoresearch setup ==="

# Install uv if not present
if ! command -v uv &> /dev/null; then
    echo "Installing uv..."
    curl -LsSf https://astral.sh/uv/install.sh | sh
    export PATH="$HOME/.local/bin:$PATH"
fi

# Clone repo if not already in it
if [ ! -f "pyproject.toml" ] || ! grep -q "autoresearch" pyproject.toml 2>/dev/null; then
    echo "Cloning autoresearch..."
    git clone https://github.com/runpod/autoresearch.git
    cd autoresearch
fi

# Install dependencies
echo "Installing dependencies..."
uv sync

# Download data and train tokenizer
echo "Preparing data (this takes ~2 minutes)..."
uv run prepare.py

echo ""
echo "=== Ready! ==="
echo "Point your coding agent at program.md to start experimenting."
echo "Example prompt: 'Read program.md and let's kick off a new experiment!'"
