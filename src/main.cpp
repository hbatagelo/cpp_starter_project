#include <iostream>
#include <memory>
#include <random>

#include "coin-flipper.hpp"
#include "foo.hpp"

class MyRng final : public Rng {
public:
  MyRng() : rng(std::make_unique<std::mt19937>(dev())) {}

  double generate(double min, double max) override;

private:
  std::random_device dev;
  std::unique_ptr<std::mt19937> rng;
};

double MyRng::generate(const double min, const double max) {
  std::uniform_real_distribution<> rdist(min, max);
  return rdist(*rng);
}

int main() {
  std::cout << "do stuff" << std::endl;

  const auto x = 4;
  std::cout << x << std::endl;

  std::cout << independentMethod(x) << std::endl;

  std::cout << Foo::bar(x) << std::endl;

  MyRng generator;

  // Create a game
  const CoinFlipper game(&generator);

  // Start playing
  const auto flip = game.flipCoin();

  const std::string result =
      flip == CoinFlipper::Result::Heads ? "Heads" : "Tails";

  std::cout << "Result: " << result << std::endl;
}
