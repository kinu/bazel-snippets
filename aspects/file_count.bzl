# Slightly more advanced than counting deps

FileCountInfo = provider(
  fields = {
    'count' : 'number of files'
  }
)

def _file_count_aspect_impl(target, ctx):
  count = 0

  # Count the file counts of this node
  if hasattr(ctx.rule.attr, 'srcs'):
    for src in ctx.rule.attr.srcs:
      for f in src.files.to_list():
        if ctx.attr.extension == '*' or ctx.attr.extension == f.extension:
          count = count + 1
  if hasattr(ctx.rule.attr, 'hdrs'):
    for src in ctx.rule.attr.hdrs:
      for f in src.files.to_list():
        if ctx.attr.extension == '*' or ctx.attr.extension == f.extension:
          count = count + 1

  # Get the counts from our dependencies
  for dep in ctx.rule.attr.deps:
    count += dep[FileCountInfo].count

  print("aspect", ctx.label, count)

  # Propagate the counter
  return [FileCountInfo(count = count)]

file_count_aspect = aspect(
  implementation = _file_count_aspect_impl,
  attr_aspects = ["deps"],
  attrs = {
    # extension is a string attribute whose values could be either one of these
    'extension': attr.string(values = ['*', 'h', 'cc']),
  }
)

#------------------------------------------------
# Define a rule to use the aspect above
# (See BUILD file to see how it can be instantiated)
def _count_file_rule_impl(ctx):
  for dep in ctx.attr.deps:
    print("rule", dep.label, dep[FileCountInfo].count)
  return []

count_file_rule = rule(
  implementation = _count_file_rule_impl,
  attrs = {
    "deps": attr.label_list(aspects = [file_count_aspect]),
    "extension": attr.string(default = '*'),
  }
)
