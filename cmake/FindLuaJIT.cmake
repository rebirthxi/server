# Try to find LuaJIT
# LuaJIT_FOUND - System has LuaJIT
# LuaJIT_LIBRARY - The libraries needed to use LuaJIT
# LuaJIT_INCLUDE_DIR - The LuaJIT include directories

if(CMAKE_SIZEOF_VOID_P EQUAL 8)
    set(LUAJIT_PARTIAL_PATH "luajit64")
else()
    set(LUAJIT_PARTIAL_PATH "luajit32")
endif()

# Copy DLL
if (WIN32)
    add_custom_target(copy_luajit_dll ALL
                COMMENT "Copying LuaJIT dll to project root")
    add_custom_command(TARGET copy_luajit_dll PRE_BUILD
                COMMAND ${CMAKE_COMMAND} -E copy_if_different
                    ${PROJECT_SOURCE_DIR}/ext/${LUAJIT_PARTIAL_PATH}/bin/lua51.dll
                    ${CMAKE_SOURCE_DIR})
endif()

find_library(LuaJIT_LIBRARY 
    NAMES 
        lua51
    PATHS
        ${PROJECT_SOURCE_DIR}/ext/${LUAJIT_PARTIAL_PATH}/lib/
        /usr/
        /usr/bin/
        /usr/include/
        /usr/lib/
        /usr/local/
        /usr/local/bin/
        /opt/)

find_path(LuaJIT_INCLUDE_DIR 
    NAMES 
        lua.h
    PATHS
        ${PROJECT_SOURCE_DIR}/ext/${LUAJIT_PARTIAL_PATH}/include) # Only look internally

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(LuaJIT DEFAULT_MSG LuaJIT_LIBRARY LuaJIT_INCLUDE_DIR)

message(STATUS "LuaJIT_FOUND: ${LuaJIT_FOUND}")
message(STATUS "LuaJIT_LIBRARY: ${LuaJIT_LIBRARY}")
message(STATUS "LuaJIT_INCLUDE_DIR: ${LuaJIT_INCLUDE_DIR}")

if (${LuaJIT_FOUND})
    link_libraries(${LuaJIT_LIBRARY})
    include_directories(${LuaJIT_INCLUDE_DIR})
    include_directories(${LuaJIT_INCLUDE_DIR}/../)
endif()
