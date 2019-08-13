module TreeSitter.Clojure.Internal
( tree_sitter_clojure
) where

import Foreign.Ptr
import TreeSitter.Language

foreign import ccall unsafe "vendor/tree-sitter-clojure/src/parser.c tree_sitter_clojure" tree_sitter_clojure :: Ptr Language
