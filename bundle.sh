#!/bin/bash

basename='twi-miku'
zipball="$basename.bundled.`git rev-parse --short HEAD`.zip"
echo Creating $zipball...
rm -rf $zipball
appcfg.rb update .
rm -rf $basename
mkdir $basename
git ls-files | cpio -pd --quiet $basename
cp -r WEB-INF $basename
zip -qr $zipball $basename
rm -rf $basename
