import card.{type Card}
import object.{type Object}

/// `GameState` represents the entire state of a game,
/// including board state,
/// current turn,
/// temporary resources,
/// etc.
pub type GameState {
  GameState(you: BoardState, opponent: BoardState)
}

/// `BoardState` represents the board state of a single player.
/// Each client has different information about the game's board state;
/// information is only shared with each client
/// as is necessary throughout gameplay.
pub type BoardState {
  BoardState(deck: List(Card), hand: List(Card), in_play: List(Object))
}
