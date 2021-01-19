module MacroSpec where

import           Macro
import           Test.Hspec
import           Token      (Token (..))

spec :: Spec
spec = do
  describe "subst" $ do
    it "performs simple substitutions" $ do
      subst [Leaf "x", Leaf "y"] [Leaf "a", Leaf "b"] (Leaf "x")
        `shouldBe` Leaf "a"
      subst [Leaf "x", Leaf "y"] [Leaf "a", Leaf "b"] (Leaf "z")
        `shouldBe` Leaf "z"
      subst [Leaf "x", Leaf "y"] [Leaf "a", Leaf "b"] (Node "enc" [Leaf "a", Leaf "b"])
        `shouldBe` Node "enc" [Leaf "a", Leaf "b"]
      subst [Leaf "x", Leaf "y"] [Leaf "a", Leaf "b"] (Node "enc" [Leaf "x", Leaf "y"])
        `shouldBe` Node "enc" [Leaf "a", Leaf "b"]
      subst [Leaf "x", Leaf "y"] [Leaf "a", Leaf "b"] (Node "enc" [Leaf "x", Leaf "x"])
        `shouldBe` Node "enc" [Leaf "a", Leaf "a"]
