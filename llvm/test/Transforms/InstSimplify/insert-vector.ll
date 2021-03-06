; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -passes=instsimplify -S | FileCheck %s

define <vscale x 16 x i8> @redundant_extract_insert_chain(<vscale x 16 x i8> %x) {
; CHECK-LABEL: @redundant_extract_insert_chain(
; CHECK-NEXT:    ret <vscale x 16 x i8> [[X:%.*]]
;
  %extracted = call <32 x i8> @llvm.vector.extract.v32i8.nxv16i8(<vscale x 16 x i8> %x, i64 0)
  %inserted = call <vscale x 16 x i8> @llvm.vector.insert.nxv16i8.v32i8(<vscale x 16 x i8> undef, <32 x i8> %extracted, i64 0)
  ret <vscale x 16 x i8> %inserted
}

define <vscale x 16 x i8> @non_redundant_extract_insert_chain_0(<vscale x 32 x i8> %x) {
; CHECK-LABEL: @non_redundant_extract_insert_chain_0(
; CHECK-NEXT:    [[EXTRACTED:%.*]] = call <32 x i8> @llvm.vector.extract.v32i8.nxv32i8(<vscale x 32 x i8> [[X:%.*]], i64 0)
; CHECK-NEXT:    [[INSERTED:%.*]] = call <vscale x 16 x i8> @llvm.vector.insert.nxv16i8.v32i8(<vscale x 16 x i8> undef, <32 x i8> [[EXTRACTED]], i64 0)
; CHECK-NEXT:    ret <vscale x 16 x i8> [[INSERTED]]
;
  %extracted = call <32 x i8> @llvm.vector.extract.v32i8.nxv32i8(<vscale x 32 x i8> %x, i64 0)
  %inserted = call <vscale x 16 x i8> @llvm.vector.insert.nxv16i8.v32i8(<vscale x 16 x i8> undef, <32 x i8> %extracted, i64 0)
  ret <vscale x 16 x i8> %inserted
}

define <vscale x 16 x i8> @non_redundant_extract_insert_chain_1(<vscale x 16 x i8> %x, <vscale x 16 x i8> %y) {
; CHECK-LABEL: @non_redundant_extract_insert_chain_1(
; CHECK-NEXT:    [[EXTRACTED:%.*]] = call <32 x i8> @llvm.vector.extract.v32i8.nxv16i8(<vscale x 16 x i8> [[X:%.*]], i64 0)
; CHECK-NEXT:    [[INSERTED:%.*]] = call <vscale x 16 x i8> @llvm.vector.insert.nxv16i8.v32i8(<vscale x 16 x i8> [[Y:%.*]], <32 x i8> [[EXTRACTED]], i64 0)
; CHECK-NEXT:    ret <vscale x 16 x i8> [[INSERTED]]
;
  %extracted = call <32 x i8> @llvm.vector.extract.v32i8.nxv16i8(<vscale x 16 x i8> %x, i64 0)
  %inserted = call <vscale x 16 x i8> @llvm.vector.insert.nxv16i8.v32i8(<vscale x 16 x i8> %y, <32 x i8> %extracted, i64 0)
  ret <vscale x 16 x i8> %inserted
}

declare <32 x i8> @llvm.vector.extract.v32i8.nxv16i8(<vscale x 16 x i8>, i64)
declare <32 x i8> @llvm.vector.extract.v32i8.nxv32i8(<vscale x 32 x i8>, i64)
declare <vscale x 16 x i8> @llvm.vector.insert.nxv16i8.v32i8(<vscale x 16 x i8>, <32 x i8>, i64)
