; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=i386-apple-darwin -relocation-model=pic -frame-pointer=all | FileCheck %s
; Don't fold re-materialized load into a two address instruction

	%"struct.Smarts::Runnable" = type { ptr, i32 }
	%struct.__sbuf = type { ptr, i32 }
	%"struct.std::ios_base" = type { ptr, i32, i32, i32, i32, i32, ptr, %struct.__sbuf, [8 x %struct.__sbuf], i32, ptr, %"struct.std::locale" }
	%"struct.std::ios_base::_Callback_list" = type { ptr, ptr, i32, i32 }
	%"struct.std::locale" = type { ptr }
	%"struct.std::locale::_Impl" = type { i32, ptr, i32, ptr, ptr }
@_ZTVSt9basic_iosIcSt11char_traitsIcEE = external constant [4 x ptr]		; <ptr> [#uses=1]
@_ZTTSt19basic_ostringstreamIcSt11char_traitsIcESaIcEE = external constant [4 x ptr]		; <ptr> [#uses=1]
@_ZTVSt19basic_ostringstreamIcSt11char_traitsIcESaIcEE = external constant [10 x ptr]		; <ptr> [#uses=2]
@_ZTVSt15basic_streambufIcSt11char_traitsIcEE = external constant [16 x ptr]		; <ptr> [#uses=1]
@_ZTVSt15basic_stringbufIcSt11char_traitsIcESaIcEE = external constant [16 x ptr]		; <ptr> [#uses=1]

define void @_GLOBAL__I__ZN5Pooma5pinfoE() nounwind  {
; CHECK-LABEL: _GLOBAL__I__ZN5Pooma5pinfoE:
; CHECK:       ## %bb.0: ## %entry
; CHECK-NEXT:    pushl %ebp
; CHECK-NEXT:    movl %esp, %ebp
; CHECK-NEXT:    pushl %ebx
; CHECK-NEXT:    pushl %edi
; CHECK-NEXT:    pushl %esi
; CHECK-NEXT:    subl $12, %esp
; CHECK-NEXT:    calll L0$pb
; CHECK-NEXT:  L0$pb:
; CHECK-NEXT:    popl %edi
; CHECK-NEXT:    movl L__ZTVSt19basic_ostringstreamIcSt11char_traitsIcESaIcEE$non_lazy_ptr-L0$pb(%edi), %ebx
; CHECK-NEXT:    leal 32(%ebx), %eax
; CHECK-NEXT:    movl %eax, 0
; CHECK-NEXT:    movl $180, (%esp)
; CHECK-NEXT:    calll __Znwm
; CHECK-NEXT:    movl %eax, %esi
; CHECK-NEXT:    movl $0, (%esp)
; CHECK-NEXT:    calll __ZNSt8ios_baseC2Ev
; CHECK-NEXT:    movl $0, 0
; CHECK-NEXT:    addl $12, %ebx
; CHECK-NEXT:    movl %ebx, (%esi)
; CHECK-NEXT:    movl L__ZTVSt15basic_streambufIcSt11char_traitsIcEE$non_lazy_ptr-L0$pb(%edi), %eax
; CHECK-NEXT:    addl $8, %eax
; CHECK-NEXT:    movl %eax, 0
; CHECK-NEXT:    movl $0, (%esp)
; CHECK-NEXT:    calll __ZNSt6localeC1Ev
; CHECK-NEXT:    movl L__ZTVSt15basic_stringbufIcSt11char_traitsIcESaIcEE$non_lazy_ptr-L0$pb(%edi), %eax
; CHECK-NEXT:    addl $8, %eax
; CHECK-NEXT:    movl %eax, 0
; CHECK-NEXT:    ud2
entry:
	store ptr getelementptr ([10 x ptr], ptr @_ZTVSt19basic_ostringstreamIcSt11char_traitsIcESaIcEE, i32 0, i32 8), ptr null, align 4
	%tmp96.i.i142.i = call ptr @_Znwm( i32 180 ) nounwind 		; <ptr> [#uses=2]
	call void @_ZNSt8ios_baseC2Ev( ptr null ) nounwind
	store ptr getelementptr ([4 x ptr], ptr @_ZTVSt9basic_iosIcSt11char_traitsIcEE, i32 0, i32 2), ptr null, align 4
	store ptr null, ptr null, align 4
	%ctg2242.i.i163.i = getelementptr i8, ptr %tmp96.i.i142.i, i32 0		; <ptr> [#uses=1]
	%tmp150.i.i164.i = load ptr, ptr getelementptr ([4 x ptr], ptr @_ZTTSt19basic_ostringstreamIcSt11char_traitsIcESaIcEE, i32 0, i64 2), align 4		; <ptr> [#uses=1]
	store ptr %tmp150.i.i164.i, ptr %ctg2242.i.i163.i, align 4
	store ptr getelementptr ([10 x ptr], ptr @_ZTVSt19basic_ostringstreamIcSt11char_traitsIcESaIcEE, i32 0, i32 3), ptr %tmp96.i.i142.i, align 4
	store ptr getelementptr ([16 x ptr], ptr @_ZTVSt15basic_streambufIcSt11char_traitsIcEE, i32 0, i32 2), ptr null, align 4
	call void @_ZNSt6localeC1Ev( ptr null ) nounwind
	store ptr getelementptr ([16 x ptr], ptr @_ZTVSt15basic_stringbufIcSt11char_traitsIcESaIcEE, i32 0, i32 2), ptr null, align 4
	unreachable
}

declare ptr @_Znwm(i32)

declare void @_ZNSt8ios_baseC2Ev(ptr)

declare void @_ZNSt6localeC1Ev(ptr) nounwind
