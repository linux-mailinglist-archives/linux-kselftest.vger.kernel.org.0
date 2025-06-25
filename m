Return-Path: <linux-kselftest+bounces-35745-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 39553AE80EA
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Jun 2025 13:25:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C7E917AC22
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Jun 2025 11:25:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3381F2D2391;
	Wed, 25 Jun 2025 11:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tcP4nQkt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F179F29B766;
	Wed, 25 Jun 2025 11:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750850695; cv=none; b=tdOdlbqbOgYCbcM4O8rLMpv/ZGo35bFwI0ovMCb2nV/LYRpzZasHVZ+wGmH/7mm/LIg9kNVRmt+KqWEfY14/LnDaB1jJTwg972w4MF5M1YYQ+34xqj4WdlTIj6GBahZAMiI+RV1zR7gr6V5vCUUWQBfNJUDdWlNeL2RtsVFAt+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750850695; c=relaxed/simple;
	bh=B0VonHlqByVdmurtHkhG4MnlHQ5yxXV7ORMnK+9rLK0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Oq6Ed0Ia+VCDz08hAssnF0bA4xc9ciQPgA7l+LFrRCM+gzLyMja8j5EQ+D2F37waCKf1gUCJoFQYRsdaLbwWapIImoMA5L2eNcD/N2YdarPWOttfakhQhpJMF7UAqnsza1e4YY2evYmlQlceeu4AIX+znji883xJ5+dN/FXjCbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tcP4nQkt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29CBCC4CEEE;
	Wed, 25 Jun 2025 11:24:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750850694;
	bh=B0VonHlqByVdmurtHkhG4MnlHQ5yxXV7ORMnK+9rLK0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=tcP4nQkt1jW4VVQTYgOIiafVl7LMLQDFvCfndmN0KLGdnnFh2BcOd5a65ok7EuW7y
	 UDJYP2QIft3q5iHeRayvcZo7U9ccWIMKAzjAXnVvdIoFM6jR/OOD9hJjvv5FMwXK1B
	 V+AIp3D4fxUJOTjUvH8w2Q8vy3x5JvBLjvnzby73B+v02rwIqqGrNQRl3jyM4pDjgw
	 yWskS2CjGDa2oenfLR6GecMy15s3Nl2unDirKCs3WCaYyj5bkaGxGKvuzvfi31xjcr
	 DCsdVf6DL0UCFocdqIkc5gIgrZADy03YK/O5+b9YOFlI3BVZIyqY3tK8i8XakXBwXX
	 RRZ3UopulUyzQ==
From: Mark Brown <broonie@kernel.org>
Date: Wed, 25 Jun 2025 11:47:53 +0100
Subject: [PATCH v6 02/28] arm64/fpsimd: Decide to save ZT0 and streaming
 mode FFR at bind time
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250625-kvm-arm64-sme-v6-2-114cff4ffe04@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3255; i=broonie@kernel.org;
 h=from:subject:message-id; bh=B0VonHlqByVdmurtHkhG4MnlHQ5yxXV7ORMnK+9rLK0=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBoW9xmLyL4x6A5wiayNNSePhqlpLnfgU5ZAK5M6
 F0DxNTJLbyJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaFvcZgAKCRAk1otyXVSH
 0Bq5B/4h+Y3UGaZA74zyyQIkJW/K1zpyrW2n43gHVviKSXDw+qloe+P5Z1BsXpBZGFYcSCgDuIm
 pKoYt3nu3HJr6lWZOTJLypb35IBVajoic/6L3nGwCBv6PMU1QFkwp0UlF1QynRGvZfGO7Zt3UTR
 A07avQxXykGTGFa/6t4N/A2g48BiszUqL6WBF4b5MJ+U0ROgEiVDpMY7wg+rNuIGG8kyPMwzju8
 LRPEEgrHinYFCxuoVh6R4aMjA8b6Yf3eoIpNutRJP6lY/PCPdKyt5WwIs2gYtKfvbxyAxjKj4oV
 WRaKnGvQhdnp0TNNVgDXWcNP5aEndN4PhQMpCkb14An5gqvF
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
index 8f6c8f57c6b9..d67e2002d354 100644
--- a/arch/arm64/kvm/fpsimd.c
+++ b/arch/arm64/kvm/fpsimd.c
@@ -106,6 +106,7 @@ void kvm_arch_vcpu_ctxsync_fp(struct kvm_vcpu *vcpu)
 		fp_state.svcr = __ctxt_sys_reg(&vcpu->arch.ctxt, SVCR);
 		fp_state.fpmr = __ctxt_sys_reg(&vcpu->arch.ctxt, FPMR);
 		fp_state.fp_type = &vcpu->arch.fp_type;
+		fp_state.sme_features = 0;
 
 		if (vcpu_has_sve(vcpu))
 			fp_state.to_save = FP_STATE_SVE;

-- 
2.39.5


