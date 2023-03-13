# bazel build :main --aspects myaspect.bzl%count_aspect

DepsCountInfo = provider(
  fields = {
    'count' : 'number of deps'
  }
)

def _count_aspect_impl(target, ctx):
  count = 1

  for dep in ctx.rule.attr.deps:
    count += dep[DepsCountInfo].count

  print("aspect", ctx.label, count)

  # Propagate the counter
  return [DepsCountInfo(count = count)]

count_aspect = aspect(
  implementation = _count_aspect_impl,

  # The list of rule attributes along which the aspect propagates
  # In this case, the aspect will propagate along the `deps` attribute
  # of the rules that it is applied to.
  # (['*'] is another attr_aspects that is often used)
  attr_aspects = ["deps"]
)

#------------------------------------------------
# Define a rule to use the aspect above
# (See BUILD file to see how it can be instantiated)
def _count_deps_impl(ctx):
  for target in ctx.attr.targets:
    print("rule", target.label, target[DepsCountInfo].count)
  return []

count_deps = rule(
  implementation = _count_deps_impl,
  attrs = {
    # Here we say that all the targets use the aspects
    # count_aspect
    "targets": attr.label_list(aspects = [count_aspect])
  }
)
