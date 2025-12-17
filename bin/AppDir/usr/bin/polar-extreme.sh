#!/bin/sh
printf '\033c\033]0;%s\a' T3-25-SCI25-A
base_path="$(dirname "$(realpath "$0")")"
"$base_path/polar-extreme.x86_64" "$@"
