Return-Path: <linux-kselftest+bounces-47891-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7710BCD7B62
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Dec 2025 02:48:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0B5143021689
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Dec 2025 01:47:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64E673195F3;
	Tue, 23 Dec 2025 01:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="clMp99AQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37FF9318125;
	Tue, 23 Dec 2025 01:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766452986; cv=none; b=FA9hk+zifiS1CJrLVYRF8CxwzYfE+m/er+vWZNRTN0w344jo6wYo5EFhre0eMByYc2++VSovw6TEViBXwAskmqE4D3qB5ctcyAY/77DNZNrlj/EbleIy3SWUDkSSMj37UANAwW2e5HMTPY0PaufaRY4Rq7I8EluY3bQKxkfqlfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766452986; c=relaxed/simple;
	bh=JJCv5/aWHYtYD01yHMX/Fpj/I6fYeKS4R7fEQWO6boU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=e60Iusweq+pVHQtlThe4GCgPpKtc2vb3a+0RzFIQCcKMp96CleJo5u8IwAnJVcqhhPN+alhUm0PZ8QjJaDCw1ALkIGRsKW6kvz/gb/dkMPe235l98zmkS5bY4COcDNAX7qIgPklwThTQUUY39l5Tnt9ZIOJQI18BmMVTBb/y3ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=clMp99AQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19B62C19424;
	Tue, 23 Dec 2025 01:23:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766452985;
	bh=JJCv5/aWHYtYD01yHMX/Fpj/I6fYeKS4R7fEQWO6boU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=clMp99AQyoLYHSM78oI17kDX2socHgqwo8NmYdrmM4f80z/WWY7k5et5kBFDwWUci
	 NggCdMxBieK3cAH6HS/6hTX8b3hSah1OWLkH+gRaCEjixJnFDiFwwNPkOCLRmvCior
	 XyH7HCLHy7PNW60R18o/d2ehLYbx5ZyEHKHNAiPfouhxz/LTZTAx+dkVPhzabEFe4e
	 mbNS9a2JbTVEynIw7//58Sx1JAU6JNl/rvZYL4yAQarxNuLO7SePSdVxy7FcaC+Vdi
	 BrzzW325ajpnVCRu7VHgmH/rUAyvaVqGAZ7hkIwExMegQFSIuIPpQ6NaRB2mqgQPYq
	 sHuzcp8Mg7Ppw==
From: Mark Brown <broonie@kernel.org>
Date: Tue, 23 Dec 2025 01:21:15 +0000
Subject: [PATCH v9 21/30] KVM: arm64: Flush register state on writes to
 SVCR.SM and SVCR.ZA
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251223-kvm-arm64-sme-v9-21-8be3867cb883@kernel.org>
References: <20251223-kvm-arm64-sme-v9-0-8be3867cb883@kernel.org>
In-Reply-To: <20251223-kvm-arm64-sme-v9-0-8be3867cb883@kernel.org>
To: Marc Zyngier <maz@kernel.org>, Joey Gouly <joey.gouly@arm.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, Will Deacon <will@kernel.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <shuah@kernel.org>, Oliver Upton <oupton@kernel.org>
Cc: Dave Martin <Dave.Martin@arm.com>, Fuad Tabba <tabba@google.com>, 
 Mark Rutland <mark.rutland@arm.com>, Ben Horgan <ben.horgan@arm.com>, 
 linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Eric Auger <eric.auger@redhat.com>, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=3621; i=broonie@kernel.org;
 h=from:subject:message-id; bh=JJCv5/aWHYtYD01yHMX/Fpj/I6fYeKS4R7fEQWO6boU=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBpSe6SNLuv1rExcs0qccarlk6HYOfwO+99KdPxT
 GgJYVCU2KeJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaUnukgAKCRAk1otyXVSH
 0EXLB/0UmpiAcLgtSGMFGBtBAEJNxmo7r6TtIB50Vi7F1WNiWbTvpXf2MPqzyU6a4daDzJ4nEDk
 1lEYUZRcMG22AM+Bs9UxhKnZVw155gLWqWvFAw3oxmWkDwEr2bLQYkJFBE3p24tyAbVh5Ble5BI
 l++ArwH2g6gBlfmpdSmO8V/rixVdTTuL1FQ+miPSsYdGDjUC8S2Yc4FRsaJffEfCss4BRNUxRYm
 ndaH3VpxDBihGNB5AP3tZbvbfP+nWJ+FOvqyEdARwVNogDmPL5eNR9AaRvy8MQIEQ4bBjJ6DZqV
 M6rMzSI/e+aEWKgKQeLWySapzOArXvQ5bbmctrPyAh6bLbFm
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
index 44595a789a97..bd7a9a4efbc3 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -1147,6 +1147,30 @@ struct kvm_vcpu_arch {
 
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
index 51f175bbe8d1..4ecfcb0af24c 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -927,6 +927,33 @@ static unsigned int hidden_visibility(const struct kvm_vcpu *vcpu,
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
@@ -3512,7 +3539,7 @@ static const struct sys_reg_desc sys_reg_descs[] = {
 		    CTR_EL0_DminLine_MASK |
 		    CTR_EL0_L1Ip_MASK |
 		    CTR_EL0_IminLine_MASK),
-	{ SYS_DESC(SYS_SVCR), undef_access, reset_val, SVCR, 0, .visibility = sme_visibility  },
+	{ SYS_DESC(SYS_SVCR), undef_access, reset_val, SVCR, 0, .visibility = sme_visibility, .set_user = set_svcr },
 	{ SYS_DESC(SYS_FPMR), undef_access, reset_val, FPMR, 0, .visibility = fp8_visibility },
 
 	{ PMU_SYS_REG(PMCR_EL0), .access = access_pmcr, .reset = reset_pmcr,

-- 
2.47.3


