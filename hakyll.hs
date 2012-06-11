{-# LANGUAGE OverloadedStrings #-}
import Control.Arrow ((>>>), arr)

import Hakyll

main :: IO ()
main = hakyll $ do
    match "images/*" $ do
        route   idRoute
        compile copyFileCompiler

    match "papers/*" $ do
        route   idRoute
        compile copyFileCompiler

    match "css/*" $ do
        route   idRoute
        compile compressCssCompiler

    match "templates/*" $ compile templateCompiler

    match (list ["index.html"]) $ do
        route   $ setExtension "html"
        compile $ myPageCompiler
            >>> applyTemplateCompiler "templates/default.html"
            >>> relativizeUrlsCompiler

    match (list ["about.md", "projects.md", "publications.md"]) $ do
        route   $ setExtension "html" `composeRoutes` gsubRoute ".html" (const "/index.html")
        compile $ pageCompiler
            >>> applyTemplateCompiler "templates/default.html"
            >>> relativizeUrlsCompiler

myPageCompiler = 
    readPageCompiler >>>
    addDefaultFields >>>  -- Sets some things like tutorials/faq.markdown
    arr applySelf         -- Used to fill in $var$s in the page
