Return-Path: <linux-kselftest+bounces-30997-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E079BA9104A
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Apr 2025 02:26:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF2A07A39CC
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Apr 2025 00:25:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9B0E160783;
	Thu, 17 Apr 2025 00:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SkSmsnyk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91BCE1547C9;
	Thu, 17 Apr 2025 00:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744849549; cv=none; b=WUH1ryq8S8R1MmAcesdWlw9RfvCm+2YmNMGEo77jnZ3rv81RQyH9AIsFzvSYWRU8acBykk0kTrPQCin5FOAflHJO9ejyjhlZOofGreftUWgp7rHWMiZSE/vxM8xw5ZtvYjdgnTxtDmzFtlitRwRTgPZq9eOVUJCoFnP6QqKJu2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744849549; c=relaxed/simple;
	bh=lXf5fjxlXJSXw0bQss56C2Kk2uzTn1+I+C1/cG9yGdE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=i4yGmJAQ9HSOOoX8sjVi/XXTDoDZKqvz63cZwRvsj46dZzFTdnvOMKol5hIXsD+mDvZJNpjLMBnSxMoCVQRQk090E+0qjVqkTwra5KuoSwLZOar+pkoKac877snan48CMtr0CeR25Y5tUXVvN8BOLfXgiKmK5rW86c1GBEVDUbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SkSmsnyk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C12CFC4CEED;
	Thu, 17 Apr 2025 00:25:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744849549;
	bh=lXf5fjxlXJSXw0bQss56C2Kk2uzTn1+I+C1/cG9yGdE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=SkSmsnykSLQJXpJqkW0L6ScXq/ukJOIEr+pCc7tLQqUDaY/uCRpCwGNZkDS6A0TOn
	 ul4hgRQFnFClmanXZWDPqRgFjl0aNn7Zx2pfEBA35l2wkyE39BEXLQkVqz48Sy17Ty
	 s8pYFU0Xh97JevdTqRp9rqhVy95lme7KzloSXu+jt1IZHlpIId5H/AFkVBUF9ycYze
	 dGi1SKv5Rrqb6TJmbXLJdu4PrS23GHofsrL76LvFa0tr7v3lKfv7omIyafL8JoLGFQ
	 1r7jx/FOR9pUaWfhXzWSaevz9hJliCzWFpxJd63HfREkUfHxu2/N0mwUEPvOOcMMfd
	 i+zlipQ3fuHiA==
From: Mark Brown <broonie@kernel.org>
Date: Thu, 17 Apr 2025 01:25:05 +0100
Subject: [PATCH v5 01/28] arm64/fpsimd: Update FA64 and ZT0 enables when
 loading SME state
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250417-kvm-arm64-sme-v5-1-f469a2d5f574@kernel.org>
References: <20250417-kvm-arm64-sme-v5-0-f469a2d5f574@kernel.org>
In-Reply-To: <20250417-kvm-arm64-sme-v5-0-f469a2d5f574@kernel.org>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
 Joey Gouly <joey.gouly@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, Will Deacon <will@kernel.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <shuah@kernel.org>
Cc: Dave Martin <Dave.Martin@arm.com>, Fuad Tabba <tabba@google.com>, 
 Mark Rutland <mark.rutland@arm.com>, linux-arm-kernel@lists.infradead.org, 
 kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-c25d1
X-Developer-Signature: v=1; a=openpgp-sha256; l=5728; i=broonie@kernel.org;
 h=from:subject:message-id; bh=lXf5fjxlXJSXw0bQss56C2Kk2uzTn1+I+C1/cG9yGdE=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBoAEpv6H+hI6UIeRrfw15CgRRSHGgPwlOHhJw2DMJT
 6HiJLSaJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaABKbwAKCRAk1otyXVSH0LwvB/
 9c9+Rz/XOqwTvVuZyq+p5QpwKkth2gscMmnkmnnJUYiiSz/m70GFIELbmGF8PzGSNy8xPGmcVRbbWu
 0RMx9A/se1wFP1DHnV+dk6XSKhjcltc0huIFlf9R7QLxMQFiqkh8VQ59BY7BwGJbF9yGcyGbpd7Wwv
 kDhreEV5UJQfxO3L0LPbmqyM2HSPpqVnAKpYRCZiXRTTmYiMdqt99jmoEjHAAuIiBT1hw5dGTZdunC
 iuMZ+Fw2XKAbjJT0L9tIaTIgfS9IBQx59aH4ztHICMDBuHWa5UFM0wHa+iDR95eAtOYUNBMN9zrCUT
 BnbA+PUjfhUfw1MW78F/bZzzaEtfBJ
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

df
---
 arch/arm64/include/asm/fpsimd.h | 14 ++++++++++++
 arch/arm64/kernel/cpufeature.c  |  2 --
 arch/arm64/kernel/fpsimd.c      | 47 +++++++++++------------------------------
 3 files changed, 26 insertions(+), 37 deletions(-)

diff --git a/arch/arm64/include/asm/fpsimd.h b/arch/arm64/include/asm/fpsimd.h
index b7adb2c72204..8279565826ad 100644
--- a/arch/arm64/include/asm/fpsimd.h
+++ b/arch/arm64/include/asm/fpsimd.h
@@ -402,6 +402,18 @@ static inline size_t sme_state_size(struct task_struct const *task)
 	return size;
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
@@ -425,6 +437,8 @@ static inline size_t sme_state_size(struct task_struct const *task)
 	return 0;
 }
 
+#define sme_cond_update_smcr(val, fa64, zt0, reg) do { } while (0)
+
 #endif /* ! CONFIG_ARM64_SME */
 
 /* For use by EFI runtime services calls only */
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 9c4d6d552b25..94b34366da37 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -2891,7 +2891,6 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 		.type = ARM64_CPUCAP_SYSTEM_FEATURE,
 		.capability = ARM64_SME_FA64,
 		.matches = has_cpuid_feature,
-		.cpu_enable = cpu_enable_fa64,
 		ARM64_CPUID_FIELDS(ID_AA64SMFR0_EL1, FA64, IMP)
 	},
 	{
@@ -2899,7 +2898,6 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 		.type = ARM64_CPUCAP_SYSTEM_FEATURE,
 		.capability = ARM64_SME2,
 		.matches = has_cpuid_feature,
-		.cpu_enable = cpu_enable_sme2,
 		ARM64_CPUID_FIELDS(ID_AA64PFR1_EL1, SME, SME2)
 	},
 #endif /* CONFIG_ARM64_SME */
diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index b0874402f7ec..d3a901afff72 100644
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
 
@@ -1242,26 +1246,6 @@ void cpu_enable_sme(const struct arm64_cpu_capabilities *__always_unused p)
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
@@ -1305,17 +1289,9 @@ void __init sme_setup(void)
 
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
 
@@ -1430,9 +1406,10 @@ void do_sme_acc(unsigned long esr, struct pt_regs *regs)
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


