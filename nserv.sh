#!/usr/bin/env bash

Arg=$1

case "$Arg" in
    "run-inspect-brk") deno run --allow-env --allow-net --inspect-brk src/main.ts;;
    "run-inspect") deno run --allow-env --allow-net --inspect src/main.ts;;
    "run-watch") deno run --allow-env --allow-net --watch src/main.ts;;
    "run") deno run --allow-env --allow-net src/main.ts;;
    *) echo "Unknown argument: $Arg";;
esac