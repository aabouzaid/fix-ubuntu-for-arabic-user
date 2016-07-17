mainDialog () {
 
  # Set main dialog width based on max width of items in the fixes list.
  itemsMaxWidth=$(printf "%s\n" "${mainDialogList[@]}" | wc -L)
  mainDialogWidth=$(((${itemsMaxWidth} * 4) + 200))
  
  # Set main dialog height based on number of items in the fixes list.
  itemsCount=$((${#mainDialogList[@]} / 2))
  mainDialogHeight=$((${itemsCount} * 20 + 160))
  
  # Main zenity dialog.
  mainAction=$(
    zenity --list --radiolist \
      --width=${mainDialogWidth} \
      --height=${mainDialogHeight} \
      --title="${applicationTitle}" \
      --text="What do you want to do?" \
      --column=" # " --column="Action" "${mainDialogList[@]}"
  )
}
