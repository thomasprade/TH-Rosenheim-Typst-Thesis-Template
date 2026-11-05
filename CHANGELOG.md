# Changelog

All notable changes to `thro` are documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

The package version in `typst.toml` has stayed at `0.1.0` so far. Everything
below `[0.1.0]` is the state of 2026-07-16; later changes are collected under
`[Unreleased]` until the next version bump.

## [Unreleased]

### Added

- `flex-caption(long, short)` helper, the counterpart of LaTeX's
  `\caption[short]{long}`: the lists of figures, tables and listings show the
  short caption.
- Glossary of abbreviations in the scaffold via the
  [glossarium](https://typst.app/universe/package/glossarium) package
  (`template/glossary.typ`, list printed after the chapters). It is optional
  and not a dependency of `thro` itself.
- `ai-declaration` now fills in the form: new parameters `systems`
  (numbered table of AI systems), `usage` (dictionary keyed by work step) and
  `author`. Unknown step keys and system numbers without a matching row are an
  error.
- Footnotes styled like `\deffootnote` (mark on the baseline in a 1em column,
  40% separator line).
- Bibliography title localised ("Literaturverzeichnis" / "Bibliography").
- `src/listing.tmTheme` syntax theme for code listings (black code with bold
  keywords, like the LaTeX `listings` package). It was already referenced by
  `thro.typ` but missing from the repository.

### Changed

- **Breaking:** `ai-declaration` requires at least one entry in `systems`. A
  plain `ai-declaration(language: "de")` call no longer compiles; leave the
  call out entirely if no AI systems were used.
- Default fonts are Palatino, Helvetica and Courier as in the LaTeX original
  (as shipped with macOS), with Libertinus Serif and DejaVu Sans Mono as
  bundled fallbacks.
- Page geometry, leading and heading sizes/skips calibrated against the LaTeX
  PDF: KOMA-Script `DIV=14` type area (165 mm text width, 47 lines on A4),
  13.6pt baseline distance, `headings=big` sizes, sans-serif headings, KOMA
  list spacing.
- Figures float to the top of the page by default (LaTeX `[t]`); a single
  figure can opt out with `placement: none`. The chapter title is itself a top
  float, so figures on a chapter's opening page are placed below it.
- Running header shows the chapter title centred; the page number is always
  centred in the footer.
- Hyphenation: higher hyphenation cost in body text, ragged headings without
  hyphenation, wrapped heading lines aligned with the first word instead of
  the number.
- Scaffold `appendix.typ` shows a complete AI-declaration example covering
  every work step.
- German keywords label is "Schlagworte" (was "Schlüsselwörter").
- README: clarified usage and installation, documented the new parameters.

### Fixed

- Citations in captions no longer take the first number (`[1]`) in numeric
  styles such as IEEE: citations are hidden in all outlines.
- Header and footer layout on pages without a level-1 heading.

## [0.1.0] - 2026-07-16

Initial Typst port of the TH Rosenheim KOMA-Script (`scrbook`) LaTeX thesis
template.

### Added

- `thro` bootstrap function (`#show: thro.with(...)`) with title page,
  declaration of originality, abstract, front matter (TOC, lists of figures,
  tables and listings), main matter, appendix and bibliography.
- German and English labels (`src/i18n.typ`).
- `ai-declaration(language: "de" | "en")` helper for the official
  generative-AI-usage declaration as an appendix chapter.
- Scaffold in `template/` for `typst init @local/thro`, with a compiled
  reference PDF (`template/main.pdf`).
- CI workflow that compiles the bundled example.
- Contribution guidelines, issue and pull request templates, `CODEOWNERS`.

[Unreleased]: https://github.com/thomasprade/TH-Rosenheim-Typst-Thesis-Template/compare/dd622b6...HEAD
[0.1.0]: https://github.com/thomasprade/TH-Rosenheim-Typst-Thesis-Template/tree/dd622b6
