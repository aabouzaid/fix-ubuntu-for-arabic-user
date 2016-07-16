setSystemArabicFont () {
  systemFontMessage="Please select Arabic font for system."
  systemArabicFont=$(selectArabicFont "${systemFontMessage}" "${recommendedArabicFont}")
  if [[ -z ${systemArabicFont} ]]; then
    return
  else
    xmlArabicFile="69-language-selector-ar.conf"
    xmlArabicPath="/etc/fonts/conf.avail/${xmlArabicFile}"
    copyConfigFile () {
      runSudo sed "s/SELECTED_ARABIC_FILE/${systemArabicFont}/g" "./files/${xmlArabicFile}" > ${xmlArabicPath}
      runSudo ln -sf "${xmlArabicPath}" "/etc/fonts/conf.d/${xmlArabicFile}"
    }

    #
    if [[ ! -f "${xmlArabicPath}" ]]; then
      copyConfigFile
    elif [[ -f "${xmlArabicPath}" ]]; then
      showZenityDialog "question" "File already exists." "The file \"${xmlArabicFile}\" already exists, do you like to overwite it?"
      if [[ $? -eq 0 ]]; then
        copyConfigFile
        check_exit_status
      fi
    fi
  fi
}
