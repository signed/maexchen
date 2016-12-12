module MessageParserSpec where

import Test.Tasty
--import Test.Tasty.SmallCheck as SC
--import Test.Tasty.QuickCheck as QC
--import Test.Tasty.HUnit
import Test.Tasty.Hspec

import Command
import MessageParser


main :: IO ()
main = do
  tests <- testSpec "Tests" spec
  defaultMain tests


spec :: Spec
spec =
  describe "parser" $ do
    it "parses ROUND STARTING" $ do
      parseCommand "ROUND STARTING;some-token-456" `shouldBe` (RoundStarting "some-token-456")

    it "parses YOUR TURN" $ do
      parseCommand "YOUR TURN;some-token-123" `shouldBe` (YourTurn "some-token-123")

    it "parses an unknown command as UNKNOWN" $ do
      parseCommand "REGISTERED" `shouldBe` (Unknown "REGISTERED")
      parseCommand "REJECTED" `shouldBe` (Unknown "REJECTED")
      parseCommand "ROUND STARTED;503;PlayerA,PlayerB" `shouldBe` (Unknown "ROUND STARTED;503;PlayerA,PlayerB")
      parseCommand "PLAYER ROLLS;PlayerA" `shouldBe` (Unknown "PLAYER ROLLS;PlayerA")
      parseCommand "ROLLED;4,2;some-token" `shouldBe` (Unknown "ROLLED;4,2;some-token")
      parseCommand "ANNOUNCED;PlayerA;5,5" `shouldBe` (Unknown "ANNOUNCED;PlayerA;5,5")
      parseCommand "PLAYER WANTS TO SEE;PlayerA" `shouldBe` (Unknown "PLAYER WANTS TO SEE;PlayerA")
      parseCommand "ACTUAL DICE;5,5" `shouldBe` (Unknown "ACTUAL DICE;5,5")
      parseCommand "PLAYER LOST;PlayerB;SOME_REASON" `shouldBe` (Unknown "PLAYER LOST;PlayerB;SOME_REASON")
      parseCommand "SCORE;PlayerX:62,PlayerY:33" `shouldBe` (Unknown "SCORE;PlayerX:62,PlayerY:33")
      parseCommand "ROUND CANCELED;SOME_REASON" `shouldBe` (Unknown "ROUND CANCELED;SOME_REASON")
