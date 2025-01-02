#import "@preview/tablex:0.0.9": tablex
#import "@preview/dashy-todo:0.0.1": todo

#let vspace = 1fr
#let fill = box(width: 1fr, repeat(sym.space))
#let long-underline = underline(box(width: 1fr, repeat(sym.space)))
#set page(numbering: none)

#heading(numbering: none, outlined: false, "Dokumentārā lapa")

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
  [Autors: *Kristiāns Francis Cagulis, kc22015 ~~\_\_.01.2025.*]

  v(vspace)
  [Rekomendēju darbu aizstāvēšanai\
    Darba vadītājs: *prof. Mg. dat. Jānis Iljins ~~\_\_.01.2025.*]

  v(vspace)
  [Recenzents: *Artūrs Driķis*]


  v(vspace)
  [Darbs iesniegs *\_\_.01.2025.*\
    Kvalifikācijas darbu pārbaudījumu komisijas sekretārs (elektronisks paraksts)
  ]

  v(vspace)
}
