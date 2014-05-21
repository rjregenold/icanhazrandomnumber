module Models
  ( RandomNumber(..)
  , readsNumberFormat
  , generateForNumberFormat
  ) where

import Control.Applicative ((<$>))
import System.Random       (randomRIO)


data NumberFormat = NFPlain
                  | NFUSD

readsNumberFormat x
  | x == "usd" = NFUSD
  | otherwise  = NFPlain

data RandomNumber = Plain Integer
                  | USD Integer Integer

generateForNumberFormat lo hi fmt =
  case fmt of
    NFPlain -> Plain <$> randomRIO (lo, hi)
    NFUSD   -> do
      dollars <- randomRIO (lo, hi)
      cents   <- randomRIO (0, 99)
      return $ USD dollars cents
