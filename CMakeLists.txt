cmake_minimum_required(VERSION 3.15)
project(Rat CXX)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

option(RAT_ENABLE_ASAN "Enable AddressSanitizer with GCC or Clang" OFF)

set(SRC_DIR src)
set(INC_DIR includes)
set(TEST_DIR tests)
set(DATA_DIR data)

file(MAKE_DIRECTORY "${CMAKE_BINARY_DIR}/${DATA_DIR}")

add_custom_target(data ALL
    COMMAND ${CMAKE_COMMAND} -E copy_directory
    "${CMAKE_SOURCE_DIR}/${DATA_DIR}" "${CMAKE_BINARY_DIR}/${DATA_DIR}"
)

# Source Files
set(SOURCES
    ${SRC_DIR}/rat_source.cpp
    ${SRC_DIR}/main.cpp
    ${SRC_DIR}/lexer.cpp
    ${SRC_DIR}/parser.cpp
    ${SRC_DIR}/symbol_table.cpp
    ${SRC_DIR}/assembly.cpp
    ${SRC_DIR}/semantic.cpp
    ${TEST_DIR}/test.cpp
)

include_directories(${INC_DIR})

set(EXECUTABLE_NAME rat)

add_executable(${EXECUTABLE_NAME} ${SOURCES})
add_dependencies(${EXECUTABLE_NAME} data)
if(MSVC)
    # rat currently runs assertion-based tests, including in Release builds.
    target_compile_options(rat PRIVATE /W3 /UNDEBUG)
else()
    target_compile_options(rat PRIVATE -Wall -UNDEBUG)
endif()
if(RAT_ENABLE_ASAN)
    if(CMAKE_CXX_COMPILER_ID MATCHES "GNU|Clang")
        target_compile_options(rat PRIVATE -fsanitize=address)
        target_link_options(rat PRIVATE -fsanitize=address)
    else()
        message(FATAL_ERROR "RAT_ENABLE_ASAN requires GCC or Clang")
    endif()
endif()
enable_testing()
add_test(NAME rat-tests COMMAND rat)
set_tests_properties(rat-tests PROPERTIES WORKING_DIRECTORY "${CMAKE_BINARY_DIR}")
