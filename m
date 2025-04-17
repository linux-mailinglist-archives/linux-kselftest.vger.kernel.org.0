Return-Path: <linux-kselftest+bounces-31009-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 725BFA9107A
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Apr 2025 02:29:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D1B417ED08
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Apr 2025 00:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90F52207E14;
	Thu, 17 Apr 2025 00:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XNLJj89d"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DBEE78F5B;
	Thu, 17 Apr 2025 00:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744849593; cv=none; b=qhRHG8GQ6DH3GKHwseT71TPUU9NEn/lmHLA0V71wlj9YlWB8e9jHTJrtHbklIQN9wbXR0QMQ/a7jrYSWnONE2KxnOeDxuwZ7cyuWB3+pdbGzl6/+I27hxrY1nfDKNZGAWQva39Oj0oj/Q7b5eoEznuZgKJ4lIWGODpTLsPuff18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744849593; c=relaxed/simple;
	bh=IqYfQW6t9ldOaFOAc2sm8Sm3afA06l36aWtBVEd2xJo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cf13FRlzmZjZ9wQuYf19ORrQJQNwc054xIGrlD44xvEvpUoE0v7aaC5OK1QWtS8cy0QY79LGI8W6JiTNEBsggMqmqJRhGi6dwA9BafPU/5zvIoD5soe8BOTx78/gcDV8mi3f5RYF3qA5UhAzVHlQivuIzHDes6LpN59caQzyJP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XNLJj89d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A3C3C4CEEF;
	Thu, 17 Apr 2025 00:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744849592;
	bh=IqYfQW6t9ldOaFOAc2sm8Sm3afA06l36aWtBVEd2xJo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=XNLJj89dWCjpgAWtV/HOydNXPItY4H5FJqiN1bJnCbM2FJAnBJseMRr7wFhIP9lsW
	 3ELvyuxgR5Vi4H4sxxPUs3wq7Sxa1EzbwWK2VQ5zsgQKD+isFlsWBvQB34JtSS0WrS
	 5ZaPopsAbzAhGhWdzi78fTef7xT7qBrr0Edo5OQ8W0fEvNzc0fTIpHBa+8gdHZ72cJ
	 PXhfpYe1pPZlH91ZWjEWB8cZjkDfanZaySM3L6HUmeTesi0stHMeRAtrfJEtz4uRJr
	 LK2WrEJX20KnEqtYlYv9346MwTIP2JPitgn1FNeN2V4qvzQuC8OxOKqauumsfGRKtG
	 atPDAxydg4y3A==
From: Mark Brown <broonie@kernel.org>
Date: Thu, 17 Apr 2025 01:25:17 +0100
Subject: [PATCH v5 13/28] KVM: arm64: Store vector lengths in an array
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250417-kvm-arm64-sme-v5-13-f469a2d5f574@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=11859; i=broonie@kernel.org;
 h=from:subject:message-id; bh=IqYfQW6t9ldOaFOAc2sm8Sm3afA06l36aWtBVEd2xJo=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBoAEp5VIQv2ZwRZXIBQ0iZCnJQHfwr18enjoinmDVj
 ODERwIOJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaABKeQAKCRAk1otyXVSH0LKCCA
 CF9j2zSmUQPTEzRQIh1oMCEwp7VG1wWvcqJoXovJqgY1HAyAEz1FWfiCxQ+Pog0/hjIMnhopJ2WGQO
 qtl94BbC/q1tKAn0yP1YitRYeupThjkZuBrEWSH0eoutn8d329TNdEaZQf1saPtfHX5K+pT9B2cYrc
 roFpkVoCgZlIBdve/ICK/IrdpjU/lzK2jfiJOcmRib3FYnK6VXdSj/AIUR7FhaaaWkerdocLG1NKle
 GH/0pydMwYMtUzmFNc2llXQdhPDcEP8Dk4dNR+f9hSTRlJEr6vmZMyBSBSHJvbQrwC9QUechzQ11SC
 PCxrDDesxAj8KY7axCceUvot6JpPhw
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

SME adds a second vector length configured in a very similar way to the
SVE vector length, in order to facilitate future code sharing for SME
refactor our storage of vector lengths to use an array like the host does.
We do not yet take much advantage of this so the intermediate code is not
as clean as might be.

No functional change.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/include/asm/kvm_host.h       | 17 +++++++++++------
 arch/arm64/include/asm/kvm_hyp.h        |  2 +-
 arch/arm64/include/asm/kvm_pkvm.h       |  2 +-
 arch/arm64/kvm/fpsimd.c                 |  2 +-
 arch/arm64/kvm/guest.c                  |  6 +++---
 arch/arm64/kvm/hyp/include/hyp/switch.h |  6 +++---
 arch/arm64/kvm/hyp/nvhe/hyp-main.c      | 11 +++++++----
 arch/arm64/kvm/hyp/nvhe/pkvm.c          |  2 +-
 arch/arm64/kvm/reset.c                  | 22 +++++++++++-----------
 9 files changed, 39 insertions(+), 31 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index a6690893ec5e..d5ad85478010 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -75,8 +75,10 @@ enum kvm_mode kvm_get_mode(void);
 static inline enum kvm_mode kvm_get_mode(void) { return KVM_MODE_NONE; };
 #endif
 
-extern unsigned int __ro_after_init kvm_sve_max_vl;
-extern unsigned int __ro_after_init kvm_host_sve_max_vl;
+extern unsigned int __ro_after_init kvm_max_vl[ARM64_VEC_MAX];
+extern unsigned int __ro_after_init kvm_host_max_vl[ARM64_VEC_MAX];
+DECLARE_STATIC_KEY_FALSE(userspace_irqchip_in_use);
+
 int __init kvm_arm_init_sve(void);
 
 u32 __attribute_const__ kvm_target_cpu(void);
@@ -753,7 +755,7 @@ struct kvm_vcpu_arch {
 	 */
 	void *sve_state;
 	enum fp_type fp_type;
-	unsigned int sve_max_vl;
+	unsigned int max_vl[ARM64_VEC_MAX];
 
 	/* Stage 2 paging state used by the hardware on next switch */
 	struct kvm_s2_mmu *hw_mmu;
@@ -1018,9 +1020,12 @@ struct kvm_vcpu_arch {
 
 /* Pointer to the vcpu's SVE FFR for sve_{save,load}_state() */
 #define vcpu_sve_pffr(vcpu) (kern_hyp_va((vcpu)->arch.sve_state) +	\
-			     sve_ffr_offset((vcpu)->arch.sve_max_vl))
+			     sve_ffr_offset((vcpu)->arch.max_vl[ARM64_VEC_SVE]))
+
+#define vcpu_vec_max_vq(vcpu, type) sve_vq_from_vl((vcpu)->arch.max_vl[type])
+
+#define vcpu_sve_max_vq(vcpu)	vcpu_vec_max_vq(vcpu, ARM64_VEC_SVE)
 
-#define vcpu_sve_max_vq(vcpu)	sve_vq_from_vl((vcpu)->arch.sve_max_vl)
 
 #define vcpu_sve_zcr_elx(vcpu)						\
 	(unlikely(is_hyp_ctxt(vcpu)) ? ZCR_EL2 : ZCR_EL1)
@@ -1029,7 +1034,7 @@ struct kvm_vcpu_arch {
 	size_t __size_ret;						\
 	unsigned int __vcpu_vq;						\
 									\
-	if (WARN_ON(!sve_vl_valid((vcpu)->arch.sve_max_vl))) {		\
+	if (WARN_ON(!sve_vl_valid((vcpu)->arch.max_vl[ARM64_VEC_SVE]))) { \
 		__size_ret = 0;						\
 	} else {							\
 		__vcpu_vq = vcpu_sve_max_vq(vcpu);			\
diff --git a/arch/arm64/include/asm/kvm_hyp.h b/arch/arm64/include/asm/kvm_hyp.h
index e6be1f5d0967..0ad5a66e0d25 100644
--- a/arch/arm64/include/asm/kvm_hyp.h
+++ b/arch/arm64/include/asm/kvm_hyp.h
@@ -145,6 +145,6 @@ extern u64 kvm_nvhe_sym(id_aa64smfr0_el1_sys_val);
 
 extern unsigned long kvm_nvhe_sym(__icache_flags);
 extern unsigned int kvm_nvhe_sym(kvm_arm_vmid_bits);
-extern unsigned int kvm_nvhe_sym(kvm_host_sve_max_vl);
+extern unsigned int kvm_nvhe_sym(kvm_host_max_vl[ARM64_VEC_MAX]);
 
 #endif /* __ARM64_KVM_HYP_H__ */
diff --git a/arch/arm64/include/asm/kvm_pkvm.h b/arch/arm64/include/asm/kvm_pkvm.h
index abd693ce5b93..df64a3f7bcb4 100644
--- a/arch/arm64/include/asm/kvm_pkvm.h
+++ b/arch/arm64/include/asm/kvm_pkvm.h
@@ -160,7 +160,7 @@ static inline size_t pkvm_host_sve_state_size(void)
 		return 0;
 
 	return size_add(sizeof(struct cpu_sve_state),
-			SVE_SIG_REGS_SIZE(sve_vq_from_vl(kvm_host_sve_max_vl)));
+			SVE_SIG_REGS_SIZE(sve_vq_from_vl(kvm_host_max_vl[ARM64_VEC_SVE])));
 }
 
 struct pkvm_mapping {
diff --git a/arch/arm64/kvm/fpsimd.c b/arch/arm64/kvm/fpsimd.c
index 7fc14b7349a0..72c67b067ca1 100644
--- a/arch/arm64/kvm/fpsimd.c
+++ b/arch/arm64/kvm/fpsimd.c
@@ -101,7 +101,7 @@ void kvm_arch_vcpu_ctxsync_fp(struct kvm_vcpu *vcpu)
 		 */
 		fp_state.st = &vcpu->arch.ctxt.fp_regs;
 		fp_state.sve_state = vcpu->arch.sve_state;
-		fp_state.sve_vl = vcpu->arch.sve_max_vl;
+		fp_state.sve_vl = vcpu->arch.max_vl[ARM64_VEC_SVE];
 		fp_state.sme_state = NULL;
 		fp_state.svcr = &__vcpu_sys_reg(vcpu, SVCR);
 		fp_state.fpmr = &__vcpu_sys_reg(vcpu, FPMR);
diff --git a/arch/arm64/kvm/guest.c b/arch/arm64/kvm/guest.c
index bb4b91e43923..e9f17b8a6fba 100644
--- a/arch/arm64/kvm/guest.c
+++ b/arch/arm64/kvm/guest.c
@@ -318,7 +318,7 @@ static int get_sve_vls(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
 	if (!vcpu_has_sve(vcpu))
 		return -ENOENT;
 
-	if (WARN_ON(!sve_vl_valid(vcpu->arch.sve_max_vl)))
+	if (WARN_ON(!sve_vl_valid(vcpu->arch.max_vl[ARM64_VEC_SVE])))
 		return -EINVAL;
 
 	memset(vqs, 0, sizeof(vqs));
@@ -356,7 +356,7 @@ static int set_sve_vls(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
 		if (vq_present(vqs, vq))
 			max_vq = vq;
 
-	if (max_vq > sve_vq_from_vl(kvm_sve_max_vl))
+	if (max_vq > sve_vq_from_vl(kvm_max_vl[ARM64_VEC_SVE]))
 		return -EINVAL;
 
 	/*
@@ -375,7 +375,7 @@ static int set_sve_vls(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
 		return -EINVAL;
 
 	/* vcpu->arch.sve_state will be alloc'd by kvm_vcpu_finalize_sve() */
-	vcpu->arch.sve_max_vl = sve_vl_from_vq(max_vq);
+	vcpu->arch.max_vl[ARM64_VEC_SVE] = sve_vl_from_vq(max_vq);
 
 	return 0;
 }
diff --git a/arch/arm64/kvm/hyp/include/hyp/switch.h b/arch/arm64/kvm/hyp/include/hyp/switch.h
index 7c9355459648..1c0ef9d6609d 100644
--- a/arch/arm64/kvm/hyp/include/hyp/switch.h
+++ b/arch/arm64/kvm/hyp/include/hyp/switch.h
@@ -370,8 +370,8 @@ static inline void __hyp_sve_save_host(void)
 	struct cpu_sve_state *sve_state = *host_data_ptr(sve_state);
 
 	sve_state->zcr_el1 = read_sysreg_el1(SYS_ZCR);
-	write_sysreg_s(sve_vq_from_vl(kvm_host_sve_max_vl) - 1, SYS_ZCR_EL2);
-	__sve_save_state(sve_state->sve_regs + sve_ffr_offset(kvm_host_sve_max_vl),
+	write_sysreg_s(sve_vq_from_vl(kvm_host_max_vl[ARM64_VEC_SVE]) - 1, SYS_ZCR_EL2);
+	__sve_save_state(sve_state->sve_regs + sve_ffr_offset(kvm_host_max_vl[ARM64_VEC_SVE]),
 			 &sve_state->fpsr,
 			 true);
 }
@@ -426,7 +426,7 @@ static inline void fpsimd_lazy_switch_to_host(struct kvm_vcpu *vcpu)
 			zcr_el2 = vcpu_sve_max_vq(vcpu) - 1;
 			write_sysreg_el2(zcr_el2, SYS_ZCR);
 		} else {
-			zcr_el2 = sve_vq_from_vl(kvm_host_sve_max_vl) - 1;
+			zcr_el2 = sve_vq_from_vl(kvm_host_max_vl[ARM64_VEC_SVE]) - 1;
 			write_sysreg_el2(zcr_el2, SYS_ZCR);
 
 			zcr_el1 = vcpu_sve_max_vq(vcpu) - 1;
diff --git a/arch/arm64/kvm/hyp/nvhe/hyp-main.c b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
index 2c37680d954c..1fb38dc64357 100644
--- a/arch/arm64/kvm/hyp/nvhe/hyp-main.c
+++ b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
@@ -34,7 +34,7 @@ static void __hyp_sve_save_guest(struct kvm_vcpu *vcpu)
 	 */
 	sve_cond_update_zcr_vq(vcpu_sve_max_vq(vcpu) - 1, SYS_ZCR_EL2);
 	__sve_save_state(vcpu_sve_pffr(vcpu), &vcpu->arch.ctxt.fp_regs.fpsr, true);
-	write_sysreg_s(sve_vq_from_vl(kvm_host_sve_max_vl) - 1, SYS_ZCR_EL2);
+	write_sysreg_s(sve_vq_from_vl(kvm_host_max_vl[ARM64_VEC_SVE]) - 1, SYS_ZCR_EL2);
 }
 
 static void __hyp_sve_restore_host(void)
@@ -50,8 +50,8 @@ static void __hyp_sve_restore_host(void)
 	 * that was discovered, if we wish to use larger VLs this will
 	 * need to be revisited.
 	 */
-	write_sysreg_s(sve_vq_from_vl(kvm_host_sve_max_vl) - 1, SYS_ZCR_EL2);
-	__sve_restore_state(sve_state->sve_regs + sve_ffr_offset(kvm_host_sve_max_vl),
+	write_sysreg_s(sve_vq_from_vl(kvm_host_max_vl[ARM64_VEC_SVE]) - 1, SYS_ZCR_EL2);
+	__sve_restore_state(sve_state->sve_regs + sve_ffr_offset(kvm_host_max_vl[ARM64_VEC_SVE]),
 			    &sve_state->fpsr,
 			    true);
 	write_sysreg_el1(sve_state->zcr_el1, SYS_ZCR);
@@ -117,6 +117,7 @@ static void sync_debug_state(struct pkvm_hyp_vcpu *hyp_vcpu)
 static void flush_hyp_vcpu(struct pkvm_hyp_vcpu *hyp_vcpu)
 {
 	struct kvm_vcpu *host_vcpu = hyp_vcpu->host_vcpu;
+	int i;
 
 	fpsimd_sve_flush();
 	flush_debug_state(hyp_vcpu);
@@ -125,7 +126,9 @@ static void flush_hyp_vcpu(struct pkvm_hyp_vcpu *hyp_vcpu)
 
 	hyp_vcpu->vcpu.arch.sve_state	= kern_hyp_va(host_vcpu->arch.sve_state);
 	/* Limit guest vector length to the maximum supported by the host.  */
-	hyp_vcpu->vcpu.arch.sve_max_vl	= min(host_vcpu->arch.sve_max_vl, kvm_host_sve_max_vl);
+	for (i = 0; i < ARM64_VEC_MAX; i++)
+		hyp_vcpu->vcpu.arch.max_vl[i] = min(host_vcpu->arch.max_vl[i],
+						    kvm_host_max_vl[i]);
 
 	hyp_vcpu->vcpu.arch.mdcr_el2	= host_vcpu->arch.mdcr_el2;
 	hyp_vcpu->vcpu.arch.hcr_el2 &= ~(HCR_TWI | HCR_TWE);
diff --git a/arch/arm64/kvm/hyp/nvhe/pkvm.c b/arch/arm64/kvm/hyp/nvhe/pkvm.c
index eff47b58effb..57b6d81006ae 100644
--- a/arch/arm64/kvm/hyp/nvhe/pkvm.c
+++ b/arch/arm64/kvm/hyp/nvhe/pkvm.c
@@ -20,7 +20,7 @@ unsigned long __icache_flags;
 /* Used by kvm_get_vttbr(). */
 unsigned int kvm_arm_vmid_bits;
 
-unsigned int kvm_host_sve_max_vl;
+unsigned int kvm_host_max_vl[ARM64_VEC_MAX];
 
 /*
  * The currently loaded hyp vCPU for each physical CPU. Used only when
diff --git a/arch/arm64/kvm/reset.c b/arch/arm64/kvm/reset.c
index 2cf2028ab0dd..052a1a452f89 100644
--- a/arch/arm64/kvm/reset.c
+++ b/arch/arm64/kvm/reset.c
@@ -32,7 +32,7 @@
 
 /* Maximum phys_shift supported for any VM on this host */
 static u32 __ro_after_init kvm_ipa_limit;
-unsigned int __ro_after_init kvm_host_sve_max_vl;
+unsigned int __ro_after_init kvm_host_max_vl[ARM64_VEC_MAX];
 
 /*
  * ARMv8 Reset Values
@@ -46,14 +46,14 @@ unsigned int __ro_after_init kvm_host_sve_max_vl;
 #define VCPU_RESET_PSTATE_SVC	(PSR_AA32_MODE_SVC | PSR_AA32_A_BIT | \
 				 PSR_AA32_I_BIT | PSR_AA32_F_BIT)
 
-unsigned int __ro_after_init kvm_sve_max_vl;
+unsigned int __ro_after_init kvm_max_vl[ARM64_VEC_MAX];
 
 int __init kvm_arm_init_sve(void)
 {
 	if (system_supports_sve()) {
-		kvm_sve_max_vl = sve_max_virtualisable_vl();
-		kvm_host_sve_max_vl = sve_max_vl();
-		kvm_nvhe_sym(kvm_host_sve_max_vl) = kvm_host_sve_max_vl;
+		kvm_max_vl[ARM64_VEC_SVE] = sve_max_virtualisable_vl();
+		kvm_host_max_vl[ARM64_VEC_SVE] = sve_max_vl();
+		kvm_nvhe_sym(kvm_host_max_vl[ARM64_VEC_SVE]) = kvm_host_max_vl[ARM64_VEC_SVE];
 
 		/*
 		 * The get_sve_reg()/set_sve_reg() ioctl interface will need
@@ -61,16 +61,16 @@ int __init kvm_arm_init_sve(void)
 		 * order to support vector lengths greater than
 		 * VL_ARCH_MAX:
 		 */
-		if (WARN_ON(kvm_sve_max_vl > VL_ARCH_MAX))
-			kvm_sve_max_vl = VL_ARCH_MAX;
+		if (WARN_ON(kvm_max_vl[ARM64_VEC_SVE] > VL_ARCH_MAX))
+			kvm_max_vl[ARM64_VEC_SVE] = VL_ARCH_MAX;
 
 		/*
 		 * Don't even try to make use of vector lengths that
 		 * aren't available on all CPUs, for now:
 		 */
-		if (kvm_sve_max_vl < sve_max_vl())
+		if (kvm_max_vl[ARM64_VEC_SVE] < sve_max_vl())
 			pr_warn("KVM: SVE vector length for guests limited to %u bytes\n",
-				kvm_sve_max_vl);
+				kvm_max_vl[ARM64_VEC_SVE]);
 	}
 
 	return 0;
@@ -78,7 +78,7 @@ int __init kvm_arm_init_sve(void)
 
 static void kvm_vcpu_enable_sve(struct kvm_vcpu *vcpu)
 {
-	vcpu->arch.sve_max_vl = kvm_sve_max_vl;
+	vcpu->arch.max_vl[ARM64_VEC_SVE] = kvm_max_vl[ARM64_VEC_SVE];
 
 	/*
 	 * Userspace can still customize the vector lengths by writing
@@ -99,7 +99,7 @@ static int kvm_vcpu_finalize_vec(struct kvm_vcpu *vcpu)
 	size_t reg_sz;
 	int ret;
 
-	vl = vcpu->arch.sve_max_vl;
+	vl = vcpu->arch.max_vl[ARM64_VEC_SVE];
 
 	/*
 	 * Responsibility for these properties is shared between

-- 
2.39.5


