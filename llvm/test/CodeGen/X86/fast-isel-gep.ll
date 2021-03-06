; RUN: llc < %s -mtriple=x86_64-linux -O0 | FileCheck %s --check-prefix=X64
; RUN: llc < %s -mtriple=x86_64-windows-itanium -O0 | FileCheck %s --check-prefix=X64
; RUN: llc < %s -mtriple=i686-- -O0 | FileCheck %s --check-prefix=X32

; GEP indices are interpreted as signed integers, so they
; should be sign-extended to 64 bits on 64-bit targets.
; PR3181
define i32 @test1(i32 %t3, ptr %t1) nounwind {
       %t9 = getelementptr i32, ptr %t1, i32 %t3           ; <ptr> [#uses=1]
       %t15 = load i32, ptr %t9            ; <i32> [#uses=1]
       ret i32 %t15
; X32-LABEL: test1:
; X32:  	movl	(%eax,%ecx,4), %eax
; X32:  	ret

; X64-LABEL: test1:
; X64:  	movslq	%e[[A0:di|cx]], %rax
; X64:  	movl	(%r[[A1:si|dx]],%rax,4), %eax
; X64:  	ret

}
define i32 @test2(i64 %t3, ptr %t1) nounwind {
       %t9 = getelementptr i32, ptr %t1, i64 %t3           ; <ptr> [#uses=1]
       %t15 = load i32, ptr %t9            ; <i32> [#uses=1]
       ret i32 %t15
; X32-LABEL: test2:
; X32:  	movl	({{%e[a-z]+}},{{%e[a-z]+}},4), %e
; X32:  	ret

; X64-LABEL: test2:
; X64:  	movl	(%r[[A1]],%r[[A0]],4), %eax
; X64:  	ret
}



; PR4984
define i8 @test3(ptr %start) nounwind {
entry:
  %A = getelementptr i8, ptr %start, i64 -2               ; <ptr> [#uses=1]
  %B = load i8, ptr %A, align 1                       ; <i8> [#uses=1]
  ret i8 %B
  
  
; X32-LABEL: test3:
; X32:  	movl	4(%esp), %eax
; X32:  	movb	-2(%eax), %al
; X32:  	ret

; X64-LABEL: test3:
; X64:  	movb	-2(%r[[A0]]), %al
; X64:  	ret

}

define double @test4(i64 %x, ptr %p) nounwind {
entry:
  %x.addr = alloca i64, align 8                   ; <ptr> [#uses=2]
  %p.addr = alloca ptr, align 8               ; <ptr> [#uses=2]
  store i64 %x, ptr %x.addr
  store ptr %p, ptr %p.addr
  %tmp = load i64, ptr %x.addr                        ; <i64> [#uses=1]
  %add = add nsw i64 %tmp, 16                     ; <i64> [#uses=1]
  %tmp1 = load ptr, ptr %p.addr                   ; <ptr> [#uses=1]
  %arrayidx = getelementptr inbounds double, ptr %tmp1, i64 %add ; <ptr> [#uses=1]
  %tmp2 = load double, ptr %arrayidx                  ; <double> [#uses=1]
  ret double %tmp2

; X32-LABEL: test4:
; X32: 128(%e{{.*}},%e{{.*}},8)
; X64-LABEL: test4:
; X64: 128(%r{{.*}},%r{{.*}},8)
}

; PR8961 - Make sure the sext for the GEP addressing comes before the load that
; is folded.
define i64 @test5(ptr %A, i32 %I, i64 %B) nounwind {
  %v8 = getelementptr i8, ptr %A, i32 %I
  %v10 = load i64, ptr %v8
  %v11 = add i64 %B, %v10
  ret i64 %v11
; X64-LABEL: test5:
; X64: movslq	%e[[A1]], [[R0:%r[a-z]+]]
; X64-NEXT: (%r[[A0]],[[R0]]),
; X64: ret
}

; PR9500, rdar://9156159 - Don't do non-local address mode folding,
; because it may require values which wouldn't otherwise be live out
; of their blocks.
define void @test6() personality ptr @__gxx_personality_v0 {
if.end:                                           ; preds = %if.then, %invoke.cont
  %tmp15 = load i64, ptr undef
  %dec = add i64 %tmp15, 13
  store i64 %dec, ptr undef
  %call17 = invoke ptr @_ZNK18G__FastAllocString4dataEv()
          to label %invoke.cont16 unwind label %lpad

invoke.cont16:                                    ; preds = %if.then14
  %arrayidx18 = getelementptr inbounds i8, ptr %call17, i64 %dec
  store i8 0, ptr %arrayidx18
  unreachable

lpad:                                             ; preds = %if.end19, %if.then14, %if.end, %entry
  %exn = landingpad {ptr, i32}
            cleanup
  unreachable
}
declare ptr @_ZNK18G__FastAllocString4dataEv() nounwind


; PR10605 / rdar://9930964 - Don't fold loads incorrectly.  The load should
; happen before the store.  
define i32 @test7(ptr %tmp1, i32 %tmp71, i32 %tmp63) nounwind  {
; X64-LABEL: test7:
; X64:    movl	8({{%rdi|%rcx}}), %eax
; X64:     movl	$4, 8({{%rdi|%rcx}})


  %tmp29 = getelementptr inbounds {i32,i32,i32}, ptr %tmp1, i32 0, i32 2
  %tmp30 = load i32, ptr %tmp29, align 4

  %p2 = getelementptr inbounds {i32,i32,i32}, ptr %tmp1, i32 0, i32 2
  store i32 4, ptr %p2
  
  %tmp72 = or i32 %tmp71, %tmp30
  %tmp73 = icmp ne i32 %tmp63, 32
  br i1 %tmp73, label %T, label %F

T:
  ret i32 %tmp72

F:
  ret i32 4
}

declare i32 @__gxx_personality_v0(...)
