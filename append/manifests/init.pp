
append_if_no_such_line { "foobar":
  file   => "/tmp/foobar.txt",
  line   => "some line of text",
  ensure => insync,
}
