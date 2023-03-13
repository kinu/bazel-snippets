import sys

print("This is my build tool")

source = sys.argv[1]
target = sys.argv[2]

s = open(source, "r")
t = open(target, "w")
t.write(s.read().upper())

s.close()
t.close()
