# Fix Lam-Alef connecting issue by change input method.
fixLamAlefIssue () {
  runSudo im-config -n xim
  checkExitStatus
}
