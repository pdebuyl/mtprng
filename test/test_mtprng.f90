program test
  use stdtypes
  use mtprng
  implicit none

  integer(INT32) :: seed
  type(mtprng_state) :: state
  integer :: i, misses
  integer(INT64) :: known(100), hop
  double precision :: known_double
  logical :: success, success_double

  known = (/   1062284148_INT64 , &
  1840134109_INT64 , &
  3636226446_INT64 , &
   887288380_INT64 , &
  3889928508_INT64 , &
   631642018_INT64 , &
   914101460_INT64 , &
  3162600344_INT64 , &
  4279173875_INT64 , &
  3888840898_INT64 , &
  2663878183_INT64 , &
  2252856790_INT64 , &
  3463027370_INT64 , &
  1097057726_INT64 , &
  3184139039_INT64 , &
  1434652676_INT64 , &
  3403152620_INT64 , &
   833869435_INT64 , &
   612581734_INT64 , &
   576299959_INT64 , &
  1474687423_INT64 , &
  3466262180_INT64 , &
  3133945242_INT64 , &
  2677293441_INT64 , &
  3505646298_INT64 , &
  1339531483_INT64 , &
  3669763788_INT64 , &
   510452911_INT64 , &
   559989931_INT64 , &
  2308431220_INT64 , &
  3603446463_INT64 , &
   667203617_INT64 , &
  1127428958_INT64 , &
  1290717533_INT64 , &
  3513405708_INT64 , &
   927031876_INT64 , &
  4032539667_INT64 , &
  3825851657_INT64 , &
  2014122148_INT64 , &
  3946341433_INT64 , &
  2489727744_INT64 , &
  3391425033_INT64 , &
  1283015508_INT64 , &
   913542342_INT64 , &
   764165363_INT64 , &
  3945892851_INT64 , &
  2442690715_INT64 , &
  1067765245_INT64 , &
  2537181202_INT64 , &
  3064480631_INT64 , &
  3101723380_INT64 , &
   802526031_INT64 , &
  3157511722_INT64 , &
  3269291235_INT64 , &
  4215855479_INT64 , &
   181260300_INT64 , &
  3744061959_INT64 , &
  1143883471_INT64 , &
    53781702_INT64 , &
   882249490_INT64 , &
   321985400_INT64 , &
   577208133_INT64 , &
   885895688_INT64 , &
  2725767908_INT64 , &
  2231810848_INT64 , &
  1980748708_INT64 , &
  3886306640_INT64 , &
   202325230_INT64 , &
  3043114780_INT64 , &
  2021505937_INT64 , &
  1074135674_INT64 , &
   753749191_INT64 , &
  3155169167_INT64 , &
  2997245061_INT64 , &
  1203929572_INT64 , &
  2247630318_INT64 , &
  1571401504_INT64 , &
  4114645852_INT64 , &
  3048726454_INT64 , &
  3912566191_INT64 , &
   546592897_INT64 , &
  3352654755_INT64 , &
  3632644786_INT64 , &
  3691031383_INT64 , &
  1267283456_INT64 , &
   900236841_INT64 , &
    47733538_INT64 , &
  2049551875_INT64 , &
   668453652_INT64 , &
  2379406100_INT64 , &
   689049113_INT64 , &
   759943852_INT64 , &
   623176051_INT64 , &
  1348915232_INT64 , &
  1345348561_INT64 , &
  2055844659_INT64 , &
  3678167085_INT64 , &
  1856143658_INT64 , &
  2464849813_INT64 , &
    28304277_INT64 /)

  known_double = 0.96673825731657869742d0

  seed = 6928

  call mtprng_init(seed, state)

  misses = 0
  success=.true.
  do i=1,100
     hop = mtprng_rand64(state)
     if (hop.ne.known(i)) misses=misses+1
  end do
  if (misses>0) success=.false.
  
! retourne un reel IEEE64, peut être utilisé en double precision
  if ( abs(mtprng_rand_real1(state)-known_double) > 5d-16 ) then
     success_double = .false.
  else
     success_double = .true.
  end if
  
  if (success .and. success_double) then
     write(*,*) 'success'
  else
     if (success) then
        write(*,*) 'integer : ok'
     else
        write(*,*) 'integer :', misses, ' misses'
     end if
     if (success_double) then
        write(*,*) 'double precision : ok'
     else
        write(*,*) 'double precision : failure'
     end if
  end if

end program test
