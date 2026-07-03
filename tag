QA TEST PLAN — GTM TRACKING

SETUP (do once)
1. Open the site in Chrome.
2. Press F12 to open DevTools, click the Console tab.
3. Paste this and press Enter (makes events print live):
   const _p = window.dataLayer.push;
   window.dataLayer.push = function(...a){ console.log('[dataLayer]', a); return _p.apply(window.dataLayer, a); };

TEST 1 — CONTAINER LOADS
1. Type window.dataLayer in console, press Enter.
Pass: entries gtm.js, gtm.dom, gtm.load appear near the top.
Fail: none of these appear.

TEST 2 — PAGE VIEW ON LOAD
1. Reload the page.
2. Look in the console output.
Pass: an event "page_view" appears with page_path matching the current URL (e.g. /en).
Fail: no page_view event.

TEST 3 — PAGE VIEW ON NAVIGATION
1. Click a menu item / navigate to another page.
2. Watch the console.
Pass: a new page_view fires with the new page's path (e.g. /en/about-overview).
3. Repeat for 2–3 different pages.

TEST 4 — CTA CLICK (BUTTON)
1. Click a tracked button (e.g. Individuals Login).
2. Watch the console.
Pass: event "cta_click" appears with correct ctaName (e.g. individuals_login) and ctaLocation (e.g. header).
Fail: no cta_click event, or wrong/empty name.

TEST 5 — CTA CLICK (LINK)
1. Click a tracked link (e.g. a PDF download or contact link).
Pass: cta_click fires with the right ctaName.

TEST 6 — UNTRACKED BUTTONS DON'T FIRE
1. Click a button that was NOT meant to be tracked.
Pass: no cta_click event appears.

TEST 7 — BOTH LANGUAGES
1. Switch the site to Arabic (RTL).
2. Repeat Tests 2, 3, and 4.
Pass: events fire the same way, and ctaName values stay the SAME in Arabic as in English.

KNOWN BEHAVIOR — NOT A BUG
- You may see gtm.historyChange-v2 events alongside page_view. Expected right now (pending config decision). Note it, but not a failure.
- If events show in console but data doesn't reach GA4 reports, it may be waiting on cookie consent. Not a code failure.

WHAT TO REPORT FOR ANY FAILURE
- Which test number
- The page URL and language
- What you clicked
- What appeared (or didn't) in the console — a screenshot is ideal
