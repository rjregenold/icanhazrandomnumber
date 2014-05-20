{-# LANGUAGE OverloadedStrings #-}

module Views.Layout
  ( layout
  ) where

import           Text.Blaze.Html5
import           Text.Blaze.Html5.Attributes
import qualified Text.Blaze.Html5 as H
import qualified Text.Blaze.Html5.Attributes as A


layout :: Html -> Html -> Html
layout ttl bdy = docTypeHtml $ do
  H.head $ do
    H.title ttl
    meta ! charset "utf-8"
    meta ! httpEquiv "X-UA-Compatible" ! content "IE=edge,chrome=1"
    meta ! name "description" ! content "Random Number Generator"
    meta ! name "viewport" ! content "width=device-width"
    link ! href "/css/main.css" ! rel "stylesheet" ! media "screen"
  body bdy