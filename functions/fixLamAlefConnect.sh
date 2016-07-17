# Fix Lam-Alef connecting issue by change input method.
fixLamAlefConnect () {
  cmdOutput=$(runSudo im-config -n xim)
  checkExitStatus --variable "${cmdOutput}"
}
