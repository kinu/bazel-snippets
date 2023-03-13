def _write_new_file_impl(ctx):
  print("Hello", ctx.label.name)
  print("Input: ", ctx.attr.my_input_file)

  # 出力ファイルを宣言する
  outfile = ctx.actions.declare_file(ctx.attr.my_output_file)

  #infile = ctx.attr.my_input_file.files.to_list()[0]
  # 上のようにしなくても
  # これで Target のファイルが取れるみたい…なんか良くわからんが
  infile = ctx.file.my_input_file

  # 何回も書くことはできない
  # ctx.actions.write(outfile, "Hello world from string\n")

  # これで action が input, output とともに登録されて
  # input が更新されたらもう一回走らなきゃいけないことがわかる
  ctx.actions.run_shell(
    outputs = [outfile],
    inputs = [infile],
    command = "cat $1 > $2",
    arguments = [infile.path, outfile.path],
  )

  # これは動かない
  #ctx.actions.run(
  #  outputs = [outfile],
  #  inputs = [infile],
  #  executable = "cat",
  #  arguments = [infile.path, ">>", outfile.path],
  #)

  # output を示す Provider を返す
  return DefaultInfo(
    files = depset([outfile])
  )

write_new_file = rule(
  implementation = _write_new_file_impl,
  attrs = {
    "my_input_file" : attr.label(allow_single_file = True),
    "my_output_file" : attr.string(),
  }
)
