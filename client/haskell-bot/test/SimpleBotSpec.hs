module SimpleBotSpec where

import qualified Data.ByteString.Char8 as BSC

import SimpleBot

import Test.Tasty
import Test.Tasty.Hspec

spec :: Spec
spec =
  describe "Simple Bot" $ do
    describe "register" $ do
      it "sends the player name for registration" $ do
        register "PlayerA" `shouldBe` (BSC.pack "REGISTER;PlayerA")
    describe "replyFor" $ do
      it "answers to a starting round" $ do
        replyFor (BSC.pack "ROUND STARTING;some-token-456") `shouldBe` (BSC.pack "JOIN;some-token-456")
      it "answers to its turn" $ do
        replyFor (BSC.pack "YOUR TURN;some-token-123") `shouldBe` (BSC.pack "SEE;some-token-123")
