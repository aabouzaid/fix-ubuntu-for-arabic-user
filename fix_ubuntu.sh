#! /bin/bash

#---------------------------------------#
# Main.
#---------------------------------------#

# Common variables.
source "./vars/commonVars.sh"

# Common functions.
source "./functions/commonFunctions.sh"

# Main dialog.
source "./functions/mainDialog.sh"


#---------------------------------------#
# Fixes.
#---------------------------------------#

# Select an Arabic font.
source "./functions/selectArabicFont.sh"

# Set system default Arabic font.
source "./functions/setSystemArabicFont.sh"

# Set Firefox default Arabic font.
source "./functions/setFirefoxArabicFont.sh"

# Enable RTL in LibreOffice and set Arabic locale.
source "./functions/libreofficeArabicSupport.sh"

# Fix Lam-Alef connecting issue.
source "./functions/fixLamAlefConnect.sh"


#---------------------------------------#
# Run.
#---------------------------------------#

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
    "${setFirefoxArabicFont}")
      setFirefoxArabicFont
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
