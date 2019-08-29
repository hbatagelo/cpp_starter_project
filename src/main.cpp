#include <functional>
#include <iostream>

int main() {
  try {
    [out = std::ref(std::cout << "Hello ")]() { out.get() << "World\n"; }();
  } catch (...) {
  }
}
