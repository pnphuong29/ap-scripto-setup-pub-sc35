#!/usr/bin/env bash

TIMEFORMAT="It took [%R] seconds to execute this script"
time {
    # Install homebrew
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    # Install essential and required apps
    echo "Installing essential and required apps"
    brew install bash git curl wget

    # Configure ssh
    echo "Configuring ssh"
    echo "Configuring ssh"
    mkdir -p ~/.ssh
    touch ~/.ssh/authorized_keys # Input public key here
    touch ~/.ssh/config
    chmod 700 ~/.ssh
    chmod 600 ~/.ssh/authorized_keys
    chmod 600 ~/.ssh/config

    mkdir -p ~/secrets
    touch ~/secrets/ap-p29.key.priv
    chmod 600 ~/secrets/*

    if [ ! -f ~/secrets/ap-p29.key.priv ]; then
        echo "You should configure [~/.ssh/config] file and add private key to clone repos"
    else
        export AP_GH_P29_DIR="${HOME}/scripto-data/projects/github.com/pnphuong29"
        mkdir -p "${AP_GH_P29_DIR}"

        # Projects to clone and symlink (parallel arrays)
        repos=(
            "ap-scripto-core-pub-sc108"
            "ap-scripto-share-sc1"
            "ap-scripto-common-sc28"
            "ap-scripto-macos-sc7"
        )

        symlinks=(
            "scripto"
            "scripto-share"
            "scripto-common"
            "scripto-main"
        )

        for i in "${!repos[@]}"; do
            repo="${repos[$i]}"
            target_dir="${AP_GH_P29_DIR}/${repo}"

            cd "${AP_GH_P29_DIR}" || exit
            echo "git clone [git@github.com:pnphuong29/${repo}.git]"
            git clone "git@github.com:pnphuong29/${repo}.git"

            rm -rf "${HOME:?}/${symlinks[$i]}"
            ln -s "${target_dir}" "${HOME:?}/${symlinks[$i]}"
        done

        # Update ~/.profile
        if ! grep scripto-main ~/.profile &>/dev/null; then
            echo "" >>~/.profile
            cat "${HOME}/scripto-main/configs/.profile" >>~/.profile
        fi
    fi
}
