Return-Path: <linux-kselftest+bounces-39640-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79D3AB30B53
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Aug 2025 04:03:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50BEBAE1C00
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Aug 2025 02:00:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41C2B28FA9A;
	Fri, 22 Aug 2025 01:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S2+QZuHp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 135E528E571;
	Fri, 22 Aug 2025 01:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755827744; cv=none; b=Dia/iWaK1BK7kwrYfsVAHF1NWCwz1K9BdAHqVDD9jTWbct6cn7TGUFnMADYnTdWtnzsIhLv0c2Z/63FRe13Ah62EGnOcKUSedgW35wdWILq8StPmWa+F5G5osd/l9c1cOcHNMd2Xgak0ec1GspT9Gv8Y9mSoULUE/YQFtD1nfSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755827744; c=relaxed/simple;
	bh=eko0M/1IoNzmkVmBa1f5aR4hGKuIltnrGwhCOTIwAnI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SsWiotIeD51YYNeN8Ko57wysV8syh2ZvhP+FCgDqea+NTCidBsm0zREjD2pvmqfb4SnMbPLga2GJ8OY8grynsl+eO82ZOphSYFoUP9kX1Sech4K6yiTm7uNa2UoVZ28A4QTZrqFwctxXnGVw9yFhls1WlWYGT7s1oqMFlHwu+2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S2+QZuHp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C82BC113D0;
	Fri, 22 Aug 2025 01:55:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755827742;
	bh=eko0M/1IoNzmkVmBa1f5aR4hGKuIltnrGwhCOTIwAnI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=S2+QZuHpH6eDMNPX0FRylkbgWM9BVxPu0FszJe82QsLIqdG4OpnJKpN74QrkOt6e2
	 A61hNPAoEClh879pkGje4WXMFKztvuFAu+qzOfj50Av9Q+7SHTwGmm/t1JyuhOE3F1
	 TUP6uLPEpjqQWFBzWtRVWPe/wdYzDudikj7pi7Zg8l15XWLjEkzGukcAwaS45gJAC2
	 /fygnpvEkGkTMJDIx0HmbG56C9f2kyan6G5nro4wEKANozOV7/woRJQ79iHWhD9KS9
	 li5pFbkMW66PXHhPR/kl01TwgEmJfhlxqVnFdI8NsRsuQS08o4qRhWE0gxFpsAUfH6
	 LqS8hJO+FKh8A==
From: Mark Brown <broonie@kernel.org>
Date: Fri, 22 Aug 2025 02:53:49 +0100
Subject: [PATCH v7 20/29] KVM: arm64: Provide assembly for SME register
 access
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250822-kvm-arm64-sme-v7-20-7a65d82b8b10@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1851; i=broonie@kernel.org;
 h=from:subject:message-id; bh=eko0M/1IoNzmkVmBa1f5aR4hGKuIltnrGwhCOTIwAnI=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBop83I+IndHAqLMki3155WeFFGLW5uEdsLLqc8X
 Ls4dDo7JIiJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaKfNyAAKCRAk1otyXVSH
 0Fr5B/95xLO97ePuVChS1XQAhqSMl+jf/Cdb+OuygtjCY9ba7d8h39WXZZJbUb4pXLSlqVm5uJw
 0WkQ4a/IbbKwJaI4NnVtO3pBZtJvGnqn8lGAEGgXoBO7MOH7Z30uzt8mOMBjXQLPTXkZ5OiIEh9
 A+j7eugheVEU2xth82Lgvr5lCX0v17pHomg68+D/YnGx0VL120/Wg0K3D3+i/x1CxZi7pMpPFqr
 mONxfpY2l5V1rKP4S2tD7WIAdOuh426oG5YfR7d6H7ux/+1ej1Ept7b658CWwxtLa7BDiqgj+xW
 I8X51+VFH0i52BYefy3WzyFKdlHLXwBCIS9nmmvw593Q5hpj
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

Provide versions of the SME state save and restore functions for the
hypervisor to allow it to restore ZA and ZT for guests.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/include/asm/kvm_hyp.h |  3 +++
 arch/arm64/kvm/hyp/fpsimd.S      | 26 ++++++++++++++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/arch/arm64/include/asm/kvm_hyp.h b/arch/arm64/include/asm/kvm_hyp.h
index 0ad5a66e0d25..1c31d8b26aa9 100644
--- a/arch/arm64/include/asm/kvm_hyp.h
+++ b/arch/arm64/include/asm/kvm_hyp.h
@@ -115,6 +115,9 @@ void __fpsimd_save_state(struct user_fpsimd_state *fp_regs);
 void __fpsimd_restore_state(struct user_fpsimd_state *fp_regs);
 void __sve_save_state(void *sve_pffr, u32 *fpsr, int save_ffr);
 void __sve_restore_state(void *sve_pffr, u32 *fpsr, int restore_ffr);
+int __sve_get_vl(void);
+void __sme_save_state(void const *state, bool restore_zt);
+void __sme_restore_state(void const *state, bool restore_zt);
 
 u64 __guest_enter(struct kvm_vcpu *vcpu);
 
diff --git a/arch/arm64/kvm/hyp/fpsimd.S b/arch/arm64/kvm/hyp/fpsimd.S
index 6e16cbfc5df2..44a1b0a483da 100644
--- a/arch/arm64/kvm/hyp/fpsimd.S
+++ b/arch/arm64/kvm/hyp/fpsimd.S
@@ -29,3 +29,29 @@ SYM_FUNC_START(__sve_save_state)
 	sve_save 0, x1, x2, 3
 	ret
 SYM_FUNC_END(__sve_save_state)
+
+SYM_FUNC_START(__sve_get_vl)
+	_sve_rdvl	0, 1
+	ret
+SYM_FUNC_END(__sve_get_vl)
+
+SYM_FUNC_START(__sme_save_state)
+	_sme_rdsvl	2, 1		// x2 = VL/8
+	sme_save_za 0, x2, 12		// Leaves x0 pointing to the end of ZA
+
+	cbz	x1, 1f
+	_str_zt 0
+1:
+	ret
+SYM_FUNC_END(__sme_save_state)
+
+SYM_FUNC_START(__sme_restore_state)
+	_sme_rdsvl	2, 1		// x2 = VL/8
+	sme_load_za	0, x2, 12	// Leaves x0 pointing to end of ZA
+
+	cbz	x1, 1f
+	_ldr_zt 0
+
+1:
+	ret
+SYM_FUNC_END(__sme_restore_state)

-- 
2.39.5


