# skills

This repository contains **Deliberate Writing**, a Codex skill for drafting and revision based on communicative purpose. It asks the model to settle meaning and discourse strategy before wording, then permits revisions only when they fix a concrete defect.

The skill is language- and genre-agnostic. It does not use phrase blacklists, generic style targets, or language-specific patches.

## Install

Clone the repository:

```powershell
git clone https://github.com/UlloaSP/skills "C:\path\to\skills"
```

Link the skill into the Codex skills directory:

```powershell
New-Item -ItemType Junction `
  -Path "$env:USERPROFILE\.codex\skills\deliberate-writing" `
  -Target "C:\path\to\skills\skills\deliberate-writing"
```

Restart Codex after installation. Invoke it explicitly with `$deliberate-writing`, or let Codex select it automatically.

## Evaluate

The experiment compares a control response with a response produced under the skill instructions:

```powershell
.\scripts\run-experiments.ps1
```

The script writes raw responses and a blind rubric-based assessment under `experiments/results/`. Model output varies, so the checked-in report records the exact run rather than claiming a permanent score.

The default evaluation sandbox is read-only. If your Codex configuration requires loading a global mandatory skill and blocks that read, review the benchmark inputs first and run with `-Sandbox danger-full-access`.

Validate the package structure with:

```powershell
uv run --with pyyaml python .\scripts\validate_skill.py
```

## Repository topics

`codex-skill`, `writing`, `ai-writing`, `discourse`, `rhetoric`, `natural-language-generation`, `prompt-engineering`, `llm`

## Status

This is an experimental v0.1. Its central claim is narrow and falsifiable: planning for purpose, diagnosing before revision, and stopping when no functional defect remains should outperform generic drafting or open-ended "improvement" prompts across different kinds of prose.
