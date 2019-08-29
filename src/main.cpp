#include <functional>
#include <iostream>

int main() {
  try {
    [out = std::ref(std::cout << "Hello ")]() { out.get() << "World 2\n"; }();
  } catch (...) {
  }
}
