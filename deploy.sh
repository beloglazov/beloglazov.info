#!/bin/sh

if stack ghc -- --make site.hs; then
    ./site clean
    ./site build
    cp -R _site/* ../beloglazov.github.io/
    cd ../beloglazov.github.com
    git add .
    git commit -a -m "Deployment on `date`"
    git push -u origin master
    cd ../
fi
