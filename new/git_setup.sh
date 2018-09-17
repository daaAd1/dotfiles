#!/bin/bash
# Sets up gitlab environment and prompts to pull repositories from gitlab
# Uses --global switch when setting user name and e-mail

# Prerequisites (software)
sudo apt-get -y install git xclip

# Enter user details
read -p "Enter your gitlab e-mail address: " email
read -p "Enter your name: " name

# SSH setup
ssh-keygen -t rsa -C "$email"
xclip -sel clip < ~/.ssh/id_rsa.pub

printf "$(tput setaf 2)!!! PUBLIC SSH KEY WAS COPIED TO CLIPBOARD, PLEASE ADD IT HERE: $(tput smul)https://git.kpi.fei.tuke.sk/profile/keys$(tput rmul) !!!$(tput setaf 7)\n"
while true; do
	read -p "Confirm by typing 'Done': " answer
	if [[ $answer = "Done" ]]; then
		break
	fi
done

# User config
git config --global user.email "$email"
git config --global user.name "$name"

# Adding repositories
while true; do
	read -p "Do you want to pull repository ? [Y/n] " answer
	if [[ ($answer = "y") || ($answer = "Y") ]]; then
		read -p "Enter repository address from https://git.kpi.fei.tuke.sk/dashboard/projects : " repo
		git clone $repo
	elif [[ ($answer = "n") || ($answer = "N") ]]; then
		break
	fi
done
