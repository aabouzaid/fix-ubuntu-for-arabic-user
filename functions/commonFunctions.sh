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
check_exit_status () {
    runCmd=${1}
  if [[ $? = 0 ]]; then
    showZenityDialog "info" "" "Done!"
  elif [[ $? = 1 ]]; then
    ${runCmd}
  else
    echo $(printf '=%.0s' {1..50}) >> ${logsFile}
    showZenityDialog "error" "" "Sorry! Unexpected error! Please check logs: ${logsFile}"
  fi
}
