Return-Path: <linux-kselftest+bounces-40562-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 09155B3FE07
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Sep 2025 13:44:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7501F2C0FF0
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Sep 2025 11:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36F892FABF5;
	Tue,  2 Sep 2025 11:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SCjY40uk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 046332FABED;
	Tue,  2 Sep 2025 11:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756813470; cv=none; b=oDhTjzEjoP//J04XxTmMS/fjDD16SQeJVlRjHeStekzlRfxEwySLIUG+11kMdU0q9xv1fUQvLghncYdF4iFG+Bl05CvudhMxTrL/XTb6DDxMFw1Oggz+Q+Mnw/a+cb5310XVTPPD+lbO2x89cCY36uvcUm1fR2N+Rfw6+bWr38s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756813470; c=relaxed/simple;
	bh=84pzZs2B5XlM7NI3iiTFhdL+enlb8CJyDRVL7RoB/Dw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YV9x//RMsIv2yTRDmg/YxUaB+w53p8MOXJsT+f7Hf7VWXdjjz3AcBg/0Rhw21w4qHDc/uwvjdiKVcaRljO88ehidI/kaw+v1b/XqmrhZFyaLbwdQ4x8vNNHwOJYDiC29Ku4PXnfkxmqQc5dA8+hLANFrhE5QF9yHDgo1H4rz4wY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SCjY40uk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18D51C4CEF5;
	Tue,  2 Sep 2025 11:44:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756813469;
	bh=84pzZs2B5XlM7NI3iiTFhdL+enlb8CJyDRVL7RoB/Dw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=SCjY40ukWpJUT8EcC5agRxRrlPfCAe5S/rRV7pH6/kuzga2TvDjE8wsflJIyuOod3
	 FHNZy+ed4ylbZ9y9/bx7HrUhXcX71ZFprdyMv8aMU5d9enrTkeirJKUKW6SdqbEU+N
	 YYcUbMKLu2mnbk95k7kw55UUDRKHUHwkyK1mLHy2rBSdnhBAxsjD4r4EgV50ARMy9f
	 EMfiJ6l2TVAHAfxIcYErqRIVyzrJTSwG7O7YBwFpZEtY2iuUhNCXlAspRi7Icr3j9X
	 CRZlM6lpJgb3j6GBvFy24NqMaFrlPNooWsZhrGFUd3DZ2nTJn7QUsvrZ/hoWTXu71a
	 7VUukpow8oXrQ==
From: Mark Brown <broonie@kernel.org>
Date: Tue, 02 Sep 2025 12:36:05 +0100
Subject: [PATCH v8 02/29] arm64/fpsimd: Update FA64 and ZT0 enables when
 loading SME state
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250902-kvm-arm64-sme-v8-2-2cb2199c656c@kernel.org>
References: <20250902-kvm-arm64-sme-v8-0-2cb2199c656c@kernel.org>
In-Reply-To: <20250902-kvm-arm64-sme-v8-0-2cb2199c656c@kernel.org>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
 Joey Gouly <joey.gouly@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, Will Deacon <will@kernel.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <shuah@kernel.org>
Cc: Dave Martin <Dave.Martin@arm.com>, Fuad Tabba <tabba@google.com>, 
 Mark Rutland <mark.rutland@arm.com>, linux-arm-kernel@lists.infradead.org, 
 kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Eric Auger <eric.auger@redhat.com>, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-cff91
X-Developer-Signature: v=1; a=openpgp-sha256; l=5757; i=broonie@kernel.org;
 h=from:subject:message-id; bh=84pzZs2B5XlM7NI3iiTFhdL+enlb8CJyDRVL7RoB/Dw=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBotth7qkrxDzdPqe9mpmGIgLKBMlbhGEYFvQrPw
 hWjiFc0jTKJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaLbYewAKCRAk1otyXVSH
 0KQbB/99fq/7tUclHQv8VSWp4/W9ljkvkEbdQOQ9k5J7ULxJJ89NOu3XO+9HP0RxKgNj/NdhDBJ
 QtUtaUqIKUcdUFv9p5DAspL4tIScta+oRJ2b3vmalp8p9dfhvZAraoC3EmBqCaiQE9Inf1MO0FF
 xVnmZDVXnXEMHJjnB/0lxFAVGvR3u24D/mg16qw1nxg9BQ6LbQIMWL8yoJ46ZDW7L2kdUR5/0/L
 7s7ssyDf3C0g65ZnCX6pd6X/YWIBYm3HyPBZf4QY2lltaFZxYR6hFUtQcpOkggfhDMlt8GPanB9
 0cQ3jcckI+r3MIQxSigCcFbKRqypwkvlMtGcFwYA2owbIdfs
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

Currently we enable EL0 and EL1 access to FA64 and ZT0 at boot and leave
them enabled throughout the runtime of the system. When we add KVM support
we will need to make this configuration dynamic, these features may be
disabled for some KVM guests. Since the host kernel saves the floating
point state for non-protected guests and we wish to avoid KVM having to
reload the floating point state needlessly on guest reentry let's move the
configuration of these enables to the floating point state reload.

We provide a helper which does the configuration as part of a
read/modify/write operation along with the configuration of the task VL,
then update the floating point state load and SME access trap to use it.
We also remove the setting of the enable bits from the CPU feature
identification and resume paths.  There will be a small overhead from
setting the enables one at a time but this should be negligable in the
context of the state load or access trap.  In order to avoid compiler
warnings due to unused variables in !CONFIG_ARM64_SME cases we avoid
storing the vector length in temporary variables.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/include/asm/fpsimd.h | 14 ++++++++++++
 arch/arm64/kernel/cpufeature.c  |  2 --
 arch/arm64/kernel/fpsimd.c      | 47 +++++++++++------------------------------
 3 files changed, 26 insertions(+), 37 deletions(-)

diff --git a/arch/arm64/include/asm/fpsimd.h b/arch/arm64/include/asm/fpsimd.h
index b8cf0ea43cc0..b4359f942621 100644
--- a/arch/arm64/include/asm/fpsimd.h
+++ b/arch/arm64/include/asm/fpsimd.h
@@ -428,6 +428,18 @@ static inline size_t sme_state_size(struct task_struct const *task)
 	return __sme_state_size(task_get_sme_vl(task));
 }
 
+#define sme_cond_update_smcr(vl, fa64, zt0, reg)		\
+	do {							\
+		u64 __old = read_sysreg_s((reg));		\
+		u64 __new = vl;					\
+		if (fa64)			\
+			__new |= SMCR_ELx_FA64;			\
+		if (zt0)					\
+			__new |= SMCR_ELx_EZT0;			\
+		if (__old != __new)				\
+			write_sysreg_s(__new, (reg));		\
+	} while (0)
+
 #else
 
 static inline void sme_user_disable(void) { BUILD_BUG(); }
@@ -456,6 +468,8 @@ static inline size_t sme_state_size(struct task_struct const *task)
 	return 0;
 }
 
+#define sme_cond_update_smcr(val, fa64, zt0, reg) do { } while (0)
+
 #endif /* ! CONFIG_ARM64_SME */
 
 /* For use by EFI runtime services calls only */
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 9ad065f15f1d..85d091d3b279 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -2961,7 +2961,6 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 		.type = ARM64_CPUCAP_SYSTEM_FEATURE,
 		.capability = ARM64_SME_FA64,
 		.matches = has_cpuid_feature,
-		.cpu_enable = cpu_enable_fa64,
 		ARM64_CPUID_FIELDS(ID_AA64SMFR0_EL1, FA64, IMP)
 	},
 	{
@@ -2969,7 +2968,6 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 		.type = ARM64_CPUCAP_SYSTEM_FEATURE,
 		.capability = ARM64_SME2,
 		.matches = has_cpuid_feature,
-		.cpu_enable = cpu_enable_sme2,
 		ARM64_CPUID_FIELDS(ID_AA64PFR1_EL1, SME, SME2)
 	},
 #endif /* CONFIG_ARM64_SME */
diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index c37f02d7194e..653c0dec6b18 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -392,11 +392,15 @@ static void task_fpsimd_load(void)
 
 	/* Restore SME, override SVE register configuration if needed */
 	if (system_supports_sme()) {
-		unsigned long sme_vl = task_get_sme_vl(current);
-
-		/* Ensure VL is set up for restoring data */
+		/*
+		 * Ensure VL is set up for restoring data.  KVM might
+		 * disable subfeatures so we reset them each time.
+		 */
 		if (test_thread_flag(TIF_SME))
-			sme_set_vq(sve_vq_from_vl(sme_vl) - 1);
+			sme_cond_update_smcr(sve_vq_from_vl(task_get_sme_vl(current)) - 1,
+					     system_supports_fa64(),
+					     system_supports_sme2(),
+					     SYS_SMCR_EL1);
 
 		write_sysreg_s(current->thread.svcr, SYS_SVCR);
 
@@ -1237,26 +1241,6 @@ void cpu_enable_sme(const struct arm64_cpu_capabilities *__always_unused p)
 	isb();
 }
 
-void cpu_enable_sme2(const struct arm64_cpu_capabilities *__always_unused p)
-{
-	/* This must be enabled after SME */
-	BUILD_BUG_ON(ARM64_SME2 <= ARM64_SME);
-
-	/* Allow use of ZT0 */
-	write_sysreg_s(read_sysreg_s(SYS_SMCR_EL1) | SMCR_ELx_EZT0_MASK,
-		       SYS_SMCR_EL1);
-}
-
-void cpu_enable_fa64(const struct arm64_cpu_capabilities *__always_unused p)
-{
-	/* This must be enabled after SME */
-	BUILD_BUG_ON(ARM64_SME_FA64 <= ARM64_SME);
-
-	/* Allow use of FA64 */
-	write_sysreg_s(read_sysreg_s(SYS_SMCR_EL1) | SMCR_ELx_FA64_MASK,
-		       SYS_SMCR_EL1);
-}
-
 void __init sme_setup(void)
 {
 	struct vl_info *info = &vl_info[ARM64_VEC_SME];
@@ -1300,17 +1284,9 @@ void __init sme_setup(void)
 
 void sme_suspend_exit(void)
 {
-	u64 smcr = 0;
-
 	if (!system_supports_sme())
 		return;
 
-	if (system_supports_fa64())
-		smcr |= SMCR_ELx_FA64;
-	if (system_supports_sme2())
-		smcr |= SMCR_ELx_EZT0;
-
-	write_sysreg_s(smcr, SYS_SMCR_EL1);
 	write_sysreg_s(0, SYS_SMPRI_EL1);
 }
 
@@ -1425,9 +1401,10 @@ void do_sme_acc(unsigned long esr, struct pt_regs *regs)
 		WARN_ON(1);
 
 	if (!test_thread_flag(TIF_FOREIGN_FPSTATE)) {
-		unsigned long vq_minus_one =
-			sve_vq_from_vl(task_get_sme_vl(current)) - 1;
-		sme_set_vq(vq_minus_one);
+		sme_cond_update_smcr(sve_vq_from_vl(task_get_sme_vl(current)) - 1,
+				     system_supports_fa64(),
+				     system_supports_sme2(),
+				     SYS_SMCR_EL1);
 
 		fpsimd_bind_task_to_cpu();
 	} else {

-- 
2.39.5


