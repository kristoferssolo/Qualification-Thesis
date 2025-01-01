#import "@preview/fletcher:0.5.3" as fletcher: diagram, node, edge
#import fletcher.shapes: diamond

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
  edge(..args, "-|>", label-pos: 0.1, stroke: default-edge-stroke)
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
