; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mcpu=pwr10 -verify-machineinstrs -mtriple=powerpc64le-unknown-linux-gnu \
; RUN:   -mattr=+quadword-atomics -ppc-asm-full-reg-names -o - %s | FileCheck %s

%struct.StructA = type { [16 x i8] }

@s1 = dso_local global i128 324929342, align 16

; Function Attrs: mustprogress noinline nounwind optnone uwtable
define dso_local void @STQ() #0 {
; CHECK-LABEL: STQ:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    lis r0, -16
; CHECK-NEXT:    ori r0, r0, 51488
; CHECK-NEXT:    stdux r1, r1, r0
; CHECK-NEXT:    .cfi_def_cfa_offset 997088
; CHECK-NEXT:    pld r3, s1@PCREL+8(0), 1
; CHECK-NEXT:    std r3, 40(r1)
; CHECK-NEXT:    pld r3, s1@PCREL(0), 1
; CHECK-NEXT:    std r3, 32(r1)
; CHECK-NEXT:    ld r3, 40(r1)
; CHECK-NEXT:    ld r4, 32(r1)
; CHECK-NEXT:    sync
; CHECK-NEXT:    mr r5, r4
; CHECK-NEXT:    mr r4, r3
; CHECK-NEXT:    lis r3, 15
; CHECK-NEXT:    ori r3, r3, 14032
; CHECK-NEXT:    add r3, r3, r1
; CHECK-NEXT:    stq r4, 0(r3)
; CHECK-NEXT:    ld r1, 0(r1)
; CHECK-NEXT:    blr
entry:
  %s2 = alloca %struct.StructA, align 16
  %s3 = alloca %struct.StructA, align 16
  %arr = alloca [997003 x i8], align 1
  %tmp = alloca %struct.StructA, align 16
  call void @llvm.memcpy.p0.p0.i64(ptr align 16 %tmp, ptr align 16 @s1, i64 16, i1 false)
  %0 = load i128, ptr %tmp, align 16
  store atomic i128 %0, ptr %s2 seq_cst, align 16
  ret void
}

define dso_local void @LQ() #0 {
; CHECK-LABEL: LQ:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    lis r0, -16
; CHECK-NEXT:    ori r0, r0, 51488
; CHECK-NEXT:    stdux r1, r1, r0
; CHECK-NEXT:    .cfi_def_cfa_offset 997088
; CHECK-NEXT:    pld r3, s1@PCREL+8(0), 1
; CHECK-NEXT:    std r3, 40(r1)
; CHECK-NEXT:    pld r3, s1@PCREL(0), 1
; CHECK-NEXT:    std r3, 32(r1)
; CHECK-NEXT:    sync
; CHECK-NEXT:    lis r3, 15
; CHECK-NEXT:    ori r3, r3, 14016
; CHECK-NEXT:    add r3, r3, r1
; CHECK-NEXT:    lq r4, 0(r3)
; CHECK-NEXT:    cmpd cr7, r5, r5
; CHECK-NEXT:    bne- cr7, .+4
; CHECK-NEXT:    isync
; CHECK-NEXT:    ld r1, 0(r1)
; CHECK-NEXT:    blr
entry:
  %s2 = alloca %struct.StructA, align 16
  %s3 = alloca %struct.StructA, align 16
  %arr = alloca [997003 x i8], align 1
  %tmp = alloca %struct.StructA, align 16
  call void @llvm.memcpy.p0.p0.i64(ptr align 16 %tmp, ptr align 16 @s1, i64 16, i1 false)
  %0 = load i128, ptr %tmp, align 16
  %1 = load atomic i128, ptr %s3 seq_cst, align 16
  ret void
}

; Function Attrs: argmemonly nofree nounwind willreturn
declare void @llvm.memcpy.p0.p0.i64(ptr noalias nocapture writeonly, ptr noalias nocapture readonly, i64, i1 immarg) #1

attributes #0 = { noinline optnone }
