#ifndef COIN_FLIPPER_HPP
#define COIN_FLIPPER_HPP

class Rng {
 public:
  Rng() = default;
  Rng(const Rng &) = delete;
  Rng &operator=(const Rng &) = delete;
  Rng(Rng &&) = delete;
  Rng &operator=(Rng &&) = delete;
  virtual ~Rng() = default;

  virtual double generate(double min, double max) = 0;
};

class CoinFlipper {
 private:
  Rng *d_rng;

 public:
  enum class Result { Heads = 0, Tails = 1 };

  explicit CoinFlipper(Rng *rng);
  [[nodiscard]] CoinFlipper::Result flipCoin() const;
};

#endif
