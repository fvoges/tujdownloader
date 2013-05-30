#!/bin/bash
# vim: set et ts=2 sw=2 ft=sh:

# Based on one of the scripts from this post:
# http://stormspire.net/addons-ui-customization/7056-auto-updating-undermine-journal-addon-os-x-edition.html
#

# Use an external config file for easy updates
if [ ! -r ${HOME}/.tujdownloader ]
then
  echo "Config file missing.
Please create ${HOME}/.tujdownloader
And add 2 lines like these:
----------
KEY=<replace with your key>
REALMS=<replace with realms list>
----------
"
  exit 1
fi

source ${HOME}/.tujdownloader

# FIXME move to config
ADDONSDIR="/cygdrive/d/Games/World of Warcraft/Interface/AddOns/"

if [ -z ${KEY} ]
then
  echo "Key missing."
  exit 1
fi

if [ -z ${REALMS} ]
then
  echo "Realms list missing."
  exit 1
fi

# FIXME move to config
# FIXME ensure dir exists before trying to download
ZPATH="${HOME}/.download/TheUndermineJournal.zip"
GETZIP=0

if [ -e "$ZPATH" ]
then
  if [ $(date -d "3 hours ago" +%s) -gt $(date -r "${ZPATH}" +%s) ]
  then
    GETZIP=1
    rm "${ZPATH}"
  fi
else
  GETZIP=1
fi

if [ ${GETZIP} -gt 0 ]
then
  curl -sLo "${ZPATH}" "https://theunderminejournal.com/TheUndermineJournal.zip?key=${KEY}&realms=${REALMS}"
  unzip -qqod "${ADDONSDIR}" "${ZPATH}"
fi

