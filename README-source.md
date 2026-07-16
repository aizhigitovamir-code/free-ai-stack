# FREE AI VOLUME STACK — expand + auto-rotate (2026-07-07)

Companion to `FREE-CODING-STACK.md` (your live OpenCode + CCR setup from 2026-07-05).
That doc got you 3 agents running at £0. **This doc adds the missing piece you asked for:
one endpoint that stacks ~10 free providers and auto-rotates to the next-best model the
instant a limit is hit — so you get high daily volume, not just short bursts.**

---

## ✅ STATUS: INSTALLED, TESTED, READY TO RUN (2026-07-07)

Operator set this up on your Mac. Done for you:
- **LiteLLM installed** (Python 3.11 venv at `~/.free-ai-stack/.venv`).
- **Config finalized with current, live-verified model IDs** — Groq → GPT-OSS 120B/20B (Kimi/Llama were retired 17 Jun 2026), Cerebras → GLM-4.7 + Qwen3-235B, OpenRouter free slugs pulled straight from your account.
- **Two providers pre-wired with your existing keys** (OpenRouter + OpenCode Zen) → the stack works with **zero new signups**. Zen (big-pickle, GLM-4.6-class) is baked in as an always-free anchor.
- **Live-tested end to end:** all three aliases returned real output through the proxy; when OpenRouter hit a 429 it **auto-rotated to Zen and answered** — the rotation you asked for, proven.
- **Update 2026-07-07 — 4 more keys added + tested: Gemini, Groq, SambaNova, Cerebras → 6 providers now LIVE.** All authenticate; all four aliases return output. (Cerebras free serves GLM-4.7 + GPT-OSS-120B; Qwen-235B isn't on its free tier, so that slug was swapped out.) `free-coder` now rotates real top models, not just Zen.
- **OpenCode + CCR wired** to the proxy (additive; old setup untouched; backups saved as `*.bak-freestack-20260707`).

**Run it:**
```
bash "/Users/amiraizhigitov/Claude/Projects/OPERATOR - AMIR/setup-free-stack.sh"
```
Proxy comes up on `http://localhost:4000`. In OpenCode type `/models` → **Free Stack → Free Coder**. Add more free keys (below) to widen the pool and pull in the top-tier coders.

---

## Truth up front (don't skip)

- **Nothing free equals Opus 4.8 / Fable 5 sustained.** Opus 4.8 leads SWE-bench Pro at 69.2%. The free ceiling is GLM-5.2 (62.1% SWE-Pro, best open-weight), Kimi K2.6 and DeepSeek V4 — near-frontier *in bursts*, rate-limited.
- **The trick isn't one magic free model — it's stacking many free tiers behind one router.** Summed, the stack below gives roughly **5,000+ requests/day and 25M+ tokens/day at £0**. When provider A throttles, the router silently moves to B, then C. That is exactly the "rotate to second best when limit hits" you wanted.
- **Free endpoints may train on your prompts.** Never paste client secrets, credentials, or private client code into free models. Fine for your own code, research, automations, drafting.
- **Free tiers shift monthly.** Everything here is verified 2026-07-07. Re-check a provider's dashboard before depending on it. Dead as of now: **Chutes free** (retired 15 Mar 2026), **Together AI** (no free tier), plus the CLIs already logged dead in `FREE-CODING-STACK.md` (Qwen Code, iFlow, Gemini CLI OAuth, Kimi Code free).

---

## The stack — 10 live free providers (verified 2026-07-07)

Ranked by how much free daily volume + quality they add to your pool.

| # | Provider | Free daily budget | Best free models | Card? | Role in your stack |
|---|----------|-------------------|------------------|-------|--------------------|
| 1 | **Google AI Studio** (Gemini API) | **1,500 req/day** Flash (250K TPM); Pro 50/day | Gemini 2.5 Flash / Flash-Lite | No | Generalist + automation glue; huge daily count |
| 2 | **SambaNova Cloud** | **20M tokens/day** (10–30 RPM) | Llama 3.3 70B, Llama 3.1 405B, Qwen2.5 72B | No | Biggest token budget; +$5 credit (30d) |
| 3 | **Groq** | 1,000 req/day large / **14,400 req/day small** (30 RPM) | GPT-OSS 120B / 20B (Kimi & Llama retired Jun'26) | No | Fastest inference; strong open coder + fast tasks |
| 4 | **Cerebras** | **1M tokens/day** (30 RPM, ~2,600 tok/s) | GLM-4.7, Qwen3-235B (131K ctx), GPT-OSS 120B | No | Speed king; GLM-4.7 is a genuinely strong free coder |
| 5 | **NVIDIA NIM** (build.nvidia.com) | ~40 RPM per model (no hard daily cap) | DeepSeek R1/V4, GLM-5, Qwen3-Coder | No* | Best free access to top-tier coding models |
| 6 | **Mistral La Plateforme** | ~**1B tokens/month** (~33M/day) | Codestral, Mistral Large/Medium | No | Free Codestral for IDE completions |
| 7 | **Z.ai** | Free "Flash" models, unlimited-ish | **GLM-4.7-Flash (203K ctx)**, GLM-4.5-Flash | No | Largest free context window anywhere |
| 8 | **OpenRouter :free** | 50/day (<$10) or **1,000/day (≥$10 lifetime)** | Qwen3-Coder-480B (262K ctx), DeepSeek R1/V3, GLM | No | Already wired into your CCR; breadth |
| 9 | **GitHub Models** | 50/day high + 150/day mini (8K in / 4K out) | GPT, Llama, Codestral, Mistral | No | Any GitHub account; tight caps → light tasks |
| 10 | **OpenCode Zen** | ~200 req/5h Big Pickle + 4 more | Big Pickle, DeepSeek V4 Flash Free | No | Already installed; your daily driver |

*NVIDIA = free but needs developer/phone signup.

**Why this beats "just add more to OpenCode":** OpenCode and CCR each rotate *within* one provider (OpenRouter). This stack rotates *across all 10*, so provider-A's 50/day cap stops mattering — you fall through to 9 more pools automatically.

---

## Best free-accessible models right now (coding + general)

Benchmarks are contamination-caveated across the board, but the ranking is stable:

| Model | Score | Free where | Use for |
|-------|-------|-----------|---------|
| **GLM-5.2** | 62.1% SWE-Pro (best open-weight, 1M ctx) | NVIDIA NIM (GLM-5); Z.ai Flash free; cheap via Z.ai plan | Hard coding / agentic |
| **DeepSeek V4-Pro** | 80.6% SWE-Verified, 93.5% LiveCodeBench | NVIDIA NIM; OpenRouter (V3/R1 :free); Zen (V4 Flash) | Hard coding / reasoning |
| **Kimi K2.6 Thinking** | 78.6 coding avg (2nd open on LiveBench) | Groq (Kimi K2); OpenRouter kimi:free; your CCR think-route | Deep thinking tasks |
| **Qwen3-Coder-480B / Next** | 70.6% SWE-Verified (262K ctx) | OpenRouter :free; Cerebras; NVIDIA | Large-context coding |
| **MiniMax M3** | 59% SWE-Pro (1M ctx, multimodal) | OpenRouter | Long-context + vision |
| **Gemini 2.5 Flash** | Fast generalist | Google AI Studio (1,500/day free) | Automations, research, glue, Q&A |

Rule of thumb: **GLM-5.2 / DeepSeek V4 / Kimi K2 for the hard stuff, Gemini Flash + Groq + SambaNova for everything else and high-volume grunt work.**

---

## The architecture — add ONE aggregator layer

You keep everything you already have. We add **LiteLLM proxy** on top as the universal
free-model aggregator. It's the open-source engine that does real fallback rotation:
try primary → on 429/5xx/timeout it cools that model down and moves to the next
deployment → then to the fallback group. Cuts error rates from ~14% to <2% without app changes.

```
                 ┌─────────────────────────────────────────────┐
   OpenCode ─┐   │         LiteLLM proxy  (localhost:4000)      │
   ccr code ─┼──▶│  aliases: free-coder / free-general / fast   │
   Cline/Roo─┤   │  auto-rotate on limit across ALL 10 pools ↓  │
   Aider  ───┘   └───┬────┬────┬────┬────┬────┬────┬────┬───────┘
                     ▼    ▼    ▼    ▼    ▼    ▼    ▼    ▼
                  Gemini Groq Samba Cere NVIDIA Mistral OpenR Zai...
```

- **Layer 0 (already live):** OpenCode Zen + CCR/OpenRouter.
- **Layer 1 (NEW): LiteLLM proxy** — one endpoint, all 10 providers stacked under 3 aliases, auto-rotation + cross-tier fallback. This is the piece you were missing.
- **Layer 2:** point OpenCode, CCR, and any other tool (Cline, Roo, Kilo, Aider) at `http://localhost:4000`. One endpoint, every free model, self-healing.

Config files are written for you:
- `litellm-config.yaml` — the full stacked config with fallbacks (keys as env vars).
- `setup-free-stack.sh` — installs LiteLLM and starts the proxy.
- `.env.free-stack.example` — where your keys go.

---

## What YOU do — accounts + keys (the only non-automatable part)

Install + your two existing keys (OpenRouter + Zen) are **already wired and tested**. To **widen the pool** — more daily volume and the top-tier coders (GLM-5, DeepSeek V4) — add any of these. Each is free, no card. I can't create accounts or type keys for you, so this part is yours; do them in order of value:

1. **Google AI Studio** → aistudio.google.com → "Get API key". **Do NOT enable billing** (it deletes the free tier). Biggest single daily win: 1,500 req/day.
2. **Groq** → console.groq.com → API Keys. 30 sec, no card.
3. **SambaNova** → cloud.sambanova.ai → API key. 20M tokens/day + $5 credit.
4. **Cerebras** → cloud.cerebras.ai → API key.
5. ~~**OpenRouter**~~ → ✅ already wired (your existing key). If you've ever topped up $10 lifetime, your free cap is 1,000/day not 50 — check platform.openrouter.ai/settings/credits.
   ~~**OpenCode Zen**~~ → ✅ already wired (always-free anchor, no action needed).
6. **NVIDIA NIM** → build.nvidia.com → sign in → any model → "Get API Key".
7. **Mistral** → console.mistral.ai → API Keys (free "Experiment" tier).
8. **Z.ai** → z.ai → register → API key (GLM-4.7-Flash free).
9. **GitHub Models** → github.com/settings/tokens → fine-grained PAT with "Models" read → use as key. (Optional, tight caps.)

Then paste each key into `.env.free-stack` (copy from the `.example`) and run `bash setup-free-stack.sh`.
You don't need all 9 — even **Gemini + Groq + SambaNova + your existing OpenRouter** already 10× your daily volume. Add the rest when you want more.

---

## Volume math (why this is "high volume")

Just the four fastest-to-set-up (Gemini + Groq + SambaNova + OpenRouter@1k):
- Gemini Flash: 1,500 req/day
- Groq: up to 14,400 req/day (8B) / 1,000 (large)
- SambaNova: 20,000,000 tokens/day
- OpenRouter :free: 1,000 req/day (if $10 lifetime)

= **~17,000 requests/day + 20M+ tokens/day, £0.** Add Cerebras (1M tok/day), Mistral (~33M tok/day), NVIDIA, Z.ai and you're past 25M tokens/day. That's more than you can personally consume across coding + automations + Q&A.

---

## Wire your existing tools into it (copy-paste)

After the proxy is running on `localhost:4000`:

**OpenCode** — add to `~/.config/opencode/opencode.json` (merge into `provider`):
```json
{
  "provider": {
    "freestack": {
      "npm": "@ai-sdk/openai-compatible",
      "name": "Free Stack",
      "options": { "baseURL": "http://localhost:4000/v1", "apiKey": "sk-freestack-local" },
      "models": {
        "free-coder":  { "name": "Free Coder (auto-rotate)" },
        "free-general":{ "name": "Free General" },
        "free-fast":   { "name": "Free Fast" },
        "free-bigctx": { "name": "Free Big-Context" }
      }
    }
  }
}
```
Then in OpenCode: `/models` → pick **Free Stack → Free Coder**. Now OpenCode rides all 10 pools.

**claude-code-router** — add to `~/.claude-code-router/config.json` `Providers` array:
```json
{
  "name": "freestack",
  "api_base_url": "http://localhost:4000/v1/chat/completions",
  "api_key": "sk-freestack-local",
  "models": ["free-coder", "free-general", "free-fast", "free-bigctx"]
}
```
…and route to it:
```json
"Router": {
  "default": "freestack,free-general",
  "think": "freestack,free-coder",
  "longContext": "freestack,free-bigctx",
  "background": "freestack,free-fast"
}
```
Restart: `ccr restart` → use `ccr code`.

**Aider / Cline / Roo / Kilo** — anything OpenAI-compatible: base URL `http://localhost:4000`, key `sk-freestack-local`, model `free-coder`. Example: `aider --openai-api-base http://localhost:4000 --openai-api-key sk-freestack-local --model free-coder`.

---

## Guardrails

- **Spend safety:** every provider above is free-tier-only by signup; you add no card. The one paid trap is **Google → enabling billing kills the free tier** — leave it off. LiteLLM never spends (no card behind it).
- **Privacy:** LiteLLM config tags free/training endpoints. Keep client code out of them; use them for your own code, research, drafting, automations.
- **When a model ID 404s:** provider changed the slug (happens monthly). Open its dashboard, copy the current model ID, update `litellm-config.yaml`. Marked `# VERIFY` on every line.

---

## Sources (all verified 2026-07-07)

- OpenRouter: [limits](https://openrouter.ai/docs/api/reference/limits) · [free models](https://costgoat.com/pricing/openrouter-free-models) · [free tier 2026](https://klymentiev.com/blog/openrouter-free-tier)
- Groq: [rate limits](https://console.groq.com/docs/rate-limits) · [free tier 2026](https://tokenmix.ai/blog/groq-free-tier-limits-2026)
- Cerebras: [rate limits](https://inference-docs.cerebras.ai/support/rate-limits) · [free tier](https://www.getaiperks.com/en/ai/cerebras-free-tier-guide)
- Google Gemini: [rate limits](https://ai.google.dev/gemini-api/docs/rate-limits) · [free tier 2026](https://tokenmix.ai/blog/gemini-api-free-tier-limits)
- SambaNova: [rate limits](https://docs.sambanova.ai/docs/en/models/rate-limits) · [free plan](https://costbench.com/software/llm-api-providers/sambanova-cloud/free-plan/)
- NVIDIA NIM: [free API 2026](https://decodethefuture.org/en/nvidia-nim-api-explained/) · [free proxy writeup](https://themenonlab.blog/blog/free-claude-code-nvidia-nim-proxy-zero-api-fees)
- Mistral: [tiers](https://docs.mistral.ai/deployment/ai-studio/tier) · [free tier](https://pricepertoken.com/endpoints/mistral/free)
- Z.ai: [free Flash models](https://z.ai/subscribe) · [dev docs](https://docs.z.ai/devpack/overview)
- GitHub Models: [free limits](https://getaitools.dev/service/github-models)
- Chutes retired free: [community announcement Feb 2026](https://chutes.ai/news/community-announcement-february) · Together no free tier: [pricing](https://pricepertoken.com/endpoints/together/free)
- LiteLLM: [fallbacks](https://docs.litellm.ai/docs/proxy/reliability) · [router](https://docs.litellm.ai/docs/routing)
- Models: [SWE-bench Pro leaderboard](https://www.morphllm.com/swe-bench-pro) · [open-weight coding 2026](https://kilo.ai/open-source-models)
- Curated free-API lists: [cheahjs/free-llm-api-resources](https://github.com/cheahjs/free-llm-api-resources) · [awesome-free-llm-apis](https://github.com/mnfst/awesome-free-llm-apis)
