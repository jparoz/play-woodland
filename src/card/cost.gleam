import gleam/dict
import gleam/dynamic.{type DecodeError, type Dynamic, dict, int, string}
import gleam/option
import gleam/result

pub type Cost {
  Green(Int)
  Blue(Int)
  Red(Int)
  Black(Int)
  Neutral(Int)
}

pub fn colour(cost: Cost) -> String {
  case cost {
    Green(_) -> "green"
    Blue(_) -> "blue"
    Red(_) -> "red"
    Black(_) -> "black"
    Neutral(_) -> "neutral"
  }
}

pub fn amount(cost: Cost) -> Int {
  case cost {
    Green(n) | Blue(n) | Red(n) | Black(n) | Neutral(n) -> n
  }
}

@internal
pub fn decoder(dyn: Dynamic) -> Result(List(Cost), List(DecodeError)) {
  dyn
  |> dict(string, int)
  |> result.map(fn(costs) {
    option.values([
      costs |> dict.get("green") |> option.from_result |> option.map(Green),
      costs |> dict.get("blue") |> option.from_result |> option.map(Blue),
      costs |> dict.get("red") |> option.from_result |> option.map(Red),
      costs |> dict.get("black") |> option.from_result |> option.map(Black),
      costs |> dict.get("neutral") |> option.from_result |> option.map(Neutral),
    ])
  })
}
