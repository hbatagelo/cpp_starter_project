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

If you use [Clang Power Tools](https://clangpowertools.com/download.html) in VS 2019, you may experience crashes when running clang-format or clang-tidy after opening the project via the `Clone or check out code` or `Open a local folder` options in VS with CMake tools for Windows (tested with MSVC and clang-cl). These crashes can be prevented by opening the solution file instead. Once the solution is open, you can switch to the folder view.

### Clang-tidy

I have been passing the following extra arguments (`--extra-arg`) to the compiler when using clang-tidy:

```sh
-Weverything
-Wno-c++11-compat
-Wno-c++98-compat
-Wno-c++98-compat-pedantic
-Wno-c++17-extensions
-I./include
```

`-I./include` adds the local header files outside `src` to the include search path. If not done, clang-tidy may complain about missing headers in VS Code.

## License

Unlicense
