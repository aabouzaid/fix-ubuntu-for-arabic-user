#! /bin/bash

#########################################
# Vars

logsFile="./fix-ubuntu.log"
recommendedArabicFont="KacstOne"


#########################################
# Main funcutions.

# 
runSudo () {
  sudoExitStatus=$(sudo -v -n; echo $?)
  if [[ ${sudoExitStatus} -eq 0 ]]; then
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
  if [[ $? = 0 ]]; then
    showZenityDialog "info" "" "Done!"
  elif [[ $? = 1 ]]; then
    ${1}
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


# Select an Arabic font.
#=======================
selectArabicFont () {
  if [[ -x ${1} ]]; then
    defaultArabicFont="${1}"
  else
    defaultArabicFont="KacstOne"
  fi

  #
  fontsList=$(fc-list :lang=ar family | sort | awk '{printf("%s;", $0)}')

  #
  origIFS=${IFS}; IFS=';'; 
  read -ra fontsListArray <<< "${defaultArabicFont};${fontsList}";
  IFS="${origIFS}"

  #
  zenity --entry --title "Select Arabic font for system." --entry-text "${fontsListArray[@]}" --text "Please select Arabic font for ${action}"
}


# Set system default Arabic font.
#================================
source "./functions/setSystemArabicFont.sh"


#########################################
# Run.

# Run sudo for first time.
runSudo true

# 
while :
do
  # Run main dialog. 
  mainDialog
  
  # Checking user's choice.
  case "${mainAction}" in
    "Set default system Arabic font.")
      setSystemArabicFont
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

