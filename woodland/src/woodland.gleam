import woodland/cost.{type Cost}

pub type Card {
  Card(
    /// The name of the card.
    name: String,
    /// The cost to play the card.
    cost: List(Cost),
    /// The types of the card.
    types: List(String),
    /// A path to the image file in the assets folder.
    image: String,
    /// The rules text of the card.
    text: String,
    /// The flavour text of the card.
    flavour: String,
  )
}
