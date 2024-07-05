import card.{type Card}

/// An `Object` is something which is in play, such as a `Card`.
pub type Object {
  Card(card: Card)
}
