Return-Path: <linux-kselftest+bounces-35748-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0867AAE80F5
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Jun 2025 13:26:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53E2417A839
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Jun 2025 11:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 283882D6613;
	Wed, 25 Jun 2025 11:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aa7T/09e"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA29D2BF00C;
	Wed, 25 Jun 2025 11:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750850707; cv=none; b=pl0hFT0QW1/T9GeU4UuZ65z29x4HGrrwH5jODJ3d/FW4z4wNGI4nPY5SfySJSV71EEpWP5J3K5MjahLG2z4l4Xs4IsAQTl5z/Sd707DplIHU1NUpz6I22zNmjqK8eYNwBdsB7/M031Zu3MblsNBf1mK9iFLkr2NVRCCIRRp0jnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750850707; c=relaxed/simple;
	bh=L05MmxQzudW02kpJunpdmEsWZHXdGfcHqQRELTGnS54=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kSpcZLdDJpKrC0Qd1doDEnmLI3iQmyCYVv2WPL269224J8JAEGw0+QGAd//VRxI6WsUO8df+sJOFTE83CV680sL8ikXIIl6jI3FUhDBeApUIhbzTzKY/eWhTfuDM0o1m1NYLi5mo2jLHXCL9OdZghgFww2Ub89aVq/DnzRMqWM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aa7T/09e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48165C4CEF0;
	Wed, 25 Jun 2025 11:25:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750850705;
	bh=L05MmxQzudW02kpJunpdmEsWZHXdGfcHqQRELTGnS54=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=aa7T/09ebEOzU9nCv/HjNbUgb5Ku6qeg7X0olU4eTs61l8oreD4fDwYGu1QJoMkUw
	 SoEjg7eWvBCiQsVEK8jrpHywABoD+uLQ+sbrEWFhE+EbazR4TrGXtMg3BLJy2JDkjZ
	 7dakTekhnKdogO3lZ7Hduza1q+pOmRCOINQvCRdH6ogDQJnz22INmaCo3bhP0PGiY0
	 WfYcReQCxcvz+ZRn78oSjJIJ/V+RDYLmnNiwRY9HoB9eECWwuFMWvVcvg0GEkhKL5i
	 GXSiOldZU+1FsUh88QeVNyLgquQgzR7DIlLQSS9O0KXSYebZshuO+WTr0Hp7D9apFR
	 37pzqw24m+AQw==
From: Mark Brown <broonie@kernel.org>
Date: Wed, 25 Jun 2025 11:47:56 +0100
Subject: [PATCH v6 05/28] KVM: arm64: Introduce non-UNDEF FGT control
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250625-kvm-arm64-sme-v6-5-114cff4ffe04@kernel.org>
References: <20250625-kvm-arm64-sme-v6-0-114cff4ffe04@kernel.org>
In-Reply-To: <20250625-kvm-arm64-sme-v6-0-114cff4ffe04@kernel.org>
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
X-Mailer: b4 0.15-dev-08c49
X-Developer-Signature: v=1; a=openpgp-sha256; l=2816; i=broonie@kernel.org;
 h=from:subject:message-id; bh=L05MmxQzudW02kpJunpdmEsWZHXdGfcHqQRELTGnS54=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBoW9xoe1NIbe+ak2Z668atq+eG2pMfxdphaUpTr
 58zo8jAz1+JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaFvcaAAKCRAk1otyXVSH
 0EwQB/wP/1x/bMmpu6WKEkI765RzWyJ9jb19W/JtOeSpqkmP+siunmXeyVufWVVl+/Rx4+mHhpI
 u/oV4hkNREXH73pJWeBxDizlArUXrMNKIU7/o9rfl9kTS6llRtxr1vs0sG5f4QSkZXA2hlcZznW
 NlbOrKS9stA6SgwLq3dJ478j4yhCcDubsv978UwYa39xHH6ko0fU/6r0/TmvT1E28JweVzhhAqk
 4qKtiJz6BQTL8hNDByowdSajaj2Fc1mBZHY5dCELNZauEwxlmnuN362T+Rmyve+cyqcFSSr1YCX
 0jCFmJw/zVPh8PGCYFfIGACIMyYo+mbpo71ZafFxoU9ECsw3
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
index d27079968341..911da41e6bc0 100644
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
index 2ad57b117385..987f5c4c5747 100644
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
 		if (vcpu_has_nv(vcpu) && !is_hyp_ctxt(vcpu))		\
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


