// OSSFE 2027 — Sponsor Prospectus (PDF)
// Single source of truth: ../src/data/sponsors.json (shared with the /sponsors web page).
// Build:  npm run prospectus   (typst compile --root . prospectus/prospectus.typ public/sponsor-prospectus.pdf --font-path prospectus/fonts)

#let data = json("../src/data/sponsors.json")
#let meta = data.meta

// ── Brand palette (mirrors src/styles/global.css @theme) ──
#let blue   = rgb("#333F50")
#let dark   = rgb("#26303D")
#let darker = rgb("#1E2731")
#let accent = rgb("#FFB347")
#let ink    = rgb("#FFFFFF")
#let muted  = rgb("#E2E8F0")
#let faint  = rgb("#94A3B8")
#let hair   = rgb(255, 255, 255, 26)
#let palette = (accent, rgb("#F59E42"), rgb("#D98A2B"), rgb("#B36B1E"))

#set document(title: "Sponsor " + meta.event, author: "OSSFE")
#set page(paper: "a4", margin: (x: 1.7cm, y: 1.8cm), fill: blue)
#set text(font: "Archivo", fill: muted, size: 10pt, hyphenate: false)
#set par(justify: false, leading: 0.65em)

// ── Helpers ──
#let h2(body) = text(fill: ink, size: 17pt, weight: "bold")[#body]
#let eyebrow(body) = text(fill: accent, size: 8pt, weight: "semibold", tracking: 2pt)[#upper(body)]

// 5-star rating, `rating` of them filled with accent (partial star via a measured clip)
#let stars(rating) = context {
  let empty = text(fill: rgb("#55606E"), size: 15pt)[★★★★★]
  let full = text(fill: accent, size: 15pt)[★★★★★]
  let w = measure(empty).width
  box(baseline: 2pt)[
    #empty
    #place(top + left, box(width: w * (rating / 5), clip: true)[#full])
  ]
}

#let statcard(s) = box(
  fill: dark, radius: 8pt, inset: (x: 13pt, y: 12pt), width: 100%, height: 100%,
)[
  #set par(leading: 0.45em)
  #if "rating" in s [
    #stars(s.rating)
    #v(3pt)
    #text(fill: faint, size: 8pt)[#s.label (#s.value)]
  ] else [
    #text(fill: accent, size: 19pt, weight: "bold")[#s.value]
    #v(2pt)
    #text(fill: faint, size: 8pt)[#s.label]
  ]
]

#let tiercard(t) = box(
  fill: dark, radius: 10pt, inset: 14pt, width: 100%, height: 100%,
  stroke: if t.featured { 1.2pt + accent } else { 0.6pt + hair },
)[
  #if t.featured [
    #place(top + center, dy: -21pt)[#box(fill: accent, radius: 20pt, inset: (x: 9pt, y: 3pt))[
      #text(fill: darker, size: 7pt, weight: "bold", tracking: 1pt)[MOST POPULAR]]]
  ]
  #text(fill: ink, size: 15pt, weight: "bold")[#t.name]
  #h(6pt)
  #text(fill: ink, size: 15pt, weight: "bold")[#t.price]
  #if "slots" in t [ #h(4pt) #text(fill: accent, size: 8pt)[#t.slots] ]
  #v(4pt)
  #if t.includes != none [
    #text(fill: accent, size: 8.5pt, weight: "semibold")[✦ Everything in #t.includes, plus:]
  ] else [
    #text(fill: faint, size: 8.5pt)[Includes:]
  ]
  #v(3pt)
  #for p in t.perks [
    #grid(columns: (10pt, 1fr), gutter: 4pt,
      text(fill: accent)[✓], text(fill: muted, size: 8.5pt)[#p])
    #v(2pt)
  ]
]

#let quotecard(q) = box(fill: blue, stroke: (left: 3pt + accent), inset: (x: 14pt, y: 10pt), width: 100%)[
  #text(fill: ink, size: 11pt, style: "italic")[“#q.text”]
  #v(2pt)
  #text(fill: faint, size: 8pt)[#q.source]
]


// ════════════════════════ COVER ════════════════════════
#page(fill: darker, margin: 0pt)[
  #align(center + horizon)[
    #block(width: 78%)[
      #image("../public/images/ossfe light transparent.svg", width: 55%)
      #v(26pt)
      #eyebrow("Sponsor Prospectus")
      #v(10pt)
      #text(fill: ink, size: 40pt, weight: "bold")[Partner with #meta.event]
      #v(14pt)
      #text(fill: muted, size: 12pt)[
        OSSFE is the conference for the open-source software powering fusion
        energy. Sponsoring connects your brand with a highly technical,
        hard-to-reach community, and helps sustain the tools the whole field
        relies on.
      ]
      #v(20pt)
      #text(fill: accent, size: 11pt, weight: "semibold")[
        #meta.location  ·  #meta.dates
      ]
      #v(4pt)
      #text(fill: faint, size: 9pt)[#meta.organiser]
      #v(4pt)
      #text(fill: faint, size: 10pt)[#meta.contact]
    ]
  ]
  #place(bottom + center, dy: -1.4cm,
    text(fill: faint, size: 8pt)[ossfe.org  ·  All amounts in #meta.currency])
]

// ════════════════════════ WHY + NUMBERS ════════════════════════
#eyebrow("Why sponsor")
#v(4pt)
#h2[Reach a niche, high-value community]
#v(6pt)
#grid(columns: (1fr, 1fr, 1fr), gutter: 10pt, rows: 3cm,
  ..(
    ("Reach a niche audience", "Direct access to fusion software engineers, scientists and decision-makers you can’t easily reach elsewhere."),
    ("Find rare talent", "Meet and recruit specialists at the intersection of fusion, scientific computing and open source."),
    ("Make real impact", "Your support funds travel grants, scholarships and the open-source tools the community depends on."),
  ).map(((t, b)) => box(fill: dark, radius: 8pt, inset: 12pt, width: 100%, height: 100%)[
    #text(fill: ink, size: 10.5pt, weight: "bold")[#t]
    #v(3pt)
    #text(fill: faint, size: 8.5pt)[#b]
  ])
)

#v(16pt)
#h2[The 2026 edition, by the numbers]
#v(3pt)
#text(fill: faint, size: 9pt)[From the post-event feedback survey (#data.feedbackResponses respondents) and registration data.]
#v(8pt)
#grid(columns: (1fr, 1fr, 1fr, 1fr), gutter: 8pt, rows: 2.6cm,
  ..data.headline.map(s => statcard(s)))
#v(8pt)
#grid(columns: (1fr, 1fr, 1fr), gutter: 8pt, rows: (2.6cm, 2.6cm),
  ..data.feedback.map(s => statcard(s)))

#v(14pt)
#quotecard(data.quotes.at(0))

#pagebreak()

// ════════════════════════ WHO ATTENDS (stacked bar + top institutions) ════════════════════════
#let atotal = data.audience.map(a => a.count).sum()
#let apct(n) = calc.round(n / atotal * 100)
#h2[Who attends]
#v(2pt)
#text(fill: faint, size: 9pt)[Participants by institution type (2026 in-person edition).]
#v(10pt)

// stacked proportion bar
#box(width: 100%, radius: 6pt, clip: true)[
  #grid(columns: data.audience.map(a => a.count * 1fr), rows: 34pt,
    ..data.audience.enumerate().map(((i, a)) => box(
      fill: palette.at(calc.rem(i, palette.len())), width: 100%, height: 100%, inset: 6pt,
    )[
      #align(center + horizon)[#text(fill: darker, size: 9pt, weight: "bold")[#if apct(a.count) >= 6 [#apct(a.count)%]]]
    ]))
]
#v(6pt)
#grid(columns: (auto, auto, auto, auto), gutter: 14pt,
  ..data.audience.enumerate().map(((i, a)) => [
    #box(fill: palette.at(calc.rem(i, palette.len())), width: 8pt, height: 8pt, radius: 2pt)
    #h(3pt) #text(fill: muted, size: 8.5pt)[#a.label · #apct(a.count)%]
  ]))

#v(16pt)
#text(fill: faint, size: 9pt)[Top institutions in each category, ranked by number of attendees.]
#v(8pt)
#let cats = data.audience.slice(0, 3)
// one grid so rank rows line up across the three categories
#let headercells = cats.enumerate().map(((i, a)) => [
  #text(fill: palette.at(i), size: 11pt, weight: "bold")[#a.label]
  #h(4pt) #text(fill: accent, size: 8.5pt)[#apct(a.count)%]
  #v(1pt)
  #text(fill: faint, size: 7pt)[#a.children.len() institutions]
  #v(3pt)
  #line(length: 100%, stroke: 0.5pt + hair)
])
// truncate long names to a single line with an ellipsis (no wrapping)
#let trunc(s, n) = {
  let g = s.clusters()
  if g.len() > n { g.slice(0, n).join().trim() + "…" } else { s }
}
#let cell(i, rk) = {
  let a = cats.at(i)
  if rk < a.children.len() {
    grid(columns: (8pt, 1fr), gutter: 4pt,
      text(fill: faint, size: 6.5pt)[#(rk + 1)],
      text(fill: muted, size: 7pt)[#trunc(a.children.at(rk).name, 35)])
  } else { [] }
}
#let datacells = range(10).map(rk => (0, 1, 2).map(i => cell(i, rk))).flatten()
#grid(columns: (1fr, 1fr, 1fr), column-gutter: 14pt, row-gutter: 5pt, align: top,
  ..headercells, ..datacells)

#v(18pt)

// ════════════════════════ WHAT THEY CAME FOR (topics) ════════════════════════
#h2[What they came for]
#v(2pt)
#text(fill: faint, size: 9pt)[Top topics submitted for the 2026 programme.]
#v(8pt)
#let maxc = calc.max(..data.topics.map(t => t.count))
#for t in data.topics [
  #grid(columns: (4.6cm, 1fr, 0.9cm), gutter: 8pt, align: horizon,
    text(fill: muted, size: 8.5pt)[#t.label],
    box(fill: rgb(255,255,255,20), radius: 3pt, width: 100%, height: 12pt)[
      #box(fill: accent, width: (t.count / maxc) * 100%, height: 100%, radius: 3pt)
    ],
    text(fill: faint, size: 8pt)[#t.count],
  )
  #v(4pt)
]

#pagebreak()

// ════════════════════════ TRACK RECORD + WHERE ATTENDEES COME FROM ════════════════════════
#h2[A growing track record]
#v(8pt)
#grid(columns: (1fr, 1fr, 1fr), gutter: 8pt, rows: 3.1cm,
  ..data.editions.map(e => box(
    fill: if "highlight" in e { rgb(255,179,71,26) } else { dark },
    radius: 8pt, inset: 13pt, width: 100%, height: 100%,
    stroke: if "highlight" in e { 0.8pt + accent } else { none },
  )[
    #set par(leading: 0.5em)
    #text(fill: ink, size: 15pt, weight: "bold")[#e.year]
    #v(2pt)
    #text(fill: if "highlight" in e { accent } else { faint }, size: 7.5pt, weight: "semibold", tracking: 1.5pt)[#upper(e.format)]
    #v(3pt)
    #text(fill: muted, size: 8.5pt)[#e.stat]
  ]))

#v(16pt)
#h2[Where attendees come from]
#v(2pt)
#text(fill: faint, size: 9pt)[Home countries of attendees across the 2025 and 2026 editions (#data.countries.len() countries).]
#v(10pt)

#let mapW = 17.4cm
#let mapH = 8.7cm
#let year2025 = rgb(255, 179, 71, 150)
#let year2026 = rgb(79, 209, 197, 150)
#let bubble(cx, cy, count, fillc, strokec) = if count > 0 {
  let r = 0.72mm * calc.sqrt(count)
  place(top + left, dx: cx - r, dy: cy - r, circle(radius: r, fill: fillc, stroke: 0.4pt + strokec))
}

#box(width: mapW, height: mapH)[
  #place(top + left, image("world-equirect.svg", width: mapW, height: mapH))
  #for c in data.countries {
    let cx = (c.lng + 180) / 360 * mapW
    let cy = (90 - c.lat) / 180 * mapH
    // draw the larger bubble first so the smaller stays visible on top
    if c.y2025 >= c.y2026 {
      bubble(cx, cy, c.y2025, year2025, rgb("#FFB347"))
      bubble(cx, cy, c.y2026, year2026, rgb("#4FD1C5"))
    } else {
      bubble(cx, cy, c.y2026, year2026, rgb("#4FD1C5"))
      bubble(cx, cy, c.y2025, year2025, rgb("#FFB347"))
    }
  }
]
#v(8pt)
#grid(columns: (auto, auto), gutter: 20pt,
  [#box(fill: rgb("#FFB347"), width: 9pt, height: 9pt, radius: 5pt) #h(3pt) #text(fill: muted, size: 9pt)[2025 (online) · 219 registrants]],
  [#box(fill: rgb("#4FD1C5"), width: 9pt, height: 9pt, radius: 5pt) #h(3pt) #text(fill: muted, size: 9pt)[2026 (in-person) · 116 attendees]],
)
#v(6pt)
#text(fill: faint, size: 8pt)[Bubble area is proportional to the number of attendees from each country.]

#v(14pt)
#quotecard(data.quotes.at(3))

#pagebreak()

// ════════════════════════ TIERS ════════════════════════
#h2[Sponsorship tiers]
#v(2pt)
#text(fill: faint, size: 9pt)[All amounts in #meta.currency. Each tier builds on the one below.]
#v(12pt)
#grid(columns: (1fr, 1fr, 1fr), gutter: 10pt, rows: 8.6cm,
  ..data.tiers.map(t => tiercard(t)))

#v(16pt)
#grid(columns: (1fr, 1fr), gutter: 14pt,
  // À la carte add-ons
  [
    #h2[À la carte add-ons]
    #v(6pt)
    #for a in data.alaCarte [
      #box(fill: dark, radius: 8pt, inset: 10pt, width: 100%)[
        #grid(columns: (1fr, auto), gutter: 6pt,
          text(fill: ink, size: 9.5pt, weight: "bold")[#a.item],
          text(fill: accent, size: 9.5pt, weight: "bold")[#a.price])
        #v(2pt)
        #text(fill: faint, size: 8pt)[#a.summary]
      ]
      #v(6pt)
    ]
  ],
  // Sponsor-funded prizes
  [
    #h2[Sponsor-funded prizes]
    #v(6pt)
    #box(fill: dark, radius: 8pt, inset: (x: 12pt, y: 4pt), width: 100%)[
      #for (i, p) in data.prizes.enumerate() [
        #grid(columns: (1fr, auto), inset: (y: 8pt),
          text(fill: faint, size: 9.5pt)[#strike[#p.item]],
          text(fill: faint, size: 9.5pt)[#strike[#p.price]])
        #if i < data.prizes.len() - 1 { line(length: 100%, stroke: 0.5pt + hair) }
      ]
    ]
    #v(6pt)
    #text(fill: faint, size: 8pt)[#data.prizeNote]
  ])

#pagebreak()
#h2[Sponsor FAQ]
#v(8pt)
#for f in data.faqs [
  #text(fill: ink, size: 9.5pt, weight: "bold")[#f.q]
  #v(2pt)
  #text(fill: faint, size: 8.5pt)[#f.a]
  #v(8pt)
]

#v(6pt)
#box(fill: darker, radius: 10pt, inset: 18pt, width: 100%)[
  #align(center)[
    #text(fill: ink, size: 15pt, weight: "bold")[Ready to partner with OSSFE?]
    #v(4pt)
    #text(fill: muted, size: 9.5pt)[Tiers are limited and assigned first-come, first-served. Let’s talk.]
    #v(8pt)
    #text(fill: accent, size: 11pt, weight: "bold")[#meta.contact]
  ]
]
