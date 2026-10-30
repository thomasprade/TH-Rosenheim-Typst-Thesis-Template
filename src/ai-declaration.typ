// Declaration on the use of generative AI systems.
//
// A Typst port of the two appendix chapters in the original LaTeX template
// (append.tex). Call `ai-declaration(language: "de" | "en", systems: ..., usage: ...)`
// inside the `appendix` passed to `thro`. Each call produces one appendix
// chapter (heading + form).
//
// - `systems`: array of `(name: ..., url: ...)` dictionaries (`url` optional),
//   one numbered row each in the first table.
// - `usage`: dictionary keyed by work step (the keys of `steps` below, identical
//   in both languages), each value `(systems: ..., description: ...)`. `systems`
//   is a number referring to a row of the first table, content, a string, or an
//   array of these (joined with ", "). Steps left out stay blank; unknown keys
//   and out-of-range numbers are an error.

#import "i18n.typ": labels, format-date

// A checked-box marker (framed box with a checkmark), mirroring the LaTeX
// `\checkedsquare` command used for the itemized declarations.
#let checked-box = box(
  width: 0.85em,
  height: 0.85em,
  stroke: 0.6pt,
  inset: 0pt,
  align(center + horizon, text(size: 0.7em, sym.checkmark)),
)

#let ai-declaration(
  language: "de",
  systems: (),
  usage: (:),
  author: none,
  location: [Rosenheim],
  date: datetime.today(),
) = {
  let L = labels.at(language)

  let de = (
    heading: [Erklärung zur Verwendung generativer KI-Systeme],
    intro: [
      Bei der Erstellung der Arbeit habe ich die folgenden auf künstlicher
      Intelligenz (KI) basierten Systeme benutzt:
    ],
    tool-head: ([], [KI-System], [Homepage/Link des Tools]),
    further: [Ich erkläre weiterhin, dass ich],
    checks: (
      [mich aktiv über die Leistungsfähigkeit und Beschränkungen der oben
        genannten KI-Systeme informiert habe,],
      [überprüft habe, dass die mithilfe der oben genannten KI-Systeme
        generierten und von mir übernommenen Inhalte faktisch richtig sind,],
      [mir bewusst bin, dass ich als Autor/Autorin dieser Arbeit die
        Verantwortung für die in ihr gemachten Angaben und Aussagen trage.],
    ),
    usage-intro: [Die oben genannten KI-Systeme habe ich wie im Folgenden dargestellt
      eingesetzt.],
    step-head: (
      [Arbeitsschritt],
      [Eingesetzte(s) KI-System(e)],
      [Beschreibung der Verwendungsweise],
    ),
    steps: (
      ideas: [Generierung von Ideen und Konzeption der Arbeit],
      literature-search: [Literatursuche],
      literature-analysis: [Literaturanalyse],
      citation-management: [Literaturverwaltung und Zitationsmanagement],
      methods: [Auswahl von Methoden und Modellen],
      data: [Datensammlung und -analyse],
      code: [Generierung von Programmcode],
      visualisation: [Erstellung von Visualisierungen],
      interpretation: [Interpretation und Validierung],
      structure: [Strukturierung des Texts der Arbeit],
      translation: [Übersetzung des Texts der Arbeit],
      other: [Sonstiges],
    ),
    signature: [Unterschrift],
  )

  let en = (
    heading: [Declaration on the Use of Generative AI Systems],
    intro: [
      In preparing this work, I used the following artificial intelligence
      (AI)-based systems:
    ],
    tool-head: ([], [AI system], [Homepage/link to the tool]),
    further: [I further declare that I],
    checks: (
      [have actively informed myself about the capabilities and limitations of
        the above-mentioned AI systems,],
      [have verified that the content generated using the above-mentioned AI
        systems and adopted by me is factually correct,],
      [am aware that, as the author of this work, I am responsible for the
        information and statements made therein.],
    ),
    usage-intro: [I have used the above-mentioned AI systems as described below.],
    step-head: (
      [Step],
      [AI system(s) used],
      [Description of how it was used],
    ),
    steps: (
      ideas: [Generation of ideas and conception of the work],
      literature-search: [Literature search],
      literature-analysis: [Literature analysis],
      citation-management: [Literature and citation management],
      methods: [Selection of methods and models],
      data: [Data collection and analysis],
      code: [Generation of program code],
      visualisation: [Creation of visualisations],
      interpretation: [Interpretation and validation],
      structure: [Structuring the text of the work],
      translation: [Translation of text],
      other: [Other],
    ),
    signature: [Signature],
  )

  let t = if language == "en" { en } else { de }

  assert(systems.len() > 0, message: "ai-declaration: `systems` must list at least one AI system")
  for (key, entry) in usage {
    assert(key in t.steps, message: "ai-declaration: unknown usage step `" + key
      + "`, expected one of: " + t.steps.keys().join(", "))
    for field in entry.keys() {
      assert(field in ("systems", "description"), message: "ai-declaration: unknown field `"
        + field + "` in usage step `" + key + "`, expected `systems` or `description`")
    }
  }
  let join-systems(key, s) = (if type(s) == array { s } else { (s,) }).map(x => {
    if type(x) != int { return x }
    assert(x >= 1 and x <= systems.len(), message: "ai-declaration: usage step `" + key
      + "` refers to system " + str(x) + ", but only " + str(systems.len()) + " are listed")
    str(x)
  }).join(", ")

  heading(level: 1, t.heading)

  t.intro

  v(0.6em)

  // Narrow cells with justified text get huge word gaps.
  show table: set par(justify: false)

  // First form: which AI systems were used.
  table(
    columns: (auto, 1fr, 1fr),
    align: left,
    stroke: none,
    inset: (x: 5pt, y: 5pt),
    table.hline(),
    table.header(..t.tool-head.map(strong)),
    table.hline(),
    ..systems.enumerate().map(((i, s)) => {
      let url = s.at("url", default: none)
      ([#(i + 1).], s.name, if url != none { link(url) })
    }).flatten(),
    table.hline(),
  )

  v(0.6em)

  t.further
  list(marker: checked-box, ..t.checks)

  t.usage-intro

  v(0.6em)

  // Second form: how each work step used AI. Rendered smaller, as in the
  // original template.
  {
    set text(size: 9pt)
    table(
      columns: (1.2fr, 1fr, 1.6fr),
      align: left,
      stroke: none,
      inset: (x: 5pt, y: 3.5pt),
      table.hline(),
      table.header(..t.step-head.map(strong)),
      table.hline(),
      ..t.steps.pairs().map(((key, label)) => {
        let entry = usage.at(key, default: (:))
        (label, join-systems(key, entry.at("systems", default: [])), entry.at("description", default: []), table.hline())
      }).flatten(),
    )
  }

  v(0.8em)

  // Date and signature move to the next page together, never split.
  block(breakable: false)[
    #location, #L.date-connector#format-date(date, language)

    #v(1.5cm)

    #line(length: 6cm, stroke: 0.5pt)
    #v(-0.4em)
    #if author != none [#author \ ]
    #text(size: 0.85em, t.signature)
  ]
}
