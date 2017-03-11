@test "service 'consul-template' should be present" {
  run which consul-template
  [ $status -eq 0 ]
}

@test "service 'consul' should be present" {
  test $(bc <<< "$VERSION >= 3.5") -eq 0 && skip "Service
   not installed in this version"
  run which consul
  [ $status -eq 0 ]
}

@test "service 'go-dnsmasq' should be present" {
  run which go-dnsmasq
  [ $status -eq 0 ]
}
