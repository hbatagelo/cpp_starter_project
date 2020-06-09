#ifndef COIN_FLIPPER_HPP
#define COIN_FLIPPER_HPP

// See https://en.cppreference.com/w/cpp/language/rule_of_three
class Rng {
 public:
  Rng() = default;                       // Constructor
  Rng(const Rng &) = delete;             // Copy constructor
  Rng &operator=(const Rng &) = delete;  // Copy assignment
  Rng(Rng &&) = delete;                  // Move constructor
  Rng &operator=(Rng &&) = delete;       // Move assignment
  virtual ~Rng() = default;              // Destructor

  virtual double generate(double min, double max) = 0;
};

class CoinFlipper {
 private:
  Rng *d_rng;  // held, not owned

 public:
  enum class Result { Heads = 0, Tails = 1 };

  explicit CoinFlipper(Rng *rng);
  [[nodiscard]] CoinFlipper::Result flipCoin() const;
};

#endif
