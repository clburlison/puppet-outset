#!/bin/bash
# Download and extract most recent version of chilcote/outset for install via puppet
version=$(curl -s https://api.github.com/repos/chilcote/outset/releases | python -c 'import json,sys;obj=json.load(sys.stdin); print obj[0]["tag_name"]')
mkdir $version
cd $version
curl -sL -o ./outset.zip --connect-timeout 30 $(curl -s https://api.github.com/repos/chilcote/outset/releases | python -c 'import json,sys;obj=json.load(sys.stdin); print obj[0]["zipball_url"]')
unzip -o outset.zip
mv -f chilcote-outset-*/pkgroot/Library/*/* ../
rsync -a chilcote-outset-*/pkgroot/usr/local/outset/* ../
cd ..
rm -rf $version
echo 'Finished'

