#include "coin-flipper.hpp"

CoinFlipper::CoinFlipper(Rng *rng) : d_rng(rng) {}

CoinFlipper::Result CoinFlipper::flipCoin() const {
  const auto half = 0.5;
  const auto val = d_rng->generate(0.0, 1.0);
  return (val < half) ? Result::Heads : Result::Tails;
}
