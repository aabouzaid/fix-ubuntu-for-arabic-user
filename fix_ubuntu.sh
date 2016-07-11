#! /bin/bash

#########################################
# Vars

logsFile="./fix-ubuntu.log"


#########################################
# Main.

# 
runSudo () {
  if [[ $(sudo -v -n| grep -q 'sudo: a password is required') ]]; then
    zenity --password | sudo -S "${@}"
  else
    sudo -S "${@}"
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
  if [[ $? = 0 ]]; then
    showZenityDialog "info" "" "Done!"
   else
    echo $(printf '=%.0s' {1..50}) >> ${logsFile}
    showZenityDialog "error" "" "Sorry! Unexpected error! Please check logs: ${logsFile}"
  fi
}


# Main dialog.
#=========================
mainDialog () {
  mainAction=$(
  zenity --list --radiolist \
    --title="What do you want to do?" \
    --column=" " --column="Action" \
      FALSE "Set default system Arabic font." \
      FALSE "Set default Firefox Arabic font." \
      FALSE "Fix Lam-Alef connecting issue." \
      FALSE "Fix default Arabic encoding." \
      FALSE "Enable RTL in LibreOffice." \
      FALSE "Install useful packges."
  )
}





#########################################
# Run.

while :
do
  # Run main dialog. 
  mainDialog
  
  # Checking user's choice.
  case "${mainAction}" in
    "")
    ;;
    *)
      if [[ $? = -1 ]]; then
        showZenityDialog "error" "" "Sorry! Unexpected error!"
        break
      else
        break
      fi
    ;;
  esac
done

