// Default content for the declaration-of-originality page.
// The `default-declaration` output can be overridden entirely via the
// `declaration-of-originality` parameter of `thro`.

#import "i18n.typ": labels, format-date

// Optional credit note (disabled by default via `show-template-credit: false`).
#let template-credit(language: "de") = {
  if language == "en" [
    This thesis was prepared using the LaTeX template _Dokumentvorlage
    Abschlussarbeit_ provided on the university's website, later ported to Typst.

    Many thanks to Prof. Dr. Jochen Schmidt for creating the original template.
  ] else [
    Diese Arbeit wurde auf Basis der LaTeX-Vorlage _Dokumentvorlage
    Abschlussarbeit_ erstellt, welche auf der Website der Hochschule zur
    Verfügung gestellt und später nach Typst portiert wurde.

    Vielen Dank an Prof. Dr. Jochen Schmidt für die Erstellung der
    ursprünglichen Vorlage.
  ]
}

// The default declaration text reproduces the wording of the original
// LaTeX template (title.tex). The German and English variants are always
// shown together; `language` only controls the closing date line.
#let default-declaration(
  author-name: "",
  location: [Rosenheim],
  date: datetime.today(),
  language: "de",
) = {
  let L = labels.at(language)

  [
    Hiermit bestätige ich, dass ich die vorliegende Arbeit selbständig verfasst
    und keine anderen als die angegebenen Hilfsmittel benutzt habe. Die Stellen
    der Arbeit, die dem Wortlaut oder dem Sinn nach anderen Werken (dazu zählen
    auch Internetquellen) entnommen sind, wurden unter Angabe der Quelle
    kenntlich gemacht.
  ]

  v(0.8em)

  emph[
    I declare that I have authored this thesis independently, that I have not
    used other than the declared sources / resources, and that I have explicitly
    marked all material which has been quoted either literally or by content
    from the used sources.
  ]

  v(1.5em)

  [#location, #L.date-connector#format-date(date, language)]

  v(2cm)

  author-name
}
