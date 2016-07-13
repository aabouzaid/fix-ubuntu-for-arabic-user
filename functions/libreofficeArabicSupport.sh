libreofficeArabicSupport () {

  # This will enable RTL and Arabic for current user only.
  libreofficeConfig="~/.config/libreoffice/4/user/registrymodifications.xcu"

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
  
  selectedLocale=$(zenity --entry --title "Please select locale:" --entry-text "${!arabicLocaleArray[@]}")
}
