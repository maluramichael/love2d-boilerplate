#!/bin/sh

name=$1

if [ -z "$name" ]; then
  echo "No name"
  exit 1
fi

echo "Create project with the name $name"
sed -i -e "s/\[TITLE\]/$name/g" conf.lua

git submodule init
rm -r .git
git init
git submodule init
git submodule update --recursive
rm init.sh