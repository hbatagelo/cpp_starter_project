#include <cassert>

#include "coin-flipper.hpp"

CoinFlipper::CoinFlipper(Rng *rng) : d_rng(rng) { assert(d_rng); }

CoinFlipper::Result CoinFlipper::flipCoin() const {
  const double val = d_rng->generate(0.0, 1.0);
  assert(0.0 <= val && val <= 1.0);

  return (val < 0.5) ? HEADS : TAILS;
}