# Contributing to thro

Thank you for your interest in improving **thro**, the Typst port of the TH
Rosenheim LaTeX thesis template. Contributions to the Typst port are welcome.

Please note that this repository maintains only the **Typst adaptation**. All
rights to the underlying template belong to TH Rosenheim; see the
[Licensing section of the README](README.md#licensing) for details. Questions
about the template itself (rather than this port) should be directed to the
[TH Rosenheim website](https://www.th-rosenheim.de/die-hochschule/fakultaeten/fakultaet-fuer-informatik/informationen-fuer-studierende/informationen-rund-um-ihre-abschlussarbeit).

## Ways to contribute

- **Report a bug or request a feature** by opening an
  [issue](../../issues/new/choose). Anyone can open issues.
- **Submit changes** by forking the repository and opening a pull request.
  Anyone can fork the repository and propose changes this way.

## Development setup

1. Install the Typst compiler (see the
   [Installation section of the README](README.md#installation)).
2. Register the package under the `@local` namespace so the bundled example in
   `template/` resolves `@local/thro:0.1.0` (see the README for per-platform
   instructions).
3. Compile the example to verify your setup:

   ```sh
   cd template
   typst compile main.typ
   ```

## Pull request workflow

1. **Fork** the repository and create a topic branch from `main`
   (e.g. `fix/title-page-spacing`).
2. Make your change, keeping it focused and as small as reasonably possible.
3. **Verify that everything still compiles** before pushing, and regenerate the
   tracked reference PDF if you changed anything that affects the rendered
   output:

   ```sh
   cd template
   typst compile main.typ main.pdf
   ```

   The CI workflow runs this same check on every pull request; PRs must compile
   cleanly to be mergeable.
4. Open a pull request against `main` and fill out the PR template.
5. A code owner will review your change. Address review comments and keep the
   branch up to date. At least one approving review from a code owner is
   required before merging.

## Guidelines

- Match the existing code style and formatting of the `.typ` sources.
- Keep template wording (declaration of originality, AI-usage declaration, …)
  faithful to the official TH Rosenheim template unless a change is explicitly
  intended and justified.
- Update the `README.md` when you change user-facing behaviour or parameters.
- The rendered example [`template/main.pdf`](template/main.pdf) is intentionally
  tracked as a visual reference. If your change affects the rendered output,
  please regenerate it (`cd template && typst compile main.typ main.pdf`) and
  commit the updated PDF so the reference stays current.
- By contributing, you agree that your contributions to the Typst port are made
  available under the same terms as the rest of this repository.

## Reporting security or sensitive issues

For anything that should not be discussed in a public issue, please use GitHub's
private vulnerability reporting (if enabled) or contact the maintainers via the
channels listed on the TH Rosenheim website.
