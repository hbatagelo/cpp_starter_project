#ifndef FOO_HPP
#define FOO_HPP

#include <iostream>

class Foo {
public:
  virtual ~Foo() = default;
  int bar(const int &i);
};

int independentMethod(const int &i);

#endif // FOO_HPP
