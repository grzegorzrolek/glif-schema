#!/bin/bash

# Validate glyphs in UFO packages against the GLIF Schema.
# Copyright 2011 by Grzegorz Rolek.


# Make sure 'xmllint' is available.
type xmllint &>/dev/null || { echo >&2 "Fatal: No 'xmllint' found; can not proceed."; exit 2; }

# Prepare the option index and look for format enforcement option.
OPTIND=1; getopts "f:" OPTION "$@"

# If found, pass only those that make sense; allow a zeroth (i.e., to be read from file) for consistency.
test "$OPTION" = "f" && if test "$OPTARG" = 1 || test "$OPTARG" = 2 || test "$OPTARG" = 0
	then FORMAT=$OPTARG
	else echo >&2 "Fatal: Bad format version: $OPTARG; must be 0-2."; exit 2
	fi

# Skip the options and get into the file paths.
shift $(expr $OPTIND - 1)

# Make sure there's at least one path given.
test $# = 0 && { echo >&2 "Usage: $(basename $0) [-f FORMAT] UFO [UFO ...]"; exit 2; }

# That's a quote of an error message to suppress on format enforcement.
QUOTE="Element 'glyph', attribute 'format':"

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

			# If no format was enforced, read it from a file; assume first if not declared.
			test ${FORMAT=0} = 0 && FORMAT=$(sed -n "/<glyph .*format=[\"']\([1-2]\)[\"'].*>/s//\1/p" <"$UFO"/$GLIF)
			! test $FORMAT && FORMAT=1

			# Validate the file against proper GLIF Schema and catch the results.
			RESULT=$(xmllint --noout --schema "`dirname \"$0\"`"/GLIF$FORMAT/glyph.xsd "$UFO"/$GLIF 2>&1)

			# Inform about failure, but only if the error does not relate to format enforcement.
			# Note that the filter part is fragile as it depends on xmllint's literal error message.
			if test $? != 0 && ! (echo "$RESULT" | grep --quiet "$QUOTE" && test $(wc -l <<<"$RESULT") = 2)
			then STATUS=1; echo "$RESULT" | sed "/$QUOTE/ d" >&2
			fi

		done

	else echo >&2 "Error: Not a UFO, skipping: $UFO"
	fi

	shift

done

# Exit with error if there were any failures.
exit ${STATUS=0}
