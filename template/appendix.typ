// Appendix — demonstrates the built-in generative-AI-usage declaration.
// Passed to `thro` via `appendix: include "appendix.typ"` in main.typ.
// Every `ai-declaration(...)` call becomes one lettered appendix chapter (A, B, …).
// You can of course add your own appendix chapters here with normal `= Heading`s.

#import "@local/thro:0.1.0": ai-declaration

// The AI systems you used: one row each in the first table (`url` is optional).
#let ai-systems = (
  (name: [ChatGPT (GPT-5)], url: "https://chatgpt.com"),
  (name: [Claude (Opus 5.5)], url: "https://claude.ai"),
  (name: [DeepL], url: "https://www.deepl.com"),
  (name: [GitHub Copilot]),
)

// The original template ships both a German and an English version. Keep the one
// matching your thesis language and delete the other (or keep both, as here).
//
// `usage` is keyed by work step. This example fills in every valid step; delete
// the ones you did not use AI for (they stay as empty rows in the table). Each
// step takes `systems` and `description`, both optional. `systems` refers to the
// rows of `ai-systems` and can be
//   - a number (1 = first row):          systems: 2
//   - an array of numbers:               systems: (1, 2)
//   - free content or a string:          systems: [alle] / systems: "keins"
//   - an array mixing these:             systems: (1, [lokales Modell])
//
// The `date` is pinned here only to keep the rendered example deterministic;
// omit it in a real thesis to default to the current date. `location` defaults
// to Rosenheim.
#ai-declaration(
  language: "de",
  author: [Max Mustermann],
  location: [Rosenheim],
  date: datetime(year: 2026, month: 8, day: 1),
  systems: ai-systems,
  usage: (
    ideas: (
      systems: 2,
      description: [Brainstorming möglicher Gliederungen.],
    ),
    literature-search: (
      systems: (1, 2),
      description: [Suche nach Einstiegsliteratur; alle Quellen wurden manuell geprüft.],
    ),
    literature-analysis: (
      systems: 2,
      description: [Zusammenfassung ausgewählter Paper.],
    ),
    citation-management: (
      systems: [keins],
      description: [Zotero ohne KI-Funktionen.],
    ),
    methods: (
      systems: 1,
      description: [Vergleich möglicher Evaluationsmethoden.],
    ),
    data: (
      systems: (2, [lokales Modell]),
      description: [Bereinigung der Messdaten.],
    ),
    code: (
      systems: (2, 4),
      description: [Erklärung von Fehlermeldungen und Autovervollständigung im Prototyp.],
    ),
    visualisation: (
      systems: 1,
      description: [Vorschläge für Diagrammtypen.],
    ),
    interpretation: (
      systems: 2,
      description: [Plausibilitätsprüfung der Ergebnisse.],
    ),
    structure: (
      systems: 2,
      description: [Feedback zur Kapitelstruktur.],
    ),
    translation: (
      systems: (3, 1),
      description: [Übersetzung des Abstracts ins Englische.],
    ),
    other: (
      systems: [alle],
      description: [Rechtschreib- und Grammatikprüfung.],
    ),
  ),
)

#ai-declaration(
  language: "en",
  author: [Max Mustermann],
  location: [Rosenheim],
  date: datetime(year: 2026, month: 8, day: 1),
  systems: ai-systems,
  usage: (
    ideas: (
      systems: 2,
      description: [Brainstorming possible outlines.],
    ),
    literature-search: (
      systems: (1, 2),
      description: [Search for introductory literature; all sources were checked manually.],
    ),
    literature-analysis: (
      systems: 2,
      description: [Summarising selected papers.],
    ),
    citation-management: (
      systems: [none],
      description: [Zotero without AI features.],
    ),
    methods: (
      systems: 1,
      description: [Comparison of possible evaluation methods.],
    ),
    data: (
      systems: (2, [local model]),
      description: [Cleaning the measurement data.],
    ),
    code: (
      systems: (2, 4),
      description: [Explanation of error messages and code completion in the prototype.],
    ),
    visualisation: (
      systems: 1,
      description: [Suggestions for chart types.],
    ),
    interpretation: (
      systems: 2,
      description: [Plausibility check of the results.],
    ),
    structure: (
      systems: 2,
      description: [Feedback on the chapter structure.],
    ),
    translation: (
      systems: (3, 1),
      description: [Translation of the abstract into English.],
    ),
    other: (
      systems: "all",
      description: [Spelling and grammar check.],
    ),
  ),
)
