cc_library(
  name = "myadd",
  hdrs = ["myadd.h"],
  srcs = ["myadd.cc"],
)

cc_library(
  name = "mysub",
  hdrs = ["mysub.h"],
  srcs = ["mysub.cc"],
)

cc_library(
  name = "mymath",
  hdrs = ["mymath.h"],
  deps = [":myadd", ":mysub"],
)

cc_binary(
  name = "main",
  srcs = ["main.cc"],
  deps = [":mymath"],
  visibility = [
    "//:__subpackages__"
  ]
)

load("//:myaspect.bzl", "count_deps")
count_deps(
  name = "counter",
  targets = [ "//:main" ]
)

load("//:file_count.bzl", "count_file_rule")
count_file_rule(
  name = "count_headers",
  deps = [ "//:main" ],
  extension = 'h',
)

count_file_rule(
  name = "count_cc",
  deps = [ "//:main" ],
  extension = 'cc',
)
