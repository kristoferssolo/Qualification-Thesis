#import "layout.typ": project
#import "@preview/i-figured:0.2.4"
#import "@preview/tablex:0.0.9": tablex, rowspanx, colspanx, cellx
#import "utils.typ": *
#import "@preview/wordometer:0.1.3": word-count, total-words
#show: word-count

#show: project.with(
  university: "Latvijas Universitāte",
  faculty: "Eksakto zinātņu un tehnoloģiju fakultāte",
  type: "Kvalifikācijas darbs",
  title: [Spēles izstrāde, izmantojot Bevy spēļu dzinēju],
  authors: ("Kristiāns Francis Cagulis, kc22015",),
  advisor: "prof. Mg. dat. Jānis Iljins",
  date: "Rīga 2025",
)
#set heading(numbering: none)
= Apzīmējumu saraksts

/ DPD: datu plūsmas diagramma;
/ ECS: entitāšu komponentu sistēma (angl. Entity-Component-System);
/ PPA: programmatūras projektējuma apraksts;
/ PPS: programmatūras prasību specifikācija;
/ Papildspēja: objekts, kas kā spēles mehānika spēlētājam piešķir īslaicīgas priekšrocības vai papildu spējas (angl. power-up#footnote[https://en.wikipedia.org/wiki/Power-up]<power-up>);
/ Spēlētājs: lietotāja ieraksts vienas virtuālās istabas kontekstā.

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
#lorem(100)
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
ceļvedis"@lvs_68 un LVS 72:1996 "Ieteicamā prakse programmatūras projektējuma
aprakstīšanai"@lvs_72 standarta prasības.

#todo("papildināt dokumentu sarakstu")

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
Pašreizējo spēļu izstrādes ainavu raksturo pieaugoša interese par neatkarīgajām
spēlēm un modernu, efektīvu spēļu dzinēju izmantošana. Izstrādātāji arvien
biežāk meklē rīkus, kas piedāvā elastību, veiktspēju un lietošanas ērtumu. Spēļu
dzinējs Bevy ar savu moderno arhitektūru un Rust programmēšanas valodas
izmantošanu gūst arvien lielāku popularitāti izstrādātāju vidū, pateicoties tā
drošības un laiksakritība funkcijām.

== Pasūtītājs
Sistēma nav izstrādāta pēc konkrēta pasūtītāja pieprasījuma, tā ir raksturota un
projektēta ar iespēju realizēt pēc studenta iniciatīvas kvalifikācijas darba
ietvaros.

== Produkta perspektīva
"Maze Ascension" ir izstrādāta kā daudzplatformu spēle, izmantojot nepārtrauktas
integrācijas un nepārtrauktas izvietošanas (CI/CD) _pipeline_
#todo("check CI/CD pipeline translation"), lai racionalizētu
izstrādes un izplatīšanas procesu. Šis _pipeline_ ir konfigurēts tā, lai kompilētu
spēli vairākām platformām, tostarp Linux, macOS, Windows un WebAssembly (Wasm).
Tas nodrošina, ka spēle ir pieejama plašai auditorijai, nodrošinot konsekventu
un saistošu pieredzi dažādās operētājsistēmās un vidēs.

Spēle tiek izplatīta, izmantojot #todo("GitHub releases") un #link("http://itch.io/")[itch.io], kas ir populāra neatkarīgo spēļu
platforma, kas ļauj viegli piekļūt un izplatīt spēli visā pasaulē.
Izmantojot šīs platformas, datorspēle gūst dažādu maksājumu modeļu un kopienas
iesasaistes funkcijas, tādējādi palielinot spēles sasniedzamību un atpazīstamību.

/* Lai gan spēle neizmanto mākoņpakalpojumus datu uzglabāšanai vai
analīzei, CI/CD cauruļvads nodrošina, ka atjauninājumus un jaunas funkcijas var
izvietot efektīvi un droši. Šāda konfigurācija ļauj ātri veikt iterāciju un
nepārtraukti uzlabot spēli, nodrošinot, ka spēlētājiem vienmēr ir pieejama
jaunākā versija ar jaunākajiem uzlabojumiem un kļūdu labojumiem. */

== Darījumprasības
Sistēmas izstrādē galvenā uzmanība tiks pievērsta sekojošu darījumprasību
īstenošanai, lai nodrošinātu stabilu un saistošu lietotāja pieredzi:

+ Spēles progresēšana un līmeņu pārvaldība: Sistēma automātiski pārvaldīs spēlētāju virzību pa spēles līmeņiem, nodrošinot vienmērīgu pāreju, kad spēlētāji progresē un saskaras ar jauniem izaicinājumiem.
  Progress tiks saglabāts lokāli spēlētāja ierīcē.
+ Nevainojama piekļuve spēlēm: Spēlētāji varēs piekļūt spēlei un spēlēt to bez nepieciešamības izveidot lietotāja kontu vai pieteikties. Tas nodrošina netraucētu piekļuvi spēlei, ļaujot spēlētājiem nekavējoties sākt spēlēt.
// + Paziņošanas sistēma: Spēlētāji saņems paziņojumus par svarīgiem spēles atjauninājumiem, sasniegumiem un citu svarīgu informāciju, lai saglabātu viņu iesaisti un informētību.
+ Savietojamība ar vairākām platformām: sistēma būs pieejama vairākās platformās, tostarp Linux, macOS, Windows un WebAssembly, nodrošinot plašu pieejamību un sasniedzamību.
+ Kopienas iesaiste: Spēle izmantos #link("http://itch.io/")[itch.io] kopienas funkcijas, lai sadarbotos ar spēlētājiem, apkopotu atsauksmes un veicinātu atbalstošu spēlētāju kopienu.
+ Regulāri atjauninājumi un uzturēšana: CI/CD _pipeline_ veicinās regulārus atjauninājumus un uzturēšanu, nodrošinot, ka spēle ir atjaunināta ar jaunākajām funkcijām un uzlabojumiem.

== Sistēmas lietotāji
Sistēma ir izstrādāta, ņemot vērā vienu lietotāja tipu -- spēlētājs. Spēlētāji
ir personas, kas iesaistās spēlē, lai pārvietotos pa tās labirinta struktūrām.
Tā kā spēlei nav nepieciešami lietotāja konti vai autentifikācija, visiem
spēlētājiem ir vienlīdzīga piekļuve spēles funkcijām un saturam no spēles sākuma
brīža.

/* "Sistēma" lietotājs ir atbildīgs par notikumu apstrādātāju izsaukšanu, kas
nepieciešams automātiskai spēles gaitas pārvaldībai. */

Ar lietotājiem saistītās datu plūsmas ir attēlotas sistēmas nultā līmeņa DPD
(skat. @fig:dpd-0 att.)

#figure(
  caption: "0. līmeņa DPD",
  image("assets/images/dpd/dpd0.jpg"),
) <dpd-0>

== Vispārējie ierobežojumi
+ Izstrādes vides un tehnoloģijas ierobežojumi:
  + Programmēšanas valodas un Bevy spēles dzinēja tehniskie ierobežojumi;
  + Responsivitāte;
  + Starpplatformu savietojamība: Linux, macOS, Windows un WebAssembly.
// + Izplatīšanas un izvietošanas ierobežojumi:
//   + CI/CD _pipeline_.

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
#figure(
  caption: "1. līmeņa DPD",
  image("assets/images/dpd/dpd1.jpg"),
) <dpd-1>

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

#bibliography(
  title: "Izmantotā literatūra un avoti",
  "bibliography.yml",
)

#pagebreak()
#todo[#total-words words]
