libreofficeArabicSupport () {

  # This will enable RTL and Arabic for current user only.
  loUserConfFile="$HOME/.config/libreoffice/4/user/registrymodifications.xcu"

  # A file has xml vales to enable RTL in LibreOffice.
  loArabicConfFile="./files/libreoffice-arabic-config.conf"

  if $(grep -q "DefaultLocale_CTL" "${loUserConfFile}"); then
    showZenityDialog "info" "Nothing to do" "RTL is already enabled in LibreOffice!"

  else
    # Key value array is only available in Bash +4.0
    declare -A arabicLocaleArray
    
    # Arabic locale that support in LibreOffice.
    arabicLocaleArray+=(
      ["Arabic (Algeria)"]=ar-DZ
      ["Arabic (Bahrain)"]=ar-BH
      ["Arabic (Egypt)"]=ar-EG
      ["Arabic (Iraq)"]=ar-IR
      ["Arabic (Jordan)"]=ar-JO
      ["Arabic (Kuwait)"]=ar-KW
      ["Arabic (Lebanon)"]=ar-LB
      ["Arabic (Libya)"]=ar-LY
      ["Arabic (Morocco)"]=ar-MA
      ["Arabic (Oman)"]=ar-OM
      ["Arabic (Qatar)"]=ar-QA
      ["Arabic (Saudi Arabia)"]=ar-SA
      ["Arabic (Sudan)"]=ar-SD
      ["Arabic (Syria)"]=ar-SY
      ["Arabic (Tunisia)"]=ar-TN
      ["Arabic (United Arab Emirates)"]=ar-AE
      ["Arabic (Yemen)"]=ar-YE
    )
    
    # Ask user to select Arabic locale (locales used for date, time, and curacy in LibreOffice).
    arabicLocale=$(zenity --entry --title "Please select locale:" --entry-text "${!arabicLocaleArray[@]}")
  
    # Set selected Arabic locale by used and add it in a variable.
    loArabicConfig=$(sed "s/SELECTED_ARABICE_LOCALE/${arabicLocaleArray[${arabicLocale}]}/g" "${loArabicConfFile}")

    # Add Arabic settings that enables RTL into LibreOffice user config file.
    # Could be better but it needs to take care of characters that should be escaped.
    echo "${loArabicConfig}" | while read line; do
      sed -r -i "s#(</oor:items>)#${line}\n\1#g" "${loUserConfFile}" 
    done

  fi
}
