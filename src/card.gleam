import gleam/dynamic.{type Dynamic, field, list, string}
import gleam/json
import gleam/result

import card/cost.{type Cost}
import card/flavour.{type Flavour}

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
    flavour: Flavour,
  )
}

fn decoder(dyn: Dynamic) {
  dyn
  |> dynamic.decode6(
    Card,
    field("name", of: string),
    field("cost", of: cost.decoder),
    field("types", of: list(string)),
    field("image", of: string),
    field("text", of: string),
    field("flavour", of: flavour.decoder),
  )
}

// TODO: this should probably have some other error value
pub fn parse_json(json: String) -> Result(Card, Nil) {
  json.decode(from: json, using: decoder)
  |> result.replace_error(Nil)
}
