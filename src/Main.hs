{-# LANGUAGE OverloadedStrings #-}

module Main 
  ( main
  ) where

import           Control.Monad.Trans                  (liftIO)
import           Data.Maybe                           (fromMaybe)
import qualified Data.Text.Lazy as L
import           Network.Wai.Middleware.RequestLogger (logStdoutDev)
import           Network.Wai.Middleware.Static        (addBase, noDots, staticPolicy, (>->))
import           System.Environment                   (lookupEnv)
import           System.Random                        (randomRIO)
import           Text.Blaze.Html.Renderer.Text        (renderHtml)
import           Web.Scotty

import qualified Views.Index


(defaultPort, defaultMin, defaultMax) = (3000, 0, 999999999999)

main = do
  port <- fromMaybeM defaultPort (lookupEnv "PORT")
  scotty port $ do
    middleware $ staticPolicy (noDots >-> addBase "static")
    middleware logStdoutDev
    get "/" index

index = do
  mn <- fromMaybeParam defaultMin "min"
  mx <- fromMaybeParam defaultMax "max"
  let (lo,hi) = (min mn mx, max mn mx)
  num <- liftIO $ randomRIO (lo, hi)
  blaze $ Views.Index.render num


-------------------------------------------------------------------------------
-- utility functions
-------------------------------------------------------------------------------

blaze = html . renderHtml

maybeParam :: Parsable a => L.Text -> ActionM (Maybe a)
maybeParam name = flip rescue (const $ return Nothing) (param name >>= return . Just)

fromMaybeParam :: Read a => a -> L.Text -> ActionM a
fromMaybeParam d = fromMaybeM d . maybeParam

fromMaybeM :: (Read a, Functor m, Monad m) => a -> m (Maybe String) -> m a
fromMaybeM d val = (safeReadM val) >>= return . fromMaybe d

maybeHead :: [a] -> Maybe a
maybeHead (x:_) = Just x
maybeHead []    = Nothing

safeRead :: Read a => String -> Maybe a
safeRead = fmap fst . maybeHead . reads

safeReadM :: (Read a, Functor m, Monad m) => m (Maybe String) -> m (Maybe a)
safeReadM = fmap (>>= safeRead)