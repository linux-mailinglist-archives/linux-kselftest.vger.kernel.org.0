Return-Path: <linux-kselftest+bounces-31004-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F538A91066
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Apr 2025 02:28:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3AE7C7A5CCF
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Apr 2025 00:27:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B9C41DE3AC;
	Thu, 17 Apr 2025 00:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ta9GsKKB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2834517A2F9;
	Thu, 17 Apr 2025 00:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744849575; cv=none; b=J85g7yfJYhmVm+DrRCAzKDjoH2zcpln/UsC5vEy7ukjOK/yA81fT0qwVi4B4zlQhDPn85r7AQztx0AzbglVOEKrM/zfJvdAe6KOqLscpZdfljWcoey44kSfz8qLkPuY+CtAYnTMYX7DsNul6G/9mzq+7WNKGqGp7kyU3QycAUe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744849575; c=relaxed/simple;
	bh=a0Ia76ikFrUJD8FigO1QWjiw7c+Y7loFA8aT5ZqeiW0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dAXiYa0hP1XN0/1/ITljZVSemPoPb2SJFBBvELCE2/D4i+2tWgCAHrtkxcTc8cvjmBPKJviloicUb9eD0kqJ6t4T4G+Mc1twrH+UxrhtcjZmzVUOJE0xWD4NL52NeQ9Ze78W4RlVgE5BXACxPsjAdvULO2Ox3PpBknKhNI3gzFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ta9GsKKB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F542C4CEE2;
	Thu, 17 Apr 2025 00:26:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744849574;
	bh=a0Ia76ikFrUJD8FigO1QWjiw7c+Y7loFA8aT5ZqeiW0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Ta9GsKKBznileJpn86YktlmV/2ZVpEB4KwCBYsiKyDZWXyRJubcHVGl+nF+7asAsN
	 V5UXraXUbS6/mU8PZ3bDelUkLvDGZIumJFSc7b2RSi8z3cdB1OlESEBXx7pSHVh8AW
	 JUwbzhpiCosUVJhG9orsvKtm3Z3l9mhTUMuEWxTIRAXazeL2fxCg6pqNWhWSUKiwrH
	 pKedc+J+eCk8WhAA2fGEMA4RMHcgdGogp5+I/cI8S309+UjgYz1TDA7N8lItdgeocV
	 4xD7BxFiAw+pIBEgAhQ2uPspi2K43Pij4ey7wAUEMrES6vSkKx9cauKu5VyDPkzvZ0
	 Iq9tk+3P/8eGA==
From: Mark Brown <broonie@kernel.org>
Date: Thu, 17 Apr 2025 01:25:12 +0100
Subject: [PATCH v5 08/28] KVM: arm64: Move SVE state access macros after
 feature test macros
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250417-kvm-arm64-sme-v5-8-f469a2d5f574@kernel.org>
References: <20250417-kvm-arm64-sme-v5-0-f469a2d5f574@kernel.org>
In-Reply-To: <20250417-kvm-arm64-sme-v5-0-f469a2d5f574@kernel.org>
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
X-Mailer: b4 0.15-dev-c25d1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2566; i=broonie@kernel.org;
 h=from:subject:message-id; bh=a0Ia76ikFrUJD8FigO1QWjiw7c+Y7loFA8aT5ZqeiW0=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBoAEp1jatlIUZQb9blHKMZHeDBVqZrdc3aooPmUoKd
 9Enk3MqJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaABKdQAKCRAk1otyXVSH0NmSB/
 0duzDLiieA4h9tp1fqx0R0MozC0Iiep5u4vpp5wHs0vYyxYrBSrrwa3fTLRt67q6lPFy/26m3CJ3v1
 4LorI2sfQfvKloiy8rIoKCAaOYbGaHdLABTBHCxW+Tnwvj+ehpmGxLxyVFwdmqfelS/K8mgl/FGkXN
 0XJmUD6cP2G0zu5k0G2HIc+fnE4ZORVSOWLKpfNgjyXkb5N2KFXrzWYignYo4w8KLlQaW0fWNvET/i
 yVgcT663qkewkU7BSkAlNfOXnor8Bf3HRxplprlJFzUhjMCEUHaTs7QbaHvtWmyADFa7GX4MIouIVw
 qprHWiaQg2wdk4VfXbdXJV4A3p7zEc
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
index 3fc8260d55a6..fb577e10c95d 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -968,29 +968,6 @@ struct kvm_vcpu_arch {
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
@@ -1026,6 +1003,29 @@ struct kvm_vcpu_arch {
 
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


