; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=i386-apple-darwin -mcpu=corei7 -o - < %s | FileCheck %s

define i32 @func(ptr %A) nounwind readnone {
; CHECK-LABEL: func:
; CHECK:       ## %bb.0: ## %entry
; CHECK-NEXT:    movl {{[0-9]+}}(%esp), %eax
; CHECK-NEXT:    roll $27, %eax
; CHECK-NEXT:    retl
entry:
  %tmp = ptrtoint ptr %A to i32
  %shr = lshr i32 %tmp, 5
  %shl = shl i32 %tmp, 27
  %or = or i32 %shr, %shl
  ret i32 %or
}
