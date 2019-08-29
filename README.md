# cpp_starter_project

##[![Codacy Badge](https://api.codacy.com/project/badge/Grade/700a7eed3d8340acbbeb7a495c123a33)](https://app.codacy.com/app/hbatagelo/cpp_starter_project?utm_source=github.com&utm_medium=referral&utm_content=hbatagelo/cpp_starter_project&utm_campaign=Badge_Grade_Dashboard) [![Build Status](https://travis-ci.org/hbatagelo/cpp_starter_project.svg?branch=master)](https://travis-ci.org/hbatagelo/cpp_starter_project) [![Build status](https://ci.appveyor.com/api/projects/status/66fs8jswu3760qak?svg=true)](https://ci.appveyor.com/project/hbatagelo/cpp-starter-project) [![codecov](https://codecov.io/gh/hbatagelo/cpp_starter_project/branch/master/graph/badge.svg)](https://codecov.io/gh/hbatagelo/cpp_starter_project)

---------
A minimal cross-platform c++ project with continuous integration. Based on the [homonymous project](https://github.com/lefticus/cpp_starter_project) by Jason Turner.

## Dependencies

* CMake 3.10
* C++ 17 or higher

## Installation

On Linux:

```
git clone https://github.com/hbatagelo/cpp_starter_project
cd cpp_starter_project
bash build.sh
```

After building, you should be able to run it via `./build/intro`.

On Windows with MSVC:

```
git clone https://github.com/hbatagelo/cpp_starter_project
cd cpp_starter_project
mkdir build
cd build
cmake -G "Visual Studio 16" .. # Visual Studio 2019
cmake --build . --config "Release"
```

The solution file for Visual Studio 2019 can be generated with `gen_vs_ln.bat` and are output to `./vs2019/`. If you are a user of [Clang Power Tools](https://clangpowertools.com/download.html) and are receiving errors when running clang-format or clang-tidy, try opening the solution file generated with `gen_vs_ln.bat` instead of using the `Clone or check out code` or `Open a local folder` options from the startup dialog (tested with MSVC and clang-cl).

## License

Unlicense
