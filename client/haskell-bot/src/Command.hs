module Command where

data Command = RoundStarting String
  | Unknown String
  deriving (Eq, Show)

