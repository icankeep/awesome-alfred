#!/bin/bash

function export_env(){
  export IDE_TYPE=$1
  export PROJECT_PATH=$2

  case "$IDE_TYPE" in
  "GoLand")
    find_and_export_app_path "GoLand" "goland"
  ;;
  "PyCharm")
    find_and_export_app_path "PyCharm" "pycharm"
  ;;
  "IntelliJIdea")
    find_and_export_app_path "IntelliJ IDEA" "idea"
  ;;
  "Fleet")
    find_and_export_app_path "Fleet" "fleet"
  ;;
  "WebStorm")
    find_and_export_app_path "WebStorm" "webstorm"
  ;;
  "PhpStorm")
    find_and_export_app_path "PhpStorm" "phpstorm"
  ;;
  "Rider")
    find_and_export_app_path "Rider" "rider"
  ;;
  "CLion")
    find_and_export_app_path "CLion" "clion"
  ;;
  "Aqua")
    find_and_export_app_path "Aqua" "aqua"
  ;;
  "RustRover")
    find_and_export_app_path "RustRover" "rustrover"
  ;;
  "DataGrip")
    find_and_export_app_path "DataGrip" "datagrip"
  ;;
  "RubyMine")
    find_and_export_app_path "RubyMine" "rubymine"
  ;;
  "DataSpell")
    find_and_export_app_path "DataSpell" "dataspell"
  ;;
  "AppCode")
    find_and_export_app_path "AppCode" "appcode"
  ;;
  esac
}

function err(){
  export ERR=1
  export ERR_MSG=$1
  echo "$1"
}

function find_and_export_app_path() {
  export BASE_APP_DIR="/Applications"
  app_prefix=$1
  app_bin_name=$2

  export EXEC_APP="$BASE_APP_DIR/$app_prefix.app"
  export MAC_BIN="$EXEC_APP/Contents/MacOS/$app_bin_name"
  if [ -d "$EXEC_APP" ] && [ -f "$MAC_BIN" ]; then
    return
  fi

  EXEC_APP="$BASE_APP_DIR/$(ls "$BASE_APP_DIR" | grep "$app_prefix" | sort -rn | head -1)"
  MAC_BIN="$EXEC_APP/Contents/MacOS/$app_bin_name"
  if [ ! -d "$EXEC_APP" ]; then
    err "ERR: NOT FOUND $app_prefix"
    exit 1
  fi
}

function open_project(){
  open -na "$EXEC_APP" --args "$PROJECT_PATH"
  if [ $? -ne 0 ]; then
    "$MAC_BIN" "$PROJECT_PATH"
  fi
}

export_env "$1" "$2"
open_project