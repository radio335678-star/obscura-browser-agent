# Obscura Stealth Browser Master Orchestrator

## Overview
This directory is the dedicated Obscura Stealth Browser workspace within `C:\quaasxecosystem-orchestrator\`. It contains the ultra-lean Rust + V8 headless browser binaries, playbooks, control scripts, and multi-IDE MCP synchronization utilities.

* **Engine:** Rust + Embedded V8 (~30 MB RAM per instance)
* **Version:** 0.2.4
* **Stealth Features:** TLS fingerprint impersonation, randomized WebGL/canvas jitter, 3,520 tracker/ad domains blocked
* **Dual Execution Modes:** Native Stdio MCP Server (37 tools) & Chrome DevTools Protocol (CDP) server (`ws://127.0.0.1:9222`)

---

## File Structure

```
C:\quaasxecosystem-orchestrator\obscura-browser\
├── AGENTS.md                  # Comprehensive AI agent operating protocol & tool catalog
├── .env                       # Verified configuration & ports
├── .env.example               # Reference template
├── connect-obscura-mcp.ps1    # 5-IDE MCP sync (Antigravity, Cursor, Claude, VS Code, Windsurf)
├── verify_obscura.py          # End-to-end verification and diagnostic tool
├── bin\                       # Compiled native Windows x86_64 binaries:
│   ├── obscura.exe            # Core browser engine (84.7 MB)
│   └── obscura-worker.exe     # Parallel scraping worker (78.8 MB)
├── scripts\                   # Lifecycle scripts:
│   ├── start-cdp-server.ps1   # Starts background CDP server on port 9222
│   └── stop-cdp-server.ps1    # Cleanly terminates Obscura instances
└── skills\                    # 3 Specialized Playbooks:
    ├── obscura-browser\       # Full 37 MCP tool catalog & automation workflow
    ├── stealth-scraping\      # Fast CLI scraping, structured extraction, infinite scrolls
    └── cdp-automation\        # Connecting Playwright/Puppeteer via Chrome DevTools Protocol
```

---

## Quickstart & Verification

Run the verification suite:
```powershell
py verify_obscura.py
```

Sync Obscura MCP server across all 5 IDEs:
```powershell
.\connect-obscura-mcp.ps1
```
