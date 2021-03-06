; RUN: llc < %s -mtriple=arm64-eabi -mcpu=cyclone | FileCheck %s
; <rdar://problem/11294426>

@b = common unnamed_addr global [3 x i32] zeroinitializer, align 4

; The important thing for this test is that we need an unaligned load of `l_b'
; ("ldr w2, [x1, #8]" in this case).

; CHECK:      adrp x[[PAGE:[0-9]+]], :got:b
; CHECK-NEXT: ldr  x[[PAGE]], [x[[ADDR:[0-9]+]], :got_lo12:b]
; CHECK-NEXT: ldr  [[VAL2:x[0-9]+]], [x[[ADDR]]]
; CHECK-NEXT: ldr  [[VAL:w[0-9]+]], [x[[ADDR]], #8]
; CHECK-NEXT: str  [[VAL]], [x0, #8]
; CHECK-NEXT: str  [[VAL2]], [x0]

define void @foo(i8* %a) {
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 4 %a, i8* align 4 bitcast ([3 x i32]* @b to i8*), i64 12, i1 false)
  ret void
}

declare void @llvm.memcpy.p0i8.p0i8.i64(i8* nocapture, i8* nocapture, i64, i1) nounwind
