module ResponseSpec where

import qualified Data.ByteString.Char8 as BSC

import Response

import Test.Tasty
import Test.Tasty.Hspec

spec :: Spec
spec =
  describe "Response" $ do
    describe "show" $ do
      it "prints the correct response string" $ do
        showR (Register "PlayerA")    `shouldBe` (BSC.pack "REGISTER;PlayerA")
        showR (Join "some-token-456") `shouldBe` (BSC.pack "JOIN;some-token-456")
        showR (See "some-token-123")  `shouldBe` (BSC.pack "SEE;some-token-123")
        showR  None                   `shouldBe`  BSC.empty
