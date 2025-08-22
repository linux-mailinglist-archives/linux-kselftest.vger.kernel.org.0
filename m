Return-Path: <linux-kselftest+bounces-39626-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B396B30B1A
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Aug 2025 03:58:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C95601649F9
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Aug 2025 01:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E2102222D2;
	Fri, 22 Aug 2025 01:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hjW7ydp/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C28E1DA60F;
	Fri, 22 Aug 2025 01:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755827690; cv=none; b=nhW4bHLRK+v5GtwAzF9HbEp+o0jlaPLVj1nc39X0mvt5XiPxa8qH9CfNKWCDIx7p3dn2JvY+OoOM9gxutikox0SbmoSDjWfnqJ4ackkr7Q2QIERIp3P91iqqHpcI7vvYVefARHugdIjrkqYAg/dfmn3cElmDd44kFAlymEh850s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755827690; c=relaxed/simple;
	bh=dbI2jtQQauIA3bdjDRznGzLHLedqf9IfSzISWZL55Y8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KIm5H7HuF5ORB4rVMxY51Z1bZHwMBG6PY2J7Y8veW/mDcPDMzkf24GMvvtGRYIvtB1sY3WkHnzP8RvZLz/nGfhDVgLgYC2NqLqjBKfqiGdYotTE41eEobn+19QmsBxM0HdtcfJYya2dwYSUu3T5LeJVtARKZ1WVCgSokrPPctCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hjW7ydp/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E16CCC113D0;
	Fri, 22 Aug 2025 01:54:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755827690;
	bh=dbI2jtQQauIA3bdjDRznGzLHLedqf9IfSzISWZL55Y8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=hjW7ydp/ascrbwXrcytmv5A9A1QEEN67C+Y5WX5OBY3/PYu9k8RL7QbbRZ3A9cF87
	 zvHTJdrUz+BxWe3Oo3pKkXRjOlbISZf0JhWVrDdcLIPgv0t9O8QJG8MglnenJ1r4L4
	 Yif+4ocwkGzHJ9n55EdJsFiBKMbmjJn280S0X3Ku4458uAsp3oN+dRXdN+imOr4yQs
	 CbIkHI7jrNc0cuB1br7jKSQPZrpWyjB2UZlMbFiH3nuJbbRr/7yG4sHhgZN1S2aUy9
	 1eETb+eeKfs7gFAO5W260jW5v1hCuQOH5HTm3Mx15CUoonxniSs1EyqwYt/R06LSwk
	 CastnJw58rfbQ==
From: Mark Brown <broonie@kernel.org>
Date: Fri, 22 Aug 2025 02:53:35 +0100
Subject: [PATCH v7 06/29] KVM: arm64: Introduce non-UNDEF FGT control
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250822-kvm-arm64-sme-v7-6-7a65d82b8b10@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2799; i=broonie@kernel.org;
 h=from:subject:message-id; bh=dbI2jtQQauIA3bdjDRznGzLHLedqf9IfSzISWZL55Y8=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBop829zOsFUMjKA1Q+FQQwAiqq9AB2vWjQjAPE2
 u9JV2QclT6JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaKfNvQAKCRAk1otyXVSH
 0CJDB/9j0rvgLnZvq7G9tLdHgMeGcVymfgbIkxBZuMivsNHRGROfGH4orSwWGmYihtCtFbjPm+j
 uAgEjOrR03z3Zp+lXbyNnG7zSDiMMS0yRZ4Xxje+HUVTN23JD59V1OIx6W30F4FhIU2La5UhiY6
 vGPLnuBCDShNugj/oJR4HqR0EzyxuQS0jUqH/R/Csn4SajUTfdw2JVT5E0E6KX+09Wbw07f8tsV
 /Wq1P3h3y5MUScUQ6iD+huxr8aPoHUtSIjn12pOMtCErdSm9pHnjmQDI2AjPL3Q+f/Wv2IiaIJv
 olwGfxzvFeQrkbaK/+kKYtb3j7j8UeKtQZm9j85taCkAp3FN
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


