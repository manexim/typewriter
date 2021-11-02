#!/bin/bash

# fail on first error
set -e

APP=com.github.manexim.typewriter

flatpak-builder --repo=repo build ${APP}.yml --force-clean
flatpak build-bundle repo ${APP}.flatpak --runtime-repo=https://flatpak.elementary.io/repo.flatpakrepo ${APP} master
flatpak install --user -y ${APP}.flatpak
flatpak run ${APP}
