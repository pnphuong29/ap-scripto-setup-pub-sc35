#!/usr/bin/env bash

ap_setup_bash() {
	# Download bash source code
	ap_bash_version='5.1.16'
	cd "${HOME}/Download"
	curl -LO "https://mirror.downloadvn.com/gnu/bash/bash-${ap_bash_version}.tar.gz"
	tar -zxf "bash-${ap_bash_version}.tar.gz"

	# Install bash
	export AP_VENDORS_BASH_DIR="${HOME}/scripto-data/software/bash/bash-${ap_bash_version}"
	cd "bash-${ap_bash_version}"
	./configure --prefix="${AP_VENDORS_BASH_DIR}"
	make install

	sudo echo "${AP_VENDORS_BASH_DIR}/bin/bash" >>/etc/shells
	chsh -s "${AP_VENDORS_BASH_DIR}/bin/bash"
}

# @#bashsn $$ measure execution time
TIMEFORMAT="It took [%R] seconds to execute this script"
time {
	# Install essential and required apps
	echo "Installing essential and required apps"

	sudo apt update
	sudo apt install -y software-properties-common

	sudo add-apt-repository -y ppa:git-core/ppa
	sudo apt update
	sudo apt install -y git wget curl vim ssh

	# If current bash version < 5.x then uncomment the below lines to install bash
	# ap_setup_bash()

	# Configure ssh
	echo "Configuring ssh"
	mkdir -p ~/.ssh
	touch ~/.ssh/config

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
			"ap-scripto-ubuntu7-sc21"
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

		# SEC1
		cd "${AP_GH_P29_DIR}"
		echo "git clone [git@github.com:pnphuong29/ap-secrets-sec1.git]"
		git clone "git@github.com:pnphuong29/ap-secrets-sec1.git"

		# SEC3
		cd "${AP_GH_P29_DIR}"
		echo "git clone [git@github.com:pnphuong29/ap-secrets-sec3.git]"
		git clone "git@github.com:pnphuong29/ap-secrets-sec3.git"

		# Update ~/.bashrc
		if ! grep scripto-main ~/.bashrc &>/dev/null; then
			echo "" >>~/.bashrc
			cat "${HOME}/scripto-main/configs/.bashrc" >>~/.bashrc
		fi
	fi
}
