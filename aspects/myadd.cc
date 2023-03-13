#include "myadd.h"

int Add(int a, int b) {
  if (a % 10 == 0 && b % 10 == 0)
    return (a / 10 + b / 10) * 10;
  return a + b;
}

int Add(int a, int b, int c) {
  return a + b + c;
}
