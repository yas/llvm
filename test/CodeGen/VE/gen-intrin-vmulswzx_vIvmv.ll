; RUN: llc < %s -mtriple=ve-unknown-unknown | FileCheck %s

; Function Attrs: nounwind
define void @vmulswzx_vIvmv(i32* %pvx, i32* %pvz, i32* %pvm, i32* nocapture readnone %pvd, i32 %n) {
; CHECK-LABEL: vmulswzx_vIvmv
; CHECK: .LBB0_2
; CHECK: 	vmuls.w.zx %v2,3,%v0,%vm1
entry:
  %cmp21 = icmp sgt i32 %n, 0
  br i1 %cmp21, label %for.body, label %for.cond.cleanup

for.cond.cleanup:                                 ; preds = %for.body, %entry
  ret void

for.body:                                         ; preds = %entry, %for.body
  %pvx.addr.025 = phi i32* [ %add.ptr, %for.body ], [ %pvx, %entry ]
  %pvz.addr.024 = phi i32* [ %add.ptr3, %for.body ], [ %pvz, %entry ]
  %pvm.addr.023 = phi i32* [ %add.ptr4, %for.body ], [ %pvm, %entry ]
  %i.022 = phi i32 [ %add, %for.body ], [ 0, %entry ]
  %sub = sub nsw i32 %n, %i.022
  %cmp1 = icmp slt i32 %sub, 256
  %spec.select = select i1 %cmp1, i32 %sub, i32 256
  tail call void @llvm.ve.lvl(i32 %spec.select)
  %0 = bitcast i32* %pvz.addr.024 to i8*
  %1 = tail call <256 x double> @llvm.ve.vldlsx.vss(i64 4, i8* %0)
  %2 = bitcast i32* %pvm.addr.023 to i8*
  %3 = tail call <256 x double> @llvm.ve.vldlzx.vss(i64 4, i8* %2)
  %4 = tail call <4 x i64> @llvm.ve.vfmkw.mcv(i32 7, <256 x double> %3)
  %5 = bitcast i32* %pvx.addr.025 to i8*
  %6 = tail call <256 x double> @llvm.ve.vldlsx.vss(i64 4, i8* %5)
  %7 = tail call <256 x double> @llvm.ve.vmulswzx.vsvmv(i32 3, <256 x double> %1, <4 x i64> %4, <256 x double> %6)
  tail call void @llvm.ve.vstl.vss(<256 x double> %7, i64 4, i8* %5)
  %add.ptr = getelementptr inbounds i32, i32* %pvx.addr.025, i64 256
  %add.ptr3 = getelementptr inbounds i32, i32* %pvz.addr.024, i64 256
  %add.ptr4 = getelementptr inbounds i32, i32* %pvm.addr.023, i64 256
  %add = add nuw nsw i32 %i.022, 256
  %cmp = icmp slt i32 %add, %n
  br i1 %cmp, label %for.body, label %for.cond.cleanup
}

; Function Attrs: nounwind
declare void @llvm.ve.lvl(i32)

; Function Attrs: nounwind readonly
declare <256 x double> @llvm.ve.vldlsx.vss(i64, i8*)

; Function Attrs: nounwind readonly
declare <256 x double> @llvm.ve.vldlzx.vss(i64, i8*)

; Function Attrs: nounwind readnone
declare <4 x i64> @llvm.ve.vfmkw.mcv(i32, <256 x double>)

; Function Attrs: nounwind readnone
declare <256 x double> @llvm.ve.vmulswzx.vsvmv(i32, <256 x double>, <4 x i64>, <256 x double>)

; Function Attrs: nounwind writeonly
declare void @llvm.ve.vstl.vss(<256 x double>, i64, i8*)

