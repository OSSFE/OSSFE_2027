# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project

Marketing/landing site for OSSFE 2027 (Open Source Software for Fusion Energy
conference), built with Astro + Tailwind CSS v4. Deployed to GitHub Pages at
`ossfe.github.io/OSSFE_2027/` (see `astro.config.mjs`; `site`/`base` are set
for that subpath, so internal links should be built with
`import.meta.env.BASE_URL` rather than hardcoded absolute paths).

## Writing style

- **Never use em dashes (—) in any copy, code comments, or commit messages.**
  Rewrite the sentence, or use a comma, colon, parentheses, or a period
  instead. This applies to all user-facing text on the site.

## Development

When starting the dev server, use background mode:

```
astro dev --background
```

Manage the background server with `astro dev stop`, `astro dev status`, and `astro dev logs`.

## Commands

```sh
npm install                # install deps
npm run build               # production build to ./dist/
npm run preview             # preview the production build locally
npm run astro -- <cmd>      # run any Astro CLI command, e.g. `npm run astro -- check`
npm run prospectus          # rebuild the sponsor prospectus PDF (requires Typst on PATH)
```

There is no test suite or linter configured. Use `npm run astro -- check` to
type-check `.astro`/`.ts` files against `tsconfig.json` (extends
`astro/tsconfigs/strict`).

## Architecture

- `src/pages/` — file-based routing. `index.astro` is the main landing page,
  composed of section components from `src/components/` (VideoHero,
  KeyFacts, About, Timeline, WhyAttend, Speakers, Gallery, Sponsors,
  TravelTeaser, FinalCTA, Footer). To add/reorder a homepage section, edit the
  component list in `src/pages/index.astro` rather than the components
  themselves.
- `src/layouts/Base.astro` — shared HTML shell (head/meta/OG tags, global CSS
  import, Google Analytics, `CountdownOverlay`). Every page wraps its content
  in `<Base>`.
- `src/components/CountdownOverlay.astro` — full-screen overlay with its own
  client-side timer that hides the site until a `revealDate` passes (used in
  `Base.astro` to hide the 2027 event location until it's announced). Preview
  backdoor: visiting any page with `?preview=fusion` unlocks the site for devs
  or invited sponsors and remembers it in `localStorage` (use `?preview=off` to
  re-lock). This is obfuscation, not real security: the token ships in the
  client JS, so don't rely on it to hide anything truly sensitive.
- `src/data/sponsors.json` — single source of truth for both
  `src/pages/sponsors.astro` (the `/sponsors` web page) and
  `prospectus/prospectus.typ` (the downloadable sponsor prospectus PDF, built
  via Typst — see `prospectus/README.md`). When updating sponsor stats,
  tiers, quotes, or FAQs, edit this JSON once and rebuild both the page and
  the PDF (`npm run prospectus`) so they don't drift.
- `tailwind.config.mjs` — defines the OSSFE brand palette (`ossfe.blue/dark/darker`,
  `accent`, `ink`) and font families (`display`/`body`). Prefer these semantic
  color/font tokens over raw Tailwind colors when styling.
- `.github/workflows/deploy.yml` — builds with `withastro/action` on push to
  `main` and deploys via `actions/deploy-pages`; there is no separate
  build/test gate before deploy.

## Documentation

Full documentation: https://docs.astro.build

Consult these guides before working on related tasks:

- [Adding pages, dynamic routes, or middleware](https://docs.astro.build/en/guides/routing/)
- [Working with Astro components](https://docs.astro.build/en/basics/astro-components/)
- [Using React, Vue, Svelte, or other framework components](https://docs.astro.build/en/guides/framework-components/)
- [Adding or managing content](https://docs.astro.build/en/guides/content-collections/)
- [Adding styles or using Tailwind](https://docs.astro.build/en/guides/styling/)
- [Supporting multiple languages](https://docs.astro.build/en/guides/internationalization/)
