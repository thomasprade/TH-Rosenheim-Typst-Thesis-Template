// thro.typ — TH Rosenheim thesis template
// A Typst port of the KOMA-Script (scrbook) LaTeX thesis template.
//
// Usage:
//   #import "@local/thro:0.1.0": thro, flex-caption
//   #show: thro.with(title: [...], author: (name: "..."), ...)

#import "src/i18n.typ": format-date, labels
#import "src/declaration.typ": default-declaration, template-credit
#import "src/ai-declaration.typ": ai-declaration

// Captions and headings are rendered a second time in the front-matter
// outlines. A citation there would be the first one in the document and shift
// numeric (IEEE) numbering, so `thro` hides citations in every outline.
// `flex-caption(long, short)` is the counterpart of LaTeX's
// `\caption[short]{long}`: the short form appears in the outlines, the long
// one at the figure.
#let in-outline = state("thro-in-outline", false)
#let flex-caption(long, short) = context if in-outline.get() { short } else { long }

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
  // Palatino / Helvetica / Courier like the LaTeX original (mathpazo, helvet,
  // courier), as shipped with macOS. Without them Typst falls back to its
  // bundled fonts (with an "unknown font family" warning), so the template
  // still compiles without font installs. Every missing family in a list
  // warns, hence no further alternatives here.
  font: ("Palatino", "Libertinus Serif"),
  sans-font: ("Helvetica", "Libertinus Serif"),
  mono-font: ("Courier", "DejaVu Sans Mono"),
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
  // Doubled hyphenation cost: justified German text otherwise splits words often.
  set text(font: font, size: font-size, lang: language, costs: (hyphenation: 300%))
  show math.equation: set text(font: math-font)

  // ------------------------------------------------------------------- layout
  // Type area of KOMA-Script `DIV=14` (one-sided, header included): 165 mm
  // text width and 47 lines of text on A4.
  set page(
    paper: paper-size,
    margin: (
      left: 22.5mm + binding-correction,
      right: 22.5mm,
      top: 101pt,
      bottom: 105pt,
    ),
    header-ascent: 28pt,
    footer-descent: 31pt,
    numbering: none,
  )

  // Baseline distance of 13.6pt like LaTeX at 11pt; no extra paragraph space.
  let leading = 6pt
  set par(
    justify: true,
    leading: leading,
    spacing: leading,
    first-line-indent: (amount: 1em, all: false),
  )

  // List spacing of KOMA's itemize/enumerate (itemsep + parsep, topsep).
  set list(spacing: leading + 9pt)
  set enum(spacing: leading + 9pt)
  show list: set block(above: leading + 9pt, below: leading + 9pt)
  show enum: set block(above: leading + 9pt, below: leading + 9pt)

  // Palatino's superscript metrics are tiny (also for footnote marks); use
  // LaTeX's \scriptsize instead.
  set super(typographic: false, size: 0.7em, baseline: -0.4em)

  // Footnote mark set on the baseline in a 1em column, as `\deffootnote`.
  set footnote.entry(separator: line(length: 40%, stroke: 0.4pt))
  show footnote.entry: it => {
    let loc = it.note.location()
    grid(
      columns: (1em, 1fr),
      numbering(it.note.numbering, ..counter(footnote).at(loc)), it.note.body,
    )
  }

  // `bibliography` is shadowed by the parameter of the same name.
  set std.bibliography(title: L.bibliography)

  // ---------------------------------------------------------------- headings
  set heading(numbering: "1.1")
  // Ragged headings; this also disables their hyphenation (`hyphenate: auto`).
  show heading: set par(justify: false)

  // Number and title in separate columns, so wrapped title lines align with
  // the first word instead of running back under the number.
  let heading-title(it) = if it.numbering == none { it.body } else {
    grid(
      columns: (auto, 1fr),
      column-gutter: 0.5em,
      numbering(it.numbering, ..counter(heading).at(it.location())), it.body,
    )
  }

  // KOMA `headings=big` sizes (\huge, \Large, \large) rounded to full points,
  // with the before/after skips of scrbook.
  show heading: set text(font: sans-font, weight: "bold")
  let chapter-title(body) = block(inset: (top: 49pt), text(font: sans-font, size: 21pt, weight: "bold", body))

  show heading.where(level: 1): it => {
    pagebreak(weak: true)
    counter(figure.where(kind: image)).update(0)
    counter(figure.where(kind: table)).update(0)
    counter(figure.where(kind: raw)).update(0)
    counter(math.equation).update(0)
    // The title is itself the first top float, so floating figures of the
    // chapter's opening page queue below it instead of above it.
    place(top, float: true, clearance: 29pt, chapter-title(heading-title(it)))
  }
  show heading.where(level: 2): it => block(above: 27pt, below: 17pt, {
    set text(size: 14pt)
    heading-title(it)
  })
  show heading.where(level: 3): it => block(above: 23pt, below: 14pt, {
    set text(size: 12pt)
    heading-title(it)
  })

  // ----------------------------------------------------------------- figures
  show figure.where(kind: image): set figure(supplement: L.figure)
  show figure.where(kind: table): set figure(supplement: L.table)
  show figure.where(kind: raw): set figure(supplement: L.listing)
  show figure.where(kind: table): set figure.caption(position: top)
  show figure.where(kind: raw): set figure.caption(position: top)

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

  // Caption: bold (sans) label, \small text, space separator ("Abbildung 2.1 …").
  // Like the caption package, a single line is centered and a longer caption
  // is justified across the full width.
  set figure.caption(separator: [ ])
  show figure.caption: it => {
    set text(size: font-size - 1pt)
    let caption = {
      text(font: sans-font, weight: "bold")[#it.supplement~#context it.counter.display(it.numbering)]
      it.separator
      it.body
    }
    layout(size => if measure(caption).width <= size.width { caption } else {
      block(width: 100%, align(left, par(first-line-indent: 0pt, caption)))
    })
  }

  // -------------------------------------------------------------------- code
  // Black text with bold keywords and no background, as `listings` sets Java.
  set raw(theme: "src/listing.tmTheme")
  show raw: set text(font: mono-font)
  show raw.where(block: true): set text(size: 0.9em)
  show raw.where(block: true): set block(above: leading + 6pt, below: leading + 6pt)
  // Floating listings get the rules above and below of `frame=tb`.
  show figure.where(kind: raw): it => {
    show raw.where(block: true): r => block(
      width: 100%,
      stroke: (top: 0.5pt, bottom: 0.5pt),
      inset: (y: 4pt),
      align(left, r),
    )
    it
  }
  show raw.where(block: false): it => box(
    fill: luma(240),
    inset: (x: 2pt),
    outset: (y: 2pt),
    radius: 2pt,
    text(font: mono-font, it),
  )

  // Unnumbered chapter-like title for front-matter pages (not a heading).
  // Placed like a chapter title and followed by the same gap.
  let front-title = body => block(below: 29pt, chapter-title(body))

  // ==================================================================== TITLE
  page({
    set text(font: sans-font)
    set par(justify: false, first-line-indent: 0pt, leading: 0.65em)

    // The bundled TH Rosenheim logo is always shown; user `logos` are appended.
    let all-logos = (image("src/th_logo.png", height: 2cm),) + logos
    align(right, grid(columns: (auto,) * all-logos.len(), column-gutter: 1cm, ..all-logos))

    v(1fr)

    // \LARGE and \Large of the LaTeX title page, rounded to full points.
    align(center, {
      text(size: 17pt, faculty)
      if degree != none {
        linebreak()
        v(0.5cm)
        text(size: 14pt, degree)
      }
      v(2cm)
      text(size: 17pt, title)
      v(2cm)
      text(size: 14pt, thesis-type)
      v(1.5cm)
      text(size: 14pt, L.by)
      linebreak()
      v(0.5cm)
      text(size: 17pt, author-name)
    })

    v(1fr)

    let info = ()
    if hand-in-date != none {
      info.push(L.submission-date + ":")
      info.push(hand-in-date)
    }
    if first-supervisor != none {
      info.push(L.first-supervisor + ":")
      info.push(first-supervisor)
    }
    if second-supervisor != none {
      info.push(L.second-supervisor + ":")
      info.push(second-supervisor)
    }
    if info.len() > 0 {
      set text(size: 14pt)
      grid(columns: 2, column-gutter: 1em, row-gutter: 0.4em, ..info)
    }
  })

  // ============================================================== DECLARATION
  // \large and \noindent throughout, as in the LaTeX title.tex.
  page({
    set text(size: font-size + 1pt)
    set par(justify: true, first-line-indent: 0pt)
    v(1fr)
    if show-template-credit {
      template-credit(language: language)
      v(1.5em)
    }
    // Small caps faked by scaled capitals: macOS' Palatino has no `smcp`.
    L.declaration-heading.clusters().map(c => if c != upper(c) { text(size: 0.8em, upper(c)) } else { c }).join()
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
        block(above: leading + 12pt)[#L.keywords: #index-terms.join(", ")]
      }
    })
  }

  // =============================================================== FRONT MATTER
  // Roman page numbers for TOC / LOF / LOT / LOL.
  counter(page).update(1)
  set page(numbering: "i")

  // Widely spaced leader dots, as LaTeX's \@dottedtocline.
  set outline.entry(fill: box(width: 1fr, repeat(gap: 0.45em)[.]))

  // Short captions and no citations in outlines (see `flex-caption`).
  show outline: it => {
    in-outline.update(true)
    show cite: none
    it
    in-outline.update(false)
  }

  front-title(L.contents)
  {
    // Chapter entries: bold sans, no leader, separated by a small gap.
    show outline.entry.where(level: 1): set block(above: leading + 8pt)
    show outline.entry.where(level: 1): it => link(it.element.location(), text(
      font: sans-font,
      weight: "bold",
      it.indented(it.prefix(), [#it.body()#h(1fr)#it.page()]),
    ))
    outline(title: none, depth: 3, indent: auto)
  }

  // Lists of figures/tables/listings show the bare number ("2.1"), without
  // the supplement.
  let figure-list(target) = {
    show outline.entry: it => context {
      let loc = it.element.location()
      let chapter = query(heading.where(level: 1).before(loc)).at(-1, default: none)
      let n = it.element.counter.at(loc).first()
      let number = if chapter == none or chapter.numbering == none { str(n) } else {
        numbering(chapter.numbering, counter(heading).at(loc).first(), n)
      }
      link(loc, it.indented(number, it.inner()))
    }
    outline(title: none, target: target)
  }

  if list-of-figures {
    pagebreak()
    front-title(L.list-of-figures)
    figure-list(figure.where(kind: image))
  }
  if list-of-tables {
    pagebreak()
    front-title(L.list-of-tables)
    figure-list(figure.where(kind: table))
  }
  if list-of-listings {
    pagebreak()
    front-title(L.list-of-listings)
    figure-list(figure.where(kind: raw))
  }

  // ================================================================ MAIN MATTER
  // Running header with the current chapter title, centered (omitted on
  // chapter-opening pages); the page number is always centered in the footer
  // (Typst's default footer for a numbered page).
  let main-header = context {
    let cur = here().page()
    let is-chapter-start = query(heading.where(level: 1)).any(h => h.location().page() == cur)
    let before = query(heading.where(level: 1).before(here()))
    if not is-chapter-start and before.len() > 0 {
      let chap = before.last()
      let chap-num = if chap.numbering != none {
        [#numbering(chap.numbering, ..counter(heading).at(chap.location()))#h(0.75em)]
      } else { [] }
      // KOMA's slanted running head in text size.
      set text(style: "italic")
      align(center)[#chap-num#chap.body]
    }
  }

  pagebreak(weak: true)
  counter(page).update(1)
  counter(heading).update(0)
  set page(numbering: "1", header: main-header)

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
