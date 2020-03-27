#include "coin-flipper.hpp"
#include <chrono>
#include <iostream>
#include <random>

double Rng::generate(double min, double max) {
  auto seed = std::chrono::system_clock::now().time_since_epoch().count();
  std::default_random_engine generator(static_cast<unsigned>(seed));
  std::uniform_real_distribution<> rdist(min, max);
  return rdist(generator);
}

CoinFlipper::CoinFlipper(Rng *rng) : d_rng(rng) {}

CoinFlipper::Result CoinFlipper::flipCoin() const {
  const auto half = 0.5;
  const auto val = d_rng->generate(0.0, 1.0);
  return (val < half) ? Result::Heads : Result::Tails;
}
