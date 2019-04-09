#!/bin/bash

# shellcheck disable=SC1091
source .env

CURENT_DIR=$(pwd)
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
BUILD_DIR=$SCRIPT_DIR"/../"
GIT_COMMIT=$(git rev-parse HEAD)

cd "$BUILD_DIR" || exit 1

usage() { 
  echo "Usage: $0 [-t tag | -m build mode | -h this help ]" 1>&2
  echo "Default values are: tag=latest, mode=none" 1>&2
  echo "Provide \"-m upgrade\" to upgrade container's OS" 1>&2
  exit 1
  }

#setting defaults
TAG='latest'
MODE='none'

while getopts ":t:m:h" arg; do
    case "${arg}" in
        t)
          TAG=${OPTARG}
          ;;
        m)
          MODE=${OPTARG}
          ;;
        h | \?)
          usage
    esac
done

echo "Building with TAG: $TAG"
echo "Using MODE: $MODE"
echo "CATALINA_BASE: $CATALINA_BASE"
echo "GIT_COMMIT: $GIT_COMMIT"

docker build -f Dockerfile \
  --build-arg CATALINA_BASE="$CATALINA_BASE" \
  --build-arg GIT_COMMIT="$GIT_COMMIT" \
  --build-arg MODE="$MODE" \
  -t "$REGISTRY"/bitblo-base:"$TAG" \
 .
# ^ this dot at the end is super important!

cd "$CURENT_DIR" || exit 1