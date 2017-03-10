@test "service 'consul-template' should be present" {
  run which consul-template
  [ $status -eq 0 ]
}

@test "service 'consul' should be present" {
  run which consul
  [ $status -eq 0 ]
}

@test "service 'go-dnsmasq' should be present" {
  run which go-dnsmasq
  [ $status -eq 0 ]
}
