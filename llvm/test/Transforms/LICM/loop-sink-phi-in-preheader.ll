; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -S -passes=loop-sink %s | FileCheck %s

define void @preheader_of_inner_has_phi() !prof !0 {
; CHECK-LABEL: @preheader_of_inner_has_phi(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br label [[OUTER_HEADER:%.*]]
; CHECK:       outer.header:
; CHECK-NEXT:    [[PH_1:%.*]] = phi i32 [ 0, [[ENTRY:%.*]] ], [ [[PH_2:%.*]], [[OUTER_LATCH:%.*]] ]
; CHECK-NEXT:    br label [[INNER:%.*]]
; CHECK:       inner:
; CHECK-NEXT:    [[PH_2]] = phi i32 [ 0, [[OUTER_HEADER]] ], [ 0, [[INNER]] ]
; CHECK-NEXT:    br i1 false, label [[OUTER_LATCH]], label [[INNER]], !prof [[PROF1:![0-9]+]]
; CHECK:       outer.latch:
; CHECK-NEXT:    br label [[OUTER_HEADER]]
;
entry:
  br label %outer.header

outer.header:
  %ph.1 = phi i32 [ 0, %entry ], [ %ph.2, %outer.latch ]
  br label %inner

inner:
  %ph.2 = phi i32 [ 0, %outer.header ], [ 0, %inner ]
  br i1 false, label %outer.latch, label %inner, !prof !1

outer.latch:
  br label %outer.header
}

!0 = !{!"function_entry_count", i64 549102}
!1 = !{!"branch_weights", i32 4027913, i32 1}
