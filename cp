#!/bin/bash
[[ -z "$INFO_LEVEL" ]] && source ./submodules/bootstrap/logging

CP_OUTPUT=/tmp/cp.log
SCRIPT_OUTPUT=$(cp $1 $2 > $CP_OUTPUT 2>&1)
ERROR="Unable to copy $1 to $2 due to ..." ./submodules/bootstrap/failonerrors $? $CP_OUTPUT
[ $? -ne 0 ] && exit 1
debug "  -- Copied $1 to $2"
