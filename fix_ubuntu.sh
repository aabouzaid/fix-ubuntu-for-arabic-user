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

# Add WINDOWS-1256 to gedit encoding.
source "./functions/setGeditArabicEncoding.sh"

# Set Totem default encoding to WINDOWS-1256.
source "./functions/setTotemEncoding.sh"

# Some essential applications for every user.
source "./functions/installUsefulPackages.sh"


#---------------------------------------#
# Run.
#---------------------------------------#

# Loop over available options till the loop is borken.
# Exit status of cancel button in "zenity" is 1 which breaks while loop.
while :
do
  # Run main dialog. 
  mainDialog

  # Checking user's choice.
  case "${mainAction}" in
    "${setSystemArabicFont}")
      setSystemArabicFont
    ;;
    "${setFirefoxArabicFont}")
      setFirefoxArabicFont
    ;;
    "${libreofficeArabicSupport}")
      libreofficeArabicSupport
    ;;
    "${fixLamAlefConnect}")
      fixLamAlefConnect
    ;;
    "${setGeditArabicEncoding}")
      setGeditArabicEncoding
    ;;
    "${setTotemEncoding}")
      setTotemEncoding
    ;;
    "${installUsefulPackages}")
      installUsefulPackages
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
