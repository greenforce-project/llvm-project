# RUN: llvm-mc --triple=x86_64-pc-linux --filetype=obj %s -o %t
# RUN: %lldb -o "target variable ug U::s" -b %t | FileCheck %s

# CHECK: (lldb) target variable ug
# CHECK: (U) ug = (m = 14159265)
# CHECK: (int) U::s = 65295141

# This tests that a static member in a class declared in the anonymous namespace
# does not appear as a field of the class. There is a difference between the
# debug info generated by gcc and clang, where clang flags the static member
# with DW_AT_external, but gcc does not.
#
# Roughly corresponds to this source code:
#
# namespace {
# struct U {
#   static int s;
#   int m = 14159265;
# };
# int U::s = 65295141;
# }
#
# U ug;

        .file   "test.cpp"
        .data
        .quad 0
ug:
        .long 14159265
.Lug_s:
        .long 65295141

        .section        .debug_info,"",@progbits
.Ldebug_info0:
        .long   .Lcu_end-.Lcu_begin
.Lcu_begin:
        .value  0x4
        .long   .Ldebug_abbrev0
        .byte   0x8
        .uleb128 0x1
        .asciz  "GCC DWARF reduced by hand"
        .byte   0x4
        .asciz  "test.cpp"
        .uleb128 0x2
.LU:
        .uleb128 0x3
        .string "U"
        .byte   0x4
.LU_s:
        .uleb128 0x4
        .string "s"
        .long   .Lint-.Ldebug_info0
        .uleb128 0x5
        .string "m"
        .long   .Lint-.Ldebug_info0
        .byte   0
        .byte   0
        .byte   0
        .uleb128 0x6
        .long   0x2d
.Lint:
        .uleb128 0x7
        .byte   0x4
        .byte   0x5
        .string "int"
        .uleb128 0x9
        .string "ug"
        .long   .LU-.Ldebug_info0
        .uleb128 0x9
        .byte   0x3
        .quad   ug
        .uleb128 0xa
        .long   .LU_s-.Ldebug_info0
        .uleb128 0x9
        .byte   0x3
        .quad .Lug_s
        .byte   0
.Lcu_end:
        .section        .debug_abbrev,"",@progbits
.Ldebug_abbrev0:
        .uleb128 0x1
        .uleb128 0x11
        .byte   0x1
        .uleb128 0x25
        .uleb128 0x8
        .uleb128 0x13
        .uleb128 0xb
        .uleb128 0x3
        .uleb128 0x8
        .byte   0
        .byte   0
        .uleb128 0x2
        .uleb128 0x39
        .byte   0x1
        .byte   0
        .byte   0
        .uleb128 0x3
        .uleb128 0x13
        .byte   0x1
        .uleb128 0x3
        .uleb128 0x8
        .uleb128 0xb
        .uleb128 0xb
        .byte   0
        .byte   0
        .uleb128 0x4
        .uleb128 0xd
        .byte   0
        .uleb128 0x3
        .uleb128 0x8
        .uleb128 0x49
        .uleb128 0x13
        .uleb128 0x3c
        .uleb128 0x19
        .byte   0
        .byte   0
        .uleb128 0x5
        .uleb128 0xd
        .byte   0
        .uleb128 0x3
        .uleb128 0x8
        .uleb128 0x49
        .uleb128 0x13
        .uleb128 0x38
        .uleb128 0xb
        .byte   0
        .byte   0
        .uleb128 0x6
        .uleb128 0x3a
        .byte   0
        .uleb128 0x18
        .uleb128 0x13
        .byte   0
        .byte   0
        .uleb128 0x7
        .uleb128 0x24
        .byte   0
        .uleb128 0xb
        .uleb128 0xb
        .uleb128 0x3e
        .uleb128 0xb
        .uleb128 0x3
        .uleb128 0x8
        .byte   0
        .byte   0
        .uleb128 0x8
        .uleb128 0x26
        .byte   0
        .uleb128 0x49
        .uleb128 0x13
        .byte   0
        .byte   0
        .uleb128 0x9
        .uleb128 0x34
        .byte   0
        .uleb128 0x3
        .uleb128 0x8
        .uleb128 0x49
        .uleb128 0x13
        .uleb128 0x2
        .uleb128 0x18
        .byte   0
        .byte   0
	.uleb128 0xa
	.uleb128 0x34
	.byte	0
	.uleb128 0x47
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x18
	.byte	0
	.byte	0
        .byte   0
