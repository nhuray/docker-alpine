# #!/usr/bin/env bats
#
load helpers
#
# # @test "service 'consul-template' is supervised" {
# #   service="consul-template"
# #   pid=$(ps -o pid,comm | grep "$service" | awk '{$1=$1};1' | cut -d' ' -f1)
# #   [ $pid -gt 0 ]
# #
# #   kill -9 $pid && sleep 1
# #
# #   new_pid=$(ps -o pid,comm | grep "$service" | awk '{$1=$1};1' | cut -d' ' -f1)
# #   [ $new_pid -gt 0 ]
# #
# #   [ $pid != $new_pid ]
# # }
#


@test "templates using 'range services' function are well rendered" {
  # Declare the service
  service=test-api
  address="$(dig +short consul)"
  port="8500"

  # Register service (actually we just use the consul service and register with the name and tags we want)
  run register_service $service api
  [ "$status" -eq 0 ]

  # Call consul template to generate the configuration
  status=$(consul-template -consul consul:8500 -config /etc/consul-template/conf -once;echo $?)
  [ "$status" -eq 0 ]

  # Check the expected configuration has been generated by consul-template
  status=$(test -f /tests/consul-template/tests.conf;echo $?)
  [ "$status" -eq 0 ]

  # Check we can find the address and port we registered
  status=$(grep "service $service: $address:$port" /tests/consul-template/tests.conf  2>&1 > /dev/null;echo $?)
  [ "$status" -eq 0 ]
}

@test "templates using 'key_or_default' function  are well rendered" {
  # Declare the service
  key="tests/key_or_default"
  value="tests/key_or_default/value"

  # Register a key
  run register_key $key $value
  [ "$status" -eq 0 ]

  # Call consul template to generate the configuration
  status=$(consul-template -consul consul:8500 -config /etc/consul-template/conf -once;echo $?)
  [ "$status" -eq 0 ]

  # Check the expected configuration has been generated by consul-template
  status=$(test -f /tests/consul-template/tests.conf;echo $?)
  [ "$status" -eq 0 ]

  # Check we can find the address and port we registered
  status=$(grep "key_or_default: $value" /tests/consul-template/tests.conf  2>&1 > /dev/null;echo $?)
  [ "$status" -eq 0 ]
}