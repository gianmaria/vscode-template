@echo off

setlocal

:: edit this to change the name of the file to build
set file_to_build=main

set mode=%1
if "%mode%"=="" (
    set mode=release
)

if "%mode%"=="debug" (
    set optimization=/Od /Zi /MDd
    set macro=/D "_DEBUG"
) else if "%mode%"=="release" (
    set optimization=/O2 /Zi /MD
    set macro=/D "_NDEBUG"
) else (
    echo Invalid mode specified. Use "debug" or "release".
    exit /b 1
)

echo Building in %mode%
rem echo Options: %opt%
rem echo Macros: %macro%
rem exit /b 0

set base=%~dp0
@REM echo Base is: %base%

set build_dir=%base%\build\%mode%
if not exist %build_dir% mkdir %build_dir%
pushd %build_dir%

cl /nologo /FC /std:c++20 ^
/EHsc ^
%optimization% ^
/utf-8 /Zc:__cplusplus ^
%macro% ^
/D "_CONSOLE" /D "_UNICODE" /D "UNICODE" ^
/I%base% ^
%base%\%file_to_build%.cpp ^
/link /MACHINE:X64 /SUBSYSTEM:CONSOLE /DEBUG:full /OUT:%file_to_build%.exe

popd
endlocal
