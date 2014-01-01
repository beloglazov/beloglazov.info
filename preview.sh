#!/bin/sh

if ghc --make site.hs; then
    ./site clean
    ./site watch
fi
