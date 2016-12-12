import qualified MessageParserSpec as MPS

import Test.Tasty
import Test.Tasty.Hspec


main :: IO ()
main = do
  tests <- testSpec "Tests" MPS.spec
  defaultMain tests
