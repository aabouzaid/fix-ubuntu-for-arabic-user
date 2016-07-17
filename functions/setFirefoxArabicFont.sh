setFirefoxArabicFont () {

  # Check if Firefox is opened, because Firefox overwrites settings file when it exits.
  if [[ $(pgrep -c -u $(id -u) "firefox") -gt 0 ]]; then
    showZenityDialog "warning" "" "<b>Firefox</b> is opened! Please close it first to perform this task!"
    return
  fi

  selectFirefoxArabicFont () {
    # Select Sans Serif.
    firefoxSerifTitle="Select Firefox Arabic font"
    firefoxSerifMessage="Please select a font for (Serif).\t\t\nNote: If you don't know, just use first one.\t"
    firefoxSerifFont=$(selectArabicFont "${firefoxSerifTitle}" "${firefoxSerifMessage}" "${recommendedArabicFont}")
  
    # Select Sans.
    firefoxSansTitle="Select Firefox Arabic font"
    firefoxSansMessage="Please select a font for (Sans).\t\t\nNote: If you don't know, just use first one.\t"
    firefoxSansfFont=$(selectArabicFont "${firefoxSansTitle}" "${firefoxSansMessage}" "${recommendedArabicFont}")
  }

  editFirefoxConf () {
    #
    IFS=$'\n'
    firefoxArabicConfig=(
      user_pref\(\"font.language.group\",\"ar\"\)\;
      user_pref\(\"font.name.serif.ar\",\"${firefoxSerifFont}\"\)\;
      user_pref\(\"font.name.sans-serif.ar\",\"${firefoxSansfFont}\"\)\;
    )
    unset IFS
  
    # Function to update Firefox user preferences.
    updateFirefoxConf () {
      ffUserProfile="${1}"
  
      # Firefox user preferences file.
      firefoxUserPrefsFile="$HOME/.mozilla/firefox/${ffUserProfile}/prefs.js"
  
      for configItem in ${firefoxArabicConfig[@]}; do
        # Extract the value of Firefox config by regex.
        configName=$(grep -o -P "(?<=user_pref\(\")[\w.-]+" <<< "${configItem}")
  
        # If config value is already there, then it will not add it again.
        if ! $(grep -q "${configItem}" "${firefoxUserPrefsFile}"); then
          echo "${configItem}" >> "${firefoxUserPrefsFile}"
          checkExitStatus --errors-only
        fi
      done
    }
  
    # Create an array with Firefox profiles.
    # By default it's one, by maybe there is more (to check them manually run "firefox -P").
    ffProfilesFile="$HOME/.mozilla/firefox/profiles.ini"
   
    ffProfilesList=$(grep -o -P "(?<=(Name|Path)=).+"  "${ffProfilesFile}" |  awk '{if (NR%2) profile_name=$0; getline; printf "%s (%s);", profile_name, $0}')
  
    IFS=';'
    ffProfilesArray=( ${ffProfilesList} )
    unset IFS
  
    # IF there is more than Firefox profile, it will ask user to select one to apply this fix. 
    if [[ ${#ffProfilesArray[@]} -gt 1 ]]; then
      selectProfileMessage="There are more then Firefox profile! Please select one."
      selectedFirefoxProfile=$(zenity --list --title="Select Firefox profile" --column="Action" "${ffProfilesArray[@]}")
      if [[ $(isEmpty "${selectedFirefoxProfile}") == "NotEmpty" ]]; then
        profileDirectory=$(echo "${selectedFirefoxProfile}" | sed -r 's/.+\((.+)\)/\1/g')
        updateFirefoxConf "${profileDirectory}"
        checkExitStatus
      fi	
    else
      profileDirectory=$(echo "${#ffProfilesArray[0]}" | sed -r 's/.+\((.+)\)/\1/g')
      updateFirefoxConf "${profileDirectory}"
      checkExitStatus
    fi
  }

  # Ask user to select a font for Firefox.
  selectFirefoxArabicFont

  # If user didn't select both Serif and Sans font, it will ask user to select again or exit.
  if [[ -z "${firefoxSerifFont}" || -z "${firefoxSansfFont}" ]]; then
    showZenityDialog "question" "" "Please select <b>2 fonts</b>!\t\nDo you want to retry?"
    if [[ $? -eq 0 ]]; then
      setFirefoxArabicFont
    else
      return
    fi

  else
    # If user selected both Serif and Sans font, it will start to edit Firefox settings.
    editFirefoxConf

  fi
}
