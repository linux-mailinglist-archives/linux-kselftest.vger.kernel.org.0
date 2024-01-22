Return-Path: <linux-kselftest+bounces-3337-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4F00836D30
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Jan 2024 18:26:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7513428EF78
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Jan 2024 17:26:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC42C679FB;
	Mon, 22 Jan 2024 16:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="loaz/CAD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E4896774D;
	Mon, 22 Jan 2024 16:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705940917; cv=none; b=spUG2nLaQ5JfaBAa7fZ2r+StG1VbY6tHtgNKqIvyjaTtrkV6Bwqcw9Zq31kSqPQjTBMrn499hKz3GurSm1NM4gu4//VQmgbQbIK3JNQ8TpZwnRVJDXCLD4M+cR4c0nBm2u0O2beUqm560Qy9hTDqD+L6py1Ey7sKhIgEm8mfRR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705940917; c=relaxed/simple;
	bh=lYhaJYrF5xvKkxhGT6KR+gulaOYrM4vUcYbJ6FuCpeo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cHEv/mK8hmgDmhmnO+0PfWBOHNPpTDmOd8QCAMMT4CO9QV9bb7lHNKDxYd8QxroGu7izWOfhgYDVcI2sPyxYdZ+Z3twfetbB6+4MAMiasxaTAjJh9JNqBA7j/Ewxar+ydp0F/6J7qG3MsSJ0WLYUub8yAh0f6jvsnbc6uMlfcuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=loaz/CAD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0015EC43394;
	Mon, 22 Jan 2024 16:28:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705940917;
	bh=lYhaJYrF5xvKkxhGT6KR+gulaOYrM4vUcYbJ6FuCpeo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=loaz/CADKkUB7ldCby7wZIGzn+JEcsvdqDfHN/aVk7mYl2xb/SwAHlBJwOpZwdWjX
	 eEtJ8+jnU9futIqm/Pq7vYAHDuB2kyImRRLa1/CJPmcmC/gbJHz9Hzic9oZyW1Po8b
	 rbeJEjOH8gOuHJtynvk18P4kuPAzvV1P1zdCFopxgWeDs7enUcY8PcNWj+0xtDL+As
	 qxgpbfyCuxobPHaElKAAlqivs4jaKOnZVxGGqhCg/h9aEfWYERGH8IR01Pvz/LduPK
	 6uYAIWWY9WPanM3WAV8jJcfE2E1eOxss7DV2bvtHAQh4TQ3pDoydfu18NL60ySlTHw
	 RZusi3CKjKqiA==
From: Mark Brown <broonie@kernel.org>
Date: Mon, 22 Jan 2024 16:28:06 +0000
Subject: [PATCH v4 03/14] arm64/fpsimd: Support FEAT_FPMR
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240122-arm64-2023-dpisa-v4-3-776e094861df@kernel.org>
References: <20240122-arm64-2023-dpisa-v4-0-776e094861df@kernel.org>
In-Reply-To: <20240122-arm64-2023-dpisa-v4-0-776e094861df@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, 
 Oliver Upton <oliver.upton@linux.dev>, James Morse <james.morse@arm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Dave Martin <dave.martin@arm.com>, kvmarm@lists.linux.dev, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-5c066
X-Developer-Signature: v=1; a=openpgp-sha256; l=7109; i=broonie@kernel.org;
 h=from:subject:message-id; bh=lYhaJYrF5xvKkxhGT6KR+gulaOYrM4vUcYbJ6FuCpeo=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlrpeddVHRv46awyuFdFR+eQc6M0orp8lLjE4hF4gQ
 eCD0+l6JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZa6XnQAKCRAk1otyXVSH0DQOB/
 9+H+eHgI7ufgspYX3wfXMQeZyItq0Kc+dpBoQWQZOKEh2enm9S4k9G921zZ32FnqdhBFpNgfQH9FmR
 JoqW+c/Xh9JtUH9W41N3qlbS17Q6jaf9clr1WvxgqE2MJJ4betyW5tZkFjQ4Bf7DNbtTBAVQyhlugp
 qhGNjgXSMtUoPJ76DKUJDq+jhfd2C1dSSqUkA5XoJVZHuooUmlc+KQEqNagWnnN2199FYm88Slc9hR
 cZMWTS3zpfRVX6aZrXsIf/bkpeY4b4EY/sD1hElOdjaPfWZnghib6VJ0lJVBYVLkgbU/UGJSuucLur
 icmms8WF22Cc1xL6zVi7DQV863092t
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

FEAT_FPMR defines a new EL0 accessible register FPMR use to configure the
FP8 related features added to the architecture at the same time. Detect
support for this register and context switch it for EL0 when present.

Due to the sharing of responsibility for saving floating point state
between the host kernel and KVM FP8 support is not yet implemented in KVM
and a stub similar to that used for SVCR is provided for FPMR in order to
avoid bisection issues. To make it easier to share host state with the
hypervisor we store FPMR as a hardened usercopy field in uw (along with
some padding).

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/include/asm/cpufeature.h |  5 +++++
 arch/arm64/include/asm/fpsimd.h     |  2 ++
 arch/arm64/include/asm/kvm_host.h   |  1 +
 arch/arm64/include/asm/processor.h  |  4 ++++
 arch/arm64/kernel/cpufeature.c      |  9 +++++++++
 arch/arm64/kernel/fpsimd.c          | 13 +++++++++++++
 arch/arm64/kvm/fpsimd.c             |  1 +
 arch/arm64/tools/cpucaps            |  1 +
 8 files changed, 36 insertions(+)

diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index 21c824edf8ce..34fcdbc65d7d 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -768,6 +768,11 @@ static __always_inline bool system_supports_tpidr2(void)
 	return system_supports_sme();
 }
 
+static __always_inline bool system_supports_fpmr(void)
+{
+	return alternative_has_cap_unlikely(ARM64_HAS_FPMR);
+}
+
 static __always_inline bool system_supports_cnp(void)
 {
 	return alternative_has_cap_unlikely(ARM64_HAS_CNP);
diff --git a/arch/arm64/include/asm/fpsimd.h b/arch/arm64/include/asm/fpsimd.h
index 50e5f25d3024..6cf72b0d2c04 100644
--- a/arch/arm64/include/asm/fpsimd.h
+++ b/arch/arm64/include/asm/fpsimd.h
@@ -89,6 +89,7 @@ struct cpu_fp_state {
 	void *sve_state;
 	void *sme_state;
 	u64 *svcr;
+	unsigned long *fpmr;
 	unsigned int sve_vl;
 	unsigned int sme_vl;
 	enum fp_type *fp_type;
@@ -154,6 +155,7 @@ extern void cpu_enable_sve(const struct arm64_cpu_capabilities *__unused);
 extern void cpu_enable_sme(const struct arm64_cpu_capabilities *__unused);
 extern void cpu_enable_sme2(const struct arm64_cpu_capabilities *__unused);
 extern void cpu_enable_fa64(const struct arm64_cpu_capabilities *__unused);
+extern void cpu_enable_fpmr(const struct arm64_cpu_capabilities *__unused);
 
 extern u64 read_smcr_features(void);
 
diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 21c57b812569..7993694a54af 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -543,6 +543,7 @@ struct kvm_vcpu_arch {
 	enum fp_type fp_type;
 	unsigned int sve_max_vl;
 	u64 svcr;
+	unsigned long fpmr;
 
 	/* Stage 2 paging state used by the hardware on next switch */
 	struct kvm_s2_mmu *hw_mmu;
diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/processor.h
index 5b0a04810b23..b453c66d3fae 100644
--- a/arch/arm64/include/asm/processor.h
+++ b/arch/arm64/include/asm/processor.h
@@ -155,6 +155,8 @@ struct thread_struct {
 	struct {
 		unsigned long	tp_value;	/* TLS register */
 		unsigned long	tp2_value;
+		unsigned long	fpmr;
+		unsigned long	pad;
 		struct user_fpsimd_state fpsimd_state;
 	} uw;
 
@@ -253,6 +255,8 @@ static inline void arch_thread_struct_whitelist(unsigned long *offset,
 	BUILD_BUG_ON(sizeof_field(struct thread_struct, uw) !=
 		     sizeof_field(struct thread_struct, uw.tp_value) +
 		     sizeof_field(struct thread_struct, uw.tp2_value) +
+		     sizeof_field(struct thread_struct, uw.fpmr) +
+		     sizeof_field(struct thread_struct, uw.pad) +
 		     sizeof_field(struct thread_struct, uw.fpsimd_state));
 
 	*offset = offsetof(struct thread_struct, uw);
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index eae59ec0f4b0..0263565f617a 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -272,6 +272,7 @@ static const struct arm64_ftr_bits ftr_id_aa64pfr1[] = {
 };
 
 static const struct arm64_ftr_bits ftr_id_aa64pfr2[] = {
+	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64PFR2_EL1_FPMR_SHIFT, 4, 0),
 	ARM64_FTR_END,
 };
 
@@ -2767,6 +2768,14 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 		.type = ARM64_CPUCAP_SYSTEM_FEATURE,
 		.matches = has_lpa2,
 	},
+	{
+		.desc = "FPMR",
+		.type = ARM64_CPUCAP_SYSTEM_FEATURE,
+		.capability = ARM64_HAS_FPMR,
+		.matches = has_cpuid_feature,
+		.cpu_enable = cpu_enable_fpmr,
+		ARM64_CPUID_FIELDS(ID_AA64PFR2_EL1, FPMR, IMP)
+	},
 	{},
 };
 
diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index a5dc6f764195..8e24b5e5e192 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -359,6 +359,9 @@ static void task_fpsimd_load(void)
 	WARN_ON(preemptible());
 	WARN_ON(test_thread_flag(TIF_KERNEL_FPSTATE));
 
+	if (system_supports_fpmr())
+		write_sysreg_s(current->thread.uw.fpmr, SYS_FPMR);
+
 	if (system_supports_sve() || system_supports_sme()) {
 		switch (current->thread.fp_type) {
 		case FP_STATE_FPSIMD:
@@ -446,6 +449,9 @@ static void fpsimd_save_user_state(void)
 	if (test_thread_flag(TIF_FOREIGN_FPSTATE))
 		return;
 
+	if (system_supports_fpmr())
+		*(last->fpmr) = read_sysreg_s(SYS_FPMR);
+
 	/*
 	 * If a task is in a syscall the ABI allows us to only
 	 * preserve the state shared with FPSIMD so don't bother
@@ -688,6 +694,12 @@ static void sve_to_fpsimd(struct task_struct *task)
 	}
 }
 
+void cpu_enable_fpmr(const struct arm64_cpu_capabilities *__always_unused p)
+{
+	write_sysreg_s(read_sysreg_s(SYS_SCTLR_EL1) | SCTLR_EL1_EnFPM_MASK,
+		       SYS_SCTLR_EL1);
+}
+
 #ifdef CONFIG_ARM64_SVE
 /*
  * Call __sve_free() directly only if you know task can't be scheduled
@@ -1680,6 +1692,7 @@ static void fpsimd_bind_task_to_cpu(void)
 	last->sve_vl = task_get_sve_vl(current);
 	last->sme_vl = task_get_sme_vl(current);
 	last->svcr = &current->thread.svcr;
+	last->fpmr = &current->thread.uw.fpmr;
 	last->fp_type = &current->thread.fp_type;
 	last->to_save = FP_STATE_CURRENT;
 	current->thread.fpsimd_cpu = smp_processor_id();
diff --git a/arch/arm64/kvm/fpsimd.c b/arch/arm64/kvm/fpsimd.c
index 8c1d0d4853df..e3e611e30e91 100644
--- a/arch/arm64/kvm/fpsimd.c
+++ b/arch/arm64/kvm/fpsimd.c
@@ -153,6 +153,7 @@ void kvm_arch_vcpu_ctxsync_fp(struct kvm_vcpu *vcpu)
 		fp_state.sve_vl = vcpu->arch.sve_max_vl;
 		fp_state.sme_state = NULL;
 		fp_state.svcr = &vcpu->arch.svcr;
+		fp_state.fpmr = &vcpu->arch.fpmr;
 		fp_state.fp_type = &vcpu->arch.fp_type;
 
 		if (vcpu_has_sve(vcpu))
diff --git a/arch/arm64/tools/cpucaps b/arch/arm64/tools/cpucaps
index b912b1409fc0..63283550c8e8 100644
--- a/arch/arm64/tools/cpucaps
+++ b/arch/arm64/tools/cpucaps
@@ -26,6 +26,7 @@ HAS_ECV
 HAS_ECV_CNTPOFF
 HAS_EPAN
 HAS_EVT
+HAS_FPMR
 HAS_FGT
 HAS_FPSIMD
 HAS_GENERIC_AUTH

-- 
2.30.2


