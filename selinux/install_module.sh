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
rand=$RANDOM
randmame=$name-$rand

if [[ -f $name ]]; then
	tr -d '\r' < $name > $randname
	name=$(echo "$name" | cut -f 1 -d '.')
elif [[ -f "$name.te" ]]; then
	tr -d '\r' < $name.te > $randname
else
	echo "$name.te not found"
	exit 1
fi

checkmodule -M -m -o $randname.mod $randname
ret=$?
rm $randname
if [[ $ret -eq 0 ]]; then
	semodule_package -m $randname.mod -o $randname.pp
	ret=$?
	rm $randname.mod
	if [[ $ret -eq 0 ]]; then
		semodule -i $randname.pp
		ret=$?
		rm $randname.pp
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

