{-# LANGUAGE TemplateHaskell #-}
module TreeSitter.Clojure
( tree_sitter_clojure
, Grammar(..)
) where

import Language.Haskell.TH
import TreeSitter.Clojure.Internal
import TreeSitter.Language

-- Regenerate template haskell code when these files change:
addDependentFileRelative "../vendor/tree-sitter-clojure/src/parser.c"

-- | Statically-known rules corresponding to symbols in the grammar.
mkSymbolDatatype (mkName "Grammar") tree_sitter_clojure
