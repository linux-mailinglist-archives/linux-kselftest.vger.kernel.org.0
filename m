Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C83974F94DE
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Apr 2022 13:57:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235345AbiDHL7S (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 8 Apr 2022 07:59:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235330AbiDHL7H (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 8 Apr 2022 07:59:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 663FA8A33D
        for <linux-kselftest@vger.kernel.org>; Fri,  8 Apr 2022 04:57:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F000F62050
        for <linux-kselftest@vger.kernel.org>; Fri,  8 Apr 2022 11:56:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9C21C385A8;
        Fri,  8 Apr 2022 11:56:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649419019;
        bh=/S7OrDRtCJk7Cj1NAWEnuqt+8teJf4RrTe+CbmCOR64=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=awayaFyr0lO/6MYW9beHs0+WhywS6sH4GVL88u9s7SRHDMr6OVTcjOEkd2h2dXVp9
         PyPVsK1p1ohRbuN/BeaeDz6HfPl4U1DOJrxmfaPVCi+UJa+PQn3XvCp4suKGZmLdo4
         Q5CSbgp7SGSWm55nPP18Jro2/eljZ7gL+qAv73QqMPEik12/PHqitLNF8hw3EwiY/X
         o6fUiGu/Ot2CugaJx9y7XRSk1ujmDUhrkDaR/l0apOGTBHd4/eTaxPvEYs5Ri4vEJb
         n2jB2XY4H4vtinYYH24kw3hhpYku8ldPB/QrW4e/G3KxYAaornGoBcTex32+mmIqh+
         cUJpKFyD4U7Yw==
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
        Luca Salabrino <luca.scalabrino@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, kvmarm@lists.cs.columbia.edu,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH v13 26/39] KVM: arm64: Handle SME host state when running guests
Date:   Fri,  8 Apr 2022 12:43:15 +0100
Message-Id: <20220408114328.1401034-27-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220408114328.1401034-1-broonie@kernel.org>
References: <20220408114328.1401034-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4067; h=from:subject; bh=/S7OrDRtCJk7Cj1NAWEnuqt+8teJf4RrTe+CbmCOR64=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBiUB/TeSh4ET7lu4HDbYeYp6mP0c5wB8aCWwZomguW qfrq0haJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYlAf0wAKCRAk1otyXVSH0PFiB/ 9tCwUx5rRQFiYgkoeKKPJ0GxdImYfsrxDAMHX4ZfGnZfMBHRK1INjwkOWqy1L3hTnLLx9hKADTnvOG yEImiFHip7vuCVp3h534Xm3yIJPzb61Nl003e1vNBzDIV65qReafGXuLsIpMhmNICrdkzM7/iKumpe +q7o6RxWjKwdyrFWhhaaJiuq5ak7a1jJYJyqPrayKh199ZJPhj9je+I/EtCd5GZ1AOm4gGSk/YHgEd WZFG6xDqL3tOuW506D/zgmk/BcsR7hW+iC1KgDcLtzEHNia71QHolCY6nCPO6oOVPbRwGVz4H5XgOW owQDpqNeHCcvNIe0lCAYDrnscrMgud
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm64/include/asm/kvm_host.h |  1 +
 arch/arm64/kvm/fpsimd.c           | 36 +++++++++++++++++++++++++++++++
 2 files changed, 37 insertions(+)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 90e92bcf2352..450cded7d361 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -444,6 +444,7 @@ struct kvm_vcpu_arch {
 #define KVM_ARM64_DEBUG_STATE_SAVE_TRBE	(1 << 13) /* Save TRBE context if active  */
 #define KVM_ARM64_FP_FOREIGN_FPSTATE	(1 << 14)
 #define KVM_ARM64_ON_UNSUPPORTED_CPU	(1 << 15) /* Physical CPU not in supported_cpus */
+#define KVM_ARM64_HOST_SME_ENABLED	(1 << 16) /* SME enabled for EL0 */
 
 #define KVM_GUESTDBG_VALID_MASK (KVM_GUESTDBG_ENABLE | \
 				 KVM_GUESTDBG_USE_SW_BP | \
diff --git a/arch/arm64/kvm/fpsimd.c b/arch/arm64/kvm/fpsimd.c
index 57d7ac3cfa0c..441edb9c398c 100644
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
 
 /*
@@ -135,6 +155,22 @@ void kvm_arch_vcpu_put_fp(struct kvm_vcpu *vcpu)
 
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

