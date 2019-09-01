#include <iostream>

#include "gtest/gtest.h"

#include "foo.hpp"

// IndependentMethod is a test case - here, we have 2 tests for this 1 test case
TEST(IndependentMethod, ResetsToZero) {
  int i = 3;
  i = independentMethod(i);
  EXPECT_EQ(0, i);

  i = 12;
  i = independentMethod(i);
  EXPECT_EQ(0, i);
}

TEST(IndependentMethod, ResetsToZero2) {
  int i = 0;
  i = independentMethod(i);
  EXPECT_EQ(0, i);
}

TEST(FooMethod, Increases1) {
  int i = 0;
  Foo p;
  i = p.bar(i);
  EXPECT_EQ(1, i);
}

// The fixture for testing class Foo. From google test primer.
class FooTest : public ::testing::Test {
protected:
  FooTest() = default;
  virtual ~FooTest() = default;
  virtual void SetUp() {}
  virtual void TearDown() {}

  // Objects declared here can be used by all tests in the test case for Foo.
  Foo p;
};

// Test case must be called the class above
// Also note: use TEST_F instead of TEST to access the test fixture (from google
// test primer)
TEST_F(FooTest, MethodBarDoesAbc) {
  int i = 0;
  i = p.bar(i); // we have access to p, declared in the fixture
  EXPECT_EQ(1, i);
}

// }  // namespace - could surround FooTest in a namespace
