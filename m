Return-Path: <linux-kselftest+bounces-40566-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64751B3FE26
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Sep 2025 13:47:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 749D3487B0C
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Sep 2025 11:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FE012FD1D4;
	Tue,  2 Sep 2025 11:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CEPxVLc+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F8F2F9C3E;
	Tue,  2 Sep 2025 11:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756813487; cv=none; b=X0fG2u1ixaZUt0GWiehjP6stPGySX8h7DD07KdTdmWD59sKq0k+CVRCtSjhqmT52a3qH6VwMJoWfFOtvtHUxj1rfLc/alwJsjvXaiMkzrrKgtegu34YPPKUdb1DQxPq9mpSbRmH3StUavAPE/SOPIIeJ/178C+CchGi3dzh5P0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756813487; c=relaxed/simple;
	bh=dbI2jtQQauIA3bdjDRznGzLHLedqf9IfSzISWZL55Y8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=l1xjDCuDw65zkXtR0ubhg4LKjye2OiO8bhBo1IYlhoVlAB3GnfstzPynHj6CGHXZ7jxiY0u1OLVea1Y0tWp3AEaK6pStqB3aECsb4MYhMg4cQys526PURxK+l+D0BECx38dU7iWAtW54pNIUqMwJdhm0XU+NbkeHryW9n9iSA0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CEPxVLc+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE559C4CEF5;
	Tue,  2 Sep 2025 11:44:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756813486;
	bh=dbI2jtQQauIA3bdjDRznGzLHLedqf9IfSzISWZL55Y8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=CEPxVLc+Vl9vWaY9RmfDlC16U3O2k3JgV3xBmu/NBNY4Trq8wwbWqnP6VXWoGwnq9
	 7XbMpWTO7gerYOzQfPP3GyWMky0jjh85jCeQaQ23/L1gsOW6QxkCmpAV4v5OT393uD
	 VmCtB8O2XRyzj+iI+mstJsPXND+7mZJt0Om3pMrVDwmeuREY1faGgOgmDP6po7shNi
	 xJZgRQA4bmTP1qIUswl2tfGDsxPlISjMhfqNpjY2wssPcXTZozsZVal5scArDIczMH
	 2CVDOIby76jlUHyDMQCT3BNjnfR6z4QE34RquVZ+jJ67rMJ6Pw0EX7mZkyzRMXrvV0
	 UuYBSk9z4Rf+g==
From: Mark Brown <broonie@kernel.org>
Date: Tue, 02 Sep 2025 12:36:09 +0100
Subject: [PATCH v8 06/29] KVM: arm64: Introduce non-UNDEF FGT control
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250902-kvm-arm64-sme-v8-6-2cb2199c656c@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2799; i=broonie@kernel.org;
 h=from:subject:message-id; bh=dbI2jtQQauIA3bdjDRznGzLHLedqf9IfSzISWZL55Y8=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBotth+tJnXowwXsMWuGwEIdyHOnkrvT98GfQg5e
 ttpOQ1xj9mJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaLbYfgAKCRAk1otyXVSH
 0AWGB/9S5rlx1MKoPilf5QfFv4ZvmsRoqSmfY10BOm1SGXi15EKmsQ9vQCv5C1FqT5aoYR5z/Nf
 BwnpHqKJFi+kBYvd3SbKuTE93ebqUXn0dwWukCotNvaslzhqgyjtyFBGA/QDMGVD2GXAyotnCqX
 0U94z1W4rg9I00hdDn51Gv4wE5j9N9uSvboX7riZiizIfZt3Dmb9XXBhDaR8gSfqT28+B/KMvRq
 YV++ye1df9d3iS6BTbwliYf0jonei8HBl/ZUgpF3a6dqozfbT9DlX0sUTTsk5MPEdIZq9kCiq4j
 gGIyqHim1hyI95bnxbDDKQvwQePEaJT0IEbHgZ+HCke02qsS
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

We have support for determining a set of fine grained traps to enable for
the guest which is tied to the support for injecting UNDEFs for undefined
features. This means that we can't use the mechanism for system registers
which should be present but need emulation, such as SMPRI_EL1 which should
be accessible when SME is present but if SME priority support is absent
SMPRI_EL1.Priority should be RAZ.

Add an additional set of fine grained traps fgt, mirroring the existing fgu
array. We use the same format where we always set the bit for the trap in
the array as for FGU. This makes it clear what is being explicitly managed
and keeps the code consistent.

We do not convert the handling of ARM_WORKAROUND_AMPERE_ACO3_CPU_38 to this
mechanism since this only enables a write trap and when implementing the
existing UNDEF that we would share the read and write trap enablement (this
being the overwhelmingly common case).

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/include/asm/kvm_host.h       | 6 ++++++
 arch/arm64/kvm/hyp/include/hyp/switch.h | 7 ++++---
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 2f2394cce24e..b501c2880ba2 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -302,6 +302,12 @@ struct kvm_arch {
 	 */
 	u64 fgu[__NR_FGT_GROUP_IDS__];
 
+	/*
+	 * Additional FGTs to enable for the guests, eg. for emulated
+	 * registers,
+	 */
+	u64 fgt[__NR_FGT_GROUP_IDS__];
+
 	/*
 	 * Stage 2 paging state for VMs with nested S2 using a virtual
 	 * VMID.
diff --git a/arch/arm64/kvm/hyp/include/hyp/switch.h b/arch/arm64/kvm/hyp/include/hyp/switch.h
index 84ec4e100fbb..d5620e02787f 100644
--- a/arch/arm64/kvm/hyp/include/hyp/switch.h
+++ b/arch/arm64/kvm/hyp/include/hyp/switch.h
@@ -283,9 +283,9 @@ static inline void __deactivate_cptr_traps(struct kvm_vcpu *vcpu)
 		id;							\
 	})
 
-#define compute_undef_clr_set(vcpu, kvm, reg, clr, set)			\
+#define compute_trap_clr_set(vcpu, kvm, trap, reg, clr, set)		\
 	do {								\
-		u64 hfg = kvm->arch.fgu[reg_to_fgt_group_id(reg)];	\
+		u64 hfg = kvm->arch.trap[reg_to_fgt_group_id(reg)];	\
 		struct fgt_masks *m = reg_to_fgt_masks(reg);		\
 		set |= hfg & m->mask;					\
 		clr |= hfg & m->nmask;					\
@@ -301,7 +301,8 @@ static inline void __deactivate_cptr_traps(struct kvm_vcpu *vcpu)
 		if (is_nested_ctxt(vcpu))				\
 			compute_clr_set(vcpu, reg, c, s);		\
 									\
-		compute_undef_clr_set(vcpu, kvm, reg, c, s);		\
+		compute_trap_clr_set(vcpu, kvm, fgu, reg, c, s);	\
+		compute_trap_clr_set(vcpu, kvm, fgt, reg, c, s);	\
 									\
 		val = m->nmask;						\
 		val |= s;						\

-- 
2.39.5


