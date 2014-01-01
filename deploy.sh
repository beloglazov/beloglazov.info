#!/bin/sh

if ghc --make site.hs; then
    ./site clean
    ./site build
    cp -R _site/* _deploy
    cd _deploy
    git add .
    git commit -a -m "Deployment on `date`"
    git push -u origin master
    cd ../
fi
