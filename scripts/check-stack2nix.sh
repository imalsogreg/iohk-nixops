#!/bin/bash


# Get relative path to script directory
set -xe
scriptDir=$(dirname -- "$(readlink -f -- "${BASH_SOURCE[0]}")")

time nix-build -A stack2nix -o $scriptDir/stack2nix -Q -j 4

#time $scriptDir/stack2nix/bin/stack2nix --revision 4bcf1e6b601d531f753ebdb6aec23e19d4b08e6c https://github.com/input-output-hk/cardano-sl.git > $scriptDir/default-2.nix

#diff -u pkgs/default.nix $scriptDir/default-2.nix

source ${scriptDir}/../pkgs/generate.sh

git diff --text --exit-code
