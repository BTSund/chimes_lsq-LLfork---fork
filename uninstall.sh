#!/bin/bash

# Removes files/folders created during a CMake build
# Run with:
# ./uninstall.sh
# or 
# ./uninstall.sh <install prefix (full path)>

PREFX=${1-""} # Empty by default


for i in `cat build/install_manifest.txt 2>/dev/null`
do
	echo "Removing installed file $i"
	rm -f $i
done

echo "Removing directory build"

rm -rf build


rm -rf $PREFX