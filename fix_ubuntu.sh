#! /bin/bash

#########################################
# Vars

logsFile="./fix-ubuntu.log"
recommendedArabicFont="KacstOne"


#########################################
# Main funcutions.

# 
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
  if [[ $? = 0 ]]; then
    showZenityDialog "info" "" "Done!"
  elif [[ $? = 1 ]]; then
    ${1}
  else
    echo $(printf '=%.0s' {1..50}) >> ${logsFile}
    showZenityDialog "error" "" "Sorry! Unexpected error! Please check logs: ${logsFile}"
  fi
}



# Fixes list.
#=========================
system_arabic_font="Set default system Arabic font."
firefox_arabic_font="Set default Firefox Arabic font."
lam_alef_connect="Fix Lam-Alef connecting issue."
gedit_arabic_encoding="Set gedit default Arabic encoding."
totem_arabic_encoding="Set Totem default Arabic encoding."
lireboffice_rtl_support="Enable RTL in LibreOffice."
more_useful_packges="Install useful packges."

# Main dialog.
#=========================
mainDialog () {
  mainAction=$(
  zenity --list --radiolist \
    --title="What do you want to do?" \
    --column=" " --column="Action" \
      FALSE "${system_arabic_font}" \
      FALSE "${firefox_arabic_font}" \
      FALSE "${lam_alef_connect}" \
      FALSE "${gedit_arabic_encoding}" \
      FALSE "${totem_arabic_encoding}" \
      FALSE "${lireboffice_rtl_support}" \
      FALSE "${more_useful_packges}"
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
if ! $(runSudo true); then
  showZenityDialog "error" "" "Sorry, this script needs sudo access!"
  exit 1
fi

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

