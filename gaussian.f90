module gaussian
use stdtypes
use mtprng
implicit none

real(IEEE64) :: gset
integer :: iset=0

contains

function gasdev(state) result(r)
  type(mtprng_state), intent(inout) :: state
  real(IEEE64) :: r

  real(IEEE64) :: rsq, v1, v2
!  rsq=0.
!  do iset=1,64
!     rsq=rsq+mtprng_rand_real1(state)
!  end do
!  rsq=rsq*0.735759/real(64)

!  r=rsq

 if (iset.eq.0) then
    do
       v1=2.0*mtprng_rand_real1(state)-1.0
       v2=2.0*mtprng_rand_real1(state)-1.0
       rsq=v1**2+v2**2
       if (rsq > 0.0 .and. rsq < 1.0) exit
    end do
    rsq=sqrt(-2.0*log(rsq)/rsq)
    gset=v1*rsq
    iset=1
    r=v2*rsq
 else
    iset=0
    r=gset
 end if
  
end function gasdev

end module gaussian
