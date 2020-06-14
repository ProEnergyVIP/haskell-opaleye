{-# LANGUAGE Arrows #-}

module QuickCheck where

import qualified Data.Profunctor.Product as PP

chooseChoice :: (a -> i) -> f i -> f a
chooseChoice choose fi = _ $ proc a -> do
  case choose a of
    i  -> fi -< i
