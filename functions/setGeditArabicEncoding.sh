setGeditArabicEncoding () {
  # Get current list of encoding enabled in gedit.
  # Output example: ['UTF-8', 'ISO-8859-15', 'UTF-16']
  currentGeditEncoding=$(gsettings get org.gnome.gedit.preferences.encodings candidate-encodings)

  # If WINDOWS-1256 is not already enabled, then the script will add it to the list, and apply it.
  if [[ ! $(echo "${currentGeditEncoding}" | grep -qi 'WINDOWS-1256') ]]; then
     newGeditEncoding=$(echo "${currentGeditEncoding}" | sed "s/]/, 'WINDOWS-1256']/g")
     gsettings set org.gnome.gedit.preferences.encodings candidate-encodings "${newGeditEncoding}"
     checkExitStatus
  fi
 
}
