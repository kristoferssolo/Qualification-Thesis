#import "layout.typ": project
#import "@preview/i-figured:0.2.4"
#import "@preview/tablex:0.0.9": tablex, rowspanx, colspanx, cellx
#import "utils.typ": *


#show: project.with(
  university: "Latvijas Universitāte",
  faculty: "Eksakto zinātņu un tehnoloģiju fakultāte",
  title: [Spēles izstrāde, izmantojot Bevy spēļu dzinēju],
  authors: ("Kristiāns Francis Cagulis, kc22015",),
  advisor: "prof. Mg. dat. Jānis Iljins",
  date: "Rīga 2025",
)

#set heading(numbering: none)

= Apzīmējumu saraksts
= Ievads
== Nolūks
== Saistība ar citiem dokumentiem
== Pārskats
#set heading(numbering: "1.1.")
= Vispārējais apraksts
== Esošā stāvokļa apraksts
== Pasūtītājs
== Produkta perspektīva
== Darījumprasības
== Sistēmas lietotāji
== Vispārējie ierobežojumi
== Pieņēmumi un atkarības
= Programmatūras prasību specifikācija
== Konceptuālais datu bāzes apraksts
== Funkcionālās prasības
== Nefunkcionālās prasības
=== Veiktspējas prasības
==== Statiskā veiktspēja
==== Dinamiskā veiktspēja
=== Atribūti
==== Izmantojamība
==== Mērogojamība
==== Drošība
==== Uzturamība
==== Pārnesamība
=== Projekta ierobežojumi
==== Intelektuālā īpašuma tiesības
==== Aparatūras ierobežojumi
===== Atbalstītās ierīces
===== Serveris un mitināšana
=== Ārējās saskarnes prasības
==== Lietotāja saskarne
==== Sakaru saskarne
= Programmatūras projektējuma apraksts
== Daļējs funkciju projektējums
/* Apraksta svarīgākās, sarežģītākās funkcijas vai sistēmas darbības aspektus; obligāti  jālieto vismaz 4 dažādi diagrammu veidi, izņemot DPD un lietošanas piemēru (use case) diagrammas */
== Daļējs lietotāju saskarņu projektējums
/* 5-7 lietotāja saskarnes un to apraksts */
=== Navigācija
=== Ekrānskati
#heading(numbering: none, "Izmantotā literatūra un avoti")
+ #hyperlink-source(
    "Eiropas Parlaments.",
    "Vispārēja datu aizsardzības regula (angl. GDPR). 2016, aprīlis.",
    "https://eur-lex.europa.eu/legal-content/LV/TXT/PDF/?uri=CELEX:32016R0679",
    datetime(
      year: 2023,
      month: 11,
      day: 20,
    ),
  )

