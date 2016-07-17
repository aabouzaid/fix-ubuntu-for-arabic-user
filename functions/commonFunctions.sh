# Run with sudo.
# If sudo session expired, will ask for password again with zenity password dialog.
runSudo () {
  if $(sudo -v -n); then
    sudo -S "${@}"
  else
    zenity --password | sudo -S "${@}"
  fi
}

# Zenity dialog (info, message, question ... etc).
showZenityDialog () {
  messageType="${1}"
  messageTitle="${2}"
  messageText="${3}"
  zenity --${messageType} --title="${messageTitle}" --text="${messageText}"
}

# Check exit status and return message in the case of success or fails.
checkExitStatus () {
  exitStatus=$?

  printSuccess () {
    showZenityDialog "info" "" "Done! The task has been performed!"
  }

  printError () {
    showZenityDialog "error" "" "Error! Something is wrong! Please check logs: ${logsFile}"
  }

  printUnexpectedError () {
    showZenityDialog "error" "" "Unexpected error! Please check logs: ${logsFile}"
  }

  # Take action based on 1st function's 1st argument.
  case "$1" in
    --errors-only|-e)
      # Don't print success message. To be used inside loops.
      if [[ ${exitStatus} -eq 0 ]]; then
        continue
      elif [[ ${exitStatus} -eq 1 ]]; then
        printError
      else
        printUnexpectedError
      fi
      return
      ;;
    --unexpected-only|-u)
      # Don't check normal exit status.
      if [[ ${exitStatus} -ne 0 ||  ${exitStatus} -ne 1 ]]; then
        printUnexpectedError
      fi
      return
      ;;
    *)
      # Work normally if there is no argument provided.
      if [[ ${exitStatus} -eq 0 ]]; then
        printSuccess
      elif [[ ${exitStatus} -eq 1 ]]; then
        printError
      else
        printUnexpectedError
      fi
      return
      ;;
  esac
}

isEmpty () {
  if [[ -z "${1}" ]]; then
    echo "Empty"
  else
    echo "NotEmpty"
  fi
}
