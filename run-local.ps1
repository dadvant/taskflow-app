# Run TaskFlow locally (PowerShell)
# Starts a simple Python HTTP server on port 8000 and opens the app in the default browser.
# Usage: Right-click -> Run with PowerShell, or run in a pwsh prompt:
#   ./run-local.ps1

param(
    [int]$Port = 8000
)

# Find Python executable
$python = "python"
try {
    $pv = & $python --version 2>&1
} catch {
    Write-Host "Python was not found on PATH. Please install Python 3.x and try again." -ForegroundColor Red
    exit 1
}

Write-Host "Starting local static server on http://localhost:$Port ..."
# Start python http.server in a new background process
$startInfo = @{ FilePath = $python; ArgumentList = "-m", "http.server", "$Port"; WorkingDirectory = (Get-Location) }
$proc = Start-Process @startInfo -PassThru
Start-Sleep -Milliseconds 400

# Open browser
$url = "http://localhost:$Port/index.html"
Write-Host "Opening $url"
Start-Process $url

Write-Host "Server started (PID $($proc.Id)). Press Ctrl+C in this window to stop the server." -ForegroundColor Green

# Wait for the server process (so the PS session keeps running while server runs)
try {
    Wait-Process -Id $proc.Id
} catch {
    # If interrupted, try to kill the child process
    if ($proc -and -not $proc.HasExited) {
        try { $proc.Kill() } catch {}
    }
}
