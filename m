Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91A1049AA3D
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jan 2022 05:36:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385074AbiAYDfh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 24 Jan 2022 22:35:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S3420558AbiAYCYt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 24 Jan 2022 21:24:49 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A48BC08B4DE
        for <linux-kselftest@vger.kernel.org>; Mon, 24 Jan 2022 16:15:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2B82D61496
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Jan 2022 00:15:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F7DFC340E7;
        Tue, 25 Jan 2022 00:15:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643069738;
        bh=LILDRv5nj5WSygqoRB1U9j0mnm4jU4VyQjP7vWy8K4A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ca7SkpFECarkq2rmclc+2E/1XCEib/nmbn4ytdimrcx7dVAjTfBEUaWcZrvWNqiyp
         QqyR1PdQC89thBWCQ4CMHHpiI1xEUILGbo+1wxZkYTott20sdqivlkeJdT3F8RjaD4
         yuwI6mSRON6VuaEqfmQ2v5IyMSaEZ56oBt7Jka/A4q58n6jAoj3oUr/3+LekFzjQVy
         rk1bGIaivrle0sItv2Qggci0VumGJ2oyMvjZFsSMI80Nc6AJWx5KfA7u23RlEc956c
         dOI0KVFUIM8Ifeot3pfvlGr1pb5x/OIimzU6UHhvg5IC+5hgDMiuJPKr/RWgRDJbsp
         z4Gd3X1aRF7aA==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     Alan Hayward <alan.hayward@arm.com>,
        Luis Machado <luis.machado@arm.com>,
        Salil Akerkar <Salil.Akerkar@arm.com>,
        Basant Kumar Dwivedi <Basant.KumarDwivedi@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, kvmarm@lists.cs.columbia.edu,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH v8 04/38] arm64/sme: Provide ABI documentation for SME
Date:   Tue, 25 Jan 2022 00:10:40 +0000
Message-Id: <20220125001114.193425-5-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220125001114.193425-1-broonie@kernel.org>
References: <20220125001114.193425-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=25779; h=from:subject; bh=LILDRv5nj5WSygqoRB1U9j0mnm4jU4VyQjP7vWy8K4A=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBh70AEOEtcuSEtc9fSkU3TG4WsW13ZDXHLhwZfXfqA 3e+H2TyJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYe9ABAAKCRAk1otyXVSH0Kb4B/ 9ZEauYmsT20nXzE1/SHUnyX0cfNwDbXQHSkwmbjDHaiozcef8NImej05UO2aH2jwhcHKUOX/5um0bn UUaNQ1t2beLiuS5q9UxeS0b6oV3iop72Ty8bjnLzX/Z11vpmzizMSy9pkMtzYNzuZiPeDNLvZ2cxiC W3464kNikvQM2LSxwuCKw9mIRLO+QePxUNp+0i7ivL9cN/+nkqsYwGD7xQnSqW/4HXdIQbi0wn9jG8 wq/3ln3809cPCc151Wmoy8aKL9AnscBfH2u1dwms03jZxxcJOhbl3NBIfzLQwj0KrPsElMTohsyfV5 ekkAohv04vHZwZSW0GazskXdMDhSUp
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Provide ABI documentation for SME similar to that for SVE. Due to the very
large overlap around streaming SVE mode in both implementation and
interfaces documentation for streaming mode SVE is added to the SVE
document rather than the SME one.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/arm64/index.rst |   1 +
 Documentation/arm64/sme.rst   | 432 ++++++++++++++++++++++++++++++++++
 Documentation/arm64/sve.rst   |  70 +++++-
 3 files changed, 493 insertions(+), 10 deletions(-)
 create mode 100644 Documentation/arm64/sme.rst

diff --git a/Documentation/arm64/index.rst b/Documentation/arm64/index.rst
index 4f840bac083e..ae21f8118830 100644
--- a/Documentation/arm64/index.rst
+++ b/Documentation/arm64/index.rst
@@ -21,6 +21,7 @@ ARM64 Architecture
     perf
     pointer-authentication
     silicon-errata
+    sme
     sve
     tagged-address-abi
     tagged-pointers
diff --git a/Documentation/arm64/sme.rst b/Documentation/arm64/sme.rst
new file mode 100644
index 000000000000..15df3157c592
--- /dev/null
+++ b/Documentation/arm64/sme.rst
@@ -0,0 +1,432 @@
+===================================================
+Scalable Matrix Extension support for AArch64 Linux
+===================================================
+
+This document outlines briefly the interface provided to userspace by Linux in
+order to support use of the ARM Scalable Matrix Extension (SME).
+
+This is an outline of the most important features and issues only and not
+intended to be exhaustive.  It should be read in conjunction with the SVE
+documentation in sve.rst which provides details on the Streaming SVE mode
+included in SME.
+
+This document does not aim to describe the SME architecture or programmer's
+model.  To aid understanding, a minimal description of relevant programmer's
+model features for SME is included in Appendix A.
+
+
+1.  General
+-----------
+
+* PSTATE.SM, PSTATE.ZA, the streaming mode vector length, the ZA
+  register state and TPIDR2_EL0 are tracked per thread.
+
+* The presence of SME is reported to userspace via HWCAP2_SME in the aux vector
+  AT_HWCAP2 entry.  Presence of this flag implies the presence of the SME
+  instructions and registers, and the Linux-specific system interfaces
+  described in this document.  SME is reported in /proc/cpuinfo as "sme".
+
+* Support for the execution of SME instructions in userspace can also be
+  detected by reading the CPU ID register ID_AA64PFR1_EL1 using an MRS
+  instruction, and checking that the value of the SME field is nonzero. [3]
+
+  It does not guarantee the presence of the system interfaces described in the
+  following sections: software that needs to verify that those interfaces are
+  present must check for HWCAP2_SME instead.
+
+* There are a number of optional SME features, presence of these is reported
+  through AT_HWCAP2 through:
+
+	HWCAP2_SME_I16I64
+	HWCAP2_SME_F64F64
+	HWCAP2_SME_I8I32
+	HWCAP2_SME_F16F32
+	HWCAP2_SME_B16F32
+	HWCAP2_SME_F32F32
+	HWCAP2_SME_FA64
+
+  This list may be extended over time as the SME architecture evolves.
+
+  These extensions are also reported via the CPU ID register ID_AA64SMFR0_EL1,
+  which userspace can read using an MRS instruction.  See elf_hwcaps.txt and
+  cpu-feature-registers.txt for details.
+
+* Debuggers should restrict themselves to interacting with the target via the
+  NT_ARM_SVE, NT_ARM_SSVE and NT_ARM_ZA regsets.  The recommended way
+  of detecting support for these regsets is to connect to a target process
+  first and then attempt a
+
+	ptrace(PTRACE_GETREGSET, pid, NT_ARM_<regset>, &iov).
+
+* Whenever ZA register values are exchanged in memory between userspace and
+  the kernel, the register value is encoded in memory as a series of horizontal
+  vectors from 0 to VL/8-1 stored in the same endianness invariant format as is
+  used for SVE vectors.
+
+* On thread creation TPIDR2_EL0 is preserved unless CLONE_SETTLS is specified,
+  in which case it is set to 0.
+
+2.  Vector lengths
+------------------
+
+SME defines a second vector length similar to the SVE vector length which is
+controls the size of the streaming mode SVE vectors and the ZA matrix array.
+The ZA matrix is square with each side having as many bytes as a SVE vector.
+
+
+3.  Sharing of streaming and non-streaming mode SVE state
+---------------------------------------------------------
+
+It is implementation defined which if any parts of the SVE state are shared
+between streaming and non-streaming modes.  When switching between modes
+via software interfaces such as ptrace if no register content is provided as
+part of switching no state will be assumed to be shared and everything will
+be zeroed.
+
+
+4.  System call behaviour
+-------------------------
+
+* On syscall PSTATE.ZA is preserved, if PSTATE.ZA==1 then the contents of the
+  ZA matrix are preserved.
+
+* On syscall PSTATE.SM will be cleared and the SVE registers will be handled
+  as normal.
+
+* Neither the SVE registers nor ZA are used to pass arguments to or receive
+  results from any syscall.
+
+* On creation fork() or clone() the newly created process will have PSTATE.SM
+  and PSTATE.ZA cleared.
+
+* All other SME state of a thread, including the currently configured vector
+  length, the state of the PR_SME_VL_INHERIT flag, and the deferred vector
+  length (if any), is preserved across all syscalls, subject to the specific
+  exceptions for execve() described in section 6.
+
+
+5.  Signal handling
+-------------------
+
+* Signal handlers are invoked with streaming mode and ZA disabled.
+
+* A new signal frame record za_context encodes the ZA register contents on
+  signal delivery. [1]
+
+* The signal frame record for ZA always contains basic metadata, in particular
+  the thread's vector length (in za_context.vl).
+
+* The ZA matrix may or may not be included in the record, depending on
+  the value of PSTATE.ZA.  The registers are present if and only if:
+  za_context.head.size >= ZA_SIG_CONTEXT_SIZE(sve_vq_from_vl(za_context.vl))
+  in which case PSTATE.ZA == 1.
+
+* If matrix data is present, the remainder of the record has a vl-dependent
+  size and layout.  Macros ZA_SIG_* are defined [1] to facilitate access to
+  them.
+
+* The matrix is stored as a series of horizontal vectors in the same format as
+  is used for SVE vectors.
+
+* If the ZA context is too big to fit in sigcontext.__reserved[], then extra
+  space is allocated on the stack, an extra_context record is written in
+  __reserved[] referencing this space.  za_context is then written in the
+  extra space.  Refer to [1] for further details about this mechanism.
+
+
+5.  Signal return
+-----------------
+
+When returning from a signal handler:
+
+* If there is no za_context record in the signal frame, or if the record is
+  present but contains no register data as desribed in the previous section,
+  then ZA is disabled.
+
+* If za_context is present in the signal frame and contains matrix data then
+  PSTATE.ZA is set to 1 and ZA is populated with the specified data.
+
+* The vector length cannot be changed via signal return.  If za_context.vl in
+  the signal frame does not match the current vector length, the signal return
+  attempt is treated as illegal, resulting in a forced SIGSEGV.
+
+
+6.  prctl extensions
+--------------------
+
+Some new prctl() calls are added to allow programs to manage the SME vector
+length:
+
+prctl(PR_SME_SET_VL, unsigned long arg)
+
+    Sets the vector length of the calling thread and related flags, where
+    arg == vl | flags.  Other threads of the calling process are unaffected.
+
+    vl is the desired vector length, where sve_vl_valid(vl) must be true.
+
+    flags:
+
+	PR_SME_VL_INHERIT
+
+	    Inherit the current vector length across execve().  Otherwise, the
+	    vector length is reset to the system default at execve().  (See
+	    Section 9.)
+
+	PR_SME_SET_VL_ONEXEC
+
+	    Defer the requested vector length change until the next execve()
+	    performed by this thread.
+
+	    The effect is equivalent to implicit exceution of the following
+	    call immediately after the next execve() (if any) by the thread:
+
+		prctl(PR_SME_SET_VL, arg & ~PR_SME_SET_VL_ONEXEC)
+
+	    This allows launching of a new program with a different vector
+	    length, while avoiding runtime side effects in the caller.
+
+	    Without PR_SME_SET_VL_ONEXEC, the requested change takes effect
+	    immediately.
+
+
+    Return value: a nonnegative on success, or a negative value on error:
+	EINVAL: SME not supported, invalid vector length requested, or
+	    invalid flags.
+
+
+    On success:
+
+    * Either the calling thread's vector length or the deferred vector length
+      to be applied at the next execve() by the thread (dependent on whether
+      PR_SME_SET_VL_ONEXEC is present in arg), is set to the largest value
+      supported by the system that is less than or equal to vl.  If vl ==
+      SVE_VL_MAX, the value set will be the largest value supported by the
+      system.
+
+    * Any previously outstanding deferred vector length change in the calling
+      thread is cancelled.
+
+    * The returned value describes the resulting configuration, encoded as for
+      PR_SME_GET_VL.  The vector length reported in this value is the new
+      current vector length for this thread if PR_SME_SET_VL_ONEXEC was not
+      present in arg; otherwise, the reported vector length is the deferred
+      vector length that will be applied at the next execve() by the calling
+      thread.
+
+    * Changing the vector length causes all of ZA, P0..P15, FFR and all bits of
+      Z0..Z31 except for Z0 bits [127:0] .. Z31 bits [127:0] to become
+      unspecified, including both streaming and non-streaming SVE state.
+      Calling PR_SME_SET_VL with vl equal to the thread's current vector
+      length, or calling PR_SME_SET_VL with the PR_SVE_SET_VL_ONEXEC flag,
+      does not constitute a change to the vector length for this purpose.
+
+    * Changing the vector length causes PSTATE.ZA and PSTATE.SM to be cleared.
+      Calling PR_SME_SET_VL with vl equal to the thread's current vector
+      length, or calling PR_SME_SET_VL with the PR_SVE_SET_VL_ONEXEC flag,
+      does not constitute a change to the vector length for this purpose.
+
+
+prctl(PR_SME_GET_VL)
+
+    Gets the vector length of the calling thread.
+
+    The following flag may be OR-ed into the result:
+
+	PR_SME_VL_INHERIT
+
+	    Vector length will be inherited across execve().
+
+    There is no way to determine whether there is an outstanding deferred
+    vector length change (which would only normally be the case between a
+    fork() or vfork() and the corresponding execve() in typical use).
+
+    To extract the vector length from the result, bitwise and it with
+    PR_SME_VL_LEN_MASK.
+
+    Return value: a nonnegative value on success, or a negative value on error:
+	EINVAL: SME not supported.
+
+
+7.  ptrace extensions
+---------------------
+
+* A new regset NT_ARM_SSVE is defined for access to streaming mode SVE
+  state via PTRACE_GETREGSET and  PTRACE_SETREGSET, this is documented in
+  sve.rst.
+
+* A new regset NT_ARM_ZA is defined for ZA state for access to ZA state via
+  PTRACE_GETREGSET and PTRACE_SETREGSET.
+
+  Refer to [2] for definitions.
+
+The regset data starts with struct user_za_header, containing:
+
+    size
+
+	Size of the complete regset, in bytes.
+	This depends on vl and possibly on other things in the future.
+
+	If a call to PTRACE_GETREGSET requests less data than the value of
+	size, the caller can allocate a larger buffer and retry in order to
+	read the complete regset.
+
+    max_size
+
+	Maximum size in bytes that the regset can grow to for the target
+	thread.  The regset won't grow bigger than this even if the target
+	thread changes its vector length etc.
+
+    vl
+
+	Target thread's current streaming vector length, in bytes.
+
+    max_vl
+
+	Maximum possible streaming vector length for the target thread.
+
+    flags
+
+	Zero or more of the following flags, which have the same
+	meaning and behaviour as the corresponding PR_SET_VL_* flags:
+
+	    SME_PT_VL_INHERIT
+
+	    SME_PT_VL_ONEXEC (SETREGSET only).
+
+* The effects of changing the vector length and/or flags are equivalent to
+  those documented for PR_SME_SET_VL.
+
+  The caller must make a further GETREGSET call if it needs to know what VL is
+  actually set by SETREGSET, unless is it known in advance that the requested
+  VL is supported.
+
+* The size and layout of the payload depends on the header fields.  The
+  SME_PT_ZA_*() macros are provided to facilitate access to the data.
+
+* In either case, for SETREGSET it is permissible to omit the payload, in which
+  case the vector length and flags are changed and PSTATE.ZA is set to 0
+  (along with any consequences of those changes).  If a payload is provided
+  then PSTATE.ZA will be set to 1.
+
+* For SETREGSET, if the requested VL is not supported, the effect will be the
+  same as if the payload were omitted, except that an EIO error is reported.
+  No attempt is made to translate the payload data to the correct layout
+  for the vector length actually set.  It is up to the caller to translate the
+  payload layout for the actual VL and retry.
+
+* The effect of writing a partial, incomplete payload is unspecified.
+
+
+8.  ELF coredump extensions
+---------------------------
+
+* NT_ARM_SSVE notes will be added to each coredump for
+  each thread of the dumped process.  The contents will be equivalent to the
+  data that would have been read if a PTRACE_GETREGSET of the corresponding
+  type were executed for each thread when the coredump was generated.
+
+* A NT_ARM_ZA note will be added to each coredump for each thread of the
+  dumped process.  The contents will be equivalent to the data that would have
+  been read if a PTRACE_GETREGSET of NT_ARM_ZA were executed for each thread
+  when the coredump was generated.
+
+
+9.  System runtime configuration
+--------------------------------
+
+* To mitigate the ABI impact of expansion of the signal frame, a policy
+  mechanism is provided for administrators, distro maintainers and developers
+  to set the default vector length for userspace processes:
+
+/proc/sys/abi/sme_default_vector_length
+
+    Writing the text representation of an integer to this file sets the system
+    default vector length to the specified value, unless the value is greater
+    than the maximum vector length supported by the system in which case the
+    default vector length is set to that maximum.
+
+    The result can be determined by reopening the file and reading its
+    contents.
+
+    At boot, the default vector length is initially set to 32 or the maximum
+    supported vector length, whichever is smaller and supported.  This
+    determines the initial vector length of the init process (PID 1).
+
+    Reading this file returns the current system default vector length.
+
+* At every execve() call, the new vector length of the new process is set to
+  the system default vector length, unless
+
+    * PR_SME_VL_INHERIT (or equivalently SME_PT_VL_INHERIT) is set for the
+      calling thread, or
+
+    * a deferred vector length change is pending, established via the
+      PR_SME_SET_VL_ONEXEC flag (or SME_PT_VL_ONEXEC).
+
+* Modifying the system default vector length does not affect the vector length
+  of any existing process or thread that does not make an execve() call.
+
+
+Appendix A.  SME programmer's model (informative)
+=================================================
+
+This section provides a minimal description of the additions made by SVE to the
+ARMv8-A programmer's model that are relevant to this document.
+
+Note: This section is for information only and not intended to be complete or
+to replace any architectural specification.
+
+A.1.  Registers
+---------------
+
+In A64 state, SME adds the following:
+
+* A new mode, streaming mode, in which a subset of the normal FPSIMD and SVE
+  features are available.  When supported EL0 software may enter and leave
+  streaming mode at any time.
+
+  For best system performance it is strongly encouraged for software to enable
+  streaming mode only when it is actively being used.
+
+* A new vector length controlling the size of ZA and the Z registers when in
+  streaming mode, separately to the vector length used for SVE when not in
+  streaming mode.  There is no requirement that either the currently selected
+  vector length or the set of vector lengths supported for the two modes in
+  a given system have any relationship.  The streaming mode vector length
+  is referred to as SVL.
+
+* A new ZA matrix register.  This is a square matrix of SVLxSVL bits.  Most
+  operations on ZA require that streaming mode be enabled but ZA can be
+  enabled without streaming mode in order to load, save and retain data.
+
+  For best system performance it is strongly encouraged for software to enable
+  ZA only when it is actively being used.
+
+* Two new 1 bit fields in PSTATE which may be controlled via the SMSTART and
+  SMSTOP instructions or by access to the SVCR system register:
+
+  * PSTATE.ZA, if this is 1 then the ZA matrix is accessible and has valid
+    data while if it is 0 then ZA can not be accessed.  When PSTATE.ZA is
+    changed from 0 to 1 all bits in ZA are cleared.
+
+  * PSTATE.SM, if this is 1 then the PE is in streaming mode.  When the value
+    of PSTATE.SM is changed then it is implementation defined if the subset
+    of the floating point register bits valid in both modes may be retained.
+    Any other bits will be cleared.
+
+
+References
+==========
+
+[1] arch/arm64/include/uapi/asm/sigcontext.h
+    AArch64 Linux signal ABI definitions
+
+[2] arch/arm64/include/uapi/asm/ptrace.h
+    AArch64 Linux ptrace ABI definitions
+
+[3] Documentation/arm64/cpu-feature-registers.rst
+
+[4] ARM IHI0055C
+    http://infocenter.arm.com/help/topic/com.arm.doc.ihi0055c/IHI0055C_beta_aapcs64.pdf
+    http://infocenter.arm.com/help/topic/com.arm.doc.subset.swdev.abi/index.html
+    Procedure Call Standard for the ARM 64-bit Architecture (AArch64)
diff --git a/Documentation/arm64/sve.rst b/Documentation/arm64/sve.rst
index 9d9a4de5bc34..93c2c2990584 100644
--- a/Documentation/arm64/sve.rst
+++ b/Documentation/arm64/sve.rst
@@ -7,7 +7,9 @@ Author: Dave Martin <Dave.Martin@arm.com>
 Date:   4 August 2017
 
 This document outlines briefly the interface provided to userspace by Linux in
-order to support use of the ARM Scalable Vector Extension (SVE).
+order to support use of the ARM Scalable Vector Extension (SVE), including
+interactions with Streaming SVE mode added by the Scalable Matrix Extension
+(SME).
 
 This is an outline of the most important features and issues only and not
 intended to be exhaustive.
@@ -23,6 +25,10 @@ model features for SVE is included in Appendix A.
 * SVE registers Z0..Z31, P0..P15 and FFR and the current vector length VL, are
   tracked per-thread.
 
+* In streaming mode FFR is not accessible unless HWCAP2_SME_FA64 is present
+  in the system, when it is not supported and these interfaces are used to
+  access streaming mode FFR is read and written as zero.
+
 * The presence of SVE is reported to userspace via HWCAP_SVE in the aux vector
   AT_HWCAP entry.  Presence of this flag implies the presence of the SVE
   instructions and registers, and the Linux-specific system interfaces
@@ -53,10 +59,19 @@ model features for SVE is included in Appendix A.
   which userspace can read using an MRS instruction.  See elf_hwcaps.txt and
   cpu-feature-registers.txt for details.
 
+* On hardware that supports the SME extensions, HWCAP2_SME will also be
+  reported in the AT_HWCAP2 aux vector entry.  Among other things SME adds
+  streaming mode which provides a subset of the SVE feature set using a
+  separate SME vector length and the same Z/V registers.  See sme.rst
+  for more details.
+
 * Debuggers should restrict themselves to interacting with the target via the
   NT_ARM_SVE regset.  The recommended way of detecting support for this regset
   is to connect to a target process first and then attempt a
-  ptrace(PTRACE_GETREGSET, pid, NT_ARM_SVE, &iov).
+  ptrace(PTRACE_GETREGSET, pid, NT_ARM_SVE, &iov).  Note that when SME is
+  present and streaming SVE mode is in use the FPSIMD subset of registers
+  will be read via NT_ARM_SVE and NT_ARM_SVE writes will exit streaming mode
+  in the target.
 
 * Whenever SVE scalable register values (Zn, Pn, FFR) are exchanged in memory
   between userspace and the kernel, the register value is encoded in memory in
@@ -126,6 +141,11 @@ the SVE instruction set architecture.
   are only present in fpsimd_context.  For convenience, the content of V0..V31
   is duplicated between sve_context and fpsimd_context.
 
+* The record contains a flag field which includes a flag SVE_SIG_FLAG_SM which
+  if set indicates that the thread is in streaming mode and the vector length
+  and register data (if present) describe the streaming SVE data and vector
+  length.
+
 * The signal frame record for SVE always contains basic metadata, in particular
   the thread's vector length (in sve_context.vl).
 
@@ -170,6 +190,11 @@ When returning from a signal handler:
   the signal frame does not match the current vector length, the signal return
   attempt is treated as illegal, resulting in a forced SIGSEGV.
 
+* It is permitted to enter or leave streaming mode by setting or clearing
+  the SVE_SIG_FLAG_SM flag but applications should take care to ensure that
+  when doing so sve_context.vl and any register data are appropriate for the
+  vector length in the new mode.
+
 
 6.  prctl extensions
 --------------------
@@ -265,8 +290,14 @@ prctl(PR_SVE_GET_VL)
 7.  ptrace extensions
 ---------------------
 
-* A new regset NT_ARM_SVE is defined for use with PTRACE_GETREGSET and
-  PTRACE_SETREGSET.
+* New regsets NT_ARM_SVE and NT_ARM_SSVE are defined for use with
+  PTRACE_GETREGSET and PTRACE_SETREGSET. NT_ARM_SSVE describes the
+  streaming mode SVE registers and NT_ARM_SVE describes the
+  non-streaming mode SVE registers.
+
+  In this description a register set is referred to as being "live" when
+  the target is in the appropriate streaming or non-streaming mode and is
+  using data beyond the subset shared with the FPSIMD Vn registers.
 
   Refer to [2] for definitions.
 
@@ -297,7 +328,7 @@ The regset data starts with struct user_sve_header, containing:
 
     flags
 
-	either
+	at most one of
 
 	    SVE_PT_REGS_FPSIMD
 
@@ -331,6 +362,10 @@ The regset data starts with struct user_sve_header, containing:
 
 	    SVE_PT_VL_ONEXEC (SETREGSET only).
 
+	If neither FPSIMD nor SVE flags are provided then no register
+	payload is available, this is only possible when SME is implemented.
+
+
 * The effects of changing the vector length and/or flags are equivalent to
   those documented for PR_SVE_SET_VL.
 
@@ -346,6 +381,13 @@ The regset data starts with struct user_sve_header, containing:
   case only the vector length and flags are changed (along with any
   consequences of those changes).
 
+* In systems supporting SME when in streaming mode a GETREGSET for
+  NT_REG_SVE will return only the user_sve_header with no register data,
+  similarly a GETREGSET for NT_REG_SSVE will not return any register data
+  when not in streaming mode.
+
+* A GETREGSET for NT_ARM_SSVE will never return SVE_PT_REGS_FPSIMD.
+
 * For SETREGSET, if an SVE_PT_REGS_SVE payload is present and the
   requested VL is not supported, the effect will be the same as if the
   payload were omitted, except that an EIO error is reported.  No
@@ -355,17 +397,25 @@ The regset data starts with struct user_sve_header, containing:
   unspecified.  It is up to the caller to translate the payload layout
   for the actual VL and retry.
 
+* Where SME is implemented it is not possible to GETREGSET the register
+  state for normal SVE when in streaming mode, nor the streaming mode
+  register state when in normal mode, regardless of the implementation defined
+  behaviour of the hardware for sharing data between the two modes.
+
+* Any SETREGSET of NT_ARM_SVE will exit streaming mode if the target was in
+  streaming mode and any SETREGSET of NT_ARM_SSVE will enter streaming mode
+  if the target was not in streaming mode.
+
 * The effect of writing a partial, incomplete payload is unspecified.
 
 
 8.  ELF coredump extensions
 ---------------------------
 
-* A NT_ARM_SVE note will be added to each coredump for each thread of the
-  dumped process.  The contents will be equivalent to the data that would have
-  been read if a PTRACE_GETREGSET of NT_ARM_SVE were executed for each thread
-  when the coredump was generated.
-
+* NT_ARM_SVE and NT_ARM_SSVE notes will be added to each coredump for
+  each thread of the dumped process.  The contents will be equivalent to the
+  data that would have been read if a PTRACE_GETREGSET of the corresponding
+  type were executed for each thread when the coredump was generated.
 
 9.  System runtime configuration
 --------------------------------
-- 
2.30.2

