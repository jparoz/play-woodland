import gleam/int
import gleam/list
import gleam/result
import gleam/string
import nakai
import nakai/attr
import nakai/html

import card.{type Card}
import card/cost
import card/flavour

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
  card
  |> card_to_html
  |> nakai.to_inline_string
  |> ffi.append_child(".game", _)
}

fn card_to_html(card: Card) -> html.Node {
  let costs =
    card.cost
    |> list.map(fn(c) {
      html.span_text([attr.class("cost " <> cost.colour(c))], case
        cost.amount(c)
      {
        1 -> ""
        n -> int.to_string(n)
      })
    })

  let name = html.span_text([attr.class("name")], card.name)

  let flavour = case card.flavour {
    flavour.Text(text) -> [html.Text(text)]
    flavour.Quote(quote, author) -> [
      html.q_text([], quote),
      html.span_text([attr.class("author")], author),
    ]
  }

  html.div([attr.class("card")], [
    html.header([], list.append(costs, [name])),
    html.div_text([attr.class("image")], card.image),
    html.div_text([attr.class("types")], string.join(card.types, " ")),
    html.div_text([attr.class("text")], card.text),
    html.footer([], flavour),
  ])
}
