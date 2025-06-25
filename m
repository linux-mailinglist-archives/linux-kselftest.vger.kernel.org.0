Return-Path: <linux-kselftest+bounces-35751-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7B5DAE8101
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Jun 2025 13:27:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1647D17C16F
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Jun 2025 11:27:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BD452DAFAD;
	Wed, 25 Jun 2025 11:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HHsxH8DA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC0E2DAFA9;
	Wed, 25 Jun 2025 11:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750850717; cv=none; b=WQOI3lVKJL0akJekvvwmluOz1mMG0PHkkXl7GYxz74A5Q6BbrzCnomgC71xTL1WHdUUOKIEvq8Wso8wuR9NCdnW3ApWvKHNYMzRfYKc14RMh5x3N/3cywE+XBcbJnUpeGgCOwFRqLn4ruX7JoQAFZb+7FstejAHj9SAoLR3Xhys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750850717; c=relaxed/simple;
	bh=WVYXu++WDYoPdV2mAe1OIg1hg2LAnVMoomMYEHc1wYQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fzN/2cpIvi3tPPv/WX3bOmd8vM4Xn99HP3bSIjcixbXwAySCXrzfAtTWgzf81hG4JA9IDusbD+dRdCTerZzV3kLy3tc/Iv5kYFGfncvMyKFAMsdKXfyZ+fo4xPpW87pJVWPVcN/l42c92L/0FIza34DvTF4f2J2RmFpvsGb9ROs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HHsxH8DA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4055FC4CEEF;
	Wed, 25 Jun 2025 11:25:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750850716;
	bh=WVYXu++WDYoPdV2mAe1OIg1hg2LAnVMoomMYEHc1wYQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=HHsxH8DAP2KV5CFhdFVMRrSTY4sezfVqDbgX5VOv39JOyubaZ7i0vRbTBGC7Mz0Y7
	 zQMctVSLJ4uhyhZ/H7P8BYMepwDAVejYsuLXz3EfeiOOHVHTV6nKu2/APeiWTi+TYK
	 015kZVSE3XvZKbT04zdsf1KsafbINuy4MYQp+KjR95HcPn4RedONb5rMqowa1r9/p4
	 BSk4E+GmuaoEtgII7O1u0WxkFzgFW+rwuGRp/xfdW4dF9+Y9X3I9ufaP0c2bYUBDUf
	 4HKUZlHirf6IQD/gD6rVBKH3A62HkhBf1rK8/xJT/ORXUIBl9NC/O0qZu1iLXxJETK
	 hc5hbq0H37PZw==
From: Mark Brown <broonie@kernel.org>
Date: Wed, 25 Jun 2025 11:47:59 +0100
Subject: [PATCH v6 08/28] KVM: arm64: Move SVE state access macros after
 feature test macros
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250625-kvm-arm64-sme-v6-8-114cff4ffe04@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2716; i=broonie@kernel.org;
 h=from:subject:message-id; bh=WVYXu++WDYoPdV2mAe1OIg1hg2LAnVMoomMYEHc1wYQ=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBoW9xro+N//1P3M6b4y8pM0l+d2Nf7d7tOaVNSm
 vsAbwM1oLSJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaFvcawAKCRAk1otyXVSH
 0GenB/4/ESl6BFzkkfDj3Vo6MA4/qcHimdbs2RbOkXdTPqnh9pOEUJpYpODUxSxPBnWOvj/zfa7
 WrVIiOnlivCHIVN8M+DfuU16LjkPRP3cQkTN2uanroioZNsgkfsevhx5E0v3b/axL2Gh8c/eSQe
 +Ch7vz3jrG7+EQZ8F+qcaPCJGfU0RDR/XY7POs75XkAGjISgvcXSAQer7LhiMt/SsV4qaQZr+6G
 GhFXZFaHMgE1Si8qusjdpxaza6ArKpxKTaLW7qUzsvyQ5YcAEvgNkc3oZR79xPNuZjjA0w6uKsg
 ctFicAe/UL8L0BQLPdIYe+zL1zhQU50jh5G32j0iYQNKQpCM
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

In preparation for SME support move the macros used to access SVE state
after the feature test macros, we will need to test for SME subfeatures to
determine the size of the SME state.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/include/asm/kvm_host.h | 50 +++++++++++++++++++--------------------
 1 file changed, 25 insertions(+), 25 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 911da41e6bc0..49ca2c3b05a2 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -1023,31 +1023,6 @@ struct kvm_vcpu_arch {
 #define IN_NESTED_ERET		__vcpu_single_flag(sflags, BIT(7))
 
 
-/* Pointer to the vcpu's SVE FFR for sve_{save,load}_state() */
-#define vcpu_sve_pffr(vcpu) (kern_hyp_va((vcpu)->arch.sve_state) +	\
-			     sve_ffr_offset((vcpu)->arch.sve_max_vl))
-
-#define vcpu_sve_max_vq(vcpu)	sve_vq_from_vl((vcpu)->arch.sve_max_vl)
-
-#define vcpu_sve_zcr_elx(vcpu)						\
-	(unlikely(is_hyp_ctxt(vcpu)) ? ZCR_EL2 : ZCR_EL1)
-
-#define sve_state_size_from_vl(sve_max_vl) ({				\
-	size_t __size_ret;						\
-	unsigned int __vq;						\
-									\
-	if (WARN_ON(!sve_vl_valid(sve_max_vl))) {			\
-		__size_ret = 0;						\
-	} else {							\
-		__vq = sve_vq_from_vl(sve_max_vl);			\
-		__size_ret = SVE_SIG_REGS_SIZE(__vq);			\
-	}								\
-									\
-	__size_ret;							\
-})
-
-#define vcpu_sve_state_size(vcpu) sve_state_size_from_vl((vcpu)->arch.sve_max_vl)
-
 #define KVM_GUESTDBG_VALID_MASK (KVM_GUESTDBG_ENABLE | \
 				 KVM_GUESTDBG_USE_SW_BP | \
 				 KVM_GUESTDBG_USE_HW | \
@@ -1083,6 +1058,31 @@ struct kvm_vcpu_arch {
 
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
+#define sve_state_size_from_vl(sve_max_vl) ({				\
+	size_t __size_ret;						\
+	unsigned int __vq;						\
+									\
+	if (WARN_ON(!sve_vl_valid(sve_max_vl))) {			\
+		__size_ret = 0;						\
+	} else {							\
+		__vq = sve_vq_from_vl(sve_max_vl);			\
+		__size_ret = SVE_SIG_REGS_SIZE(__vq);			\
+	}								\
+									\
+	__size_ret;							\
+})
+
+#define vcpu_sve_state_size(vcpu) sve_state_size_from_vl((vcpu)->arch.sve_max_vl)
+
 /*
  * Only use __vcpu_sys_reg/ctxt_sys_reg if you know you want the
  * memory backed version of a register, and not the one most recently

-- 
2.39.5


