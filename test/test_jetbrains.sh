#!bin/bash
set -e

. ./test/test.sh

make build
./bin/aw projects --ide PyCharm $1