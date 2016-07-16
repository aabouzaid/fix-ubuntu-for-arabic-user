# Select an Arabic from system.
selectArabicFont () {

  # Use 1st parameter as a dialog message.
  if [[ -x ${1} ]]; then
    selectFontMessage="${1}"
  else
    selectFontMessage="Please select an Arabic font."
  fi

  # Use 2nd parameter as a default font.
  if [[ -x ${2} ]]; then
    defaultArabicFont="${2}"
  else
    defaultArabicFont="KacstOne"
  fi

  # Get list of Arabic fonts on the system.
  fontsList=$(fc-list :lang=ar family | sort | awk '{printf("%s;", $0)}')
  IFS=';'; 
  read -ra fontsListArray <<< "${defaultArabicFont};${fontsList}";
  unset IFS

  # Ask user to select one of Arabic fonts.
  zenity --entry --title "" --entry-text "${fontsListArray[@]}" --text "${selectFontMessage}"
}
