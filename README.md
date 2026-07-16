# free-ai-stack

**One OpenAI-compatible endpoint. A dozen free LLM tiers. Auto-rotates the moment you hit a rate limit.**

Point any OpenAI-compatible client — [OpenCode](https://opencode.ai), Cline, Aider, or your own scripts — at `http://localhost:4000/v1`, call one alias, and a [LiteLLM](https://github.com/BerriAI/litellm) gateway spreads the request across ~10 free providers, cooling down any that `429` and falling through to the next. High-volume AI tooling at **£0**, no credit card. Keys are read from the environment — nothing secret lives in this repo.

## Why

Every free tier has a ceiling — Gemini ~1,500 req/day, Groq ~1k/day, Cerebras ~1M tokens/day. On its own each one runs dry by mid-afternoon. **Stacked behind a single endpoint they add up to well over 15k requests/day, and you stop seeing rate-limit errors entirely** because the gateway rotates to the next provider for you.

## Providers it stacks (all free, no card — verify, tiers drift monthly)

| Provider | Free tier (approx.) | Models used |
|---|---|---|
| Google AI Studio | ~1,500 req/day | Gemini 2.5 Flash / Flash-Lite (1M ctx) |
| Groq | ~1k req/day, ~300 tok/s | GPT-OSS-120B / 20B |
| Cerebras | ~1M tokens/day | GLM-4.7, GPT-OSS-120B |
| SambaNova | high daily token budget | Llama-3.3-70B |
| OpenRouter | free model slugs | Qwen3-Coder, GPT-OSS-120B, Qwen3-Next-80B |
| OpenCode Zen | always-free anchor | DeepSeek-V4-Flash, GLM-4.6-class |
| Z.ai | free | GLM-4.7-Flash (203K ctx) |
| Mistral | ~1B tokens/mo (Experiment) | Codestral |
| NVIDIA NIM | ~1k req/day | DeepSeek, GLM |

## Aliases — route by task

| Alias | For | Backed by |
|---|---|---|
| `free-coder` | hard / agentic coding | DeepSeek, GLM, Qwen3-Coder, GPT-OSS-120B, Cerebras, Zen |
| `free-general` | research, writing, Q&A | Gemini, SambaNova, Groq, Qwen3-Next, Zen |
| `free-fast` | glue, classification | Groq GPT-OSS-20B, Gemini Flash-Lite, Zen |
| `free-bigctx` | 200K+ context / whole-repo | Z.ai GLM-4.7-Flash (203K), Qwen3-Coder (262K) |

## 60-second start

```bash
cp .env.example .env.free-stack       # add your own free keys
bash setup-free-stack.sh              # installs LiteLLM in a venv, runs the proxy on :4000
```
```bash
curl -s http://localhost:4000/v1/chat/completions \
  -H "Authorization: Bearer sk-freestack-local" -H "Content-Type: application/json" \
  -d '{"model":"free-general","messages":[{"role":"user","content":"hello"}]}'
```

## How the rotation works

Multiple deployments share one alias (`model_name`). On `429`/`5xx`/timeout, LiteLLM cools that deployment for `cooldown_time` and moves to the next; when the whole alias is exhausted it falls through to a backup group. `routing_strategy: simple-shuffle` spreads load so you don't burn one provider first. It's all in [`litellm-config.yaml`](litellm-config.yaml) — every model line is tagged `# VERIFY` because slugs drift; if a call `404`s, paste the current slug from that provider's dashboard and restart.

## Honest notes

Free tiers and model IDs change **monthly** — treat the table as a starting point and re-verify. `sk-freestack-local` is a **local-only** master key (like `localhost`), not a secret. This is a personal-scale setup: within free limits it's plenty for solo tooling; it is not meant to power a production product.

MIT — see [LICENSE](LICENSE).
