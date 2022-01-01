#!/bin/bash

source /home/janson/Documents/qnap.sh

VER=0.5.3
sed -i "s/QPKG_VER=\".*\"/QPKG_VER=\"${VER}\"/g" ./qpkg.cfg

rm ./build/*.qpkg
BASEDIR=/projects/workspace-go/src/github.com/jiajia/sdk/cmd/client/release

mkdir build/upgrade
cp ${BASEDIR}/qnap.amd64 build/upgrade/qnap.amd64
cp ${BASEDIR}/qnap.amd64.json build/upgrade/qnap.amd64.json
cp ${BASEDIR}/qnap.x86 build/upgrade/qnap.x86
cp ${BASEDIR}/qnap.x86.json build/upgrade/qnap.x86.json
cp ${BASEDIR}/qnap.arm build/upgrade/qnap.arm
cp ${BASEDIR}/qnap.arm.json build/upgrade/qnap.arm.json

cp ${BASEDIR}/qnap.amd64 x86_64/LinkEaseAgent
cp ${BASEDIR}/heif-converter.amd64 x86_64/heif-converter
cp ${BASEDIR}/qnap.x86 x86/LinkEaseAgent
cp ${BASEDIR}/qnap.x86 x86_ce53xx/LinkEaseAgent
cp ${BASEDIR}/qnap.arm arm_64/LinkEaseAgent
cp ${BASEDIR}/heif-converter.arm64 arm_64/heif-converter
cp ${BASEDIR}/qnap.arm arm-x19/LinkEaseAgent
cp ${BASEDIR}/qnap.arm arm-x31/LinkEaseAgent
cp ${BASEDIR}/qnap.arm arm-x41/LinkEaseAgent
qbuild

rm ./build/*.md5

for file in build/*.qpkg; do
  target=`echo $file|sed "s/_"${VER}"//g"`
  echo "$file" "${target}"
  mv "$file" "${target}"
done

