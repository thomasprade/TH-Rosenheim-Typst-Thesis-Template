# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this is

`thro` is a Typst package (`typst.toml`, entrypoint `thro.typ`) porting the TH Rosenheim KOMA-Script (`scrbook`) LaTeX thesis template for bachelor/master theses, mainly for the Faculty of Computer Science. It exposes one bootstrap function, `thro`, used as `#show: thro.with(...)`, plus the `ai-declaration` and `flex-caption` helpers. `template/` is the scaffold copied by `typst init @local/thro`.

## Build / verify

There are no tests or linter; "it compiles" is the check. CI (`.github/workflows/ci.yml`, Typst 0.15.0) does exactly this:

```sh
# one-time: expose the repo as @local/thro:0.1.0 (macOS path; Linux: ${XDG_DATA_HOME:-$HOME/.local/share}/typst/...)
ln -s "$PWD" "$HOME/Library/Application Support/typst/packages/local/thro/0.1.0"

cd template && typst compile main.typ main.pdf   # or `typst watch main.typ`
```

`template/main.typ` imports `@local/thro:0.1.0`, so it only resolves once the symlink exists. If the package version in `typst.toml` changes, the import, symlink path, CI and README must all change with it.

`template/main.pdf` is tracked as a visual reference: regenerate and commit it when rendered output changes (CONTRIBUTING.md). The example pins `date:` so the declaration text stays stable; the PDF metadata timestamp still changes on every compile unless `--creation-timestamp` is passed.

### Checking rendered output

Compiling only proves the document builds; layout changes need a look at the pages. Write scratch output to the session scratchpad, not into the repo.

```sh
# PNG per page ({0p} is required for multi-page output); --pages limits it, low --ppi keeps images small
typst compile main.typ "$OUT/p-{0p}.png" --pages 8-10 --ppi 40
```

- Look at the PNGs with the Read tool. In the example, physical pages 8+ are the main matter (page 8 = chapter 1 opener, page 9 = chapter 2 opener); earlier pages are title, declaration, abstract and the roman-numbered lists. Page numbers shift when content grows, so check `ls` before assuming.
- Things that are easy to break and worth eyeballing: chapter-opening pages (centered footer number, no running header), float order around chapter titles, the appendix/AI-declaration pages, and the lists of figures/tables/listings.
- **Before/after regression check:** copy the tracked `main.pdf` to the scratchpad *before* changing anything, then compare text positions (poppler's `pdftotext`/`pdftoppm` are installed via Homebrew):

  ```sh
  pdftotext -bbox old.pdf a.txt && pdftotext -bbox new.pdf b.txt && diff a.txt b.txt
  pdftotext -f 8 -l 8 -bbox new.pdf - | grep -m1 '<word'   # e.g. y-position of a chapter title
  ```

  Only the `CreationDate`/`ModDate` meta lines should differ for a refactor that must not change output. For a byte-exact check, compile both versions with `--creation-timestamp 0` and `cmp` them.
- `pdftoppm -r 40 -png -f 8 -l 9 old.pdf old` renders pages of an older PDF (e.g. the committed `main.pdf`) for side-by-side comparison.
- For behaviour the example doesn't exercise (e.g. a float that overflows into the next chapter), write a tiny throwaway `.typ` in the scratchpad that imports `@local/thro:0.1.0` and render it the same way.
- If `typst init`/scaffolding is affected, verify with `typst init @local/thro my-thesis` in the scratchpad and compile it there.
- Tinymist diagnostics for a single chapter file (e.g. "label does not exist", "cannot reference equation without numbering") are false positives: chapters are only valid when included from `main.typ`. Trust the `typst compile` result.

## Architecture

- `thro.typ` — the whole layout in one function, rendered in a fixed order: title page → declaration page → optional abstract → front matter (roman numbering: TOC, list of figures/tables/listings) → main matter (`body`, arabic numbering, running chapter header; chapter-opening pages get a centered footer number instead) → `appendix` → `bibliography`.
  - Level-1 heading show rule does the page break **and** resets figure (image/table/raw) and equation counters; figure/equation numbering closures read `counter(heading)` to produce `2.1`-style numbers.
  - Figures default to `placement: top` (LaTeX `[t]`); a custom `show figure` rule bypasses this and must re-apply it via `place(top, float: true, ...)`.
  - The level-1 title itself is rendered as a top float (`place(top, float: true)`) so floating figures on a chapter's opening page queue below it, not above it. `pagebreak` already flushes pending floats, so no `place.flush()` (it added a blank page and shifted the heading's location, breaking chapter-start header detection).
  - Appendix resets the heading counter and re-applies those numbering rules with `A.1` patterns inside a scoped content block. Page numbering continues.
  - Bibliography is passed in as content (`bibliography: bibliography(...)`) so the parameter name shadows Typst's built-in inside `thro`; it's rendered last.
  - Code listings only appear in the list of listings when wrapped as `figure(kind: raw, ...)`.
  - A `show outline` rule (front matter) sets the `in-outline` state and hides `cite` in every outline, so captions with citations don't take the first IEEE number from the lists. The exported `flex-caption(long, short)` reads that state to show a short caption in the lists.
- `src/i18n.typ` — `labels` dict keyed by language (`de`, `en`) and `format-date`. Every user-visible string in the layout goes through `labels.at(language)`; adding a label means adding it to **both** languages, or lookup fails.
- `src/declaration.typ` — default declaration of originality (DE+EN text always both shown; `language` only affects the date line) and the optional template-credit note.
- `src/ai-declaration.typ` — official generative-AI-usage declaration form, one appendix chapter per call.
- `src/th_logo.png` is the always-shown title-page logo (path is hard-coded in `thro.typ`). Logos must be SVG/PNG/JPEG/GIF — Typst can't embed EPS.

Default fonts mirror the LaTeX original (Palatino, Helvetica, Courier as shipped with macOS), each with a Typst-bundled fallback (Libertinus Serif, DejaVu Sans Mono; math: New Computer Modern Math), so the template still compiles without font installs; keep it that way. Every missing family in a font list emits a warning, so don't add further alternatives to the defaults. Page geometry, leading and heading skips are calibrated against the LaTeX PDF (`pdftotext -bbox` positions of header, first/last line, headings, page number).

## Conventions

- Declaration and AI-declaration wording must stay faithful to the official TH Rosenheim template unless a deviation is intentional and explained.
- Update the `README.md` parameter table when adding/changing `thro` parameters or user-facing behaviour.
- Default branch is `master` (CONTRIBUTING.md says `main`, which is outdated).
