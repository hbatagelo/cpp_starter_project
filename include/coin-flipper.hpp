#ifndef COIN_FLIPPER_HPP
#define COIN_FLIPPER_HPP

// See https://en.cppreference.com/w/cpp/language/rule_of_three
class Rng {
public:
  Rng() = default;
  Rng(const Rng &) = default;            // Copy constructor
  Rng &operator=(const Rng &) = default; // Copy assignment
  Rng(Rng &&) = default;                 // Move constructor
  Rng &operator=(Rng &&) = default;      // Move assignment
  virtual ~Rng() = default;              // Destructor

  virtual double generate(double min, double max);
};

class CoinFlipper {
private:
  Rng *d_rng; // held, not owned

public:
  enum Result { HEADS = 0, TAILS = 1 };

  explicit CoinFlipper(Rng *rng);
  Result flipCoin() const;
};

#endif
