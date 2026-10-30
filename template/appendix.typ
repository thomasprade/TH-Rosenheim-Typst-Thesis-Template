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
)

// The original template ships both a German and an English version. Keep the one
// matching your thesis language and delete the other (or keep both, as here).
// `usage` is keyed by work step; leave out steps you did not use AI for. Its
// `systems` refer to the rows of `ai-systems` by number (1 = first). Valid keys:
// ideas, literature-search, literature-analysis, citation-management, methods,
// data, code, visualisation, interpretation, structure, translation, other.
// The `date` is pinned here only to keep the rendered example deterministic;
// omit it in a real thesis to default to the current date.
#ai-declaration(
  language: "de",
  author: [Max Mustermann],
  date: datetime(year: 2026, month: 8, day: 1),
  systems: ai-systems,
  usage: (
    literature-search: (
      systems: (1, 2),
      description: [Suche nach Einstiegsliteratur; alle Quellen wurden manuell geprüft.],
    ),
    code: (
      systems: 2,
      description: [Erklärung von Fehlermeldungen im Prototyp.],
    ),
    translation: (
      systems: (3, 1),
      description: [Übersetzung des Abstracts ins Englische.],
    ),
  ),
)

#ai-declaration(
  language: "en",
  author: [Max Mustermann],
  date: datetime(year: 2026, month: 8, day: 1),
  systems: ai-systems,
  usage: (
    literature-search: (
      systems: (1, 2),
      description: [Search for introductory literature; all sources were checked manually.],
    ),
    code: (
      systems: 2,
      description: [Explanation of error messages in the prototype.],
    ),
    translation: (
      systems: (3, 1),
      description: [Translation of the abstract into English.],
    ),
  ),
)
