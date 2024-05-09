#!/bin/sh

set -e

: "${PREFIX:=/usr}"
: "${uninstall:=false}"

_msg() {
    echo "=>" "$@" >&2
}

_rm() {
    sudo rm -rf "$1"
    sudo rmdir -p "$(dirname "$1")" 2>/dev/null || true
}

_uninstall() {
    _msg "Deleting ..."
    _rm "$PREFIX/share/wallpapers/Materia"
}

_install() {
    _msg "Installing ..."
    sudo cp -R \
        "./wallpapers" \
        "$PREFIX/share"
}

_cleanup() {
    _msg "Clearing cache ..."
    rm  ~/.cache/plasma-svgelements-Materia* \
        ~/.cache/plasma_theme_Materia*.kcache
    _msg "Done!"
}

trap _cleanup EXIT HUP INT TERM

_uninstall
_uninstall


if [ "$uninstall" = "false" ]; then
    _install
fi
