#!/bin/bash
export GOLAND_MAC_BIN=/Applications/GoLand.app/Contents/MacOS/goland
export GOLAND_GLOBAL_BIN=/usr/local/bin/goland

export PYCHARM_MAC_BIN=/Applications/PyCharm.app/Contents/MacOS/pycharm
export PYCHARM_GLOBAL_BIN=/usr/local/bin/pycharm

export IDEA_MAC_BIN="/Applications/IntelliJ IDEA.app/Contents/MacOS/idea"
export IDEA_GLOBAL_BIN=/usr/local/bin/idea

IDE_TYPE=$1
PROJECT_PATH=$2

if [ "$IDE_TYPE" == "GoLand" ]; then
  if [ -f $GOLAND_GLOBAL_BIN ]; then
  	$GOLAND_GLOBAL_BIN "$PROJECT_PATH"
  elif [ -f $GOLAND_MAC_BIN ]; then
  	$GOLAND_MAC_BIN "$PROJECT_PATH"
  else
  	open -na "GoLand.app" --args "$PROJECT_PATH"
  fi
fi

if [ "$IDE_TYPE" == "PyCharm" ]; then
  if [ -f $PYCHARM_GLOBAL_BIN ]; then
    $PYCHARM_GLOBAL_BIN "$PROJECT_PATH"
  elif [ -f $PYCHARM_MAC_BIN ]; then
    $PYCHARM_MAC_BIN "$PROJECT_PATH"
  else
    open -na "PyCharm.app" --args "$PROJECT_PATH"
  fi
fi

if [ "$IDE_TYPE" == "IntelliJIdea" ]; then
  if [ -f $IDEA_GLOBAL_BIN ]; then
    $IDEA_GLOBAL_BIN "$PROJECT_PATH"
  elif [ -f $IDEA_MAC_BIN ]; then
    $IDEA_MAC_BIN "$PROJECT_PATH"
  else
    open -na "IntelliJ IDEA.app" --args "$PROJECT_PATH"
  fi
fi