import gleam/result

import card.{type Card}
import ffi

pub fn main() {
  load_card("/example_cards/market.json")
  load_card("/example_cards/fox.json")
  load_card("/example_cards/buffoon.json")
  load_card("/example_cards/night_watch.json")
  load_card("/example_cards/foobar.json")
  add_card(card.Unknown)
}

fn load_card(path: String) {
  use json <- ffi.open_json(path)
  json
  |> card.parse_json
  |> result.lazy_unwrap(fn() { panic as "couldn't parse card JSON" })
  |> card.Card
  |> add_card
}

fn add_card(card: Card) {
  card
  |> card.to_html
  |> ffi.append_child(".game", _)
}
