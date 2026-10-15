---
name: stealth-scraping
description: High-concurrency stealth web scraping patterns, infinite-scroll handling, structured extraction, and anti-bot bypass using Obscura.
metadata:
  version: "1.0.0"
---

# Obscura Stealth Scraping Playbook

Obscura allows high-speed headless web scraping without getting blocked by anti-bot systems (Cloudflare Turnstile, Datadome, PerimeterX) because of native TLS fingerprint impersonation and normalized navigator properties.

## 1. High-Speed CLI Scraping

Use the native CLI for batch and multi-URL extraction:
```bash
# Scrape single URL with stealth mode
obscura.exe scrape https://example.com --stealth

# Scrape with custom user-agent
obscura.exe scrape https://example.com --stealth --user-agent "Mozilla/5.0 (Windows NT 10.0; Win64; x64)..."

# Fetch rendered DOM directly
obscura.exe fetch https://example.com --stealth
```

---

## 2. Structured Extraction via MCP

When operating through an AI agent with the Obscura MCP server:

### A. Token-Dense Markdown
```json
// Call browser_markdown after browser_navigate
{
  "name": "browser_markdown"
}
```
Converts HTML into dense, clean Markdown with preserved links and semantic hierarchy.

### B. Precision Extraction Map
```json
// Call browser_extract
{
  "map": {
    "title": "h1.entry-title",
    "author": "span.author-name",
    "paragraphs[]": "div.article-content p",
    "links[]": "div.references a@href"
  }
}
```

---

## 3. Dynamic Infinite-Scroll Feeds

For dynamic single-page applications (SPAs):
1. Navigate: `browser_navigate({ url: targetUrl })`
2. Scroll to trigger XHR pagination: `browser_scroll({ direction: "bottom" })`
3. Wait for new DOM items: `browser_wait_for({ selector: ".item:nth-child(20)" })`
4. Extract updated content: `browser_markdown()`
