Return-Path: <linux-kselftest+bounces-39623-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A850B30B12
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Aug 2025 03:57:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F34801BA2FE7
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Aug 2025 01:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6CB91F237A;
	Fri, 22 Aug 2025 01:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KhdNZOK3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 740B21F130B;
	Fri, 22 Aug 2025 01:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755827679; cv=none; b=CcKZQP7bpIcIZUkH0setYW84UDoDBtkz/Eg4A4Gik7MxVkKnkc5MIWtuNDv8klT0SV78atYDHFqCrK3LaO8EzyXVLSkeF+HEBM+RxRj98MrKcQ3AmsB1GzL2vj8bUBfdBIVEpjZpCiJ1CZHVRiSLkHSCyN1p2xSA7QuHjHNJ7N8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755827679; c=relaxed/simple;
	bh=tDa3Sk8XxTm+Aaxc1UJdjATH+x+7vPOsHdbcIxBkYo8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mijFuU4uqF0hu7Yx9s3R5uRYjZj969dJ7nydd0WTca8r+KhHGGlEhZpw5SoaBxcMGXA3wUiUY6RwZcohiCI0tZAvH6q2VBoJSsWtxjvax7hjNlRb6A1IOzlU+dWQTC7+NDVk0CR1NzcpVOVXFwE/57mThhzd8WkNaFjPRqa8SJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KhdNZOK3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B01EEC4CEEB;
	Fri, 22 Aug 2025 01:54:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755827679;
	bh=tDa3Sk8XxTm+Aaxc1UJdjATH+x+7vPOsHdbcIxBkYo8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=KhdNZOK3Uhz33z8IDngblDep6ZUpFArS9oStZOm7E3tYAoLl6aeTGPam+B445S3hy
	 tPoKtFiXSpLr7Fb2p52alFhxzAv7EcWiKevWFZwrffoLyG2Kbxqiiko6Ora9dYqzx4
	 bOxpsds/IMZMxt9Py5FTPW3+kEfs8/33md1HVc9o2EvmCxj9zIU6EJMfPNARjnBoA3
	 prJhWKPr5xMy+yFgXqMBhbRvaBgmxOMJ5kNa/wc06nJDTCas4enoOHZbt8JTujeIZ+
	 DsyXmmetMvLVFdhAvcUKF5z9b/7tmzzLmODxQ8K4jgoK2mJYIv8ag2TngKXfBMyKRF
	 n1Hno2J20WMZA==
From: Mark Brown <broonie@kernel.org>
Date: Fri, 22 Aug 2025 02:53:32 +0100
Subject: [PATCH v7 03/29] arm64/fpsimd: Decide to save ZT0 and streaming
 mode FFR at bind time
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250822-kvm-arm64-sme-v7-3-7a65d82b8b10@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3253; i=broonie@kernel.org;
 h=from:subject:message-id; bh=tDa3Sk8XxTm+Aaxc1UJdjATH+x+7vPOsHdbcIxBkYo8=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBop826uYzP1snjmHZRz+3YLBp0E5d8f9TMSaQAg
 8u5eVFkI4mJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaKfNugAKCRAk1otyXVSH
 0FVwB/979F6kMUmZv//EVqk7RDD4dIMflrPiqEZyizKmQcURwPvXz+p/vJbnczOOyz+eojs7LsM
 pTJQpMklqRd14HHq5gIB9ZpyOEbPIxcCPv4f+y53ANuYnATetiGTRb26QMOx8hKHUAF3xx6+TV3
 LwLv0dYliTKf8sXL2TbC0/75573W2f0QSf1wvtGIeHaaZ+AOVgjRQetJHxlClGM0Wu2Hm3t1M1s
 jytSBHpOhBlTHFOjshBrZGKyclmPQ8o2THGrAyraB6HsiLmQnuwqApWc19u7Eeanv0S5ttY/9Tg
 hIQ8PTRA8KyKjl9dvEZDGe2+P550azR+yEMoNf5XPDucnYRf
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

Some parts of the SME state are optional, enabled by additional features
on top of the base FEAT_SME and controlled with enable bits in SMCR_ELx. We
unconditionally enable these for the host but for KVM we will allow the
feature set exposed to guests to be restricted by the VMM. These are the
FFR register (FEAT_SME_FA64) and ZT0 (FEAT_SME2).

We defer saving of guest floating point state for non-protected guests to
the host kernel. We also want to avoid having to reconfigure the guest
floating point state if nothing used the floating point state while running
the host. If the guest was running with the optional features disabled then
traps will be enabled for them so the host kernel will need to skip
accessing that state when saving state for the guest.

Support this by moving the decision about saving this state to the point
where we bind floating point state to the CPU, adding a new variable to
the cpu_fp_state which uses the enable bits in SMCR_ELx to flag which
features are enabled.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/include/asm/fpsimd.h |  1 +
 arch/arm64/kernel/fpsimd.c      | 10 ++++++++--
 arch/arm64/kvm/fpsimd.c         |  1 +
 3 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/fpsimd.h b/arch/arm64/include/asm/fpsimd.h
index b4359f942621..0ecdd7dcf623 100644
--- a/arch/arm64/include/asm/fpsimd.h
+++ b/arch/arm64/include/asm/fpsimd.h
@@ -87,6 +87,7 @@ struct cpu_fp_state {
 	void *sme_state;
 	u64 *svcr;
 	u64 *fpmr;
+	u64 sme_features;
 	unsigned int sve_vl;
 	unsigned int sme_vl;
 	enum fp_type *fp_type;
diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index 653c0dec6b18..77f9dfaffe8b 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -477,12 +477,12 @@ static void fpsimd_save_user_state(void)
 
 		if (*svcr & SVCR_ZA_MASK)
 			sme_save_state(last->sme_state,
-				       system_supports_sme2());
+				       last->sme_features & SMCR_ELx_EZT0);
 
 		/* If we are in streaming mode override regular SVE. */
 		if (*svcr & SVCR_SM_MASK) {
 			save_sve_regs = true;
-			save_ffr = system_supports_fa64();
+			save_ffr = last->sme_features & SMCR_ELx_FA64;
 			vl = last->sme_vl;
 		}
 	}
@@ -1655,6 +1655,12 @@ static void fpsimd_bind_task_to_cpu(void)
 	last->to_save = FP_STATE_CURRENT;
 	current->thread.fpsimd_cpu = smp_processor_id();
 
+	last->sme_features = 0;
+	if (system_supports_fa64())
+		last->sme_features |= SMCR_ELx_FA64;
+	if (system_supports_sme2())
+		last->sme_features |= SMCR_ELx_EZT0;
+
 	/*
 	 * Toggle SVE and SME trapping for userspace if needed, these
 	 * are serialsied by ret_to_user().
diff --git a/arch/arm64/kvm/fpsimd.c b/arch/arm64/kvm/fpsimd.c
index 15e17aca1dec..9158353d8be3 100644
--- a/arch/arm64/kvm/fpsimd.c
+++ b/arch/arm64/kvm/fpsimd.c
@@ -80,6 +80,7 @@ void kvm_arch_vcpu_ctxsync_fp(struct kvm_vcpu *vcpu)
 		fp_state.svcr = __ctxt_sys_reg(&vcpu->arch.ctxt, SVCR);
 		fp_state.fpmr = __ctxt_sys_reg(&vcpu->arch.ctxt, FPMR);
 		fp_state.fp_type = &vcpu->arch.fp_type;
+		fp_state.sme_features = 0;
 
 		if (vcpu_has_sve(vcpu))
 			fp_state.to_save = FP_STATE_SVE;

-- 
2.39.5


