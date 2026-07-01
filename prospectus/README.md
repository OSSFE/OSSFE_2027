# Sponsor prospectus (PDF)

`prospectus.typ` renders the downloadable sponsor prospectus
(`/public/sponsor-prospectus.pdf`). It reads the **same data source** as the
`/sponsors` web page — [`../src/data/sponsors.json`](../src/data/sponsors.json) —
so the web page and PDF never drift. Edit the JSON, rebuild both.

## Build

Requires [Typst](https://github.com/typst/typst) on your `PATH`:

```sh
npm run prospectus
# → public/sponsor-prospectus.pdf
```

(equivalent to
`typst compile --root . prospectus/prospectus.typ public/sponsor-prospectus.pdf --font-path prospectus/fonts`)

## Notes

- `fonts/Archivo.ttf` is the brand font (OFL), bundled so the PDF matches the
  site typography without a system install.
- `--root .` lets the file read `../src/data/sponsors.json` and the logo from
  `../public/images/`.
- Stats come from the OSSFE 2025/2026 registration + feedback exports (kept out
  of git; see `.gitignore`). Provenance is summarised in `prospectus-plan.md §4`.
