#!/bin/bash
#
# Shell script to automate Composer install on shared DreamHost account
#
# author: Grzegorz Wojcik
# source & readme: https://github.com/kminek/dhcomposer
#
################################################################################

clear

selection=
until [ "$selection" = "0" ]; do
	echo ""
	echo "This shell script will install Composer on your shared DreamHost account"
	echo "Pick PHP version to use:"
	echo ""
	echo "1 - PHP 5.3"
	echo "2 - PHP 5.4"
	echo ""
	echo "0 - do nothing, exit"
	echo ""
	echo -n "Enter selection: "
	read selection
	echo ""
	case $selection in
		1 ) VER="5.3"; break ;;
		2 ) VER="5.4"; break ;;
		0 ) return ;;
		* ) echo "Please enter 1, 2, or 0"
	esac
done

if [ ! -d ~/bin ]; then
	echo "Creating ~/bin directory ..."
	mkdir ~/bin
fi

if [ -f ~/bin/php ]; then
	rm ~/bin/php
fi

echo "Creating symlink to php binary inside ~/bin directory ..."
ln -s /usr/local/bin/php-$VER ~/bin/php

if [[ ! ":$PATH:" == *":$HOME/bin:"* ]]; then
	echo "Adding ~/bin to PATH"
	echo "export PATH=~/bin:\$PATH" >> ~/.bash_profile
	echo "export PATH=~/bin:\$PATH" >> ~/.bashrc
	. ~/.bash_profile
	. ~/.bashrc
fi

PHAR=$(php -m | grep Phar)

if [ ! "$PHAR" == "Phar" ]; then

	if [ ! -d ~/.php/$VER ]; then
		echo "Creating ~/.php/$VER directory ..."
		mkdir -p ~/.php/$VER
	fi

	if [ ! -f ~/.php/$VER/phprc ]; then
		echo "Creating ~/.php/$VER/phprc file ..."
		touch ~/.php/$VER/phprc
	fi

	echo "Adding phar extension in ~/.php/$VER/phprc file ..."
	echo "extension = phar.so" >> ~/.php/$VER/phprc
	echo "suhosin.executor.include.whitelist = phar" >> ~/.php/$VER/phprc

fi

if [ ! -f ~/bin/composer ]; then
	echo "Installing Composer ..."
	curl -sS https://getcomposer.org/installer | php -- --install-dir=$HOME/bin
	mv ~/bin/composer.phar ~/bin/composer
	chmod u+x ~/bin/composer
fi

echo "Done."
