mainDialog () {

  # Convert list of fixes variable to an array.
  # This list imported from "commonVars.sh" file.
  IFS=$'\n'
  fixesArray=( $(printf '%s\n' ${fixesList}) )
  unset IFS
  
  # Set main dialog width based on max width of items in the fixes list.
  itemsMaxWidth=$(wc -L <<< "${fixesList}")
  mainDialogWidth=$(((${itemsMaxWidth} * 4) + 200))
  
  # Set main dialog height based on number of items in the fixes list.
  itemsCount=$(wc -l <<< "${fixesList}")
  mainDialogHeight=$((${itemsCount} * 20 + 160))
  
  # Main zenity dialog.
  mainAction=$(
    zenity --list --width=${mainDialogWidth} --height=${mainDialogHeight} \
      --title="Fix Ubuntu" \
      --text="What do you want to do?" \
      --column="Action" "${fixesArray[@]}"
  )
}
