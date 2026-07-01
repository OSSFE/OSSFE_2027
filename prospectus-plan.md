# OSSFE 2027 — Sponsor Prospectus Plan

> Plan for building the OSSFE 2027 sponsor prospectus (web page + downloadable PDF).
> Owner: Board C (sponsorship/comms). Target: outreach-ready by **Oct 2026**.

---

## 1. Goal

A polished, convincing prospectus that:
- Leads with **value + evidence**, not just a price grid.
- Exists as a **web page** (`/sponsors`, already built in Astro) *and* a **downloadable PDF** (Typst) generated from the same data.
- Uses real **OSSFE 2026 data** to prove reach and impact.

---

## 2. Two outputs, one source

| Output | Tool | Location |
|---|---|---|
| Web page | Astro (`src/pages/sponsors.astro`) | `ossfe.org/sponsors` |
| PDF | Typst | `/public/sponsor-prospectus.pdf` (linked from site) |

Keep tier/stat data in **one place** so web and PDF never drift.

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

**TODO — pull hard numbers from registration/pretix:**
- [ ] Total attendees (2026 and 2025 for growth trend)
- [ ] Exact # countries
- [ ] # talks / posters / tutorials
- [ ] Website / newsletter / social / recording-view stats
- [ ] Audience % breakdown (academia / lab / industry / student)

Mark any projection clearly as "2027 projected".

---

## 5. Selling points surfaced by 2026 feedback

Use these as pull-quotes / rationale:
- **"The most valuable event I ever visited in fusion."**
- Strong **recruiting appeal**: attendees explicitly want full-time roles, industry collaborations, consulting.
- **Growing, young, active community** → sponsors get in early.
- Attendees value the **coffee breaks / networking** → à la carte break sponsorships are attractive & justified.

---

## 6. Fixes needed vs. old prospectus

- [ ] Merge the **two conflicting tier tables** into one canonical version.
- [ ] Fix currency typos ("500e" → €500) and set **currency = USD** (Madison/MIT).
- [ ] Define **Silver benefits explicitly** (Lanyard add-on references them).
- [ ] Add the **audience data / stats** (was missing entirely).
- [ ] Note **MIT as host** → invoicing/tax details, overhead considerations.
- [ ] Add scarcity ("Diamond — only 3").

---

## 7. Build tasks

- [ ] Finalise tier pricing + perks with the board.
- [ ] Collect the hard numbers (§4 TODO).
- [ ] Write final copy (hook, why-sponsor, FAQ).
- [ ] Build Typst PDF template mirroring `/sponsors` data + branding.
- [ ] Wire `/public/sponsor-prospectus.pdf` link from the site.
- [ ] Internal review by all 3 board members.
- [ ] Ship + begin outreach (Oct 2026).

---

## 8. Related
- Web page: `src/pages/sponsors.astro` (built)
- Home teaser: `src/components/Sponsors.astro`
- Master Gantt: "Sponsorship" workstream (prospectus & tiers → outreach rounds)