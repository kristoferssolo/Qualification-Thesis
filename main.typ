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

/ ECS: entitāšu komponentu sistēma (angl. Entity-Component-System);
/ PPS: programmatūras prasību specifikācija;
/ Papildspēja: objekts, kas kā spēles mehānika spēlētājam piešķir īslaicīgas priekšrocības vai papildu spējas (angl. power-up);

/* Pēdējos gados spēļu izstrādes joma ir piedzīvojusi strauju popularitātes
* pieaugumu, ko veicināja neatkarīgo spēļu skaita pieaugums un jaudīgu spēļu
* dzinēju pieejamība. Starp šiem dzinējiem Bevy izceļas kā mūsdienīgs atvērtā
* koda risinājums, kas izmanto Rust programmēšanas valodu, lai nodrošinātu
* drošību un veiktspēju. Šajā diplomdarbā tiek pētīts Bevy spēļu dzinēja
* potenciāls, izstrādājot minimālistisku labirinta izpētes spēli "Maze
* Ascension". */

= Ievads
== Nolūks
Šī dokumenta mērķis ir raksturot sešstūru labirinta spēles "Maze Ascension"
programmatūras prasības un izpētīt Bevy spēļu dzinēja iespējas.

== Darbības sfēra
#todo("add first sentence")

Galvenā uzmanība tiek pievērsta tādas galvenās spēles mehānikas izstrādei kā labirinta
ģenerēšana, navigācija, papildspēju (power-up) integrācija un vertikālā
virzība, vienlaikus saglabājot minimālisma estētiku.

Spēles dizaina centrā ir sešstūra formas plāksnes, kas, savukārt, veido sešstūra
formas labirintus, kuri rada atšķirīgu vizuālo un navigācijas izaicinājumu.
Spēlētāju uzdevums ir pārvietoties pa šiem labirintiem, lai sasniegtu katra
līmeņa beigas. Spēlētājiem progresējot, tie sastopas ar arvien sarežģītākiem
labirintiem, kuros nepieciešama stratēģiska domāšana un izpēte. Papildspēju
integrācija piešķir spēlei dziļumu, mudinot spēlētājus izpētīt un eksperimentēt
ar dažādām spēju kombinācijām.

No tehniskā viedokļa šajā darbā tiks aplūkota spēles īstenošana, izmantojot
Bevy entitāšu komponentu sistēmas (ECS) arhitektūru. Tas ietver spēles vides
izveidi, spēles stāvokļu pārvaldību un Bevy funkciju izmantošanu, lai radītu
netraucētu un efektīvu spēles pieredzi.
/* Projekta ietvaros tiks izstrādāts arī lietotāja interfeisa dizains,
* nodrošinot, ka tas ir intuitīvs un pieejams, ar skaidru vizuālu atgriezenisko
* saiti par spēlētāja progresu un savāktajiem papildspēkiem. */

/* Turklāt, lai gan spēlei būs minimālistiska vizuālā izstrāde, darbā netiks
* aplūkotas progresīvas grafikas atveidošanas metodes vai augstas precizitātes
* vizuālie efekti, saglabājot koncentrēšanos uz dizaina vienkāršību un
* skaidrību. */

== Saistība ar citiem dokumentiem
PPS ir izstrādāta, ievērojot LVS 68:1996 "Programmatūras prasību specifikācijas
ceļvedis" un LVS 72:1996 "Ieteicamā prakse programmatūras projektējuma
aprakstīšanai" standarta prasības.

#todo("papildināt dokumentus")

== Pārskats
Dokumenta ievads satur ...

/* Dokumenta ievads satur tā nolūku, izstrādājamās programmatūras skaidrojumu,
vispārīgu programmatūras mērķi un funkciju klāstu, saistību ar citiem
dokumentiem, kuru prasības tika izmantotas dokumenta izstrādāšanas gaitā, kā arī
pārskatu par dokumenta daļu saturu ar dokumenta struktūras skaidrojumu. */

Pirmajā nodaļa tiek aprakstīti ...

Otrajā nodaļā tiek ...

Trešajā nodaļā tiek aprakstīta ...

#set heading(numbering: "1.1.")
= Vispārējais apraksts
== Esošā stāvokļa apraksts
== Pasūtītājs
== Produkta perspektīva
== Darījumprasības
== Sistēmas lietotāji
== Vispārējie ierobežojumi
== Pieņēmumi un atkarības

// Constraints

/* Šis darbs koncentrējas uz viena spēlētāja spēlēšanu, uzsverot
individuālās prasmes un stratēģiju. Daudzspēlētāju funkcionalitāte nav iekļauta
darbības jomā, kas ļauj koncentrēti izpētīt spēles pamatmehāniku. */

/* Attiecībā uz attīstības ierobežojumiem projektu ierobežo pieejamie resursi,
tostarp laiks un tehniskās zināšanas. Tas liek koncentrēties uz būtiskām
funkcijām un mehāniku, nevis uz plašu saturu vai sarežģītām sistēmām. Tiks ņemti
vērā arī Bevy dzinēja ierobežojumi, jo īpaši tādās jomās kā lietotāja interfeisa
izstrāde un aktīvu pārvaldība, kas noteiks dizaina lēmumus un izstrādes procesu. */

/* Visbeidzot, šajā darbā tiek pieņemts, ka spēlētājiem ir pieejamas ierīces, kas
spēj atbalstīt uz Bevy balstītas spēles, un viņiem ir pamatzināšanas par
labirinta navigāciju un mīklu risināšanu. Projekts ir atkarīgs no Bevy spēles
dzinēja nepārtrauktas attīstības un atbalsta, un jebkuras izmaiņas vai
atjauninājumi var ietekmēt spēles attīstību un funkcionalitāti. Skaidri
definējot šīs robežas, darbības joma nodrošina, ka darbs paliek koncentrēts un
pārvaldāms, nodrošinot strukturētu ceļu projekta mērķu sasniegšanai. */


= Programmatūras prasību specifikācija
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
/* Apraksta svarīgākās, sarežģītākās funkcijas vai sistēmas darbības aspektus;
* obligāti  jālieto vismaz 4 dažādi diagrammu veidi, izņemot DPD un lietošanas
* piemēru (use case) diagrammas */
== Daļējs lietotāju saskarņu projektējums
/* 5-7 lietotāja saskarnes un to apraksts */
=== Navigācija
=== Ekrānskati

#heading(
  numbering: none,
  "Izmantotā literatūra un avoti",
)

+ #hyperlink-source(
    [Institūcija "Latvijas standarts".],
    [LVS 68:1996 "Programmatūras prasību specifikācijas ceļvedis". 1996, marts.],
    "",
    datetime(
      year: 2023,
      month: 11,
      day: 20,
    ),
  )

+ #hyperlink-source(
    [Institūcija "Latvijas standarts".],
    [LVS 72:1996 PPS "Ieteicamā prakse programmatūras projektējuma aprakstīšanai". 1996, marts.],
    "",
    datetime(
      year: 2024,
      month: 11,
      day: 04,
    ),
  )

+ #hyperlink-source(
  "", // TODO:
  "Hexagonal Grids from Red Blob Games.",
  "https://www.redblobgames.com/grids/hexagons/",
  datetime(
    year: 2024,
    month: 09,
    day: 10,
  )
)

+ #hyperlink-source(
    "", // TODO:
    "Power-up.",
    "https://en.wikipedia.org/wiki/Power-up",
    datetime(
      year: 2024,
      month: 11,
      day: 04,
    ),
  )


+ #hyperlink-source(
    "", // TODO:
    "Unofficial Bevy Cheat Book.",
    "https://bevy-cheatbook.github.io/",
    datetime(
      year: 2024,
      month: 09,
      day: 10,
    ),
  )

+ #hyperlink-source(
    "Bevy piemēri.",
    "Bevy Examples",
    "https://bevyengine.org/examples/",
    datetime(
      year: 2024,
      month: 09,
      day: 10,
    ),
  )

