Return-Path: <linux-kselftest+bounces-30998-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64359A9104E
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Apr 2025 02:26:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6440D1895E3D
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Apr 2025 00:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73F3C1922FB;
	Thu, 17 Apr 2025 00:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dzwy2xTc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EF2C1547C9;
	Thu, 17 Apr 2025 00:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744849553; cv=none; b=LBKC3zx1Fn4dtVwFBIPTPQL46w9E6I8AI4xuvkvcG5WgEDQIe9RQZpkRYBrs6sAq+gVZhVH0Q0syvmJAx/qgM/ScHOHy5pZqDS3MiJHKEdsQ2AF7+Ypz+JUCIE6/ni8FQex/dZWySvt7CsejkLOhMyFQr2AH7S/dvM0qv/8ME8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744849553; c=relaxed/simple;
	bh=oRt3lYFMkjnSjiKx9sDZB+3QRpB709eowurjKxguJTA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TTrMo9xz/5xTwrsOl/crXGM+1MmJjUW+eSfx+lpuQTvBAER1cz7lB/u5O9wQ89C7sKm02WP3qStqbFjTIPCf1jVJKB4ihBtoMTKiBrbBL1qHcQzmMzrMqhLy1gTvebVSvPhgkekAK1t8Um7j5sbt8UJiRByjfB5R0Cij9XXRjLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dzwy2xTc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BD04C4CEE2;
	Thu, 17 Apr 2025 00:25:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744849552;
	bh=oRt3lYFMkjnSjiKx9sDZB+3QRpB709eowurjKxguJTA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Dzwy2xTcrjU/683hGez8zlDaDWQQ1RO+JDjpuMEFEQbpg6LgYMI6sKAm6Ocx8f1yC
	 i4t6zsBw4Co3avfBQygF3vWV3XABMgUUutilSyYAeNJPztsktNfzC23AZANlvJRqHG
	 lQr7k9v+oXrpMCYQT4NvncCRxlIJXimVyx4gUIWFxppNOUFrYb/kfTWl2zYno3jpv0
	 TkEkap7elGLzy/kguXUovRM07gZMmOPDayJ1Jy0TB82qFhDoaht51iF+xjR2ifAXK8
	 XXVj6dKupL17ahRoCccM1I+QXKzRyeueFNmK08JE4Jt58wYJnOFS7+qRdqdY9Pxpvx
	 c7tLbi0lH0tsA==
From: Mark Brown <broonie@kernel.org>
Date: Thu, 17 Apr 2025 01:25:06 +0100
Subject: [PATCH v5 02/28] arm64/fpsimd: Decide to save ZT0 and streaming
 mode FFR at bind time
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250417-kvm-arm64-sme-v5-2-f469a2d5f574@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3233; i=broonie@kernel.org;
 h=from:subject:message-id; bh=oRt3lYFMkjnSjiKx9sDZB+3QRpB709eowurjKxguJTA=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBoAEpwozZXsAd5qJB21CA4CiCtC30WEvhJ7v0tYfEB
 LUVgom+JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaABKcAAKCRAk1otyXVSH0D68B/
 9M69whFUWMXybJGWIhTbqH8+ujooutUhhbaK2hydw7hO46/aGqeqndM6p8RFHY1GvSsSF5wa0rjgkG
 CCZ9kYwIAksf54WacwaQ0QwTo7qDzLn3s7laitE06tg22cIY6B3HTWNbmXyr/b9DvKk0USDwzs8qbT
 oFLJUNDxoZYM/nLAzQvk/wbcDctkuiLuoZ22W6v5oLrneyLfqrJb3t0eyZSuj/aZlbPfr6n/fxWbFC
 8uHMEaK+rwzJu139FcqQCNF6JqDjK3B1QSQ/rdX87LZwEPo+S6wEu39p8cPDlvtuQnGaArHPK4zoHB
 ywHb4TIGRl2XmDiNgrtPN3fSrniwif
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
index 8279565826ad..573bd6a219f2 100644
--- a/arch/arm64/include/asm/fpsimd.h
+++ b/arch/arm64/include/asm/fpsimd.h
@@ -86,6 +86,7 @@ struct cpu_fp_state {
 	void *sme_state;
 	u64 *svcr;
 	u64 *fpmr;
+	u64 sme_features;
 	unsigned int sve_vl;
 	unsigned int sme_vl;
 	enum fp_type *fp_type;
diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index d3a901afff72..266ce7a9f195 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -474,12 +474,12 @@ static void fpsimd_save_user_state(void)
 
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
@@ -1660,6 +1660,12 @@ static void fpsimd_bind_task_to_cpu(void)
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
index 7f6e43d25691..7fc14b7349a0 100644
--- a/arch/arm64/kvm/fpsimd.c
+++ b/arch/arm64/kvm/fpsimd.c
@@ -106,6 +106,7 @@ void kvm_arch_vcpu_ctxsync_fp(struct kvm_vcpu *vcpu)
 		fp_state.svcr = &__vcpu_sys_reg(vcpu, SVCR);
 		fp_state.fpmr = &__vcpu_sys_reg(vcpu, FPMR);
 		fp_state.fp_type = &vcpu->arch.fp_type;
+		fp_state.sme_features = 0;
 
 		if (vcpu_has_sve(vcpu))
 			fp_state.to_save = FP_STATE_SVE;

-- 
2.39.5


