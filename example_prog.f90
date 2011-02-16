program test
  use stdtypes
  use mtprng
  implicit none

  integer(INT32) :: seed
  type(mtprng_state) :: state

  call mtprng_info

  seed = nint(100*secnds(0.))

  call mtprng_init(seed, state)

  ! returns a INT64 integer with a range in 0 .. 2^32-1
  write(*,*) mtprng_rand64(state)
  
  ! returns a IEEE64 real, may be used as double precision
  write(*,*) mtprng_rand_real1(state)

end program test
