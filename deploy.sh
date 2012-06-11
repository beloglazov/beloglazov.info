#!/bin/sh

./build.sh
cp -R _site/* _deploy
cd _deploy
git add .
git commit -a -m "Auto-commit on `date`"
git push -u origin master
cd ../
