#!/bin/bash

# fail on first error
set -e

APP=com.github.manexim.typewriter
MODULE=typewriter

case "$1" in
    build)
        flatpak-builder --repo=repo build ${APP}.yml --force-clean
        flatpak build-bundle repo ${APP}.flatpak --runtime-repo=https://flatpak.elementary.io/repo.flatpakrepo ${APP} master
        ;;
    install)
        flatpak install --user -y ${APP}.flatpak
        ;;
    pot)
        TMPDIR=$(basename `mktemp -u`)
        mkdir "$TMPDIR"
        flatpak-builder build "$APP.yml" --force-clean --stop-at="$MODULE" --state-dir="$TMPDIR"
        echo "ninja extra-pot; ninja $APP-pot" | flatpak-builder build "$APP.yml" --force-clean --build-shell="$MODULE" --state-dir="$TMPDIR"
        cp "$TMPDIR/build/$MODULE/po/extra/extra.pot" po/extra/
        cp "$TMPDIR/build/$MODULE/po/$APP.pot" po/
        rm -rf "$TMPDIR"
        ;;
    po)
        TMPDIR=$(basename `mktemp -u`)
        mkdir "$TMPDIR"
        flatpak-builder build "$APP.yml" --force-clean --stop-at="$MODULE" --state-dir="$TMPDIR"
        echo "ninja extra-update-po; ninja $APP-update-po" | flatpak-builder build "$APP.yml" --force-clean --build-shell="$MODULE" --state-dir="$TMPDIR"
        cp "$TMPDIR/build/$MODULE/po/extra/"*.po po/extra/
        cp "$TMPDIR/build/$MODULE/po/"*.po po/
        rm -rf "$TMPDIR"
        ;;
    run)
        flatpak run ${APP}
        ;;
esac
