{-# LANGUAGE DisambiguateRecordFields, OverloadedStrings, TemplateHaskell #-}

module Main where

import           TreeSitter.GenerateSyntax
import           Control.Monad
import           Control.Monad.IO.Class
import           Data.ByteString (ByteString)
import           Data.Char
import           Data.Foldable
import           Hedgehog
import qualified Hedgehog.Gen as Gen
import qualified Hedgehog.Range as Range
import           TreeSitter.Python
import qualified TreeSitter.Python.AST as Py
import           TreeSitter.Unmarshal

-- TODO: add tests that verify correctness for product, sum and leaf types

shouldParseInto :: (MonadIO m, MonadTest m, Unmarshal t, Eq t, Show t) => ByteString -> t -> m ()
s `shouldParseInto` t = do
  parsed <- liftIO $ parseByteString tree_sitter_python s
  parsed === Right t

pass = Py.PassStatementSimpleStatement (Py.PassStatement "pass")
one = Py.ExpressionStatementSimpleStatement (Py.ExpressionStatement [Left (Py.PrimaryExpressionExpression (Py.IntegerPrimaryExpression (Py.Integer "1")))])

prop_simpleExamples :: Property
prop_simpleExamples = property $ do
  "pass" `shouldParseInto` Py.Module { Py.statement = [Right pass] }
  "1" `shouldParseInto` Py.Module { Py.statement = [Right one] }

main = void $ checkParallel $$(discover)
