#!/bin/bash

# targets=$(find ./ -name '*.py' | awk -F"/" '{printf "%s:%s\n", NF, $0}' | sort -nk1 -t:)
targets=$(find ./ -name 'activate' | awk -F"/" '{printf "%s:%s\n", NF, $0}' | sort -nk1 -t:)

for target in ${targets}; do

    fname=$(echo ${target} | awk -F: '{print $NF}')
    if [[ $(echo ${fname} | awk -F"/" '{print $(NF-1)}') == 'bin' ]]; then
        if [[ $(head -1 ${fname}) == '# This file must be used with "source bin/activate" *from bash*' ]]; then
            # Activate the virtual environment
            unalias python
            unalias pip
        fi
    fi
done

echo 'Activating virtual environment!'