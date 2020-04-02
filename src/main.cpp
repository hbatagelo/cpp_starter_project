#include <iostream>
#include <memory>
#include <random>

#include <Eigen/Core>

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
  Eigen::MatrixXd m(2, 2);
  m(0, 0) = 3;
  m(1, 0) = 2.5;
  m(0, 1) = -1;
  m(1, 1) = m(1, 0) + m(0, 1);
  std::cout << m << std::endl;

  std::cout << "do stuff\n";

  const auto x = 4;
  std::cout << x << "\n";

  std::cout << independentMethod(x) << "\n";

  std::cout << Foo::bar(x) << "\n";

  // Rng baseGenerator = Rng();
  // std::cout << baseGenerator.generate(0.0, 1.0) << "\n";

  MyRng myGenerator;

  // Create a game
  const CoinFlipper game(&myGenerator);

  // Start playing
  const auto flip = game.flipCoin();

  const auto result = (flip == CoinFlipper::Result::Heads)
                          ? std::string("Heads")
                          : std::string("Tails");

  std::cout << "Result: " << result << "\n";
}
