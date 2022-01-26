Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A33D49CE6D
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Jan 2022 16:32:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235886AbiAZPcI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 26 Jan 2022 10:32:08 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:51178 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235837AbiAZPcI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 26 Jan 2022 10:32:08 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E24A6618D3
        for <linux-kselftest@vger.kernel.org>; Wed, 26 Jan 2022 15:32:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6996C340E8;
        Wed, 26 Jan 2022 15:32:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643211127;
        bh=3CVajAIAdTOdfvfZ82kEgNvR06jRolq6At9bUSWFRwk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HYtxSr2l1VySFCh07eWDeLBj2yxZ4kBnGsdxMNADixYjxmzjesmOq17tVKc5yPXFa
         vvMpcr6leOdBY8Xja0XHWQs0FLF2wJes8xVzQPqb2qMb07axw3RpXBHpn0plcuswkO
         o7F+Yl8TGpBktv7C3kR4cL+8yYc6MCtQtJxM8Z2o1WSm6Bg7FyjcAUtq/bm7Gr6ZgW
         85ZVesYc7ySmzqXAAX+GH+Htav3e5IKsFWTItXQNYsdDRdDrnHvj7xsmbPqAy90vGs
         HBB6XENkHkjcIT4kkExM7RN+ZouUILLKp4dJYOBs1eIwPBe/2n9cnk+u/orhaHFRGr
         OCIYOWpRwWV0g==
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
Subject: [PATCH v10 27/39] KVM: arm64: Handle SME host state when running guests
Date:   Wed, 26 Jan 2022 15:27:37 +0000
Message-Id: <20220126152749.233712-28-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220126152749.233712-1-broonie@kernel.org>
References: <20220126152749.233712-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4057; h=from:subject; bh=3CVajAIAdTOdfvfZ82kEgNvR06jRolq6At9bUSWFRwk=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBh8WhqipvlQdnfuu2rF6eRpP9SEhn4zU4bLewdFWFr /0NnPgmJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYfFoagAKCRAk1otyXVSH0HjNB/ 4g7bii79dbMvR/LMZMbqpC9Pgq1Dd6cShJLBnzF/WuSCIQMu0eIjIrsuMlgHL7S+d+rQIdSmd1LvCy lWTIijY5eWCrQRzGpsqHAlHh8DfRIKuua+1JMjiyCL7VJE/c+BgveD8JgmM8ZgwA7ZlRi2iSQRYhQi v/mUv4ckLbw+6wJ/lAIN8g9Zan6H4KnKQJzmrOWeWHBdhzGZs5Cnf8nGvRsdhdKqWKW4Cg+w9+AECb AuCsTS83OJs6olyu2ddGcCMDjKS/OAV4auxhSTLiSYhs9adKu6+33t7youu2HVB7HMY9gEliebdyn9 vXFfmgsfmy2oVqyRa5+O3EK3fAx1JG
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
 arch/arm64/kvm/fpsimd.c           | 36 +++++++++++++++++++++++++++++++
 2 files changed, 37 insertions(+)

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
index 338733ac63f8..1c585553d74f 100644
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
@@ -129,6 +149,22 @@ void kvm_arch_vcpu_put_fp(struct kvm_vcpu *vcpu)
 
 	local_irq_save(flags);
 
+	/*
+	 * If we have VHE then the Hyp code will reset CPACR_EL1 to
+	 * CPACR_EL1_DEFAULT and we need to reenable SME.
+	 */
+	if (has_vhe() && system_supports_sme()) {
+		/* Also restore EL0 state seen on entry */
+		if (vcpu->arch.flags & KVM_ARM64_HOST_SME_ENABLED)
+			sysreg_clear_set(CPACR_EL1, 0,
+					 CPACR_EL1_SMEN_EL0EN |
+					 CPACR_EL1_SMEN_EL1EN);
+		else
+			sysreg_clear_set(CPACR_EL1,
+					 CPACR_EL1_SMEN_EL0EN,
+					 CPACR_EL1_SMEN_EL1EN);
+	}
+
 	if (vcpu->arch.flags & KVM_ARM64_FP_ENABLED) {
 		if (vcpu_has_sve(vcpu)) {
 			__vcpu_sys_reg(vcpu, ZCR_EL1) = read_sysreg_el1(SYS_ZCR);
-- 
2.30.2

