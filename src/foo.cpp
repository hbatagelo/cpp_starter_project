#include "foo.hpp"

int Foo::bar(const int &i) { return i + 1; }

int independentMethod([[maybe_unused]] const int &i) { return 0; }
