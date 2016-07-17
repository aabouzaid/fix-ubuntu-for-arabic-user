# Fix Lam-Alef connecting issue by change input method.
fixLamAlefConnect () {
  runSudo im-config -n xim
  checkExitStatus
}
