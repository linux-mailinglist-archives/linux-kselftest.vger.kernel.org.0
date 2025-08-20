Return-Path: <linux-kselftest+bounces-39378-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C86E7B2DF0C
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Aug 2025 16:21:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D15FEA066B6
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Aug 2025 14:17:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57D8C2E2EEE;
	Wed, 20 Aug 2025 14:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vCwpma3J"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2931E2E2EF7;
	Wed, 20 Aug 2025 14:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755699335; cv=none; b=L/BbWfawt22DnDoVFDgV+1Tb+w2Ga5BzQk6bCI01uHHm9+8psIvRacywh5YcZp7xPv7PoYLsdAq/MrQ3PUIiSrzARvW5Nc2qhVNlWxLtuqVGtpr5Zkt/v4rxJ1p6ObcH7ODtr7lnIeEQHL3EmSn6k4vrDlPsO+wJrj37Tf2Up60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755699335; c=relaxed/simple;
	bh=XqW9QBgR4CO7JeWk2qq6fqCcQ8Tlv6hAbg0b3Fasmt0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OXtFGvCDCet6ZkMBtf84KTl3kgowWc//0eJtXKOg03obMwb24n+dX7Xq4h0ZNimrGoQLrJt5MpCFBX5I6oA3c7TY3RbR1Xvdgtk3hFYi+7mU+RqgV3seSz0ERQD7GGQE2tQNMGAPnbRvZa3XuEW6LlHtHAWQlyHGrP34MHU203U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vCwpma3J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAD10C116B1;
	Wed, 20 Aug 2025 14:15:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755699334;
	bh=XqW9QBgR4CO7JeWk2qq6fqCcQ8Tlv6hAbg0b3Fasmt0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=vCwpma3JIbrl27GHSb4cgxBnxXzWGcgbBXnp4Re99GnN6+gSCkCCNgm+qthDWFflp
	 t3h8uJC555VPrSBsf9bU9rcyJW9lQ6a18h/PrtHcoaxMQV88d3WTx9uBcJbUvXrzp2
	 3fzVrmlTCIk59kd92DXAjgqARsCPUPgh3ySCYIJsn+b2UoYVseHA8eRNDEhKvn83H2
	 alhAhdh3pCJSrzzHAedbpwZEaPrUJytt0YE2TbCD9sWqyoJ3f38lPhVzRkUMLSf+5j
	 93JFlIa2c52vKFZsgthtBvkvfKFD3tzFz4ZXUVOfB6B6CRs4paTm8SXfN9Ex0expN6
	 KYdf2gX4yTLNQ==
From: Mark Brown <broonie@kernel.org>
Date: Wed, 20 Aug 2025 15:14:44 +0100
Subject: [PATCH v15 4/6] KVM: arm64: Set PSTATE.EXLOCK when entering an
 exception
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250820-arm64-gcs-v15-4-5e334da18b84@kernel.org>
References: <20250820-arm64-gcs-v15-0-5e334da18b84@kernel.org>
In-Reply-To: <20250820-arm64-gcs-v15-0-5e334da18b84@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, 
 Oliver Upton <oliver.upton@linux.dev>, Joey Gouly <joey.gouly@arm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, Shuah Khan <shuah@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, 
 kvmarm@lists.linux.dev, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-cff91
X-Developer-Signature: v=1; a=openpgp-sha256; l=2724; i=broonie@kernel.org;
 h=from:subject:message-id; bh=XqW9QBgR4CO7JeWk2qq6fqCcQ8Tlv6hAbg0b3Fasmt0=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBopdhxAZ4L+7YVt+YSme0YvQpLtyjywwn/lGMy4
 cGWlmL3oQeJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaKXYcQAKCRAk1otyXVSH
 0Du4B/0RDICVNAmNTsMAD3fmXlzD8V7yZ3k1cuhEFKlFN3oWsTwuBbYnsPFpMWpfvytpIh5+PDJ
 kjY3j1Q5tPoC85EtQyaC3sRJV0vN8adm+jbTs7czxbRfjZjHjMq28vnTMznqQ+/MbnJIktcjIVN
 i6ZxKpdt9HiX1JpDq2q4QWFcEueIZFZY06vYCaKn5BbXafIwHPczDloB0+Pv8pIPr8ZUCvNKYGj
 qvhgeZpFb17ejFruJ03OF1jH2rxGGhWKi4nR+/y3I+nWsJRBYqW0IY3VXUheN1C0xiIjLHBuQLf
 9XmyV3waTjLQddrme1VsAnKUz5p/FiEqcBD8hMTxtEIVJmin
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

As per DDI 0487 RWTXBY we need to manage PSTATE.EXLOCK when entering an
exception, when the exception is entered from a lower EL the bit is cleared
while if entering from the same EL it is set to GCSCR_ELx.EXLOCKEN.
Implement this behaviour in enter_exception64().

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/include/uapi/asm/ptrace.h |  1 +
 arch/arm64/kvm/hyp/exception.c       | 37 ++++++++++++++++++++++++++++++++++++
 2 files changed, 38 insertions(+)

diff --git a/arch/arm64/include/uapi/asm/ptrace.h b/arch/arm64/include/uapi/asm/ptrace.h
index 0f39ba4f3efd..f2fb029fb61a 100644
--- a/arch/arm64/include/uapi/asm/ptrace.h
+++ b/arch/arm64/include/uapi/asm/ptrace.h
@@ -56,6 +56,7 @@
 #define PSR_C_BIT	0x20000000
 #define PSR_Z_BIT	0x40000000
 #define PSR_N_BIT	0x80000000
+#define PSR_EXLOCK_BIT 0x400000000
 
 #define PSR_BTYPE_SHIFT		10
 
diff --git a/arch/arm64/kvm/hyp/exception.c b/arch/arm64/kvm/hyp/exception.c
index 95d186e0bf54..46e1d0c3038c 100644
--- a/arch/arm64/kvm/hyp/exception.c
+++ b/arch/arm64/kvm/hyp/exception.c
@@ -73,6 +73,38 @@ static void __vcpu_write_spsr_und(struct kvm_vcpu *vcpu, u64 val)
 		vcpu->arch.ctxt.spsr_und = val;
 }
 
+static unsigned long enter_exception64_gcs(struct kvm_vcpu *vcpu,
+					   unsigned long mode,
+					   unsigned long target_mode)
+{
+	u64 gcscr;
+
+	if (!kvm_has_gcs(kern_hyp_va(vcpu->kvm)))
+		return 0;
+
+	/* GCS can't be enabled for 32 bit */
+	if (mode & PSR_MODE32_BIT)
+		return 0;
+
+	/* When taking an exception to a higher EL EXLOCK is cleared. */
+	if ((mode | PSR_MODE_THREAD_BIT) != target_mode)
+		return 0;
+
+	/*
+	 * When taking an exception to the same EL EXLOCK is set to
+	 * the effective value of GCSR_ELx.EXLOCKEN.
+	 */
+	if (vcpu_is_el2(vcpu))
+		gcscr = __vcpu_read_sys_reg(vcpu, GCSCR_EL2);
+	else
+		gcscr = __vcpu_read_sys_reg(vcpu, GCSCR_EL1);
+
+	if (gcscr & GCSCR_ELx_EXLOCKEN)
+		return PSR_EXLOCK_BIT;
+
+	return 0;
+}
+
 /*
  * This performs the exception entry at a given EL (@target_mode), stashing PC
  * and PSTATE into ELR and SPSR respectively, and compute the new PC/PSTATE.
@@ -162,6 +194,11 @@ static void enter_exception64(struct kvm_vcpu *vcpu, unsigned long target_mode,
 	// PSTATE.BTYPE is set to zero upon any exception to AArch64
 	// See ARM DDI 0487E.a, pages D1-2293 to D1-2294.
 
+	// PSTATE.EXLOCK is set to 0 upon any exception to a higher
+	// EL, or to GCSCR_ELx.EXLOCKEN for an exception to the same
+	// exception level.  See ARM DDI 0487 RWTXBY, D.1.3.2 in K.a.
+	new |= enter_exception64_gcs(vcpu, mode, target_mode);
+
 	new |= PSR_D_BIT;
 	new |= PSR_A_BIT;
 	new |= PSR_I_BIT;

-- 
2.39.5


