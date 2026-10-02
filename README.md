# thro — TH Rosenheim thesis template for Typst

A Typst port of the KOMA-Script (`scrbook`) LaTeX thesis template used for
bachelor's and master's theses at TH Rosenheim. It provides a single bootstrap
function, `thro`, in the spirit of the `charged-ieee` template.

For the official regulations, deadlines and forms around your thesis, always
refer to the authoritative page of the Faculty of Computer Science at TH
Rosenheim:
[Informationen rund um Ihre Abschlussarbeit](https://www.th-rosenheim.de/die-hochschule/fakultaeten/fakultaet-fuer-informatik/informationen-fuer-studierende/informationen-rund-um-ihre-abschlussarbeit).

## Features

- Title page with the bundled TH Rosenheim logo (`src/th_logo.png`) shown
  **always**; further logos (e.g. a company logo) can be added alongside it.
- Declaration of originality (German + English) that **defaults** to the
  original template wording but is fully **overridable**.
- **Appendix** support (`appendix:`) with automatic letter numbering (`A`, `B`,
  … and `A.1` for figures/equations), rendered before the bibliography.
- Built-in **generative-AI-usage declaration** (`ai-declaration`, German and
  English) reproducing the official template form.
- **Roman** page numbers for the table of contents, list of figures, list of
  tables and list of listings; **arabic** page numbers from the first chapter.
- Per-chapter figure/table/listing **and equation** numbering (e.g. `2.1`) and
  matching `Abbildungs-`, `Tabellen-` und `Code-Verzeichnis`.
- Running chapter headers, IEEE bibliography linked into the table of contents.
- German by default, English via `language: "en"`.
- Uses only Typst's bundled fonts (Libertinus Serif / New Computer Modern Math /
  DejaVu Sans Mono) — no font installation required.

## Installation

### 1. Install the Typst compiler

Install the Typst compiler for your platform. See the official download and
package-manager instructions at
[typst.app/open-source](https://typst.app/open-source/), for example:

```sh
# macOS (Homebrew)
brew install typst

# Linux (winget/cargo/package managers — see the page above)
# Windows (winget)
winget install --id Typst.Typst
```

Verify the installation with `typst --version`.

### 2. Recommended editor setup

For editing Typst with live preview, autocompletion and diagnostics, the
[**tinymist**](https://marketplace.visualstudio.com/items?itemName=myriad-dreamin.tinymist)
VS Code extension is recommended. Install it from the Extensions view or run:

```sh
code --install-extension myriad-dreamin.tinymist
```

### 3. Make the package available (`@local`)

Expose the template under Typst's `@local` namespace by linking (or copying) this
repository into your Typst local-packages directory. The target path is
`<data-dir>/typst/packages/local/thro/0.1.0`, where `<data-dir>` depends on your
operating system.

The macOS and Linux snippets are written for **bash** or **zsh** (the macOS
default). If you use another shell such as **fish**, start a bash first by
running `bash`, paste the snippet, then leave it again with `exit`.

#### macOS

```sh
DEST="$HOME/Library/Application Support/typst/packages/local/thro/0.1.0"
mkdir -p "$(dirname "$DEST")"
ln -s /absolute/path/to/thro "$DEST"     # symlink (recommended while editing)
# or: cp -R /absolute/path/to/thro "$DEST"
```

#### Ubuntu / Linux

```sh
DEST="${XDG_DATA_HOME:-$HOME/.local/share}/typst/packages/local/thro/0.1.0"
mkdir -p "$(dirname "$DEST")"
ln -s /absolute/path/to/thro "$DEST"     # symlink (recommended while editing)
# or: cp -R /absolute/path/to/thro "$DEST"
```

#### Windows

Using PowerShell (run as Administrator or with Developer Mode enabled for
symlinks):

```powershell
$Dest = "$env:APPDATA\typst\packages\local\thro\0.1.0"
New-Item -ItemType Directory -Force -Path (Split-Path $Dest) | Out-Null
New-Item -ItemType SymbolicLink -Path $Dest -Target "C:\absolute\path\to\thro"
# or copy instead: Copy-Item -Recurse "C:\absolute\path\to\thro" $Dest
```

Or, using the classic Command Prompt (`cmd.exe`) with `mklink`:

```bat
mkdir "%APPDATA%\typst\packages\local\thro"
mklink /D "%APPDATA%\typst\packages\local\thro\0.1.0" "C:\absolute\path\to\thro"
```

### 4. Create a new thesis

Scaffold a new thesis project from the bundled example:

```sh
typst init @local/thro my-thesis
cd my-thesis
typst compile main.typ
```

### Alternative: import directly by path (no symlink)

If you prefer not to register the package, you can copy the example project
from this repository and point its imports at the cloned repository instead.
Assuming the repository is cloned to `thro/` and your thesis should live next
to it in `my-thesis/`:

```sh
cp -R thro/template my-thesis
cd my-thesis
```

In the copied files, replace the `@local/thro:0.1.0` imports with a path to
`thro.typ`, i.e. in `main.typ`

```typ
#import "../thro/thro.typ": thro
```

and in `appendix.typ`

```typ
#import "../thro/thro.typ": ai-declaration
```

Typst only reads files inside the *project root*, which by default is the
directory of `main.typ`. As `thro.typ` lies outside of `my-thesis/`, the root
must be set to the common parent directory:

```sh
typst compile --root .. main.typ
```

In VS Code with tinymist, set the `tinymist.rootPath` setting to that parent
directory accordingly. Because of this extra step, the `@local` setup from
step 3 remains the recommended one.

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
  appendix: include "appendix.typ",
  bibliography: bibliography("refs.bib", style: "ieee"),
)

#include "chapters/1_einleitung.typ"
```

### Appendix and the AI-usage declaration

Appendix content is passed via `appendix:` and rendered after the chapters with
letter numbering (`A`, `B`, …). The bundled `ai-declaration` helper reproduces
the official generative-AI-usage declaration as an appendix chapter:

```typ
// appendix.typ
#import "@local/thro:0.1.0": ai-declaration

#ai-declaration(language: "de")   // → appendix A
#ai-declaration(language: "en")   // → appendix B
```

## Parameters

| Parameter | Default | Description |
| --- | --- | --- |
| `title` | — | Thesis title. |
| `author` | `(name: "")` | Dictionary with at least `name`, or a plain string. |
| `abstract` | `none` | Abstract content (e.g. `include "abstract.typ"`). |
| `index-terms` | `()` | Optional keywords shown below the abstract. |
| `bibliography` | `none` | Result of `bibliography("refs.bib", style: "ieee")`. |
| `appendix` | `none` | Appendix content (e.g. `include "appendix.typ"`); chapters lettered `A`, `B`, …. |
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
| `math-font` | New Computer Modern Math | Font for mathematics (the only bundled math face). |
| `binding-correction` | `0mm` | Extra inner margin for print binding (BCOR). |
| `list-of-figures` / `list-of-tables` / `list-of-listings` | `true` / `true` / `false` | Toggle the front-matter lists. |
| `date` | `datetime.today()` | Date used in the declaration. |

## Notes

- The always-present logo lives at `src/th_logo.png`. Replace that file to
  change it, or add more via `logos:`. **Logos must be SVG, PNG, JPEG or
  GIF** — Typst cannot embed the original template's `.eps`; convert it first
  (e.g. `rsvg-convert`, `inkscape`, `pdftocairo`).
- The `ai-declaration(language: "de" | "en")` helper renders the official
  generative-AI-usage declaration as one lettered appendix chapter; call it in
  the content passed to `appendix:` (see `template/appendix.typ`).
- Appendix headings, figures, tables and equations use letter numbering
  (`A`, `A.1`); page numbering continues from the last chapter.
- Figures, tables and listings float to the top of the page by default (the
  equivalent of LaTeX's `[t]`). Pass `placement: none` to a single figure only
  where it really must stay at its position in the text, or e.g.
  `placement: bottom` / `auto` for other float positions. On a chapter's first
  page, floats are placed below the chapter title. A custom `show figure` rule
  replaces the built-in layout and therefore drops the placement; re-apply it
  with `place(top, float: true, ...)` inside the rule (see the side-caption
  figure in `template/chapters/2_grundlagen.typ`).
- Code listings appear in the list of listings when wrapped as
  `#figure(kind: raw, caption: [...])[ ```lang … ``` ]`.
- For a sans-serif title page like the LaTeX original, install a sans font and
  pass e.g. `sans-font: "Helvetica Neue"`.

## Licensing

This project is a Typst port of the LaTeX _Dokumentvorlage Abschlussarbeit_
provided by TH Rosenheim (Technische Hochschule Rosenheim). **The maintainer of
this repository is not the original author of the template.** All rights to the
original template and its contents remain with the university.

- The original LaTeX template was created by **Prof. Dr. Jochen Schmidt**.
- All copyright in the template design, wording (declaration of originality,
  generative-AI-usage declaration, …) and the TH Rosenheim logo belongs to
  **TH Rosenheim** and its respective authors.
- This repository only provides a Typst adaptation to make the template usable
  with the Typst typesetting system; it does not claim any ownership over the
  underlying template.

If you have questions about the licensing or permitted use of the template
itself, please refer to the official material and contact details on the
[TH Rosenheim website](https://www.th-rosenheim.de/die-hochschule/fakultaeten/fakultaet-fuer-informatik/informationen-fuer-studierende/informationen-rund-um-ihre-abschlussarbeit).

## Contributing

Contributions to the Typst port are welcome:

- The repository is **public** and may be freely **cloned**.
- **Anyone can open issues** to report bugs or suggest improvements.
- **Anyone can fork** the repository and submit **pull requests** with fixes or
  enhancements.

For questions that concern the underlying template itself (rather than this
Typst port), or for further contact information, please consult the
[TH Rosenheim website](https://www.th-rosenheim.de/die-hochschule/fakultaeten/fakultaet-fuer-informatik/informationen-fuer-studierende/informationen-rund-um-ihre-abschlussarbeit).
