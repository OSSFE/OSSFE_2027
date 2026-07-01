# OSSFE 2027 — Sponsor Prospectus Plan

> Plan for building the OSSFE 2027 sponsor prospectus (web page + downloadable PDF).
> Owner: Board C (sponsorship/comms). Target: outreach-ready by **Oct 2026**.

---

## 1. Goal

A polished, convincing prospectus that:
- Leads with **value + evidence**, not just a price grid.
- Exists as a **web page** (`/sponsors`, already built in Astro) *and* a **downloadable PDF** (Typst) generated from the same data.
- Uses real **OSSFE 2026 and 2025 data** to prove reach and impact.
    - Data can be found in the folder data/2025/ and data/2026

---

## 2. Two outputs, one source

| Output | Tool | Location |
|---|---|---|
| Web page | Astro (`src/pages/sponsors.astro`) | `ossfe.org/sponsors` |
| PDF | Typst | `/public/sponsor-prospectus.pdf` (linked from site) |

Keep tier/stat data in **one place** so web and PDF never drift.

PDF should be built using data/assets from the webpage

---

## 3. Structure (both formats)

1. **Hook** — what OSSFE is + why this audience matters.
2. **Why sponsor** — reach · talent · impact.
3. **Data / proof points** — from 2026 (see §4).
4. **Tiers** — Silver €/$2k · Gold 5k · Diamond 10k (cumulative; Diamond ⊃ Gold ⊃ Silver).
5. **À la carte** — welcome reception, coffee breaks, lanyards, travel-grant pool.
6. **FAQ** — booth, logo placement, attendee list, sponsor talks.
7. **CTA** — sponsors@ossfe.org + deadline + first-come scarcity.

---

## 4. Data to include (from OSSFE 2026 feedback + registration)

Confirmed signals from the 2026 feedback survey (~40 respondents):

- **Overall value:** avg rating ≈ 4.4 / 5.
- **Would attend again:** overwhelmingly "Definitely / Probably".
- **Audience mix:** industry, national labs, faculty/research staff, postdocs, students, software engineers — genuinely cross-sector.
- **Open-source involvement:** many are **maintainers/contributors** of OSS (high-value technical audience).
- **Exposed to new tools:** most said "Yes, many" — proves discovery value.
- **Post-event intent:** large share "More / Much more likely" to adopt OSS, contribute, and collaborate.
- **International reach:** attendees from across Europe, UK, US, national labs (PPPL, UKAEA, CEA…), startups.
- **Job-matching interest:** many "Yes, I would participate" in a sponsor↔attendee jobs programme → **direct hook for recruiting sponsors**.

All the raw data from the previous version of the conference can be found in the data folder. Feel free to suggest anything else based on your own analysis of the data.

Use this page as inspiration for representation of the data: https://ossfe.org/OSSFE_2025/plot

We like the Tree map for participants per institution type.

We can use chart.js for the plots 

We can refine the plan based on your own evaluation of the data too.

**Hard numbers pulled from the data folder** (now live on `/sponsors` + PDF, single source `src/data/sponsors.json`):
- [x] Attendance: 2025 online **219 registrants**; 2026 in-person **~115 unique attendees** (deduped from 145 Eventbrite ticket rows, which double-counted the Proxima tour add-on), **77 organisations**.
- [x] Countries — **33** distinct attendee home countries across editions (2025 registration + 2026 Eventbrite, normalised & deduped). Shown as an interactive **bubble map** (`chartjs-chart-geo`) with a 2025/2026 legend toggle.
- [x] Talks/posters/tutorials — **105** abstracts submitted in 2026 (100 in 2025) → "100+".
- [x] Audience % (institution type, 2026 in-person, deduped): Industry **42%**, National lab **35%**, Academia **21%**, Other **2%**. *(Rendered as the tree map on the web page, stacked bar in the PDF.)*
- [x] Feedback (n=42): overall value **4.4/5**; **100%** discovered new tools; **93%** would attend again; **62%** OSS maintainers/contributors; **81%** want a jobs programme; **76%** more likely to contribute to OSS.
- [ ] Website / newsletter / social / recording-view stats — *not in the current exports; omitted rather than invented.*

Projections (2027) are clearly labelled "projected". Note: 2025 (online) vs 2026 (in-person) aren't directly comparable, so we show them as distinct editions rather than a single misleading growth curve.

---

## 5. Selling points surfaced by 2026 feedback

Use these as pull-quotes / rationale:
- **"The most valuable event I ever visited in fusion."**
- Strong **recruiting appeal**: attendees explicitly want full-time roles, industry collaborations, consulting.
- **Growing, young, active community** → sponsors get in early.
- Attendees value the **coffee breaks / networking** → à la carte break sponsorships are attractive & justified.

---

## 6. Fixes needed vs. old prospectus

- [x] Merge the **two conflicting tier tables** into one canonical version (in `sponsors.json`).
- [x] Fix currency typos and set **currency = USD** (Madison/MIT).
- [x] Define **Silver benefits explicitly** (Lanyard add-on references them).
- [x] Add the **audience data / stats** (tree map + feedback stats + topics bar).
- [x] Note **MIT as host** → invoicing/tax FAQ added.
- [x] Add scarcity ("Diamond — only 3").

---

## 7. Build tasks

- [ ] Finalise tier pricing + perks with the board *(prices are still the draft values in `sponsors.json`)*.
- [x] Collect the hard numbers (§4).
- [x] Write final copy (hook, why-sponsor, FAQ).
- [x] Build Typst PDF template mirroring `/sponsors` data + branding (`prospectus/prospectus.typ`, `npm run prospectus`).
- [x] Wire `/public/sponsor-prospectus.pdf` link from the site (hero + final CTA).
- [ ] Internal review by all 3 board members.
- [ ] Ship + begin outreach (Oct 2026).

### Implementation notes
- **Single source of truth:** `src/data/sponsors.json` feeds the web page, the home teaser, and the Typst PDF.
- **Web page:** `src/pages/sponsors.astro` — chart.js treemap (institution type) + horizontal bar (topics), loaded from CDN.
- **PDF:** `prospectus/prospectus.typ` — dark brand theme, Archivo font bundled in `prospectus/fonts/`. Rebuild with `npm run prospectus` (needs Typst installed).
- **Data privacy:** raw exports in `data/` contain names/emails/addresses → git-ignored; only aggregate stats live in the repo.

---

## 8. Related
- Web page: `src/pages/sponsors.astro` (built)
- Home teaser: `src/components/Sponsors.astro`
- Master Gantt: "Sponsorship" workstream (prospectus & tiers → outreach rounds)