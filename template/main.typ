#import "@local/thro:0.1.0": thro

#show: thro.with(
  title: [Konzeption und Umsetzung einer beispielhaften Abschlussarbeit],
  author: (name: "Max Mustermann"),
  faculty: [Fakultät für Informatik],
  degree: [Master of Science Informatik],
  thesis-type: [Masterarbeit],
  hand-in-date: "2026-08-01",
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
  bibliography: bibliography("refs.bib", style: "ieee"),
  declaration-of-originality: include "declaration.typ"
)

#include "chapters/1_einleitung.typ"
#include "chapters/2_grundlagen.typ"
