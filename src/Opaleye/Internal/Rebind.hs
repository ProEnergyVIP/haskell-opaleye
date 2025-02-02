{-# LANGUAGE FlexibleContexts #-}

module Opaleye.Internal.Rebind where

import Data.Profunctor.Product.Default (Default, def)
import Opaleye.Internal.Unpackspec (Unpackspec, runUnpackspec)
import Opaleye.Internal.QueryArr (SelectArr(QueryArr))
import qualified Opaleye.Internal.PackMap as PM
import qualified Opaleye.Internal.PrimQuery as PQ
import qualified Opaleye.Internal.Tag as Tag

rebind :: Default Unpackspec a a => SelectArr a a
rebind = rebindExplicit def

rebindExplicit :: Unpackspec a b -> SelectArr a b
rebindExplicit u = QueryArr (\(a, tag) ->
                     let (b, bindings) = PM.run (runUnpackspec u (PM.extractAttr "rebind" tag) a)
                     in (b, \_ -> PQ.Rebind True bindings, Tag.next tag))
