; RUN: llc < %s -mtriple=ve-unknown-unknown | FileCheck %s

; Function Attrs: nounwind
define void @test(i64 %offset, float* %p) {
; CHECK-LABEL: test
; CHECK: .LBB0_2
; CHECK:        pfchv %s0,%s1
entry:
  %0 = bitcast float* %p to i8*
  tail call void @llvm.ve.pfchv(i64 %offset, i8* %0)
  ret void
}

; Function Attrs: nounwind
declare void @llvm.ve.pfchv(i64, i8*)

