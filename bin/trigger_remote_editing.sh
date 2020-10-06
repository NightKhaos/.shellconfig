#!/bin/bash

trigger_remote_editing() {
  if which mvim > /dev/null
  then
    export VEDITOR='mvim'
  else
    export VEDITOR='vim'
  fi
  LOGFILE=/tmp/iterm_remote_trigger.log
  FTYPE=$1
  MACHINE=$2
  FILEPATH=$3

  TS="["$(date "+%Y-%m-%d %H:%M:%S")"]"
  echo "${TS} Triggered: ""$@" >> ${LOGFILE}
  if [[ "${FTYPE}" == "directory" ]]; then
        CMD="${VEDITOR} scp://${MACHINE}/${FILEPATH}/"
    elif [[ "${FTYPE}" == "file" ]]; then
        CMD="${VEDITOR} scp://${MACHINE}/${FILEPATH}"
    else
        echo "${TS} Error: Bad arguments." >> ${LOGFILE}
        exit 1
    fi

    echo "${TS} ${CMD}" >> ${LOGFILE}
    ${CMD}
}

trigger_remote_editing "$@"
