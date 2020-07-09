#include <gtest/gtest.h>

#include <iostream>

#include "foo.hpp"

// IndependentMethod is a test case - here, we have 2 tests for this 1 test case
TEST(IndependentMethod, ResetsToZero) {
  auto i = 3;
  i = independentMethod(i);
  EXPECT_EQ(0, i);

  i = 12;
  i = independentMethod(i);
  EXPECT_EQ(0, i);
}

TEST(IndependentMethod, ResetsToZero2) {
  auto i = 0;
  i = independentMethod(i);
  EXPECT_EQ(0, i);
}

TEST(FooMethod, Increases1) {
  auto i = 0;
  i = Foo::bar(i);
  EXPECT_EQ(1, i);
}

// The fixture for testing class Foo. From google test primer.
class FooTest : public ::testing::Test {
 protected:
  FooTest() = default;
  void SetUp() override {}
  void TearDown() override {}

  // Objects declared here can be used by all tests in the test case for Foo.
  // Foo p;
};

// Test case must be called the class above
// Also note: use TEST_F instead of TEST to access the test fixture (from google
// test primer)
TEST_F(FooTest, MethodBarDoesAbc) {
  auto i = 0;
  i = Foo::bar(i);  // we have access to p, declared in the fixture
  EXPECT_EQ(1, i);
}

// }  // namespace - could surround FooTest in a namespace
