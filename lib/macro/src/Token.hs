module Token where

import           Text.Parsec
import           Text.Parsec.Combinator
import qualified Text.Parsec.Language   as L
import qualified Text.Parsec.Token      as T


data Token = Leaf String
           | Node String [Token]
           deriving (Eq, Ord, Show)

type Spthy = [Token]

type Parser = Parsec String ()

lang :: T.TokenParser ()
lang = T.makeTokenParser $ L.emptyDef
    { T.identStart = alphaNum <|> oneOf "_~:!$#*+<=>-@?|\\^[]%.\""
    , T.identLetter = alphaNum <|> oneOf "_~:!$#*+<=>-@?|\\^[]%.\""
    }

ident :: Parser String
ident = T.whiteSpace lang *> T.identifier lang

commaSep1 :: Parser a -> Parser [a]
commaSep1 = T.commaSep1 lang

comma :: Parser String
comma = T.comma lang

parens :: Parser a -> Parser a
parens = T.parens lang

leaf :: Parser Token
leaf = Leaf <$> ident

node :: Parser Token
node = Node <$> ident <*> parens (commaSep1 tok)

tok :: Parser Token
tok = try node <|> leaf

spthy :: Parser Spthy
spthy = many tok
