; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -mtriple=x86_64-unknown-unknown -mattr=+amx-int8 -mattr=+avx512f -pre-amx-config -S | FileCheck %s

@buf = dso_local global [1024 x i8] zeroinitializer, align 16
@buf2 = dso_local global [1024 x i8] zeroinitializer, align 16

define dso_local void @test_api(i32 %cond, i16 signext %row, i16 signext %col) local_unnamed_addr {
; CHECK-LABEL: @test_api(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP0:%.*]] = alloca <16 x i32>, align 4
; CHECK-NEXT:    [[TMP1:%.*]] = alloca <16 x i32>, align 4
; CHECK-NEXT:    [[TMP2:%.*]] = alloca <16 x i32>, align 4
; CHECK-NEXT:    [[TMP3:%.*]] = alloca <16 x i32>, align 4
; CHECK-NEXT:    [[TMP4:%.*]] = alloca <16 x i32>, align 4
; CHECK-NEXT:    [[TMP5:%.*]] = alloca <16 x i32>, align 4
; CHECK-NEXT:    [[TMP6:%.*]] = alloca <16 x i32>, align 4
; CHECK-NEXT:    [[TMP7:%.*]] = alloca <16 x i32>, align 4
; CHECK-NEXT:    [[I:%.*]] = alloca <256 x i32>, align 1024
; CHECK-NEXT:    [[I2:%.*]] = alloca <256 x i32>, align 1024
; CHECK-NEXT:    [[I4:%.*]] = alloca <256 x i32>, align 1024
; CHECK-NEXT:    [[I6:%.*]] = alloca <256 x i32>, align 1024
; CHECK-NEXT:    [[TOBOOL_NOT:%.*]] = icmp eq i32 [[COND:%.*]], 0
; CHECK-NEXT:    br i1 [[TOBOOL_NOT]], label [[IF_ELSE:%.*]], label [[IF_THEN:%.*]]
; CHECK:       if.then:
; CHECK-NEXT:    store <16 x i32> zeroinitializer, ptr [[TMP7]], align 4
; CHECK-NEXT:    [[TMP8:%.*]] = getelementptr i8, ptr [[TMP7]], i64 0
; CHECK-NEXT:    store i8 1, ptr [[TMP8]], align 1
; CHECK-NEXT:    [[AMX_TMM_0_SHAPE_ROW:%.*]] = getelementptr i8, ptr [[TMP7]], i64 48
; CHECK-NEXT:    [[TMP9:%.*]] = getelementptr i8, ptr [[TMP7]], i64 16
; CHECK-NEXT:    [[TMP10:%.*]] = trunc i16 [[ROW:%.*]] to i8
; CHECK-NEXT:    store i8 [[TMP10]], ptr [[AMX_TMM_0_SHAPE_ROW]], align 1
; CHECK-NEXT:    store i16 8, ptr [[TMP9]], align 2
; CHECK-NEXT:    call void @llvm.x86.ldtilecfg.internal(ptr [[TMP7]])
; CHECK-NEXT:    [[I8:%.*]] = tail call x86_amx @llvm.x86.tileloadd64.internal(i16 [[ROW]], i16 8, ptr @buf, i64 32)
; CHECK-NEXT:    call void @llvm.x86.tilestored64.internal(i16 [[ROW]], i16 8, ptr [[I4]], i64 64, x86_amx [[I8]])
; CHECK-NEXT:    store <16 x i32> zeroinitializer, ptr [[TMP6]], align 4
; CHECK-NEXT:    [[TMP11:%.*]] = getelementptr i8, ptr [[TMP6]], i64 0
; CHECK-NEXT:    store i8 1, ptr [[TMP11]], align 1
; CHECK-NEXT:    [[AMX_TMM_0_SHAPE_ROW1:%.*]] = getelementptr i8, ptr [[TMP6]], i64 48
; CHECK-NEXT:    [[TMP12:%.*]] = getelementptr i8, ptr [[TMP6]], i64 16
; CHECK-NEXT:    store i8 8, ptr [[AMX_TMM_0_SHAPE_ROW1]], align 1
; CHECK-NEXT:    store i16 [[COL:%.*]], ptr [[TMP12]], align 2
; CHECK-NEXT:    call void @llvm.x86.ldtilecfg.internal(ptr [[TMP6]])
; CHECK-NEXT:    [[I9:%.*]] = tail call x86_amx @llvm.x86.tileloadd64.internal(i16 8, i16 [[COL]], ptr @buf, i64 32)
; CHECK-NEXT:    call void @llvm.x86.tilestored64.internal(i16 8, i16 [[COL]], ptr [[I2]], i64 64, x86_amx [[I9]])
; CHECK-NEXT:    store <16 x i32> zeroinitializer, ptr [[TMP5]], align 4
; CHECK-NEXT:    [[TMP13:%.*]] = getelementptr i8, ptr [[TMP5]], i64 0
; CHECK-NEXT:    store i8 1, ptr [[TMP13]], align 1
; CHECK-NEXT:    [[AMX_TMM_0_SHAPE_ROW2:%.*]] = getelementptr i8, ptr [[TMP5]], i64 48
; CHECK-NEXT:    [[TMP14:%.*]] = getelementptr i8, ptr [[TMP5]], i64 16
; CHECK-NEXT:    [[TMP15:%.*]] = trunc i16 [[ROW]] to i8
; CHECK-NEXT:    store i8 [[TMP15]], ptr [[AMX_TMM_0_SHAPE_ROW2]], align 1
; CHECK-NEXT:    store i16 [[COL]], ptr [[TMP14]], align 2
; CHECK-NEXT:    call void @llvm.x86.ldtilecfg.internal(ptr [[TMP5]])
; CHECK-NEXT:    [[I10:%.*]] = tail call x86_amx @llvm.x86.tileloadd64.internal(i16 [[ROW]], i16 [[COL]], ptr @buf, i64 32)
; CHECK-NEXT:    call void @llvm.x86.tilestored64.internal(i16 [[ROW]], i16 [[COL]], ptr [[I]], i64 64, x86_amx [[I10]])
; CHECK-NEXT:    br label [[IF_END:%.*]]
; CHECK:       if.else:
; CHECK-NEXT:    store <16 x i32> zeroinitializer, ptr [[TMP4]], align 4
; CHECK-NEXT:    [[TMP16:%.*]] = getelementptr i8, ptr [[TMP4]], i64 0
; CHECK-NEXT:    store i8 1, ptr [[TMP16]], align 1
; CHECK-NEXT:    [[AMX_TMM_0_SHAPE_ROW3:%.*]] = getelementptr i8, ptr [[TMP4]], i64 48
; CHECK-NEXT:    [[TMP17:%.*]] = getelementptr i8, ptr [[TMP4]], i64 16
; CHECK-NEXT:    [[TMP18:%.*]] = trunc i16 [[ROW]] to i8
; CHECK-NEXT:    store i8 [[TMP18]], ptr [[AMX_TMM_0_SHAPE_ROW3]], align 1
; CHECK-NEXT:    store i16 8, ptr [[TMP17]], align 2
; CHECK-NEXT:    call void @llvm.x86.ldtilecfg.internal(ptr [[TMP4]])
; CHECK-NEXT:    [[I11:%.*]] = tail call x86_amx @llvm.x86.tileloadd64.internal(i16 [[ROW]], i16 8, ptr @buf2, i64 32)
; CHECK-NEXT:    call void @llvm.x86.tilestored64.internal(i16 [[ROW]], i16 8, ptr [[I4]], i64 64, x86_amx [[I11]])
; CHECK-NEXT:    store <16 x i32> zeroinitializer, ptr [[TMP3]], align 4
; CHECK-NEXT:    [[TMP19:%.*]] = getelementptr i8, ptr [[TMP3]], i64 0
; CHECK-NEXT:    store i8 1, ptr [[TMP19]], align 1
; CHECK-NEXT:    [[AMX_TMM_0_SHAPE_ROW4:%.*]] = getelementptr i8, ptr [[TMP3]], i64 48
; CHECK-NEXT:    [[TMP20:%.*]] = getelementptr i8, ptr [[TMP3]], i64 16
; CHECK-NEXT:    store i8 8, ptr [[AMX_TMM_0_SHAPE_ROW4]], align 1
; CHECK-NEXT:    store i16 [[COL]], ptr [[TMP20]], align 2
; CHECK-NEXT:    call void @llvm.x86.ldtilecfg.internal(ptr [[TMP3]])
; CHECK-NEXT:    [[I12:%.*]] = tail call x86_amx @llvm.x86.tileloadd64.internal(i16 8, i16 [[COL]], ptr @buf2, i64 32)
; CHECK-NEXT:    call void @llvm.x86.tilestored64.internal(i16 8, i16 [[COL]], ptr [[I2]], i64 64, x86_amx [[I12]])
; CHECK-NEXT:    store <16 x i32> zeroinitializer, ptr [[TMP2]], align 4
; CHECK-NEXT:    [[TMP21:%.*]] = getelementptr i8, ptr [[TMP2]], i64 0
; CHECK-NEXT:    store i8 1, ptr [[TMP21]], align 1
; CHECK-NEXT:    [[AMX_TMM_0_SHAPE_ROW5:%.*]] = getelementptr i8, ptr [[TMP2]], i64 48
; CHECK-NEXT:    [[TMP22:%.*]] = getelementptr i8, ptr [[TMP2]], i64 16
; CHECK-NEXT:    [[TMP23:%.*]] = trunc i16 [[ROW]] to i8
; CHECK-NEXT:    store i8 [[TMP23]], ptr [[AMX_TMM_0_SHAPE_ROW5]], align 1
; CHECK-NEXT:    store i16 [[COL]], ptr [[TMP22]], align 2
; CHECK-NEXT:    call void @llvm.x86.ldtilecfg.internal(ptr [[TMP2]])
; CHECK-NEXT:    [[I13:%.*]] = tail call x86_amx @llvm.x86.tileloadd64.internal(i16 [[ROW]], i16 [[COL]], ptr @buf2, i64 32)
; CHECK-NEXT:    call void @llvm.x86.tilestored64.internal(i16 [[ROW]], i16 [[COL]], ptr [[I]], i64 64, x86_amx [[I13]])
; CHECK-NEXT:    br label [[IF_END]]
; CHECK:       if.end:
; CHECK-NEXT:    store <16 x i32> zeroinitializer, ptr [[TMP1]], align 4
; CHECK-NEXT:    [[TMP24:%.*]] = getelementptr i8, ptr [[TMP1]], i64 0
; CHECK-NEXT:    store i8 1, ptr [[TMP24]], align 1
; CHECK-NEXT:    [[AMX_TMM_0_SHAPE_ROW6:%.*]] = getelementptr i8, ptr [[TMP1]], i64 48
; CHECK-NEXT:    [[TMP25:%.*]] = getelementptr i8, ptr [[TMP1]], i64 16
; CHECK-NEXT:    [[TMP26:%.*]] = trunc i16 [[ROW]] to i8
; CHECK-NEXT:    store i8 [[TMP26]], ptr [[AMX_TMM_0_SHAPE_ROW6]], align 1
; CHECK-NEXT:    store i16 [[COL]], ptr [[TMP25]], align 2
; CHECK-NEXT:    [[AMX_TMM_1_SHAPE_ROW:%.*]] = getelementptr i8, ptr [[TMP1]], i64 49
; CHECK-NEXT:    [[TMP27:%.*]] = getelementptr i8, ptr [[TMP1]], i64 18
; CHECK-NEXT:    [[TMP28:%.*]] = trunc i16 [[ROW]] to i8
; CHECK-NEXT:    store i8 [[TMP28]], ptr [[AMX_TMM_1_SHAPE_ROW]], align 1
; CHECK-NEXT:    store i16 8, ptr [[TMP27]], align 2
; CHECK-NEXT:    [[AMX_TMM_2_SHAPE_ROW:%.*]] = getelementptr i8, ptr [[TMP1]], i64 50
; CHECK-NEXT:    [[TMP29:%.*]] = getelementptr i8, ptr [[TMP1]], i64 20
; CHECK-NEXT:    store i8 8, ptr [[AMX_TMM_2_SHAPE_ROW]], align 1
; CHECK-NEXT:    store i16 [[COL]], ptr [[TMP29]], align 2
; CHECK-NEXT:    [[AMX_TMM_3_SHAPE_ROW:%.*]] = getelementptr i8, ptr [[TMP1]], i64 51
; CHECK-NEXT:    [[TMP30:%.*]] = getelementptr i8, ptr [[TMP1]], i64 22
; CHECK-NEXT:    [[TMP31:%.*]] = trunc i16 [[ROW]] to i8
; CHECK-NEXT:    store i8 [[TMP31]], ptr [[AMX_TMM_3_SHAPE_ROW]], align 1
; CHECK-NEXT:    store i16 [[COL]], ptr [[TMP30]], align 2
; CHECK-NEXT:    call void @llvm.x86.ldtilecfg.internal(ptr [[TMP1]])
; CHECK-NEXT:    [[I14:%.*]] = call x86_amx @llvm.x86.tileloadd64.internal(i16 [[ROW]], i16 8, ptr [[I4]], i64 64)
; CHECK-NEXT:    [[I15:%.*]] = call x86_amx @llvm.x86.tileloadd64.internal(i16 8, i16 [[COL]], ptr [[I2]], i64 64)
; CHECK-NEXT:    [[I16:%.*]] = call x86_amx @llvm.x86.tileloadd64.internal(i16 [[ROW]], i16 [[COL]], ptr [[I]], i64 64)
; CHECK-NEXT:    [[I17:%.*]] = tail call x86_amx @llvm.x86.tdpbssd.internal(i16 [[ROW]], i16 [[COL]], i16 8, x86_amx [[I16]], x86_amx [[I14]], x86_amx [[I15]])
; CHECK-NEXT:    call void @llvm.x86.tilestored64.internal(i16 [[ROW]], i16 [[COL]], ptr [[I6]], i64 64, x86_amx [[I17]])
; CHECK-NEXT:    store <16 x i32> zeroinitializer, ptr [[TMP0]], align 4
; CHECK-NEXT:    [[TMP32:%.*]] = getelementptr i8, ptr [[TMP0]], i64 0
; CHECK-NEXT:    store i8 1, ptr [[TMP32]], align 1
; CHECK-NEXT:    [[AMX_TMM_0_SHAPE_ROW7:%.*]] = getelementptr i8, ptr [[TMP0]], i64 48
; CHECK-NEXT:    [[TMP33:%.*]] = getelementptr i8, ptr [[TMP0]], i64 16
; CHECK-NEXT:    [[TMP34:%.*]] = trunc i16 [[ROW]] to i8
; CHECK-NEXT:    store i8 [[TMP34]], ptr [[AMX_TMM_0_SHAPE_ROW7]], align 1
; CHECK-NEXT:    store i16 [[COL]], ptr [[TMP33]], align 2
; CHECK-NEXT:    call void @llvm.x86.ldtilecfg.internal(ptr [[TMP0]])
; CHECK-NEXT:    [[I18:%.*]] = call x86_amx @llvm.x86.tileloadd64.internal(i16 [[ROW]], i16 [[COL]], ptr [[I6]], i64 64)
; CHECK-NEXT:    tail call void @llvm.x86.tilestored64.internal(i16 [[ROW]], i16 [[COL]], ptr @buf, i64 32, x86_amx [[I18]])
; CHECK-NEXT:    ret void
;
entry:
  %i = alloca <256 x i32>, align 1024
  %i2 = alloca <256 x i32>, align 1024
  %i4 = alloca <256 x i32>, align 1024
  %i6 = alloca <256 x i32>, align 1024
  %tobool.not = icmp eq i32 %cond, 0
  br i1 %tobool.not, label %if.else, label %if.then

if.then:                                          ; preds = %entry
  %i8 = tail call x86_amx @llvm.x86.tileloadd64.internal(i16 %row, i16 8, ptr @buf, i64 32)
  call void @llvm.x86.tilestored64.internal(i16 %row, i16 8, ptr %i4, i64 64, x86_amx %i8)
  %i9 = tail call x86_amx @llvm.x86.tileloadd64.internal(i16 8, i16 %col, ptr @buf, i64 32)
  call void @llvm.x86.tilestored64.internal(i16 8, i16 %col, ptr %i2, i64 64, x86_amx %i9)
  %i10 = tail call x86_amx @llvm.x86.tileloadd64.internal(i16 %row, i16 %col, ptr @buf, i64 32)
  call void @llvm.x86.tilestored64.internal(i16 %row, i16 %col, ptr %i, i64 64, x86_amx %i10)
  br label %if.end

if.else:                                          ; preds = %entry
  %i11 = tail call x86_amx @llvm.x86.tileloadd64.internal(i16 %row, i16 8, ptr @buf2, i64 32)
  call void @llvm.x86.tilestored64.internal(i16 %row, i16 8, ptr %i4, i64 64, x86_amx %i11)
  %i12 = tail call x86_amx @llvm.x86.tileloadd64.internal(i16 8, i16 %col, ptr @buf2, i64 32)
  call void @llvm.x86.tilestored64.internal(i16 8, i16 %col, ptr %i2, i64 64, x86_amx %i12)
  %i13 = tail call x86_amx @llvm.x86.tileloadd64.internal(i16 %row, i16 %col, ptr @buf2, i64 32)
  call void @llvm.x86.tilestored64.internal(i16 %row, i16 %col, ptr %i, i64 64, x86_amx %i13)
  br label %if.end

if.end:                                           ; preds = %if.else, %if.then
  %i14 = call x86_amx @llvm.x86.tileloadd64.internal(i16 %row, i16 8, ptr %i4, i64 64)
  %i15 = call x86_amx @llvm.x86.tileloadd64.internal(i16 8, i16 %col, ptr %i2, i64 64)
  %i16 = call x86_amx @llvm.x86.tileloadd64.internal(i16 %row, i16 %col, ptr %i, i64 64)
  %i17 = tail call x86_amx @llvm.x86.tdpbssd.internal(i16 %row, i16 %col, i16 8, x86_amx %i16, x86_amx %i14, x86_amx %i15)
  call void @llvm.x86.tilestored64.internal(i16 %row, i16 %col, ptr %i6, i64 64, x86_amx %i17)
  %i18 = call x86_amx @llvm.x86.tileloadd64.internal(i16 %row, i16 %col, ptr %i6, i64 64)
  tail call void @llvm.x86.tilestored64.internal(i16 %row, i16 %col, ptr @buf, i64 32, x86_amx %i18)
  ret void
}

; Function Attrs: nounwind
declare x86_amx @llvm.x86.tileloadd64.internal(i16, i16, ptr, i64)

; Function Attrs: nounwind
declare x86_amx @llvm.x86.tdpbssd.internal(i16, i16, i16, x86_amx, x86_amx, x86_amx)

; Function Attrs: nounwind
declare void @llvm.x86.tilestored64.internal(i16, i16, ptr, i64, x86_amx)
