; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=x86_64-linux-gnu -global-isel -verify-machineinstrs < %s -o - | FileCheck %s --check-prefix=X64_GISEL
; RUN: llc -mtriple=x86_64-linux-gnu              -verify-machineinstrs < %s -o - | FileCheck %s --check-prefix=X64

define ptr @test_gep_i8(ptr%arr, i8 %ind) {
; X64_GISEL-LABEL: test_gep_i8:
; X64_GISEL:       # %bb.0:
; X64_GISEL-NEXT:    # kill: def $esi killed $esi def $rsi
; X64_GISEL-NEXT:    shlq $56, %rsi
; X64_GISEL-NEXT:    sarq $56, %rsi
; X64_GISEL-NEXT:    imulq $4, %rsi, %rax
; X64_GISEL-NEXT:    addq %rdi, %rax
; X64_GISEL-NEXT:    retq
;
; X64-LABEL: test_gep_i8:
; X64:       # %bb.0:
; X64-NEXT:    # kill: def $esi killed $esi def $rsi
; X64-NEXT:    movsbq %sil, %rax
; X64-NEXT:    leaq (%rdi,%rax,4), %rax
; X64-NEXT:    retq
  %arrayidx = getelementptr i32, ptr %arr, i8 %ind
  ret ptr %arrayidx
}

define ptr @test_gep_i8_const(ptr%arr) {
; X64_GISEL-LABEL: test_gep_i8_const:
; X64_GISEL:       # %bb.0:
; X64_GISEL-NEXT:    movl $80, %eax
; X64_GISEL-NEXT:    addq %rdi, %rax
; X64_GISEL-NEXT:    retq
;
; X64-LABEL: test_gep_i8_const:
; X64:       # %bb.0:
; X64-NEXT:    leaq 80(%rdi), %rax
; X64-NEXT:    retq
  %arrayidx = getelementptr i32, ptr %arr, i8 20
  ret ptr %arrayidx
}

define ptr @test_gep_i16(ptr%arr, i16 %ind) {
; X64_GISEL-LABEL: test_gep_i16:
; X64_GISEL:       # %bb.0:
; X64_GISEL-NEXT:    # kill: def $esi killed $esi def $rsi
; X64_GISEL-NEXT:    shlq $48, %rsi
; X64_GISEL-NEXT:    sarq $48, %rsi
; X64_GISEL-NEXT:    imulq $4, %rsi, %rax
; X64_GISEL-NEXT:    addq %rdi, %rax
; X64_GISEL-NEXT:    retq
;
; X64-LABEL: test_gep_i16:
; X64:       # %bb.0:
; X64-NEXT:    # kill: def $esi killed $esi def $rsi
; X64-NEXT:    movswq %si, %rax
; X64-NEXT:    leaq (%rdi,%rax,4), %rax
; X64-NEXT:    retq
  %arrayidx = getelementptr i32, ptr %arr, i16 %ind
  ret ptr %arrayidx
}

define ptr @test_gep_i16_const(ptr%arr) {
; X64_GISEL-LABEL: test_gep_i16_const:
; X64_GISEL:       # %bb.0:
; X64_GISEL-NEXT:    movl $80, %eax
; X64_GISEL-NEXT:    addq %rdi, %rax
; X64_GISEL-NEXT:    retq
;
; X64-LABEL: test_gep_i16_const:
; X64:       # %bb.0:
; X64-NEXT:    leaq 80(%rdi), %rax
; X64-NEXT:    retq
  %arrayidx = getelementptr i32, ptr %arr, i16 20
  ret ptr %arrayidx
}

define ptr @test_gep_i32(ptr%arr, i32 %ind) {
; X64_GISEL-LABEL: test_gep_i32:
; X64_GISEL:       # %bb.0:
; X64_GISEL-NEXT:    movslq %esi, %rax
; X64_GISEL-NEXT:    imulq $4, %rax, %rax
; X64_GISEL-NEXT:    addq %rdi, %rax
; X64_GISEL-NEXT:    retq
;
; X64-LABEL: test_gep_i32:
; X64:       # %bb.0:
; X64-NEXT:    movslq %esi, %rax
; X64-NEXT:    leaq (%rdi,%rax,4), %rax
; X64-NEXT:    retq
  %arrayidx = getelementptr i32, ptr %arr, i32 %ind
  ret ptr %arrayidx
}

define ptr @test_gep_i32_const(ptr%arr) {
; X64_GISEL-LABEL: test_gep_i32_const:
; X64_GISEL:       # %bb.0:
; X64_GISEL-NEXT:    movl $20, %eax
; X64_GISEL-NEXT:    addq %rdi, %rax
; X64_GISEL-NEXT:    retq
;
; X64-LABEL: test_gep_i32_const:
; X64:       # %bb.0:
; X64-NEXT:    leaq 20(%rdi), %rax
; X64-NEXT:    retq
  %arrayidx = getelementptr i32, ptr %arr, i32 5
  ret ptr %arrayidx
}

define ptr @test_gep_i64(ptr%arr, i64 %ind) {
; X64_GISEL-LABEL: test_gep_i64:
; X64_GISEL:       # %bb.0:
; X64_GISEL-NEXT:    imulq $4, %rsi, %rax
; X64_GISEL-NEXT:    addq %rdi, %rax
; X64_GISEL-NEXT:    retq
;
; X64-LABEL: test_gep_i64:
; X64:       # %bb.0:
; X64-NEXT:    leaq (%rdi,%rsi,4), %rax
; X64-NEXT:    retq
  %arrayidx = getelementptr i32, ptr %arr, i64 %ind
  ret ptr %arrayidx
}

define ptr @test_gep_i64_const(ptr%arr) {
; X64_GISEL-LABEL: test_gep_i64_const:
; X64_GISEL:       # %bb.0:
; X64_GISEL-NEXT:    movl $20, %eax
; X64_GISEL-NEXT:    addq %rdi, %rax
; X64_GISEL-NEXT:    retq
;
; X64-LABEL: test_gep_i64_const:
; X64:       # %bb.0:
; X64-NEXT:    leaq 20(%rdi), %rax
; X64-NEXT:    retq
  %arrayidx = getelementptr i32, ptr %arr, i64 5
  ret ptr %arrayidx
}

