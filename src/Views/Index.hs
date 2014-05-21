{-# LANGUAGE OverloadedStrings #-}

module Views.Index where

import           Data.List                   (intercalate)
import           Data.List.Split             (chunksOf)
import           Text.Blaze.Html5
import           Text.Blaze.Html5.Attributes
import qualified Text.Blaze.Html5 as H
import qualified Text.Blaze.Html5.Attributes as A

import           Models                      (RandomNumber(..))
import           Views.Layout                (layout)


render :: RandomNumber -> Html
render num = layout "pseudorandom numbers!" $ do
  h1 $ toHtml $ formattedNum
  where
    formattedNum =
      case num of
        (USD dollars cents) -> formatUSD dollars cents
        (Plain x)           -> showsIntegerWithCommas x


showsIntegerWithCommas x = 
  if x < 0
  then "-" ++ f (abs x)
  else f (abs x)
  where
    f = reverse . intercalate "," . chunksOf 3 . reverse . show

formatUSD :: Integer -> Integer -> String
formatUSD dollars cents = 
  let dollars' = showsIntegerWithCommas dollars
      cents'   = if cents < 10
                 then "0" ++ show cents
                 else show cents
  in  concat ["$", dollars', ".", cents']
