# Select an Arabic from system.
selectArabicFont () {
  if [[ -x ${1} ]]; then
    defaultArabicFont="${1}"
  else
    defaultArabicFont="KacstOne"
  fi

  #
  fontsList=$(fc-list :lang=ar family | sort | awk '{printf("%s;", $0)}')
  IFS=';'; 
  read -ra fontsListArray <<< "${defaultArabicFont};${fontsList}";
  unset IFS

  #
  zenity --entry --title "Select Arabic font for system." --entry-text "${fontsListArray[@]}" --text "Please select Arabic font for ${action}"
}
