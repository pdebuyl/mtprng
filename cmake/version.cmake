FIND_PACKAGE(Git)


IF(GIT_EXECUTABLE)
SET(MY_GIT_DIR ${SRC})
execute_process(COMMAND ${GIT_EXECUTABLE} --git-dir=${MY_GIT_DIR}/.git --work-tree=${MY_GIT_DIR} status RESULT_VARIABLE git_return OUTPUT_VARIABLE git_out)

execute_process(COMMAND ${GIT_EXECUTABLE} --git-dir=${MY_GIT_DIR}/.git --work-tree=${MY_GIT_DIR} symbolic-ref HEAD OUTPUT_VARIABLE symb_out OUTPUT_STRIP_TRAILING_WHITESPACE)
string(REGEX REPLACE "^refs/heads/" "" mtprng_f95_symb "${symb_out}")

if(git_out MATCHES "working directory clean")

execute_process(COMMAND ${GIT_EXECUTABLE} --git-dir=${MY_GIT_DIR}/.git --work-tree=${MY_GIT_DIR} log -n1 --format=%H OUTPUT_VARIABLE mtprng_f95_commit OUTPUT_STRIP_TRAILING_WHITESPACE)
execute_process(COMMAND ${GIT_EXECUTABLE} --git-dir=${MY_GIT_DIR}/.git --work-tree=${MY_GIT_DIR} describe OUTPUT_VARIABLE mtprng_f95_version OUTPUT_STRIP_TRAILING_WHITESPACE)

else(git_out MATCHES "working directory clean")

set(mtprng_f95_commit "unknown rev. or working dir. not clean")

endif(git_out MATCHES "working directory clean")

set(mtprng_f95_commit "${mtprng_f95_symb} / ${mtprng_f95_commit}")

execute_process(COMMAND ${GIT_EXECUTABLE} --git-dir=${MY_GIT_DIR}/.git --work-tree=${MY_GIT_DIR} describe OUTPUT_VARIABLE mtprng_f95_version OUTPUT_STRIP_TRAILING_WHITESPACE)
execute_process(COMMAND ${GIT_EXECUTABLE} --git-dir=${MY_GIT_DIR}/.git --work-tree=${MY_GIT_DIR} log -n1 --format=%aD OUTPUT_VARIABLE mtprng_f95_date OUTPUT_STRIP_TRAILING_WHITESPACE)
SET(mtprng_f95_version_date "${mtprng_f95_version} ${mtprng_f95_date}")

execute_process(COMMAND "uname" "-nsm" OUTPUT_VARIABLE mtprng_f95_machine OUTPUT_STRIP_TRAILING_WHITESPACE)
execute_process(COMMAND "basename" "${CMAKE_Fortran_COMPILER}" OUTPUT_VARIABLE mtprng_f95_compiler OUTPUT_STRIP_TRAILING_WHITESPACE)
SET(mtprng_f95_compiler "${mtprng_f95_compiler} ${CMAKE_Fortran_FLAGS}")
configure_file(${SRC}/mtprng_version.h.in ${F95_MOD_DIR}/mtprng_version.h @ONLY)

else(GIT_EXECUTABLE)

configure_file(${SRC}/f95/mtprng_version.h.git.in ${F95_MOD_DIR}/mtprng_version.h COPYONLY)

endif(GIT_EXECUTABLE)



