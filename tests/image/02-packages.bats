@test "package 'curl' should be present" {
  run which curl
  [ $status -eq 0 ]
}

@test "package 'wget' should be present" {
  run which wget
  [ $status -eq 0 ]
}

@test "package 'bash' should be present" {
  run which bash
  [ $status -eq 0 ]
}

@test "package 'tree' should be present" {
  run which tree
  [ $status -eq 0 ]
}

@test "package 'jq' should be present" {
  test $(bc <<< "$VERSION >= 3.5") -eq 0 && skip "Package not installed in this version"
  run which jq
  [ $status -eq 0 ]
}

@test "package 'dig' should be present" {
  test $(bc <<< "$VERSION >= 3.5") -eq 0 && skip "Package not installed in this version"
  run which dig
  [ $status -eq 0 ]
}

@test "package 'nslookup' should be present" {
  run which nslookup
  [ $status -eq 0 ]
}

@test "package 'telnet' should be present" {
  run which telnet
  [ $status -eq 0 ]
}