# Prospectuses (PDF)

Two downloadable PDFs, both rendered with [Typst](https://github.com/typst/typst)
from the site's own data so they never drift from the web pages:

| File | Source | Output |
|---|---|---|
| `prospectus.typ` | [`../src/data/sponsors.json`](../src/data/sponsors.json) | `/public/sponsor-prospectus.pdf` |
| `cfp-prospectus.typ` | [`../src/data/cfp.json`](../src/data/cfp.json) + `sponsors.json` | `/public/cfp-prospectus.pdf` |

The **sponsor** prospectus shares its data with the `/sponsors` web page. The
**call-for-proposals** prospectus is a dense one-page flyer whose copy (event
meta, tracks, session formats, programme note, key dates) lives in `cfp.json`;
it reuses only the audience mix from `sponsors.json` for the "who's in the room"
bar. Edit the JSON, rebuild.

## Build

Requires [Typst](https://github.com/typst/typst) on your `PATH`:

```sh
npm run prospectus          # → public/sponsor-prospectus.pdf
npm run cfp-prospectus      # → public/cfp-prospectus.pdf
```

(equivalent to
`typst compile --root . prospectus/<file>.typ public/<name>.pdf --font-path prospectus/fonts`)

Don't have Typst? Grab a static binary from the
[releases page](https://github.com/typst/typst/releases) (e.g.
`typst-x86_64-unknown-linux-musl.tar.xz`) and put it on your `PATH`.

## Notes

- `fonts/Archivo.ttf` is the brand font (OFL), bundled so the PDFs match the
  site typography without a system install.
- `--root .` lets the files read `../src/data/*.json` and the logo from
  `../public/images/`.
- Photos in `img/` are from the OSSFE 2026 (Munich) edition and are shared by
  both prospectuses.
- Stats come from the OSSFE 2025/2026 registration + feedback exports (kept out
  of git; see `.gitignore`). Provenance is summarised in `prospectus-plan.md §4`.
