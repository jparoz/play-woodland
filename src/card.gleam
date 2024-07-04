import gleam/dynamic.{type Dynamic, field, list, string}
import gleam/int
import gleam/json
import gleam/list
import gleam/result
import gleam/string
import nakai
import nakai/attr
import nakai/html

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

pub fn to_html(card: Card) -> String {
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
  |> nakai.to_inline_string
}
