Return-Path: <linux-kselftest+bounces-23675-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BDBE29F970D
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Dec 2024 17:57:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6D00188BFF3
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Dec 2024 16:54:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8DD32210F8;
	Fri, 20 Dec 2024 16:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="crEj/i06"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76BA721B1BC;
	Fri, 20 Dec 2024 16:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734713489; cv=none; b=fUWJNLxw8Qy5wZSV9QUGRlL3PqMOVXRso+VtNYT5oE4g+gMx+aPrlxn1eYf/GthtpQ3Gm//BZfv7/crdBfFQ0GHUMUGDsSCgUI6lBdwR/LeX69DxQA2lAz3DEtzKeXPTCW35ZY1dCErJEGrKv3aG507GVrb7zdDuV6DbfvnZgQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734713489; c=relaxed/simple;
	bh=/i3TwaKgCBLSWDUFzgZJ5E4rHb3UDDDbQ/9/hT2MAGs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QP3EUwUh/YIi/AddD6wIiHG1c19lCqL7axrTeEFVHQanh56xi6R8y6l58jmlJGbTiFJFkLP/Wwp+AJDVz0ItRYpJXuj9XOIGL5Qfcztgs8Eu48VDzKLaoprL8JlLaDUqkh9X+yNfyoqBBWR+6ME5/qZKqBc13aK/walxXWI0G6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=crEj/i06; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACAB8C4CEDC;
	Fri, 20 Dec 2024 16:51:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734713488;
	bh=/i3TwaKgCBLSWDUFzgZJ5E4rHb3UDDDbQ/9/hT2MAGs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=crEj/i06gGmZk5M1LHwTVOq3Ku4eZAwf5Lzjlpp4UJMXlDax1g3QMdBxXpwDIF7FL
	 3f4Sw2E19x5pgh+/SUWeExgu5ZqBXoC0UQYa9MfQqEiEqAYj7i1uvEoPBmwRt3Zch/
	 yBRzbMe3fLfIJ0ZQU2nlMSoQ4Z4Ft0xsLUnbt10tgLxn8eAPoNfh4jbCJEWaXWYKkj
	 6+JriIQTN1rfxrzPFATGPza69g/KlQ6qL7xrR2ftbW4arHneM8tELY2c83conD3+sc
	 Ne7bT4T5Z9rC0XG/I9u3BvNBBAG9H0C3RtojGEnJmqcjV8an0PT22I8GWfXd1YQeOo
	 D+NPSWaiBOsYg==
From: Mark Brown <broonie@kernel.org>
Date: Fri, 20 Dec 2024 16:46:33 +0000
Subject: [PATCH RFC v3 08/27] KVM: arm64: Move SVE state access macros
 after feature test macros
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241220-kvm-arm64-sme-v3-8-05b018c1ffeb@kernel.org>
References: <20241220-kvm-arm64-sme-v3-0-05b018c1ffeb@kernel.org>
In-Reply-To: <20241220-kvm-arm64-sme-v3-0-05b018c1ffeb@kernel.org>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
 Joey Gouly <joey.gouly@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, Will Deacon <will@kernel.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <shuah@kernel.org>
Cc: Dave Martin <Dave.Martin@arm.com>, Fuad Tabba <tabba@google.com>, 
 linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-1b0d6
X-Developer-Signature: v=1; a=openpgp-sha256; l=2613; i=broonie@kernel.org;
 h=from:subject:message-id; bh=/i3TwaKgCBLSWDUFzgZJ5E4rHb3UDDDbQ/9/hT2MAGs=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBnZaBaSCMFrVKugleuCqcjESXruDC/s6CaD4yZ5F6Z
 p7wReKWJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZ2WgWgAKCRAk1otyXVSH0LqlB/
 9idSTtrsfAftjwtJ51rl1MDfrczjOESiyC+PCFAePnmVi3KdagMZPCJQvdE7wrKQuchGOWvo9/CLq+
 cN7EaMnLRHfgp8Z/hUnReRjkCeiHX6BBOj0iNBGSRirbpxgDO95XXMQAGYnQLEeGAXP1431tdMRmzf
 LAzBVbJtNVeUBBEHCRD0Yn5Wb8AKl7fWQYwAJHJikESsLd6fPuwCVKe+oekBg/R1YaUxiTNfVApgOM
 s4PZRY/HFMAqM77VIzYl/XflL9D6jQAwR2yKjwLDgt7OK5tGxJk41JJH0hl36jcAdH41yrYuMic6lU
 kq+tPZijmIyttMxtCnye3BE46zZ1AN
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
index fca81ede6140c0ee7d03cb6ca8f5eead45b87033..97b617606221e8c11fd2b55d9636848d8453209f 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -934,29 +934,6 @@ struct kvm_vcpu_arch {
 #define IN_WFI			__vcpu_single_flag(sflags, BIT(7))
 
 
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
@@ -992,6 +969,29 @@ struct kvm_vcpu_arch {
 
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


