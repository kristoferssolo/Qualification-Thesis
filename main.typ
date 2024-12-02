#import "@preview/dashy-todo:0.0.1": todo
#import "@preview/i-figured:0.2.4"
#import "@preview/tablex:0.0.9": tablex, rowspanx, colspanx, cellx
#import "@preview/wordometer:0.1.3": word-count, total-words
#import "layout.typ": project, indent-par
#import "utils.typ": *
#show: word-count

#show: project.with(
  university: "Latvijas Universitāte",
  faculty: "Eksakto zinātņu un tehnoloģiju fakultāte",
  type: "Kvalifikācijas darbs",
  title: [Spēles izstrāde, izmantojot\ Bevy spēļu dzinēju],
  authors: ("Kristiāns Francis Cagulis, kc22015",),
  advisor: "prof. Mg. dat. Jānis Iljins",
  date: "Rīga 2025",
)
#set heading(numbering: none)
= Apzīmējumu saraksts

/ Audio: Skaņas komponentes, kas ietver gan skaņas efektus, gan fona mūziku.
/ CI/CD: nepārtraukta integrācija un nepārtraukta izvietošana;
/ DPD: datu plūsmas diagramma;
/ ECS: entitāšu komponentu sistēma (angl. Entity-Component-System#footnote[https://en.wikipedia.org/wiki/Entity_component_system]);
/ GitHub#footnote[https://en.wikipedia.org/wiki/GitHub]: izstrādātāju platforma, kas ļauj izstrādātājiem izveidot, glabāt, pārvaldīt un kopīgot savu kodu;
/ Jaucējtabula#footnote[https://lv.wikipedia.org/wiki/Jauc%C4%93jtabula]: jeb heštabula (angl. hash table#footnote[https://en.wikipedia.org/wiki/Hash_table]) ir datu struktūra, kas saista identificējošās vērtības ar piesaistītajām vērtībām.
/ Laidiens: Programmatūras versija, kas ir gatava izplatīšanai lietotājiem un satur īpašas funkcijas, uzlabojumus vai labojumus.
/ PPA: programmatūras projektējuma apraksts;
/ PPS: programmatūras prasību specifikācija;
/ Papildspēja: objekts, kas kā spēles mehānika spēlētājam piešķir īslaicīgas priekšrocības vai papildu spējas (angl. power-up#footnote[https://en.wikipedia.org/wiki/Power-up]<power-up>);
/ Pirmkods: Cilvēkam lasāmas programmēšanas instrukcijas, kas nosaka programmatūras darbību.
/ Renderēšana: Process, kurā tiek ģenerēts vizuāla izvade.
/ Sēkla: Skaitliska vērtība, ko izmanto nejaušo skaitļu ģeneratora inicializēšanai.
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

== Darbības sfēra
Darba galvenā uzmanība ir vērsta uz būtisku spēles mehāniku ieviešanu, tostarp
procedurālu labirintu ģenerēšanu, spēlētāju navigācijas sistēmu, papildspēju
integrāciju un vertikālās progresijas mehāniku, vienlaikus ievērojot minimālisma
dizaina filozofiju.

Spēles pamatā ir sešstūra formas plāksnes, kas, savukārt, veido sešstūra
formas labirintus, kuri rada atšķirīgu vizuālo un navigācijas izaicinājumu.
Spēlētāju uzdevums ir pārvietoties pa šiem labirintiem, lai sasniegtu katra
līmeņa beigas. Spēlētājiem progresējot, tie sastopas ar arvien sarežģītākiem
labirintiem, kuros nepieciešama stratēģiska domāšana, izpēte un papildspēju
izmantošana.

Spēlētājam progresējot, tie sastopas ar dažādiem uzlabojumiem un
papildspējām, kas stratēģiski izvietoti labirintos. Šī funkcija padziļina spēlēšanas
pieredzi, veicinot izpēti un eksperimentēšanu ar dažādām spēju kombinācijām,
radot dinamiskākus un aizraujošākus spēles scenārijus.

No tehniskā viedokļa darbā tiek pētīta šo funkciju īstenošana, izmantojot
Bevy entitāšu komponentu sistēmas (ECS) arhitektūru. Tas ietver stabilu spēles vides
sistēmu izstrādi, stāvokļa pārvaldības mehānismus un efektīvu Bevy iebūvēto
funkcionalitāšu izmantošanu.

No darbības sfēras apzināti izslēgta daudzspēlētāju funkcionalitāte un sarežģīti
grafiskie efekti, koncentrējoties uz pulētu viena spēlētāja pieredzi ar skaidru,
minimālistisku vizuālo noformējumu. Šāda mērķtiecīga pieeja ļauj padziļināti
izpētīt spēles pamatmehāniku, vienlaikus nodrošinot projekta vadāmību un
tehnisko iespējamību.

== Saistība ar citiem dokumentiem
PPS ir izstrādāta, ievērojot LVS 68:1996 "Programmatūras prasību specifikācijas
ceļvedis"@lvs_68 un LVS 72:1996 "Ieteicamā prakse programmatūras projektējuma
aprakstīšanai"@lvs_72 standarta prasības.

== Pārskats
Dokumenta ievads satur ...

/* Dokumenta ievads satur tā nolūku, izstrādājamās programmatūras skaidrojumu,
vispārīgu programmatūras mērķi un funkciju klāstu, saistību ar citiem
dokumentiem, kuru prasības tika izmantotas dokumenta izstrādāšanas gaitā, kā arī
pārskatu par dokumenta daļu saturu ar dokumenta struktūras skaidrojumu. */

Pirmajā nodaļa tiek aprakstīti ...

Otrajā nodaļā tiek ...

Trešajā nodaļā tiek aprakstīta ...

#todo("uzrakstīt dokumenta pārskatu")

#set heading(numbering: "1.1.")
= Vispārējais apraksts
== Esošā stāvokļa apraksts
Pašreizējo spēļu izstrādes ainavu raksturo pieaugoša interese pēc neatkarīgajām
spēlēm un modernu, efektīvu spēļu dzinēju izmantošana. Izstrādātāji arvien
biežāk meklē rīkus, kas piedāvā elastību, veiktspēju un lietošanas ērtumu. Spēļu
dzinējs Bevy ar savu moderno arhitektūru un Rust programmēšanas valodas
izmantošanu gūst arvien lielāku popularitāti izstrādātāju vidū, pateicoties tā
drošām un vienlaicīgām funkcijām.

== Pasūtītājs
Sistēma nav izstrādāta pēc konkrēta pasūtītāja pieprasījuma, tā ir raksturota un
projektēta ar iespēju realizēt pēc studenta iniciatīvas kvalifikācijas darba
ietvaros.

== Produkta perspektīva
"Maze Ascension" ir izstrādāta kā daudzplatformu spēle, izmantojot nepārtrauktas
integrācijas un nepārtrauktas izvietošanas (CI/CD) darbplūsma@pipeline, lai
vienkāršotu izstrādes un izplatīšanas procesu.
Šī darbplūsma ir konfigurēts tā, lai kompilētu spēli vairākām platformām,
tostarp Linux, macOS, Windows un WebAssembly (WASM).
Tas nodrošina, ka spēle ir pieejama plašai auditorijai, nodrošinot konsekventu
un saistošu pieredzi dažādās operētājsistēmās un vidēs.

Spēle tiek izplatīta, izmantojot "GitHub
releases"@gh-release un itch.io#footnote("https://itch.io/")<itch-io>, kas ir
populāra neatkarīgo spēļu platforma, kas ļauj viegli piekļūt un izplatīt spēles
visā pasaulē. Izmantojot šīs platformas, datorspēle gūst dažādu maksājumu modeļu
un kopienas iesasaistes funkcijas, tādējādi palielinot spēles sasniedzamību un
atpazīstamību.

/* Lai gan spēle neizmanto mākoņpakalpojumus datu uzglabāšanai vai
analīzei, CI/CD cauruļvads nodrošina, ka atjauninājumus un jaunas funkcijas var
izvietot efektīvi un droši. Šāda konfigurācija ļauj ātri veikt iterāciju un
nepārtraukti uzlabot spēli, nodrošinot, ka spēlētājiem vienmēr ir pieejama
jaunākā versija ar jaunākajiem uzlabojumiem un kļūdu labojumiem. */

== Darījumprasības
Sistēmas izstrādē galvenā uzmanība tiks pievērsta sekojošu darījumprasību
īstenošanai, lai nodrošinātu stabilu un saistošu lietotāja pieredzi:

+ Spēles progresēšana un līmeņu pārvaldība: Sistēma automātiski pārvaldīs
  spēlētāju virzību pa spēles līmeņiem, nodrošinot vienmērīgu pāreju, kad
  spēlētāji progresē un saskaras ar jauniem izaicinājumiem. Progress tiks
  saglabāts lokāli spēlētāja ierīcē.
+ Nevainojama piekļuve spēlēm: Spēlētāji varēs piekļūt spēlei un spēlēt to bez
  nepieciešamības izveidot lietotāja kontu vai pieteikties. Tas nodrošina
  netraucētu piekļuvi spēlei, ļaujot spēlētājiem nekavējoties sākt spēlēt.
// + Paziņošanas sistēma: Spēlētāji saņems paziņojumus par svarīgiem spēles
// atjauninājumiem, sasniegumiem un citu svarīgu informāciju, lai saglabātu viņu
// iesaisti un informētību.
+ Savietojamība ar vairākām platformām: sistēma būs pieejama vairākās
  platformās, tostarp Linux, macOS, Windows un WebAssembly, nodrošinot plašu
  pieejamību un sasniedzamību.
+ Kopienas iesaiste: Spēle izmantos itch.io@itch-io kopienas
  funkcijas, lai sadarbotos ar spēlētājiem, apkopotu atsauksmes un veicinātu
  atbalstošu spēlētāju kopienu.
+ Regulāri atjauninājumi un uzturēšana: CI/CD cauruļvadu veicinās regulārus
  atjauninājumus un uzturēšanu, nodrošinot, ka spēle ir atjaunināta ar jaunākajām
  funkcijām un uzlabojumiem.

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
  caption: [\0. līmeņa DPD],
  image("assets/images/dpd/dpd0.svg"),
) <dpd-0>

== Vispārējie ierobežojumi
+ Izstrādes vides un tehnoloģijas ierobežojumi:
  + Programmēšanas valodas un Bevy spēles dzinēja tehniskie ierobežojumi;
  + Responsivitāte;
  + Starpplatformu savietojamība: Linux, macOS, Windows un WebAssembly.
// + Izplatīšanas un izvietošanas ierobežojumi:
//   + CI/CD darbplūsma.

== Pieņēmumi un atkarības
- Tehniskie pieņēmumi:
  - Spēlētāja ierīcei jāatbilst minimālajām aparatūras prasībām, lai varētu
    palaist uz Bevy spēles dzinēja balstītas spēles.
  - ierīcei jāatbalsta WebGL2#footnote("https://registry.khronos.org/webgl/specs/latest/2.0/"),
    lai nodrošinātu pareizu atveidošanu @webgl2.
- tīmekļa spēļu spēlēšanai (WebAssembly versija) pārlūkprogrammai jābūt mūsdienīgai un saderīgai ar WebAssembly.
- ekrāna izšķirtspējai jābūt vismaz 800x600 pikseļu, lai spēle būtu optimāla.
- Veiktspējas atkarība:
  - Spēle ir atkarīga no Bevy spēles dzinēja (0.14).
- Veiksmīga kompilēšana un izvietošana ir atkarīga no CI/CD darbplūsmai saderības ar:
  - Linux kompilācijām;
  - macOS kompilācijām;
  - Windows kompilācijām;
  - WebAssembly kompilāciju.
- Izplatīšanas atkarības:
  - Pastāvīga itch.io@itch-io platformas pieejamība spēļu izplatīšanai.
  - CI/CD darbplūsmai nepieciešamo kompilēšanas rīku un atkarību uzturēšana.
- Izstrādes atkarības:
  - Rust programmēšanas valoda (stabilā versija);
  - "Cargo" pakešu pārvaldnieks;
  - Nepieciešamie Bevy spraudņi un atkarības, kā norādīts projekta "Cargo.toml" failā.
- Lietotāja vides pieņēmumi:
  - Spēlētājiem ir pamata izpratne par labirinta navigāciju un mīklu risināšanas koncepcijām.
  - Lietotāji var piekļūt un lejupielādēt spēles no itch.io@itch-io platformas.
  - Spēlētājiem ir ievadierīces (tastatūra/pele), ar kurām kontrolēt spēli.

= Programmatūras prasību specifikācija
== Funkcionālās prasības
\1. līmeņa datu plūsmas diagramma (skat. @fig:dpd-1 att.) ilustrē galvenos
procesus spēles "Maze Ascension" sistēmā.
Diagrammā attēloti septiņi galvenie procesi:
ievades apstrādāšanas modulis,
spēles stāvokļa pārvalības modulis,
spēlētāja modulis,
labirinta ģenerēšanas modulis,
spēles līmeņu pārvaldības modulis,
atveidošanas jeb renderēšanas un skaņas jeb audio moduļi.
Šie procesi mijiedarbojas ar vienu datu krātuvi -- operatīvo atmiņu (RAM) -- un vienu
ārējo lietotāju -- spēlētājs.

Ievades apstrādes modulis uztver un apstrādā spēlētāja ievades datus.
Spēles stāvokļa modulis pārrauga vispārējo spēles stāvokli.
Labirinta ģeneratora modulis izveido un pārvalda labirinta struktūras.
Spēlētāja modulis apstrādā visas ar spēlētāju saistītās kustības, sadursmes un papildspēju mijiedarbības.
Spēles līmeņu pārvaldnieks kontrolē līmeņu virzību un stāvokli.
Renderēšanas un audio moduļi pārvalda attiecīgi vizuālo un audio izvadi.

// Visas datu plūsmas starp procesiem tiek nodrošinātas, izmantojot operatīvo
// atmiņu, ievērojot atbilstošas datu plūsmas diagrammas konvencijas. Šī
// arhitektūra nodrošina efektīvu datu pārvaldību un skaidru interešu nodalīšanu
// starp dažādām spēles sastāvdaļām.

#figure(
  caption: [\1. līmeņa DPD],
  image("assets/images/dpd/dpd1.svg"),
) <dpd-1>


=== Funkciju sadalījums moduļos
Tabulā @tbl:function-modules ir sniegts visaptverošs spēles funkcionalitātes
sadalījums pa tās galvenajiem moduļiem. Katram modulim ir noteikti konkrēti
pienākumi, un tas ietver funkcijas, kas veicina kopējo spēles sistēmu.

#figure(
  caption: "Funkciju sadalījums pa moduļiem",
  kind: table,
  tablex(
    columns: (auto, 1fr, auto),
    /* --- header --- */
    [*Modulis*], [*Funkcija*], [*Identifikators*],
    /* -------------- */
    rowspanx(3)[Ievades apstrādes modulis],
    [Ievades notikumu apstrāde], [],
    [Ievades stāvokļa atjaunināšana], [],
    [Ievades validācija], [],

    rowspanx(4)[Spēles stāvokļa pārvaldības modulis],
    [Spēļu stāvokļa pārvaldība], [],
    [Spēles cilpas pārvaldība], [],
    [Stāvokļu pāreju apstrāde], [],
    [Spēles notikumu apstrāde], [],

    rowspanx(4)[Spēlētāja modulis],
    [Kustības vadība], [],
    [Sadursmju apstrāde], [],
    [Papildsēju pārvaldība], [],
    [Spēlētāju stāvokļa atjaunināšana], [],

    rowspanx(1)[Labirinta ģenerēšanas modulis],
    [Labirinta būvētājs], [#link(<LGMF01>)[LGMF01]],

    rowspanx(5)[Līmeņu pārvaldības modulis],
    [Līmeņu ielāde], [],
    [Progresa izsekošana], [],
    [Pāreju apstrāde], [],
    [Stāvokļa saglabāšana], [],
    [Stāvokļa ielāde], [],

    rowspanx(4)[Renderēšanas modulis],
    [Labirinta renderēšana], [],
    [Spēlētāja renderēšana], [],
    [Lietotājsaskarnes renderēšana], [],
    [Vizuālo efektu renderēšana], [],

    rowspanx(3)[Audio modulis],
    [Skaņas efektu atskaņošana], [],
    [Mūzikas pārvaldība], [],
    [Audio stāvokļu apstrāde], [],
  ),
) <function-modules>

=== Ievades apstrādes modulis
#todo("uzrakstīt ievades apstrādes moduli")
=== Spēles stāvokļa pārvaldības modulis
#todo("uzrakstīt spēles stāvokļa pārvaldības moduli")
=== Spēlētāja modulis
#todo("uzrakstīt spēlētāja moduli")
=== Labirinta ģenerēšanas modulis
#todo("uzrakstīt labirinta ģenerēšanas moduli")

Apakšnodaļa ietver labirinta moduļa funkcijas. Moduļa funkcionalitāte ir
izmantota sešstūraina labirinta ģenerēšanai.
Moduļa funkciju datu
plūsmas ir parādītas 2. līmeņa datu plūsmas diagrammā (skat. @dpd-2-maze-gen att.)
Labirinta būvēšanas funkcija ir aprakstītas atsevišķā tabulā (skat.
#link(<LGMF01>)[LGMF01] tab.)

Modularitātes un atkārtotas lietojamības apsvērumu dēļ labirinta ģenerēšanas
funkcionalitāte tika pārnesta uz ārēju bibliotēku "hexlib"@hexlab. Šis lēmums
ļauj labirinta ģenerēšanas loģiku atkārtoti izmantot dažādos projektos un
lietojumprogrammās, veicinot atkārtotu koda izmantošanu.
Iekapsulējot labirinta ģenerēšanu atsevišķā bibliotēkā, to ir vieglāk pārvaldīt
un atjaunināt neatkarīgi no galvenās lietojumprogrammas, nodrošinot, ka
labirinta ģenerēšanas algoritma uzlabojumus vai izmaiņas var veikt, neietekmējot
programmu.

#figure(
  caption: [Labirinta ģenerēšanas moduļa 2. līmeņa DPD],
  image("assets/images/dpd/dpd2/maze-gen.svg"),
) <dpd-2-maze-gen>

#function-table(
  "Labirinta būzētājs",
  "LGMF01",
  [Izveido sešstūrainu labirintu ar norādītajiem parametriem.],
  [
    + Rādiuss -- Labirinta rādiuss. Obligāts parametrs, kas nosaka labirinta izmēru.
    + Sēkla -- Neobligāta sēkla nejaušo skaitļu ģeneratoram. Ja
      norādīta, nodrošina reproducējamu labirinta ģenerēšanu ar vienādiem
      parametriem. Ja nav norādīta, tiek izmantota nejauša sēkla.
    + Sākuma pozīcija -- Neobligāta sākotnējā pozīcija labirintā.
      Ja norādīta, labirinta ģenerēšana sāksies no šīs pozīcijas. Ja nav norādīta,
      tiek izvēlēta nejauša derīga sākuma pozīcija.
    // + Ģeneratora tips: `GeneratorType` -- Algoritms, kas tiks izmantots
    //   labirinta ģenerēšanai. Pašlaik pieejams tikai RecursiveBacktracking.
  ],
  [
    + Validē ievades parametrus:
      + Pārbauda rādiusa esamību un derīgumu;
      + Validē sākuma pozīciju, ja tāda norādīta;
    + Izveido sākotnējo labirinta struktūru:
      + Inicializē tukšu labirintu ar norādīto rādiusu;
      + Katrai šūnai iestata sākotnējās (visas) sienas.
    + Validē stākuma prozīciju, ja tāda norādīta.
    + Ģenerē labirintu:
      + Rekursīvi izveido ceļus, noņemot sienas starp šūnām;
      + Izmanto atpakaļizsekošanu, kad sasniegts strupceļš.
  ],
  [
    + Jaucējtabulu, kas satur:
      + Sešstūra koordinātes kā atslēgās;
      + Sešstūra objekti ar:
        + Pozīcijas koordinātēm ($x$, $y$);
        + Sienu konfigurāciju (8-bitu maska).
  ],
  [
    + Lai izveidotu labirintu, ir jānorāda rādiuss.
    + Sākuma pozīcija ir ārpus labirinta robežām.
    + Neizdevās izveidot labirintu.
  ],
) <LGMF01>


=== Līmeņu pārvaldības modulis
#todo("uzrakstīt līmeņu pārvaldības moduli")
=== Renderēšanas modulis
#todo("uzrakstīt renderēšanas moduli")
=== Audio modulis
#todo("uzrakstīt audio moduli")

== Nefunkcionālās prasības
=== Veiktspējas prasības
Uz sistēmas veiktspēju ir sekojošas prasības:
- Labirinta ģenerēšana: Jebkura izmēra labirintam jātiek uzģenerētam ātrāk par 1 sekundi.
- Spēles ielāde: Spēlei jāstartējas ātrāk par 3 sekundēm.
- Kadru ātrums: Spēlei jādarbojas ar vismaz 60 kadriem sekundē.
- Ievades apstrāde: Spēlētāja kustībām jātiek apstrādātām bez manāmas aizkaves ($<16$ms).
=== Uzticamība
Uz sistēmas uzticamību ir sekojošas prasības:
- Kļūdu apstrāde: spēlei jāapstrādā kļūdas graciozi, bez sistēmas atteicēm.
- Saglabāšana: spēles progresam jātiek automātiski saglabātam pēc katra līmeņa.
- Atjaunošanās: spēlei jāspēj atjaunoties pēc negaidītas aizvēršanas.

=== Atribūti
==== Izmantojamība
Uz sistēmas izmantojamību ir sekojošas prasības:
- $90%$ jaunu lietotāju jāspēj lietot visas tiem pieejamās funkcijas bez palīdzības.
- Teksta fonta izmēram datoru ekrāniem jābūt vismaz 14 pikseļiem, labas
  salasāmības nodrošināšanai.

==== Drošība
Uz drošību risinājumiem ir sekojošas prasības:
- Spēles pirmkods ir iekļauts kopā ar izpildāmo bināro failu;
- Spēle nemodificē un nelasa lietotāja vai operētājsistēmas failus, izņemot izmantoto bibliotēku
  failus.

==== Uzturamība
Pret sistēmas izstrādājamo programmatūras uzturamību tiek izvirzītas sekojošās prasības:
- API dokumentācijas pārklājumam jābūt vismaz 80%.
- Koda testēšanas pārklājumam jābūt vismaz 70%.

==== Pārnesamība
Spēlei jābūt saderīgai ar vairākām operētājsistēmām. Tas ietver Windows, Linux
un macOS operētājsistēmu 64 bitu versiju atbalstu. Minimālās sistēmas prasības
ir noteiktas, lai nodrošinātu plašu pieejamību, vienlaikus saglabājot veiktspēju:

- 4GB operatīvās atmiņas (RAM);
- Integrēta grafiskā karte;
- Divkodolu procesors.

=== Ārējās saskarnes prasības

= Programmatūras projektējuma apraksts
== Daļējs funkciju projektējums
#todo("pievienot funkciju projektējumu +diagrammas")
/* Apraksta svarīgākās, sarežģītākās funkcijas vai sistēmas darbības aspektus;
* obligāti  jālieto vismaz 4 dažādi diagrammu veidi, izņemot DPD un lietošanas
* piemēru (use case) diagrammas */
== Saskarņu projektējums
#todo("pievienot saskarnes (UI/UX)")
/* 5-7 lietotāja saskarnes un to apraksts */

= Testēšanas dokumentācija
Šajā nodaļā ir aprakstīta spēles "Maze Ascension" testēšanas process.
Testēšana tika veikta divos galvenajos virzienos -- statiskā un dinamiskā
testēšana, izmantojot gan automatizētus rīkus, gan manuālu pārbaudi.

== Statiskā testēšana <static-tests>
Statiskā testēšana ir svarīga daļa no projekta kvalitātes nodrošināšanas.
"Clippy"@clippy tiek izmantots koda analīzei, meklējot potenciālas problēmas un
neoptimālus risinājumus. Papildus noklusētajiem noteikumiem, tika aktivizēti
stingrāki koda kvalitātes pārbaudes līmeņi: "pedantic" režīms nodrošina
padziļinātu koda stila pārbaudi, "nursery" aktivizē eksperimentālās pārbaudes,
un "unwrap_used" un "expect_used" brīdina par potenciāli nedrošu kļūdu
apstrādi. Šie papildu noteikumi palīdz uzturēt augstāku koda kvalitāti un
samazināt potenciālo kļūdu skaitu.


/* Programmatūras statiskai testēšanai ir izmantots rīks „clang-tidy“, kas analizē
programmatūru, meklējot kļūdas un problēmas pirmkodā. [12] Rīks satur vairākas specifiskas
problēmu kopas, kas var tikt izmantotas analīzē. Tika izmantota „clang-analyzer“ problēmu
kopa. Vieglākai statisko testu darbināšanai tika izmantots vienkāršs programmēšanas valodas
„Python“ skripts, kas atlasa visus failus, kuru paplašinājums ir „cpp“ (valodas „C++“ pirmkoda
fails) vai „h“ (galvenes fails) un darbina statiskās analīzes rīku ar katru failu atsevišķi (skat.
izpildes rezultātu attēlā 4.3.). */

== Dinamiskā testēšana
#todo("uztakstīt dinamisko testēšanu")
=== Manuālā integrācijas testēšana
=== Automatizēti testi

= Programmas projekta organizācija

Kvalifikācijas darba prasības paredz, ka programmatūru un dokumentāciju autors
veido patstāvīgi, vadoties pēc darba vadītāja norādījumiem.

#todo("uzrakstīt projekta organizāciju")

== Kvalitātes nodrošināšana
Augstas koda kvalitātes nodrošināšana ir jebkura projekta būtisks aspekts.
Lai to panāktu, tiek izmantoti vairāki rīki un prakses, kas palīdz uzturēt tīru,
efektīvu un uzticamu koda.

Viens no galvenajiem rīkiem, kas tiek izmantots ir "Clippy"@clippy, kas analizē
iespējamās problēmas un iesaka uzlabojumus (skat. @static-tests nodaļu).

Kopā ar "Clippy" tiek arī izmantots "Rustfmt"@rustfmt, koda formatētājs, lai
uzturētu vienotu koda formatējumu visā projektā. Šis rīks automātiski formatē
kodu saskaņā ar Rust stila vadlīnijām@rust-style.

Turklāt visas publiskās funkcijas un datu struktūras
hexlab bibliotēkā ir dokumentētas@hexlab-docs. Šajā dokumentācijā ir ietverti
detalizēti apraksti un lietošanas piemēri, kas ne tikai palīdz saprast kodu, bet
arī kalpo kā dokumentācijas testēšanas veids. Darbinot "cargo doc"@cargo-doc,
tiek ģenerēja un validēja dokumentācija, nodrošinot, ka piemēri ir pareizi un
aktuāli.

Programmatūras prasības specifikācija ir izstrādāta, ievērojot LVS 68:1996
standarta "Programmatūras prasību specifikācijas ceļvedis"@lvs_68 un LVS 72:1996
standarta "Ieteicamā prakse programmatūras projektējuma aprakstīšanai"@lvs_72
standarta prasības.
// Programmatūras projektējuma aprakstā iekļautās
// aktivitāšu diagrammas ir izstrādātas, ievērojot UML 2.5 versijas
// specifikāciju@omg-uml.

== Konfigurācijas pārvaldība
Pirmkods tiek pārvaldīts, izmantojot "git"@git versiju kontroles sistēmu.
Repozitorijs tiek izvietots platformā "GitHub".
Rīku konfigurācija ir definēta vairākos failos:
- "justfile"@justfile -- satur atkļūdošanas un
  laidiena komandas dažādām vidēm:
  - atkļūdošanas kompilācijas ar iespējotu pilnu atpakaļsekošanu;
  - laidiena kompilācijas ar iespējotu optimizāciju.
- "GitHub Actions"@gh-actions darbplūsmas, kas apstrādā:
  - koda kvalitātes pārbaudes (vienībtesti, statiskie testi, formatēšana,
    dokumentācijas izveide).
  - kompilācijas un izvietotošanas darbplūsma, kas:
    - izveido Windows, Linux, macOS un WebAssembly versijas;
    - publicē bināros failus GitHub platformā;
    - izvieto tīmekļa versiju itch.io@itch-io platformā.

Versiju specifikācija notiek pēc semantiskās versiju atlases@sem_ver (MAJOR.MINOR.PATCH):
+ MAJOR -- galvenā versija, nesaderīgas izmaiņas, būtiskas koda izmaiņas.
+ MINOR -- atpakaļsaderīgas funkcionalitātes papildinājumi.
+ PATCH -- ar iepriekšējo versiju saderīgu kļūdu labojumi.

== Darbietilpības novērtējums
#todo("uzrakstīt darbietilpības novērtējumu")

// = Secinājumi
// #todo("uzrakstīt secinājumus")

#bibliography(
  title: "Izmantotā literatūra un avoti",
  "bibliography.yml",
)

#heading("Pielikumi", numbering: none)

// #include "doc.typ"

// #pagebreak()
// #total-words words
