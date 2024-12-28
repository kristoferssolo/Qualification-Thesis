pub fn generate_backtracking(
    maze: &mut HexMaze,
    start_pos: Option<Hex>,
    seed: Option<u64>,
) {
    if maze.is_empty() {
        return;
    }
    let start = start_pos.unwrap_or(Hex::ZERO);
    let mut visited = HashSet::new();
    let mut rng: Box<dyn RngCore> = seed.map_or_else(
        || Box::new(thread_rng()) as Box<dyn RngCore>,
        |seed| Box::new(ChaCha8Rng::seed_from_u64(seed)) as Box<dyn RngCore>,
    );
    recursive_backtrack(maze, start, &mut visited, &mut rng);
}

fn recursive_backtrack<R: Rng>(
    maze: &mut HexMaze,
    current: Hex,
    visited: &mut HashSet<Hex>,
    rng: &mut R,
) {
    visited.insert(current);
    let mut directions = EdgeDirection::ALL_DIRECTIONS;
    directions.shuffle(rng);
    for direction in directions {
        let neighbor = current + direction;
        if maze.get_tile(&neighbor).is_some() && !visited.contains(&neighbor) {
            maze.remove_tile_wall(&current, direction);
            maze.remove_tile_wall(&neighbor, direction.const_neg());
            recursive_backtrack(maze, neighbor, visited, rng);
        }
    }
}
