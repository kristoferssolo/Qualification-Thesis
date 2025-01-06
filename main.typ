#import "@preview/dashy-todo:0.0.1": todo
#import "@preview/i-figured:0.2.4"
#import "@preview/tablex:0.0.9": tablex, rowspanx, colspanx, cellx
#import "@preview/wordometer:0.1.3": word-count, total-words
#import "src/layout.typ": project, indent-par
#import "@preview/fletcher:0.5.3" as fletcher: diagram, node, edge
#import fletcher.shapes: diamond
#import "src/utils.typ": *
#import "src/diagrams.typ": *
#show: word-count

#show: project.with(
  university: "Latvijas Universitāte",
  faculty: [Eksakto zinātņu un tehnoloģiju fakultāte\ Datorikas nodaļa],
  thesis_type: "Kvalifikācijas darbs",
  title: [Spēles izstrāde, izmantojot\ Bevy spēļu dzinēju],
  authors: ("Kristiāns Francis Cagulis, kc22015",),
  advisor: "Mg. dat. Jānis Iljins",
  date: "Rīga 2025",
)
#set heading(numbering: none)
= Apzīmējumu saraksts
/ Audio: skaņas komponentes, kas ietver gan skaņas efektus, gan fona mūziku;
/ CI/CD: nepārtraukta integrācija un nepārtraukta izvietošana;
/ DPD: datu plūsmas diagramma;
/ ECS: entitāšu-komponenšu sistēma (angl. Entity-Component-System)@ecs;
/ Entitāte: unikāls identifikators, kas apvieno saistītās komponentes;
/ Jaucējtabula#footnote[https://lv.wikipedia.org/wiki/Jauc%C4%93jtabula]: jeb heštabula (angl. hash table)#footnote[https://en.wikipedia.org/wiki/Hash_table] ir datu struktūra, kas saista identificējošās vērtības ar piesaistītajām vērtībām;
/ Komponente: datu struktūra, kas satur tikai datus bez loģikas;
/ Notikums: īslaicīga ziņojuma struktūra, kas tiek izmantota komunikācijai starp sistēmām;
/ PPA: programmatūras projektējuma apraksts;
/ PPS: programmatūras prasību specifikācija;
/ Papildspēja: spēles mehānika, kas spēlētājam piešķir īslaicīgas priekšrocības vai papildu spējas (angl. power-up)#footnote[https://en.wikipedia.org/wiki/Power-up]<power-up>;
/ Pirmkods: cilvēkam lasāmas programmēšanas instrukcijas, kas nosaka programmatūras darbību;
/ Procedurāla ģenerēšana: algoritmisks satura radīšanas process, kas automātiski ģenerē datus izpildes laikā, nevis izmanto manuāli, iepriekš veidotu saturu;
/ Renderēšana: process, kurā tiek ģenerēta vizuāla izvade;
/ Resurss: globāli pieejama datu struktūra, kas nav piesaistīta konkrētai entitātei;
/ Režģis: strukturēts šūnu izkārtojums, kas veido spēles pasaules pamata struktūru;
/ Sistēma: loģikas vienība, kas apstrādā entitātes ar specifiskām komponentēm;
/ Spēlētājs: entitāte, kas reprezentē lietotāja vadāmo objektu spēlē;
/ Sēkla: skaitliska vērtība, ko izmanto nejaušo skaitļu ģeneratora inicializēšanai;
/ Šūna: sešstūraina režģa viena pozīcija, kas definē telpu, kuru var aizņemt viena plāksne;
/ WASM: WebAssembly -- zema līmeņa assemblera tipa kods, kas var darboties modernos tīmekļa pārlūkos.

= Ievads
== Nolūks
Šī programmatūras prasību specifikācija (PPS) ir izstrādāta, lai definētu un
dokumentētu procedurāli ģenerētas sešstūru labirinta spēles "Maze Ascension"
programmatūras prasības, arhitektūru un tehnisko implementāciju. Dokumenta
galvenais uzdevums ir nodrošināt skaidru un visaptverošu projekta aprakstu, kas
kalpo gan kā tehniskā specifikācija, gan kā izpētes dokumentācija Bevy spēļu
dzinēja iespēju demonstrēšanai.

== Darbības sfēra
Darba galvenā uzmanība ir vērsta uz būtisku spēles mehāniku ieviešanu, tostarp
procedurālu labirintu ģenerēšanu, spēlētāju navigācijas sistēmu, papildspēju
integrāciju un vertikālās progresijas mehāniku, vienlaikus ievērojot minimālisma
dizaina filozofiju.

Spēles pamatā ir procedurāli ģenerēti sešstūra labirinti, kas katrā spēlē rada
unikālu vizuālu un navigācijas izaicinājumu. Procedurālās ģenerēšanas sistēma
nodrošina, ka:

- katrs labirints tiek unikāli ģenerēts "uzreiz"#footnote[Attiecas uz gandrīz
  tūlītēju labirintu ģenerēšanu, kas notiek milisekunžu
  laikā.], nodrošinot "bezgalīgu"#footnote[Lai gan sistēma izmanto `u64` sēklas,
  kas ir galīgas, iespējamo labirinta konfigurāciju skaits ir ārkārtīgi liels,
  tādējādi praktiskiem mērķiem nodrošinot praktiski bezgalīgu labirintu
  skaitu.] daudzveidību;
- labirinta sarežģītību var dinamiski pielāgot spēlētājam progresējot;
- uzglabāšanas prasības tiek samazinātas līdz minimumam, ģenerējot labirintus reāllaikā.

#indent-par[
  Spēlētāju uzdevums ir pārvietoties pa šiem procedurāli ģenerētajiem labirintiem,
  lai sasniegtu katra līmeņa beigas. Turpinot progresēt, spēlētāji saskaras ar
  arvien sarežģītākiem labirintiem, kuros nepieciešama stratēģiskā domāšana,
  izpēte un papildu prasmju izmantošana.
]

Spēlētājam progresējot, tie sastopas ar dažādiem uzlabojumiem un
papildspējām, kas stratēģiski izvietoti labirintos. Šī funkcija padziļina spēlēšanas
pieredzi, veicinot izpēti un eksperimentēšanu ar dažādām spēju kombinācijām,
radot dinamiskākus un aizraujošākus spēles scenārijus.

No tehniskā viedokļa darbā tiek pētīta šo funkciju īstenošana, izmantojot
Bevy entitāšu-komponenšu sistēmas (turpmāk tekstā -- ECS) arhitektūru.
Tas ietver stabilu spēles vides sistēmu izstrādi, stāvokļa pārvaldības
mehānismus un efektīvu Bevy iebūvēto funkciju izmantošanu.

No darbības sfēras apzināti izslēgta daudzspēlētāju funkcionalitāte un sarežģīti
grafiskie efekti, koncentrējoties uz pulētu viena spēlētāja pieredzi ar skaidru,
minimālistisku vizuālo noformējumu. Šāda mērķtiecīga pieeja ļauj padziļināti
izpētīt spēles pamatmehāniku, vienlaikus nodrošinot projekta vadāmību un
tehnisko iespējamību.

== Saistība ar citiem dokumentiem
PPS ir izstrādāta, ievērojot LVS 68:1996 "Programmatūras prasību specifikācijas
ceļvedis" @lvs_68 un LVS 72:1996 "Ieteicamā prakse programmatūras projektējuma
aprakstīšanai" standarta prasības @lvs_72.

== Pārskats
Šis dokuments sniedz detalizētu programmatūras prasību specifikāciju spēlei
"Maze Ascension", aprakstot tās arhitektūru, galvenās komponentes un to
mijiedarbību.
Dokumentā ir apkopota informācija par spēles tehnisko implementāciju, izmantojot
Bevy spēļu dzinēju un ECS arhitektūru.

Ievada sadaļa iepazīstina ar projekta pamatkonceptu, definējot spēles galvenos
mērķus un uzdevumus.
Šajā nodaļā tiek aprakstīta spēles ideja -- procedurāli ģenerēts labirints ar
sešstūrainu lauku, kas piedāvā unikālu spēles pieredzi katrā spēles reizē.
Tiek skaidrota arī spēles vertikālās progresijas sistēma un papildspēju
mehānikas, kas padara spēli izaicinošāku un interesantāku.

Programmatūras prasību specifikācijas sadaļa detalizētāk apraksta sistēmas
funkcionālās prasības un arhitektūru.
Izmantojot datu plūsmas diagrammas, tiek ilustrēta sistēmas moduļu mijiedarbība
un datu plūsmas starp tiem.
Šajā sadaļā tiek aprakstīti pieci galvenie moduļi: spēles stāvokļa pārvaldības
modulis, labirinta pārvaldības modulis, spēlētāja modulis, stāvu pārvaldības
modulis un papildspēju modulis.
Katram modulim ir detalizēts funkciju apraksts, kas dokumentēts, izmantojot
funkciju tabulas.

Programmatūras projektējuma sadaļa sniedz detalizētu tehnisko specifikāciju.
Datu struktūru projektējuma apakšsadaļā tiek aprakstītas ECS arhitektūras
komponentes, notikumi un resursi.
Daļējā funkciju projektējuma apakšsadaļā tiek detalizēta šūnu pārvaldības
sistēma un citas būtiskas funkcijas.
Saskarņu projektējuma apakšsadaļā tiek aprakstīta lietotāja saskarnes
arhitektūra un implementācija.

Testēšanas dokumentācijas sadaļa aptver gan statisko, gan dinamisko testēšanu.
Statiskās testēšanas apakšsadaļā tiek aprakstītas koda kvalitātes pārbaudes
metodes un rīki.
Dinamiskās testēšanas apakšsadaļā tiek detalizētāk izskatīta gan manuālā
integrācijas testēšana, gan automatizēto testu implementācija, sniedzot
konkrētus piemērus un rezultātus.

Projekta organizācijas sadaļa apraksta projekta pārvaldības aspektus.
Kvalitātes nodrošināšanas apakšsadaļa detalizē izmantotās metodes un rīkus koda
kvalitātes uzturēšanai.
Konfigurācijas pārvaldības apakšsadaļa apraksta versiju kontroles sistēmu un
izstrādes procesu, bet darbietilpības novērtējuma apakšsadaļa sniedz projekta
resursu un laika patēriņa analīzi.

Secinājumu sadaļā tiek apkopoti galvenie projekta sasniegumi, izaicinājumi un to
risinājumi.
Šeit tiek izvērtēta izvēlēto tehnoloģiju un metožu efektivitāte, kā arī sniegti
ieteikumi turpmākai projekta attīstībai.

#set heading(numbering: "1.1.")
= Vispārējais apraksts
== Esošā stāvokļa apraksts
Pašreizējo spēļu izstrādes ainavu raksturo pieaugoša interese pēc neatkarīgajām
spēlēm un modernu, efektīvu spēļu dzinēju izmantošana. Izstrādātāji arvien
biežāk meklē rīkus, kas piedāvā elastību, veiktspēju un lietošanas ērtumu.
Spēļu dzinējs Bevy ar savu moderno arhitektūru un Rust programmēšanas valodas
izmantošanu gūst arvien lielāku popularitāti izstrādātāju vidū, pateicoties tā
drošām, paralēlām sistēmām.

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
un itch.io platformas,#footnote[https://itch.io/]<itch-io> kas ir
populāra neatkarīgo spēļu platforma, kas ļauj viegli piekļūt un izplatīt spēles
visā pasaulē.

== Darījumprasības
Sistēmas izstrādē tiek izvirzītas sekojošas darījumprasības, kas nodrošinās
kvalitatīvu lietotāja pieredzi:

- Līmeņu pārvaldība: Sistēma nodrošinās automātisku spēles līmeņu pārvaldību un
  vienmērīgu pāreju starp tiem, veidojot pakāpenisku grūtības pieaugumu.
- Līmeņu ģenerēšana: Sistēma nodrošinās procedurālu līmeņu ģenerēšanu, radot
  unikālus sešstūrainus labirintus katram spēles stāvam, garantējot, ka katrs
  labirints ir pilnībā izejams.
- Tieša piekļuve: Spēle būs pieejama bez lietotāja konta izveides vai
  autentifikācijas, nodrošinot tūlītēju piekļuvi spēles saturam.
- Platformu atbalsts: Sistēma tiks izstrādāta ar daudzplatformu atbalstu,
  ietverot Linux, macOS, Windows un WebAssembly platformas.
- Kopienas integrācija: Izmantojot itch.io@itch-io platformu, tiks nodrošināta
  spēlētāju atsauksmju apkopošana un kopienas atbalsts.
- Nepārtraukta izstrāde: Izmantojot CI/CD risinājumus, tiks nodrošināta regulāra
  spēles atjaunināšana un uzturēšana.

== Sistēmas lietotāji
Sistēma ir izstrādāta, ņemot vērā vienu lietotāja tipu -- spēlētājs. Spēlētāji
ir personas, kas iesaistās spēlē, lai pārvietotos pa tās labirinta struktūrām.
Tā kā spēlei nav nepieciešami lietotāja konti vai autentifikācija, visiem
spēlētājiem ir vienlīdzīga piekļuve spēles funkcijām un saturam no spēles sākuma
brīža.

Ar lietotāju saistītās datu plūsmas ir attēlotas sistēmas nultā līmeņa DPD
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
// + Izstrādes vides un tehnoloģijas ierobežojumi:
//   + Programmēšanas valodas un Bevy spēles dzinēja tehniskie ierobežojumi;
//   + Responsivitāte;
//   + Starpplatformu savietojamība: Linux, macOS, Windows un WebAssembly.


+ Izstrādes vides un tehnoloģijas ierobežojumi:
  + Bevy dzinēja tehniskie ierobežojumi:
    + ECS arhitektūras specifika un tās ierobežojumi datu organizācijā;
    + "Render Graph"#footnote[https://docs.rs/bevy_render/latest/bevy_render/render_graph/struct.RenderGraph.htmlhttps://docs.rs/bevy_render/latest/bevy_render/render_graph/struct.RenderGraph.html] sistēmas ierobežojumi grafisko elementu attēlošanā;
    + atkarība no "wgpu"#footnote[https://wgpu.rs/] grafikas bibliotēkas iespējām.
  + Rust programmēšanas valodas ierobežojumi:
    + stingra atmiņas pārvaldība (angl. memory management) un īpašumtiesību (angl. ownership) sistēma;
    + kompilācijas laika pārbaudes un to ietekme uz izstrādes procesu;
    + WebAssembly kompilācijas specifika.
+ Platformu atbalsta ierobežojumi:
  + Nepieciešamība nodrošināt savietojamību ar:
    + darbvirsmas platformām (Linux, macOS, Windows);
    + tīmekļa pārlūkprogrammām caur WebAssembly.
  + Platformu specifiskās prasības attiecībā uz:
    + grafikas renderēšanu;
    + ievades apstrādi;
    + veiktspējas optimizāciju.

#indent-par[
  Dokumentācijas izstrādei ir izmantots Typst rīks, kas nodrošina efektīvu darbu
  ar tehnisko dokumentāciju, ieskaitot matemātiskas formulas, diagrammas un koda
  fragmentus @typst.
]

== Pieņēmumi un atkarības
- Tehniskie pieņēmumi:
  - Spēlētāja ierīcei jāatbilst minimālajām aparatūras prasībām, lai varētu
    palaist uz Bevy spēles dzinēja balstītas spēles;
  - ierīcei jāatbalsta WebGL2 #footnote("https://registry.khronos.org/webgl/specs/latest/2.0/");
    lai nodrošinātu pareizu atveidošanu @webgl2;
  - tīmekļa spēļu spēlēšanai (WebAssembly versija) pārlūkprogrammai jābūt mūsdienīgai un saderīgai ar WebAssembly;
  - ekrāna izšķirtspējai jābūt vismaz $800 times 600$ pikseļi.
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
ārējs (bibliotēkas) process(-i):
stāva pārvaldības modulis,
labirinta ģenerēšanas un pārvaldības moduļi,
spēlētāja modulis,
spēles stāvokļa pārvalības modulis,
papildspēju modulis
un izstrādes rīku modulis.
Šie procesi mijiedarbojas ar vienu datu krātuvi -- operatīvo atmiņu (RAM) -- un vienu
ārējo lietotāju -- spēlētājs.

Bevy spēļu dzinējs diagrammā ir attēlots kā ārējs process vairāku iemeslu dēļ.
Pirmkārt, Bevy nodrošina pamata infrastruktūru spēles darbībai, ieskaitot
ievades apstrādi, renderēšanu un audio atskaņošanu.
Tā rezultātā visa lietotāja mijiedarbība ar spēli (tastatūras, peles ievade)
vispirms tiek apstrādāta caur Bevy sistēmām, pirms tā nonāk līdz spēles
specifiskajiem moduļiem.

Operatīvā atmiņa (RAM) ir vienīgā datu krātuve diagrammā, jo Bevy ECS
arhitektūra balstās uz komponenšu datiem, kas tiek glabāti operatīvajā atmiņā un
spēles stāvoklis netiek pastāvīgi saglabāts diskā.

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

    rowspanx(2)[Stāva pārvaldības modulis], // floor
    [Stāva kustība],
    [#link(<floor-F01>)[SPMF01]],
    [Stāvu pārejas apstrāde],
    [#link(<floor-F02>)[SPMF02]],

    rowspanx(1)[Labirinta ģenerēšanas modulis], // hexlab
    [Labirinta būvētājs],
    [#link(<hexlab-F01>)[LGMF01]],

    rowspanx(2)[Labirinta pārvaldības modulis], // maze
    [Labirinta ielāde],
    [#link(<maze-F01>)[LPMF01]],
    [Labirinta pārlāde],
    [#link(<maze-F02>)[LPMF02]],

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
    [Spēlētāja ievades apstrāde],
    [#link(<power-up-F01>)[PSMF01]],
    [Ceļa rādīšanas papildspēja],
    [#link(<power-up-F02>)[PSMF02]],
    [Sienu pārlēkšanas papildspēja],
    [#link(<power-up-F03>)[PSMF03]],
  ),
) <function-modules>

=== Izstrādes rīku modulis

Dotais modulis ir izstrādes rīks, kas paredzēts lietotāja saskarnes elementu
attēlošanai un apstrādei, lai konfigurētu labirinta parametrus.
Šis modulis, izmantojot "bevy_egui"@bevy-egui un "inspector-egui"@bevy-inspector-egui
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

#function-table(
  "Labirinta pārvadības saskarne",
  "IRMF01",
  [Apstrādā un izvada labirinta konfigurācijas vadības elementus lietotāja saskarnē.],
  [
    + "`EguiContext`" komponente;#footnote[https://docs.rs/bevy_egui/latest/bevy_egui/]<bevy_egui>
    + Labirinta konfigurācija un stāva komponentes saistībā ar pašreizējā stāva
      komponenti;
    + Globālais labirinta konfigurācijas resurss.
  ],
  [
    + Saņem "`EguiContext`" komponenti no primārā loga.
    + Saņem labirinta konfigurāciju un stāvu komponentes no pašreizējā stāva.
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
Stāvu pārvaldības modulis nodrošina vertikālo pārvietošanos starp spēles
līmeņiem.
Modulis sastāv no divām galvenajām funkcijām (sk. @fig:dpd-2-floor):
stāvu kustības (sk. @tbl:floor-F01) un stāvu
pārejas apstrādes (sk. @tbl:floor-F02).
Stāvu kustības sistēma nodrošina plūstošu vertikālo pārvietošanos starp
līmeņiem, savukārt pārejas apstrādes sistēma koordinē pārejas starp pašreizējo
un nākamo stāvu, reaģējot uz "TransitionFloor" notikumu (sk. @tbl:events-floor).

#figure(
  caption: [Stāvu pārvaldības moduļa 2. līmeņa DPD],
  diagram(
    spacing: (8em, 4em),
    {
      process((-1, 0), [Stāvu\ kustība])
      dpd-edge("d,r,u", align(center)[Atjaunoti labirinta\ entitātes dati])

      dpd-database((0, 0), [Operatīvā\ atmiņa])
      dpd-edge("u,l,d", align(center)[Atjaunotie labirinta\ entitātes dati])

      dpd-edge("u,r,d", align(center)[Labirinta\ konfigurācijas dati])
      dpd-edge("uu,r,dd", align(center)[Labirinta entitātes dati])
      dpd-edge("uuu,r,ddd", align(center)[Sistēmas notikumu dati])

      process((1, 0), [Stāvu pārejas\ apstrāde])
      dpd-edge("d,l,u", align(center)[Atjaunoti labirinta\ entitātes dati])
    },
  ),
) <dpd-2-floor>

#function-table(
  "Stāvu kustība",
  "SPMF01",
  "Nodrošina plūstošu pāreju starp stāviem, pārvietojot tos vertikāli.",
  [
    + Labirinta entitātes ar galamērķa $Y$ pozīcijām.
  ],
  [
    + Aprēķina kustības attālumus.
    + Pārvieto stāvus uz galamērķi ar noteiktu ātrumu.
    + Atjaunina stāvu pozīcijas datus.
    + Noņem mērķa komponentes pēc sasniegšanas.
  ],
  [
    + Atjaunināto stāva pozīcijas.
  ],
) <floor-F01>

#function-table(
  "Stāvu pārejas apstrāde",
  "SPMF02",
  "Apstrādā stāvu pārejas notikumus un koordinē pārejas starp stāviem.",
  [
    + Pārejas notikums.
    + Stāvas entitātes.
    + Pašreizējais stāvs.
  ],
  [
    + Pārbauda vai ir aktīva pāreja.
      + Ja ir, iziet no sistēmas un nedara neko.
    + Aprēķina galamērķu pozīcijas.
    + Pievieno mērķa komponentes stāvu entitātēm.
    + Atjauno stāvu statusus:
      + Noņem pašreizējā stāva komponenti no pašreizējā stāva entitātes.
      + Pievieno pašreizējā stāva komponenti nākamā stāva entitātei.
  ],
  [
    + Atjaunināts stāvs.
  ],
) <floor-F02>

=== Labirinta ģenerēšanas modulis

Moduļa funkcionalitāte ir izmantota sešstūraina labirinta ģenerēšanai,
balstoties uz "Hexagonal Grids"
rakstu @hex-grid, kas jau ir
kļuvis par _de facto_ standartu sešstūrainu režģu matemātikas un algoritmu
implementācijai.
Moduļa funkciju datu plūsmas ir parādītas 2. līmeņa datu plūsmas diagrammā (sk. @fig:dpd-2-hexlab).
Labirinta būvēšanas funkcija ir aprakstītas atsevišķā tabulā (sk. @tbl:hexlab-F01).

Modularitātes un atkārtotas lietojamības apsvērumu dēļ, labirinta ģenerēšanas
funkcionalitāte ir izveidota kā ārēja bibliotēka
"hexlib".#footnote[https://crates.io/crates/hexlab]<hexlab>
Šis lēmums ļauj labirinta ģenerēšanas loģiku atkārtoti izmantot dažādos
projektos un lietojumprogrammās, veicinot atkārtotu koda izmantošanu.
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
      + Pārbauda rādiusa esamību un derīgumu.
      + Validē sākuma pozīciju, ja tāda norādīta.
    + Izveido sākotnējo labirinta struktūru:
      + Inicializē tukšu labirintu ar norādīto rādiusu.
      + Katrai šūnai iestata sākotnējās (visas) sienas.
    + Validē sākuma pozīciju, ja tāda norādīta.
    + Ģenerē labirintu:
      + Rekursīvi izveido ceļus, noņemot sienas starp šūnām.
      + Izmanto atpakaļizsekošanu, kad sasniegts strupceļš.
  ],
  [
    + Jaucējtabulu, kas satur:
      + Sešstūra koordinātes kā atslēgās.
      + Sešstūra objekti ar:
        + Pozīcijas koordinātēm ($x$, $y$).
        + Sienu konfigurāciju (8-bitu maska).
  ],
  [
    + Lai izveidotu labirintu, ir jānorāda rādiuss.
    + Sākuma pozīcija ir ārpus labirinta robežām.
    + Neizdevās izveidot labirintu.
  ],
) <hexlab-F01>

=== Labirinta pārvaldības modulis
Labirinta pārvaldības modulis ir atbildīgs par labirintu ģenerēšanu un
pārvaldību katrā spēles stāvā. Moduļa funkciju datu plūsmas ir attēlotas 2.
līmeņa datu plūsmas diagrammā (sk. @fig:dpd-2-maze).

Modulis nodrošina divas galvenās funkcijas: labirinta izveidi
(sk. @tbl:maze-F01) un labirinta atjaunošanu (sk. @tbl:maze-F02).
Labirinta izveides funkcija tiek izsaukta, kad nepieciešams izveidot jaunu
stāvu, pārbaudot, vai šāds stāvs jau neeksistē.
Funkcija ģenerē jaunu labirintu, izmantojot norādīto konfigurāciju, un izvieto
to atbilstošā augstumā spēles pasaulē.

Labirinta atjaunošanas funkcija ļauj pārģenerēt esošā stāva labirintu,
saglabājot to pašu stāva numuru un pozīciju telpā nemainot entitātes
identifikatoru.

#figure(
  caption: [Labirinta pārvaldības moduļa 2. līmeņa DPD],
  diagram(
    spacing: (8em, 4em),
    {
      process((-1, 0), [Labirinta\ ielāde])
      dpd-edge("d,r,u", align(center)[Labirinta entitātes dati])

      dpd-database((0, 0), [Operatīvā\ atmiņa])
      dpd-edge("u,l,d", align(center)[Labirinta\ konfigurācijas dati])
      dpd-edge("u,r,d", align(center)[Labirinta\ konfigurācijas dati])
      dpd-edge("uu,r,dd", align(center)[Labirinta entitātes dati])

      process((1, 0), [Labirinta\ pārlāde])
      dpd-edge("d,l,u", align(center)[Atjaunoti labirinta\ entitātes dati])
    },
  ),
) <dpd-2-maze>

#function-table(
  "Labirinta ielāde",
  "LPMF01",
  "Izveido jaunu labirinta stāvu spēles pasaulē.",
  [
    + Labirinta konfigurācija.
    + Globālā konfigurācija.
  ],
  [
    + Pārbauda, vai labirints šim stāvam jau eksistē.
      + Ja eksistē, parāda 1. paziņojumu un iziet no sistēmas.
    + Ģenerē jaunu labirintu balstoties uz doto konfigurāciju.
    + Aprēķina vertikālo nobīdi jaunajam stāvam.
    + Izveido jaunu entitāti, kas pārstāv labirinta stāvu, pievienojot tam
      atbilstošās komponente.
    + Atkarībā no tā, vai tas ir pašreizējais stāvs, pievieno
      pašreizējā stāva komponenti.
    + Izveido jaunas entitātes, kas pārstāv labirinta šūnas, kā bērnu
      elementus labirinta entitātei.
    + Katrai labirinta šūnai atbilstoši labirinta konfigurācijai, izveido
      sienas bērnu entitātes.
  ],
  [
    + Labirinta entitāte.
  ],
  [
    + "Stāvs $x$ jau eksistē."
    // + "Neizdevās ģenerēt labirintu stāvam $x$."
  ],
) <maze-F01>

#function-table(
  "Labirinta pārlāde",
  "LPMF02",
  "Izveido jaunu labirinta stāvu spēles pasaulē.",
  [
    + Stāva numurs, kuru atjaunot.
    + Labirinta konfigurācija.
    + Globālā konfigurācija.
  ],
  [
    + Pārbauda, vai labirints doto stāvu eksistē.
      + Ja neeksistē, parāda 1. paziņojumu un iziet no sistēmas.
    + Ģenerē jaunu labirintu balstoties uz doto konfigurāciju.
    + Izdzēš visus labirinta entitātes pēcnācēju entitātes.
    + Izveido jaunas entitātes, kas pārstāv labirinta šūnas, kā bērnu
      elementus labirinta entitātei.
    + Katrai labirinta šūnai atbilstoši labirinta konfigurācijai, izveido
      sienas bērnu entitātes.
  ],
  [
    + Labirinta entitāte.
  ],
  [
    + "Neizdevās atrast labirinta stāvu $x$."
  ],
) <maze-F02>

=== Spēlētāja modulis
Spēlētāja modulis ir atbildīgs par spēlētāja entītijas pārvaldību, kas ietver
tās izveidi, kustību apstrādi un mijiedarbību ar spēles vidi.
Moduļa datu plūsma ir attēlota 2. līmeņa datu plūsmas diagrammā (sk.
@fig:dpd-2-player), kas parāda četras galvenās funkcijas un to mijiedarbību ar
datu glabātuvi.

Spēlētāja kustība tiek realizēta divās daļās: ievades apstrāde
(@tbl:player-F02) un kustības izpilde (@tbl:player-F03).
Ievades apstrādes funkcija pārbauda tastatūras ievadi
un, ņemot vērā labirinta sienu izvietojumu, nosaka nākamo kustības mērķi.
Kustības izpildes funkcija nodrošina plūstošu pārvietošanos uz mērķa pozīciju,
izmantojot interpolāciju#footnote[Matemātiska metode, kas aprēķina starpvērtības
starp diviem zināmiem punktiem.] starp pašreizējo un mērķa pozīciju.

Stāvu pārejas apstrāde nepārtraukti uzrauga spēlētāja pozīciju
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
    + Izveido spēlētāja entitāti ar pašreizējās pozīcijas komponenti.
  ],
  [
    + Spēlētāja entitāte.
  ],
) <player-F01>

#function-table(
  "Spēlētāja ievades apstrāde",
  "SPMF02",
  "Apstrādā spēlētāja tastatūras ievadi un aprēķina nākamo kustības šūnu.",
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
    + Kustības mērķa šūnas pozīcija.
  ],
) <player-F02>

#function-table(
  "Spēlētāja kustība",
  "SPMF03",
  "Atjaunina spēlētāja pozīciju, veicot plūstošu pārvietošanos uz mērķa šūnas pozīciju.",
  [
    + Kustības mērķis.
    + Kustības ātrums.
    + Pašreizējā pozīcija.
    + Labirinta konfigurācija.
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
un pārejas starp tiem. Modulis sastāv no trim galvenajām funkcijām:
spēles sākšana (@tbl:screen-F01),
atgriešanās uz sākumekrānu (@tbl:screen-F02) un
sākumekrāna attēlošanas (@tbl:screen-F03).
Katra no šīm funkcijām apstrādā specifiskus lietotāja ievades datus un
atbilstoši atjaunina spēles stāvokli.

Moduļa 2. līmeņa DPD diagramma (sk. @fig:dpd-2-screen) parāda, ka lietotājs
mijiedarbojas ar sistēmu izmantojot divus galvenos ievades veidus: pogu izvēli
sākumekrānā un "Escape" taustiņa nospiešanu spēles laikā.

Spēles sākšanas funkcija inicializē nepieciešamos resursus un
sistēmas, kad lietotājs izvēlas sākt jaunu spēli.
Atgriešanās funkcija apstrādā lietotāja pieprasījumu pārtraukt aktīvo spēli un
atgriežas uz sākumekrānu.

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
      align(center)[Spēles\ stāvokļa dati],
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
      - pogu "Exit" (tikai platformām, kas nav WASM).
    + Pievieno novērotājus katrai pogai.
  ],
  [
    Izvades datu sistēmai nav.
  ],
) <screen-F03>


=== Papildspēju modulis

Papildspēju modulis nodrošina spēlētājam papildu iespējas labirinta izpētē,
piedāvājot divas galvenās funkcijas: sienu pārlēkšanu un izejas ceļa parādīšanu
(sk. @fig:dpd-2-powerup).

#figure(
  caption: [Papildspēju moduļa 2. līmeņa DPD],
  diagram(
    spacing: (8em, 4em),
    {
      data-store((0, 0), [Spēlētājs])
      dpd-edge("r", align(center)[Tastatūras\ ievades dati])

      process((1, -1), [Ceļa rādīšanas\ papildspēja])
      dpd-edge(
        "dr",
        align(center)[Ceļa marķieru\ dati],
        label-pos: 0.4,
      )

      process((1, 0), [Spēlētāja\ ievades apstrāde])
      dpd-edge("r", align(center)[Papildspēju\ notikumu dati])

      process((1, 1), [Sienu pārlēkšanas\ papildspēja])
      dpd-edge(
        "ur",
        align(center)[Atjaunoti spēlētāja\ entitātes dati],
        label-pos: 0.3,
      )

      dpd-database((2, 0), [Operatīvā\ atmiņa])
      dpd-edge(
        "u,l",
        align(center)[Papildspēju\ notikumu dati],
        label-pos: 0.65,
      )
      dpd-edge(
        "d,l",
        align(center)[Papildspēju\ notikumu dati],
        label-pos: 0.65,
      )
    },
  ),
) <dpd-2-powerup>

#function-table(
  "Spēlētāja ievades apstrāde",
  "PSMF01",
  "Apstrādā spēlētāja tastatūras ievadi un aktivizē attiecīgo papildspēju.",
  [
    + Tastatūras ievade.
    + Globālā konfigurācija.
    + Papildspējas atdzišanas stāvoklis.
    + Atdzišanas laiks.
  ],
  [
    + Pārbauda lēkšanas papildspējas ievadi.
      + Iegūst lēkšanas taustiņu no konfigurācijas.
      + Ja taustiņš nospiests un nav atdzišanas periodā.
        + Izsauc lēkšanas notikumu.
    + Pārbauda ceļa rādīšanas papildspējas ievadi.
      + Iegūst ceļa rādīšanas taustiņu no konfigurācijas
      + Ja taustiņš nospiests un nav atdzišanas periodā.
        + Izsauc ceļa parādīšanas notikumu.
  ],
  [
    + Papilspējas notikums.
  ],
) <power-up-F01>

#function-table(
  "Ceļa rādīšanas papildspēja",
  "PSMF02",
  "Rāda ceļu uz izeju noteiktu laiku periodu.",
  [
    + Papilspējas notikums.
    + Pašreizējā spēlētāja pozīcija.
    + Labirinta konfigurācija.
    + Laiks.
  ],
  [
    + Aprēķina īsāko ceļu no pašreizējās pozīcijas līdz labirinta izejai.
    + Izveido ceļa marķieru entitātes.
    + Seko līdzi atlikušajam laikam.
      + Ja laiks pārsniedz 10 sekundes, izdzēš ceļa marķierus.
  ],
  [
    + Ceļa vizualizācijas dati.
  ],
) <power-up-F02>

#function-table(
  "Sienu pārlēkšanas papildspēja",
  "PSMF03",
  "Ļauj pārlēkt pāri sienām.",
  [
    + Lēciena pozīcijas dati
    + Papilspējas notikums.
    + Kustības mērķis.
    + Kustības ātrums.
    + Pašreizējā spēlētāja pozīcija.
    + Labirinta konfigurācija.
  ],
  [
    + Aprēķina mērķa pozīciju pasaules koordinātēs.
    + Pārbauda sienas esamību.
    + Pārvieto spēlētāju uz mērķi ar noteiktu ātrumu.
    + Atjaunina pozīcijas datus.
  ],
  [
    + Atjauninātā pozīcija.
    + Transformācijas dati.
  ],
) <power-up-F03>


== Nefunkcionālās prasības
=== Veiktspējas prasības
Uz sistēmas veiktspēju ir sekojošas prasības:
- Jebkura izmēra labirintam jātiek uzģenerētam ātrāk kā 1 sekundē.
- Spēlei jāstartējas ātrāk par 3 sekundēm.
- Spēlei jādarbojas ar vismaz 60 kadriem sekundē.
- Spēlētāja kustībām jātiek apstrādātā bez manāmas aizkaves ($<16$ms).

=== Uzticamība
Uz sistēmas uzticamību ir sekojošas prasības:
- Kļūdu apstrāde: spēlei jāapstrādā kļūdas graciozi, bez sistēmas atteicēm.
// - Saglabāšana: spēles progresam jātiek automātiski saglabātam pēc katra līmeņa.
// - Atjaunošanās: spēlei jāspēj atjaunoties pēc negaidītas aizvēršanas.

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

= Programmatūras projektējuma apraksts
== Datu struktūru projektējums

Spēle ir veidota, izmantojot Bevy spēles dzinēju, kas īstenu
entitāšu-komponenšu sistēmu (ECS) arhitektūras modeli.
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
pašreizējā stāva stāvokli un vertikālās kustības mehāniku.

#components-table(
  caption: "Ar stāviem saistītās komponentes",
  `Floor`,
  "Stāva numurs",
  "Identificē, kurai entitātei ir kurš stāvs.",
  `CurrentFloor`,
  "Atzīmē pašreizējo stāvu",
  "Identificē pašreizējo stāvu.",
  `FloorYTarget`,
  "Stāva nākamā Y pozīcija",
  "Identificē stāva Y koordināti, uz kuru tas jāpārvieto.",
) <components-floor>

==== Labirinta komponentes

Labirinta struktūru pārvalda vairāki savstarpēji saistītas komponentes,
kas ir atbildīgas par labirinta uzturēšanu (sk. @tbl:components-maze).
#pagebreak()
#components-table(
  caption: "Ar labirintiem saistītās komponentes",
  `HexMaze`,
  "Galvenais labirinta marķieris",
  "Identificē labirinta entitāti un pieprasa nepieciešamās atkarības.",
  `Tile`,
  "Apzīmē labirinta sešstūra šūnu",
  "Identificē labirinta vietas, pa kurām var staigāt.",
  `Wall`,
  "Apzīmē labirinta sienas",
  "Identificē sadursmju robežas.",
  `MazeConfig`,
  "Glabā labirinta parametrus",
  "Konfigurē labirinta ģenerēšanu ar rādiusu, pozīcijām un izkārtojumu.",
  `Maze`,
  "Glabā sešstūra labirinta datus",
  "Glabā pilnu labirinta struktūru, izmantojot jaucējtabulu.",
  `Walls`,
  "Apzīmē sienu konfigurāciju",
  [Pārvalda sienas stāvokļus, izmantojot bitu karodziņus
    @begginer-patterns.],
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
  "Glabā spēlētājs pozīciju",
  "Nosaka pašreizējo atrašanās vietu labirintā.",
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
@tbl:events-maze[tabulā], šie notikumi pārvalda labirinta izveidi un
atjaunošanu.

#events-table(
  caption: "Ar labirintiem saistīti notikumi",
  `SpawnMaze`,
  "Izveido jaunu labirintu",
  "Inicializē labirintu ar norādīto grīdu un konfigurāciju.",
  `RespawnMaze`,
  "Atjauno esošo labirintu",
  "Atjauno labirintu.",
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
Līdzīgi kā labirintu notikumiem, šie apstrādā spēlētāja izveidošanu un
atjaunošanu.

#events-table(
  caption: "Ar spēlētaju saistīti notikumi",
  `SpawnPlayer`,
  "Izveido spēlētāja entitāti",
  "Inicializē jaunu spēlētāju starta pozīcijā.",
  `RespawnPlayer`,
  "Atjauno spēlētāju",
  "Atiestata spēlētāju uz pašreizējā stāva sākuma pozīciju.",
) <events-player>

=== Resursi

Bevy resursi kalpo kā globāli stāvokļa konteineri, kuriem var piekļūt jebkura
sistēma.
Atšķirībā no komponentēm, kas ir piesaistīti konkrētām entitātēm, resursi
nodrošina spēles mēroga datus un konfigurāciju.
Tie ir īpaši noderīgi kopīgu stāvokļu un iestatījumu pārvaldībai, kas var
ietekmēt vairākas sistēmas @bevy-cheatbook[nod. ~14.6].
Spēle izmanto vienu resursu globālās konfigurācijas un stāvokļa pārvaldībai
(sk. @tbl:resources)

#resources-table(
  caption: "Globālie resursi",
  `GlobalMazeConfig`,
  "Labirinta vizuālie iestatījumi",
  "Uzglabā globālos labirinta izskata parametrus.",
) <resources>

#indent-par[
  Dotais resurss pārvalda labirinta vizuālo attēlojumu, ietverot tādus
  parametrus kā sešstūra lielums, sienu biezums un vertikālais augstums.
]

== Daļējs funkciju projektējums

Labirinta ģenerēšanas process ir realizēts, izmantojot meklēšanas dziļumā
algoritmu (angl. Depth-First Search, DFS)
#footnote[https://en.wikipedia.org/wiki/Depth-first_search], kas ir viens no
populārākajiem labirintu ģenerēšanas algoritmiem @maze-generation.
Labirinta ģenerēšanas process ir attēlots aktivitāšu diagrammā (sk.
@fig:hexlab-activity-diagram), kas parāda algoritma galvenos soļus, sākot ar
labirinta būvētāja inicializāciju un beidzot ar gatava labirinta atgriešanu.

DFS algoritma implementācija (sk. @fig:dfs-diagram) izmanto
rekursīvu pieeju, kur katrs rekursijas solis apstrādā vienu labirinta šūnu.
Algoritms sākas ar sākotnējās pozīcijas atzīmēšanu kā apmeklētu un turpina ar
nejaušu, neapmeklētu kaimiņu izvēli.
Kad nejaušs kaimiņš ir izvēlēts, algoritms noņem sienu starp pašreizējo un
izvēlēto šūnu, tad rekursīvi turpina procesu no jaunās pozīcijas.
Šī pieeja nodrošina, ka izveidotais labirints ir pilnībā savienots un katrai
šūnai var piekļūt no jebkuras citas šūnas.

Algoritma īpatnība ir tāda, ka tas veido labirintus ar zemu sazarošanās faktoru
un gariem koridoriem, jo tas izpēta katru zaru pēc iespējas tālāk, pirms
atgriežas un mēģina citu ceļu.


#figure(
  caption: "Labirinta ģenerēšanas pārejas diagramma",
  kind: image,
  scale(
    75%,
    reflow: true,
    diagram(
      spacing: (0em, 3em),
      {
        terminal-node((0, 0))
        std-edge()

        action-node((0, 1), [Izveido labirinta būvētāju])
        std-edge()

        decision-node((0, 2), [Vai rādius\ ir norādīts?])
        std-edge("ll,d", [nē])
        std-edge("d", [jā])

        action-node((-2, 3), [Nav rādiusa kļūda])
        std-edge()
        terminal-node((-2, 4), extrude: (0, 3))

        action-node((0, 3), [Izveido labirinta glabātuvi])
        std-edge()

        decision-node((0, 4), [Starta pozīcija\ ir norādīta?])
        std-edge("l,d", [jā])
        std-edge("r,d", [nē])

        decision-node((1, 5), [Izmanto noklusējuma\ sākuma pozīciju\ (0, 0)])
        std-edge("d,l")


        decision-node((-1, 5), [Pozīcija\ ir derīga?])
        std-edge("l,d", [nē])
        std-edge("r,d", [jā])

        action-node((-2, 6), [Nepareiza starta pozīcija kļūda])
        std-edge()
        terminal-node((-2, 7), extrude: (0, 3))

        action-node(
          (0, 6),
          [
            #place(
              top + right,
              image("assets/images/fork.svg"),
            )
            \
            \
            Dziļuma meklēšanas\
            labirinta ģenerēšanas\
            algoritms
          ],
        )
        std-edge()

        action-node((0, 7), [Atgriež izveidotu labirintu])
        std-edge()

        terminal-node((0, 8), extrude: (0, 3))
      },
    ),
  ),
) <hexlab-activity-diagram>

#figure(
  caption: "Meklēšanas dziļumā labirinta ģenerēšanas algoritms (apakšaktivitāte)",
  kind: image,
  scale(
    75%,
    reflow: true,
    diagram(
      spacing: (0em, 3em),
      {
        terminal-node((0, 0))
        std-edge()

        action-node((0, 1), [Atzīmē pašreizējo pozīciju\ kā apmeklētu])
        std-edge()

        decision-node((0, 2), [Vai eksistē\ neapmeklēti\ kaimiņi?])
        std-edge("l,d", [jā])
        std-edge("r,d", [nē])

        action-node((-1, 3), [Nejauši izvēlas\ neapmeklētu kaimiņu])
        std-edge()

        decision-node((-1, 4), [Kaimiņš eksistē\ un ir neapmeklēts?])
        std-edge("l,d", [jā])
        std-edge("d", [nē])

        action-node((-1, 5), [Pārbauda nākamo\ virzienu])
        std-edge("r,uuu")

        action-node(
          (-2, 5),
          [Noņem sienas starp pašreizējo\ un kaimiņa pozīcijām],
        )
        std-edge()

        action-node((-2, 6), [Izpilda doto algoritmu\ kaimiņa pozīcijai])
        std-edge()

        action-node((-2, 7), [Atgriežas uz\ iepriekšējo pozīciju])
        std-edge()

        action-node((-2, 8), [Pārvietojas uz šī\ kaimiņa pozīciju])
        std-edge("rr,uuuuuu")

        terminal-node((1, 3), extrude: (0, 3))
        node(
          snap: false,
          stroke: black,
          inset: 1em,
          enclose: (
            (0, 0),
            (1, 3),
            (-2, 8),
            (-2, 5),
          ),
        )
      },
    ),
  ),
) <dfs-diagram>

#indent-par[
  Stāva kustības aktivitāšu diagramma (sk. @fig:floor-transition-diagram) attēlo
  divus procesus stāvu pārvaldībai.
  Kreisajā pusē ir attēlota stāvu kustības loģika, kas sākas ar kustības
  stāvokļa pārbaudi.
  Ja kāds stāvs kustās, sistēma aprēķina kustības attālumu, balstoties uz ātrumu
  un laika deltu, un atjaunina stāva $Y$ pozīciju. Šis process turpinās, līdz
  tiek sasniegts mērķis, pēc kā tiek noņemta stāva galamērķa komponente.
  Labajā pusē ir attēlota stāvu pārejas loģika, kas tiek izpildīta, kad neviens
  stāvs nekustās.
  Šī daļa aprēķina jaunās $Y$ koordinātes visiem stāviem, pievieno tiem
  galamērķa komponentes un atjaunina pašreizējā stāva marķierus.
]
#figure(
  caption: "Stāva kustības sistēma",
  kind: image,
  scale(
    75%,
    reflow: true,
    diagram({
      terminal-node((0, 0))
      std-edge()

      action-node((0, 1), [Pārbauda stāvu\ kustību])
      std-edge()

      decision-node((0, 2), [Vai kāds stāvs\ kustās?])
      std-edge("l,d", [jā])
      std-edge("r,d", [nē])

      action-node(
        (-1, 3),
        [Aprēķināt kustības attālumu\ ($"ātrums" times Delta"laiks"$)],
      )
      std-edge()

      action-node((-1, 4), [Atjaunina stāva $Y$ pozīciju])
      std-edge()

      decision-node((-1, 5), [Vai sasniegts\ mērķis?])
      std-edge("ld", [nē])
      std-edge("d", [jā])

      action-node((-2, 6), [Turpināt kustību])
      std-edge("uu,r")

      action-node((-1, 6), [Noņemt stāva\ galamērķa komponenti])
      std-edge()

      terminal-node((-1, 7))


      action-node((1, 3), [Aprēķina jaunās $Y$\ koordinātes visiem stāviem])
      std-edge()

      action-node((1, 4), [Pievienot stāva galamērķa\ komponenti katram stāvam])
      std-edge()

      action-node((1, 5), [Atjaunina pašreizējā marķieri])
      std-edge("l,uu,l")
    }),
  ),
) <floor-transition-diagram>


=== Plākšņu pārvaldības sistēma

Projekta sākotnējā plānošanas posmā tika apsvēra iespēja labirinta elementu
pārvaldībai izmantot
"bevy_ecs_tilemap" bibliotēku.#footnote[https://crates.io/crates/bevy_ecs_tilemap]<bevy-ecs-tilemap>
Tomēr pēc rūpīgas izvērtēšanas tika secināts, ka tā neatbilst konkrētajam
projekta lietojuma gadījumam sekojošu iemeslu dēļ:
+ Uz failiem balstīta plākšņu ielāde: "bevy_ecs_tilemap" galvenokārt paļaujas uz
  plākšņu ielādi no ārējiem failiem. Šajā projektā ir nepieciešami dinamiski,
  procedurāli ģenerēti labirinti, tāpēc šī pieeja nav īsti piemērota.
+ Elastības ierobežojumi: bibliotēkas plākšņu datu struktūra nav viegli
  pielāgojama nepieciešamajai datu struktūrai, kurai ir nepieciešama
  sarežģītākām telpiskām attiecībām starp šūnām.
+ Prasības attiecībā uz sienu veidošanu: katrai sistēmas labirinta šūnai
  var būt 0-6 sienas, kas tiek ģenerētas nejauši. Šādu dinamisku sienu ģenerēšanas
  līmeni nav viegli sasniegt izmantojot "bevy_ecs_tilemap".

#indent-par[
  Tā vietā, lai izmantotu "bevy_ecs_tilemap", tika izlemts izstrādāt pielāgotu
  risinājumu, kas tieši integrējas ar labirinta ģenerēšanas algoritmu. Šī
  pieeja ļauj:
]
- vienkāršāku integrācija ar procedurālo labirintu ģenerēšanu;
- optimālāku veiktspēja projekta lietošanas gadījumam;
- lielāku kontroli pār labirinta vizuālo attēlojumu.

== Saskarņu projektējums
Spēles saskarņu projektējums ietver divus galvenos skatus (sk. @fig:ui-flow) --
galveno izvēlni un spēles saskarni -- un izstrādes rīkus.

#figure(
  caption: "Ekrānskatu plūsmu diagramma",
  diagram(
    spacing: 6em,
    {
      action-node((0, 0), [Galvenais ekrāns], inset: 2em)
      edge(
        stroke: 1pt,
        "<|-|>",
      )
      action-node((1, 0), [Spēles ekrāns], inset: 2em)
    },
  ),
) <ui-flow>

=== Galvenā izvēlne

Galvenā izvēlne ir pirmais skats, ar ko saskaras lietotājs, uzsākot spēli (sk.
@fig:main-menu).
Tā sastāv no spēles nosaukuma, "Play" -- sākt spēli pogas un "Quit" -- iziet
pogas.

#figure(
  caption: "Galvenās izvēlnes skats",
  image("assets/images/sceens/main.svg"),
) <main-menu>

=== Spēles skats

Spēles skats apvieno pašu spēles pasauli ar minimālistisku lietotāja saskarni
(sk. @fig:game-ui).
Centrālo daļu aizņem spēles pasaule ar sešstūra labirintu, kas veido spēles
galveno interaktīvo elementu.
Ekrāna kreisajā apakšējā stūrī ir izvietoti papildspēju statusa indikatori, kas
sniedz spēlētājam vizuālu atgriezenisko saiti par pieejamajām spējām un to
atjaunošanās laiku.


#figure(
  caption: "Galvenās izvēlnes skats",
  image("assets/images/sceens/game.svg"),
) <game-ui>

=== Izstrādes rīki
Izstrādes rīki, kas redzami @fig:dev-tools-ui[attēlā], ir implementēti
izmantojot "bevy_egui" bibliotēku @bevy_egui.
Pirmais "Bevy Inspector Egui" noklusētais skats @bevy-inspector-egui, kas
nodrošina detalizētu piekļuvi spēles entitāšu hierarhijai, komponenšu
inspektoram un resursu pārvaldniekam.
Otrs ir izvietots labirinta konfigurācijas panelis, kas ļauj kontrolēt labirinta
izmēru, izkārtojumu un pielāgot ģenerēšanas parametrus,

#figure(
  caption: "Izstrādes rīku saskarne ar labirinta konfigurācijas paneli",
  image("assets/images/sceens/dev-tools.png"),
) <dev-tools-ui>

= Testēšanas dokumentācija
Šajā nodaļā ir aprakstīta spēles "Maze Ascension" testēšanas process.
Testēšana tika veikta divos galvenajos virzienos -- statiskā un dinamiskā
testēšana, izmantojot gan automatizētus rīkus, gan manuālu pārbaudi.

== Statiskā testēšana <static-tests>
Statiskā testēšana ir svarīga daļa no projekta kvalitātes nodrošināšanas.
"Clippy" tiek izmantots koda analīzei, meklējot potenciālas problēmas un
neoptimālus risinājumus.
Papildus noklusētajiem noteikumiem, tika aktivizēti stingrāki koda kvalitātes
pārbaudes līmeņi: "pedantic" režīms nodrošina padziļinātu koda stila pārbaudi,
"nursery" aktivizē eksperimentālās pārbaudes, un "unwrap_used" un "expect_used"
brīdina par potenciāli nedrošu kļūdu apstrādi. Šie papildu noteikumi palīdz
uzturēt augstāku koda kvalitāti un samazināt potenciālo kļūdu skaitu
(sk. @clippy-hexlab[] un @clippy-maze-ascension[pielikumus]) @clippy.

== Dinamiskā testēšana

Lai novērtētu programmatūras uzvedību darbības laikā, tika veikta dinamiskā
testēšana.
Šī testēšanas pieeja apvieno gan manuālu testēšanu, izmantojot lietotāja
saskarnes mijiedarbību, gan automatizētus testu komplektus, lai nodrošinātu
visaptverošu spēles funkcionalitātes pārklājumu.

=== Manuālā integrācijas testēšana

Integrācijas testēšana ir veikta manuāli, mijiedarboties ar spēles saskarni.
Katrs testa scenārijs ir dokumentēta strukturētas tabulas formātā, ievērojot
būtisku informāciju, piemēram, test nosaukumu, unikālo identifikatoru, aprakstu,
izpildes soļus, gaidāmo rezultātu un faktisko rezultātu (veiksmīga testa
gadījumā apzīmēts ar "Ok", bet neveiksmīgu -- "Err").
Testu gadījumi ir detalizētāk aprakstīti @tbl:manual-tests[tabulā].


#figure(
  caption: "Manuālā testēšana",
  kind: table,
  tablex(
    columns: (3.5em, 6em, auto, auto, 5.5em),
    [*Testa ID*],
    [*Testa nosaukums*],
    [*Soļi*],
    [*Sagaidāmais rezultāts*],
    [*Faktiskais rezultāts*],
    "MT01",
    "Spēles palaišana",
    [
      + Palaist spēli
      + Gaidīt ielādi
    ],
    [Parādās galvenā izvēlne ar "Play" pogu.],
    "Ok",
    "MT02",
    "Labirinta ģenerēšana",
    [
      + Palaist spēli
      + Nospiest "Play" pogu
      + Gaidīt ielādi
    ],
    [Tiek uzģenerēts sešstūrains labirints ar sienām.],
    "Ok",
    "MT03",
    "Stāvu pāreja (uz augšu)",
    [
      + Nokļūt līdz beigu šūnai
      + Nospiest taustiņu "E"
      + Novērot animāciju
    ],
    [
      + Jauna stāva ģenerēšana
      + Plūstoša pāreja starp stāviem uz augšu
    ],
    "Ok",
    "MT04",
    "Stāvu pāreja (uz leju)",
    [
      + Nokļūt līdz sākuma šūnai
      + Nospiest taustiņu "E"
      + Novērot animāciju
    ],
    [
      + Jauns stāvs netiek ģenerēts
      + Plūstoša pāreja starp stāviem uz leju
    ],
    "Ok",
    "MT05",
    "Papildspēju aktivizēšana",
    [
      + Aktivizēt papildspēju
      + Gaidīt atjaunošanās laiku
    ],
    [
      + Papildspēja aktivizējas
      + Sākas atjaunošanās laiks
    ],
    "Err",
    "MT06",
    "Izstrādes rīku atvēršana",
    [
      + Palaist spēli izstrādes režīmā
      + Nospiest "Play" pogu
    ],
    [Parādās "egui" panelis ar labirinta konfigurācijas opcijām],
    "Ok",
    "MT07",
    [Labirinta parametru maiņa],
    [
      + Atvērt "egui" paneli
      + Mainīt labirinta izmēru un citus parametrus
    ],
    [Tiek ģenerēts jauns labirints ar mainītajiem parametriem],
    "Ok",
    "MT08",
    [Spēlētāja kustība],
    [
      + Izmantot "WASD" kustības taustiņus
      + Mēģināt šķērsot sienas
    ],
    [
      + Plūstoša kustība brīvajā telpā
      + Sadursmes ar sienām strādā
    ],
    "Ok",
    "MT09",
    [Windows palaišana],
    [
      + Kompilēt spēli Windows platformai
      + Palaist .exe failu
      + Veikt pamata funkcionalitātes testus
    ],
    [Spēle darbojas Windows vidē bez kļūdām],
    "Ok",
    "MT10",
    [Linux palaišana],
    [
      + Kompilēt spēli Linux platformai
      + Palaist bināro failu
      + Veikt pamata funkcionalitātes testus
    ],
    [Spēle darbojas Linux vidē bez kļūdām],
    "Ok",
    "MT11",
    [macOS palaišana],
    [
      + Kompilēt spēli macOS platformai
      + Palaist .dmg pakotni
      + Veikt pamata funkcionalitātes testus
    ],
    [Spēle darbojas macOS vidē bez kļūdām],
    "Err",
    "MT12",
    [WASM palaišana],
    [
      + Kompilēt spēli WASM mērķim
      + Atvērt pārlūkā
      + Veikt pamata funkcionalitātes testus
    ],
    [
      + Spēle ielādējas pārlūkā
      + Darbojas visas pamatfunkcijas
    ],
    "Ok",
  ),
) <manual-tests>

#indent-par[
  Divi testi no manuālās testēšanas plāna netika izpildīti.
  Papildspēju tests (MT05) netika izpildīts, jo šī funkcionalitāte netika
  implementēta projekta pirmajā versijā, atstājot to kā potenciālu nākotnes
  papildinājumu.
  Savukārt macOS platformas tests (MT11) netika izpildīts
  tehnisku ierobežojumu dēļ -- projekta izstrādātājam nav pieejama Apple
  aparatūra.
]

Tādējādi no divpadsmit definētajiem testiem desmit tika veiksmīgi izpildīti,
viens netika implementēts (papildspējas), un viens tika daļēji izpildīts (macOS
kompilēšana bez funkcionālās testēšanas).

=== Automatizēti testi

Automatizētā testēšanas sistēma plaši pārklāj bibliotēku "hexlab", jo tā ir
paredzēta publiskai lietošanai.
Testēšanas stratēģijā ir ieviesti vairāki pārbaudes līmeņi: dokumentācijas testi
no drošina piemēra koda pareizību, moduļu testi pārbauda iekšējo
funkcionalitāti, savukārt testu mapē esošie vienībtesti un integrācijas testi
pārbauda sarežģītākus gadījumus.
Daļējs automatizēto testu izpildes rezultāts ir redzams @fig:tests-hexlab, savukārt
detalizēts testu izpildes pārskats ir redzams piejams pielikumā (sk.
@tests-hexlab-full).

Izmantojot "cargo-tarpaulin", testu pārklājums ir $81.69%$ (sk.
@tarpaulin-hexlab[pielikumu]), tomēr šis rādītājs
pilnībā neatspoguļo faktisko pārklājumu, jo rīkam ir ierobežojumi attiecībā uz
"inline"#footnote[https://doc.rust-lang.org/nightly/reference/attributes/codegen.html?highlight=inline]
funkcijām un citi tehniski ierobežojumi @cargo-tarpaulin.

#figure(
  caption: [Daļējs "hexlab" bibliotēkas testu rezultāts],
  image("assets/images/tests/hexlab-minimized.png"),
)<tests-hexlab>

#indent-par[
  Arī spēles kods saglabā stabilu testēšanas stratēģiju.
  Moduļu testi ir stratēģiski izvietoti līdzās implementācijas kodam tajā pašā
  failā, nodrošinot, ka katras komponentes funkcionalitāte tiek pārbaudīta
  izolēti.
  Šie testi attiecas uz tādām svarīgām spēles sistēmām kā spēlētāju kustība,
  sadursmju noteikšana, spēles stāvokļa pārvaldība u.c.
]

Visi testi tiek automātiski izpildīti kā nepārtrauktas integrācijas procesa
daļa, nodrošinot tūlītēju atgriezenisko saiti par sistēmas stabilitāti un
funkcionalitāti pēc katras koda izmaiņas.

= Programmas projekta organizācija

Kvalifikācijas darba izstrāde ir individuāls process, kur autors uzņemas pilnu
atbildību par programmatūras izveidi un dokumentāciju.

Individuālā darba pieeja ļauj izvairīties no daudzām tipiskām projektu vadības
problēmām.
Tā kā nav nepieciešama koordinācija starp vairākiem izstrādātājiem, lēmumu
pieņemšana ir tiešāka un ātrāka.
Tas ir īpaši svarīgi, ņemot vērā kvalifikācijas darba ierobežoto laika periodu.

== Kvalitātes nodrošināšana
Augstas koda kvalitātes nodrošināšana ir jebkura projekta būtisks aspekts.
Lai to panāktu, tiek izmantoti vairāki rīki un prakses, kas palīdz uzturēt tīru,
efektīvu un uzticamu koda.

Viens no galvenajiem rīkiem, kas tiek izmantots ir "Clippy"@clippy, kas analizē
iespējamās problēmas un iesaka uzlabojumus (sk. @static-tests nodaļu).

Kopā ar "Clippy" tiek arī izmantots "Rustfmt" @rustfmt, koda formatētājs, lai
uzturētu vienotu koda formatējumu visā projektā.
Šis rīks automātiski formatē kodu saskaņā ar Rust stila vadlīnijām @rust-style.

Turklāt visas publiskās funkcijas un datu struktūras "hexlab" bibliotēkā ir
dokumentētas#footnote[https://docs.rs/hexlab/latest/hexlab/]<hexlab-docs>.
Šajā dokumentācijā ir ietverti detalizēti apraksti un lietošanas piemēri, kas ne
tikai palīdz saprast kodu, bet arī atvieglo bibliotēkas testēšanu un kļūdu
labošanu.

Programmatūras prasības specifikācija ir izstrādāta, ievērojot LVS 68:1996
standarta "Programmatūras prasību specifikācijas ceļvedis" @lvs_68 un LVS
72:1996 standarta "Ieteicamā prakse programmatūras projektējuma aprakstīšanai"
standarta prasības @lvs_72.
// Programmatūras projektējuma aprakstā iekļautās
// aktivitāšu diagrammas ir veidotas atbilstoši UML (Unified Modeling Language) 2.5
// specifikācijai @omg-uml.

== Konfigurācijas pārvaldība

Pirmkods tiek pārvaldīts, izmantojot "git"#footnote[https://git-scm.com/doc]<git> versiju kontroles sistēmu.
Repozitorijs tiek izvietots platformā "GitHub".
Rīku konfigurācija ir definēta vairākos failos:
- "justfile"#footnote[https://just.systems/man/en/]<justfile> -- satur atkļūdošanas un
  laidiena komandas dažādām vidēm:
  - atkļūdošanas kompilācijas ar iespējotu pilnu atpakaļsekošanu;
  - laidiena kompilācijas ar iespējotu optimizāciju.
- "GitHub Actions" darbplūsmas, kas apstrādā @gh-actions:
  - koda kvalitātes pārbaudes (vienībtesti, statiskie testi, formatēšana,
    dokumentācijas izveide);
  - kompilācijas un izvietotošanas darbplūsma, kas:
    - izveido Windows, Linux, macOS un WebAssembly versijas;
    - publicē bināros failus GitHub platformā;
    - izvieto tīmekļa versiju itch.io@itch-io platformā.

Versiju specifikācija notiek pēc semantiskās versiju atlases (MAJOR.MINOR.PATCH) @sem-ver:
+ MAJOR -- galvenā versija, nesaderīgas izmaiņas, būtiskas koda izmaiņas.
+ MINOR -- atpakaļsaderīgas funkcionalitātes papildinājumi.
+ PATCH -- ar iepriekšējo versiju saderīgu kļūdu labojumi.

== Darbietilpības novērtējums
Projekta darbietilpības novērtēšanai tika izmantota QSM (angl. Quantitative
Software Management, latv. kvantitatīvā programmatūras vadība) metodoloģija, kas
balstās uz $550$ verificētu programmatūras projektu datubāzi @QSM.
Izmantojot "tokei" rīku @tokei, tika veikta detalizēta projekta koda analīze,
kas parādija, ka "Maze Ascension" projekts satur $2686$ koda rindiņas (sk. @tokei-maze-ascension), bet
saistītā "hexlab" bibliotēka -- $979$ rindiņas (sk. @tokei-hexlab), kopā
veidojot $3236$ pirmkoda rindiņas, neiekļaujot tukšās rindiņas un komentārus.

Saskaņā ar QSM etalontabulu "Business Systems Implementation Unit (New and
Modified IU) Benchmarks", pirmās kvartiles projekti ($25%$ mazākie no $550$
biznesa sistēmu projektiem) vidēji ilgst $3.2$ mēnešus, ar vidēji $1.57$
izstrādātājiem un mediāna projekta apjomu -- $1889$ koda rindiņas @QSM.
Ņemot vērā, ka projekta autors ir students ar ierobežotu pieredzi, tiek
izmantota pirmās kvartiles $50%$ diapazona augšējā robeža -- $466$ rindiņas
personmēnesī.
Tādējādi minimālais nepieciešamais koda apjoms trīs mēnešu darbam būtu $3 times 466
= 1398$ rindiņas.

Projekta faktiskais koda apjoms ($2906$ rindiņas) vairāk nekā divkārt pārsniedz šo
minimālo slieksni, kas apliecina projekta atbilstību trīs mēnešu darbietilpības
prasībai.
Turklāt jāņem vērā projekta papildu sarežģītības faktori:
- Bevy dzinēja un ECS arhitektūras apgūšana;
- Procedurālās ģenerēšanas algoritma izstrāde "hexlab" bibliotēkai;
- "hexlab" bibliotēkas izstrāde ar plašu dokumentāciju, ieskaitot API
  dokumentāciju, lietošanas piemērus un integrācijas vadlīnijas.

#indent-par[
  Šie faktori būtiski palielina projekta faktisko darbietilpību, jo prasa ne tikai
  koda rakstīšanu, bet arī izpēti, dokumentēšanu un optimizāciju.
]

= Secinājumi

Kvalifikācijas darba ietvaros tika izstrādāta trīsdimensiju spēle, izmantojot
Bevy spēļu dzinēju un Rust programmēšanas valodu un tās dokumentācija.
Projekta izstrādes gaitā tika sasniegti vairāki nozīmīgi rezultāti un gūtas
vērtīgas atziņas.

Projekta galvenie sasniegumi ietver procedurāli ģenerēta sešstūraina labirinta
implementāciju, kas balstās uz meklēšanas dziļumā (DFS) algoritmu.
Šī funkcionalitāte tika veiksmīgi nodalīta atsevišķā "hexlab" bibliotēkā, kas
padara to pieejamu atkārtotai izmantošanai citos projektos.
Tika izveidota arī efektīva stāvu pārvaldības sistēma, kas nodrošina plūstošu
pāreju starp dažādiem labirinta līmeņiem.

Bevy spēļu dzinēja izmantošana ļāva efektīvi implementēt entitāšu-komponenšu
sistēmu (ECS), kas nodrošina labu veiktspēju un koda organizāciju.
Tomēr tika konstatēts, ka Bevy ekosistēma joprojām ir aktīvās izstrādes stadijā,
ko apliecina darba izstrādes laikā iznākusī jaunā versija (0.15).
Šī versija ieviesa vairākas būtiskas izmaiņas, piemēram, "Required Components"
(latv. nepieciešamo komponenšu) konceptu uzlabotu animāciju sistēmu un daudz ko
citu, kas radīja nepieciešamību pielāgot esošo kodu @bevy-0.15.
Šāda strauja attīstība, no vienas puses, nodrošina jaunas iespējas un
uzlabojumus, bet no otras puses, rada izaicinājumus saistībā ar dokumentācijas
aktualitāti un bibliotēku savietojamību.

Izstrādes procesā īpaša uzmanība tika pievērsta koda kvalitātei un
dokumentācijai.
Tika izveidota detalizēta tehniskā dokumentācija, kas ietver gan sistēmas
arhitektūras aprakstu, gan atsevišķu komponenšu funkcionalitātes skaidrojumu.

Projekta turpmākās attīstības iespējas ietver:
- papildu labirinta ģenerēšanas algoritmu implementāciju;
- spēles mehānikas paplašināšanu ar jaunām papildspējām;
- grafiskās kvalitātes uzlabojumus;
- tīkla spēles režīma ieviešanu.

#bibliography(
  title: "Izmantotā literatūra un avoti",
  "bibliography.yml",
)

#include "src/attachments.typ"
#include "src/code.typ"
#include "documentary_page.typ"

// #pagebreak()
// #total-words words
