[CmdletBinding()]
param(
    [string]$OutputRoot = (Join-Path $PSScriptRoot "..\experiments\results"),
    [string]$Model = "",
    [ValidateSet("read-only", "danger-full-access")]
    [string]$Sandbox = "read-only"
)

$ErrorActionPreference = "Stop"
$repoRoot = (Resolve-Path (Join-Path $PSScriptRoot "..")).Path
$casesPath = Join-Path $repoRoot "experiments\cases.json"
$rubricPath = Join-Path $repoRoot "experiments\rubric.md"
$skillPath = Join-Path $repoRoot "SKILL.md"
$runId = Get-Date -Format "yyyyMMdd-HHmmss"
$runPath = Join-Path $OutputRoot $runId
New-Item -ItemType Directory -Path $runPath -Force | Out-Null

$cases = Get-Content -Raw $casesPath
$skill = Get-Content -Raw $skillPath
$rubric = Get-Content -Raw $rubricPath
$modelArgs = if ($Model) { @("--model", $Model) } else { @() }
$globalSkillsPath = Join-Path $env:USERPROFILE ".codex\skills"
$codexWorkdir = if (Test-Path $globalSkillsPath) { $globalSkillsPath } else { $repoRoot }

function Invoke-CodexRun {
    param(
        [string]$Prompt,
        [string]$OutputFile
    )

    $Prompt | & codex exec --ephemeral --ignore-user-config --skip-git-repo-check `
        --sandbox $Sandbox `
        --cd $codexWorkdir --output-last-message $OutputFile @modelArgs -
    if ($LASTEXITCODE -ne 0) {
        throw "Codex failed while producing $OutputFile"
    }
}

$sharedPrompt = @"
Complete every writing task below. Return only the finished responses, each under a heading containing its case id. Do not discuss your process.

CASES
$cases
"@

Invoke-CodexRun -Prompt $sharedPrompt -OutputFile (Join-Path $runPath "control.md")

$treatmentPrompt = @"
Apply the following skill instructions to every task. Return only the finished responses, each under a heading containing its case id. Do not discuss your process.

SKILL
$skill

CASES
$cases
"@

Invoke-CodexRun -Prompt $treatmentPrompt -OutputFile (Join-Path $runPath "treatment.md")

$control = Get-Content -Raw (Join-Path $runPath "control.md")
$treatment = Get-Content -Raw (Join-Path $runPath "treatment.md")
$swap = (Get-Random -Minimum 0 -Maximum 2) -eq 1
$systemA = if ($swap) { $treatment } else { $control }
$systemB = if ($swap) { $control } else { $treatment }
$mapping = if ($swap) { "A=treatment`nB=control" } else { "A=control`nB=treatment" }
Set-Content -Path (Join-Path $runPath "mapping.txt") -Value $mapping -Encoding utf8

$judgePrompt = @"
Act as a strict blind writing evaluator. Apply the rubric to the two anonymous systems for every case. Give a compact score table, concrete evidence, a per-case winner or tie, totals by dimension and system, and an overall conclusion. Do not infer which system used special instructions.

RUBRIC
$rubric

CASES
$cases

SYSTEM A
$systemA

SYSTEM B
$systemB
"@

Invoke-CodexRun -Prompt $judgePrompt -OutputFile (Join-Path $runPath "blind-assessment.md")
Write-Host "Experiment complete: $runPath"
