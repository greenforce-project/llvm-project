! Ensure arguments -ffree-form and -ffixed-form work as expected.

!--------------------------
! FLANG DRIVER (flang)
!--------------------------
! RUN: not %flang -fsyntax-only -ffree-form %S/Inputs/fixed-form-test.f  2>&1 | FileCheck %s --check-prefix=FREEFORM
! RUN: %flang -fsyntax-only -ffixed-form %S/Inputs/free-form-test.f90 2>&1 | FileCheck %s --check-prefix=FIXEDFORM

!----------------------------------------
! FRONTEND FLANG DRIVER (flang -fc1)
!----------------------------------------
! RUN: not %flang_fc1 -fsyntax-only -ffree-form %S/Inputs/fixed-form-test.f  2>&1 | FileCheck %s --check-prefix=FREEFORM
! RUN: %flang_fc1 -fsyntax-only -ffixed-form %S/Inputs/free-form-test.f90 2>&1 | FileCheck %s --check-prefix=FIXEDFORM

! FREEFORM: Could not parse

! FIXEDFORM:free-form-test.f90:1:1: warning: Character in fixed-form label field must be a digit
