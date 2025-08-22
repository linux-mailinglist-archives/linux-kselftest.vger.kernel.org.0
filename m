Return-Path: <linux-kselftest+bounces-39642-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 26C48B30B60
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Aug 2025 04:03:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6BA9B63673
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Aug 2025 02:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C885A299A82;
	Fri, 22 Aug 2025 01:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HqfTMJEI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B2B1C549F;
	Fri, 22 Aug 2025 01:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755827750; cv=none; b=rWIpnjOiaBxNv1/HBfveOBc5n48KlYUUY56dkDmEJfxDzebrR2i+y+/v60Kxf6iHlTd7GEjAV3LtkJt+UDxLkXwSJehqP0Ep1ebKeBHk9j8Sy/D9xCBI6XaM/57alSKHrl+lfjr5xQhLoRlK8HWRBSqZh0kT8+XdbK0FP3hSAM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755827750; c=relaxed/simple;
	bh=K/O9CttzW0zt3QhDrAZF6NQXIZmkZnmyhsSNH3lWRrU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=I+4yje2QVeVgpJRsO9RYkfZ8MyId3dfGJ3rh46SpCbA8UgGAvwXM2nicY5UVfai5RsA/k+n5WoCAh4TNdiLZCuplpQDc0qqdCmzGz2zuMIGJJzlxWYI7vIiCoTIqUi/Vgs2+zaoI16ZfsnQwJV03BjNJbMOoTFgQtZ5qJSGyfIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HqfTMJEI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1C7EC116B1;
	Fri, 22 Aug 2025 01:55:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755827750;
	bh=K/O9CttzW0zt3QhDrAZF6NQXIZmkZnmyhsSNH3lWRrU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=HqfTMJEIIm0RVp8DdAwJ+7iOeQtGnXVoOOecL9qzpJ0rGiAk9eG5mToRPG9SUMT+m
	 KVEZc3EJgTO1NVp4flTSaBHr0ZX0M3TqrAHeFyJ9lzLQcI4rR1oHCYv7lPVEIL82/Q
	 pqCNkHMRuvnF6FKOOr+T0PvEICS2YMP8BT3pYFtyEEOYHZZxwwG32rq5CmJ+HUV2sN
	 95FdQFPFrXG4DxzufZm/vwTMnfOodVp9+3NzKTyWDHEK3YrGLGBN0HiPIfRweZ65cA
	 Q17cxZTsQfO8k+A3IDWZgKcSNZoJjiathuDmGZzKyDBi1FZlrcsauiOSQ9yIWY8nvv
	 l4iuD6pt5aKDg==
From: Mark Brown <broonie@kernel.org>
Date: Fri, 22 Aug 2025 02:53:51 +0100
Subject: [PATCH v7 22/29] KVM: arm64: Flush register state on writes to
 SVCR.SM and SVCR.ZA
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250822-kvm-arm64-sme-v7-22-7a65d82b8b10@kernel.org>
References: <20250822-kvm-arm64-sme-v7-0-7a65d82b8b10@kernel.org>
In-Reply-To: <20250822-kvm-arm64-sme-v7-0-7a65d82b8b10@kernel.org>
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
X-Mailer: b4 0.15-dev-cff91
X-Developer-Signature: v=1; a=openpgp-sha256; l=3621; i=broonie@kernel.org;
 h=from:subject:message-id; bh=K/O9CttzW0zt3QhDrAZF6NQXIZmkZnmyhsSNH3lWRrU=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBop83JJXqzXqJ5OVr99ci+V6a3vGPLFRimUnWeH
 SqoJHNeNkqJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaKfNyQAKCRAk1otyXVSH
 0KcDCACFKvDYoPHrzdlHonB/UTvZ8IgbysGU4q7TsbxOb/15KCQ3dSgpF8h+AZv0rf/dtANxjvK
 ASSmvXR17WouQrUCoLU3WV4fYAPsouahjr2mWOW0t2VoX/CKHVZy23Vxb0zQlf+PvjuYJisW+LN
 E0yK6rcJk7oXRjKG/+YBdtx/HvCmmTD6g3huORstNbALGrrjSyYfEw5MdkfeURJa4tASPsWxcZt
 Sr3Au71YQW1bJoydFA+pT/9oYz4eYRSkgBQx7Ca14IecKv8TiGOmy76zaH0q/9UeqELUveAU6ds
 SWtLBtLuaYWbRgryRPEjE8WEOsY09f1hWKF18jB1fc56XlP9
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

Writes to the physical SVCR.SM and SVCR.ZA change the state of PSTATE.SM
and PSTATE.ZA, causing other floating point state to reset. Emulate this
behaviour for writes done via the KVM userspace ABI.

Setting PSTATE.ZA to 1 causes ZA and ZT0 to be reset to 0, these are stored
in sme_state. Setting PSTATE.ZA to 0 causes ZA and ZT0 to become inaccesible
so no reset is needed.

Any change in PSTATE.SM causes the V, Z, P, FFR and FPMR registers to be
reset to 0 and FPSR to be reset to 0x800009f.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/include/asm/kvm_host.h | 24 ++++++++++++++++++++++++
 arch/arm64/kvm/sys_regs.c         | 29 ++++++++++++++++++++++++++++-
 2 files changed, 52 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index ebc516fe09db..8e5c16372b83 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -1144,6 +1144,30 @@ struct kvm_vcpu_arch {
 
 #define vcpu_sve_state_size(vcpu) sve_state_size_from_vl((vcpu)->arch.max_vl[ARM64_VEC_SVE])
 
+#define vcpu_sme_state(vcpu) (kern_hyp_va((vcpu)->arch.sme_state))
+
+#define sme_state_size_from_vl(vl, sme2) ({				\
+	size_t __size_ret;						\
+	unsigned int __vq;						\
+									\
+	if (WARN_ON(!sve_vl_valid(vl))) {				\
+		__size_ret = 0;						\
+	} else {							\
+		__vq = sve_vq_from_vl(vl);				\
+		__size_ret = ZA_SIG_REGS_SIZE(__vq);			\
+		if (sme2)						\
+			__size_ret += ZT_SIG_REG_SIZE;			\
+	}								\
+									\
+	__size_ret;							\
+})
+
+#define vcpu_sme_state_size(vcpu) ({					\
+	unsigned long __vl;						\
+	__vl = (vcpu)->arch.max_vl[ARM64_VEC_SME];			\
+	sme_state_size_from_vl(__vl, vcpu_has_sme2(vcpu));		\
+})
+
 /*
  * Only use __vcpu_sys_reg/ctxt_sys_reg if you know you want the
  * memory backed version of a register, and not the one most recently
diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 7284705a5f0a..0752e119c056 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -788,6 +788,33 @@ static unsigned int hidden_visibility(const struct kvm_vcpu *vcpu,
 	return REG_HIDDEN;
 }
 
+static int set_svcr(struct kvm_vcpu *vcpu, const struct sys_reg_desc *rd,
+		    u64 val)
+{
+	u64 old = __vcpu_sys_reg(vcpu, rd->reg);
+
+	if (val & SVCR_RES0)
+		return -EINVAL;
+
+	if ((val & SVCR_ZA) && !(old & SVCR_ZA) && vcpu->arch.sme_state)
+		memset(vcpu->arch.sme_state, 0, vcpu_sme_state_size(vcpu));
+
+	if ((val & SVCR_SM) != (old & SVCR_SM)) {
+		memset(vcpu->arch.ctxt.fp_regs.vregs, 0,
+		       sizeof(vcpu->arch.ctxt.fp_regs.vregs));
+
+		if (vcpu->arch.sve_state)
+			memset(vcpu->arch.sve_state, 0,
+			       vcpu_sve_state_size(vcpu));
+
+		__vcpu_assign_sys_reg(vcpu, FPMR, 0);
+		vcpu->arch.ctxt.fp_regs.fpsr = 0x800009f;
+	}
+
+	__vcpu_assign_sys_reg(vcpu, rd->reg, val);
+	return 0;
+}
+
 static unsigned int pmu_visibility(const struct kvm_vcpu *vcpu,
 				   const struct sys_reg_desc *r)
 {
@@ -3248,7 +3275,7 @@ static const struct sys_reg_desc sys_reg_descs[] = {
 		    CTR_EL0_DminLine_MASK |
 		    CTR_EL0_L1Ip_MASK |
 		    CTR_EL0_IminLine_MASK),
-	{ SYS_DESC(SYS_SVCR), undef_access, reset_val, SVCR, 0, .visibility = sme_visibility  },
+	{ SYS_DESC(SYS_SVCR), undef_access, reset_val, SVCR, 0, .visibility = sme_visibility, .set_user = set_svcr },
 	{ SYS_DESC(SYS_FPMR), undef_access, reset_val, FPMR, 0, .visibility = fp8_visibility },
 
 	{ PMU_SYS_REG(PMCR_EL0), .access = access_pmcr, .reset = reset_pmcr,

-- 
2.39.5


