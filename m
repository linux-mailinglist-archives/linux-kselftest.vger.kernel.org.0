Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BDCF7D8309
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Oct 2023 14:47:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231195AbjJZMrj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 26 Oct 2023 08:47:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235014AbjJZMrU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 26 Oct 2023 08:47:20 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 657AD1722;
        Thu, 26 Oct 2023 05:47:10 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10565C433CB;
        Thu, 26 Oct 2023 12:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698324429;
        bh=P/MK23RoQa3xV9BTA1XSgjVaNHyyLLWBg+19ufBz12Q=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=O5TiAGsUsHGwNs8g1Ry4TWQRuoKVLW4jkkNl/JjjgKgClIbHm0BSbNFdl3USgrWxF
         t9dVrLhyGNFCJBXZHiwfy2aqwgyv1l7P2Ib3lK5Lt6HH5+dCbl9nowU9J1jFADd1/T
         zQa2v1ijroHw2GKzRyH4R6EwFEEbZY8BeR0MGSzUw1pevWtW6rJ4zUiydyAfALwGNY
         p+sG46Dw8GJPDIhgqPLaLTY/L/DozD4vA843GwUTz2hQkGq/2+skCmVLwXrBV25UML
         N/sE+fLgTB9kF11RPxXSqGYCiSUJH8WT4DKCzJU3ZTGaOcikuK+od1Pn/MsjhOYy1B
         /UZ+Yz6mOqd+A==
From:   Mark Brown <broonie@kernel.org>
Date:   Thu, 26 Oct 2023 13:44:25 +0100
Subject: [PATCH 11/21] arm64/fpsimd: Support FEAT_FPMR
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231026-arm64-2023-dpisa-v1-11-8470dd989bb2@kernel.org>
References: <20231026-arm64-2023-dpisa-v1-0-8470dd989bb2@kernel.org>
In-Reply-To: <20231026-arm64-2023-dpisa-v1-0-8470dd989bb2@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kvmarm@lists.linux.dev, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-0438c
X-Developer-Signature: v=1; a=openpgp-sha256; l=6769; i=broonie@kernel.org;
 h=from:subject:message-id; bh=P/MK23RoQa3xV9BTA1XSgjVaNHyyLLWBg+19ufBz12Q=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlOl+cvI35TLTZu/lVQIbg6QyuZqTAbAVwqCaLpoZW
 kyxfdTKJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZTpfnAAKCRAk1otyXVSH0BpPB/
 9rUy788ZDLctH9y03YOLxEstNPheVNgfcVeR/TDoJ72b2DPj1syWiFBF/E2yjVBvwY6LFU0ox9Jmic
 4YUAhf2cHDVKNUNf4JTGcLxSVC12tnMx+gEEESJImiTx0jCxhCqwFMoV2iX0EX7M1Ur8sN/BeSGoNk
 JOiUej3ERdv7FqJASCfRL67SD3RWTe4QhYpETl2IoZWJ3WVZv08nzchtChPS4cp2NkV7EJwMuRlS3a
 pnxNhtTxTxc126belPuKrOCbEHYBiHXSbvzkJsk80hn/YR1AdDkfRCsjJ7oS+Zq1ThHZqOQ1IBuUS6
 EMM6qeZMBetiwo3/cRfxwdMCpAWEEj
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

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
index 5bba39376055..9b93ba4a5a3d 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -779,6 +779,11 @@ static __always_inline bool system_supports_tpidr2(void)
 	return system_supports_sme();
 }
 
+static __always_inline bool system_supports_fpmr(void)
+{
+	return cpus_have_const_cap(ARM64_HAS_FPMR);
+}
+
 static __always_inline bool system_supports_cnp(void)
 {
 	return IS_ENABLED(CONFIG_ARM64_CNP) &&
diff --git a/arch/arm64/include/asm/fpsimd.h b/arch/arm64/include/asm/fpsimd.h
index 8df46f186c64..5f921ebb7ca4 100644
--- a/arch/arm64/include/asm/fpsimd.h
+++ b/arch/arm64/include/asm/fpsimd.h
@@ -63,6 +63,7 @@ struct cpu_fp_state {
 	void *sve_state;
 	void *sme_state;
 	u64 *svcr;
+	u64 *fpmr;
 	unsigned int sve_vl;
 	unsigned int sme_vl;
 	enum fp_type *fp_type;
@@ -127,6 +128,7 @@ extern void sve_kernel_enable(const struct arm64_cpu_capabilities *__unused);
 extern void sme_kernel_enable(const struct arm64_cpu_capabilities *__unused);
 extern void sme2_kernel_enable(const struct arm64_cpu_capabilities *__unused);
 extern void fa64_kernel_enable(const struct arm64_cpu_capabilities *__unused);
+extern void fpmr_kernel_enable(const struct arm64_cpu_capabilities *__unused);
 
 extern u64 read_zcr_features(void);
 extern u64 read_smcr_features(void);
diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index af06ccb7ee34..2151c1cbc53d 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -481,6 +481,7 @@ struct kvm_vcpu_arch {
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
index c1658d893e0e..8e8cd411d1a2 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -272,6 +272,7 @@ static const struct arm64_ftr_bits ftr_id_aa64pfr1[] = {
 };
 
 static const struct arm64_ftr_bits ftr_id_aa64pfr2[] = {
+	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64PFR2_EL1_FPMR_SHIFT, 4, 0),
 	ARM64_FTR_END,
 };
 
@@ -2747,6 +2748,14 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 		.matches = has_cpuid_feature,
 		ARM64_CPUID_FIELDS(ID_AA64MMFR2_EL1, EVT, IMP)
 	},
+	{
+		.desc = "FPMR",
+		.type = ARM64_CPUCAP_SYSTEM_FEATURE,
+		.capability = ARM64_HAS_FPMR,
+		.matches = has_cpuid_feature,
+		.cpu_enable = fpmr_kernel_enable,
+		ARM64_CPUID_FIELDS(ID_AA64PFR2_EL1, FPMR, IMP)
+	},
 	{},
 };
 
diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index 91e44ac7150f..88a541b14d39 100644
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
@@ -716,6 +722,12 @@ static void sve_to_fpsimd(struct task_struct *task)
 	}
 }
 
+void fpmr_kernel_enable(const struct arm64_cpu_capabilities *__always_unused p)
+{
+	write_sysreg_s(read_sysreg_s(SYS_SCTLR_EL1) | SCTLR_EL1_EnFPM_MASK,
+		       SYS_SCTLR_EL1);
+}
+
 #ifdef CONFIG_ARM64_SVE
 /*
  * Call __sve_free() directly only if you know task can't be scheduled
@@ -1729,6 +1741,7 @@ static void fpsimd_bind_task_to_cpu(void)
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
index dea3dc89234b..11b0e3360a2a 100644
--- a/arch/arm64/tools/cpucaps
+++ b/arch/arm64/tools/cpucaps
@@ -26,6 +26,7 @@ HAS_ECV
 HAS_ECV_CNTPOFF
 HAS_EPAN
 HAS_EVT
+HAS_FPMR
 HAS_FGT
 HAS_GENERIC_AUTH
 HAS_GENERIC_AUTH_ARCH_QARMA3

-- 
2.30.2

