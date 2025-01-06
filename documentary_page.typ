#import "@preview/tablex:0.0.9": tablex
#import "src/layout.typ": project, indent-par
#import "src/layout.typ": indent

#set page(
  margin: (
    left: 30mm,
    right: 20mm,
    top: 20mm,
    bottom: 20mm,
  ),
  number-align: center,
  paper: "a4",
)
#set text(
  font: "Times New Roman",
  size: 12pt,
  hyphenate: auto,
  lang: "lv",
  region: "lv",
)

#set par(
  justify: true,
  leading: 1.5em,
  first-line-indent: indent,
  spacing: 1.5em,
)
#show heading: set block(spacing: 1.5em)
#show heading: it => {
  if it.level == 1 {
    pagebreak(weak: true)
    text(
      14pt,
      align(
        center,
        upper(it),
      ),
    )
  } else {
    text(12pt, it)
  }
  ""
  v(-1cm)
}

#let vspace = 1fr
#let fill = box(width: 1fr, repeat(sym.space))
#let long-underline = underline(box(width: 1fr, repeat(sym.space)))
#set page(numbering: none)

#heading(level: 1, outlined: false, numbering: none, "Dokumentārā lapa")

Kvalifikācijas darbs "*Spēles izstrāde, izmantojot Bevy spēļu dzinēju*" ir
izstrādāts Latvijas Universitātes Eksakto zinātņu un tehnoloģiju fakultātē,
Datorikas nodaļā.

#v(vspace / 3)
Ar savu parakstu apliecinu, ka darbs izstrādāts patstāvīgi, izmantoti tikai tajā
norādītie informācijas avoti un iesniegtā darba elektroniskā kopija atbilst
izdrukai un/vai recenzentam uzrādītajai darba versijai.


#context {
  set par(
    first-line-indent: 1cm,
    hanging-indent: 1cm,
  )

  v(vspace / 2)
  [Autors: *Kristiāns Francis Cagulis, kc22015 ~~06.01.2025.*]

  v(vspace)
  [Rekomendēju darbu aizstāvēšanai\
    Darba vadītājs: *Mg. dat. Jānis Iljins ~~06.01.2025.*]

  v(vspace)
  [Recenzents: *Artūrs Driķis*]


  v(vspace)
  [Darbs iesniegs *06.01.2025.*\
    Kvalifikācijas darbu pārbaudījumu komisijas sekretārs (elektronisks paraksts)
  ]

  v(vspace)
}
