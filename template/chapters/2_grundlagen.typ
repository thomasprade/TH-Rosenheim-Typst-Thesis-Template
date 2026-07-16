= Grundlagen

Dieses Kapitel führt die wichtigsten Begriffe ein und ordnet die Arbeit in den
Stand der Technik ein @tanenbaum2011computer.

== Internet der Dinge

Unter dem Internet der Dinge versteht man die Vernetzung physischer Objekte,
die Daten erfassen und austauschen. @tbl-vergleich stellt gängige
Übertragungsprotokolle gegenüber.

#figure(
  table(
    columns: 3,
    align: (left, center, center),
    table.header([*Protokoll*], [*Reichweite*], [*Energiebedarf*]),
    [MQTT], [hoch], [gering],
    [CoAP], [mittel], [gering],
    [HTTP], [hoch], [hoch],
  ),
  caption: [Vergleich gängiger IoT-Übertragungsprotokolle.],
) <tbl-vergleich>

Ein einzelner Sensorknoten ist in @fig-knoten zu sehen. Bei schmalen Abbildungen
kann die Beschriftung auch seitlich neben dem Bild stehen.

#[
  #show figure: it => block(width: 100%, grid(
    columns: (auto, 1fr),
    column-gutter: 1em,
    align: (center + horizon, left + horizon),
    it.body,
    it.caption,
  ))
  #figure(
    image("../assets/th_logo.png", width: 3cm),
    caption: [Schematischer Sensorknoten – eine schmale Abbildung mit seitlich
      stehender Beschriftung, umgesetzt über ein Grid-Layout.],
  ) <fig-knoten>
]

== Softwarearchitektur

Der Prototyp folgt einer schichtenbasierten Architektur. @lst-config zeigt einen
Ausschnitt der Konfiguration.

#figure(
  kind: raw,
  caption: [Beispielhafte Konfiguration des Sensor-Gateways.],
  ```python
  gateway = Gateway(
      protocol="mqtt",
      interval=30,          # Sekunden
      sensors=["temp", "co2", "motion"],
  )
  gateway.connect()
  ```
) <lst-config>

=== Datenhaltung

Die erfassten Messwerte werden in einer Zeitreihendatenbank gespeichert und
für die Auswertung aggregiert.

== Energiemodell

Der Energiebedarf $E$ eines Verbrauchers ergibt sich aus dessen Leistung $P$ und
der Betriebsdauer $t$ gemäß @eq-energie:

$ E = P dot t $ <eq-energie>

Für $n$ Verbraucher folgt daraus der Gesamtbedarf gemäß @eq-gesamt:

$ E_"ges" = sum_(i=1)^n P_i dot t_i . $ <eq-gesamt>

Das Einsparpotenzial einer bedarfsgerechten Steuerung ergibt sich als Verhältnis
des optimierten zum ungeregelten Verbrauch (@eq-eta):

$ eta = 1 - E_"opt" / E_"ges" $ <eq-eta>
