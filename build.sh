#!/bin/bash
set -euo pipefail

# Create build directory
mkdir -p build && cd build

# Configure
cmake -DCODE_COVERAGE=ON -DCMAKE_BUILD_TYPE=Debug -DCMAKE_EXPORT_COMPILE_COMMANDS=ON ..

# Build
cmake --build . --config Debug -- -j $(nproc)

# Test
echo -e "\e[93m-- Running tests\e[39m"
ctest -j $(nproc) --output-on-failure

# Coverage
COV=$(cmake -LA -N . | grep CODE_COVERAGE:BOOL=ON) 
if [ ! -z "$COV" ]; then # Does CMake's cache has CODE_COVERAGE:BOOL=ON?
    # Generate coverage report
    if command -v lcov >/dev/null 2>&1; then # Does lcov exist?
        printf '\n'
        echo -e "\e[93m-- Generating lcov info\e[39m"
        lcov --capture --base-directory . --directory . --output-file coverage_unfiltered.info
        echo -e "\e[93m-- Filtering out dependencies\e[39m"
        lcov --remove coverage_unfiltered.info $PWD'/gtest/*' '/usr/*' --output-file coverage.info
        echo -e "\e[93m-- Generating HTML report\e[39m"
        genhtml coverage.info --output-directory coverage_report
        echo -e "\e[93m-- Generating done\e[39m"
    fi
fi
