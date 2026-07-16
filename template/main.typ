#import "@local/thro:0.1.0": thro

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
  // To render the title page / caption labels in a real sans-serif face
  // (requires the font to be installed), uncomment:
  // sans-font: "Helvetica Neue",
  // To override the declaration text, uncomment:
  // declaration-of-originality: include "declaration.typ",
  // Appendix content (e.g. the generative-AI-usage declaration). Rendered after
  // the chapters with lettered numbering (A, B, …):
  appendix: include "appendix.typ",
  bibliography: bibliography("refs.bib", style: "ieee"),
)

#include "chapters/1_einleitung.typ"
#include "chapters/2_grundlagen.typ"
