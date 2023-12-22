Return-Path: <linux-kselftest+bounces-2381-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D778E81CCBD
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Dec 2023 17:23:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6185B286A9B
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Dec 2023 16:23:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D3AC2421C;
	Fri, 22 Dec 2023 16:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sP/S6n3X"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 095E02C199;
	Fri, 22 Dec 2023 16:21:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6737FC433CA;
	Fri, 22 Dec 2023 16:21:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703262111;
	bh=OnKnmFwvPKqcK2Hf5C/5tmugcp+N7aOjoTzymWCaGCY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=sP/S6n3XhTsBYnEIld7kq0zqmQjw2xOEFFFul+T2UpP/N9HqKVxHBWiZd+p98DUWB
	 JDuCZDrp0uuNvjOsn03h8BNqvv+4BBZ403I/EiwXROUJ9EVbaefN0q9OsdfDjyb0PO
	 5Roy+7H0k/6UVIoUn4KPwAEZ6T3K6sI+wFalAeM6dDmYdSwzFCCCt/Iv3lkBldR+2R
	 nAYRzS/UmGAMOlVDq/d14u2zgRVvq6wkYRRdljpuzoqayMeeAcJt+E5ryvEFjmLkyF
	 PiQeqWnzFGeCsAzB884OpG49qw3OdaoU3qBqwvdOiljN7Es8rChwMnfZFpitf4mQy0
	 buHKzuiwnlUPg==
From: Mark Brown <broonie@kernel.org>
Date: Fri, 22 Dec 2023 16:21:12 +0000
Subject: [PATCH RFC v2 04/22] KVM: arm64: Store vector lengths in an array
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231222-kvm-arm64-sme-v2-4-da226cb180bb@kernel.org>
References: <20231222-kvm-arm64-sme-v2-0-da226cb180bb@kernel.org>
In-Reply-To: <20231222-kvm-arm64-sme-v2-0-da226cb180bb@kernel.org>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
 James Morse <james.morse@arm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-5c066
X-Developer-Signature: v=1; a=openpgp-sha256; l=6907; i=broonie@kernel.org;
 h=from:subject:message-id; bh=OnKnmFwvPKqcK2Hf5C/5tmugcp+N7aOjoTzymWCaGCY=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlhbd/eiloV7s3MXvc8V5lL1WX9meTcpNLRESTLgyz
 y9YQD4aJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZYW3fwAKCRAk1otyXVSH0Pv9B/
 433dR84Y6mlbovKt4xcpAwEGGYMn4E7HfOrWb7z51MRkvUZitHVjslTQkPnKKTYbS+d4Pho7rWxNSs
 QaCq5gxYF0+JH6oahYpJoBTjf+xTmNT9sHl1LFBRTzO/IdmjC8Hn1yzMUOVd9iecZAvbAY1BMueRLR
 O7anC9iHnujJSnpDb2Y8/OW1WbWbf3H7d93IA6NiVL7N16/SrG4Cg9cJNfF73GJrTwszAkIc/l1UC4
 OvlbKB11+UQd3yJzU7KQRcbJ2MG+znVNWPbkUlqk24AzS5KYyzAM0Ef5GJfI/ExRDEAuTaBciqueTI
 Y+i71m81fm4RJ+7U3OKBymVXhTuMDX
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

SME introduces a second vector length enumerated and configured in the same
manner as for SVE. In a similar manner to the host kernel refactor to store
an array of vector lengths in order to facilitate sharing code between the
two.

We do not fully handle vcpu_sve_pffr() since we have not yet introduced
support for streaming mode, this will be updated as part of implementing
streaming mode.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/include/asm/kvm_host.h  | 12 +++++++-----
 arch/arm64/kvm/fpsimd.c            |  2 +-
 arch/arm64/kvm/guest.c             |  6 +++---
 arch/arm64/kvm/hyp/nvhe/hyp-main.c |  5 ++++-
 arch/arm64/kvm/reset.c             | 16 ++++++++--------
 5 files changed, 23 insertions(+), 18 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 9180713a2f9b..3b557ffb8e7b 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -74,7 +74,7 @@ static inline enum kvm_mode kvm_get_mode(void) { return KVM_MODE_NONE; };
 
 DECLARE_STATIC_KEY_FALSE(userspace_irqchip_in_use);
 
-extern unsigned int __ro_after_init kvm_sve_max_vl;
+extern unsigned int __ro_after_init kvm_vec_max_vl[ARM64_VEC_MAX];
 int __init kvm_arm_init_sve(void);
 
 u32 __attribute_const__ kvm_target_cpu(void);
@@ -515,7 +515,7 @@ struct kvm_vcpu_arch {
 	 */
 	void *sve_state;
 	enum fp_type fp_type;
-	unsigned int sve_max_vl;
+	unsigned int max_vl[ARM64_VEC_MAX];
 	u64 svcr;
 
 	/* Stage 2 paging state used by the hardware on next switch */
@@ -802,15 +802,17 @@ struct kvm_vcpu_arch {
 
 /* Pointer to the vcpu's SVE FFR for sve_{save,load}_state() */
 #define vcpu_sve_pffr(vcpu) (kern_hyp_va((vcpu)->arch.sve_state) +	\
-			     sve_ffr_offset((vcpu)->arch.sve_max_vl))
+			     sve_ffr_offset((vcpu)->arch.max_vl[ARM64_VEC_SVE]))
 
-#define vcpu_sve_max_vq(vcpu)	sve_vq_from_vl((vcpu)->arch.sve_max_vl)
+#define vcpu_vec_max_vq(type, vcpu) sve_vq_from_vl((vcpu)->arch.max_vl[type])
+
+#define vcpu_sve_max_vq(vcpu)	vcpu_vec_max_vq(ARM64_VEC_SVE, vcpu)
 
 #define vcpu_sve_state_size(vcpu) ({					\
 	size_t __size_ret;						\
 	unsigned int __vcpu_vq;						\
 									\
-	if (WARN_ON(!sve_vl_valid((vcpu)->arch.sve_max_vl))) {		\
+	if (WARN_ON(!sve_vl_valid((vcpu)->arch.max_vl[ARM64_VEC_SVE]))) { \
 		__size_ret = 0;						\
 	} else {							\
 		__vcpu_vq = vcpu_sve_max_vq(vcpu);			\
diff --git a/arch/arm64/kvm/fpsimd.c b/arch/arm64/kvm/fpsimd.c
index 8c1d0d4853df..a402a072786a 100644
--- a/arch/arm64/kvm/fpsimd.c
+++ b/arch/arm64/kvm/fpsimd.c
@@ -150,7 +150,7 @@ void kvm_arch_vcpu_ctxsync_fp(struct kvm_vcpu *vcpu)
 		 */
 		fp_state.st = &vcpu->arch.ctxt.fp_regs;
 		fp_state.sve_state = vcpu->arch.sve_state;
-		fp_state.sve_vl = vcpu->arch.sve_max_vl;
+		fp_state.sve_vl = vcpu->arch.max_vl[ARM64_VEC_SVE];
 		fp_state.sme_state = NULL;
 		fp_state.svcr = &vcpu->arch.svcr;
 		fp_state.fp_type = &vcpu->arch.fp_type;
diff --git a/arch/arm64/kvm/guest.c b/arch/arm64/kvm/guest.c
index aaf1d4939739..3ae08f7c0b80 100644
--- a/arch/arm64/kvm/guest.c
+++ b/arch/arm64/kvm/guest.c
@@ -317,7 +317,7 @@ static int get_sve_vls(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
 	if (!vcpu_has_sve(vcpu))
 		return -ENOENT;
 
-	if (WARN_ON(!sve_vl_valid(vcpu->arch.sve_max_vl)))
+	if (WARN_ON(!sve_vl_valid(vcpu->arch.max_vl[ARM64_VEC_SVE])))
 		return -EINVAL;
 
 	memset(vqs, 0, sizeof(vqs));
@@ -355,7 +355,7 @@ static int set_sve_vls(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
 		if (vq_present(vqs, vq))
 			max_vq = vq;
 
-	if (max_vq > sve_vq_from_vl(kvm_sve_max_vl))
+	if (max_vq > sve_vq_from_vl(kvm_vec_max_vl[ARM64_VEC_SVE]))
 		return -EINVAL;
 
 	/*
@@ -374,7 +374,7 @@ static int set_sve_vls(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
 		return -EINVAL;
 
 	/* vcpu->arch.sve_state will be alloc'd by kvm_vcpu_finalize_sve() */
-	vcpu->arch.sve_max_vl = sve_vl_from_vq(max_vq);
+	vcpu->arch.max_vl[ARM64_VEC_SVE] = sve_vl_from_vq(max_vq);
 
 	return 0;
 }
diff --git a/arch/arm64/kvm/hyp/nvhe/hyp-main.c b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
index 84deed83e580..56808df6a078 100644
--- a/arch/arm64/kvm/hyp/nvhe/hyp-main.c
+++ b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
@@ -26,11 +26,14 @@ void __kvm_hyp_host_forward_smc(struct kvm_cpu_context *host_ctxt);
 static void flush_hyp_vcpu(struct pkvm_hyp_vcpu *hyp_vcpu)
 {
 	struct kvm_vcpu *host_vcpu = hyp_vcpu->host_vcpu;
+	int i;
 
 	hyp_vcpu->vcpu.arch.ctxt	= host_vcpu->arch.ctxt;
 
+	for (i = 0; i < ARRAY_SIZE(hyp_vcpu->vcpu.arch.max_vl); i++)
+		hyp_vcpu->vcpu.arch.max_vl[i] = host_vcpu->arch.max_vl[i];
+
 	hyp_vcpu->vcpu.arch.sve_state	= kern_hyp_va(host_vcpu->arch.sve_state);
-	hyp_vcpu->vcpu.arch.sve_max_vl	= host_vcpu->arch.sve_max_vl;
 
 	hyp_vcpu->vcpu.arch.hw_mmu	= host_vcpu->arch.hw_mmu;
 
diff --git a/arch/arm64/kvm/reset.c b/arch/arm64/kvm/reset.c
index 5bb4de162cab..81b949dd809d 100644
--- a/arch/arm64/kvm/reset.c
+++ b/arch/arm64/kvm/reset.c
@@ -45,12 +45,12 @@ static u32 __ro_after_init kvm_ipa_limit;
 #define VCPU_RESET_PSTATE_SVC	(PSR_AA32_MODE_SVC | PSR_AA32_A_BIT | \
 				 PSR_AA32_I_BIT | PSR_AA32_F_BIT)
 
-unsigned int __ro_after_init kvm_sve_max_vl;
+unsigned int __ro_after_init kvm_vec_max_vl[ARM64_VEC_MAX];
 
 int __init kvm_arm_init_sve(void)
 {
 	if (system_supports_sve()) {
-		kvm_sve_max_vl = sve_max_virtualisable_vl();
+		kvm_vec_max_vl[ARM64_VEC_SVE] = sve_max_virtualisable_vl();
 
 		/*
 		 * The get_sve_reg()/set_sve_reg() ioctl interface will need
@@ -58,16 +58,16 @@ int __init kvm_arm_init_sve(void)
 		 * order to support vector lengths greater than
 		 * VL_ARCH_MAX:
 		 */
-		if (WARN_ON(kvm_sve_max_vl > VL_ARCH_MAX))
-			kvm_sve_max_vl = VL_ARCH_MAX;
+		if (WARN_ON(kvm_vec_max_vl[ARM64_VEC_SVE] > VL_ARCH_MAX))
+			kvm_vec_max_vl[ARM64_VEC_SVE] = VL_ARCH_MAX;
 
 		/*
 		 * Don't even try to make use of vector lengths that
 		 * aren't available on all CPUs, for now:
 		 */
-		if (kvm_sve_max_vl < sve_max_vl())
+		if (kvm_vec_max_vl[ARM64_VEC_SVE] < sve_max_vl())
 			pr_warn("KVM: SVE vector length for guests limited to %u bytes\n",
-				kvm_sve_max_vl);
+				kvm_vec_max_vl[ARM64_VEC_SVE]);
 	}
 
 	return 0;
@@ -75,7 +75,7 @@ int __init kvm_arm_init_sve(void)
 
 static void kvm_vcpu_enable_sve(struct kvm_vcpu *vcpu)
 {
-	vcpu->arch.sve_max_vl = kvm_sve_max_vl;
+	vcpu->arch.max_vl[ARM64_VEC_SVE] = kvm_vec_max_vl[ARM64_VEC_SVE];
 
 	/*
 	 * Userspace can still customize the vector lengths by writing
@@ -96,7 +96,7 @@ static int kvm_vcpu_finalize_sve(struct kvm_vcpu *vcpu)
 	size_t reg_sz;
 	int ret;
 
-	vl = vcpu->arch.sve_max_vl;
+	vl = vcpu->arch.max_vl[ARM64_VEC_SVE];
 
 	/*
 	 * Responsibility for these properties is shared between

-- 
2.30.2


