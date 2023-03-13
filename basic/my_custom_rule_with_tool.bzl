# ほぼ my_custom_rule.bzl と同じ、ただし tool を使う
# 同じファイルにぜんぶ書いてももちろん ok

def _write_new_file_with_custom_tool_impl(ctx):
  outfile = ctx.actions.declare_file(ctx.attr.my_output_file)
  infile = ctx.file.my_input_file

  ctx.actions.run(
    outputs = [outfile],
    inputs = [infile],
    executable = ctx.executable.my_custom_build_tool,
    arguments = [infile.path, outfile.path],
  )

  # output を示す Provider を返す
  return DefaultInfo(
    files = depset([outfile])
  )

write_new_file_with_custom_tool = rule(
  implementation = _write_new_file_with_custom_tool_impl,
  attrs = {
    "my_input_file" : attr.label(allow_single_file = True),
    "my_output_file" : attr.string(),
    "my_custom_build_tool" : attr.label(executable = True, cfg = "exec"),
  }
)
