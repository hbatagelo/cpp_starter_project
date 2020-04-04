:: Generates a solution file for Visual Studio
:: USAGE:
::   .\gen_vs_sln.bat [VERSION]
:: VERSION:
::   15    generates a v15 solution file in .\vs15
::   16    generates a v16 solution file in .\vs16 (default)
@echo off

set ver=16

if [%1]==[] (
   goto :build
)
if [%1]==[16] (
   goto :build
)
if [%1]==[15] (
   set ver=15
   goto :build
)

echo Invalid argument.
echo Use either 15 or 16 (default).
exit /b

:build
echo Generating solution file for Visual Studio version %ver%...
mkdir vs%ver%
cd vs%ver%
cmake -G "Visual Studio %ver%" -A x64 -DCMAKE_BUILD_TYPE=Release ..
echo Done!
