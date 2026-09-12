from pathlib import Path
import re

import yaml


ROOT = Path(__file__).resolve().parents[1]
SKILL = ROOT / "SKILL.md"
OPENAI_YAML = ROOT / "agents" / "openai.yaml"


def fail(message: str) -> None:
    raise SystemExit(f"validation failed: {message}")


text = SKILL.read_text(encoding="utf-8")
match = re.match(r"\A---\n(.*?)\n---\n", text, flags=re.DOTALL)
if not match:
    fail("SKILL.md must start with YAML frontmatter")

frontmatter = yaml.safe_load(match.group(1))
if frontmatter.get("name") != "deliberate-writing":
    fail("skill name must be deliberate-writing")
if not isinstance(frontmatter.get("description"), str) or not frontmatter["description"].strip():
    fail("skill description is required")

metadata = yaml.safe_load(OPENAI_YAML.read_text(encoding="utf-8"))
interface = metadata.get("interface", {})
if interface.get("display_name") != "Deliberate Writing":
    fail("display name must match the skill")
if "$deliberate-writing" not in interface.get("default_prompt", ""):
    fail("default prompt must invoke $deliberate-writing")
if metadata.get("policy", {}).get("allow_implicit_invocation") is not True:
    fail("implicit invocation must remain enabled")

print("skill package is valid")
