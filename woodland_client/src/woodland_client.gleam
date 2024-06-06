import gleam/int
import gleam/list
import gleam/string

import woodland.{type Card, Card}
import woodland/cost

pub fn main() {
  let card =
    Card(
      name: "Foobar",
      cost: [cost.Black(1)],
      types: ["Foobar", "Critter"],
      image: "/foobar.jpg",
      text: "Foobar has 7 damage doodads.",
      flavour: "Foobar!",
    )
  add_card(card)
}

pub fn add_card(card: Card) {
  append_child(".game", "<div class=\"card\">
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
        <footer>" <> card.flavour <> "</footer>
    </div>")
}

/// Appends some HTML as a child of the given selector.
@external(javascript, "ffi", "append_child")
pub fn append_child(selector: String, html: String) -> Nil
