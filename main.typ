#import "@preview/dashy-todo:0.0.1": todo
#import "@preview/i-figured:0.2.4"
#import "@preview/tablex:0.0.9": tablex, rowspanx, colspanx, cellx
#import "@preview/wordometer:0.1.3": word-count, total-words
#import "layout.typ": project, indent-par
#import "@preview/fletcher:0.5.3" as fletcher: diagram, node, edge
#import fletcher.shapes: diamond
#import "utils.typ": *
#import "diagrams.typ": *
#show: word-count

#show: project.with(
  university: "Latvijas Universitāte",
  faculty: [Eksakto zinātņu un tehnoloģiju fakultāte\ Datorikas nodaļa],
  thesis_type: "Kvalifikācijas darbs",
  title: [Spēles izstrāde, izmantojot\ Bevy spēļu dzinēju],
  authors: ("Kristiāns Francis Cagulis, kc22015",),
  advisor: "prof. Mg. dat. Jānis Iljins",
  date: "Rīga 2025",
)
#set heading(numbering: none)
= Apzīmējumu saraksts

/ Audio: Skaņas komponentes, kas ietver gan skaņas efektus, gan fona mūziku;
/ CI/CD: nepārtraukta integrācija un nepārtraukta izvietošana;
/ DPD: datu plūsmas diagramma;
/ ECS: entitāšu komponenšu sistēma (angl. Entity-Component-System)@ecs;
/ GitHub#footnote[https://en.wikipedia.org/wiki/GitHub]: izstrādātāju platforma, kas ļauj izstrādātājiem izveidot, glabāt, pārvaldīt un kopīgot savu kodu;
/ Interpolācija: starpvērtību atrašana pēc funkcijas doto vērtību virknes;
/ Jaucējtabula#footnote[https://lv.wikipedia.org/wiki/Jauc%C4%93jtabula]: jeb heštabula (angl. hash table)#footnote[https://en.wikipedia.org/wiki/Hash_table] ir datu struktūra, kas saista identificējošās vērtības ar piesaistītajām vērtībām;
/ Laidiens: Programmatūras versija, kas ir gatava izplatīšanai lietotājiem un satur īpašas funkcijas, uzlabojumus vai labojumus;
/ PPA: programmatūras projektējuma apraksts;
/ PPS: programmatūras prasību specifikācija;
/ Papildspēja: objekts, kas kā spēles mehānika spēlētājam piešķir īslaicīgas priekšrocības vai papildu spējas (angl. power-up)#footnote[https://en.wikipedia.org/wiki/Power-up]<power-up>;
/ Pirmkods: Cilvēkam lasāmas programmēšanas instrukcijas, kas nosaka programmatūras darbību;
/ Procedurāla ģenerēšana: datu algoritmiskas izstrādes metode, kurā tiek kombinēts cilvēka radīts saturs un algoritmi, kas apvienoti ar datora ģenerētu nejaušību;
/ Renderēšana: Process, kurā tiek ģenerēts vizuāla izvade;
/ Spēlētājs: lietotāja ieraksts vienas virtuālās istabas kontekstā;
/ Sēkla: Skaitliska vērtība, ko izmanto nejaušo skaitļu ģeneratora inicializēšanai;

= Ievads
== Nolūks
Šī dokumenta mērķis ir raksturot sešstūru labirinta spēles "Maze Ascension"
programmatūras prasības un izpētīt Bevy spēļu dzinēja iespējas.

== Darbības sfēra
Darba galvenā uzmanība ir vērsta uz būtisku spēles mehāniku ieviešanu, tostarp
procedurālu labirintu ģenerēšanu, spēlētāju navigācijas sistēmu, papildspēju
integrāciju un vertikālās progresijas mehāniku, vienlaikus ievērojot minimālisma
dizaina filozofiju.

// Spēles pamatā ir sešstūra formas plāksnes, kas, savukārt, veido sešstūra
// formas labirintus, kuri rada atšķirīgu vizuālo un navigācijas izaicinājumu.
// Spēlētāju uzdevums ir pārvietoties pa šiem labirintiem, lai sasniegtu katra
// līmeņa beigas. Spēlētājiem progresējot, tie sastopas ar arvien sarežģītākiem
// labirintiem, kuros nepieciešama stratēģiska domāšana, izpēte un papildspēju
// izmantošana.

Spēles pamatā ir procedurāli ģenerēti sešstūra labirinti, kas katrā spēlē rada
unikālu vizuālo un navigācijas izaicinājumu. Procedurālās ģenerēšanas sistēma
nodrošina, ka:

- Katrs labirints tiek unikāli ģenerēts "uzreiz"#footnote[Attiecas uz gandrīz
  tūlītēju labirintu ģenerēšanu, kas notiek milisekunžu
  laikā.], nodrošinot "bezgalīgu"#footnote[Lai gan sistēma izmanto `u64` sēklas,
  kas ir galīgas, iespējamo labirinta konfigurāciju skaits ir ārkārtīgi liels,
  tādējādi praktiskiem mērķiem nodrošinot praktiski bezgalīgu labirintu
  skaitu.] daudzveidību.
- Labirinta sarežģītību var dinamiski pielāgot spēlētājam progresējot.
- Uzglabāšanas prasības tiek samazinātas līdz minimumam, ģenerējot labirintus reāllaikā.

Spēlētāju uzdevums ir pārvietoties pa šiem procesuāli ģenerētajiem labirintiem,
lai sasniegtu katra līmeņa beigas. Turpinot progresēt, spēlētāji saskaras ar
arvien sarežģītākiem labirintiem, kuros nepieciešama stratēģiskā domāšana,
izpēte un papildu prasmju izmantošana.

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
ceļvedis" un LVS 72:1996 "Ieteicamā prakse programmatūras projektējuma
aprakstīšanai" standarta prasības @lvs_68 @lvs_72.

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
integrācijas un nepārtrauktas izvietošanas (CI/CD)
darbplūsma,#footnote[https://github.com/resources/articles/devops/ci-cd]<pipeline> lai
vienkāršotu izstrādes un izplatīšanas procesu.
Šī darbplūsma ir konfigurēts tā, lai kompilētu spēli vairākām platformām,
tostarp Linux, macOS, Windows un WebAssembly (WASM).
Tas nodrošina, ka spēle ir pieejama plašai auditorijai, nodrošinot konsekventu
un saistošu pieredzi dažādās operētājsistēmās un vidēs.

Spēle tiek izplatīta, izmantojot "GitHub
releases"#footnote[https://docs.github.com/en/repositories/releasing-projects-on-github/about-releases]<gh-release>
un itch.io,#footnote[https://itch.io/]<itch-io> kas ir
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
(sk. @fig:dpd-0).

#figure(
  caption: [\0. līmeņa DPD],
  diagram(
    data-store((0, 0), [Spēlētājs]),
    dpd-edge("rr,ddd,ll", align(center)[Ievades ierīces\ dati]),
    process((0, 3), [Spēle], inset: 20pt),
    dpd-edge(
      "lll,uuu,rrr",
      align(center)[Vizuālās\ izvades dati],
    ),
    dpd-edge(
      "l,uuu,r",
      align(center)[Audio\ izvades dati],
    ),
  ),
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
  - ierīcei jāatbalsta WebGL2,#footnote("https://registry.khronos.org/webgl/specs/latest/2.0/")
    lai nodrošinātu pareizu atveidošanu @webgl2.
- tīmekļa spēļu spēlēšanai (WebAssembly versija) pārlūkprogrammai jābūt mūsdienīgai un saderīgai ar WebAssembly.
- ekrāna izšķirtspējai jābūt vismaz 800x600 pikseļu, lai spēle būtu optimāla.
- Veiktspējas atkarība:
  - Spēle ir atkarīga no Bevy spēles dzinēja (0.15).
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
  - Lietotāji var piekļūt un lejupielādēt spēles no itch.io platformas.
  - Spēlētājiem ir ievadierīces (tastatūra/pele), ar kurām kontrolēt spēli.

= Programmatūras prasību specifikācija
== Funkcionālās prasības
\1. līmeņa datu plūsmas diagramma (sk. @fig:dpd-1) ilustrē galvenos
procesus spēles "Maze Ascension" sistēmā.
Diagrammā attēloti seši galvenie procesi, viens izstrādes process un viens
ārējs (bibliotēkas) process(-i) process:
stāva pārvaldības modulis,
labirinta ģenerēšanas un pārvaldības moduļi,
spēlētāja modulis,
spēles stāvokļa pārvalības modulis,
papildspēju modulis
un izstrādes rīku modulis.
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
  diagram({
    dpd-database((0, 0), [Operatīvā\ atmiņa], snap: -1)
    dpd-edge(
      "u,ull",
      align(center)[Visi spēles\ dati],
      shift: (-29pt, 0),
      label-pos: 0.8,
    ) // dev_tools
    dpd-edge(
      "uuu",
      align(center)[Visi spēles\ dati],
      shift: -20pt,
    ) // bevy
    dpd-edge("rru,u", [Stāva dati]) // floor
    dpd-edge(
      (2.5, 0),
      align(center)[Labirinta\ konfigurācijas dati],
      label-sep: -0.5em,
      shift: -22pt,
    ) // hexlab
    dpd-edge(
      "rrd,d",
      align(center)[Labirinta\ izkārtojuma dati],
      shift: 20pt,
      label-pos: 0.501,
      label-sep: 4em,
    ) // maze
    dpd-edge(
      "d,drr",
      align(center)[Labirinta\ konfigurācijas dati],
      shift: (-29pt, 0),
      label-pos: 0.7,
    ) // maze
    dpd-edge(
      "ddd",
      align(center)[Spēlētaja\ dati],
      shift: 10pt,
      label-pos: 0.4,
    ) // player
    dpd-edge(
      "d,dll",
      align(center)[Spēles\ stāvokļa dati],
      shift: (29pt, 0),
      label-pos: 0.7,
    ) // screns
    dpd-edge(
      (-2.5, 0),
      align(center)[Papildspēju\ stāvokļa dati],
      shift: 15pt,
      label-sep: -0.5em,
    ) // power_ups

    process(
      (0, -3),
      [Bevy],
      inset: 20pt,
      extrude: (-4pt, 0),
      stroke: (thickness: 1pt, dash: "dashed"),
    )
    dpd-edge("uu", align(center)[Vizuālās\ izvades dati])
    dpd-edge("l,uu,r", align(center)[Audio\ izvades dati])
    dpd-edge("ddd", [Ievades dati], shift: (-20pt, -20pt), label-pos: 0.3)

    data-store((0, -5), [Spēlētājs])
    dpd-edge(
      "r,dd,l",
      align(center)[Neapstrādāti ievades\ ierīces dati],
      label-sep: -0.3em,
    )

    process((-2, -2), [Izstrādes rīku\ modulis])
    dpd-edge(
      "d,drr",
      align(center)[Atjaunoti\ spēles dati],
      label-pos: 0.4,
    )

    process((2, -2), [Stāva pārvaldības\ modulis])
    dpd-edge("ddll", align(center)[Atjaunoti\ stāva dati])

    process((2.5, 0), [Labirinta\ ģenerēšanas\ modulis])
    dpd-edge((0, 0), align(center)[Labirinta\ izkārtojuma dati], shift: -10pt)

    process((2, 2), [Labirinta\ pārvaldības\ modulis])
    dpd-edge(
      "ll,uu",
      align(center)[Labirinta dati],
      label-pos: 0.3,
      shift: (0, 22pt),
    )

    process((0, 3), [Spēlētāja\ modulis])
    dpd-edge(
      "uuu",
      align(center)[Atjaunoti\ spēlētāja\ dati],
      shift: 20pt,
      label-pos: 0.3,
    )

    process((-2, 2), [Spēles stāvokļa\ pārvaldības modulis])
    dpd-edge(
      "u,urr",
      align(center)[Atjaunoti spēles\ stāvokļa dati],
      shift: (0, 10pt),
      label-pos: 0.3,
    )

    process((-2.5, 0), [Papildspēju\ modulis])
    dpd-edge((0, 0), align(center)[Papildspēju\ dati], shift: 15pt)
  }),
) <dpd-1>

=== Funkciju sadalījums moduļos
Tabulā @tbl:function-modules[] ir sniegts visaptverošs spēles funkcionalitātes
sadalījums pa tās galvenajiem moduļiem. Katram modulim ir noteikti konkrēti
pienākumi, un tas ietver funkcijas, kas veicina kopējo spēles sistēmu.

#figure(
  caption: "Funkciju sadalījums pa moduļiem",
  kind: table,
  tablex(
    columns: (auto, 1fr, auto),
    /* --- header --- */
    [*Modulis*],
    [*Funkcija*],
    [*Identifikators*],
    /* -------------- */

    rowspanx(1)[Izstrādes rīku modulis], // dev_tools
    [Labirinta pārvaldības saskarne],
    [#link(<dev_tools-F01>)[IRMF01]],

    rowspanx(3)[Stāva pārvaldības modulis], // floor
    [Stāva ielāde],
    [],
    [Stāva izlāde],
    [],
    [Stāvu kustība],
    [],

    rowspanx(1)[Labirinta ģenerēšanas modulis], // hexlab
    [Labirinta būvētājs],
    [#link(<hexlab-F01>)[LGMF01]],

    rowspanx(3)[Labirinta pārvaldības modulis], // maze
    [Labirinta ielāde],
    [#link(<maze-F01>)[LPMF01]],
    [Labirinta #red("pārlāde")],
    [],
    [Labirinta #red("izlāde")],
    [],

    rowspanx(4)[Spēlētāja modulis], // player
    [Spēlētāja ielāde],
    [#link(<player-F01>)[SPMF01]],
    [Spēlētāja ievades apstrāde],
    [#link(<player-F02>)[SPMF02]],
    [Spēlētāja kustība],
    [#link(<player-F03>)[SPMF03]],
    [Spēlētāja pāreja],
    [#link(<player-F04>)[SPMF04]],

    rowspanx(3)[Spēles stāvokļa pārvaldības modulis], // screens
    [Spēles sākšana],
    [#link(<screen-F01>)[SSPMF01]],
    [Atgriešanās uz sākumekrānu],
    [#link(<screen-F02>)[SSPMF02]],
    [Attēlot sākumekrānu],
    [#link(<screen-F03>)[SSPMF03]],

    rowspanx(3)[Papildspēju modulis], // power_up
  ),
) <function-modules>

// === Audio modulis
// #todo("uzrakstīt audio moduli")

=== Izstrādes rīku modulis

#figure(
  caption: [Izstrādes rīku moduļa 2. līmeņa DPD],
  diagram(
    spacing: 10em,
    {
      data-store((0, 0), [Spēlētājs])
      dpd-edge("r", align(center)[Labirinta\ konfigurācijas dati])

      dpd-database((2, 0), [Operatīvā\ atmiņa])

      process((1, 0), [Labirinta\ pārvaldības\ saskarne])
      dpd-edge("r", align(center)[Labirinta\ izkārtojuma dati])
    },
  ),
) <dpd-2-dev_tools>

Dotais modulis ir izstrādes rīks, kas paredzēts lietotāja saskarnes elementu
attēlošanai un apstrādei, lai konfigurētu labirinta parametrus.
Šis modulis, izmantojot "egui"@bevy-egui un "inspector-egui"@bevy-inspector-egui
bibliotēkas, izveido logu "Maze Controls" (labirinta vadības
elementi), kurā tiek parādītas dažādas
konfigurācijas opcijas, piemēram, sēkla, rādiuss, augstums, labirinta izmērs,
orientācija un sākuma/galapunkta pozīcijas (sk @tbl:dev_tools-F01).
Lietotāji var mijiedarboties ar šiem vadības elementiem, lai mainītu labirinta
izkārtojumu un izskatu.
Modulis pārbauda, vai konfigurācijā nav notikušas izmaiņas, un izraisa attiecīgus
notikumus, lai atjauninātu labirintu un spēlētāja pozīciju, kad notiek izmaiņas.

Svarīgi atzīmēt, ka šis modulis ir paredzēts lietošanai spēles izstrādes procesā.
Laidiena versijās šī lietotāja saskarne nebūs pieejama, nodrošinot, ka
gala lietotāji nevar piekļūt šīm uzlabotajām konfigurācijas opcijām.

// Moduļa funkcionalitāti var vizualizēt, izmantojot datu plūsmas diagrammu (DFD),
// kurā būtu parādītas ievades no spēles pasaules (piemēram, pašreizējā stāva un
// labirinta konfigurācija), apstrāde lietotāja saskarnes sistēmā un izejas kā
// atjauninātas labirinta konfigurācijas un respawn notikumi.


#function-table(
  "Labirinta pārvadības saskarne",
  "IRMF01",
  [Apstrādā un izvada labirinta konfigurācijas vadības elementus lietotāja saskarnē.],
  [
    Ievades dati tiek saņemti no pasaules resursiem un komponentiem:
    + Labirinta spraudņa resurss;
    + "EguiContext" komponente;#footnote[https://docs.rs/bevy_egui/latest/bevy_egui/]<bevy_egui>
    + Labirinta konfigurācija un stāva komponentes saistībā ar pašreizējā stāva
      komponenti;
    + Globālais labirinta konfigurācijas resurss.
  ],
  [
    + Pārbauda, vai labirinta straudņa resurss eksistē pasaulē.
      + Ja nav, iziet no sistēmas un nedara neko.
    + Saņem `EguiContext` komponentu no primārā loga.
    + Saņem labirinta konfigurāciju un stāvu komponentus no pašreizējā stāva.
    + Izveido jaunu "Maze Controls" logu, izmantojot "egui".
    + Ja globālais labirinta konfigurācijas resurss ir pieejams:
      + Parāda galveno virsrakstu "Maze Configuration".
      + Pievieno vadības elementus:
        - Sēklai;
        - Rādiusam;
        - Augstumam;
        - Šešstūra izmēram;
        - Orientācijai;
        - Sākuma pozīcijai;
        - Beigu pozīcijai.
      + Apstrādā izmaiņas un atjaunina labirintu un spēlētāju, ja radušās izmaiņas.
  ],
  [
    + Atjaunināta labirinta konfigurācijas struktūra.
    + Atjaunināts labirints, ja radušās izmaiņas.
    + Atjaunināts spēlētāja novietojums, ja radušās izmaiņas.
  ],
) <dev_tools-F01>

=== Stāvu pārvaldības modulis
#todo("uzrakstīt stāvu pārvaldības moduli")

=== Labirinta ģenerēšanas modulis

Apakšnodaļa ietver labirinta moduļa funkcijas. Moduļa funkcionalitāte ir
izmantota sešstūraina labirinta ģenerēšanai.
Moduļa funkciju datu
plūsmas ir parādītas 2. līmeņa datu plūsmas diagrammā (sk. @fig:dpd-2-hexlab)
Labirinta būvēšanas funkcija ir aprakstītas atsevišķā tabulā (sk. @tbl:hexlab-F01)

Modularitātes un atkārtotas lietojamības apsvērumu dēļ, labirinta ģenerēšanas
funkcionalitāte ir izveidota kā ārēja bibliotēka
"hexlib".#footnote[https://crates.io/crates/hexlab]<hexlab> Šis lēmums
ļauj labirinta ģenerēšanas loģiku atkārtoti izmantot dažādos projektos un
lietojumprogrammās, veicinot atkārtotu koda izmantošanu.
Iekapsulējot labirinta ģenerēšanu atsevišķā bibliotēkā, to ir vieglāk pārvaldīt
un atjaunināt neatkarīgi no galvenās lietojumprogrammas, nodrošinot, ka
labirinta ģenerēšanas algoritma uzlabojumus vai izmaiņas var veikt, neietekmējot
programmu.

#figure(
  caption: [Labirinta ģenerēšanas moduļa 2. līmeņa DPD],
  diagram(
    spacing: 8em,
    {
      dpd-database((0, 0), [Operatīvā\ atmiņa])
      dpd-edge("l,u,r", align(center)[Labirinta\ konfigurācijas dati])

      process((0, -1), [Labirinta\ būvētājs])
      dpd-edge("r,d,l", align(center)[Labirinta\ izkārtojuma dati])
    },
  ),
) <dpd-2-hexlab>

#function-table(
  "Labirinta būvētājs",
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
) <hexlab-F01>

=== Labirinta pārvaldības modulis
#todo("uzrakstīt labirinta pārvaldības moduli")

#function-table(
  "Labirinta ielāde",
  "LPMF01",
  [ Izveidot jaunu labirinta stāvu spēles pasaulē. ],
  [
    Ievades dati tiek saņemti no:
    + SpawnMaze notikuma (saturoša stāva numuru un konfigurāciju)
    + Bevy ECS komponentiem un resursiem
  ],
  [
    + Pārbauda, vai labirints šim stāvam jau eksistē.
      + Ja eksistē, parāda 1. paziņojumu un iziet no sistēmas.
    + Ģenerē jaunu labirintu balstoties uz nodoto konfigurāciju.
    + Aprēķina vertikālo nobīdi jaunajam stāvam.
    + Izveido jaunu entitāti, kas pārstāv labirinta stāvu, pievienojot tam
      atbilstošās komponente.
    + Atkarībā no tā, vai tas ir pašreizējais vai nākamais stāvs, pievieno
      attiecīgo komponenti.
    + Izsauc atsevišķu funkciju labirinta plākšņu izveidei. #todo("rework")
  ],
  [
    Izvades datu sistēmai nav.
  ],
  [
    + "Stāvs $x$ jau eksistē."
    + "Neizdevās ģenerēt labirintu stāvam $x$."
  ],
) <maze-F01>

=== Spēlētāja modulis
Spēlētāja modulis ir atbildīgs par spēlētāja entītijas pārvaldību, kas ietver
tās izveidi, kustību apstrādi un mijiedarbību ar spēles vidi. Moduļa darbības
plūsma ir attēlota 2. līmeņa datu plūsmas diagrammā (sk. @fig:dpd-2-player), kas
parāda četras galvenās funkcijas un to mijiedarbību ar datu glabātuvi.

Spēlētāja kustība tiek realizēta divās daļās: ievades apstrāde
(#link(<player-F02>)[SPMF02]) un kustības izpilde
(#link(<player-F03>)[SPMF03]).
Ievades apstrādes funkcija pārbauda tastatūras ievadi
un, ņemot vērā labirinta sienu izvietojumu, nosaka nākamo kustības mērķi.
Kustības izpildes funkcija nodrošina plūstošu pārvietošanos uz mērķa pozīciju,
izmantojot interpolāciju starp pašreizējo un mērķa pozīciju.

Stāvu pārejas apstrāde (#link(<player-F04>)[SPMF04]) nepārtraukti uzrauga spēlētāja pozīciju
attiecībā pret stāva izeju un sākumu. Kad spēlētājs sasniedz kādu no šiem
punktiem, funkcija izsauc atbilstošu pārejas notikumu.

#figure(
  caption: [Spēlētāja moduļa 2. līmeņa DPD],
  diagram(
    spacing: (6em, 2em),
    {
      data-store((0, 0), [Spēlētājs])
      dpd-edge(
        "u,r",
        align(center)[Tastatūras\ ievades dati],
        label-pos: 0.6,
        shift: (10pt, 0),
      )

      process((1, -2), [Spēlētāja\ ielāde])
      dpd-edge(
        "rr,dd",
        align(center)[Spēlētāja\ entitātes dati],
        label-pos: 0.2,
        shift: (-10pt, -29pt),
      )

      process((1, -1), [Spēlētāja\ ievades apstrāde])
      dpd-edge(
        "dr,r",
        align(center)[Atjaunoti spēlētāja\ entitātes dati],
        label-pos: 0.35,
        shift: (0, -20pt),
      )

      process((1, 0), [Spēlētāja\ kustība])
      dpd-edge(
        "dd,rr,uu",
        align(center)[Atjaunoti spēlētāja\ entitātes dati],
        label-pos: 0.2,
        shift: (0, -29pt),
      )
      process((1, 3), [Spēlētāja\ pāreja])
      dpd-edge(
        "rr,uuu",
        align(center)[Notikuma dati],
        label-pos: 0.2,
        label-sep: -0.2em,
        shift: (9pt, 5pt),
      )

      dpd-database((3, 0), [Operatīvā\ atmiņa])
      dpd-edge(
        "uu,ll",
        align(center)[Labirinta\ konfigurācijas dati],
        label-pos: 0.6,
        shift: (19pt, -10pt),
      )
      dpd-edge(
        "u,ll",
        align(center)[Labirinta\ konfigurācijas dati],
        label-pos: 0.75,
        shift: (-29pt, -10pt),
      )
      dpd-edge(
        "u,ll",
        align(center)[Spēlētāja\ entitātes dati],
        label-pos: 0.55,
        shift: (-19pt, 10pt),
      )
      dpd-edge(
        "ll",
        align(center)[Spēlētāja\ entitātes dati],
        label-pos: 0.7,
      )
      dpd-edge(
        "ll",
        align(center)[Labirinta\ konfigurācijas dati],
        label-pos: 0.35,
        label-sep: -0.5em,
        shift: 19pt,
      )
      dpd-edge(
        "ddd,ll",
        align(center)[Spēlētāja\ entitātes dati],
        label-pos: 0.8,
        shift: (19pt, 20pt),
      )
      dpd-edge(
        "ddd,ll",
        align(center)[Pašreizējā\ stāva dati],
        label-pos: 0.6,
        label-sep: -0.2em,
        shift: (9pt, 5pt),
      )
    },
  ),
) <dpd-2-player>

#function-table(
  "Spēlētāja ielāde",
  "SPMF01",
  "Izveido spēlētāja entitāti ar visām nepieciešamajiem komponentēm.",
  [
    + Labirinta konfigurācija.
    + Globālā konfigurācija.
  ],
  [
    + Iegūst sākuma pozīciju no labirinta konfigurācijas.
    + Izveido spēlētāja entitāti ar:
      - pašreizējo pozīciju;
      - tekstūru;
      - krāsu.
  ],
  [
    + Spēlētāja entitāte.
  ],
) <player-F01>

#function-table(
  "Spēlētāja ievades apstrāde",
  "SPMF02",
  "Apstrādā spēlētāja tastatūras ievadi un aprēķina nākamo kustības plāksi.",
  [
    + Tastatūras ievade.
    + Pašreizējā pozīcija.
    + Labirinta konfigurācija.
  ],
  [
    + Pārbauda vai ir aktīva kustība.
      + Ja ir, iziet no sistēmas un nedara neko.
    + Nosaka kustības virzienu no ievades.
    + Pārbauda sienu šķēršļus.
      + Ja kustības virzienā ir siena, iziet no sistēmas un nedara neko.
    + Aprēķina nākamo pozīciju.
  ],
  [
    + Kustības mērķa plāksnes pozīcija.
  ],
) <player-F02>

#function-table(
  "Spēlētāja kustība",
  "SPMF03",
  "Atjaunina spēlētāja pozīciju, veicot plūstošu pārvietošanos uz mērķa plāksnes pozīciju.",
  [
    + Kustības mērķis
    + Kustības ātrums
    + Pašreizējā pozīcija
    + Labirinta konfigurācija
  ],
  [
    + Aprēķina mērķa pozīciju pasaules koordinātēs.
    + Pārvieto spēlētāju uz mērķi ar noteiktu ātrumu.
    + Atjaunina pozīcijas datus.
  ],
  [
    + Atjauninātā pozīcija.
    + Transformācijas dati.
  ],
) <player-F03>

#function-table(
  "Stāvu pāreja",
  "SPMF04",
  "Pārbauda vai spēlētājs ir sasniedzis stāva izeju vai sākumu un inicializē vertikālo pāreju.",
  [
    + Pašreizējā pozīcija.
    + Pašreizējais stāvs.
    + Labirinta konfigurācija.
  ],
  [
    + Pārbauda vai pozīcija sakrīt ar izeju.
      + Ja sakrīt, izsauc pacelšanās notikumu uz iziet no sistēmas.
    + Pārbauda vai pozīcija sakrīt ar sākumu.
      + Ja sakrīt, pārbauda vai iespējama nolaišanās.
        + Ja ir iespējama, izsauc nolaišanās notikumu uz iziet no sistēmas.
  ],
  [
    + Stāva pārejas notikums.
  ],
) <player-F04>

=== Spēles stāvokļa pārvaldības modulis
Spēles stāvokļa pārvaldības modulis nodrošina spēles dažādu stāvokļu pārvaldību
un pārejas starp tiem. Modulis sastāv no trim galvenajām funkcijām: spēles
sākšana (#link(<screen-F01>)[SSPMF01]), atgriešanās uz sākumekrānu
(#link(<screen-F02>)[SSPMF02]) un sākumekrāna attēlošanas
(#link(<screen-F03>)[SSPMF03]). Katra no šīm funkcijām apstrādā specifiskus
lietotāja ievades datus un atbilstoši atjaunina spēles stāvokli operatīvajā
atmiņā.

Moduļa 2. līmeņa DPD diagramma (sk. @fig:dpd-2-screen) parāda, ka lietotājs
mijiedarbojas ar sistēmu caur diviem galvenajiem ievades veidiem: pogu izvēli
sākumekrānā un "Escape" taustiņa nospiešanu spēles laikā.

Spēles sākšanas funkcija inicializē nepieciešamos resursus un
sistēmas, kad lietotājs izvēlas sākt jaunu spēli. Atgriešanās funkcija
apstrādā lietotāja pieprasījumu pārtraukt aktīvo spēli un atgriežas uz
sākumekrānu.

#figure(
  caption: [Spēles stāvokļa pārvaldības moduļa 2. līmeņa DPD],
  diagram({
    data-store((0, 0), [Spēlētājs])
    dpd-edge("rrr", align(center)[Tastatūras\ ievades dati])
    dpd-edge("u,rrr", align(center)[Izvēlētās\ pogas dati], label-pos: 0.6)

    process((3, -1), [Spēles\ sākšana])
    dpd-edge("rrr,d", align(center)[Spēles\ stāvokļa dati], label-pos: 0.4)

    process((3, 0), [Atgriešanās\ uz sākumekrānu])
    dpd-edge("rrr", align(center)[Spēles\ stāvokļa dati])

    process((3, 1), [Attēlot\ sākumekrānu])
    dpd-edge(
      "rrr,u",
      align(center)[Atjaunoti spēles\ stāvokļa dati],
      label-pos: 0.3,
      shift: -20pt,
    )

    dpd-database((6, 0), [Operatīvā\ atmiņa])
    dpd-edge(
      "d,lll",
      align(center)[Atjaunoti spēles\ stāvokļa dati],
      label-pos: 0.7,
      shift: -20pt,
    )
  }),
) <dpd-2-screen>

#function-table(
  "Spēles sākšana",
  "SSPMF01",
  "Sākt spēles līmeni, ielādējot labirintu, spēlētāju un mūziku.",
  [
    + Ekrāna stāvoklis
  ],
  [
    + Pievieno sistēmas spēles sākumā:
      - Izveido līmeni;
      - Izveido spēlētāju;
      - Sistēmas tiek darbinātas secīgi.
  ],
  [
    Izvades datu sistēmai nav.
  ],
) <screen-F01>


#function-table(
  "Atgriešanās uz sākumekrānu",
  "SSPMF02",
  "Apstrādāt atgriešanos uz titulekrānu no gameplay režīma.",
  [
    + Ekrāna stāvoklis
    + Nospiestie tastatūra taustiņi
  ],
  [
    + Pārbauda, vai ir nospiests "Escape" taustiņš.
      + Ja nav, iziet no sistēmas un nedara neko.
    + Pārbauda, vai pašreizējais stāvoklis spēle ir aktīva.
      + Ja nav, iziet no sistēmas un nedara neko.
    + Samaina ekrāna stāvokli uz sākumekrānu.
  ],
  [
    Izvades datu sistēmai nav.
  ],
) <screen-F02>

#function-table(
  "Attēlot sākumekrānu",
  "SSPMF03",
  "Izveido un parāda nosaukuma ekrāna lietotāja saskarni ar interaktīvām pogām.",
  [
    + Ekrāna stāvoklis
  ],
  [
    + Pievieno interaktīvas pogas:
      - pogu "Play" ar pāreju uz spēli;
      // - pogu "Credits" ar pāreju uz kredītiem;
      - pogu "Exit" (tikai platformām, kas nav WASM).
    + Pievieno novērotājus katrai pogai.
  ],
  [
    Izvades datu sistēmai nav.
  ],
) <screen-F03>

/* #function-table(
"Mūzikas atskaņošana",
"SSPMF03",
"Sākt atskaņot spēles mūziku gameplay režīmā.",
[ Ievades dati: + GameplayMusic resurss + AudioSource resurss ],
[ + Izveido jaunu audio entitāšu + Pievieno AudioPlayer komponenti + Iestata atskaņošanas iestatījumus uz LOOP ],
[ + Aktīva audio atskaņošanas entitāte ],
[ Nav definēti specifiski kļūdu ziņojumi. ],
) <screen-F03> */

/* #function-table(
"Mūzikas apturēšana",
"SSPMF04",
"Apturēt spēles mūziku, izejot no gameplay režīma.",
[
+ GameplayMusic resurss ar entitāte ID
],
[
+ Pārbauda, vai eksistē mūzikas entitāte:
+ Ja neeksistē, ...
+ Ja eksistē, likvidē entitāte rekursīvi
],
[
Izvades datu sistēmai nav.
],
) <screen-F04> */



== Nefunkcionālās prasības
=== Veiktspējas prasības
Uz sistēmas veiktspēju ir sekojošas prasības:
- Jebkura izmēra labirintam jātiek uzģenerētam ātrāk kā 1 sekundē.
- Spēlei jāstartējas ātrāk par 3 sekundēm.
- Spēlei jādarbojas ar vismaz 60 kadriem sekundē.
- Spēlētāja kustībām jātiek apstrādātām bez manāmas aizkaves ($<16$ms).
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
== Datu struktūru projektējums

Spēle ir veidota, izmantojot Bevy spēles dzinēju, kas īstenu
entitāšu komponenšu sistēmu (ECS) arhitektūras modeli.
Šis modelis sadala spēles loģiku trīs galvenajās daļās: entitātes jeb spēles
objekti, komponentes jeb dati un sistēmas -- loģika, kas darbojas ar entitātēm
ar konkrētām komponentēm @ecs @bevy-ecs @bevy-cheatbook[nod. ~14.7].
Šis modelis ļauj efektīvi apstrādāt datus un skaidri nodalīt atsevišķus
pienākumus.

=== Komponentes

Komponentes Bevy ir vienkāršas datu struktūras, kuras var pievienot entitātēm.
Tās nosaka spēles objektu īpašības un iespējas.
Šajā spēlē komponentes tiek izmantotas, lai attēlotu dažādus spēles vienību
aspektus, sākot ar to fiziskajām īpašībām un beidzot ar to vizuālo attēlojumu.
Komponentes ir izstrādātas būt minimālām un mērķtiecīgām, ievērojot vienotas
atbildības principus @SRP @SoC.
Šīs komponentes var iedalīt trīs galvenajās grupās: ar stāvu/līmeni, labirintu un
spēlētāju saistītās komponentes, kā redzams @tbl:components-floor[],
@tbl:components-maze[] un @tbl:components-player[tabulās].

==== Stāva komponentes

Stāva komponentes pārvalda vertikālo progresu un kustību spēlē.
Kā redzams @tbl:components-floor[tabulā], šīs komponentes pārvalda stāvu numurus,
pašreizējā un nākamā stāva stāvokli un vertikālās kustības mehāniku.

#components-table(
  caption: "Ar stāviem saistītās komponentes",
  `Floor`,
  "Stāva numurs",
  "Identificē, kurai entitātei ir kurš stāvs.",
  `CurrentFloor`,
  "Atzīmē pašreizējo stāvu",
  "Identificē pašreizējo stāvu.",
  `NextFloor`,
  "Atzīmē nākamo stāvu",
  "Identificē progresa mērķa līmeni, uz kuru jāpāriet. Var būt arī līmenis zemāk.",
  `FloorYTarget`,
  "Stāva nākamā Y pozīcija",
  "Identificē stāva Y koordināti, uz kuru tas jāpārvieto.",
) <components-floor>

==== Labirinta komponentes

Labirinta struktūru pārvalda vairāki savstarpēji saistītas komponentes.
Tabulā @tbl:components-maze[] ir redzamas sastāvdaļas, kas ir atbildīgas par
labirinta izveidi un uzturēšanu.

#components-table(
  caption: "Ar labirintiem saistītās komponentes",
  `HexMaze`,
  "Galvenais labirinta marķieris",
  "Identificē labirinta entitāti un pieprasa nepieciešamās atkarības.",
  `Tile`,
  "Apzīmē labirinta sešstūra plāksnes",
  "Identificē labirinta vietas, pa kurām var staigāt.",
  `Wall`,
  "Apzīmē labirinta sienas",
  "Identificē sadursmju robežas.",
  `MazeConfig`,
  "Glabā labirinta parametrus",
  "Konfigurē labirinta ģenerēšanu ar rādiusu, pozīcijām un izkārtojumu.",
  `Maze`,
  "Glabā sešstūra labirinta datu",
  "Glabā pilnu labirinta struktūru, izmantojot jaucējtabulu.",
  `Walls`,
  "Apzīmē sienu konfigurāciju",
  [Pārvalda sienas stāvokļus, izmantojot bitu karodziņus.
    @begginer-patterns],
) <components-maze>

==== Spēlētāja komponentes

Spēlētāju kustību un mijiedarbību nodrošina specializētu komponenšu kopums.
@tbl:components-player[tabulā] ir redzamas sastāvdaļas, kas pārvalda ar
spēlētāju saistītās funkcijas.

#components-table(
  caption: "Ar spēlētāju saistītās komponentes",
  `Player`,
  "Apzīmē spēlētāja entitāti",
  "Identificē spēlētāju un pieprasa nepieciešamās sastāvdaļas.",
  `CurrentPosition`,
  "Glabā spēlētāj pozīciju",
  "nosaka pašreizējo atrašanās vietu labirintā.",
  `MovementSpeed`,
  "Glabā kustības ātrumu",
  "Nosaka spēlētāja pārvietošanās ātrumu.",
  `MovementTarget`,
  "Glabā pārvietošanās mērķi",
  "Pārvalda spēlētāju pārvietošanās virzienus.",
) <components-player>


=== Notikumi

Notikumi Bevy nodrošina paziņojumu apmaiņas mehānismu, kas nodrošina brīvu
sasaisti starp sistēmām.
Šī uz notikumiem balstītā arhitektūra ļauj dažādām sistēmas daļām spēles daļām
sazināties bez tiešas atkarības.
Notikumi ir īpaši noderīgi lietotāja ievades, fizikas mijiedarbības un spēles
stāvokļa pāreju apstrādei @bevy-cheatbook[nod. ~14.11].
Notikumi arī ir iedalīti trīs galvenajās grupās: ar labirintu, pāreju uz citu stāvu
un ar spēlētāju saistīti notikumi, kas redzams @tbl:events-maze[],
@tbl:events-floor[] un @tbl:events-player[tabulās].

==== Labirintu notikumi

Labirinta notikumi pārvalda labirinta entitāšu dzīves ciklu spēlē. Kā redzams
@tbl:events-maze[tabulā], šie notikumi pārvalda labirinta izveidi, atjaunošanu
un likvidēšanu.

#events-table(
  caption: "Ar labirintiem saistīti notikumi",
  `SpawnMaze`,
  "Izveido jaunu labirintu",
  "Inicializē labirintu ar norādīto grīdu un konfigurāciju.",
  `RespawnMaze`,
  "Atjauno esošo labirintu",
  "Atjauno labirintu.",
  `DespawnMaze`,
  "Noņem labirintu",
  "Izdzēš labirinta entitātes norādītajam stāvam.",
) <events-maze>

==== Stāvu notikumi

Stāvu pārejas sistēma izmanto vienu uzskaitītu notikumu tipu (sk.
@tbl:events-floor), kas pārvalda vertikālo kustību starp stāviem.

#figure(
  caption: "Ar stāviem saistīti notikumi",
  kind: table,
  tablex(
    columns: (1fr, 1fr, 2fr),
    [*Notikums*],
    [*Variants*],
    [*Pielietojums*],
    `TransitionFloor`,
    `Ascend`,
    "Izraisa visu stāvu augšupejošu pāreju.",
    `TransitionFloor`,
    `Descend`,
    "Izraisa visu stāvu lejupejošu pāreju.",
  ),
) <events-floor>

==== Spēlētāju notikumi

Ar spēlētāju saistītie notikumi pārvalda spēlētāja entitātes dzīves ciklu (sk.
@tbl:events-player).
Līdzīgi kā labirintu notikumiem, šie apstrādā spēlētāja izveidošanu, atjaunošanu
un likvidēšanu.

#events-table(
  caption: "Ar spēlētaju saistīti notikumi",
  `SpawnPlayer`,
  "Izveido spēlētāja entitāti",
  "Inicializē jaunu spēlētāju starta pozīcijā.",
  `RespawnPlayer`,
  "Atjauno spēlētāju",
  "Atiestata spēlētāju uz pašreizējā stāva sākuma pozīciju.",
  `DespawnPlayer`,
  "Noņem spēlētāju",
  "Izdzēš spēlētāja entitātes.",
) <events-player>

=== Resursi

Bevy resursi kalpo kā globāli stāvokļa konteineri, kuriem var piekļūt jebkura
sistēma.
Atšķirībā no komponentiem, kas ir piesaistīti konkrētām entitātēm, resursi
nodrošina spēles mēroga datus un konfigurāciju.
Tie ir īpaši noderīgi kopīgu stāvokļu un iestatījumu pārvaldībai, kas var
ietekmē vairākas sistēmas@bevy-cheatbook[nod. ~14.6].
Spēle izmanto vairākus resursus globālās konfigurācijas un stāvokļa pārvaldībai
(sk. @tbl:resources)

#resources-table(
  caption: "Globālie resursi",
  `MazePluginLoaded`,
  "Spraudņa stāvokļa marķieris",
  "Norāda labirinta spraudņa inicializāciju.",
  `GlobalMazeConfig`,
  "Labirinta vizuālie iestatījumi",
  "Uzglabā globālos labirinta izskata parametrus.",
) <resources>

#indent-par[
  Resurss "`GlobalMazeConfig`" ir īpaši svarīgs, jo tas pārvalda labirinta vizuālo
  attēlojumu, ietverot tādus parametrus kā sešstūra lielums, sienu biezums un
  vertikālais augstums.
]

== Daļējs funkciju projektējums

#todo("pievienot funkciju projektējumu +diagrammas")



#figure(
  caption: "Stāva pārejas diagramma",
  kind: image,
  diagram(
    terminal-node((0, 0)),
    std-edge(),

    action-node((0, 1), [Pārbaudīt stāva\ pārejas notikumu]),
    std-edge(),

    decision-node((0, 2), [Vai stāvi\ kustās?]),
    std-edge("l,d", [jā]),
    std-edge("r,d", [nē]),

    terminal-node((-1, 3), extrude: (0, 3)),

    action-node((1, 3), [Iegūt pašreizējo\ stāvu]),
    std-edge(),

    decision-node((1, 4), [Stāva\ notikuma\ tips?]),
    std-edge("d", [Pacelties]),
    std-edge("r,d,d", [Nolaisties]),

    decision-node((1, 5), [Vai nākamais\ stāvs eksistē?]),
    std-edge("d", [jā]),
    std-edge("l,d", [nē]),

    action-node((0, 6), [Izsaukt jauna stāva\ izveides notikumu]),
    std-edge("d,d,r"),

    action-node((1, 6), [Aprēķināt katra stāva\ jaunās $Y$ koordinātas]),
    std-edge("d"),

    action-node((1, 7), [Pārvieto visus stāvus\ uz jaunajām $Y$ koordinātām]),
    std-edge("d"),

    decision-node((2, 6), [Pašreizējais\ stāvs $== 1$?]),
    std-edge("d,d,l", [jā]),
    std-edge("l", [nē]),

    terminal-node((1, 8), extrude: (0, 3)),
  ),
) <floor-transition-diagram>

#figure(
  caption: "Spēlētaja pārejas diagramma",
  kind: image,
  diagram(
    terminal-node((0, 0)),
    std-edge(),

    action-node((0, 1), [Pārbaudīt stāva\ pārejas notikumu]),
    std-edge(),

    decision-node((0, 2), [Vai stāvi\ kustās?]),
    std-edge("l,d", [jā]),
    std-edge("r,d", [nē]),

    terminal-node((-1, 3), extrude: (0, 3)),

    action-node((1, 3), [Iegūt pašreizējo\ stāvu]),
    std-edge(),

    decision-node((1, 4), [Stāva\ notikuma\ tips?]),
    std-edge("d", [Pacelties]),
    std-edge("r,d,d", [Nolaisties]),

    decision-node((1, 5), [Vai nākamais\ stāvs eksistē?]),
    std-edge("d", [jā]),
    std-edge("l,d", [nē]),

    action-node((0, 6), [Izsaukt jauna stāva\ izveides notikumu]),
    std-edge("d,d,r"),

    action-node((1, 6), [Aprēķināt katra stāva\ jaunās $Y$ koordinātas]),
    std-edge("d"),

    action-node((1, 7), [Pārvieto visus stāvus\ uz jaunajām $Y$ koordinātām]),
    std-edge("d"),

    decision-node((2, 6), [Pašreizējais\ stāvs $== 1$?]),
    std-edge("d,d,l", [jā]),
    std-edge("l", [nē]),

    terminal-node((1, 8), extrude: (0, 3)),
  ),
) <player-activity-diagram>


// ```pintora
// activityDiagram
// start
// partition "Ievades apstrāde" {
// :Pārbaudīt spēlētāja ievadi;
// if (Vai ir mērķpozīcija?) then (jā)
// :Skip Movement;
// else (nē)
// :Saņemt virzienu no ievades;
// if (Vai ir pareizs virziens?) then (jā)
// if (Vai ir siena virzienā?) then (jā)
// :Skip Movement;
// else (nē)
// :Iestata mērķpozīciju;
// endif
// else (nē)
// :Skip Movement;
// endif
// endif
// }
//
// partition "Movement Processing" {
// :Calculate Movement Speed;
// if (Has Target?) then (yes)
// :Calculate Target Position;
// if (Reached Target?) then (yes)
// :Update Current Position;
// :Clear Target;
// else (no)
// :Update Position;
// endif
// endif
// }
// partition "Floor Transition" {
// :Check Player Position;
// if (At End Position?) then (yes)
// :Send Ascend Event;
// else (no)
// if (At Start Position?) then (yes)
// if (Floor > 1?) then (yes)
// :Send Descend Event;
// endif
// endif
// endif
// }
// stop
// ```

=== Plākšņu pārvaldas sistēma

Projekta sākotnējā plānošanas posmā tika apsvēra iespēja labirinta elementu
pārvaldībai izmantot
"`bevy_ecs_tilemap`" bibliotēku.#footnote[https://crates.io/crates/bevy_ecs_tilemap]<bevy-ecs-tilemap>
Tomēr pēc rūpīgas izvērtēšanas tika secināts, ka tā neatbilst konkrētajam
projekta lietojuma gadījumam sekojošu iemeslu dēļ:
+ Uz failiem balstīta plākšņu ielāde: "`bevy_ecs_tilemap`" galvenokārt paļaujas uz
  plākšņu ielādi no ārējiem failiem. Šajā projektā ir nepieciešami dinamiski,
  procedurāli ģenerēti labirinti, tāpēc šī pieeja nav īsti piemērota.
+ Elastības ierobežojumi: bibliotēkas plākšņu datu struktūra nav viegli
  pielāgojama nepieciešamajai datu struktūrai, kurai ir nepieciešama
  sarežģītākām telpiskām attiecībām starp plāksnēm.
+ Prasības attiecībā uz sienu veidošanu: katrai sistēmas labirinta plāksnei
  var būt 0-6 sienas, kas tiek ģenerētas nejauši. Šādu dinamisku sienu ģenerēšanas
  līmeni nav viegli sasniegt izmantojot "`bevy_ecs_tilemap`".

#indent-par[
  Tā vietā, lai izmantotu "`bevy_ecs_tilemap`", tika izlemts izstrādāt pielāgotu
  risinājumu, kas tieši integrējas ar labirinta ģenerēšanas algoritmu. Šī
  pieeja ļauj:
]
- vienkāršāku integrācija ar procesuālo labirintu ģenerēšanu;
- optimālāku veiktspēja projekta lietošanas gadījumam;
- lielāku kontroli pār labirinta vizuālo attēlojumu.

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
"Clippy"
tiek izmantots koda analīzei, meklējot potenciālas problēmas un
neoptimālus risinājumus. Papildus noklusētajiem noteikumiem, tika aktivizēti
stingrāki koda kvalitātes pārbaudes līmeņi: "`pedantic`" režīms nodrošina
padziļinātu koda stila pārbaudi, "`nursery`" aktivizē eksperimentālās pārbaudes,
un "`unwrap_used`" un "`expect_used`" brīdina par potenciāli nedrošu kļūdu
apstrādi. Šie papildu noteikumi palīdz uzturēt augstāku koda kvalitāti un
samazināt potenciālo kļūdu skaitu @clippy.


/* Programmatūras statiskai testēšanai ir izmantots rīks „clang-tidy“, kas analizē
programmatūru, meklējot kļūdas un problēmas pirmkodā. [12] Rīks satur vairākas specifiskas
problēmu kopas, kas var tikt izmantotas analīzē. Tika izmantota „clang-analyzer“ problēmu
kopa. Vieglākai statisko testu darbināšanai tika izmantots vienkāršs programmēšanas valodas
„Python“ skripts, kas atlasa visus failus, kuru paplašinājums ir „cpp“ (valodas „C++“ pirmkoda
fails) vai „h“ (galvenes fails) un darbina statiskās analīzes rīku ar katru failu atsevišķi (sk.
izpildes rezultātu attēlā 4.3.). */

== Dinamiskā testēšana

Lai novērtētu programmatūras uzvedību darbības laikā, tika veikta dinamiskā
testēšana. Šī testēšanas pieeja apvieno gan manuālu testēšanu, izmantojot
lietotāja saskarnes mijiedarbību, gan automatizētus testu komplektus, lai
nodrošinātu visaptverošu spēles funkcionalitātes pārklājumu.

=== Manuālā integrācijas testēšana

Integrācijas testēšana ir veikta manuāli, mijiedarboties ar spēles saskarni.
Katrs testa scenārijs ir dokumentēta strukturētas tabulas formātā, ievērojot
būtisku informāciju, piemēram, test nosaukumu, unikālo identifikatoru, aprakstu,
izpildes soļus, gaidāmo rezultātu un faktisko rezultātu (veiksmīga testa
gadījumā apzīmēts ar "Ok", bet neveiksmīgu -- ar "Err").
Izvēlētie testu gadījumi ir detalizēti aprakstīti #todo("tab") tabulā.

#todo("add tests table")

=== Automatizēti testi

Automatizētā testēšanas sistēma plaši pārklāj bibliotēku "hexlab", jo tā ir
paredzēta publiskai lietošanai.
Testēšanas stratēģijā ir ieviesti vairāki pārbaudes līmeņi: dokumentācijas testi
no drošina piemēra koda pareizību, moduļu testi pārbauda iekšējo
funkcionalitāti, savukārt testu mapē esošie vienībtesti un integrācijas testi
pārbauda sarežģītākus gadījumus.
Izmantojot "cargo-tarpaulin", testu pārklājums ir $81,69%$ (116 no 142
iekļautajām rindiņām), tomēr šis rādītājs pilnībā neatspoguļo faktisko
pārklājumu, jo rīkam ir ierobežojumi attiecībā uz "inline"#footnote[https://doc.rust-lang.org/nightly/reference/attributes/codegen.html?highlight=inline]
funkcijām un citi tehniski ierobežojumi @cargo-tarpaulin.


#todo("double check which tests are actually impemented")
Arī spēles kods saglabā stabilu testēšanas stratēģiju.
Dokumentācijas testi tiek rakstīti tieši koda dokumentācijā, kalpojot diviem
mērķiem -- tie pārbauda koda pareizību un vienlaikus sniedz skaidrus lietošanas
piemērus turpmākai uzturēšanai.
Šie testi ir īpaši vērtīgi, jo tie nodrošina, ka dokumentācija tiek sinhronizēta
ar faktisko koda uzvedību.
Moduļu testi ir stratēģiski izvietoti līdzās implementācijas kodam tajā pašā
failā, nodrošinot, ka katras komponentes funkcionalitāte tiek pārbaudīta
izolēti.
Šie testi attiecas uz tādām svarīgām spēles sistēmām kā spēlētāju kustība,
sadursmju noteikšana, spēles stāvokļa pārvaldība u.c.

Visi testi tiek automātiski izpildīti kā nepārtrauktas integrācijas procesa
daļa, nodrošinot tūlītēju atgriezenisko saiti par sistēmas stabilitāti un
funkcionalitāti pēc katras koda izmaiņas.

= Programmas projekta organizācija

Kvalifikācijas darba prasības paredz, ka programmatūru un dokumentāciju autors
veido patstāvīgi, vadoties pēc darba vadītāja norādījumiem.

#todo("uzrakstīt projekta organizāciju")

== Kvalitātes nodrošināšana
Augstas koda kvalitātes nodrošināšana ir jebkura projekta būtisks aspekts.
Lai to panāktu, tiek izmantoti vairāki rīki un prakses, kas palīdz uzturēt tīru,
efektīvu un uzticamu koda.

Viens no galvenajiem rīkiem, kas tiek izmantots ir "Clippy"@clippy, kas analizē
iespējamās problēmas un iesaka uzlabojumus (sk. @static-tests nodaļu).

Kopā ar "Clippy" tiek arī izmantots "Rustfmt" @rustfmt, koda formatētājs, lai
uzturētu vienotu koda formatējumu visā projektā. Šis rīks automātiski formatē
kodu saskaņā ar Rust stila
vadlīnijām @rust-style.

Turklāt visas publiskās funkcijas un datu struktūras "hexlab" bibliotēkā ir
dokumentētas#footnote[https://docs.rs/hexlab/latest/hexlab/]<hexlab-docs>.
Šajā dokumentācijā ir ietverti detalizēti apraksti un lietošanas piemēri, kas ne
tikai palīdz saprast kodu, bet programmatūras prasības specifikācija ir
izstrādāta, ievērojot LVS 68:1996 standarta "Programmatūras prasību
specifikācijas ceļvedis" un LVS 72:1996 standarta "Ieteicamā prakse
programmatūras projektējuma aprakstīšanai" standarta prasības @lvs_68 @lvs_72.
// Programmatūras projektējuma aprakstā iekļautās
// aktivitāšu diagrammas ir izstrādātas, ievērojot UML 2.5 versijas
// specifikāciju@omg-uml.

== Konfigurācijas pārvaldība

Pirmkods tiek pārvaldīts, izmantojot "git"#footnote[https://git-scm.com/doc]<git> versiju kontroles sistēmu.
Repozitorijs tiek izvietots platformā "GitHub".
Rīku konfigurācija ir definēta vairākos failos:
- "justfile"#footnote[https://just.systems/man/en/]<justfile> -- satur atkļūdošanas un
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

Versiju specifikācija notiek pēc semantiskās versiju atlases (MAJOR.MINOR.PATCH) @sem-ver:
+ MAJOR -- galvenā versija, nesaderīgas izmaiņas, būtiskas koda izmaiņas.
+ MINOR -- atpakaļsaderīgas funkcionalitātes papildinājumi.
+ PATCH -- ar iepriekšējo versiju saderīgu kļūdu labojumi.

== Darbietilpības novērtējums
#todo("uzrakstīt darbietilpības novērtējumu")

= Secinājumi
#todo("uzrakstīt secinājumus")

#bibliography(
  title: "Izmantotā literatūra un avoti",
  "bibliography.yml",
)

#heading("Pielikumi", numbering: none)
// #include "code.typ"

#include "doc.typ"

#pagebreak()
#total-words words
