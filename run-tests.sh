#!/bin/bash

set -o errexit
set -o nounset

check_script() {
	shellcheck run-tests.sh utils/*.sh
}

check_black() {
	black --check \
		cms-YYYY-run-numbers/code/*.py \
		cms-2013-collision-datasets-hi-ppref/code/*.py \
		cms-2015-collision-datasets-hi-ppref/code/*.py \
		utils/*.py
}

check_pydocstyle() {
	pydocstyle utils/*.py
}

check_all() {
	check_script
	check_black
	check_pydocstyle
}

if [ $# -eq 0 ]; then
	check_all
	exit 0
fi

for arg in "$@"; do
	case $arg in
	--check-shellscript) check_script ;;
	--check-black) check_black ;;
	--check-pydocstyle) check_pydocstyle ;;
	*) ;;
	esac
done
