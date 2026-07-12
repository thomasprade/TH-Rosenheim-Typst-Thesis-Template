// Localized labels for the `thro` thesis template.
// Add further languages by extending the `labels` dictionary.

#let labels = (
  de: (
    contents: "Inhaltsverzeichnis",
    list-of-figures: "Abbildungsverzeichnis",
    list-of-tables: "Tabellenverzeichnis",
    list-of-listings: "Code-Verzeichnis",
    figure: "Abbildung",
    table: "Tabelle",
    listing: "Listing",
    abstract: "Kurzfassung",
    keywords: "Schlüsselwörter",
    declaration-heading: "Eigenständigkeitserklärung / Declaration of Originality",
    by: "von",
    submission-date: "Datum der Abgabe",
    first-supervisor: "Erstprüfer",
    second-supervisor: "Zweitprüfer",
    date-connector: "den ",
    months: (
      "Januar", "Februar", "März", "April", "Mai", "Juni",
      "Juli", "August", "September", "Oktober", "November", "Dezember",
    ),
  ),
  en: (
    contents: "Contents",
    list-of-figures: "List of Figures",
    list-of-tables: "List of Tables",
    list-of-listings: "List of Listings",
    figure: "Figure",
    table: "Table",
    listing: "Listing",
    abstract: "Abstract",
    keywords: "Keywords",
    declaration-heading: "Declaration of Originality",
    by: "by",
    submission-date: "Date of submission",
    first-supervisor: "First examiner",
    second-supervisor: "Second examiner",
    date-connector: "",
    months: (
      "January", "February", "March", "April", "May", "June",
      "July", "August", "September", "October", "November", "December",
    ),
  ),
)

// Format a `datetime` for the given language, e.g.
//   de -> "1. August 2026"
//   en -> "August 1, 2026"
#let format-date(date, language) = {
  let L = labels.at(language)
  let month = L.months.at(date.month() - 1)
  if language == "en" {
    [#month #date.day(), #date.year()]
  } else {
    [#date.day(). #month #date.year()]
  }
}
