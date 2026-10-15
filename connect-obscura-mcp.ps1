# ==============================================================================
# SYNC OBSCURA STEALTH BROWSER MCP SERVER ACROSS ALL 5 IDES
# (Antigravity, Cursor, Claude Desktop, VS Code, Windsurf)
# ==============================================================================

$bin = "C:\quaasxecosystem-orchestrator\obscura-browser\bin\obscura.exe"
if (-not (Test-Path $bin)) {
    $bin = "C:\Users\bvnik\tools\obscura\bin\obscura.exe"
}

Write-Host "==========================================================" -ForegroundColor Cyan
Write-Host "SYNCING OBSCURA BROWSER MCP SERVER ($bin)" -ForegroundColor Cyan
Write-Host "==========================================================" -ForegroundColor Cyan

# 1. Antigravity MCP Config
$agPath = "C:\Users\bvnik\.gemini\config\mcp_config.json"
if (Test-Path $agPath) {
    try {
        $agJson = Get-Content $agPath -Raw | ConvertFrom-Json
        $agJson.mcpServers | Add-Member -Name "obscura" -Value ([PSCustomObject]@{
            command = $bin
            args = @("mcp", "--stealth", "--allow-private-network")
        }) -MemberType NoteProperty -Force
        $agJson | ConvertTo-Json -Depth 10 | Set-Content $agPath -Encoding UTF8
        Write-Host "[OK] Antigravity updated ($agPath)" -ForegroundColor Green
    } catch {
        Write-Host "[ERR] Error updating Antigravity: $($_.Exception.Message)" -ForegroundColor Red
    }
}

# 2. Cursor MCP Config
$cursorPath = "C:\Users\bvnik\.cursor\mcp.json"
if (Test-Path $cursorPath) {
    try {
        $cursorJson = Get-Content $cursorPath -Raw | ConvertFrom-Json
        $cursorJson.mcpServers | Add-Member -Name "obscura" -Value ([PSCustomObject]@{
            command = $bin
            args = @("mcp", "--stealth", "--allow-private-network")
            transport = "stdio"
        }) -MemberType NoteProperty -Force
        $cursorJson | ConvertTo-Json -Depth 10 | Set-Content $cursorPath -Encoding UTF8
        Write-Host "[OK] Cursor updated ($cursorPath)" -ForegroundColor Green
    } catch {
        Write-Host "[ERR] Error updating Cursor: $($_.Exception.Message)" -ForegroundColor Red
    }
}

# 3. Windsurf MCP Config
$windsurfPath = "C:\Users\bvnik\.codeium\windsurf\mcp_config.json"
if (Test-Path $windsurfPath) {
    try {
        $windsurfJson = Get-Content $windsurfPath -Raw | ConvertFrom-Json
        $windsurfJson.mcpServers | Add-Member -Name "obscura" -Value ([PSCustomObject]@{
            command = $bin
            args = @("mcp", "--stealth", "--allow-private-network")
        }) -MemberType NoteProperty -Force
        $windsurfJson | ConvertTo-Json -Depth 10 | Set-Content $windsurfPath -Encoding UTF8
        Write-Host "[OK] Windsurf updated ($windsurfPath)" -ForegroundColor Green
    } catch {
        Write-Host "[ERR] Error updating Windsurf: $($_.Exception.Message)" -ForegroundColor Red
    }
}

# 4. VS Code User MCP Config
$vscodePath = "C:\Users\bvnik\AppData\Roaming\Code\User\mcp.json"
if (Test-Path $vscodePath) {
    try {
        $vscodeJson = Get-Content $vscodePath -Raw | ConvertFrom-Json
        $obscuraDef = [PSCustomObject]@{
            type = "stdio"
            command = $bin
            args = @("mcp", "--stealth", "--allow-private-network")
        }
        if ($vscodeJson.servers) {
            $vscodeJson.servers | Add-Member -Name "obscura" -Value $obscuraDef -MemberType NoteProperty -Force
        }
        if ($vscodeJson.mcpServers) {
            $vscodeJson.mcpServers | Add-Member -Name "obscura" -Value $obscuraDef -MemberType NoteProperty -Force
        }
        $vscodeJson | ConvertTo-Json -Depth 10 | Set-Content $vscodePath -Encoding UTF8
        Write-Host "[OK] VS Code updated ($vscodePath)" -ForegroundColor Green
    } catch {
        Write-Host "[ERR] Error updating VS Code: $($_.Exception.Message)" -ForegroundColor Red
    }
}

# 5. Claude Desktop Config
$claudePath = "C:\Users\bvnik\AppData\Roaming\Claude\claude_desktop_config.json"
if (Test-Path $claudePath) {
    try {
        $claudeJson = Get-Content $claudePath -Raw | ConvertFrom-Json
        $claudeJson.mcpServers | Add-Member -Name "obscura" -Value ([PSCustomObject]@{
            command = $bin
            args = @("mcp", "--stealth", "--allow-private-network")
        }) -MemberType NoteProperty -Force
        $claudeJson | ConvertTo-Json -Depth 10 | Set-Content $claudePath -Encoding UTF8
        Write-Host "[OK] Claude Desktop updated ($claudePath)" -ForegroundColor Green
    } catch {
        Write-Host "[ERR] Error updating Claude Desktop: $($_.Exception.Message)" -ForegroundColor Red
    }
}

Write-Host "All 5 IDE configs synced for Obscura Stealth Browser MCP" -ForegroundColor Cyan
