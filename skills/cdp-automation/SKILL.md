---
name: cdp-automation
description: Chrome DevTools Protocol (CDP) server mode for Obscura on port 9222. Integrate with Puppeteer, Playwright, or direct WebSocket clients.
metadata:
  version: "1.0.0"
---

# Obscura Chrome DevTools Protocol (CDP) Playbook

Obscura embeds a full Chrome DevTools Protocol (CDP) server, allowing developers to connect standard automation libraries (Playwright, Puppeteer) to Obscura instead of launching heavy Chromium instances.

## 1. Starting the CDP Server

```powershell
# Start on default port 9222 with stealth
obscura.exe serve -p 9222 --stealth --allow-private-network
```
The server exposes:
* HTTP endpoint: `http://127.0.0.1:9222/json/version`
* WebSocket debug URL: `ws://127.0.0.1:9222/devtools/browser/<id>`

---

## 2. Connecting with Playwright (Node.js)

```javascript
const { chromium } = require('playwright');

(async () => {
  // Connect over CDP directly to Obscura
  const browser = await chromium.connectOverCDP('http://127.0.0.1:9222');
  const context = browser.contexts()[0];
  const page = await context.newPage();

  await page.goto('https://example.com');
  console.log('Title:', await page.title());

  await browser.close();
})();
```

---

## 3. Connecting with Puppeteer (Node.js)

```javascript
const puppeteer = require('puppeteer-core');

(async () => {
  const browser = await puppeteer.connect({
    browserURL: 'http://127.0.0.1:9222'
  });
  const page = await browser.newPage();
  await page.goto('https://example.com');
  console.log(await page.content());
  await browser.disconnect();
})();
```
