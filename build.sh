#!/bin/bash
set -eo pipefail

# Create build directory
mkdir -p build && cd build

# Configure
cmake -DENABLE_COVERAGE=ON \
      -DCMAKE_BUILD_TYPE=Debug \
      ..

# Build
cmake --build . --config Debug -- -j "$(nproc)"

# Test
echo -e "\e[93m-- Running tests\e[39m"
ctest -j "$(nproc)" --output-on-failure -VV

# Coverage
COV=$(cmake -LA -N . | grep ENABLE_COVERAGE:BOOL=ON)
if [[ -n "$COV" && -z ${TRAVIS} ]]; then # Does CMake's cache has ENABLE_COVERAGE:BOOL=ON?
    # Generate coverage report
    if command -v lcov >/dev/null 2>&1; then # Does lcov exist?
        printf '\n'
        echo -e "\e[93m-- Generating lcov info\e[39m"
        lcov --capture --directory . --output-file coverage.info
        echo -e "\e[93m-- Filtering out dependencies\e[39m"
        lcov --remove coverage.info '*conan/data/*' '/usr/*' --output-file coverage.info
        echo -e "\e[93m-- Generating HTML report\e[39m"
        genhtml coverage.info --output-directory coverage_report
        echo -e "\e[93m-- Generating done\e[39m"
    fi
fi

#--base-directory .
