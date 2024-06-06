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
