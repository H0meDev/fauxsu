#!/bin/bash

unset persist
while getopts "p:" Option; do
	case $Option in
		p) persist="${OPTARG}" ;;
		*) exit 1 ;;
	esac
done

shift $(($OPTIND - 1))

if [[ ! -z "$persist" ]]; then
	export _FAUXSU_PERSIST_FILENAME="$persist"
fi

export DYLD_INSERT_LIBRARIES=/usr/libexec/fauxsu/libfauxsu.dylib
if [[ $# -eq 0 ]]; then
	${SHELL:-/bin/sh}
	RESULT=$?
else
	"$@"
	RESULT=$?
fi
exit $RESULT
