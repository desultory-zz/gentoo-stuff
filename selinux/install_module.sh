#!/bin/bash

tr -d '\r' < $1.te > $1-converted

checkmodule -M -m -o $1.mod $1-converted
rm $1-converted
semodule_package -m $1.mod -o $1.pp
semodule -i $1.pp
