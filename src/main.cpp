#include <iostream>

#include "foo.hpp"

int main() {
  std::cout << "do stuff" << std::endl;

  int x = 4;
  std::cout << x << std::endl;

  std::cout << independentMethod(x) << std::endl;

  Foo p;
  std::cout << p.bar(x) << std::endl;
}
