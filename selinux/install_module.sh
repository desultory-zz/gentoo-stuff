#!/bin/bash

checkmodule -M -m -o $1.mod $1.te
semodule_package -m $1.mod -o $1.pp
semodule -i $1.pp
