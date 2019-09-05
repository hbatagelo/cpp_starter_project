#include <iostream>
#include <memory>
#include <random>

#include "coin-flipper.hpp"
#include "foo.hpp"

class MyRng : public Rng {
public:
  MyRng() : rng(std::make_unique<std::mt19937>(dev())) {}

  double generate(double min, double max) override {
    std::uniform_real_distribution<> rdist(min, max);
    return rdist(*rng);
  }

private:
  std::random_device dev;
  std::unique_ptr<std::mt19937> rng;
};

int main() {
  std::cout << "do stuff" << std::endl;

  int x = 4;
  std::cout << x << std::endl;

  std::cout << independentMethod(x) << std::endl;

  Foo p;
  std::cout << p.bar(x) << std::endl;

  MyRng generator;

  // Create a game
  CoinFlipper game(&generator);

  // Start playing
  CoinFlipper::Result flip = game.flipCoin();

  std::cout << "Result: " << flip << std::endl;
}
