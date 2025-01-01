#import "@preview/fletcher:0.5.3" as fletcher: diagram, node, edge
#import fletcher.shapes: diamond, ellipse
#import "@preview/cetz:0.3.1"
#import cetz: draw

#let default-node-stroke = 1pt
#let default-edge-stroke = 1pt

// Common filled circle node (terminal node)
#let terminal-node(pos, extrude: none) = {
  if extrude != none {
    node(
      pos,
      [],
      radius: 6pt,
      fill: black,
      stroke: default-node-stroke,
      extrude: extrude,
    )
  } else {
    node(
      pos,
      [],
      radius: 6pt,
      fill: black,
    )
  }
}

// Common rounded rectangle node
#let action-node(pos, text) = {
  node(
    pos,
    text,
    corner-radius: 4pt,
    stroke: default-node-stroke,
  )
}

// Common diamond node (decision node)
#let decision-node(pos, text) = {
  node(
    pos,
    text,
    shape: diamond,
    stroke: default-node-stroke,
  )
}

// Standard arrow edge
#let std-edge(..args) = {
  edge(
    label-pos: 0.1,
    stroke: default-edge-stroke,
    label-size: 10pt,
    ..args,
    "-|>",
  )
}

// Fork/parallel function
#let parallel-fork(
  pos,
  paths,
  path_spacing: 1,
  join_pos: none,
) = {
  let elements = ()

  // Calculate positions
  let path_count = paths.len()
  let total_width = (path_count + 1) * path_spacing
  let (start_x, start_y) = pos


  // Fork bar (horizontal line)
  elements.push(
    edge(
      (start_x - total_width / 2, start_y),
      (start_x + total_width / 2, start_y),
      stroke: default-edge-stroke * 3,
    ),
  )

  // Create paths
  for path in paths {
    let first_obj_path = path.first().value.pos.raw
    let x_offset = first_obj_path.first()
    let path_start = (x_offset, start_y)

    // Vertical connector from fork bar
    elements.push(
      std-edge(
        path_start,
        first_obj_path,
      ),
    )

    // Add the path elements
    elements += path
  }

  // Join paths if specified
  if join_pos != none {
    let (join_x, join_y) = join_pos

    // Join bar (horizontal line)
    elements.push(
      edge(
        (join_x - total_width / 2, join_y),
        (join_x + total_width / 2, join_y),
        stroke: default-edge-stroke * 3,
      ),
    )

    // Connect each path to join bar
    for path in paths {
      let last_obj_path = path.last().value.pos.raw
      let x_offset = last_obj_path.first()
      let path_end = (x_offset, join_y)
      elements.push(
        std-edge(
          last_obj_path,
          path_end,
        ),
      )
    }
  }

  elements
}

#let data-store(pos, text) = {
  node(
    pos,
    text,
    inset: 20pt,
    stroke: default-node-stroke,
  )
}

#let process(..args) = {
  node(
    inset: 10pt,
    shape: ellipse,
    stroke: default-node-stroke,
    ..args,
  )
}

#let dpd-edge(..args) = {
  edge(
    label-pos: 0.5,
    stroke: default-edge-stroke,
    label-anchor: "center",
    label-fill: white,
    corner-radius: 4pt,
    label-size: 10pt,
    ..args,
    "-|>",
  )
}

// Database shape
#let database(node, extrude) = {
  let (w, h) = node.size

  // Calculate dimensions for the cylinder parts
  let ellipse-height = h * 0.15

  let cap-ratio = 0.2 // Cap height will be 30% of width
  let cap-height = w * cap-ratio

  // Main body sides (without bottom line)
  draw.line(
    (-w, -h + cap-height), // Start at top-left
    (-w, h - cap-height),  // Left side
  )
  draw.line(
    (w, h - cap-height),   // To bottom-right
    (w, -h + cap-height),  // Right side
  )

  // Top ellipse
  draw.circle(
    (0, h - cap-height),
    radius: (w, cap-height),
  )

  // Bottom elliptical cap (front arc only)
  draw.arc(
    (-w, -h + cap-height),
    radius: (w, cap-height),
    start: 180deg,
    delta: 180deg,
  )
}

#let dpd-database(..args) = {
  node(
    shape: database,
    height: 4em,
    stroke: default-node-stroke,
    fill: white,
    ..args,
  )
}
