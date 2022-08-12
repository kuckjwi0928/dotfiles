function open-pr() {
  open $(git config --get remote.origin.url | sed -e "s/\.git//g")/pulls
}
