#include <iostream>
#include <utility>

#include <gmock/gmock.h>
#include <gtest/gtest.h>

#include "coin-flipper.hpp"

// http://donsoft.io/gmock-presentation

using ::testing::DoubleEq;
using ::testing::Exactly;
using ::testing::Return;
using ::testing::Values;

class MockRng : public Rng {
public:
  MOCK_METHOD(double, generate, (double, double), (override));
};

TEST(CoinFlipper, ShouldReturnHeadsIfRandValueIsLessThanProbability) {
  // 1) Create mock objects (collaborators)
  MockRng rng;

  // 2) Specify your expectations of them
  EXPECT_CALL(rng, generate(DoubleEq(0.0), DoubleEq(1.0)))
      .Times(Exactly(1))
      .WillOnce(Return(0.25));

  // 3) Construct object(s) under test, passing mocks
  CoinFlipper coinFlipper(&rng);

  // 4) Run code under test
  CoinFlipper::Result result = coinFlipper.flipCoin();

  // 5) Check output (using Google Test or some other framework)
  EXPECT_EQ(CoinFlipper::Result::Heads, result);

  // testing::Mock::AllowLeak(&rng);

  // 6) Let gmock automatically check mock expectations were met at end of test
}

class CoinFlipperTestFixture
    : public ::testing::TestWithParam<std::pair<double, CoinFlipper::Result>> {
protected:
};

TEST_P(CoinFlipperTestFixture, CoinFlip) {
  const double randomVal = GetParam().first;
  const CoinFlipper::Result expectedResult = GetParam().second;

  MockRng rng;
  EXPECT_CALL(rng, generate(DoubleEq(0.0), DoubleEq(1.0)))
      .Times(Exactly(1))
      .WillOnce(Return(randomVal));

  CoinFlipper coinFlipper(&rng);
  CoinFlipper::Result result = coinFlipper.flipCoin();

  EXPECT_EQ(expectedResult, result);
}

INSTANTIATE_TEST_CASE_P(
    ValidRandomNumberGenerated, CoinFlipperTestFixture,
    Values(std::make_pair(0.0, CoinFlipper::Result::Heads),
           std::make_pair(0.25, CoinFlipper::Result::Heads),
           std::make_pair(0.49999, CoinFlipper::Result::Heads),
           std::make_pair(0.5, CoinFlipper::Result::Tails),
           std::make_pair(0.75, CoinFlipper::Result::Tails),
           std::make_pair(1.0, CoinFlipper::Result::Tails)));
