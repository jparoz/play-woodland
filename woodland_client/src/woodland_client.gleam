import gleam/int
import gleam/list
import gleam/result
import gleam/string

import woodland/card.{type Card}
import woodland/card/cost
import woodland/card/flavour

import ffi

pub fn main() {
  load_card("/example_cards/market.json")
  load_card("/example_cards/fox.json")
  load_card("/example_cards/buffoon.json")
  load_card("/example_cards/night_watch.json")
  load_card("/example_cards/foobar.json")
}

fn load_card(path: String) {
  use json <- ffi.open_json(path)
  json
  |> card.parse_json
  |> result.lazy_unwrap(fn() { panic as "couldn't parse card JSON" })
  |> add_card
}

fn add_card(card: Card) {
  ffi.append_child(".game", "<div class=\"card\">
        <header>" <> {
    card.cost
    |> list.map(fn(c) {
      "<span class=\"cost "
      <> cost.colour(c)
      <> "\">"
      <> case cost.amount(c) {
        1 -> ""
        n -> int.to_string(n)
      }
      <> "</span>"
    })
    |> string.concat
  } <> "<span class=\"name\">" <> card.name <> "</span>
        </header>
        <div class=\"image\">" <> card.image <> "</div>
        <div class=\"types\">" <> string.join(card.types, " ") <> "</div>
        <div class=\"text\">" <> card.text <> "</div>
        <footer>" <> case card.flavour {
    flavour.Text(text) -> text
    flavour.Quote(quote, author) -> {
      "<q>" <> quote <> "</q><span class=\"author\">" <> author <> "</span>"
    }
  } <> "</footer>
    </div>")
}
