#import "@preview/i-figured:0.2.4"
#import "@preview/tablex:0.0.9": tablex

#let indent = 1cm

#let indent-par(
  body,
) = par(h(indent) + body)


#let project(
  university: "",
  faculty: "",
  thesis_type: "",
  title: [],
  authors: (),
  advisor: "",
  date: "",
  body,
) = {
  set document(author: authors)

  set page(
    margin: (
      left: 30mm,
      right: 20mm,
      top: 20mm,
      bottom: 20mm,
    ),
    number-align: center,
    paper: "a4",
  )
  set text(
    font: "Times New Roman",
    size: 12pt,
    hyphenate: auto,
    lang: "lv",
    region: "lv",
  )
  show raw: set text(font: "JetBrainsMono NF")

  show math.equation: set text(weight: 400)

  // Formatting for regular text
  set par(
    justify: true,
    leading: 1.5em,
    first-line-indent: indent,
    spacing: 1.5em,
  )
  show heading: set block(spacing: 1.5em)
  set terms(separator: [ -- ])

  // Headings
  set heading(numbering: "1.1.")
  show heading: it => {
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

  /* Title page config start */
  align(
    center,
    upper(
      text(
        size: 16pt,
        [
          #university\
          #faculty
        ],
      ),
    ),
  )

  v(1fr)

  align(
    center,
    upper(
      text(
        20pt,
        weight: "bold",
        title,
      ),
    ),
  )

  v(0.3fr)

  align(
    center,
    upper(
      text(
        size: 16pt,
        thesis_type,
      ),
    ),
  )

  v(1fr)

  // Author information
  align(
    right,
    [
      #if authors.len() > 1 {
        text(
          weight: "bold",
          "Darba autori:",
        )
      } else {
        text(
          weight: "bold",
          "Darba autors:",
        )
      }\
      #authors.join("\n")

      #v(2em)

      #if advisor != "" {
        text(
          weight: "bold",
          "Darba vadītājs:\n",
        )
        advisor
      }
    ],
  )

  v(0.5fr)

  align(
    center,
    upper(
      text(date),
    ),
  )
  /* Title page config end */

  // Start page numbering
  set page(
    numbering: "1",
    number-align: center,
  )

  // WARNING: remove before sending
  outline(title: "TODOs", target: figure.where(kind: "todo"))

  /* --- Figure/Table config start --- */
  show heading: i-figured.reset-counters
  show figure: i-figured.show-figure.with(numbering: "1.1.")
  set figure(placement: none)

  show figure.where(kind: "i-figured-table"): set block(breakable: true)
  show figure.where(kind: "i-figured-table"): set figure.caption(position: top)

  show figure: set par(justify: false) // disable justify for figures (tables)
  show figure.caption: set text(size: 11pt)

  show figure.caption: it => {
    if it.kind == "i-figured-table" {
      return align(
        end,
        emph(it.counter.display(it.numbering) + " tabula ") + text(
          weight: "bold",
          it.body,
        ),
      )
    }
    if it.kind == "i-figured-image" {
      return align(
        start,
        emph(it.counter.display(it.numbering) + " att. ") + text(
          weight: "bold",
          it.body,
        ),
      )
    }
    it
  }

  // disable default reference suppliments
  set ref(supplement: it => { })

  // Custom show rule for references
  show ref: it => {
    let el = it.element

    if el == none {
      return it
    }

    if el.func() == heading {
      return link(
        el.location(),
        numbering(
          el.numbering,
          ..counter(heading).at(el.location()),
        ) + " " + el.body,
      )
    }

    if el.func() == figure {
      let kind = el.kind

      // Map for different kinds of supplements
      let supplement_map = (
        i-figured-table: "tab.",
        i-figured-image: "att.",
      )

      // Get the supplement value properly
      let supplement = if type(it.supplement) != function {
        it.supplement
      } else {
        if kind in supplement_map {
          supplement_map.at(kind)
        } else {
          ""
        }
      }
      // Create counter based on the kind
      return link(
        el.location(),
        numbering(
          el.numbering,
          ..counter(figure.where(kind: kind)).at(
            el.location(),
          ),
        ) + if supplement != "" {
          " " + supplement
        } else {
          ""
        },
      )
    }


    // Default case for non-figure elements
    it
  }
  /* --- Figure/Table config end --- */

  set list(marker: (
    [•],
    [--],
    [\*],
    [·],
  ))
  set enum(numbering: "1aiA)") // TODO: make the same style as LaTeX: 1. | (a) | i. | A.

  // Abstract
  include "abstract.typ"

  /* ToC config start */
  // Uppercase 1st level headings in ToC
  show outline.entry.where(level: 1): it => {
    upper(it)
  }

  pagebreak()
  outline(
    depth: 3,
    indent: 1cm,
    title: text(
      size: 14pt,
      "SATURS",
    ),
  )
  /* ToC config end */



  // show link: set text(fill: blue.darken(20%))

  // Main body
  body
}
