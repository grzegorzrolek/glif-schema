#!/bin/bash

# Validate glyphs in UFO packages against the GLIF Schema.
# Copyright 2011 by Grzegorz Rolek.


# Make sure 'xmllint' is available.
type xmllint &>/dev/null || { echo >&2 "Fatal: No 'xmllint' found; can not proceed."; exit 2; }

# Make sure there's at least one path given.
test $# = 0 && { echo >&2 "Usage: $(basename $0) UFO [UFO ...]"; exit 2; }

while test "$1" != ""
do

	# Remove trailing slash from the path, if any.
	UFO=$(sed 's/\/*$//' <<<"$1")

	# Make sure given path is indeed a UFO package.
	if test -d "$UFO" && grep --quiet '.ufo$' <<<"$UFO"
	then

		# Look through all the .glif files inside the UFO package.
		for GLIF in $(cd "$UFO"; ls glyphs*/*.glif)
		do

			# Dig out .glif file's format version; assume first if not declared.
			FORMAT=$(sed -n "/<glyph .*format=[\"']\([1-2]\)[\"'].*>/s//\1/p" <"$UFO"/$GLIF)
			! test $FORMAT && FORMAT=1

			# Validate the file against proper GLIF Schema and catch the results.
			RESULT=$(xmllint --noout --schema "`dirname \"$0\"`"/GLIF$FORMAT/glyph.xsd "$UFO"/$GLIF 2>&1)

			# Record failed validation and spit the errors, if any.
			test $? != 0 && STATUS=1 && echo >&2 "$RESULT"

		done

	else echo >&2 "Error: Not a UFO, skipping: $UFO"
	fi

	shift

done

# Exit with error if there were any failures.
exit ${STATUS=0}
