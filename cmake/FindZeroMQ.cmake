# Try to find ZeroMQ
# ZeroMQ_FOUND - System has ZeroMQ
# ZeroMQ_LIBRARY - The libraries needed to use ZeroMQ
# ZeroMQ_INCLUDE_DIR - The ZeroMQ include directories

if(CMAKE_SIZEOF_VOID_P EQUAL 8)
    set(ZMQ_PARTIAL_PATH "zmq64")
else()
    set(ZMQ_PARTIAL_PATH "zmq32")
endif()

# Copy DLL
if (WIN32)
    add_custom_target(copy_zmq_dll ALL
                COMMENT "Copying ZMQ dll to project root")
    add_custom_command(TARGET copy_zmq_dll PRE_BUILD
                COMMAND ${CMAKE_COMMAND} -E copy_if_different
                    ${PROJECT_SOURCE_DIR}/ext/${ZMQ_PARTIAL_PATH}/bin/libzmq-v143-mt-4_3_4.dll
                    ${CMAKE_SOURCE_DIR}
                COMMAND ${CMAKE_COMMAND} -E copy_if_different
                    ${PROJECT_SOURCE_DIR}/ext/${ZMQ_PARTIAL_PATH}/bin/libzmq-v143-mt-gd-4_3_4.dll
                    ${CMAKE_SOURCE_DIR})
endif()

find_library(ZeroMQ_LIBRARY 
    NAMES 
        "zmq${lib_debug}" "zmq${lib_debug}_64" "libzmq${lib_debug}" "libzmq${lib_debug}_64" "libzmq-v143-mt-4_3_4"
    PATHS
        ${PROJECT_SOURCE_DIR}/ext/${ZMQ_PARTIAL_PATH}/lib/
        /usr/
        /usr/bin/
        /usr/include/
        /usr/lib/
        /usr/local/
        /usr/local/bin/
        /opt/)

find_path(ZeroMQ_INCLUDE_DIR 
    NAMES 
        zmq.h
    PATHS
        ${PROJECT_SOURCE_DIR}/ext/${ZMQ_PARTIAL_PATH}/include) # Only look internally

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(ZeroMQ DEFAULT_MSG ZeroMQ_LIBRARY ZeroMQ_INCLUDE_DIR)

message(STATUS "ZeroMQ_FOUND: ${ZeroMQ_FOUND}")
message(STATUS "ZeroMQ_LIBRARY: ${ZeroMQ_LIBRARY}")
message(STATUS "ZeroMQ_INCLUDE_DIR: ${ZeroMQ_INCLUDE_DIR}")

if (${ZeroMQ_FOUND})
    link_libraries(${ZeroMQ_LIBRARY})
    include_directories(${ZeroMQ_INCLUDE_DIR})
    include_directories(${ZeroMQ_INCLUDE_DIR}/../)
endif()
