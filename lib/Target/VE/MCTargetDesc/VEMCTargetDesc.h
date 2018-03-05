//===-- VEMCTargetDesc.h - VE Target Descriptions ---------------*- C++ -*-===//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//
//
// This file provides VE specific target descriptions.
//
//===----------------------------------------------------------------------===//

#ifndef LLVM_LIB_TARGET_VE_MCTARGETDESC_VEMCTARGETDESC_H
#define LLVM_LIB_TARGET_VE_MCTARGETDESC_VEMCTARGETDESC_H

#include "llvm/Support/DataTypes.h"

#include <memory>

namespace llvm {
class MCAsmBackend;
class MCCodeEmitter;
class MCContext;
class MCInstrInfo;
class MCObjectWriter;
class MCRegisterInfo;
class MCSubtargetInfo;
class MCTargetOptions;
class Target;
class Triple;
class StringRef;
class raw_pwrite_stream;
class raw_ostream;

Target &getTheVETarget();

#if 0
MCCodeEmitter *createVEMCCodeEmitter(const MCInstrInfo &MCII,
                                        const MCRegisterInfo &MRI,
                                        MCContext &Ctx);
MCAsmBackend *createVEAsmBackend(const Target &T, const MCSubtargetInfo &STI,
                                    const MCRegisterInfo &MRI,
                                    const MCTargetOptions &Options);
std::unique_ptr<MCObjectWriter>
createVEELFObjectWriter(raw_pwrite_stream &OS, bool Is64Bit,
                           bool IsLIttleEndian, uint8_t OSABI);
#endif
} // End llvm namespace

// Defines symbolic names for VE registers.  This defines a mapping from
// register name to register number.
//
#define GET_REGINFO_ENUM
#include "VEGenRegisterInfo.inc"

// Defines symbolic names for the VE instructions.
//
#define GET_INSTRINFO_ENUM
#include "VEGenInstrInfo.inc"

#define GET_SUBTARGETINFO_ENUM
#include "VEGenSubtargetInfo.inc"

#endif
