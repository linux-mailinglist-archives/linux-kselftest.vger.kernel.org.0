Return-Path: <linux-kselftest+bounces-1167-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E9AA805A63
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Dec 2023 17:51:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FBB31C21215
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Dec 2023 16:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 946085D8F4;
	Tue,  5 Dec 2023 16:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ARVVaqwB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 732BD4174B;
	Tue,  5 Dec 2023 16:51:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A2C0C433D9;
	Tue,  5 Dec 2023 16:51:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701795107;
	bh=8aMhtvWd2U4DgD7OsoWitXafC2Gl0m4G3yGyGq+lQbA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ARVVaqwBsRNjIG6UoLNTooDt9ZkQhpDEELPZinsTgX67bv+B1qNQ1EtNya1Gi20YY
	 79zoOmKES3Dn+7OKrF2wLaMVJ5zbctUq/+0gAB0eEnM17jGkcVm+6y/dxDOr1KgwnW
	 ygMveDFyBvmXHwk/F/6KIx1Kos6WyK6U7xqB46gzETG2YZsKOLo0EavKvrH2Oc7d3I
	 8ObUXE11tf75hmFfBRNh8GjVpVvzWwGpomOusMQcOjUebBQTPK8eAqVJpjgifLvM4T
	 1KuWvg8Uo7pSiIdekNQIgwkJKRARKUn+0pXF07aSwemxZ6FGgfOQDMbTMX1Cu25mK+
	 Uf7p2Fmj4rDog==
From: Mark Brown <broonie@kernel.org>
Date: Tue, 05 Dec 2023 16:48:09 +0000
Subject: [PATCH v3 11/21] arm64/fpsimd: Support FEAT_FPMR
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231205-arm64-2023-dpisa-v3-11-dbcbcd867a7f@kernel.org>
References: <20231205-arm64-2023-dpisa-v3-0-dbcbcd867a7f@kernel.org>
In-Reply-To: <20231205-arm64-2023-dpisa-v3-0-dbcbcd867a7f@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, 
 Oliver Upton <oliver.upton@linux.dev>, James Morse <james.morse@arm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 kvmarm@lists.linux.dev, linux-doc@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-5c066
X-Developer-Signature: v=1; a=openpgp-sha256; l=6717; i=broonie@kernel.org;
 h=from:subject:message-id; bh=8aMhtvWd2U4DgD7OsoWitXafC2Gl0m4G3yGyGq+lQbA=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlb1Tx4ufTMGq++6xAGUsvJwEfm2UexNq/AP6QrS5l
 qw5qM2GJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZW9U8QAKCRAk1otyXVSH0AhvB/
 4pU53JQZCGqkuHtTf3gxhaCiAMud/JEGHdQ/7sfyy3RH6NZ3Hk2Nq4rqfrMfyPN4qStSERJsli6VqV
 tY0FkwjD4CXalsKYcszrxDzZhN74qJYURRnQ6idMRtfmtrY3X9Q6MT+iOQ1HSu4H0NfdIjzwF6oJer
 nglQJ0nSQnzkPNclnYh3CY21L62NeyZ+tOoFARhvo4l4/CoQ3653uw2hKnQcQ14GXnLSzPgM9Zbf97
 9xPrzvLxbPR0x/rjV+XRAPotz2tLCYcsLL3Z4I1Zg5xrBl8BbLG/3PM2tVQ1v2DTTf5VsbMY5UpSfN
 SS/nEw+qXNIJ0RgRyMNMGm9WlFMxV6
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

FEAT_FPMR defines a new EL0 accessible register FPMR use to configure the
FP8 related features added to the architecture at the same time. Detect
support for this register and context switch it for EL0 when present.

Due to the sharing of responsibility for saving floating point state
between the host kernel and KVM FP8 support is not yet implemented in KVM
and a stub similar to that used for SVCR is provided for FPMR in order to
avoid bisection issues.  To make it easier to share host state with the
hypervisor we store FPMR immediately after the base floating point
state, existing usage means that it is not practical to extend that
directly.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/include/asm/cpufeature.h |  5 +++++
 arch/arm64/include/asm/fpsimd.h     |  2 ++
 arch/arm64/include/asm/kvm_host.h   |  1 +
 arch/arm64/include/asm/processor.h  |  2 ++
 arch/arm64/kernel/cpufeature.c      |  9 +++++++++
 arch/arm64/kernel/fpsimd.c          | 13 +++++++++++++
 arch/arm64/kvm/fpsimd.c             |  1 +
 arch/arm64/tools/cpucaps            |  1 +
 8 files changed, 34 insertions(+)

diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index f6d416fe49b0..8e83cb1e6c7c 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -767,6 +767,11 @@ static __always_inline bool system_supports_tpidr2(void)
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
index 50e5f25d3024..74afca3bd312 100644
--- a/arch/arm64/include/asm/fpsimd.h
+++ b/arch/arm64/include/asm/fpsimd.h
@@ -89,6 +89,7 @@ struct cpu_fp_state {
 	void *sve_state;
 	void *sme_state;
 	u64 *svcr;
+	u64 *fpmr;
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
index 824f29f04916..f8d98985a39c 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -517,6 +517,7 @@ struct kvm_vcpu_arch {
 	enum fp_type fp_type;
 	unsigned int sve_max_vl;
 	u64 svcr;
+	u64 fpmr;
 
 	/* Stage 2 paging state used by the hardware on next switch */
 	struct kvm_s2_mmu *hw_mmu;
diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/processor.h
index e5bc54522e71..dd3a5b29f76e 100644
--- a/arch/arm64/include/asm/processor.h
+++ b/arch/arm64/include/asm/processor.h
@@ -158,6 +158,8 @@ struct thread_struct {
 		struct user_fpsimd_state fpsimd_state;
 	} uw;
 
+	u64			fpmr;		/* Adjacent to fpsimd_state for KVM */
+
 	enum fp_type		fp_type;	/* registers FPSIMD or SVE? */
 	unsigned int		fpsimd_cpu;
 	void			*sve_state;	/* SVE registers, if any */
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index c8d38e5ce997..ea0b680792de 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -272,6 +272,7 @@ static const struct arm64_ftr_bits ftr_id_aa64pfr1[] = {
 };
 
 static const struct arm64_ftr_bits ftr_id_aa64pfr2[] = {
+	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64PFR2_EL1_FPMR_SHIFT, 4, 0),
 	ARM64_FTR_END,
 };
 
@@ -2759,6 +2760,14 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 		.matches = has_cpuid_feature,
 		ARM64_CPUID_FIELDS(ID_AA64MMFR2_EL1, EVT, IMP)
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
index 1559c706d32d..2a6abd6423f7 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -385,6 +385,9 @@ static void task_fpsimd_load(void)
 	WARN_ON(!system_supports_fpsimd());
 	WARN_ON(!have_cpu_fpsimd_context());
 
+	if (system_supports_fpmr())
+		write_sysreg_s(current->thread.fpmr, SYS_FPMR);
+
 	if (system_supports_sve() || system_supports_sme()) {
 		switch (current->thread.fp_type) {
 		case FP_STATE_FPSIMD:
@@ -472,6 +475,9 @@ static void fpsimd_save(void)
 	if (test_thread_flag(TIF_FOREIGN_FPSTATE))
 		return;
 
+	if (system_supports_fpmr())
+		*(last->fpmr) = read_sysreg_s(SYS_FPMR);
+
 	/*
 	 * If a task is in a syscall the ABI allows us to only
 	 * preserve the state shared with FPSIMD so don't bother
@@ -714,6 +720,12 @@ static void sve_to_fpsimd(struct task_struct *task)
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
@@ -1671,6 +1683,7 @@ static void fpsimd_bind_task_to_cpu(void)
 	last->sve_vl = task_get_sve_vl(current);
 	last->sme_vl = task_get_sme_vl(current);
 	last->svcr = &current->thread.svcr;
+	last->fpmr = &current->thread.fpmr;
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
index b98c38288a9d..7a249a950bbc 100644
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


