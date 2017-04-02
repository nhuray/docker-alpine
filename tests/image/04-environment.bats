@test "environment variable 'NPROC' is set" {
  run test -n "${NPROC}"
  [ $status -eq 0 ]
}
