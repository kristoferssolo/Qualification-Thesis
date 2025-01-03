#import "@preview/dashy-todo:0.0.1": todo
#import "@preview/wordometer:0.1.3": word-count, total-words
#pagebreak()
#heading(
  level: 1,
  outlined: false,
  numbering: none,
  "Anotācija",
)
Kvalifikācijas darbā ir izstrādāta spēle "Maze Ascension", kas piedāvā
spēlētājiem izaicinājumu iziet cauri procedurāli ģenerētiem sešstūrainam
labirintiem. Spēle ir veidota, izmantojot Rust programmēšanas valodu un Bevy
spēļu dzinēju.

Darba gaitā tika izstrādāta "hexlab" bibliotēka labirintu ģenerēšanai, kas tika
atdalīta no galvenās spēles loģikas. Labirintu ģenerēšanai tiek izmantots
rekursīvās atpakaļizsekošanas algoritms, kas nodrošina, ka katrai šūnai var
piekļūt no jebkuras citas šūnas.

Spēle ir izstrādāta kā vienspēlētāja režīmā ar progresējošu grūtības
pakāpi, kur katrs nākamais līmenis piedāvā lielāku labirintu. Spēle ir pieejama
gan kā lejupielādējama versija Windows, Linux un macOS platformām, gan kā
tīmekļa versija, izmantojot WebAssembly tehnoloģiju.

#par(
  first-line-indent: 0cm,
  [*Atslēgvārdi:*],
)
Labirints,
datorspēle,
sistēmas prasības,
programmatūras prasību specifikācija,
Bevy,
ECS,
papildspējas.


#text(
  hyphenate: auto,
  lang: "en",
  [
    #pagebreak()
    #heading(
      level: 1,
      outlined: false,
      numbering: none,
      "Abstract",
    )
    #align(
      center,
      heading(
        level: 2,
        outlined: false,
        numbering: none,
        text(13pt, "Game development using Bevy game engine"),
      ),
    )
    The qualification work includes the game "Maze Ascension", which offers
    players the challenge to pass through procedurally generated hexagons
    mazes. The game is built using the Rust programming language and Bevy
    game engine.

    The work included the development of a "hexlab" library for maze generation,
    which was separated from the main game logic. The maze generation is a
    recursive backtracking algorithm which ensures that each cell can be
    accessed from any other cell.

    The game is designed as a single-player mode with progressive difficulty
    with each successive level offering a larger maze. The game is available
    as a downloadable version for Windows, Linux and macOS platforms, and as
    as a web-based version using WebAssembly technology.
    #par(
      first-line-indent: 0cm,
      [*Keywords:*],
    )
    Maze,
    computer game,
    system requirements,
    software requirements specification,
    Bevy,
    ECS,
    power-ups.
  ],
)
