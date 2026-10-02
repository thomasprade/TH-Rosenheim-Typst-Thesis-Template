// thro.typ — TH Rosenheim thesis template
// A Typst port of the KOMA-Script (scrbook) LaTeX thesis template.
//
// Usage:
//   #import "@local/thro:0.1.0": thro
//   #show: thro.with(title: [...], author: (name: "..."), ...)

#import "src/i18n.typ": labels, format-date
#import "src/declaration.typ": default-declaration, template-credit
#import "src/ai-declaration.typ": ai-declaration

#let thro(
  // --- Core metadata -------------------------------------------------------
  title: [Titel der Abschlussarbeit],
  author: (name: ""),
  abstract: none,
  index-terms: (),
  bibliography: none,
  appendix: none,

  // --- Title page ----------------------------------------------------------
  // Additional logos shown alongside the always-present TH Rosenheim logo.
  logos: (),
  faculty: [Fakultät für Informatik],
  university: [Technische Hochschule Rosenheim],
  degree: none,
  thesis-type: [Abschlussarbeit],
  hand-in-date: none,
  first-supervisor: none,
  second-supervisor: none,

  // --- Declaration of originality -----------------------------------------
  location: [Rosenheim],
  declaration-of-originality: none,
  show-template-credit: false,

  // --- Configuration -------------------------------------------------------
  language: "de",
  paper-size: "a4",
  font-size: 11pt,
  font: "Libertinus Serif",
  sans-font: "Libertinus Serif",
  mono-font: "DejaVu Sans Mono",
  math-font: "New Computer Modern Math",
  binding-correction: 0mm,
  list-of-figures: true,
  list-of-tables: true,
  list-of-listings: false,
  date: datetime.today(),

  body,
) = {
  let L = labels.at(language)
  let author-name = if type(author) == dictionary { author.at("name", default: "") } else { author }

  // ----------------------------------------------------------------- metadata
  set document(title: title, author: author-name)

  // --------------------------------------------------------------------- text
  set text(font: font, size: font-size, lang: language)
  show math.equation: set text(font: math-font)

  // ------------------------------------------------------------------- layout
  set page(
    paper: paper-size,
    margin: (
      left: 25mm + binding-correction,
      right: 25mm,
      top: 30mm,
      bottom: 30mm,
    ),
    numbering: none,
  )

  set par(
    justify: true,
    leading: 0.7em,
    spacing: 0.7em,
    first-line-indent: (amount: 1em, all: false),
  )

  // ---------------------------------------------------------------- headings
  set heading(numbering: "1.1")

  let heading-number(it) = if it.numbering != none {
    numbering(it.numbering, ..counter(heading).at(it.location()))
    h(0.5em)
  }

  show heading.where(level: 1): it => {
    pagebreak(weak: true)
    counter(figure.where(kind: image)).update(0)
    counter(figure.where(kind: table)).update(0)
    counter(figure.where(kind: raw)).update(0)
    counter(math.equation).update(0)
    // The title is itself the first top float, so floating figures of the
    // chapter's opening page queue below it instead of above it.
    place(top, float: true, clearance: 1cm, block({
      set text(size: 22pt, weight: "bold")
      heading-number(it)
      it.body
    }))
  }
  show heading.where(level: 2): it => block(above: 1.4em, below: 0.7em, {
    set text(size: 15pt, weight: "bold")
    heading-number(it)
    it.body
  })
  show heading.where(level: 3): it => block(above: 1.1em, below: 0.6em, {
    set text(size: 12pt, weight: "bold")
    heading-number(it)
    it.body
  })

  // ----------------------------------------------------------------- figures
  show figure.where(kind: image): set figure(supplement: L.figure)
  show figure.where(kind: table): set figure(supplement: L.table)
  show figure.where(kind: raw): set figure(supplement: L.listing)
  show figure.where(kind: table): set figure.caption(position: top)

  // Float figures to the top of the page, like LaTeX's [t]; a single figure
  // can opt out with `placement: none`.
  set figure(placement: top)

  // Per-chapter figure numbering, e.g. "2.1".
  set figure(numbering: n => {
    let chapters = counter(heading).get()
    if chapters.len() == 0 { numbering("1", n) } else { numbering("1.1", chapters.first(), n) }
  })

  // Per-chapter equation numbering, e.g. "(2.1)".
  set math.equation(numbering: n => {
    let chapters = counter(heading).get()
    if chapters.len() == 0 { numbering("(1)", n) } else { numbering("(1.1)", chapters.first(), n) }
  })

  // Caption: bold (sans) label, small text, space separator ("Abbildung 2.1 …").
  set figure.caption(separator: [ ])
  show figure.caption: it => {
    set text(size: 9pt)
    text(font: sans-font, weight: "bold")[#it.supplement~#context it.counter.display(it.numbering)]
    it.separator
    it.body
  }

  // -------------------------------------------------------------------- code
  show raw.where(block: true): it => block(
    width: 100%,
    fill: luma(247),
    inset: 8pt,
    radius: 3pt,
    text(font: mono-font, size: 0.85em, it),
  )
  show raw.where(block: false): it => box(
    fill: luma(240),
    inset: (x: 2pt),
    outset: (y: 2pt),
    radius: 2pt,
    text(font: mono-font, it),
  )

  // Unnumbered chapter-like title for front-matter pages (not a heading).
  let front-title = body => block(above: 2cm, below: 1cm, text(size: 22pt, weight: "bold", body))

  // ==================================================================== TITLE
  page({
    set text(font: sans-font)
    set par(justify: false, first-line-indent: 0pt, leading: 0.65em)

    // The bundled TH Rosenheim logo is always shown; user `logos` are appended.
    let all-logos = (image("src/th_logo.png", height: 2cm),) + logos
    align(right, grid(columns: (auto,) * all-logos.len(), column-gutter: 1cm, ..all-logos))

    v(1fr)

    align(center, {
      text(size: 17pt, faculty)
      if degree != none {
        linebreak()
        v(0.2cm)
        text(size: 14pt, degree)
      }
      v(2cm)
      text(size: 17pt, weight: "bold", title)
      v(2cm)
      text(size: 17pt, thesis-type)
      v(1.5cm)
      text(size: 14pt, L.by)
      linebreak()
      v(0.3cm)
      text(size: 17pt, author-name)
    })

    v(1fr)

    let info = ()
    if hand-in-date != none { info.push(L.submission-date + ":"); info.push(hand-in-date) }
    if first-supervisor != none { info.push(L.first-supervisor + ":"); info.push(first-supervisor) }
    if second-supervisor != none { info.push(L.second-supervisor + ":"); info.push(second-supervisor) }
    if info.len() > 0 {
      set text(size: 12pt)
      grid(columns: 2, column-gutter: 1em, row-gutter: 0.6em, ..info)
    }
  })

  // ============================================================== DECLARATION
  page({
    set par(justify: true)
    v(1fr)
    if show-template-credit {
      template-credit(language: language)
      v(1.5em)
    }
    text(font: sans-font, weight: "bold", smallcaps(L.declaration-heading))
    v(1em)
    if declaration-of-originality != none {
      declaration-of-originality
    } else {
      default-declaration(
        author-name: author-name,
        location: location,
        date: date,
        language: language,
      )
    }
  })

  // ================================================================= ABSTRACT
  if abstract != none {
    page({
      front-title(L.abstract)
      abstract
      if index-terms.len() > 0 {
        v(1em)
        text(weight: "bold")[#L.keywords: ]
        index-terms.join(", ")
      }
    })
  }

  // =============================================================== FRONT MATTER
  // Roman page numbers for TOC / LOF / LOT / LOL.
  counter(page).update(1)
  set page(numbering: "i")

  front-title(L.contents)
  outline(title: none, depth: 3, indent: auto)

  if list-of-figures {
    pagebreak()
    front-title(L.list-of-figures)
    outline(title: none, target: figure.where(kind: image))
  }
  if list-of-tables {
    pagebreak()
    front-title(L.list-of-tables)
    outline(title: none, target: figure.where(kind: table))
  }
  if list-of-listings {
    pagebreak()
    front-title(L.list-of-listings)
    outline(title: none, target: figure.where(kind: raw))
  }

  // ================================================================ MAIN MATTER
  // Running header with the current chapter title + arabic page number; a plain
  // style (number centered in the footer) is used on chapter-opening pages.
  let is-chapter-start = () => {
    let cur = here().page()
    query(heading.where(level: 1)).map(h => h.location().page()).contains(cur)
  }

  let main-header = context {
    let before = query(heading.where(level: 1).before(here()))
    if not is-chapter-start() and before.len() > 0 {
      let chap = before.last()
      let chap-num = if chap.numbering != none {
        [#numbering(chap.numbering, ..counter(heading).at(chap.location()))#h(0.75em)]
      } else { [] }
      set text(size: 9pt)
      block(
        width: 100%,
        stroke: (bottom: 0.4pt),
        inset: (bottom: 3pt),
        grid(
          columns: (1fr, auto),
          align(left)[#chap-num#chap.body],
          align(right)[#counter(page).display()],
        ),
      )
    }
  }

  let main-footer = context {
    if is-chapter-start() {
      align(center)[#counter(page).display()]
    }
  }

  pagebreak(weak: true)
  counter(page).update(1)
  counter(heading).update(0)
  set page(numbering: "1", header: main-header, footer: main-footer)

  body

  // ================================================================== APPENDIX
  // Lettered numbering (A, B, … / A.1) mirroring the LaTeX \appendix; the
  // arabic page numbering from the main matter simply continues.
  if appendix != none {
    counter(heading).update(0)
    [
      #set heading(numbering: "A.1")
      #set figure(numbering: n => {
        let chapters = counter(heading).get()
        if chapters.len() == 0 { numbering("A", n) } else { numbering("A.1", chapters.first(), n) }
      })
      #set math.equation(numbering: n => {
        let chapters = counter(heading).get()
        if chapters.len() == 0 { numbering("(A)", n) } else { numbering("(A.1)", chapters.first(), n) }
      })
      #appendix
    ]
  }

  // =============================================================== BIBLIOGRAPHY
  if bibliography != none {
    bibliography
  }
}
