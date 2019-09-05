:: Generates a solution file for Visual Studio
:: SYNOPSIS:
::   .\gen_vs_sln.bat [VERSION]
:: OPTIONS:
::   2017    generates a VS 2017 solution file in .\vs2017
::   2019    generates a VS 2019 solution file in .\vs2019 (default)
@echo off

set ver=16
set year=2019

if [%1]==[] (
   goto :build
)
if [%1]==[2019] (
   goto :build
)
if [%1]==[2017] (
   set ver=15
   set year=2017
   goto :build
)

echo Invalid argument.
echo Use either 2017 or 2019 (default).
exit /b

:build
echo Generating solution file for Visual Studio %year%...
mkdir vs%year%
cd vs%year%
cmake -G "Visual Studio %ver% %year%" -A x64 ..
echo Done!
