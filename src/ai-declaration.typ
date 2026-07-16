// Declaration on the use of generative AI systems.
//
// A Typst port of the two appendix chapters in the original LaTeX template
// (append.tex). Call `ai-declaration(language: "de")` and/or
// `ai-declaration(language: "en")` inside the `appendix` passed to `thro`.
// Each call produces one appendix chapter (heading + form).

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
    usage: [Die oben genannten KI-Systeme habe ich wie im Folgenden dargestellt
      eingesetzt.],
    step-head: (
      [Arbeitsschritt],
      [Eingesetzte(s) KI-System(e)],
      [Beschreibung der Verwendungsweise],
    ),
    steps: (
      [Generierung von Ideen und Konzeption der Arbeit],
      [Literatursuche],
      [Literaturanalyse],
      [Literaturverwaltung und Zitationsmanagement],
      [Auswahl von Methoden und Modellen],
      [Datensammlung und -analyse],
      [Generierung von Programmcode],
      [Erstellung von Visualisierungen],
      [Interpretation und Validierung],
      [Strukturierung des Texts der Arbeit],
      [Übersetzung des Texts der Arbeit],
      [Sonstiges],
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
    usage: [I have used the above-mentioned AI systems as described below.],
    step-head: (
      [Step],
      [AI system(s) used],
      [Description of how it was used],
    ),
    steps: (
      [Generation of ideas and conception of the work],
      [Literature search],
      [Literature analysis],
      [Literature and citation management],
      [Selection of methods and models],
      [Data collection and analysis],
      [Generation of program code],
      [Creation of visualisations],
      [Interpretation and validation],
      [Structuring the text of the work],
      [Translation of text],
      [Other],
    ),
    signature: [Signature],
  )

  let t = if language == "en" { en } else { de }

  heading(level: 1, t.heading)

  t.intro

  v(0.6em)

  // First form: which AI systems were used.
  table(
    columns: (auto, 1fr, 1fr),
    align: left,
    stroke: none,
    inset: (x: 5pt, y: 5pt),
    table.hline(),
    table.header(..t.tool-head.map(strong)),
    table.hline(),
    [1.], [], [],
    [2.], [], [],
    [3.], [], [],
    table.hline(),
  )

  v(0.6em)

  t.further
  list(marker: checked-box, ..t.checks)

  t.usage

  v(0.6em)

  // Second form: how each work step used AI. Rendered smaller, as in the
  // original template.
  {
    set text(size: 9pt)
    table(
      columns: (1.2fr, 1.4fr, 1.4fr),
      align: left,
      stroke: none,
      inset: (x: 5pt, y: 3.5pt),
      table.hline(),
      table.header(..t.step-head.map(strong)),
      table.hline(),
      ..t.steps.map(s => (s, [], [], table.hline())).flatten(),
    )
  }

  v(0.8em)

  [#location, #L.date-connector#format-date(date, language)]

  v(1.5cm)

  t.signature
}
