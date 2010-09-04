#!/bin/bash

basename='twi-miku'
zipball="$basename.bundled.`git rev-parse --short HEAD`.zip"
rm -rf $zipball
appcfg.rb update .
rm -rf $basename
mkdir $basename
cp -r `git ls-files` WEB-INF/ $basename
zip -r $zipball $basename
rm -rf $basename
