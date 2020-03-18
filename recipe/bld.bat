setlocal EnableDelayedExpansion

:: Make a build folder and change to it
mkdir build
cd build

cmake -G "NMake Makefiles JOM" ^
    -DCMAKE_INSTALL_PREFIX:PATH="%LIBRARY_PREFIX%" ^
    -DCMAKE_PREFIX_PATH:PATH="%LIBRARY_PREFIX%" ^
    -DCMAKE_BUILD_TYPE:STRING=Release ^
    -DVERSION:STRING="%PKG_VERSION%" ^
    ..
if errorlevel 1 exit 1

:: build
cmake --build . --config Release -- -j%CPU_COUNT% %VERBOSE_CM%
if errorlevel 1 exit 1

:: install
cmake --build . --target install --config Release
if errorlevel 1 exit 1
