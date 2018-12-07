#!/bin/bash
set -e

# Modify this here to automate the building process.
# This can include auto syncing the manifest, cleaning unused makefiles or setting up ccache.
if [ ! "$(ccache -s|grep -E 'max cache size'|awk '{print $4}')" = "120.0" ]
then
    ccache -M 120G
fi

exec bash