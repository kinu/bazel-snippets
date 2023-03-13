# 自分で作った rule から write_new_file を load
load("//:my_custom_rule.bzl", "write_new_file")
load("//:my_custom_rule_with_tool.bzl", "write_new_file_with_custom_tool")

# WORKSPACE の http_archive で取ってきた package rules_python から
# py_binary を load する
# 参照: https://github.com/bazelbuild/rules_python
load("@rules_python//python:defs.bzl", "py_binary")

write_new_file(
  name = "write_my_custom",
  my_input_file = ":my_input_file.txt",
  my_output_file = "my_awesome_output.txt",
)

# 参照: https://github.com/bazelbuild/rules_python
py_binary(
  name = "my_build_tool",
  srcs = ["my_build_tool.py"],
)

write_new_file_with_custom_tool(
  name = "write_my_custom_message_into_file",
  my_input_file = ":my_input_file.txt",
  my_output_file = "my_awesome_output_with_tool.txt",
  my_custom_build_tool = ":my_build_tool",
)

