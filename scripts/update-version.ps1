#!/usr/bin/env pwsh
<##
Updates visible version markers in index.html to the latest git short commit hash.
Intended to be called from a post-commit hook.

Behavior:
- Reads the current git short HEAD hash
- Replaces occurrences like "TaskFlow v3.0 (abcdef)" and "version: '3.0-abcdef'"
- If changes were made, stages and commits the updated file with a message

#>

param()

Set-StrictMode -Version Latest

# Move to repository root
$repoRoot = (git rev-parse --show-toplevel) 2>$null
if (-not $repoRoot) {
    Write-Error "Not inside a git repository."
    exit 1
}
Set-Location $repoRoot

# Get short commit hash
$hash = (git rev-parse --short HEAD).Trim()
if (-not $hash) {
    Write-Error "Failed to get git short HEAD hash."
    exit 1
}

# Avoid infinite loop: if the most recent commit message is already a version bump,
# do not create another commit. This protects post-commit from committing repeatedly.
$lastMsg = (git log -1 --pretty=%B) 2>$null
if ($lastMsg -and $lastMsg -match 'chore\(version\): bump visible version') {
    Write-Host "Last commit is a version bump; skipping update to avoid loop."
    exit 0
}

$indexPath = Join-Path $repoRoot 'index.html'
if (-not (Test-Path $indexPath)) {
    Write-Error "index.html not found at expected path: $indexPath"
    exit 1
}

$content = Get-Content $indexPath -Raw -ErrorAction Stop
$original = $content

# Replace patterns
# 1) TaskFlow v3.0 (hash)
$content = [System.Text.RegularExpressions.Regex]::Replace($content, 'TaskFlow v3\.0 \([0-9a-f]{6,}\)', "TaskFlow v3.0 ($hash)")
# 2) version: '3.0-hash'
$content = [System.Text.RegularExpressions.Regex]::Replace($content, "version:\s*'3\.0-[0-9a-f]+'", "version: '3.0-$hash'")

if ($content -ne $original) {
    # Write the updated file
    $content | Set-Content -Path $indexPath -Encoding UTF8

    # Stage and commit the change
    git add -- "index.html"
    $msg = "chore(version): bump visible version to $hash"

    # Create a new commit so the change is recorded (post-commit hook context)
    git commit -m $msg
    Write-Host "Updated index.html with version $hash and committed the change."
} else {
    Write-Host "No version markers found or already up-to-date (hash $hash)."
}
