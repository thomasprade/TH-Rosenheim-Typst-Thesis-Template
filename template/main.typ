#import "@local/thro:0.1.0": thro
// Abbreviations via the glossarium package; entries live in glossary.typ.
#import "glossary.typ": glossary, make-glossary, register-glossary, print-glossary

#show: make-glossary
#register-glossary(glossary)

#show: thro.with(
  title: [Konzeption und Umsetzung einer beispielhaften Abschlussarbeit],
  author: (name: "Max Mustermann"),
  faculty: [Fakultät für Informatik],
  degree: [Master of Science Informatik],
  thesis-type: [Masterarbeit],
  hand-in-date: "2026-08-01",
  // Pinned so the rendered example (and the tracked reference PDF) stays
  // deterministic; omit this in a real thesis to default to the current date.
  date: datetime(year: 2026, month: 8, day: 1),
  first-supervisor: [Prof. Dr. A B],
  second-supervisor: [Prof. Dr. C D],
  abstract: include "abstract.typ",
  index-terms: ("Masterarbeit", "Vorlage", "Typst"),
  list-of-listings: true,
  language: "de",
  // The TH Rosenheim logo is always shown. Add further logos (e.g. a company
  // logo) here — they appear next to it:
  // logos: (image("assets/company-logo.svg", height: 2cm),),
  // Fonts default to Palatino / Helvetica / Courier (macOS). Elsewhere, e.g.:
  // font: "TeX Gyre Pagella", sans-font: "TeX Gyre Heros",
  // To override the declaration text, uncomment:
  // declaration-of-originality: include "declaration.typ",
  // Appendix content (e.g. the generative-AI-usage declaration). Rendered after
  // the chapters with lettered numbering (A, B, …):
  appendix: include "appendix.typ",
  bibliography: bibliography("refs.bib", style: "ieee"),
)

#include "chapters/1_einleitung.typ"
#include "chapters/2_grundlagen.typ"

// thro has no front-matter slot for a list of abbreviations, so it is placed
// after the chapters. Only entries referenced in the text are listed.
#heading(numbering: none)[Abkürzungsverzeichnis]
#print-glossary(glossary, deduplicate-back-references: true)
