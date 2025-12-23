Return-Path: <linux-kselftest+bounces-47878-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E949ACD7C46
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Dec 2025 02:58:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7AE20304FB9A
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Dec 2025 01:52:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 882FA28DB46;
	Tue, 23 Dec 2025 01:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gExXjjOl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3377279DA6;
	Tue, 23 Dec 2025 01:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766452929; cv=none; b=ODdjRO2Tc3rSmSb/9oWrsNWLZBafk1UsujY57RsHgTR5Eck2HU+Gx6IXkSth1OWD2/YRJBHMv8NbIhHiPCcP6XWUE67j2gOCxicPh2VcZcciVwIimIF9nJyUd0pYbL1wrV23Qi6/3Tq0DHedz0A1PTkZY0sdWsCSRJMOIoG4DBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766452929; c=relaxed/simple;
	bh=E1tho8A6hfPPGjuGEPK6k9ILaXOQXFCS51jTCVXwf/E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PaeMnTk3TobJ3d8xJoKngJaXSl43RaIalqivE9Vfn32hhcpm3ER6zoF1v7ozyQLd5mj84AW/XhP6WGwkyoATY5W5pEh5V5K0LXKLFFuGUy6wkRoIlLGdL0l94NTQlrDvvmCe8Rlna3Yz7DXiwIp5g16vNPXeXz/wk8A8H12SR2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gExXjjOl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30898C116C6;
	Tue, 23 Dec 2025 01:22:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766452929;
	bh=E1tho8A6hfPPGjuGEPK6k9ILaXOQXFCS51jTCVXwf/E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=gExXjjOlepqN3I13y0vqBReUuuEzplfXjnjUFvjDeOlBhFhyGfU4eRAh0gMu6+4OD
	 Amy1sOzU0+P+ZE2HRl9YMMoDJ7o5epqMgiUAvLE5D7qah7WWWg9azoijNuipTZgrES
	 Vnt2zYye0PxiIdvQF1k3OkzHivUjs5nan+78m808PeufAJ/zpgfmyXNO8N0M7innO9
	 joL5iCwyH5dZ2DYdCtMCLmz1Y6WuprN8a2JKQDrTSaE43b7G9Dr4pcf1R92wEWVTTq
	 g3+ZPfNZak26mZggNJANWMXi4W5r1dktVdQxmL/SehSbdzp+2MImOyO23QD9JONf3B
	 uSGzrxyW7DeAg==
From: Mark Brown <broonie@kernel.org>
Date: Tue, 23 Dec 2025 01:21:02 +0000
Subject: [PATCH v9 08/30] KVM: arm64: Move SVE state access macros after
 feature test macros
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251223-kvm-arm64-sme-v9-8-8be3867cb883@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2722; i=broonie@kernel.org;
 h=from:subject:message-id; bh=E1tho8A6hfPPGjuGEPK6k9ILaXOQXFCS51jTCVXwf/E=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBpSe6I+tag2JsffKzG88VawRRVvwEfOmEYhzfdw
 YuOxyEI/Y6JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaUnuiAAKCRAk1otyXVSH
 0IZsB/9nwQDCBcfXW8cBxP2zWPcZOPYHXxojDf7/BDDGG43agQTrUFKY6M/y0F5vuy9dLfdKSPl
 BZPbc7ZYMO7iWg3arGKdU9DJL6jbyQ8DUj45o2cXcXhaRjdtwFCedIMFWsZMZVyF+MGYz3VfAql
 2LcqCDsWakugDU6g1FmooNBmgNTxHIRWsIr1lHxErTUtCR/nd/fqG6D/ZW12TLb0ObQ7bYP7dFc
 lQhRJqj1KCTzUVY9VbTDwFQ7lDz8R4/G4VZ5bG5na7PDEE8MBuKvoEM8haAsdexPub0+ul+4/2l
 uj7LIRLkgThFIHZDgsFKKBW9NIMpAOONGLCZWW6UL9jeGGqD
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
index ac7f970c7883..e6d25db10a6b 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -1048,31 +1048,6 @@ struct kvm_vcpu_arch {
 #define NESTED_SERROR_PENDING	__vcpu_single_flag(sflags, BIT(8))
 
 
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
@@ -1108,6 +1083,31 @@ struct kvm_vcpu_arch {
 
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
2.47.3


