#!/bin/bash
set -e

TEMP_DIR=".temp"
FREQTRADE_COMMIT="3503fdb4ec31be99f433fdce039543e0911964d6"
FREQTRADE_DOCKER_IMAGE="freqtradeorg/freqtrade"
FREQTRADE_DOCKER_TAG="mgm"
MGM_DOCKER_IMAGE="rikj000/monigomani"
MGM_DOCKER_TAG="latest"

if [ ! -d $TEMP_DIR ]
then
  echo "Cloning freqtrade to temp directory..."
  git clone --depth 1 https://github.com/freqtrade/freqtrade.git --branch develop --single-branch $TEMP_DIR
else
  echo "Temp directory already exist"
fi

cd $TEMP_DIR
echo "Checkout freqtrade commit ${FREQTRADE_COMMIT}"
git fetch --depth 1 origin $FREQTRADE_COMMIT
git checkout $FREQTRADE_COMMIT && git reset --hard
echo "Building freqtrade image..."
docker build -t freqtradeorg/freqtrade:$FREQTRADE_DOCKER_TAG .

cd ..
echo "Building MGM image..."
docker build -t $MGM_DOCKER_IMAGE:$MGM_DOCKER_TAG . -f docker/Dockerfile.MoniGoMani

rm -rf $TEMP_DIR
