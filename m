Return-Path: <linux-kselftest+bounces-26612-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 966BEA3541D
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Feb 2025 03:03:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAAAF16E49B
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Feb 2025 02:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7F0F18A6D7;
	Fri, 14 Feb 2025 02:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ifJGSSKC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9380E13C67E;
	Fri, 14 Feb 2025 02:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739498490; cv=none; b=WlZxXGeP2cVWE5YYRUMGfo2g1xARMnguB2+WIWqQk5MPz0GXhPUMHgCplXA9hFDTa5zcMPIRa4BHBwaLcoFrLJ9qGOMbu7ltywjitqxyk9CsDLbAhZiub7jKiNZgtUp3M+3gxZpZd6V/L5XBjpcyUh1+g8fV0zWhXnv5+f127gE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739498490; c=relaxed/simple;
	bh=/kVkzdok3zY0L9R8ATIeMk+gB1u00XvWZa5DduAicqo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HBfQ7nscIv7+1hYH6Pm1n87baNzJfGY1Rh0MHQDAQwqP16zdAe73sq0px1LoOl7WR3xXvbLlrzJ/rOjexizbiAkrWBJlK2f31Xp5eROtsE/Rz/kUEs7TZVJcnCmr0z8mLitWtaEnwwvqCszc9FB2w4eynFXjUGp2Mg8PsPXKPY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ifJGSSKC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 230A2C4CED1;
	Fri, 14 Feb 2025 02:01:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739498490;
	bh=/kVkzdok3zY0L9R8ATIeMk+gB1u00XvWZa5DduAicqo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ifJGSSKC3dlboRuPPAH9/sD6seprDak814Vr00WQC8rqpNXYqn7gvaMoUocdcv5hk
	 LANw68mffy5whHeW4XM3cwTafC3/y/6EViOdAB+cVVgt3Ih/hWxLyiFlfueld4zc/h
	 M6EV6pwTTytsuSwGnZeTjcui4Ic0oZFqpEo3O7bRIIxloZ3c+MyeCwLH28NyJLYdmi
	 EsG/Dh/JiDh2I6SZeY/GDcReirY+M2M1QGI60YZ95Cz2ffZsVvy8JUCdy5tk6iNAA/
	 PnsmLz5lX5NsTYJxiXSp56kwxZqxg6w4iZZ6yk+8/F1DhaXupwdAfk4aI2fZA8Xb+4
	 wT3PEYjeIIRzQ==
From: Mark Brown <broonie@kernel.org>
Date: Fri, 14 Feb 2025 01:57:51 +0000
Subject: [PATCH v4 08/27] KVM: arm64: Move SVE state access macros after
 feature test macros
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250214-kvm-arm64-sme-v4-8-d64a681adcc2@kernel.org>
References: <20250214-kvm-arm64-sme-v4-0-d64a681adcc2@kernel.org>
In-Reply-To: <20250214-kvm-arm64-sme-v4-0-d64a681adcc2@kernel.org>
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
X-Mailer: b4 0.15-dev-1b0d6
X-Developer-Signature: v=1; a=openpgp-sha256; l=2613; i=broonie@kernel.org;
 h=from:subject:message-id; bh=/kVkzdok3zY0L9R8ATIeMk+gB1u00XvWZa5DduAicqo=;
 b=owGbwMvMwMWocq27KDak/QLjabUkhvR1i48djVNYpiAqtqbA1jTY3/BFRoWz2O+W0I2ejhtPuSVX
 Fop1MhqzMDByMciKKbKsfZaxKj1cYuv8R/NfwQxiZQKZwsDFKQAT2arB/k9lXnD6fZ+brVzOt64vUB
 dZFex5L/zu6RdntpzuvlXpsGSNl3JbmXzAt9iAtlfMIVyXX0YGV9549y+rucHwLqN2CcspycdvLaTL
 tbf2Coc8mClQXPZx9nXu9scFOcyePi9N0tevXnusvf/rnMbyXTIX3K3i0tVOysy1iWp/qmstsazc9J
 byCpHPfoub/jJOv8S7PnVZgI9z8uy+aK8iJ+0E5qRksevvlAq3GWnqnG+KZbiy+96b5/NZU2Rdm9i+
 zC9sS7/htTxsN7+4XOX+y2bPboU05ug/4HXQVRTLznwl9Wuqi66/ffCdO4o7Ns75mVftcCKr+fwrz2
 M7tYSe7LktVhCwonSN6dkYEcYeAA==
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

In preparation for SME support move the macros used to access SVE state
after the feature test macros, we will need to test for SME subfeatures to
determine the size of the SME state.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/include/asm/kvm_host.h | 46 +++++++++++++++++++--------------------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 64f2885cd4a87e9807fbbbbe6de937ed304ab917..cef03309fbe6b7f44ab30357ceb037e7e342fb0c 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -927,29 +927,6 @@ struct kvm_vcpu_arch {
 #define IN_WFI			__vcpu_single_flag(sflags, BIT(6))
 
 
-/* Pointer to the vcpu's SVE FFR for sve_{save,load}_state() */
-#define vcpu_sve_pffr(vcpu) (kern_hyp_va((vcpu)->arch.sve_state) +	\
-			     sve_ffr_offset((vcpu)->arch.sve_max_vl))
-
-#define vcpu_sve_max_vq(vcpu)	sve_vq_from_vl((vcpu)->arch.sve_max_vl)
-
-#define vcpu_sve_zcr_elx(vcpu)						\
-	(unlikely(is_hyp_ctxt(vcpu)) ? ZCR_EL2 : ZCR_EL1)
-
-#define vcpu_sve_state_size(vcpu) ({					\
-	size_t __size_ret;						\
-	unsigned int __vcpu_vq;						\
-									\
-	if (WARN_ON(!sve_vl_valid((vcpu)->arch.sve_max_vl))) {		\
-		__size_ret = 0;						\
-	} else {							\
-		__vcpu_vq = vcpu_sve_max_vq(vcpu);			\
-		__size_ret = SVE_SIG_REGS_SIZE(__vcpu_vq);		\
-	}								\
-									\
-	__size_ret;							\
-})
-
 #define KVM_GUESTDBG_VALID_MASK (KVM_GUESTDBG_ENABLE | \
 				 KVM_GUESTDBG_USE_SW_BP | \
 				 KVM_GUESTDBG_USE_HW | \
@@ -985,6 +962,29 @@ struct kvm_vcpu_arch {
 
 #define vcpu_gp_regs(v)		(&(v)->arch.ctxt.regs)
 
+/* Pointer to the vcpu's SVE FFR for sve_{save,load}_state() */
+#define vcpu_sve_pffr(vcpu) (kern_hyp_va((vcpu)->arch.sve_state) +	\
+			     sve_ffr_offset((vcpu)->arch.sve_max_vl))
+
+#define vcpu_sve_max_vq(vcpu)	sve_vq_from_vl((vcpu)->arch.sve_max_vl)
+
+#define vcpu_sve_zcr_elx(vcpu)						\
+	(unlikely(is_hyp_ctxt(vcpu)) ? ZCR_EL2 : ZCR_EL1)
+
+#define vcpu_sve_state_size(vcpu) ({					\
+	size_t __size_ret;						\
+	unsigned int __vcpu_vq;						\
+									\
+	if (WARN_ON(!sve_vl_valid((vcpu)->arch.sve_max_vl))) {		\
+		__size_ret = 0;						\
+	} else {							\
+		__vcpu_vq = vcpu_sve_max_vq(vcpu);			\
+		__size_ret = SVE_SIG_REGS_SIZE(__vcpu_vq);		\
+	}								\
+									\
+	__size_ret;							\
+})
+
 /*
  * Only use __vcpu_sys_reg/ctxt_sys_reg if you know you want the
  * memory backed version of a register, and not the one most recently

-- 
2.39.5


