setSystemArabicFont () {

  selectSystemArabicFont () {
    systemFontTitle=""
    systemFontMessage="Please select Arabic font for system."
    systemArabicFont=$(selectArabicFont "${systemFontTitle}" "${systemFontMessage}" "${recommendedArabicFont}")
  }

  copyArabicConfig () {
    xmlArabicFile="69-language-selector-ar.conf"
    xmlArabicPath="/etc/fonts/conf.avail/${xmlArabicFile}"

    copyConfigFile () {
      if [[ $(runSudo true; echo $?) -eq 0 ]]; then
        sed "s/SELECTED_ARABIC_FILE/${systemArabicFont}/g" "./files/${xmlArabicFile}" | runSudo tee ${xmlArabicPath} &&
        runSudo ln -sf "${xmlArabicPath}" "/etc/fonts/conf.d/${xmlArabicFile}"
        checkExitStatus
      else
        setSystemArabicFont
      fi
    }

    # If the file not exists, the script will copy it.
    if [[ ! -f "${xmlArabicPath}" ]]; then
      copyConfigFile

    # If the file exists, the script will ask the user to overwrite it or not.
    elif [[ -f "${xmlArabicPath}" ]]; then
      alreadyExitsts=$(showZenityDialog "question" "File already exists." "The file \"${xmlArabicFile}\" already exists, do you like to overwite it?"; echo $?)
      if [[ "${alreadyExitsts}" -eq 0 ]]; then
        copyConfigFile
      fi
    fi
  }
 
  # Ask user to select a font for system.
  selectSystemArabicFont

  # If user didn't select a font, it will ask user to select again or exit.
  if [[ -z "${systemArabicFont}" ]]; then
    showZenityDialog "question" "" "Please select <b>a font</b>!\t\nDo you want to retry?"
    if [[ $? -eq 0 ]]; then
      setSystemArabicFont
    else
      return
    fi

  else
    # If user selected a font, it will copy Arabic config file.
    copyArabicConfig

  fi
}
