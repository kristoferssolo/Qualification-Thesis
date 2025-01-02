/// A bit-flag representation of walls in a hexagonal tile.
///
/// `Walls` uses an efficient bit-flag system to track the presence or absence of walls
/// along each edge of a hexagonal tile. Each of the six possible walls is represented
/// by a single bit in an 8-bit integer, allowing for fast operations and minimal memory usage.
///
/// # Examples
///
/// Creating and manipulating walls:
/// ```
/// use hexlab::prelude::*;
///
/// // Create a hexagon with all walls
/// let walls = Walls::new();
/// assert!(walls.is_enclosed());
///
/// // Create a hexagon with no walls
/// let mut walls = Walls::empty();
/// assert!(walls.is_empty());
///
/// // Add specific walls
/// walls.insert(EdgeDirection::FLAT_NORTH);
/// walls.insert(EdgeDirection::FLAT_SOUTH);
/// assert_eq!(walls.count(), 2);
/// ```
#[cfg_attr(feature = "serde", derive(serde::Serialize, serde::Deserialize))]
#[cfg_attr(feature = "bevy_reflect", derive(bevy_reflect::Reflect))]
#[cfg_attr(feature = "bevy", derive(Component))]
#[cfg_attr(feature = "bevy", reflect(Component))]
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub struct Walls(u8);

impl Walls {
    /// Insert a wall in the specified direction.
    ///
    /// # Arguments
    ///
    /// - `direction` - The direction in which to insert the wall.
    ///
    /// # Returns
    ///
    /// Returns `true` if a wall was present, `false` otherwise.
    ///
    /// # Examples
    ///
    /// ```
    /// use hexlab::prelude::*;
    ///
    /// let mut walls = Walls::empty();
    /// assert_eq!(walls.count(), 0);
    ///
    /// assert!(!walls.insert(1));
    /// assert_eq!(walls.count(), 1);
    ///
    /// assert!(walls.insert(1));
    /// assert_eq!(walls.count(), 1);
    ///
    /// assert!(!walls.insert(EdgeDirection::FLAT_NORTH));
    /// assert_eq!(walls.count(), 2);
    /// ```
    #[inline]
    pub fn insert<T>(&mut self, direction: T) -> bool
    where
        T: Into<Self>,
    {
        let mask = direction.into().0;
        let was_present = self.0 & mask != 0;
        self.0 |= mask;
        was_present
    }

    /// Removes a wall in the specified direction.
    ///
    /// # Arguments
    ///
    /// - `direction` - The direction from which to remove the wall.
    ///
    /// # Returns
    ///
    /// Returns `true` if a wall was present and removed, `false` otherwise.
    ///
    /// # Examples
    ///
    /// ```
    /// use hexlab::prelude::*;
    ///
    /// let mut walls = Walls::new();
    ///
    /// assert!(walls.remove(1));
    /// assert_eq!(walls.count(), 5);
    ///
    /// assert!(!walls.remove(1));
    /// assert_eq!(walls.count(), 5);
    ///
    /// assert!(walls.remove(EdgeDirection::FLAT_NORTH));
    /// assert_eq!(walls.count(), 4);
    /// ```
    #[inline]
    pub fn remove<T>(&mut self, direction: T) -> bool
    where
        T: Into<Self>,
    {
        let mask = direction.into().0;
        let was_present = self.0 & mask != 0;
        self.0 &= !mask;
        was_present
    }

    /// Checks if there is a wall in the specified direction.
    ///
    /// # Arguments
    ///
    /// - `other` - The direction to check for a wall.
    ///
    /// # Examples
    ///
    /// ```
    /// use hexlab::prelude::*;
    ///
    /// let mut walls = Walls::empty();
    /// walls.insert(EdgeDirection::FLAT_NORTH);
    ///
    /// assert!(walls.contains(EdgeDirection::FLAT_NORTH));
    /// assert!(!walls.contains(EdgeDirection::FLAT_SOUTH));
    /// ```
    #[inline]
    pub fn contains<T>(&self, direction: T) -> bool
    where
        T: Into<Self>,
    {
        self.0 & direction.into().0 != 0
    }

    /// Toggles a wall in the specified direction.
    ///
    /// If a wall exists in the given direction, it will be removed.
    /// If no wall exists, one will be added.
    ///
    /// # Arguments
    ///
    /// - `direction` - The direction in which to toggle the wall.
    ///
    /// # Returns
    ///
    /// The previous state (`true` if a wall was present before toggling, `false` otherwise).
    ///
    /// # Examples
    ///
    /// ```
    /// use hexlab::prelude::*;
    ///
    /// let mut walls = Walls::empty();
    ///
    /// assert!(!walls.toggle(0));
    /// assert_eq!(walls.count(), 1);
    ///
    /// assert!(walls.toggle(0));
    /// assert_eq!(walls.count(), 0);
    /// ```
    pub fn toggle<T>(&mut self, direction: T) -> bool
    where
        T: Into<Self> + Copy,
    {
        let mask = direction.into().0;
        let was_present = self.0 & mask != 0;
        self.0 ^= mask;
        was_present
    }
}

impl From<EdgeDirection> for Walls {
    fn from(value: EdgeDirection) -> Self {
        Self(1 << value.index())
    }
}

impl From<u8> for Walls {
    fn from(value: u8) -> Self {
        Self(1 << value)
    }
}

impl FromIterator<EdgeDirection> for Walls {
    fn from_iter<T: IntoIterator<Item = EdgeDirection>>(iter: T) -> Self {
        let mut walls = 0u8;
        for direction in iter {
            walls |= 1 << direction.index();
        }
        Self(walls)
    }
}

impl<const N: usize> From<[EdgeDirection; N]> for Walls {
    fn from(value: [EdgeDirection; N]) -> Self {
        value.into_iter().collect()
    }
}
