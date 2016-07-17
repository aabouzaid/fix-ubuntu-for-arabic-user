# General.
appTitle="Fix Ubuntu"
logsFile="./fix-ubuntu.log"
recommendedArabicFont="KacstOne"

# Fixes list.
setSystemArabicFont="Set default system Arabic font."
setFirefoxArabicFont="Set default Firefox Arabic font."
fixLamAlefConnect="Fix Lam-Alef connecting issue."
setGeditArabicEncoding="Set gedit default Arabic encoding."
setTotemEncoding="Set Totem default encoding."
libreofficeArabicSupport="Enable RTL in LibreOffice."
installUsefulPackages="Install useful packges."

# List with all fixes that will be used in main dialog.
IFS=$'\n'
mainDialogList=(
  FALSE "${setSystemArabicFont}"
  FALSE "${setFirefoxArabicFont}"
  FALSE "${fixLamAlefConnect}"
  FALSE "${setGeditArabicEncoding}"
  FALSE "${setTotemEncoding}"
  FALSE "${libreofficeArabicSupport}"
  FALSE "${installUsefulPackages}"
)
unset IFS
