# terraform

We're not using any kind of remote state so we just encrypt the statefile and
store it in the repo. You need to use the `terraform.bash` wrapper instead of
`terraform apply`. Any state surgery (import, move, remove, etc) should still
be done with `terraform` followed by an apply to be sure that the statefile
has been updated and then encrypted.
