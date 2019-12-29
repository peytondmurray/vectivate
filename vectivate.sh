#!/bin/bash

# This file must be sourced; note this only works with bash. For other shells, see
# https://stackoverflow.com/questions/2683279/how-to-detect-if-a-script-is-being-sourced
# for additional implementation options
(return 0 2>/dev/null)
if [[ $? == 1 ]]; then
	echo "vectivate must be sourced; please set your alias accordingly."
	exit 1
fi

# Grab all files named 'activate', count how many levels deep in the directory tree they are,
# and sort the list by depth
targets=$(find ./ -type f -name 'activate' | awk -F"/" '{printf "%s:%s\n", NF, $0}' | sort -nk1 -t:)

# If no candidate targets are found, write an error to stdout. Otherwise, iterate through each one,
# and check whether it looks like a valid virtualenv activate script. If it does, source it; otherwise,
# move on to the other candidate files, which exist deeper into the directory tree
if [ -z ${targets} ]; then
	echo "No virtual environments found in current directory tree."
else
	for target in ${targets}; do
	    fname=$(echo ${target} | awk -F: '{print $NF}')
	    if [[ $(echo ${fname} | awk -F"/" '{print $(NF-1)}') == 'bin' ]]; then
	        if [[ $(head -1 ${fname}) == '# This file must be used with "source bin/activate" *from bash*' ]]; then
	        	unset -f python
	        	unset -f pip
	            source ${fname}
	            echo "Entered virtual environment: ${fname}"
	            break
	        fi
	    fi

	    # If the last candidate file has been reached, issue an error message to stdout.
		if [[ ${target} == $(tail -1 ${targets}) ]]; then
			echo "No virtual environments found in current directory tree."
			exit 1
		fi
	done
fi
