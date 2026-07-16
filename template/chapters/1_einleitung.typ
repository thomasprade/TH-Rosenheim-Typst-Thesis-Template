= Einleitung

Die Digitalisierung von Gebäuden schreitet stetig voran. Vernetzte Sensoren und
Aktoren ermöglichen eine bedarfsgerechte Steuerung von Heizung, Lüftung und
Beleuchtung. Das Internet der Dinge (IoT) bildet dafür die technische
Grundlage @atzori2010iot.

== Motivation

Ein erheblicher Anteil des Energieverbrauchs in Gebäuden entfällt auf Zeiten, in
denen Räume ungenutzt sind. Eine intelligente Steuerung kann hier ansetzen und
den Verbrauch senken, ohne den Komfort der Nutzer zu beeinträchtigen.

@fig-overview zeigt schematisch den Aufbau des betrachteten Systems.

#figure(
  image("../assets/th_logo.png", width: 60%),
  caption: [Schematische Übersicht der IoT-Lösung.],
) <fig-overview>

Zum Vergleich zeigt @fig-vergleich den Ausgangs- und den optimierten Zustand als
zwei Teil-Abbildungen nebeneinander.

#figure(
  grid(
    columns: (1fr, 1fr),
    column-gutter: 1.5em,
    row-gutter: 0.6em,
    align: center,
    image("../assets/th_logo.png", width: 90%),
    image("../assets/th_logo.png", width: 90%),
    [(a) Ausgangszustand], [(b) Optimierter Zustand],
  ),
  caption: [Zwei Betriebszustände nebeneinander, dargestellt als Teil-Abbildungen
    (a) und (b) über ein Grid-Layout.],
) <fig-vergleich>

== Zielsetzung

Ziel der Arbeit ist es, verschiedene Steuerungsansätze zu vergleichen und einen
funktionsfähigen Prototyp zu entwickeln.

=== Forschungsfragen

Im Zentrum stehen die folgenden Fragen zur Wirksamkeit und Übertragbarkeit der
entwickelten Lösung.

=== Aufbau der Arbeit

Kapitel 2 legt die Grundlagen, die folgenden Kapitel behandeln Umsetzung und
Auswertung.
