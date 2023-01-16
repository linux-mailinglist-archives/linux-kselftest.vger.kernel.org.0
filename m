Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F235066C5A3
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Jan 2023 17:08:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232304AbjAPQI1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 16 Jan 2023 11:08:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232454AbjAPQHk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 16 Jan 2023 11:07:40 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5D7E27D52;
        Mon, 16 Jan 2023 08:05:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A37EDB81076;
        Mon, 16 Jan 2023 16:05:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D905C43398;
        Mon, 16 Jan 2023 16:05:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673885138;
        bh=9JWEIgM4ds4EdD49z2pICDu3icq2YzKQQ/2ECpCDSKg=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=iCYoVn2kTIpfBvEHvJjyhLi0eWrSjnGq2QnunAvwer75sS/b1Wqtqf2FI//ImtxLb
         sWzTa8prFP82OLsjJ7mE+QDusojoX4c5iRbSZuZLG56PBaVFQagabwPZ1B8y0UCuMP
         /Mg/q0nMTuH0NqPJEVJA0IpQq/Qum9Np0VbtP15d+bdnzvrekRzmBUcNijvAK12hr9
         Zb5Z3J96EsL8Ofyw/75fXHSDTGabiFTkAckl1xbI5Uv/NxN6rOUFJ0tKqOQTc3WvH8
         EoVqbx6AKuzsno/UrQdXLTGZqM/tNzHyesnAgXP1vkzvCrijQR9JXmnnFPUWu7tQm8
         djf2gygcYzWZQ==
From:   Mark Brown <broonie@kernel.org>
Date:   Mon, 16 Jan 2023 16:04:39 +0000
Subject: [PATCH v4 04/21] arm64/sme: Document SME 2 and SME 2.1 ABI
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20221208-arm64-sme2-v4-4-f2fa0aef982f@kernel.org>
References: <20221208-arm64-sme2-v4-0-f2fa0aef982f@kernel.org>
In-Reply-To: <20221208-arm64-sme2-v4-0-f2fa0aef982f@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Oleg Nesterov <oleg@redhat.com>,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Oliver Upton <oliver.upton@linux.dev>,
        Shuah Khan <shuah@kernel.org>
Cc:     Alan Hayward <alan.hayward@arm.com>,
        Luis Machado <luis.machado@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kvmarm@lists.linux.dev, linux-kselftest@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.12-dev-77e06
X-Developer-Signature: v=1; a=openpgp-sha256; l=7013; i=broonie@kernel.org;
 h=from:subject:message-id; bh=9JWEIgM4ds4EdD49z2pICDu3icq2YzKQQ/2ECpCDSKg=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBjxXWkwHrhAiDoVyeR4abRah2ZyWkzmdcmNiV7uZNO
 GooajmqJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCY8V1pAAKCRAk1otyXVSH0EXJB/
 48cue5HajDd1ZyFOJvzmLFk3/ckJ+lttIGHi5ga147ltF9eQFuo3CYU4NUqE5hVK3rFJiSBkdEhh/R
 E/oGNzWMI+uZgeunL28xaLsbEaScbGvhj4DzIM9SIITV379Rl6IEfz7Fp3yK6el/iB7N9QHZgv2zog
 W0g0ROmTlqkQVN/UQWMRcBmZeyvdMFW1bKDLRNnJZK08yq/bOZI3eCdT6qKbPE+Bd1ZMh7FMHnU3/T
 4STK6GCF2L4igH15j4aBjMLoHlrJLblWvo+pIPl/W0kdoW7xhV5Cz5l/weYSVjpc8T8PPkUNJVC5o6
 yh4Rrwgl/kN576lAsPgynJiphR+Dk/
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

As well as a number of simple features which only add new instructions and
require corresponding hwcaps SME2 introduces a new register ZT0 for which
we must define ABI. Fortunately this is a fixed size 512 bits and therefore
much more straightforward than the base SME state, the only wrinkle is that
it is only accessible when ZA is accessible.

While there is only a single register the architecture is written with a
view to exensibility, including a number in the name, so follow this in the
ABI.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/arm64/sme.rst | 52 +++++++++++++++++++++++++++++++++++++--------
 1 file changed, 43 insertions(+), 9 deletions(-)

diff --git a/Documentation/arm64/sme.rst b/Documentation/arm64/sme.rst
index 16d2db4c2e2e..68d1efb7d171 100644
--- a/Documentation/arm64/sme.rst
+++ b/Documentation/arm64/sme.rst
@@ -18,14 +18,19 @@ model features for SME is included in Appendix A.
 1.  General
 -----------
 
-* PSTATE.SM, PSTATE.ZA, the streaming mode vector length, the ZA
-  register state and TPIDR2_EL0 are tracked per thread.
+* PSTATE.SM, PSTATE.ZA, the streaming mode vector length, the ZA and (when
+  present) ZTn register state and TPIDR2_EL0 are tracked per thread.
 
 * The presence of SME is reported to userspace via HWCAP2_SME in the aux vector
   AT_HWCAP2 entry.  Presence of this flag implies the presence of the SME
   instructions and registers, and the Linux-specific system interfaces
   described in this document.  SME is reported in /proc/cpuinfo as "sme".
 
+* The presence of SME2 is reported to userspace via HWCAP2_SME2 in the
+  aux vector AT_HWCAP2 entry.  Presence of this flag implies the presence of
+  the SME2 instructions and ZT0, and the Linux-specific system interfaces
+  described in this document.  SME2 is reported in /proc/cpuinfo as "sme2".
+
 * Support for the execution of SME instructions in userspace can also be
   detected by reading the CPU ID register ID_AA64PFR1_EL1 using an MRS
   instruction, and checking that the value of the SME field is nonzero. [3]
@@ -44,6 +49,7 @@ model features for SME is included in Appendix A.
 	HWCAP2_SME_B16F32
 	HWCAP2_SME_F32F32
 	HWCAP2_SME_FA64
+        HWCAP2_SME2
 
   This list may be extended over time as the SME architecture evolves.
 
@@ -52,8 +58,8 @@ model features for SME is included in Appendix A.
   cpu-feature-registers.txt for details.
 
 * Debuggers should restrict themselves to interacting with the target via the
-  NT_ARM_SVE, NT_ARM_SSVE and NT_ARM_ZA regsets.  The recommended way
-  of detecting support for these regsets is to connect to a target process
+  NT_ARM_SVE, NT_ARM_SSVE, NT_ARM_ZA and NT_ARM_ZT regsets.  The recommended
+  way of detecting support for these regsets is to connect to a target process
   first and then attempt a
 
 	ptrace(PTRACE_GETREGSET, pid, NT_ARM_<regset>, &iov).
@@ -89,13 +95,13 @@ be zeroed.
 -------------------------
 
 * On syscall PSTATE.ZA is preserved, if PSTATE.ZA==1 then the contents of the
-  ZA matrix are preserved.
+  ZA matrix and ZTn (if present) are preserved.
 
 * On syscall PSTATE.SM will be cleared and the SVE registers will be handled
   as per the standard SVE ABI.
 
-* Neither the SVE registers nor ZA are used to pass arguments to or receive
-  results from any syscall.
+* None of the SVE registers, ZA or ZTn are used to pass arguments to
+  or receive results from any syscall.
 
 * On process creation (eg, clone()) the newly created process will have
   PSTATE.SM cleared.
@@ -134,6 +140,14 @@ be zeroed.
   __reserved[] referencing this space.  za_context is then written in the
   extra space.  Refer to [1] for further details about this mechanism.
 
+* If ZTn is supported and PSTATE.ZA==1 then a signal frame record for ZTn will
+  be generated.
+
+* The signal record for ZTn has magic ZT_MAGIC (0x5a544e01) and consists of a
+  standard signal frame header followed by a struct zt_context specifying
+  the number of ZTn registers supported by the system, then zt_context.nregs
+  blocks of 64 bytes of data per register.
+
 
 5.  Signal return
 -----------------
@@ -151,6 +165,9 @@ When returning from a signal handler:
   the signal frame does not match the current vector length, the signal return
   attempt is treated as illegal, resulting in a forced SIGSEGV.
 
+* If ZTn is not supported or PSTATE.ZA==0 then it is illegal to have a
+  signal frame record for ZTn, resulting in a forced SIGSEGV.
+
 
 6.  prctl extensions
 --------------------
@@ -214,8 +231,8 @@ prctl(PR_SME_SET_VL, unsigned long arg)
       vector length that will be applied at the next execve() by the calling
       thread.
 
-    * Changing the vector length causes all of ZA, P0..P15, FFR and all bits of
-      Z0..Z31 except for Z0 bits [127:0] .. Z31 bits [127:0] to become
+    * Changing the vector length causes all of ZA, ZTn, P0..P15, FFR and all
+      bits of Z0..Z31 except for Z0 bits [127:0] .. Z31 bits [127:0] to become
       unspecified, including both streaming and non-streaming SVE state.
       Calling PR_SME_SET_VL with vl equal to the thread's current vector
       length, or calling PR_SME_SET_VL with the PR_SVE_SET_VL_ONEXEC flag,
@@ -317,6 +334,15 @@ The regset data starts with struct user_za_header, containing:
 
 * The effect of writing a partial, incomplete payload is unspecified.
 
+* A new regset NT_ARM_ZT is defined for access to ZTn state via
+  PTRACE_GETREGSET and PTRACE_SETREGSET.
+
+* The NT_ARM_ZT regset consists of a single 512 bit register.
+
+* When PSTATE.ZA==0 reads of NT_ARM_ZT will report all bits of ZTn as 0.
+
+* Writes to NT_ARM_ZT will set PSTATE.ZA to 1.
+
 
 8.  ELF coredump extensions
 ---------------------------
@@ -331,6 +357,11 @@ The regset data starts with struct user_za_header, containing:
   been read if a PTRACE_GETREGSET of NT_ARM_ZA were executed for each thread
   when the coredump was generated.
 
+* A NT_ARM_ZT note will be added to each coredump for each thread of the
+  dumped process.  The contents will be equivalent to the data that would have
+  been read if a PTRACE_GETREGSET of NT_ARM_ZT were executed for each thread
+  when the coredump was generated.
+
 * The NT_ARM_TLS note will be extended to two registers, the second register
   will contain TPIDR2_EL0 on systems that support SME and will be read as
   zero with writes ignored otherwise.
@@ -406,6 +437,9 @@ In A64 state, SME adds the following:
   For best system performance it is strongly encouraged for software to enable
   ZA only when it is actively being used.
 
+* A new ZT0 register is introduced when SME2 is present. This is a 512 bit
+  register which is accessible when PSTATE.ZA is set, as ZA itself is.
+
 * Two new 1 bit fields in PSTATE which may be controlled via the SMSTART and
   SMSTOP instructions or by access to the SVCR system register:
 

-- 
2.34.1

