Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 999E74AC3D9
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Feb 2022 16:40:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232009AbiBGPe5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 7 Feb 2022 10:34:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355431AbiBGPYk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 7 Feb 2022 10:24:40 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D404C0401C1
        for <linux-kselftest@vger.kernel.org>; Mon,  7 Feb 2022 07:24:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F042CB815B3
        for <linux-kselftest@vger.kernel.org>; Mon,  7 Feb 2022 15:24:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6DCFC340F3;
        Mon,  7 Feb 2022 15:24:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644247476;
        bh=54fbHBhPsozwjp/3pATyx8OpVN6ucv7EKpZAVjJ2qAQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=T0237IHf3Qd6wr4uImfi51NbqCl9IOkazHNfuBj8SCPidpW6eaEep3lYIJgrGWEgq
         rZ22gZcXP1Q4m7pIqx+3rAwYaFjnkSHtibqIcZRE6tj0v65OMMi1G1MPAhOUtQPFDD
         FIbcKXVaWJNt+U+ezsrImewdSidvGehH+1hpsPCShUAOdvseOJhFR0AG3JOULlI+hX
         Yywcbxqlkc1hWz23UV02hL3sQ9RZGcRMF9V9PsZcZW1VUcI8R3V8aKrLnYuxtbhv54
         K2z7K1BWjFK+4WEph/H025m5I9MH9Why1QI/klRMFeAOu4kuSpbIbFga5MDywph7Bp
         i0ePqDeiAwQQw==
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
Subject: [PATCH v11 22/40] arm64/sme: Implement ptrace support for streaming mode SVE registers
Date:   Mon,  7 Feb 2022 15:20:51 +0000
Message-Id: <20220207152109.197566-23-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220207152109.197566-1-broonie@kernel.org>
References: <20220207152109.197566-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=14915; h=from:subject; bh=54fbHBhPsozwjp/3pATyx8OpVN6ucv7EKpZAVjJ2qAQ=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBiATjWNBn52S0bIWVYmB4TcfeoCi0Q1cKp21rjNspq DD4Ok3uJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYgE41gAKCRAk1otyXVSH0GrlB/ 9x1xMpCmPENnlNQz5bT6ysspgPovwRtgTrmfJMmbdyhpX/2AkXT9LQ97RvsYk8AaKpYa7KVmO9QtEx 2Y9+C1x5YHSEIp5lz/C9SYmWOOw3pycC9xgdVf3Oc6HnS95KA29iuFRKt6sOGAoq3NOr77dqdTSUQX PQNQTOp9aOh//mqaN6aFd+8ey4xrbHsYb2un7LD0EIUrSXTG/Bc9YrtDi9KE22MoxXOBYhnot9HSYd hq8ChzaF7ZTrGS9874/yChhdDZIyzr5YVLKL2xSu5fPp64UT1uv5VW6o5vqCi1ZeWfw663gHTDjLXm d2W6BimjCppHHAcRZIFAqaKRbn+3pZ
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The streaming mode SVE registers are represented using the same data
structures as for SVE but since the vector lengths supported and in use
may not be the same as SVE we represent them with a new type NT_ARM_SSVE.
Unfortunately we only have a single 16 bit reserved field available in
the header so there is no space to fit the current and maximum vector
length for both standard and streaming SVE mode without redefining the
structure in a way the creates a complicatd and fragile ABI. Since FFR
is not present in streaming mode it is read and written as zero.

Setting NT_ARM_SSVE registers will put the task into streaming mode,
similarly setting NT_ARM_SVE registers will exit it. Reads that do not
correspond to the current mode of the task will return the header with
no register data. For compatibility reasons on write setting no flag for
the register type will be interpreted as setting SVE registers, though
users can provide no register data as an alternative mechanism for doing
so.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/include/uapi/asm/ptrace.h |  13 +-
 arch/arm64/kernel/fpsimd.c           |  21 ++-
 arch/arm64/kernel/ptrace.c           | 212 +++++++++++++++++++++------
 include/uapi/linux/elf.h             |   1 +
 4 files changed, 190 insertions(+), 57 deletions(-)

diff --git a/arch/arm64/include/uapi/asm/ptrace.h b/arch/arm64/include/uapi/asm/ptrace.h
index 758ae984ff97..522b925a78c1 100644
--- a/arch/arm64/include/uapi/asm/ptrace.h
+++ b/arch/arm64/include/uapi/asm/ptrace.h
@@ -109,7 +109,7 @@ struct user_hwdebug_state {
 	}		dbg_regs[16];
 };
 
-/* SVE/FP/SIMD state (NT_ARM_SVE) */
+/* SVE/FP/SIMD state (NT_ARM_SVE & NT_ARM_SSVE) */
 
 struct user_sve_header {
 	__u32 size; /* total meaningful regset content in bytes */
@@ -220,6 +220,7 @@ struct user_sve_header {
 	(SVE_PT_SVE_PREG_OFFSET(vq, __SVE_NUM_PREGS) - \
 		SVE_PT_SVE_PREGS_OFFSET(vq))
 
+/* For streaming mode SVE (SSVE) FFR must be read and written as zero */
 #define SVE_PT_SVE_FFR_OFFSET(vq) \
 	(SVE_PT_REGS_OFFSET + __SVE_FFR_OFFSET(vq))
 
@@ -240,10 +241,12 @@ struct user_sve_header {
 			- SVE_PT_SVE_OFFSET + (__SVE_VQ_BYTES - 1))	\
 		/ __SVE_VQ_BYTES * __SVE_VQ_BYTES)
 
-#define SVE_PT_SIZE(vq, flags)						\
-	 (((flags) & SVE_PT_REGS_MASK) == SVE_PT_REGS_SVE ?		\
-		  SVE_PT_SVE_OFFSET + SVE_PT_SVE_SIZE(vq, flags)	\
-		: SVE_PT_FPSIMD_OFFSET + SVE_PT_FPSIMD_SIZE(vq, flags))
+#define SVE_PT_SIZE(vq, flags)						  \
+	 (((flags) & SVE_PT_REGS_MASK) == SVE_PT_REGS_SVE ?		  \
+		  SVE_PT_SVE_OFFSET + SVE_PT_SVE_SIZE(vq, flags)	  \
+		: ((((flags) & SVE_PT_REGS_MASK) == SVE_PT_REGS_FPSIMD ?  \
+		    SVE_PT_FPSIMD_OFFSET + SVE_PT_FPSIMD_SIZE(vq, flags) \
+		  : SVE_PT_REGS_OFFSET)))
 
 /* pointer authentication masks (NT_ARM_PAC_MASK) */
 
diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index 2242c14a5a05..8b111b7f2006 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -645,14 +645,19 @@ static void __fpsimd_to_sve(void *sst, struct user_fpsimd_state const *fst,
  */
 static void fpsimd_to_sve(struct task_struct *task)
 {
-	unsigned int vq;
+	unsigned int vq, vl;
 	void *sst = task->thread.sve_state;
 	struct user_fpsimd_state const *fst = &task->thread.uw.fpsimd_state;
 
 	if (!system_supports_sve())
 		return;
 
-	vq = sve_vq_from_vl(task_get_sve_vl(task));
+	if (thread_sm_enabled(&task->thread))
+		vl = task_get_sme_vl(task);
+	else
+		vl = task_get_sve_vl(task);
+
+	vq = sve_vq_from_vl(vl);
 	__fpsimd_to_sve(sst, fst, vq);
 }
 
@@ -669,7 +674,7 @@ static void fpsimd_to_sve(struct task_struct *task)
  */
 static void sve_to_fpsimd(struct task_struct *task)
 {
-	unsigned int vq;
+	unsigned int vq, vl;
 	void const *sst = task->thread.sve_state;
 	struct user_fpsimd_state *fst = &task->thread.uw.fpsimd_state;
 	unsigned int i;
@@ -678,7 +683,12 @@ static void sve_to_fpsimd(struct task_struct *task)
 	if (!system_supports_sve())
 		return;
 
-	vq = sve_vq_from_vl(task_get_sve_vl(task));
+	if (thread_sm_enabled(&task->thread))
+		vl = task_get_sme_vl(task);
+	else
+		vl = task_get_sve_vl(task);
+
+	vq = sve_vq_from_vl(vl);
 	for (i = 0; i < SVE_NUM_ZREGS; ++i) {
 		p = (__uint128_t const *)ZREG(sst, vq, i);
 		fst->vregs[i] = arm64_le128_to_cpu(*p);
@@ -819,8 +829,7 @@ int vec_set_vector_length(struct task_struct *task, enum vec_type type,
 	/*
 	 * To ensure the FPSIMD bits of the SVE vector registers are preserved,
 	 * write any live register state back to task_struct, and convert to a
-	 * regular FPSIMD thread.  Since the vector length can only be changed
-	 * with a syscall we can't be in streaming mode while reconfiguring.
+	 * regular FPSIMD thread.
 	 */
 	if (task == current) {
 		get_cpu_fpsimd_context();
diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index 39dbdfdc38d3..0b8324fa1abc 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -714,21 +714,51 @@ static int system_call_set(struct task_struct *target,
 #ifdef CONFIG_ARM64_SVE
 
 static void sve_init_header_from_task(struct user_sve_header *header,
-				      struct task_struct *target)
+				      struct task_struct *target,
+				      enum vec_type type)
 {
 	unsigned int vq;
+	bool active;
+	bool fpsimd_only;
+	enum vec_type task_type;
 
 	memset(header, 0, sizeof(*header));
 
-	header->flags = test_tsk_thread_flag(target, TIF_SVE) ?
-		SVE_PT_REGS_SVE : SVE_PT_REGS_FPSIMD;
-	if (test_tsk_thread_flag(target, TIF_SVE_VL_INHERIT))
-		header->flags |= SVE_PT_VL_INHERIT;
+	/* Check if the requested registers are active for the task */
+	if (thread_sm_enabled(&target->thread))
+		task_type = ARM64_VEC_SME;
+	else
+		task_type = ARM64_VEC_SVE;
+	active = (task_type == type);
+
+	switch (type) {
+	case ARM64_VEC_SVE:
+		if (test_tsk_thread_flag(target, TIF_SVE_VL_INHERIT))
+			header->flags |= SVE_PT_VL_INHERIT;
+		fpsimd_only = !test_tsk_thread_flag(target, TIF_SVE);
+		break;
+	case ARM64_VEC_SME:
+		if (test_tsk_thread_flag(target, TIF_SME_VL_INHERIT))
+			header->flags |= SVE_PT_VL_INHERIT;
+		fpsimd_only = false;
+		break;
+	default:
+		WARN_ON_ONCE(1);
+		return;
+	}
 
-	header->vl = task_get_sve_vl(target);
+	if (active) {
+		if (fpsimd_only) {
+			header->flags |= SVE_PT_REGS_FPSIMD;
+		} else {
+			header->flags |= SVE_PT_REGS_SVE;
+		}
+	}
+
+	header->vl = task_get_vl(target, type);
 	vq = sve_vq_from_vl(header->vl);
 
-	header->max_vl = sve_max_vl();
+	header->max_vl = vec_max_vl(type);
 	header->size = SVE_PT_SIZE(vq, header->flags);
 	header->max_size = SVE_PT_SIZE(sve_vq_from_vl(header->max_vl),
 				      SVE_PT_REGS_SVE);
@@ -739,19 +769,17 @@ static unsigned int sve_size_from_header(struct user_sve_header const *header)
 	return ALIGN(header->size, SVE_VQ_BYTES);
 }
 
-static int sve_get(struct task_struct *target,
-		   const struct user_regset *regset,
-		   struct membuf to)
+static int sve_get_common(struct task_struct *target,
+			  const struct user_regset *regset,
+			  struct membuf to,
+			  enum vec_type type)
 {
 	struct user_sve_header header;
 	unsigned int vq;
 	unsigned long start, end;
 
-	if (!system_supports_sve())
-		return -EINVAL;
-
 	/* Header */
-	sve_init_header_from_task(&header, target);
+	sve_init_header_from_task(&header, target, type);
 	vq = sve_vq_from_vl(header.vl);
 
 	membuf_write(&to, &header, sizeof(header));
@@ -759,49 +787,61 @@ static int sve_get(struct task_struct *target,
 	if (target == current)
 		fpsimd_preserve_current_state();
 
-	/* Registers: FPSIMD-only case */
-
 	BUILD_BUG_ON(SVE_PT_FPSIMD_OFFSET != sizeof(header));
-	if ((header.flags & SVE_PT_REGS_MASK) == SVE_PT_REGS_FPSIMD)
+	BUILD_BUG_ON(SVE_PT_SVE_OFFSET != sizeof(header));
+
+	switch ((header.flags & SVE_PT_REGS_MASK)) {
+	case SVE_PT_REGS_FPSIMD:
 		return __fpr_get(target, regset, to);
 
-	/* Otherwise: full SVE case */
+	case SVE_PT_REGS_SVE:
+		start = SVE_PT_SVE_OFFSET;
+		end = SVE_PT_SVE_FFR_OFFSET(vq) + SVE_PT_SVE_FFR_SIZE(vq);
+		membuf_write(&to, target->thread.sve_state, end - start);
 
-	BUILD_BUG_ON(SVE_PT_SVE_OFFSET != sizeof(header));
-	start = SVE_PT_SVE_OFFSET;
-	end = SVE_PT_SVE_FFR_OFFSET(vq) + SVE_PT_SVE_FFR_SIZE(vq);
-	membuf_write(&to, target->thread.sve_state, end - start);
+		start = end;
+		end = SVE_PT_SVE_FPSR_OFFSET(vq);
+		membuf_zero(&to, end - start);
 
-	start = end;
-	end = SVE_PT_SVE_FPSR_OFFSET(vq);
-	membuf_zero(&to, end - start);
+		/*
+		 * Copy fpsr, and fpcr which must follow contiguously in
+		 * struct fpsimd_state:
+		 */
+		start = end;
+		end = SVE_PT_SVE_FPCR_OFFSET(vq) + SVE_PT_SVE_FPCR_SIZE;
+		membuf_write(&to, &target->thread.uw.fpsimd_state.fpsr,
+			     end - start);
 
-	/*
-	 * Copy fpsr, and fpcr which must follow contiguously in
-	 * struct fpsimd_state:
-	 */
-	start = end;
-	end = SVE_PT_SVE_FPCR_OFFSET(vq) + SVE_PT_SVE_FPCR_SIZE;
-	membuf_write(&to, &target->thread.uw.fpsimd_state.fpsr, end - start);
+		start = end;
+		end = sve_size_from_header(&header);
+		return membuf_zero(&to, end - start);
 
-	start = end;
-	end = sve_size_from_header(&header);
-	return membuf_zero(&to, end - start);
+	default:
+		return 0;
+	}
 }
 
-static int sve_set(struct task_struct *target,
+static int sve_get(struct task_struct *target,
 		   const struct user_regset *regset,
-		   unsigned int pos, unsigned int count,
-		   const void *kbuf, const void __user *ubuf)
+		   struct membuf to)
+{
+	if (!system_supports_sve())
+		return -EINVAL;
+
+	return sve_get_common(target, regset, to, ARM64_VEC_SVE);
+}
+
+static int sve_set_common(struct task_struct *target,
+			  const struct user_regset *regset,
+			  unsigned int pos, unsigned int count,
+			  const void *kbuf, const void __user *ubuf,
+			  enum vec_type type)
 {
 	int ret;
 	struct user_sve_header header;
 	unsigned int vq;
 	unsigned long start, end;
 
-	if (!system_supports_sve())
-		return -EINVAL;
-
 	/* Header */
 	if (count < sizeof(header))
 		return -EINVAL;
@@ -814,13 +854,37 @@ static int sve_set(struct task_struct *target,
 	 * Apart from SVE_PT_REGS_MASK, all SVE_PT_* flags are consumed by
 	 * vec_set_vector_length(), which will also validate them for us:
 	 */
-	ret = vec_set_vector_length(target, ARM64_VEC_SVE, header.vl,
+	ret = vec_set_vector_length(target, type, header.vl,
 		((unsigned long)header.flags & ~SVE_PT_REGS_MASK) << 16);
 	if (ret)
 		goto out;
 
 	/* Actual VL set may be less than the user asked for: */
-	vq = sve_vq_from_vl(task_get_sve_vl(target));
+	vq = sve_vq_from_vl(task_get_vl(target, type));
+
+	/* Enter/exit streaming mode */
+	if (system_supports_sme()) {
+		u64 old_svcr = target->thread.svcr;
+
+		switch (type) {
+		case ARM64_VEC_SVE:
+			target->thread.svcr &= ~SYS_SVCR_EL0_SM_MASK;
+			break;
+		case ARM64_VEC_SME:
+			target->thread.svcr |= SYS_SVCR_EL0_SM_MASK;
+			break;
+		default:
+			WARN_ON_ONCE(1);
+			return -EINVAL;
+		}
+
+		/*
+		 * If we switched then invalidate any existing SVE
+		 * state and ensure there's storage.
+		 */
+		if (target->thread.svcr != old_svcr)
+			sve_alloc(target);
+	}
 
 	/* Registers: FPSIMD-only case */
 
@@ -832,7 +896,10 @@ static int sve_set(struct task_struct *target,
 		goto out;
 	}
 
-	/* Otherwise: full SVE case */
+	/*
+	 * Otherwise: no registers or full SVE case.  For backwards
+	 * compatibility reasons we treat empty flags as SVE registers.
+	 */
 
 	/*
 	 * If setting a different VL from the requested VL and there is
@@ -853,8 +920,9 @@ static int sve_set(struct task_struct *target,
 
 	/*
 	 * Ensure target->thread.sve_state is up to date with target's
-	 * FPSIMD regs, so that a short copyin leaves trailing registers
-	 * unmodified.
+	 * FPSIMD regs, so that a short copyin leaves trailing
+	 * registers unmodified.  Always enable SVE even if going into
+	 * streaming mode.
 	 */
 	fpsimd_sync_to_sve(target);
 	set_tsk_thread_flag(target, TIF_SVE);
@@ -890,8 +958,46 @@ static int sve_set(struct task_struct *target,
 	return ret;
 }
 
+static int sve_set(struct task_struct *target,
+		   const struct user_regset *regset,
+		   unsigned int pos, unsigned int count,
+		   const void *kbuf, const void __user *ubuf)
+{
+	if (!system_supports_sve())
+		return -EINVAL;
+
+	return sve_set_common(target, regset, pos, count, kbuf, ubuf,
+			      ARM64_VEC_SVE);
+}
+
 #endif /* CONFIG_ARM64_SVE */
 
+#ifdef CONFIG_ARM64_SME
+
+static int ssve_get(struct task_struct *target,
+		   const struct user_regset *regset,
+		   struct membuf to)
+{
+	if (!system_supports_sme())
+		return -EINVAL;
+
+	return sve_get_common(target, regset, to, ARM64_VEC_SME);
+}
+
+static int ssve_set(struct task_struct *target,
+		    const struct user_regset *regset,
+		    unsigned int pos, unsigned int count,
+		    const void *kbuf, const void __user *ubuf)
+{
+	if (!system_supports_sme())
+		return -EINVAL;
+
+	return sve_set_common(target, regset, pos, count, kbuf, ubuf,
+			      ARM64_VEC_SME);
+}
+
+#endif /* CONFIG_ARM64_SME */
+
 #ifdef CONFIG_ARM64_PTR_AUTH
 static int pac_mask_get(struct task_struct *target,
 			const struct user_regset *regset,
@@ -1109,6 +1215,9 @@ enum aarch64_regset {
 #ifdef CONFIG_ARM64_SVE
 	REGSET_SVE,
 #endif
+#ifdef CONFIG_ARM64_SVE
+	REGSET_SSVE,
+#endif
 #ifdef CONFIG_ARM64_PTR_AUTH
 	REGSET_PAC_MASK,
 	REGSET_PAC_ENABLED_KEYS,
@@ -1189,6 +1298,17 @@ static const struct user_regset aarch64_regsets[] = {
 		.set = sve_set,
 	},
 #endif
+#ifdef CONFIG_ARM64_SME
+	[REGSET_SSVE] = { /* Streaming mode SVE */
+		.core_note_type = NT_ARM_SSVE,
+		.n = DIV_ROUND_UP(SVE_PT_SIZE(SVE_VQ_MAX, SVE_PT_REGS_SVE),
+				  SVE_VQ_BYTES),
+		.size = SVE_VQ_BYTES,
+		.align = SVE_VQ_BYTES,
+		.regset_get = ssve_get,
+		.set = ssve_set,
+	},
+#endif
 #ifdef CONFIG_ARM64_PTR_AUTH
 	[REGSET_PAC_MASK] = {
 		.core_note_type = NT_ARM_PAC_MASK,
diff --git a/include/uapi/linux/elf.h b/include/uapi/linux/elf.h
index 61bf4774b8f2..61502388683f 100644
--- a/include/uapi/linux/elf.h
+++ b/include/uapi/linux/elf.h
@@ -427,6 +427,7 @@ typedef struct elf64_shdr {
 #define NT_ARM_PACG_KEYS	0x408	/* ARM pointer authentication generic key */
 #define NT_ARM_TAGGED_ADDR_CTRL	0x409	/* arm64 tagged address control (prctl()) */
 #define NT_ARM_PAC_ENABLED_KEYS	0x40a	/* arm64 ptr auth enabled keys (prctl()) */
+#define NT_ARM_SSVE	0x40b		/* ARM Streaming SVE registers */
 #define NT_ARC_V2	0x600		/* ARCv2 accumulator/extra registers */
 #define NT_VMCOREDD	0x700		/* Vmcore Device Dump Note */
 #define NT_MIPS_DSP	0x800		/* MIPS DSP ASE registers */
-- 
2.30.2

