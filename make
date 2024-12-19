#!/usr/bin/env bash

set -eu

cd "${BASH_SOURCE[0]%/*}"

tmpdir=$(mktemp -d)
cleanup() { rm -rf "$tmpdir"; }
trap cleanup EXIT

fetch() {
    local url=$1 oname stat scode surl
    oname=${url##*/}
    stat=$(
        curl -qsSL -C - -z "$oname" \
            -w '%{http_code}\t%{url_effective}' \
            ${UAGENT:+-A "$UAGENT"} \
            -o "$tmpdir/$oname" "$url"
    )
    read -r scode surl <<<"$stat"
    case $scode in
        200) mv "$tmpdir/$oname" "$oname" ;;
        304) ;;
        *)
            exec >&2
            echo "HTTP $scode : $surl"
            cat "$oname"
            return 1
            ;;
    esac
}

fetch https://www.unicode.org/Public/UCD/latest/ucd/UnicodeData.txt
fetch https://raw.githubusercontent.com/vim/vim/master/src/digraph.c
#fetch https://raw.githubusercontent.com/neovim/neovim/master/src/nvim/digraph.c

./compile
