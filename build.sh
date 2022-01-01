#!/bin/bash

source /home/janson/Documents/qnap.sh

VER=0.5.3
sed -i "s/QPKG_VER=\".*\"/QPKG_VER=\"${VER}\"/g" ./qpkg.cfg

rm ./build/*.qpkg

mkdir build/upgrade
cp /projects/workspace-go/src/github.com/jiajia/sdk/cmd/client/release/qnap.amd64 build/upgrade/qnap.amd64
cp /projects/workspace-go/src/github.com/jiajia/sdk/cmd/client/release/qnap.amd64.json build/upgrade/qnap.amd64.json
cp /projects/workspace-go/src/github.com/jiajia/sdk/cmd/client/release/qnap.x86 build/upgrade/qnap.x86
cp /projects/workspace-go/src/github.com/jiajia/sdk/cmd/client/release/qnap.x86.json build/upgrade/qnap.x86.json
cp /projects/workspace-go/src/github.com/jiajia/sdk/cmd/client/release/qnap.arm build/upgrade/qnap.arm
cp /projects/workspace-go/src/github.com/jiajia/sdk/cmd/client/release/qnap.arm.json build/upgrade/qnap.arm.json

cp /projects/workspace-go/src/github.com/jiajia/sdk/cmd/client/release/qnap.amd64 x86_64/LinkEaseAgent
cp /projects/workspace-go/src/github.com/jiajia/sdk/cmd/client/release/heif-converter.amd64 x86_64/heif-converter
cp /projects/workspace-go/src/github.com/jiajia/sdk/cmd/client/release/qnap.x86 x86/LinkEaseAgent
cp /projects/workspace-go/src/github.com/jiajia/sdk/cmd/client/release/qnap.x86 x86_ce53xx/LinkEaseAgent
cp /projects/workspace-go/src/github.com/jiajia/sdk/cmd/client/release/qnap.arm arm_64/LinkEaseAgent
cp /projects/workspace-go/src/github.com/jiajia/sdk/cmd/client/release/heif-converter.arm64 arm_64/heif-converter
cp /projects/workspace-go/src/github.com/jiajia/sdk/cmd/client/release/qnap.arm arm-x19/LinkEaseAgent
cp /projects/workspace-go/src/github.com/jiajia/sdk/cmd/client/release/qnap.arm arm-x31/LinkEaseAgent
cp /projects/workspace-go/src/github.com/jiajia/sdk/cmd/client/release/qnap.arm arm-x41/LinkEaseAgent
qbuild

rm ./build/*.md5

for file in build/*.qpkg; do
  target=`echo $file|sed "s/_"${VER}"//g"`
  echo "$file" "${target}"
  mv "$file" "${target}"
done

