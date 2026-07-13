// OSSFE 2027 Call for Proposals Prospectus (PDF), one-page dense flyer.
// CFP content:   ../src/data/cfp.json
// Shared stats:  ../src/data/sponsors.json (audience mix for the "who's in the room" bar).
// Build:  npm run cfp-prospectus
//   (typst compile --root . prospectus/cfp-prospectus.typ public/cfp-prospectus.pdf --font-path prospectus/fonts)

#let cfp   = json("../src/data/cfp.json")
#let stats = json("../src/data/sponsors.json")
#let meta  = cfp.meta

// ── Brand palette (mirrors src/styles/global.css @theme) ──
#let blue   = rgb("#333F50")
#let dark   = rgb("#26303D")
#let darker = rgb("#1E2731")
#let accent = rgb("#FFB347")
#let ink    = rgb("#FFFFFF")
#let muted  = rgb("#E2E8F0")
#let faint  = rgb("#94A3B8")
#let hair   = rgb(255, 255, 255, 26)
#let softaccent = rgb(255, 179, 71, 26)

#set document(title: "Call for Proposals: " + meta.event, author: "OSSFE")

// Full-bleed OSSFE 2026 opening-session photo behind the top of the page,
// tinted with a blue gradient that fades to solid blue so the header text stays
// readable and the body sits on a clean background.
#let headerphoto = block(width: 100%, height: 10cm, clip: true)[
  #place(top + left, image("../public/images/gallery/SN_07511.jpg", width: 100%, height: 10cm, fit: "cover"))
  #place(top + left, rect(width: 100%, height: 10cm, fill: gradient.linear(
    (blue.transparentize(38%), 0%),
    (blue.transparentize(12%), 55%),
    (blue, 100%),
    angle: 90deg,
  )))
]

#set page(paper: "a4", margin: (x: 1.4cm, top: 1.3cm, bottom: 1.0cm), fill: blue,
  background: place(top + left, headerphoto))
#set text(font: "Archivo", fill: muted, size: 9pt, hyphenate: false)
#set par(justify: false, leading: 0.5em)

// ── Helpers ──
#let eyebrow(body) = text(fill: accent, size: 8pt, weight: "semibold", tracking: 2pt)[#upper(body)]
#let hd(body) = text(fill: ink, size: 12pt, weight: "bold")[#body]
#let sigtag = box(fill: accent, radius: 3pt, inset: (x: 4pt, y: 1pt), baseline: 1pt)[
  #text(fill: darker, size: 6pt, weight: "bold", tracking: 0.5pt)[SIGNATURE]]

// compact stat: big accent number over a faint label
#let stat(value, label) = box(width: 100%)[
  #text(fill: accent, size: 15pt, weight: "bold")[#value]
  #v(-2pt)
  #text(fill: faint, size: 6.6pt)[#label]
]

// track card (the centerpiece grid)
#let trackcard(i, name) = box(
  fill: dark, radius: 8pt, inset: (x: 11pt, y: 9pt), width: 100%, height: 100%,
  stroke: (left: 2.5pt + accent),
)[
  #text(fill: accent, size: 7.5pt, weight: "bold")[#if i < 9 { "0" }#(i + 1)]
  #v(2pt)
  #text(fill: ink, size: 9pt, weight: "bold")[#name]
]

// ════════════════════════ HEADER ════════════════════════
#grid(columns: (1fr, auto), align: horizon, column-gutter: 12pt,
  [
    #eyebrow("Call for Proposals")
    #v(3pt)
    #text(fill: ink, size: 27pt, weight: "bold")[Speak at #meta.event]
    #v(4pt)
    #text(fill: muted, size: 9.5pt)[
      Three full days of talks and hands-on tutorials for the open-source
      software powering fusion energy. Bring a tool, a result, or a lesson to
      Madison.
    ]
  ],
  box(width: 3.5cm)[#image("../public/images/ossfe light transparent.svg", width: 100%)],
)
#v(4pt)
// key-facts strip
#box(fill: darker, radius: 8pt, inset: (x: 12pt, y: 8pt), width: 100%)[
  #grid(columns: (1fr, 1fr, 1fr, 1fr), column-gutter: 8pt,
    ..(
      ("Where", meta.location),
      ("When", meta.dates),
      ("Submissions open", cfp.cfpDates.opens),
      ("Deadline", cfp.cfpDates.closes),
    ).map(((k, val)) => [
      #text(fill: faint, size: 6.6pt, weight: "semibold", tracking: 1pt)[#upper(k)]
      #v(-3pt)
      #text(fill: ink, size: 9pt, weight: "bold")[#val]
    ]))
]
#v(5pt)
// programme note (days / optional tours / social)
#box(fill: softaccent, radius: 6pt, stroke: (left: 2pt + accent), inset: (x: 10pt, y: 6pt), width: 100%)[
  #text(fill: ink, size: 8pt, weight: "bold")[Programme  ]
  #text(fill: muted, size: 8pt)[#cfp.programmeNote]
]
#v(8pt)

// ════════════════════════ TRACKS (centerpiece) ════════════════════════
#grid(columns: (auto, 1fr), align: horizon, column-gutter: 8pt,
  hd[Submit to one of eight tracks],
  text(fill: faint, size: 8pt)[ Pick the track that fits your work, or propose something new.])
#v(8pt)
// row 1 holds the multi-line names (e.g. "Community, governance & sustainability"),
// so it is taller; row 2 is all single-line names, so it is shorter. Total height
// is unchanged, keeping the page to one sheet.
#grid(columns: (1fr, 1fr, 1fr, 1fr), gutter: 8pt, rows: (2.35cm, 1.45cm),
  ..cfp.tracks.enumerate().map(((i, name)) => trackcard(i, name)))

#v(8pt)

// ════════════════════════ TWO-COLUMN BODY ════════════════════════
#let sig  = cfp.formats.filter(f => "signature" in f).at(0)
#let rest = cfp.formats.filter(f => "signature" not in f)
#grid(columns: (1.05fr, 1fr), column-gutter: 16pt, align: top,

  // ── LEFT: ways to take part + key dates ──
  [
    #v(4pt)
    #text(fill: accent, size: 9.5pt)[★] #h(4pt)
    #text(fill: ink, size: 9.5pt, weight: "bold")[#sig.name] #h(4pt) #sigtag
    #v(1pt)
    #text(fill: faint, size: 8pt)[#sig.desc]
    #v(6pt)
    #text(fill: accent, size: 9.5pt)[▪] #h(4pt)
    #text(fill: ink, size: 9.5pt, weight: "bold")[#{ rest.map(f => f.name).join("  ·  ") }  ·  More]
    #v(1pt)
    #text(fill: faint, size: 8pt)[Short, informal or in-depth: quick ways to share work and spark collaboration, whatever your experience level.]
    #v(5pt)
    #text(fill: muted, size: 8pt)[Not a maintainer? #text(weight: "bold")[Users] of open-source tools are just as welcome as the people who build them.]

    #v(8pt)
    #box(fill: darker, radius: 10pt, inset: (x: 12pt, y: 9pt), width: 100%)[
      #eyebrow("Key dates")
      #v(5pt)
      #for (i, m) in cfp.timeline.enumerate() [
        #grid(columns: (auto, 1fr, auto), column-gutter: 8pt, align: horizon,
          box(width: 8pt, height: 8pt, radius: 4pt,
            fill: if "highlight" in m { accent } else { dark },
            stroke: if "highlight" in m { none } else { 1pt + hair }),
          text(fill: muted, size: 8.5pt)[#m.label],
          text(fill: if "highlight" in m { accent } else { faint }, size: 8pt, weight: "bold")[#m.date],
        )
        #if i < cfp.timeline.len() - 1 { v(3pt) }
      ]
    ]
  ],

  // ── RIGHT: proof stats ──
  [
    #box(fill: darker, radius: 10pt, inset: 12pt, width: 100%)[
      #eyebrow("The OSSFE community")
      #v(2pt)
      #text(fill: faint, size: 7.5pt)[From the OSSFE 2026 in-person edition and its post-event feedback survey.]
      #v(9pt)
      #grid(columns: (1fr, 1fr, 1fr), row-gutter: 11pt, column-gutter: 6pt,
        stat("125", "In-person attendees"),
        stat("71", "Institutions"),
        stat("19", "Countries"),
        stat("100+", "Talks & posters"),
        stat("4.4/5", "Overall value"),
        stat("100%", "Found new tools"),
      )
      #v(11pt)
      #line(length: 100%, stroke: 0.6pt + hair)
      #v(9pt)
      // institution mix, compact stacked bar
      #let atot = stats.audience.map(a => a.count).sum()
      #let pal = (accent, rgb("#F59E42"), rgb("#D98A2B"), rgb("#B36B1E"))
      #text(fill: muted, size: 8pt, weight: "semibold")[Who's in the room]
      #v(5pt)
      // labels sit inside each segment, so the near-identical amber shades don't
      // need to be told apart from a legend
      #box(width: 100%, radius: 5pt, clip: true)[
        #grid(columns: stats.audience.map(a => a.count * 1fr), rows: 26pt,
          ..stats.audience.enumerate().map(((i, a)) => box(fill: pal.at(calc.rem(i, 4)), width: 100%, height: 100%, inset: (x: 3pt))[
            #align(center + horizon)[#{
              let p = calc.round(a.count / atot * 100)
              if p >= 12 { text(fill: darker, size: 7pt, weight: "bold")[#a.label #p%] }
              else if p >= 5 { text(fill: darker, size: 7pt, weight: "bold")[#p%] }
            }]
          ]))
      ]
      #v(9pt)
      #text(fill: ink, size: 8.5pt, weight: "bold")[Student travel grants and childcare support available.]
    ]
  ],
)

#v(8pt)
// ════════════════════════ CTA BAND ════════════════════════
#box(fill: accent, radius: 10pt, inset: (x: 16pt, y: 11pt), width: 100%)[
  #grid(columns: (1fr, auto), align: horizon, column-gutter: 12pt,
    [
      #text(fill: darker, size: 13pt, weight: "bold")[Got something to share? Submit your proposal.]
      #v(2pt)
      #text(fill: darker, size: 9pt)[Tutorials, talks, lightning talks and posters. Deadline #cfp.cfpDates.closes. Questions? #link("mailto:" + meta.contact)[#meta.contact]]
    ],
    link("https://" + meta.cfpUrl, box(fill: darker, radius: 20pt, inset: (x: 14pt, y: 9pt))[
      #text(fill: accent, size: 11pt, weight: "bold")[#meta.cfpUrl]
    ]),
  )
]
