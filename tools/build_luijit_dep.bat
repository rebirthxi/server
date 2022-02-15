REM WINDOWS ONLY SCRIPT!
REM For building our external dependency DLLs
REM To be run from /tools/ directory

git clone --branch v2.1 --depth 1 https://github.com/LuaJIT/LuaJIT.git

pushd LuaJIT\src

call "C:\Program Files\Microsoft Visual Studio\2022\Preview\VC\Auxiliary\Build\vcvarsall.bat" x86
call "msvcbuild.bat"

copy lua51.dll ..\..\..\ext\luajit32\bin\lua51.dll
copy lua51.lib ..\..\..\ext\luajit32\lib\lua51.lib
copy lua.h ..\..\..\ext\luajit32\include\lua.h
copy lua.hpp ..\..\..\ext\luajit32\include\lua.hpp
copy lauxlib.h ..\..\..\ext\luajit32\include\lauxlib.h
copy lualib.h ..\..\..\ext\luajit32\include\lualib.h
copy luajit.h ..\..\..\ext\luajit32\include\luajit.h

call "C:\Program Files\Microsoft Visual Studio\2022\Preview\VC\Auxiliary\Build\vcvarsall.bat" x64
call "msvcbuild.bat"

copy lua51.dll ..\..\..\ext\luajit64\bin\lua51.dll
copy lua51.lib ..\..\..\ext\luajit64\lib\lua51.lib
copy lua.h ..\..\..\ext\luajit64\include\lua.h
copy lua.hpp ..\..\..\ext\luajit64\include\lua.hpp
copy lauxlib.h ..\..\..\ext\luajit64\include\lauxlib.h
copy lualib.h ..\..\..\ext\luajit64\include\lualib.h
copy luajit.h ..\..\..\ext\luajit64\include\luajit.h

pushd
