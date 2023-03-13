#include <iostream>
#include <vector>

#include "mymath.h"

using namespace std;

int main() {
  int a, b;
  cout << "Enter two numbers" << endl;
  cin >> a >> b;
  cout << a << " + " << b << " = " << Add(a, b) << endl;
  cout << a << " - " << b << " = " << Sub(a, b) << endl;
}
