# thro — TH Rosenheim thesis template for Typst

A Typst port of the KOMA-Script (`scrbook`) LaTeX thesis template used for
bachelor's and master's theses at TH Rosenheim. It provides a single bootstrap
function, `thro`, in the spirit of the `charged-ieee` template.

## Features

- Title page with the bundled TH Rosenheim logo (`src/th_logo.png`) shown
  **always**; further logos (e.g. a company logo) can be added alongside it.
- Declaration of originality (German + English) that **defaults** to the
  original template wording but is fully **overridable**.
- **Roman** page numbers for the table of contents, list of figures, list of
  tables and list of listings; **arabic** page numbers from the first chapter.
- Per-chapter figure/table/listing numbering (e.g. `2.1`) and matching
  `Abbildungs-`, `Tabellen-` und `Code-Verzeichnis`.
- Running chapter headers, IEEE bibliography linked into the table of contents.
- German by default, English via `language: "en"`.
- Uses only Typst's bundled fonts (Libertinus Serif / New Computer Modern Math /
  DejaVu Sans Mono) — no font installation required.

## Installation (local package)

Make the package available under the `@local` namespace. On macOS:

```sh
DEST="$HOME/Library/Application Support/typst/packages/local/thro/0.1.0"
mkdir -p "$(dirname "$DEST")"
ln -s /absolute/path/to/thro "$DEST"     # symlink (recommended while editing)
# or: cp -R /absolute/path/to/thro "$DEST"
```

Then scaffold a new thesis from the bundled example:

```sh
typst init @local/thro my-thesis
cd my-thesis
typst compile main.typ
```

## Usage

```typ
#import "@local/thro:0.1.0": thro

#show: thro.with(
  title: [Titel der Arbeit],
  author: (name: "Vorname Nachname"),
  faculty: [Fakultät für Informatik],
  degree: [Master of Science Informatik],
  thesis-type: [Masterarbeit],
  // The TH Rosenheim logo is always shown; add further logos alongside it:
  // logos: (image("assets/company.svg", height: 2cm),),
  hand-in-date: "2026-08-01",
  first-supervisor: [Prof. Dr. …],
  second-supervisor: [M.Sc. …],
  abstract: include "abstract.typ",
  index-terms: ("Stichwort A", "Stichwort B"),
  bibliography: bibliography("refs.bib", style: "ieee"),
)

#include "chapters/1_einleitung.typ"
```

## Parameters

| Parameter | Default | Description |
| --- | --- | --- |
| `title` | — | Thesis title. |
| `author` | `(name: "")` | Dictionary with at least `name`, or a plain string. |
| `abstract` | `none` | Abstract content (e.g. `include "abstract.typ"`). |
| `index-terms` | `()` | Optional keywords shown below the abstract. |
| `bibliography` | `none` | Result of `bibliography("refs.bib", style: "ieee")`. |
| `logos` | `()` | Extra logos shown next to the always-present TH Rosenheim logo. |
| `faculty` | `[Fakultät für Informatik]` | Faculty name. |
| `degree` | `none` | Degree programme, e.g. `[Master of Science Informatik]`. |
| `thesis-type` | `[Abschlussarbeit]` | e.g. `[Bachelorarbeit]` / `[Masterarbeit]`. |
| `hand-in-date` | `none` | Submission date (string or content). |
| `first-supervisor` / `second-supervisor` | `none` | Examiners. |
| `location` | `[Rosenheim]` | Place used in the declaration date line. |
| `declaration-of-originality` | `none` | Overrides the default declaration text. |
| `show-template-credit` | `false` | Show the optional template-credit note. |
| `language` | `"de"` | `"de"` or `"en"`. |
| `paper-size` | `"a4"` | Page size. |
| `font-size` | `11pt` | Base font size. |
| `font` / `sans-font` / `mono-font` | Libertinus Serif / Libertinus Serif / DejaVu Sans Mono | Font faces. |
| `binding-correction` | `0mm` | Extra inner margin for print binding (BCOR). |
| `list-of-figures` / `list-of-tables` / `list-of-listings` | `true` / `true` / `false` | Toggle the front-matter lists. |
| `date` | `datetime.today()` | Date used in the declaration. |

## Notes

- The always-present logo lives at `src/th_logo.png`. Replace that file to
  change it, or add more via `logos:`. **Logos must be SVG, PNG, JPEG or
  GIF** — Typst cannot embed the original template's `.eps`; convert it first
  (e.g. `rsvg-convert`, `inkscape`, `pdftocairo`).
- Code listings appear in the list of listings when wrapped as
  `#figure(kind: raw, caption: [...])[ ```lang … ``` ]`.
- For a sans-serif title page like the LaTeX original, install a sans font and
  pass e.g. `sans-font: "Helvetica Neue"`.
