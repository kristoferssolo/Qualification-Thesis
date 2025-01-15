#import "@preview/touying:0.5.5": *
#import themes.university: *
#import "@preview/cetz:0.3.1"
#import "@preview/fletcher:0.5.3" as fletcher: node, edge
#import "@preview/ctheorems:1.1.3": *
#import "@preview/numbly:0.1.0": numbly
#import "src/diagrams.typ": *

#set text(
  font: (
    "Times New Roman",
    "New Computer Modern",
  ),
  size: 12pt,
  hyphenate: auto,
  lang: "lv",
  region: "lv",
)
#show raw: set text(
  font: (
    "JetBrainsMono NF",
    "JetBrains Mono",
    "Fira Code",
  ),
  features: (calt: 0),
)

// cetz and fletcher bindings for touying
#let cetz-canvas = touying-reducer.with(
  reduce: cetz.canvas,
  cover: cetz.draw.hide.with(bounds: true),
)
#let fletcher-diagram = touying-reducer.with(
  reduce: fletcher.diagram,
  cover: fletcher.hide,
)

#set figure(supplement: none)

// Theorems configuration by ctheorems
#show: thmrules.with(qed-symbol: $square$)
#let theorem = thmbox("theorem", "Theorem", fill: rgb("#eeffee"))
#let corollary = thmplain(
  "corollary",
  "Corollary",
  base: "theorem",
  titlefmt: strong,
)
#let definition = thmbox(
  "definition",
  "Definition",
  inset: (x: 1.2em, top: 1em),
)
#let example = thmplain("example", "Example").with(numbering: none)
#let proof = thmproof("proof", "Proof")

#show: university-theme.with(
  aspect-ratio: "16-9",
  config-info(
    title: [Spēles izstrāde, izmantojot Bevy spēļu dzinēju],
    subtitle: [Kvalifikācijas darbs],
    author: [Kristiāns Francis Cagulis kc22015],
    date: [2025],
    institution: [Latvijas Universitāte],
  ),
  config-colors(
    primary: rgb("#575279"),
    secondary: rgb("#797593"),
    tertiary: rgb("#286983"),
    neutral-lightest: rgb("#faf4ed"),
    neutral-darkest: rgb("#575279"),
  ),
)

#title-slide()

#slide[
  = Pārskats
  - Entitāšu komponenšu sistēma (ECS)
  - Maze Ascension
  - Hexlab bibliotēka
  - Sešstūru implementācija
  - Saskarne
  - Rezultāti un secinājumi
]

= Entitāšu komponenšu sistēma (ECS)

== Kas ir ECS?

- Koncentrējas uz kompozīciju, nevis mantošanu.
- Datu orientēta arhitektūra.
- Nodalīti dati (komponentes) un uzvedība (sistēmas).

== Datu izkārtojums

// Here is an illustration to help you visualize the logical structure. The
// checkmarks show what component types are present on each entity. Empty cells
// mean that the component is not present. In this example, we have a player, a
// camera, and several enemies.
#context {
  show raw: set text(size: 16pt)
  table(
    columns: 7,
    [*Entity (ID)*],
    [*Transform*],
    [*Player*],
    [*Enemy*],
    [*Camera*],
    [*Health*],
    [*...*],

    `...`, "", "", "", "", "", "",
    "107",
    [#emoji.checkmark.heavy `<translation>`\ `<rotation>`\ `<scale>`],
    emoji.checkmark.heavy,
    "",
    "",
    [#emoji.checkmark.heavy `<50.0>`],
    "",

    "108",
    [#emoji.checkmark.heavy `<translation>`\ `<rotation>`\ `<scale>`],
    "",
    emoji.checkmark.heavy,
    "",
    [#emoji.checkmark.heavy `<25.0>`],
    "",

    "109",
    [#emoji.checkmark.heavy `<translation>`\ `<rotation>`\ `<scale>`],
    "",
    "",
    [#emoji.checkmark.heavy `<camera data>`],
    "",
    "",

    `...`,
  )
}

== Piemērs
#context {
  show raw: set text(size: 16pt)
  ```rust
  #[derive(Component)]
  struct Player;

  #[derive(Component)]
  struct Health {
      current: u32,
      max: u32
  }

  fn heal_player(
      mut query: Query<&mut Health, With<Player>>,
      time: Res<Time>,
  ) {
      for mut health in query.iter_mut() {
        let new_health = health.current + 2. * time.delta_secs();
        health.current = new_health.min(health.max);
      }
  }
  ```
}

= Maze Ascension

== 1. Līmeņa DPD

#figure(image("assets/images/diagrams/dpd1.png"))

== Stāva modulis

#figure(image("assets/images/diagrams/floor.png", width: 50%))


= Hexlab bibliotēka

#pagebreak()

#figure(
  caption: link("https://crates.io/crates/hexlab"),
  image("assets/images/crates/hexlab.png", height: 92%),
)

== Labirinta ģenerēšanas funkcijas projektējums
#grid(
  columns: (1fr, 1fr),
  figure(image("assets/images/diagrams/maze-gen.png")),
  figure(image("assets/images/diagrams/recursive.png")),
)

== Ģenerēšanas algoritms
// recursive backtracking
#figure(
  caption: link("https://en.wikipedia.org/wiki/Maze_generation_algorithm"),
  image("assets/videos/hexmaze/hexmaze.gif", height: 92%),
)

= Sešstūru implementācija
== Attēlošana

#grid(
  columns: 2,
  figure(image("assets/images/game/tile-spreadout.png", height: 100%)),
  figure(image("assets/images/game/tile.png", height: 100%)),
)

#figure(image("assets/images/game/grid.png", height: 100%))

= Saskarne
#pagebreak()

#grid(
  columns: 2,
  figure(image("assets/images/game/main-menu.png")),
)

#figure(image("assets/videos/game/maze-game.gif"))

#grid(
  columns: (1fr, 1fr),
  figure(image("assets/images/game/debug.png")),
  figure(image("assets/images/game/dev-tools.png")),
)


#figure(image("assets/videos/game/big-maze.gif"))

= Secinājumi
== Rezultāti

- 3D spēle izmantojot Bevy un Rust:
  - Procedurāla sešstūraina labirints ģenerēšana, izmantojot DFS.
  - Izveidota atkārtoti lietojama atvērtā pirmkoda bibliotēka "hexlab".
- Efektīva līmeņa pārvaldība:
  - Vienmērīga pāreja starp labirinta līmeņiem.

== Turpmākie darbi

- Īstenot vairāk labirintu ģenerēšanas paņēmienus/algoritmus.
- Ieviest jaunas mehānikas un papildspējas.
- Uzlabot vizuālo kvalitāti un spēlētāja izskatu.
- Izstrādāt daudzspēlētāju režīmu.

= Paldies par uzmanību!

Jautājumi?

#show: appendix

= Galavārds
== ECS vs OOP
#grid(
  columns: (1fr, 1fr),
  gutter: 1em,
  [
    *ECS*
    - Plakana hierarhija
    - Datu orientēta
    - Kešatmiņai piemērots
    - Paralēla apstrāde
  ],
  [
    *OOP*
    - Dziļa mantojamība (inheritance)
    - Objektorientēta
    - Kešatmiņa izkliedēts
    - Secīga apstrāde
  ],
)

== Iedvesma
#figure(
  caption: link("https://www.redblobgames.com/grids/hexagons/"),
  grid(
    columns: 2,
    figure(image("assets/images/redblogmages/axial-coords.png", height: 92%)),
    figure(image("assets/videos/coords/coords.gif", height: 92%)),
  ),
)

