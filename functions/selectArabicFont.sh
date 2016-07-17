# Select an Arabic from system.
selectArabicFont () {
  # Defaults.
  selectFontTitle="Select an Arabic font"
  selectFontMessage="Please a font from the list:"
  defaultArabicFont="KacstOne"

  # Use 1st parameter as a dialog title.
  if [[ -n ${1} ]]; then selectFontTitle="${1}"; fi

  # Use 2nd parameter as a dialog message.
  if [[ -n ${2} ]]; then selectFontMessage="${2}"; fi

  # Use 3rd parameter as a default font.
  if [[ -n ${3} ]]; then defaultArabicFont="${3}"; fi

  # Get list of Arabic fonts on the system.
  fontsList=$(fc-list :lang=ar family | sort | awk '{printf("%s;", $0)}')
  IFS=';'; 
  read -ra fontsListArray <<< "${defaultArabicFont};${fontsList}";
  unset IFS

  # Ask user to select one of Arabic fonts.
  zenity --entry --title "${selectFontTitle}" --entry-text "${fontsListArray[@]}" --text "${selectFontMessage}"
}
