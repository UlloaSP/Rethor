from pathlib import Path
import re

import yaml


ROOT = Path(__file__).resolve().parents[1]
SKILL_ROOT = ROOT / "skills" / "deliberate-writing"
SKILL = SKILL_ROOT / "SKILL.md"
OPENAI_YAML = SKILL_ROOT / "agents" / "openai.yaml"


def fail(message: str) -> None:
    raise SystemExit(f"validation failed: {message}")


text = SKILL.read_text(encoding="utf-8")
match = re.match(r"\A---\n(.*?)\n---\n", text, flags=re.DOTALL)
if not match:
    fail("SKILL.md must start with YAML frontmatter")

frontmatter = yaml.safe_load(match.group(1))
if frontmatter.get("name") != "deliberate-writing":
    fail("skill name must be deliberate-writing")
if not frontmatter.get("description", "").endswith("Must always apply."):
    fail('skill description must end with "Must always apply."')

metadata = yaml.safe_load(OPENAI_YAML.read_text(encoding="utf-8"))
interface = metadata.get("interface", {})
if interface.get("display_name") != "Deliberate Writing":
    fail("display name must match the skill")
if "$deliberate-writing" not in interface.get("default_prompt", ""):
    fail("default prompt must invoke $deliberate-writing")
if metadata.get("policy", {}).get("allow_implicit_invocation") is not True:
    fail("implicit invocation must remain enabled")

print("skill package is valid")
