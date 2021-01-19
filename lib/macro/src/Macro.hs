module Macro where

import           Data.Map   (Map)
import qualified Data.Map   as M
import           Data.Maybe (fromMaybe)
import           Token      (Spthy (..), Token (..))

data Def = Def String [Token] Token
    deriving (Eq, Ord, Show)

type Stack = Map String ([Token], Token)

reserved :: [String]
reserved = ["define", "undefine", "include"]

expand :: Token -> (Stack, Spthy) -> (Stack, Spthy)
-- | Defining new macros
expand (Node "!define" [decl,body]) (stack, spthy) =
    case decl of
      Node name params
        | name `elem` reserved -> error "@define@ is reserved."
          -- | @name@ can contain "!"
        | otherwise -> (M.insert name (params, body) stack, spthy)
      Leaf name -> (M.insert name ([], body) stack, spthy)

-- | Calling macros
expand tok@(Node ('!':name) args) (stack, spthy) =
    case M.lookup name stack of
      Nothing             -> (stack, tok:spthy)
      -- TODO: what to do when
      -- `length args != length params`
      Just (params, body) ->
          (stack, subst args params body:spthy)
expand tok@(Leaf ('!':name)) (stack, spthy) =
    case M.lookup name stack of
      Nothing        -> (stack, tok:spthy)
      Just (_, body) -> (stack, body:spthy)
-- | Otherwise
expand tok (stack, spthy) = (stack, tok:spthy)

-- | Substitute @args@ for @param@ in @body@
-- invariant: length args == length param
subst :: [Token] -> [Token] -> Token -> Token
subst args params = subst' (M.fromList $ zip args params)
    where
        subst' m tok@(Leaf _)          = fromMaybe tok $ M.lookup tok m
        subst' m tok@(Node name leafs) = Node name $ fmap (subst' m) leafs

process :: Spthy -> Spthy
process = snd . foldr expand (M.empty, [])
