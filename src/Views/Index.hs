{-# LANGUAGE OverloadedStrings #-}

module Views.Index where

import           Text.Blaze.Html5
import           Text.Blaze.Html5.Attributes
import qualified Text.Blaze.Html5 as H
import qualified Text.Blaze.Html5.Attributes as A

import           Views.Layout (layout)


render :: Integer -> Html
render num = layout "i can haz random number?" $ do
  h1 $ (toHtml . show) num