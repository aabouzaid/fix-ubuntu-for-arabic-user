#! /bin/bash

#########################################
# Vars

logsFile="./fix-ubuntu.log"
recommendedArabicFont="KacstOne"


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
  read -ra fontsListArray <<< "${defaultArabicFont};${fontsList}"
  IFS=${origIFS}

  #
  zenity --entry --title "Select Arabic font for system." --entry-text "${fontsListArray[@]}" --text "Please select Arabic font for ${action}"
}


# Set system default Arabic font.
#================================
setSystemArabicFont () {
  selectedArabicFont=$(selectArabicFont ${recommendedArabicFont})
  xmlArabicFile="69-language-selector-ar.conf"
  xmlArabicPath="/etc/fonts/conf.avail/${xmlArabicFile}"
  if [[ -f "${xmlArabicPath}" ]]; then
    showZenityDialog "question" "File already exists." "The file ${xmlArabicFile} already exists, do you like to overwite it?"
    if [[ $? -eq 0 ]]; then
      runSudo cp -a "./files/${xmlArabicFile}" /etc/fonts/conf.avail/
      runSudo ln -s "${xmlArabicPath}" "/etc/fonts/conf.d/${xmlArabicFile}"
      check_exit_status
    else
      mainDialog
    fi
  fi
}



#########################################
# Run.

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

