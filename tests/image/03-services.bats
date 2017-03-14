
# ------ DNSMasq ------

@test "service 'go-dnsmasq' should be installed" {
  run test -f /etc/services.d/go-dnsmasq/run
  [ $status -eq 0 ]
}

@test "service 'go-dnsmasq' is running" {
  status=$(ps -o pid,comm | grep go-dnsmasq 2>&1 >/dev/null;echo $?)
  [ $status -eq 0 ]
}


@test "service 'go-dnsmasq' is supervised" {
  service="go-dnsmasq"
  pid=$(ps -o pid,comm | grep "$service" | awk '{$1=$1};1' | cut -d' ' -f1)
  [ $pid -gt 0 ]

  kill -9 $pid && sleep 1

  new_pid=$(ps -o pid,comm | grep "$service" | awk '{$1=$1};1' | cut -d' ' -f1)
  [ $new_pid -gt 0 ]

  [ $pid != $new_pid ]
}

# ------ Consul Template ------

@test "service 'consul-template' should be installed" {
  run test -f /etc/services.d/consul-template/run
  [ $status -eq 0 ]
}
