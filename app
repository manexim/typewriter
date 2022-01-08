#!/bin/bash

# fail on first error
set -e

APP=com.github.manexim.typewriter

case "$1" in
    build)
        flatpak-builder --repo=repo build ${APP}.yml --force-clean
        flatpak build-bundle repo ${APP}.flatpak --runtime-repo=https://flatpak.elementary.io/repo.flatpakrepo ${APP} main
        ;;
    install)
        flatpak install --user -y ${APP}.flatpak
        ;;
    run)
        flatpak run ${APP}
        ;;
esac
