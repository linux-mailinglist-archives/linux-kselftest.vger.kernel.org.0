Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7768849A537
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jan 2022 03:11:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S3409286AbiAYAZY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 24 Jan 2022 19:25:24 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:57656 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2374461AbiAYARG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 24 Jan 2022 19:17:06 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 017E9B815F6
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Jan 2022 00:17:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45408C340EC;
        Tue, 25 Jan 2022 00:17:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643069823;
        bh=jEyud6x1YGBVsWHdD8Q9gNLZk7/BvtyPAjeOVpneBR8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kcnj+BmYM65iPXzGwlN/VrLom7FjHs4OrrtYdj5pR1n3ilONDgyhFM+3h9THoxoKk
         Eg7rkd7sKf4qLMuMUSrcgfsHnmfbW2ctmOc5HsPg61tLfE8loCMQd4EJ8YznNpTCY5
         dcG9nAtDQS2yL1aZjOPrKlZydRxFUPW3gBV1kNqc7P5hapC6KyZP56QL1f4WpONImv
         Q+nAiyu27hh6WaOphdBvIUpv+03O4qG7PT//lTmtq09R70Ugf7B0AOj/cfT7UPJY4l
         ZIGSWL+s/FMgSpbloYzgu5SRzx42jdPqog2UoaMeIQTcQCqV25lzmEbF49lVIeA2oN
         aFKV43OIHZPnA==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     Alan Hayward <alan.hayward@arm.com>,
        Luis Machado <luis.machado@arm.com>,
        Salil Akerkar <Salil.Akerkar@arm.com>,
        Basant Kumar Dwivedi <Basant.KumarDwivedi@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, kvmarm@lists.cs.columbia.edu,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH v8 26/38] KVM: arm64: Handle SME host state when running guests
Date:   Tue, 25 Jan 2022 00:11:02 +0000
Message-Id: <20220125001114.193425-27-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220125001114.193425-1-broonie@kernel.org>
References: <20220125001114.193425-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4080; h=from:subject; bh=jEyud6x1YGBVsWHdD8Q9gNLZk7/BvtyPAjeOVpneBR8=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBh70AVfJFkLKCJZq4Gps4zY52BZXzbcGLbOMe99Cdt hhGcKniJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYe9AFQAKCRAk1otyXVSH0A/xCA CATFjfgXFx1KMbxT17jJxu6hD+nTFWbNVU1fAPs1lIf1DMNpbuBjma8zuAVP27QJLxLjDSZQ8daLJr X8aOoHk4F3PG0EA500D+1zq6RR2FaYvZL+GYwkUaYdL1tQL348kS4jrIa36msmzI5ZTVVexBS3HHz+ ke7W4Dau0cS5/JWsmphqFGpyrNG7uLvlrsJfdFY2zuen6CtYRBzav/h9b3pPH7UGTBJ67rnwbiUDKi EYrITgzPOR2kmpi8McANLKrLQqEXYVthFcZUo4Khr4cvbhD0+jaic2yqQue5aMt9+ArGWmKOmNxA1J KfC0LG+tLwSGhzAfPda27f4DDOWZu2
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

While we don't currently support SME in guests we do currently support it
for the host system so we need to take care of SME's impact, including
the floating point register state, when running guests. Simiarly to SVE
we need to manage the traps in CPACR_RL1, what is new is the handling of
streaming mode and ZA.

Normally we defer any handling of the floating point register state until
the guest first uses it however if the system is in streaming mode FPSIMD
and SVE operations may generate SME traps which we would need to distinguish
from actual attempts by the guest to use SME. Rather than do this for the
time being if we are in streaming mode when entering the guest we force
the floating point state to be saved immediately and exit streaming mode,
meaning that the guest won't generate SME traps for supported operations.

We could handle ZA in the access trap similarly to the FPSIMD/SVE state
without the disruption caused by streaming mode but for simplicity
handle it the same way as streaming mode for now.

This will be revisited when we support SME for guests (hopefully before SME
hardware becomes available), for now it will only incur additional cost on
systems with SME and even there only if streaming mode or ZA are enabled.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/include/asm/kvm_host.h |  1 +
 arch/arm64/kvm/fpsimd.c           | 38 +++++++++++++++++++++++++++++++
 2 files changed, 39 insertions(+)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 7dc85d5a6552..404b7358ba96 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -438,6 +438,7 @@ struct kvm_vcpu_arch {
 #define KVM_ARM64_DEBUG_STATE_SAVE_SPE	(1 << 12) /* Save SPE context if active  */
 #define KVM_ARM64_DEBUG_STATE_SAVE_TRBE	(1 << 13) /* Save TRBE context if active  */
 #define KVM_ARM64_FP_FOREIGN_FPSTATE	(1 << 14)
+#define KVM_ARM64_HOST_SME_ENABLED	(1 << 15) /* SME enabled for EL0 */
 
 #define KVM_GUESTDBG_VALID_MASK (KVM_GUESTDBG_ENABLE | \
 				 KVM_GUESTDBG_USE_SW_BP | \
diff --git a/arch/arm64/kvm/fpsimd.c b/arch/arm64/kvm/fpsimd.c
index 338733ac63f8..cecaddb644ce 100644
--- a/arch/arm64/kvm/fpsimd.c
+++ b/arch/arm64/kvm/fpsimd.c
@@ -82,6 +82,26 @@ void kvm_arch_vcpu_load_fp(struct kvm_vcpu *vcpu)
 
 	if (read_sysreg(cpacr_el1) & CPACR_EL1_ZEN_EL0EN)
 		vcpu->arch.flags |= KVM_ARM64_HOST_SVE_ENABLED;
+
+	/*
+	 * We don't currently support SME guests but if we leave
+	 * things in streaming mode then when the guest starts running
+	 * FPSIMD or SVE code it may generate SME traps so as a
+	 * special case if we are in streaming mode we force the host
+	 * state to be saved now and exit streaming mode so that we
+	 * don't have to handle any SME traps for valid guest
+	 * operations. Do this for ZA as well for now for simplicity.
+	 */
+	if (system_supports_sme()) {
+		if (read_sysreg(cpacr_el1) & CPACR_EL1_SMEN_EL0EN)
+			vcpu->arch.flags |= KVM_ARM64_HOST_SME_ENABLED;
+
+		if (read_sysreg_s(SYS_SVCR_EL0) &
+		    (SYS_SVCR_EL0_SM_MASK | SYS_SVCR_EL0_ZA_MASK)) {
+			vcpu->arch.flags &= ~KVM_ARM64_FP_HOST;
+			fpsimd_save_and_flush_cpu_state();
+		}
+	}
 }
 
 void kvm_arch_vcpu_ctxflush_fp(struct kvm_vcpu *vcpu)
@@ -129,6 +149,24 @@ void kvm_arch_vcpu_put_fp(struct kvm_vcpu *vcpu)
 
 	local_irq_save(flags);
 
+	/*
+	 * If we have VHE then the Hyp code will reset CPACR_EL1 to
+	 * CPACR_EL1_DEFAULT and we need to reenable SME.
+	 */
+	if (has_vhe()) {
+		if (system_supports_sme()) {
+			/* Also restore EL0 state seen on entry */
+			if (vcpu->arch.flags & KVM_ARM64_HOST_SME_ENABLED)
+				sysreg_clear_set(CPACR_EL1, 0,
+						 CPACR_EL1_SMEN_EL0EN |
+						 CPACR_EL1_SMEN_EL1EN);
+			else
+				sysreg_clear_set(CPACR_EL1,
+						 CPACR_EL1_SMEN_EL0EN,
+						 CPACR_EL1_SMEN_EL1EN);
+		}
+	}
+
 	if (vcpu->arch.flags & KVM_ARM64_FP_ENABLED) {
 		if (vcpu_has_sve(vcpu)) {
 			__vcpu_sys_reg(vcpu, ZCR_EL1) = read_sysreg_el1(SYS_ZCR);
-- 
2.30.2

