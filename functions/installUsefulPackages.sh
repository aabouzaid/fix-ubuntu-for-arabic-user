installUsefulPackages () {

  # List of recommended apps.
  IFS=$'\n'
  packagesList=(
    TRUE ubuntu-restricted-addons 'Restricted addons packages for Ubuntu.'
    TRUE ubuntu-restricted-extras 'Extras media codecs and fonts for Ubuntu.'
    TRUE openjdk-8-jre            'OpenJDK Java runtime.'
    TRUE vlc                      'Best media player ever!'
    TRUE gimp                     'Create images and edit photographs.'
    TRUE inkscape                 'Create and edit SVG images.'
    TRUE chromium-browser         'Web browser, open-source version of Chrome.'
  )
  unset IFS

  # Set main dialog width based on max width of itmes in the fixes list.
  itemsMaxWidth=$(wc -L <<< "${packagesList[@]}")
  dialogWidth=$(((${itemsMaxWidth} * 1) + 220))

  # Set main dialog height based on number of itmes in the fixes list.
  itemsCount=$(wc -l <<< "${packagesList[@]}")
  dialogHeight=$((${itemsCount} * 120 + 160))


  # Ask user to select which app should be installed.
  selectedPackages=$(
    zenity --list --width=${dialogWidth} --height=${dialogHeight} \
           --separator=' ' --checklist --title='Install useful applications' \
           --column=" # " --column="Package"  --column="Description" "${packagesList[@]}"
  )

  if [[ -z "${selectedPackages}" ]]; then
    return
  fi

  # Install selected apps.
  runSudo apt-get update
  runSudo apt-get install -y ${selectedPackages}
  checkExitStatus
}
