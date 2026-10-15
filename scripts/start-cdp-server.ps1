# Start Obscura CDP Server in background on port 9222
param(
    [int]$Port = 9222
)

$bin = "C:\quaasxecosystem-orchestrator\obscura-browser\bin\obscura.exe"
if (-not (Test-Path $bin)) {
    $bin = "C:\Users\bvnik\tools\obscura\bin\obscura.exe"
}

Write-Host "Starting Obscura CDP Server on port $Port with --stealth..." -ForegroundColor Cyan

# Check if already running on port
$existing = Get-NetTCPConnection -LocalPort $Port -ErrorAction SilentlyContinue
if ($existing) {
    Write-Host "[!] Port $Port is already in use by process ID $($existing.OwningProcess[0])" -ForegroundColor Yellow
    exit 0
}

$proc = Start-Process -FilePath $bin -ArgumentList "serve", "-p", $Port, "--stealth", "--allow-private-network" -PassThru -WindowStyle Hidden
Start-Sleep -Seconds 1

Write-Host "[✓] Obscura CDP Server running with PID $($proc.Id) on ws://127.0.0.1:$Port" -ForegroundColor Green
