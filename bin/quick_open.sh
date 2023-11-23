#!/bin/bash
export IDE_TYPE=$1
export PROJECT_PATH=$2

function export_env(){
#  [[ -f $HOME/.zshrc ]] && source "$HOME/.zshrc" || [[ -f $HOME/.bashrc ]] && source "$HOME/.bashrc"

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
  "Writerside")
    find_and_export_app_path "Writerside" "writerside"
  ;;
  "VsCode")
    find_and_export_app_path "Visual Studio Code" "code"
    export MAC_BIN="/usr/local/bin/code"
  ;;
  esac
}

function clone_project_if_need(){
  if [[ $PROJECT_PATH == git@* ]]; then
    REPO_PREFIX=$(echo "$PROJECT_PATH" | cut -d@ -f2 | cut -d/ -f1)
    REPO_NAME=$(echo "$PROJECT_PATH" | cut -d/ -f2 | cut -d. -f1)

    export CLONE_ROOT_DIR=$HOME/$IDE_TYPE"Projects"

    if [[ $IDE_TYPE == "GoLand" ]]; then
      DOMAIN=$(echo "$REPO_PREFIX" | cut -d: -f1)
      SUB_DOMAIN=$(echo "$REPO_PREFIX" | cut -d: -f2)
      export CLONE_ROOT_DIR=$GOPATH/src/$DOMAIN/$SUB_DOMAIN
    fi

    export CLONE_DIR=$CLONE_ROOT_DIR/$REPO_NAME
    if [[ ! -d $CLONE_DIR ]]; then
      mkdir -p "$CLONE_DIR"
      git clone "$PROJECT_PATH" "$CLONE_DIR"
    fi
    export PROJECT_PATH=$CLONE_DIR
  fi
}

function err(){
  export ERR=1
  export ERR_MSG=$1
  echo "$1"
}

function find_and_export_app_path() {
  _find_and_export_app_path "$1" "$2" "/Applications"
  if [ -z "$EXEC_APP" ] || [ ! -d "$EXEC_APP" ]; then
    _find_and_export_app_path "$1" "$2" "$HOME/Applications"
  fi
  if [ -z "$EXEC_APP" ] || [ ! -d "$EXEC_APP" ]; then
    err "ERR: NOT FOUND $app_prefix"
    exit 1
  fi
}

function _find_and_export_app_path() {
  app_prefix=$1
  app_bin_name=$2
  app_base_dir=$3
  app_name=$(ls "$app_base_dir" | grep "$app_prefix" | sort -rn | head -1)

  export EXEC_APP="$app_base_dir/$app_prefix.app"
  export MAC_BIN="$EXEC_APP/Contents/MacOS/$app_bin_name"
  if [ -d "$EXEC_APP" ] && [ -f "$MAC_BIN" ]; then
    return
  fi

  EXEC_APP="$app_base_dir/$app_name"
  MAC_BIN="$EXEC_APP/Contents/MacOS/$app_bin_name"
  if [ -z "$app_name" ] || [ ! -d "$EXEC_APP" ]; then
    export EXEC_APP=""
    export MAC_BIN=""
  fi
}

function open_project(){
  open -na "$EXEC_APP" --args "$PROJECT_PATH"
  if [ $? -ne 0 ]; then
    "$MAC_BIN" "$PROJECT_PATH"
  fi
}

export_env
clone_project_if_need
open_project
