setTotemEncoding () {

  # Get subtitle encoding in Totem. Output example: 'WINDOWS-1256'
  currentTotemEncoding=$(gsettings get org.gnome.totem subtitle-encoding)

  # Check if WINDOWS-1256 is enabled or not.
  if [[ $(echo "${currentTotemEncoding}" | grep -qi 'WINDOWS-1256') ]]; then
    showZenityDialog "warning" "" "Arabic encoding WINDOWS-1256 is already enabled!"
  else
     gsettings set org.gnome.totem subtitle-encoding 'WINDOWS-1256'
     checkExitStatus
  fi
}
