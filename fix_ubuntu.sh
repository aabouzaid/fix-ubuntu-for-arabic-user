#! /bin/bash

#########################################
# Vars

# Common variables.
source "./vars/commonVars.sh"


#########################################
# Functions.

# Common functions.
source "./functions/commonFunctions.sh"


#########################################
# Main.

# Convert the variable that has list of fixes to an array.
# This list imported from "Common variables" file.
IFS=$'\n'
fixesArray=( $(printf 'FALSE \n%s\n' ${fixesList}) )
unset IFS

# Main zenity dialog.
mainDialog () {
  mainAction=$(
  zenity --list --radiolist \
    --title="What do you want to do?" \
    --column=" " --column="Action" "${fixesArray[@]}"
  )
}


#########################################
# Fixes.

# Select an Arabic font.
source "./functions/selectArabicFont.sh"

# Set system default Arabic font.
source "./functions/setSystemArabicFont.sh"

# Enable RTL in LibreOffice and set Arabic locale.
source "./functions/libreofficeArabicSupport.sh"

# Fix Lam-Alef connecting issue.
source "./functions/fixLamAlefConnect.sh"


#########################################
# Run.

# Run sudo for first time.
if ! $(runSudo true); then
  showZenityDialog "error" "" "Sorry, this script needs sudo access!"
  exit 1
fi

# Loop over available options till the loop is borken.
# Exit status of cancel button in "zenity" is 1 which breaks while loop.
while :
do
  # Run main dialog. 
  mainDialog
  
  # Checking user's choice.
  case "${mainAction}" in
    "Set default system Arabic font.")
      setSystemArabicFont
    ;;
    "${libreofficeArabicSupport}")
      libreofficeArabicSupport
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
