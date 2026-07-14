// OSSFE 2027 Call for Proposals Prospectus (PDF), one-page A4 flyer — improved layout.
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
#let softaccent = rgb(255, 179, 71, 20)

#set document(title: "Call for Proposals: " + meta.event, author: "OSSFE")

// Full-bleed OSSFE 2026 poster-session photo behind the top of the page, tinted
// with a blue gradient that fades to solid blue so the header text stays readable
// and the body sits on a clean background. (No readable event dates in this shot.)
// The photo ends at 8.0cm but the solid-blue gradient rect extends to 8.2cm, so
// the block's bottom edge sits in pure page-fill blue and leaves no visible seam
// (a hard clip here would produce a bright 1px line where the photo bottom shows).
#let headerphoto = block(width: 100%, height: 8.2cm)[
  #place(top + left, image("../public/images/gallery/SN_07427.jpg", width: 100%, height: 8.0cm, fit: "cover"))
  #place(top + left, rect(width: 100%, height: 8.2cm, fill: gradient.linear(
    (blue.transparentize(64%), 0%),
    (blue.transparentize(28%), 45%),
    // reach fully solid blue while the photo is still visible, so the last
    // stretch is pure page-fill blue and the block boundary leaves no seam
    (blue, 70%),
    (blue, 100%),
    angle: 90deg,
  )))
]

#set page(paper: "a4", margin: (x: 1.4cm, top: 1.15cm, bottom: 0.85cm), fill: blue,
  background: place(top + left, headerphoto))
#set text(font: "Archivo", fill: muted, size: 9pt, hyphenate: false)
#set par(justify: false, leading: 0.5em)

// ── Helpers ──
#let eyebrow(body) = text(fill: accent, size: 8pt, weight: "semibold", tracking: 2pt)[#upper(body)]
#let hd(body) = text(fill: ink, size: 12pt, weight: "bold")[#body]
#let sigtag = box(fill: accent, radius: 3pt, inset: (x: 4pt, y: 1pt), baseline: 1pt)[
  #text(fill: darker, size: 6pt, weight: "bold", tracking: 0.5pt)[SIGNATURE]]

// open fact cell (label over value), used in the hairline-divided facts row
#let fact(k, val) = [
  #text(fill: faint, size: 6.6pt, weight: "semibold", tracking: 1pt)[#upper(k)]
  #v(-3pt)
  #text(fill: ink, size: 10pt, weight: "bold")[#val]
]
#let vrule = box(width: 0.6pt, height: 0.85cm, fill: hair)

// compact stat: big accent number over a faint label
#let stat(value, label) = box(width: 100%)[
  #text(fill: accent, size: 15pt, weight: "bold")[#value]
  #v(-2pt)
  #text(fill: faint, size: 6.6pt)[#label]
]

// track card (the centerpiece grid)
#let trackcard(i, name) = box(
  fill: dark, radius: 8pt, inset: (x: 12pt, y: 11pt), width: 100%, height: 100%,
  stroke: (left: 2.5pt + accent),
)[
  #text(fill: accent, size: 7.5pt, weight: "bold")[#if i < 9 { "0" }#(i + 1)]
  #v(4pt)
  #text(fill: ink, size: 8pt, weight: "bold")[#name]
]

// ════════════════════════ HEADER ════════════════════════
// The logo is placed (absolutely) over the photo rather than sitting in the
// flow, so enlarging it does not add header height or push content to a 2nd page.
#place(top + right, dy: -2pt, image("../public/images/ossfe light transparent.svg", width: 4cm))
#eyebrow("Call for Proposals")
#v(0.1cm)  // sit the headline lower over the photo
// explicit `below` spacing so the intro sits tight under the title (otherwise
// Typst's paragraph spacing scales to the 44pt headline and leaves a big gap)
#block(below: 15pt, text(fill: ink, size: 44pt, weight: "bold")[Speak at \ #meta.event])
// spell the acronym out for newcomers; runs the full page width
#text(fill: muted, size: 10pt)[
  #text(fill: ink, weight: "semibold")[Open Source Software for Fusion Energy.]
  Talks and hands-on tutorials for the tools powering fusion. Bring a tool, a result, or a lesson to Madison.
]
#v(7pt)

// ════════════════════════ FACTS + DEADLINE ════════════════════════
// Open row with hairline dividers (no filled box), and the deadline pulled out
// as an amber-outlined chip — it is the single most action-critical fact.
#grid(columns: (1fr, auto), align: horizon, column-gutter: 14pt,
  grid(columns: (1fr, auto, 1fr, auto, 1fr), align: horizon, column-gutter: 12pt,
    fact("Where", meta.location), vrule,
    fact("When", meta.dates), vrule,
    fact("Submissions open", cfp.cfpDates.opens),
  ),
  box(radius: 9pt, inset: (x: 13pt, y: 7pt), fill: softaccent,
    stroke: 1pt + accent)[
    #align(right)[
      #text(fill: accent, size: 6.6pt, weight: "bold", tracking: 1pt)[SUBMIT BY]
      #v(-3pt)
      #text(fill: accent, size: 14pt, weight: "bold")[#cfp.cfpDates.closes]
    ]
  ],
)
#v(6pt)

// programme note (subtle, left accent rule)
#block(inset: (left: 10pt), stroke: (left: 2pt + accent))[
  #text(fill: ink, size: 8pt, weight: "bold")[Programme.  ]
  #text(fill: muted, size: 8pt)[#cfp.programmeNote]
]
#v(6pt)

// ════════════════════════ TRACKS (centerpiece) ════════════════════════
#grid(columns: (auto, 1fr), align: horizon, column-gutter: 8pt,
  hd[Submit to one of eight tracks],
  text(fill: faint, size: 8pt)[ Pick the track that fits your work, or propose something new.])
#v(8pt)
// both rows share one height so every card matches (the tallest is the 3-line
// track 02, "Community, governance & sustainability")
#grid(columns: (1fr, 1fr, 1fr, 1fr), gutter: 10pt, rows: (2.15cm, 2.15cm),
  ..cfp.tracks.enumerate().map(((i, name)) => trackcard(i, name)))

#v(7pt)

// ════════════════════════ TWO-COLUMN BODY ════════════════════════
#let sig  = cfp.formats.filter(f => "signature" in f).at(0)
#let rest = cfp.formats.filter(f => "signature" not in f)
#grid(columns: (1.05fr, 1fr), column-gutter: 16pt, align: top,

  // ── LEFT: ways to take part + key dates ──
  [
    #text(fill: accent, size: 9.5pt)[★] #h(4pt)
    #text(fill: ink, size: 9.5pt, weight: "bold")[#sig.name] #h(4pt) #sigtag
    #v(1pt)
    #text(fill: faint, size: 8pt)[#sig.desc]
    #v(7pt)
    #text(fill: accent, size: 9.5pt)[▪] #h(4pt)
    #text(fill: ink, size: 9.5pt, weight: "bold")[#{ rest.map(f => f.name).join("  ·  ") }  ·  More]
    #v(1pt)
    #text(fill: faint, size: 8pt)[Short, informal or in-depth: quick ways to share work and spark collaboration, whatever your experience level.]
    #v(6pt)
    #text(fill: muted, size: 8pt)[Not a maintainer? #text(weight: "bold")[Users] of open-source tools are just as welcome as the people who build them.]

    // key dates — sits directly under the copy (hairline separator, no big gap)
    #v(11pt)
    #line(length: 100%, stroke: 0.6pt + hair)
    #v(9pt)
    #eyebrow("Key dates")
    #v(6pt)
    #for (i, m) in cfp.timeline.enumerate() [
      #grid(columns: (auto, 1fr, auto), column-gutter: 8pt, align: horizon,
        // bullet, with a dashed connector *placed* below it (placed => adds no
        // layout height) so the dates stay tightly stacked
        box(width: 8pt, height: 8pt)[
          #place(center + horizon, circle(radius: 4pt,
            fill: if "highlight" in m { accent } else { none },
            stroke: if "highlight" in m { none } else { 1pt + hair }))
          #if i < cfp.timeline.len() - 1 {
            place(top + left, dx: 3.5pt, dy: 11pt,
              line(angle: 90deg, length: 7pt, stroke: (paint: faint, thickness: 1pt, dash: "dotted")))
          }
        ],
        text(fill: if "highlight" in m { ink } else { muted },
          size: 8.5pt, weight: if "highlight" in m { "semibold" } else { "regular" })[#m.label],
        text(fill: if "highlight" in m { accent } else { faint }, size: 8pt, weight: "bold")[#m.date],
      )
      #if i < cfp.timeline.len() - 1 { v(5pt) }
    ]
  ],

  // ── RIGHT: proof stats ──
  [
    #box(fill: dark, radius: 12pt, inset: 13pt, width: 100%)[
      #eyebrow("The OSSFE community")
      #v(2pt)
      #text(fill: faint, size: 7.5pt)[From the OSSFE 2026 in-person edition and its post-event feedback survey.]
      #v(10pt)
      #grid(columns: (1fr, 1fr, 1fr), row-gutter: 12pt, column-gutter: 6pt,
        stat("125", "In-person attendees"),
        stat("71", "Institutions"),
        stat("19", "Countries"),
        stat("100+", "Talks & posters"),
        stat("4.4/5", "Overall value"),
        stat("100%", "Found new tools"),
      )
      #v(12pt)
      #line(length: 100%, stroke: 0.6pt + hair)
      #v(10pt)
      #let atot = stats.audience.map(a => a.count).sum()
      #let pal = (accent, rgb("#E0942F"), rgb("#B36B1E"), rgb("#8A5316"))
      #text(fill: muted, size: 8pt, weight: "semibold")[Who's in the room]
      #v(5pt)
      // labels sit inside each segment, so the near-identical amber shades don't
      // need a legend
      #box(width: 100%, radius: 5pt, clip: true)[
        #grid(columns: stats.audience.map(a => a.count * 1fr), rows: 26pt,
          ..stats.audience.enumerate().map(((i, a)) => box(fill: pal.at(calc.rem(i, 4)), width: 100%, height: 100%, inset: (x: 3pt))[
            #align(center + horizon)[#{
              let p = calc.round(a.count / atot * 100)
              let lc = if i < 2 { darker } else { ink }
              if p >= 12 { text(fill: lc, size: 7pt, weight: "bold")[#a.label #p%] }
              else if p >= 5 { text(fill: lc, size: 7pt, weight: "bold")[#p%] }
            }]
          ]))
      ]
    ]
    // grants note — under the stats box but outside it, in the right column
    #v(10pt)
    #grid(columns: (auto, 1fr), column-gutter: 8pt, align: horizon,
      text(fill: accent, size: 9.5pt)[▪],
      text(fill: ink, size: 9pt, weight: "bold")[Student travel grants and childcare support available.])
  ],
)

#v(7pt)
// ════════════════════════ CTA BAND ════════════════════════
#box(fill: accent, radius: 12pt, inset: (x: 16pt, y: 11pt), width: 100%)[
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
