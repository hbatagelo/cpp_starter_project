# cpp_starter_project

[![Codacy Badge](https://api.codacy.com/project/badge/Grade/700a7eed3d8340acbbeb7a495c123a33)](https://app.codacy.com/app/hbatagelo/cpp_starter_project?utm_source=github.com&utm_medium=referral&utm_content=hbatagelo/cpp_starter_project&utm_campaign=Badge_Grade_Dashboard) [![Build Status](https://travis-ci.org/hbatagelo/cpp_starter_project.svg?branch=master)](https://travis-ci.org/hbatagelo/cpp_starter_project) [![Build status](https://ci.appveyor.com/api/projects/status/66fs8jswu3760qak?svg=true)](https://ci.appveyor.com/project/hbatagelo/cpp-starter-project) [![codecov](https://codecov.io/gh/hbatagelo/cpp_starter_project/branch/master/graph/badge.svg)](https://codecov.io/gh/hbatagelo/cpp_starter_project)

---------
A minimal cross-platform C++ project with continuous integration. Based on the [homonymous project](https://github.com/lefticus/cpp_starter_project) by Jason Turner.

## Build Requirements

*   [CMake](https://cmake.org)
*   C++17-standard-compliant compiler

## Installation

On Linux:

```sh
git clone https://github.com/hbatagelo/cpp_starter_project
cd cpp_starter_project
./build.sh
```

After building, run it with:

```sh
cd build
./intro
```

On Windows (MSVC 14.2*):

```bat
git clone https://github.com/hbatagelo/cpp_starter_project
cd cpp_starter_project
mkdir build
cd build
cmake -G "Visual Studio 16" ..
cmake --build . --config "Release"
```

Run `gen_vs_ln.bat` to generate a [Visual Studio](https://visualstudio.microsoft.com/vs/) 2019 solution file targeted to x64 platform. The output is written to `./vs2019/`.

If you use [Clang Power Tools](https://clangpowertools.com/download.html) in VS 2019, you may experience crashes when running clang-format or clang-tidy after opening the project directly from CMakeLists.txt via the `Clone or check out code` or `Open a local folder` options in the startup dialog (tested with MSVC and clang-cl). These crashes can be prevented by using the generated solution file. Once the solution is open, you can switch the view to the folder view.

## License

Unlicense
