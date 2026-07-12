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
