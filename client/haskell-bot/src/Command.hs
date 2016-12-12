module Command where

data Command =
  RoundStarting String
  | YourTurn String
  | Unknown String
  deriving (Eq, Show)

