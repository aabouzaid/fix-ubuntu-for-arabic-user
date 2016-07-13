#! /bin/bash

#########################################
# Vars

logsFile="./fix-ubuntu.log"
recommendedArabicFont="KacstOne"


#########################################
# Main funcutions.

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


#########################################
# Main dialog.

# Fixes list.
systemArabicFont="Set default system Arabic font."
firefoxArabicFont="Set default Firefox Arabic font."
lamAlefConnect="Fix Lam-Alef connecting issue."
geditArabicEncoding="Set gedit default Arabic encoding."
totemArabicEncoding="Set Totem default Arabic encoding."
libreofficeArabicSupport="Enable RTL in LibreOffice."
moreUsefulPackges="Install useful packges."


fixesList="${systemArabicFont}
${firefoxArabicFont}
${lamAlefConnect}
${geditArabicEncoding}
${totemArabicEncoding}
${libreofficeArabicSupport}
${moreUsefulPackges}"

# Convert variables list to an array.
IFS=$'\n'
fixesArray=( $(printf 'FALSE \n%s\n' ${fixesList}) )
unset IFS

# Main dialog.
#=========================
mainDialog () {
  mainAction=$(
  zenity --list --radiolist \
    --title="What do you want to do?" \
    --column=" " --column="Action" "${fixesArray[@]}"
  )
}


#########################################
# Fixes.


# Fix Lam-Alef connecting issue.
#===============================
fixLamAlefIssue () {
  runSudo im-config -n xim
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


# Enable RTL in LibreOffice and set Arabic locale.
#=================================================
source "./functions/libreofficeArabicSupport.sh"


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

