; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=i386-unknown-unknown %s -o - | FileCheck --check-prefix=X86 %s
; RUN: not llc -mtriple=i386-unknown-unknown -relocation-model=pic %s -o /dev/null 2>&1 | FileCheck --check-prefix=X86PIC %s

; Tests come from "clang/test/CodeGen/ms-inline-asm-variables.c"
;
; int gVar;
; void t1() {
;  __asm add ecx, dword ptr gVar[4590 + eax + ecx*4]
;  __asm add dword ptr [gVar + eax + 45 + 23 - 53 + 60 - 2 + ecx*8], ecx
;  __asm add 1 + 1 + 2 + 3[gVar + ecx + ebx], eax
;
; gVar = 3;
; }

@gVar = global i32 0, align 4

; Function Attrs: noinline nounwind optnone uwtable
define void @t1() #0 {
; X86-LABEL: t1:
; X86:       # %bb.0: # %entry
; X86-NEXT:    pushl %ebp
; X86-NEXT:    .cfi_def_cfa_offset 8
; X86-NEXT:    .cfi_offset %ebp, -8
; X86-NEXT:    movl %esp, %ebp
; X86-NEXT:    .cfi_def_cfa_register %ebp
; X86-NEXT:    #APP
; X86-EMPTY:
; X86-NEXT:    addl gVar+4590(%eax,%ecx,4), %ecx
; X86-NEXT:    addl %ecx, gVar+73(%eax,%ecx,8)
; X86-NEXT:    addl %eax, gVar+7(%ecx,%ebx)
; X86-EMPTY:
; X86-NEXT:    #NO_APP
; X86-NEXT:    movl $3, gVar
; X86-NEXT:    popl %ebp
; X86-NEXT:    .cfi_def_cfa %esp, 4
; X86-NEXT:    retl

; X86PIC: error: Don't use 2 or more regs for mem offset in PIC model
; X86PIC: error: Don't use 2 or more regs for mem offset in PIC model
; X86PIC: error: Don't use 2 or more regs for mem offset in PIC model

entry:
  call void asm sideeffect inteldialect "add ecx, dword ptr ${2:P}[eax + ecx * $$4 + $$4590]\0A\09add dword ptr ${0:P}[eax + ecx * $$8 + $$73], ecx\0A\09add ${1:P}[ecx + ebx + $$7], eax", "=*m,=*m,*m,~{eax},~{ecx},~{flags},~{dirflag},~{fpsr},~{flags}"(ptr elementtype(i32) @gVar, ptr elementtype(i32) @gVar, ptr elementtype(i32) @gVar) #1
  store i32 3, ptr @gVar, align 4
  ret void
}

attributes #0 = { noinline nounwind optnone uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="pentium4" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { nounwind }

!llvm.module.flags = !{!0}

!0 = !{i32 1, !"NumRegisterParameters", i32 0}
