#!/bin/bash
set -euo pipefail

# Create build directory
rm -rf build
mkdir -p build && cd build

# Configure
cmake -DCODE_COVERAGE=ON -DCMAKE_BUILD_TYPE=Debug -DCMAKE_EXPORT_COMPILE_COMMANDS=ON ..

# Build
cmake --build . --config Debug -- -j $(nproc)

# Test
ctest -j $(nproc) --output-on-failure

