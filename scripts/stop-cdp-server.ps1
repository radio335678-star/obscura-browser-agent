# Stop running Obscura CDP Server processes
Write-Host "Stopping all Obscura processes..." -ForegroundColor Cyan

$procs = Get-Process -Name "obscura", "obscura-worker" -ErrorAction SilentlyContinue
if ($procs) {
    foreach ($p in $procs) {
        Write-Host "Terminating PID $($p.Id) ($($p.ProcessName))..." -ForegroundColor Yellow
        Stop-Process -Id $p.Id -Force
    }
    Write-Host "[✓] All Obscura processes terminated." -ForegroundColor Green
} else {
    Write-Host "No running Obscura processes found." -ForegroundColor DarkGray
}
