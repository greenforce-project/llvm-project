; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mcpu=corei7-avx | FileCheck %s

define void @wideloads(ptr %a, ptr %b, ptr %c) nounwind {
; CHECK-LABEL: wideloads:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vmovaps (%rdi), %xmm0
; CHECK-NEXT:    vinsertf128 $1, 16(%rdi), %ymm0, %ymm0
; CHECK-NEXT:    vmovaps (%rsi), %ymm1
; CHECK-NEXT:    vcmpltps %ymm0, %ymm1, %ymm1
; CHECK-NEXT:    vmovaps (%rdx), %ymm2
; CHECK-NEXT:    vcmpltps %ymm0, %ymm2, %ymm0
; CHECK-NEXT:    vandps %ymm1, %ymm0, %ymm0
; CHECK-NEXT:    vandps {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %ymm0, %ymm0
; CHECK-NEXT:    vmovaps %ymm0, (%rax)
; CHECK-NEXT:    vzeroupper
; CHECK-NEXT:    retq
  %v0 = load <8 x float>, ptr %a, align 16  ; <---- unaligned!
  %v1 = load <8 x float>, ptr %b, align 32  ; <---- aligned!
  %m0 = fcmp olt <8 x float> %v1, %v0
  %v2 = load <8 x float>, ptr %c, align 32  ; <---- aligned!
  %m1 = fcmp olt <8 x float> %v2, %v0
  %mand = and <8 x i1> %m1, %m0
  %r = zext <8 x i1> %mand to <8 x i32>
  store <8 x i32> %r, ptr undef, align 32
  ret void
}

define void @widestores(ptr %a, ptr %b, ptr %c) nounwind {
; CHECK-LABEL: widestores:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vmovaps (%rdi), %ymm0
; CHECK-NEXT:    vmovaps (%rsi), %ymm1
; CHECK-NEXT:    vmovaps %ymm0, (%rsi)
; CHECK-NEXT:    vextractf128 $1, %ymm1, 16(%rdi)
; CHECK-NEXT:    vmovaps %xmm1, (%rdi)
; CHECK-NEXT:    vzeroupper
; CHECK-NEXT:    retq
  %v0 = load <8 x float>, ptr %a, align 32
  %v1 = load <8 x float>, ptr %b, align 32
  store <8 x float> %v0, ptr %b, align 32 ; <--- aligned
  store <8 x float> %v1, ptr %a, align 16 ; <--- unaligned
  ret void
}

define void @widestores_unaligned_load(ptr %a, ptr %b, ptr %c) nounwind {
; CHECK-LABEL: widestores_unaligned_load:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vmovaps (%rdi), %ymm0
; CHECK-NEXT:    vmovaps (%rsi), %xmm1
; CHECK-NEXT:    vmovaps 16(%rsi), %xmm2
; CHECK-NEXT:    vmovaps %ymm0, (%rsi)
; CHECK-NEXT:    vmovaps %xmm2, 16(%rdi)
; CHECK-NEXT:    vmovaps %xmm1, (%rdi)
; CHECK-NEXT:    vzeroupper
; CHECK-NEXT:    retq
  %v0 = load <8 x float>, ptr %a, align 32 ; <--- aligned
  %v1 = load <8 x float>, ptr %b, align 16 ; <--- unaligned
  store <8 x float> %v0, ptr %b, align 32 ; <--- aligned
  store <8 x float> %v1, ptr %a, align 16 ; <--- unaligned
  ret void
}
