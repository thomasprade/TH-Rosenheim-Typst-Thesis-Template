// Abbreviations for the glossarium package (not a dependency of thro itself;
// only this scaffold uses it). Reference in text with @key (plural @key:pl);
// the first use is spelled out automatically. Before a hyphen write
// #gls("key")-Wort, since @key-Wort would be read as the key "key-Wort".
// Chapters using #gls need `#import "../glossary.typ": gls`.
#import "@preview/glossarium:0.5.10": make-glossary, register-glossary, print-glossary, gls

#let glossary = (
  (key: "iot", short: "IoT", long: "Internet of Things"),
)
