#!/usr/bin/env bash
# Free AI Volume Stack — launcher. LiteLLM aggregator on http://localhost:4000.
# One-time install already done by Operator (venv at ~/.free-ai-stack/.venv, keys at ~/.free-ai-stack/.env.free-stack).
# Just run:  bash "setup-free-stack.sh"
set -euo pipefail
STACK_DIR="/Users/amiraizhigitov/Claude/Projects/OPERATOR - AMIR"
HOME_STACK="$HOME/.free-ai-stack"
VENV="$HOME_STACK/.venv"
PY311="$HOME/.local/bin/python3.11"
ENVF="$HOME_STACK/.env.free-stack"
cd "$STACK_DIR"

echo "▶ Free AI Volume Stack"
if [ ! -f "$ENVF" ]; then
  echo "✗ No keys file at $ENVF (see .env.free-stack.example)."; exit 1
fi
if [ ! -x "$VENV/bin/litellm" ]; then
  echo "▶ Installing LiteLLM (one-time)…"
  "$PY311" -m venv "$VENV"
  "$VENV/bin/python" -m pip install -q --upgrade pip
  "$VENV/bin/pip" install -q "litellm[proxy]"
fi
set -a; source "$ENVF"; set +a
echo "▶ Proxy → http://localhost:4000  (API key: sk-freestack-local).  Ctrl-C to stop."
echo "  Test:  curl -s http://localhost:4000/v1/models -H 'Authorization: Bearer sk-freestack-local'"
exec "$VENV/bin/litellm" --config litellm-config.yaml --port 4000
