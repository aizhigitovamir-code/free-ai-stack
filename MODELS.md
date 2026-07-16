# Best free / open-weight models by task (2026)

Rankings move monthly — treat this as directional and re-verify. Scores are SWE-bench Verified unless noted.

## Coding (agentic)

| Model | ~SWE-bench Verified | Where it's free | Notes |
|---|---|---|---|
| DeepSeek-V4 (Flash/Pro) | ~80% | Zen, OpenRouter | MIT; Flash is fast + cheap |
| MiniMax M3 | ~80% | open weights | self-hostable |
| Kimi K2.6 | ~80% | open weights | strong agentic |
| Qwen3-Coder | — | OpenRouter (free slug) | 262K context |
| GLM-4.7 / GLM-5.2 | SWE-Pro ~62% | Cerebras, Z.ai | very fast on Cerebras |
| GPT-OSS-120B | — | Groq, Cerebras, OpenRouter | hundreds of tok/s |

## Long context (whole-repo reads)
Z.ai **GLM-4.7-Flash** (203K) · **Qwen3-Coder** (262K) · **Gemini Flash** (1M).

## Fast / cheap glue & classification
**GPT-OSS-20B** on Groq (very high tok/s) · **Gemini Flash-Lite** · **DeepSeek-V4-Flash**.

## Reality check (truth over shine)
Frontier paid models still lead — Claude Fable 5 (~95%), GPT-5.5 (~89%), Claude Opus 4.8 (~89%). Free/open models trade a few points of accuracy for **£0 and high volume**. And per morphllm's 2026 analysis, the *scaffold* around a model — routing, verification, retries — drives more variance than swapping frontier models. That's the whole idea behind [hive](https://github.com/aizhigitovamir-code/hive): route the right task to the right free model, verify hard, and the swarm punches above its weight.
