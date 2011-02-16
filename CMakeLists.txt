cmake_minimum_required(VERSION 2.6)

set(CMAKE_MODULE_PATH ${CMAKE_CURRENT_SOURCE_DIR}/cmake)

project(MTPRNG_f95)
FIND_PACKAGE(Git)

enable_language(Fortran)
set(CMAKE_Fortran_MODULE_DIRECTORY ${CMAKE_BINARY_DIR}/modules)
ENABLE_TESTING()
if (CMAKE_Fortran_COMPILER MATCHES "gfortran")
  # gfortran
  set (CMAKE_Fortran_FLAGS "-ffree-line-length-none")
endif (CMAKE_Fortran_COMPILER MATCHES "gfortran")


add_custom_target(MTPRNG_F95_version ${CMAKE_COMMAND} -D
SRC=${CMAKE_CURRENT_SOURCE_DIR} -D
F95_MOD_DIR=${CMAKE_Fortran_MODULE_DIRECTORY} -D
CMAKE_MODULE_PATH=${CMAKE_MODULE_PATH} -D
CMAKE_Fortran_COMPILER=${CMAKE_Fortran_COMPILER} -D
CMAKE_Fortran_FLAGS=${CMAKE_Fortran_FLAGS} -P
${CMAKE_CURRENT_SOURCE_DIR}/cmake/version.cmake)

include_directories(${CMAKE_Fortran_MODULE_DIRECTORY}) 
add_library(mtprng stdtypes.f90 mtprng.f90)
add_dependencies(mtprng MTPRNG_F95_version)

add_executable(example_prog example_prog.f90)
target_link_libraries(example_prog mtprng)

add_executable(test_mtprng test/test_mtprng.f90)
target_link_libraries(test_mtprng mtprng)

add_test(test_f95 test_mtprng PROPERTIES PASS_REGULAR_EXPRESSION "success")

install(TARGETS mtprng LIBRARY DESTINATION lib ARCHIVE DESTINATION lib)
install(DIRECTORY ${CMAKE_Fortran_MODULE_DIRECTORY}/ DESTINATION include)


