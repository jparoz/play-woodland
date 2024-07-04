import gleam/dynamic.{type DecodeError, type Dynamic, field, string}

pub type Flavour {
  Quote(text: String, author: String)
  Text(text: String)
}

@internal
pub fn decoder(dyn: Dynamic) -> Result(Flavour, List(DecodeError)) {
  dyn
  |> dynamic.any([
    dynamic.decode2(Quote, field("text", string), field("author", string)),
    dynamic.decode1(Text, field("text", string)),
  ])
}
