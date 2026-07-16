# free-ai-stack

One OpenAI-compatible endpoint that stacks a dozen **free** LLM tiers behind a single [LiteLLM](https://github.com/BerriAI/litellm) gateway and **auto-rotates on rate limits** — so high-volume AI tooling keeps working at £0.

Point any OpenAI-compatible client (OpenCode, Cline, Aider, your own scripts) at `http://localhost:4000/v1` and call one of the aliases below. When a provider 429s, LiteLLM cools it down and moves to the next deployment in the alias; when the whole alias is exhausted it falls through to a backup group. Provider keys are read from the environment — nothing secret lives in the repo.

## Aliases

| Alias | For | Backed by (free tiers) |
|-------|-----|------------------------|
| `free-coder` | hard / agentic coding | DeepSeek, GLM, Qwen3-Coder, GPT-OSS-120B, Cerebras, Zen |
| `free-general` | research, writing, Q&A | Gemini Flash, SambaNova, Groq, Qwen3-Next, Zen |
| `free-fast` | glue, classification | Groq GPT-OSS-20B, Gemini Flash-Lite, Zen |
| `free-bigctx` | 200K+ context / whole-repo | Z.ai GLM-4.7-Flash (203K), Qwen3-Coder (262K) |

## Run it

```bash
cp .env.example .env.free-stack     # add your own free keys (no card needed)
bash setup-free-stack.sh            # installs LiteLLM in a venv, starts the proxy on :4000
curl -s http://localhost:4000/v1/models -H "Authorization: Bearer sk-freestack-local"
```

```bash
curl -s http://localhost:4000/v1/chat/completions \
  -H "Authorization: Bearer sk-freestack-local" -H "Content-Type: application/json" \
  -d '{"model":"free-general","messages":[{"role":"user","content":"hello"}]}'
```

## Get free keys (all no-card)

Google AI Studio (Gemini, 1,500 req/day) · Groq · Cerebras · SambaNova · OpenRouter (free models) · Mistral. Paste them into `.env.free-stack` and re-run the launcher to widen the pool.

## Notes

Model IDs drift monthly — if a call 404s, open that provider's dashboard, copy the current slug into `litellm-config.yaml`, restart. `sk-freestack-local` is a **local-only** master key (like `localhost`), not a secret.

MIT — see [LICENSE](LICENSE).
