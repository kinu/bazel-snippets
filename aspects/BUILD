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

cc_binary(
  name = "main",
  srcs = ["main.cc"],
  deps = [":myadd", ":mysub"],
  visibility = [
    "//:__subpackages__"
  ]
)
