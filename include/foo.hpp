#ifndef FOO_HPP
#define FOO_HPP

#include <iostream>

class Foo {
public:
  // why only detected if implemented here?
  // void foo(int &i) {
  // 	i = 1;
  // }
  int bar(const int &i);
};

int independentMethod(const int &i);

#endif // FOO_HPP
