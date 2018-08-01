; RUN: llc < %s -mtriple=ve-unknown-unknown | FileCheck %s

define dso_local signext i8 @func1(i8 signext, i8 signext) local_unnamed_addr #0 {
; CHECK-LABEL: func1:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    sra.w.sx %s0, %s0, %s1
  %3 = sext i8 %0 to i32
  %4 = sext i8 %1 to i32
  %5 = ashr i32 %3, %4
  %6 = trunc i32 %5 to i8
  ret i8 %6
}

define dso_local signext i16 @func2(i16 signext, i16 signext) local_unnamed_addr #0 {
; CHECK-LABEL: func2:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    sra.w.sx %s0, %s0, %s1
  %3 = sext i16 %0 to i32
  %4 = sext i16 %1 to i32
  %5 = ashr i32 %3, %4
  %6 = trunc i32 %5 to i16
  ret i16 %6
}

define dso_local i32 @func3(i32, i32) local_unnamed_addr #0 {
; CHECK-LABEL: func3:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    sra.w.sx %s0, %s0, %s1
  %3 = ashr i32 %0, %1
  ret i32 %3
}

define dso_local i64 @func4(i64, i64) local_unnamed_addr #0 {
; CHECK-LABEL: func4:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    adds.w.sx %s34, %s1, (0)1
; CHECK-NEXT:    sra.l %s0, %s0, %s34
  %3 = ashr i64 %0, %1
  ret i64 %3
}

define dso_local zeroext i8 @func5(i8 zeroext, i8 zeroext) local_unnamed_addr #0 {
; CHECK-LABEL: func5:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    # kill: def $sw0 killed $sw0 def $sx0
; CHECK-NEXT:    and %s34, %s0, (32)0
; CHECK-NEXT:    srl %s34, %s34, %s1
; CHECK-NEXT:    and %s0, %s34, (56)0
  %3 = zext i8 %0 to i32
  %4 = zext i8 %1 to i32
  %5 = lshr i32 %3, %4
  %6 = trunc i32 %5 to i8
  ret i8 %6
}

define dso_local zeroext i16 @func6(i16 zeroext, i16 zeroext) local_unnamed_addr #0 {
; CHECK-LABEL: func6:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    # kill: def $sw0 killed $sw0 def $sx0
; CHECK-NEXT:    and %s34, %s0, (32)0
; CHECK-NEXT:    srl %s34, %s34, %s1
; CHECK-NEXT:    and %s0, %s34, (48)0
  %3 = zext i16 %0 to i32
  %4 = zext i16 %1 to i32
  %5 = lshr i32 %3, %4
  %6 = trunc i32 %5 to i16
  ret i16 %6
}

define dso_local i32 @func7(i32, i32) local_unnamed_addr #0 {
; CHECK-LABEL: func7:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    # kill: def $sw0 killed $sw0 def $sx0
; CHECK-NEXT:    and %s34, %s0, (32)0
; CHECK-NEXT:    srl %s0, %s34, %s1
; CHECK-NEXT:    # kill: def $sw0 killed $sw0 killed $sx0
  %3 = lshr i32 %0, %1
  ret i32 %3
}

define dso_local i64 @func8(i64, i64) local_unnamed_addr #0 {
; CHECK-LABEL: func8:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    adds.w.sx %s34, %s1, (0)1
; CHECK-NEXT:    srl %s0, %s0, %s34
  %3 = lshr i64 %0, %1
  ret i64 %3
}

define dso_local signext i8 @func9(i8 signext) local_unnamed_addr #0 {
; CHECK-LABEL: func9:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    sra.w.sx %s0, %s0, 5
  %2 = ashr i8 %0, 5
  ret i8 %2
}

define dso_local signext i16 @func10(i16 signext) local_unnamed_addr #0 {
; CHECK-LABEL: func10:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    sra.w.sx %s0, %s0, 5
  %2 = ashr i16 %0, 5
  ret i16 %2
}

define dso_local i32 @func11(i32) local_unnamed_addr #0 {
; CHECK-LABEL: func11:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    sra.w.sx %s0, %s0, 5
  %2 = ashr i32 %0, 5
  ret i32 %2
}

define dso_local i64 @func12(i64) local_unnamed_addr #0 {
; CHECK-LABEL: func12:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    sra.l %s0, %s0, 5
  %2 = ashr i64 %0, 5
  ret i64 %2
}

define dso_local zeroext i8 @func13(i8 zeroext) local_unnamed_addr #0 {
; CHECK-LABEL: func13:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    # kill: def $sw0 killed $sw0 def $sx0
; CHECK-NEXT:    and %s34, %s0, (32)0
; CHECK-NEXT:    srl %s0, %s34, 5
; CHECK-NEXT:    # kill: def $sw0 killed $sw0 killed $sx0
  %2 = lshr i8 %0, 5
  ret i8 %2
}

define dso_local zeroext i16 @func14(i16 zeroext) local_unnamed_addr #0 {
; CHECK-LABEL: func14:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    # kill: def $sw0 killed $sw0 def $sx0
; CHECK-NEXT:    and %s34, %s0, (32)0
; CHECK-NEXT:    srl %s0, %s34, 5
; CHECK-NEXT:    # kill: def $sw0 killed $sw0 killed $sx0
  %2 = lshr i16 %0, 5
  ret i16 %2
}

define dso_local i32 @func15(i32) local_unnamed_addr #0 {
; CHECK-LABEL: func15:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    # kill: def $sw0 killed $sw0 def $sx0
; CHECK-NEXT:    and %s34, %s0, (32)0
; CHECK-NEXT:    srl %s0, %s34, 5
; CHECK-NEXT:    # kill: def $sw0 killed $sw0 killed $sx0
  %2 = lshr i32 %0, 5
  ret i32 %2
}

define dso_local i64 @func16(i64) local_unnamed_addr #0 {
; CHECK-LABEL: func16:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    srl %s0, %s0, 5
  %2 = lshr i64 %0, 5
  ret i64 %2
}
