# cpp_starter_project

[![Codacy Badge](https://api.codacy.com/project/badge/Grade/700a7eed3d8340acbbeb7a495c123a33)](https://app.codacy.com/app/hbatagelo/cpp_starter_project?utm_source=github.com&utm_medium=referral&utm_content=hbatagelo/cpp_starter_project&utm_campaign=Badge_Grade_Dashboard) [![Build Status](https://travis-ci.org/hbatagelo/cpp_starter_project.svg?branch=master)](https://travis-ci.org/hbatagelo/cpp_starter_project) [![Build status](https://ci.appveyor.com/api/projects/status/66fs8jswu3760qak?svg=true)](https://ci.appveyor.com/project/hbatagelo/cpp-starter-project) [![codecov](https://codecov.io/gh/hbatagelo/cpp_starter_project/branch/master/graph/badge.svg)](https://codecov.io/gh/hbatagelo/cpp_starter_project)

---------
A barebones C++ project using Conan for package management and CMake as build system, based on [Jason Turner's project](https://github.com/lefticus/cpp_starter_project). The example code for Google Test is based on the code from the talk "[Introduction to Google Mock](http://donsoft.io/gmock-presentation/)" by Donald Whyte.

## Build Requirements

*   [CMake](https://cmake.org/download) 3.10 or greater.
*   [Conan](https://conan.io/downloads.html).
*   A C++20-standard-compliant compiler.

## Installation

On Linux:

```sh
git clone https://github.com/hbatagelo/cpp_starter_project
cd cpp_starter_project
./build.sh
```

On Windows (MSVC 14.2*):

```bat
git clone https://github.com/hbatagelo/cpp_starter_project
cd cpp_starter_project
mkdir build
cd build
cmake -G "Visual Studio 16 2019" -DCMAKE_BUILD_TYPE=Release ..
cmake --build . --config "Release"
```

Use `gen_vs_ln.bat` to create a [Visual Studio](https://visualstudio.microsoft.com/vs/) solution file. By default, a VS 2019 solution file is generated (in `./vs16/`). Use `15` as argument for VS 2017. These solutions are targeted to x86-x64.
