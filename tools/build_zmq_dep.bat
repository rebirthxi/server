REM WINDOWS ONLY SCRIPT!
REM For building our external dependency DLLs
REM To be run from /tools/ directory
REM Change TYPE between Debug/Release, if you like

git clone --branch v4.3.4 --depth 1 https://github.com/zeromq/libzmq.git

mkdir libzmq\build32
mkdir libzmq\build64

cmake -A Win32 -S libzmq -B "libzmq\build32" -DBUILD_TESTS=NO -DZMQ_BUILD_TESTS=NO -DENABLE_CURVE=NO -DWITH_TLS=NO
cmake -S libzmq -B "libzmq\build64" -DBUILD_TESTS=NO -DZMQ_BUILD_TESTS=NO -DENABLE_CURVE=NO -DWITH_TLS=NO

cmake --build libzmq\build32 --config Release
cmake --build libzmq\build64 --config Release
cmake --build libzmq\build32 --config Debug
cmake --build libzmq\build64 --config Debug

copy libzmq\build32\bin\Release\libzmq-v143-mt-4_3_4.dll ..\ext\zmq32\bin\libzmq-v143-mt-gd-4_3_4.dll
copy libzmq\build32\bin\Debug\libzmq-v143-mt-gd-4_3_4.dll ..\ext\zmq32\bin\libzmq-v143-mt-4_3_4.dll
copy libzmq\build32\lib\Release\libzmq-v143-mt-4_3_4.lib ..\ext\zmq32\lib\libzmq-v143-mt-gd-4_3_4.lib
copy libzmq\build32\lib\Debug\libzmq-v143-mt-gd-4_3_4.lib ..\ext\zmq32\lib\libzmq-v143-mt-4_3_4.lib
copy libzmq\include\zmq.h ..\ext\zmq32\include\zmq.h
copy libzmq\include\zmq_utils.h ..\ext\zmq32\include\zmq_utils.h

copy libzmq\build64\bin\Release\libzmq-v143-mt-4_3_4.dll ..\ext\zmq64\bin\libzmq-v143-mt-4_3_4.dll
copy libzmq\build64\bin\Debug\libzmq-v143-mt-gd-4_3_4.dll ..\ext\zmq64\bin\libzmq-v143-mt-gd-4_3_4.dll
copy libzmq\build64\lib\Release\libzmq-v143-mt-4_3_4.lib ..\ext\zmq64\lib\libzmq-v143-mt-4_3_4.lib
copy libzmq\build64\lib\Debug\libzmq-v143-mt-gd-4_3_4.lib ..\ext\zmq64\lib\libzmq-v143-mt-gd-4_3_4.lib
copy libzmq\include\zmq.h ..\ext\zmq64\include\zmq.h
copy libzmq\include\zmq_utils.h ..\ext\zmq64\include\zmq_utils.h
