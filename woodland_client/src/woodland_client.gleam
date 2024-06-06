import gleam/int
import gleam/list
import gleam/string

import woodland.{type Card, Card}
import woodland/cost
import woodland/flavour

pub fn main() {
  let fox =
    Card(
      name: "Fox",
      cost: [cost.Red(3)],
      types: ["Fox", "Critter"],
      image: "/fox.jpg",
      text: "Fox has 15 damage doodads.",
      flavour: flavour.Quote(
        "A fox never smells its own farts, except while driving off a cliff.",
        "The Great Fox",
      ),
    )

  let buffoon =
    Card(
      name: "Buffoon",
      cost: [cost.Green(1)],
      types: ["Baboon", "Critter"],
      image: "/buffoon.jpg",
      text: "Buffoon has 1 damage doodad.",
      flavour: flavour.Text("Great bumbling baboons!"),
    )

  let night_watch =
    Card(
      cost: [cost.Blue(2)],
      name: "Night Watch",
      image: "night_watch.png",
      types: ["Bird", "Spell"],
      text: "Make 2 1/1 flying Bird Critters.",
      flavour: flavour.Text(
        "The night shift can be hard, but it's easier with a friend.",
      ),
    )

  let market =
    Card(
      cost: [
        cost.Green(1),
        cost.Blue(1),
        cost.Red(1),
        cost.Black(1),
        cost.Neutral(1),
      ],
      name: "Market",
      image: "/market.jpg",
      types: ["Building", "Spell"],
      text: "Get 5 of any one type of food.",
      flavour: flavour.Text("Variety is the spice of life."),
    )

  let foobar =
    Card(
      name: "Foobar",
      cost: [cost.Black(1)],
      types: ["Foobar", "Critter"],
      image: "/foobar.jpg",
      text: "Foobar has 7 damage doodads.",
      flavour: flavour.Text("Foobar!"),
    )

  add_card(fox)
  add_card(buffoon)
  add_card(night_watch)
  add_card(market)
  add_card(foobar)
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
        <footer>" <> case card.flavour {
    flavour.Text(text) -> text
    flavour.Quote(quote, author) -> {
      "<q>" <> quote <> "</q><span class=\"author\">" <> author <> "</span>"
    }
  } <> "</footer>
    </div>")
}

/// Appends some HTML as a child of the given selector.
@external(javascript, "ffi", "append_child")
pub fn append_child(selector: String, html: String) -> Nil
