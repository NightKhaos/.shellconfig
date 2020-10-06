#!/bin/bash

trigger_remote_editing() {
  PATH=/usr/local/bin:$PATH
  if which mvim > /dev/null
  then
    export VEDITOR='mvim'
  else
    export VEDITOR='vim'
  fi
  LOGFILE=/tmp/iterm_remote_trigger.log
  FTYPE=$1
  USER=$2
  MACHINE=$3
  FILEPATH=$4

  TS="["$(date "+%Y-%m-%d %H:%M:%S")"]"
  echo "${TS} Triggered: ""$@" >> ${LOGFILE}
  if [[ "${FTYPE}" == "directory" ]]; then
        CMD="${VEDITOR} scp://${USER}@${MACHINE}/${FILEPATH}/"
    elif [[ "${FTYPE}" == "file" ]]; then
        CMD="${VEDITOR} scp://${USER}@${MACHINE}/${FILEPATH}"
    else
        echo "${TS} Error: Bad arguments." >> ${LOGFILE}
        exit 1
    fi

    echo "${TS} ${CMD}" >> ${LOGFILE}
    ${CMD}
}

trigger_remote_editing "$@"
