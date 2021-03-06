#!/bin/sh
# get a list of changes and authors since a give revision tag in Git

if [[ -z "${1}" ]]
then
	echo "Usage: $0 <Git-Tag>" >&2
	echo "       outputs changes marked with 'XYZ:' and a unique list of authors since the tagged release" >&2
	exit 1
fi
RELTAG="${1}"

echo "=== Changes ==="
git log ${RELTAG}.. |
	sed -n '/^ *[A-Z][A-Z][A-Z]: / s/^ *//p'

echo "=== Authors ==="
git log ${RELTAG}.. |
	awk -F': *| *<' '$1 == "Author" { print $2 }' | sort -u
