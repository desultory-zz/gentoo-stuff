#!/bin/bash

if [[ -z $1 ]]; then
	echo "You must specify a module name"
	exit 1
fi

if [[ "$1" == "-h" ]]; then
	echo "Arguement should be module name"
	exit 1
fi

name=$1

if [[ ! -f $name ]]; then
	name=$(echo "$name" | cut -f 1 -d '.')
	name=$name.te
fi

if [[ ! -f $name ]]; then
	echo "File $name not found"
	exit 1
fi

checkmodule -M -m -o $name.mod $name
ret=$?
if [[ $ret -eq 0 ]]; then
	semodule_package -m $name.mod -o $name.pp
	ret=$?
	rm $name.mod
	if [[ $ret -eq 0 ]]; then
		semodule -i $name.pp
		ret=$?
		rm $name.pp
		if [[ $ret -ne 0 ]]; then
			echo "Failed to install package"
			exit 1
		fi
	else
		echo "Failed to package module"
		exit 1
	fi
else
	echo "Failed to create module"
	exit 1
fi


