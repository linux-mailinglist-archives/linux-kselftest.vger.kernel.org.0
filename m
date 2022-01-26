Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4265849CD95
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Jan 2022 16:13:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242619AbiAZPNS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 26 Jan 2022 10:13:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235791AbiAZPNS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 26 Jan 2022 10:13:18 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ECF5C06161C
        for <linux-kselftest@vger.kernel.org>; Wed, 26 Jan 2022 07:13:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1098461463
        for <linux-kselftest@vger.kernel.org>; Wed, 26 Jan 2022 15:13:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09A96C340E3;
        Wed, 26 Jan 2022 15:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643209997;
        bh=zPY7MztNeoE37pwIcdD53A+8yVkZO7HD7I60oNurDIQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jrNBs0KRmioQSHV+3p1Bj1WvQ34d3K31ve/1tOselvfqbfqbihYAVCgWb6yYdFYUC
         PYhXo0+36xqzuPKvz8P60GxMJkVRI2O1L3lz5bBs2m+uZ4lATj17rvHwBauE4LMWov
         4eYx72Rf5zeB9GrpXlUA1+Sododu4pqoR7aKRZCqbFCRqQ8IS67LC4mh937/Pi+rYE
         wp2hWlxS5/dbBVyG5ICyx+x1P4lWVkxoCiDaPXhOW1KDbrLl28d/ZrqTh/GQVrTY0b
         DMV/VVOA+QCkKRLgR1DE08rdmrTpSbAilCK2WnoeBtI0JYMJx2f641DfiXV24a/vRb
         dk7GjI7zXRy3g==
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
Subject: [PATCH v9 26/40] KVM: arm64: Trap SME usage in guest
Date:   Wed, 26 Jan 2022 15:11:06 +0000
Message-Id: <20220126151120.3811248-27-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220126151120.3811248-1-broonie@kernel.org>
References: <20220126151120.3811248-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4157; h=from:subject; bh=zPY7MztNeoE37pwIcdD53A+8yVkZO7HD7I60oNurDIQ=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBh8WSLR0Rz8fI5m32styscC/lpTw1aQPp/qDGAgb66 dxZu8k2JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYfFkiwAKCRAk1otyXVSH0G3rB/ 9uHjpghZVQAfBXZLhzt2XmJY/vePWk+y1yAdxb0d9mavaBolYBRRFxR2CjYQeb5i1C0a3cvyIL0Lu8 8jcyIGE2CIFU+c5UCV2T50UuY9NTxJFKSY+O68WuZTEP+P9fmLFHi8cBTXxWAW1sz/jyAmL1mchwQA B1cGEuM5n7Nu6TwZcV83Xw3wH6i6PZ+HMgJDLsmWf41Q4Cm/XxAI+ltkR7Gg1qE6UkRpAvG7fP+igM dBfLTodvwxzpIcg0JX3gQgVIMRj03+7xBxbCpTgc1D176lWsRsBOg1lKlucCdfN6dCCvMem44Zk0MR 5h2E2W3nkoykQlL2t59tlZyYZG3c+B
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

SME defines two new traps which need to be enabled for guests to ensure
that they can't use SME, one for the main SME operations which mirrors the
traps for SVE and another for access to TPIDR2 in SCTLR_EL2.

For VHE manage SMEN along with ZEN in activate_traps() and the FP state
management callbacks, along with SCTLR_EL2.EnTPIDR2.  There is no
existing dynamic management of SCTLR_EL2.

For nVHE manage TSM in activate_traps() along with the fine grained
traps for TPIDR2 and SMPRI.  There is no existing dynamic management of
fine grained traps.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/kvm/hyp/nvhe/switch.c | 30 ++++++++++++++++++++++++++++++
 arch/arm64/kvm/hyp/vhe/switch.c  | 11 ++++++++++-
 2 files changed, 40 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/hyp/nvhe/switch.c b/arch/arm64/kvm/hyp/nvhe/switch.c
index 6410d21d8695..184bf6bd79b9 100644
--- a/arch/arm64/kvm/hyp/nvhe/switch.c
+++ b/arch/arm64/kvm/hyp/nvhe/switch.c
@@ -47,10 +47,25 @@ static void __activate_traps(struct kvm_vcpu *vcpu)
 		val |= CPTR_EL2_TFP | CPTR_EL2_TZ;
 		__activate_traps_fpsimd32(vcpu);
 	}
+	if (IS_ENABLED(CONFIG_ARM64_SME) && cpus_have_final_cap(ARM64_SME))
+		val |= CPTR_EL2_TSM;
 
 	write_sysreg(val, cptr_el2);
 	write_sysreg(__this_cpu_read(kvm_hyp_vector), vbar_el2);
 
+	if (IS_ENABLED(CONFIG_ARM64_SME) && cpus_have_final_cap(ARM64_SME) &&
+	    cpus_have_final_cap(ARM64_HAS_FGT)) {
+		val = read_sysreg_s(SYS_HFGRTR_EL2);
+		val &= ~(HFGxTR_EL2_nTPIDR_EL0_MASK |
+			 HFGxTR_EL2_nSMPRI_EL1_MASK);
+		write_sysreg_s(val, SYS_HFGRTR_EL2);
+
+		val = read_sysreg_s(SYS_HFGWTR_EL2);
+		val &= ~(HFGxTR_EL2_nTPIDR_EL0_MASK |
+			 HFGxTR_EL2_nSMPRI_EL1_MASK);
+		write_sysreg_s(val, SYS_HFGWTR_EL2);
+	}
+
 	if (cpus_have_final_cap(ARM64_WORKAROUND_SPECULATIVE_AT)) {
 		struct kvm_cpu_context *ctxt = &vcpu->arch.ctxt;
 
@@ -94,9 +109,24 @@ static void __deactivate_traps(struct kvm_vcpu *vcpu)
 
 	write_sysreg(this_cpu_ptr(&kvm_init_params)->hcr_el2, hcr_el2);
 
+	if (IS_ENABLED(CONFIG_ARM64_SME) && cpus_have_final_cap(ARM64_SME) &&
+	    cpus_have_final_cap(ARM64_HAS_FGT)) {
+		u64 val;
+
+		val = read_sysreg_s(SYS_HFGRTR_EL2);
+		val |= HFGxTR_EL2_nTPIDR_EL0_MASK | HFGxTR_EL2_nSMPRI_EL1_MASK;
+		write_sysreg_s(val, SYS_HFGRTR_EL2);
+
+		val = read_sysreg_s(SYS_HFGWTR_EL2);
+		val |= HFGxTR_EL2_nTPIDR_EL0_MASK | HFGxTR_EL2_nSMPRI_EL1_MASK;
+		write_sysreg_s(val, SYS_HFGWTR_EL2);
+	}
+
 	cptr = CPTR_EL2_DEFAULT;
 	if (vcpu_has_sve(vcpu) && (vcpu->arch.flags & KVM_ARM64_FP_ENABLED))
 		cptr |= CPTR_EL2_TZ;
+	if (IS_ENABLED(CONFIG_ARM64_SME) && cpus_have_final_cap(ARM64_SME))
+		cptr &= ~CPTR_EL2_TSM;
 
 	write_sysreg(cptr, cptr_el2);
 	write_sysreg(__kvm_hyp_host_vector, vbar_el2);
diff --git a/arch/arm64/kvm/hyp/vhe/switch.c b/arch/arm64/kvm/hyp/vhe/switch.c
index 619353b06e38..21217485514d 100644
--- a/arch/arm64/kvm/hyp/vhe/switch.c
+++ b/arch/arm64/kvm/hyp/vhe/switch.c
@@ -38,7 +38,8 @@ static void __activate_traps(struct kvm_vcpu *vcpu)
 
 	val = read_sysreg(cpacr_el1);
 	val |= CPACR_EL1_TTA;
-	val &= ~(CPACR_EL1_ZEN_EL0EN | CPACR_EL1_ZEN_EL1EN);
+	val &= ~(CPACR_EL1_ZEN_EL0EN | CPACR_EL1_ZEN_EL1EN |
+		 CPACR_EL1_SMEN_EL0EN | CPACR_EL1_SMEN_EL1EN);
 
 	/*
 	 * With VHE (HCR.E2H == 1), accesses to CPACR_EL1 are routed to
@@ -59,6 +60,10 @@ static void __activate_traps(struct kvm_vcpu *vcpu)
 		__activate_traps_fpsimd32(vcpu);
 	}
 
+	if (IS_ENABLED(CONFIG_ARM64_SME) && cpus_have_final_cap(ARM64_SME))
+		write_sysreg(read_sysreg(sctlr_el2) & ~SCTLR_ELx_ENTP2,
+			     sctlr_el2);
+
 	write_sysreg(val, cpacr_el1);
 
 	write_sysreg(__this_cpu_read(kvm_hyp_vector), vbar_el1);
@@ -80,6 +85,10 @@ static void __deactivate_traps(struct kvm_vcpu *vcpu)
 	 */
 	asm(ALTERNATIVE("nop", "isb", ARM64_WORKAROUND_SPECULATIVE_AT));
 
+	if (IS_ENABLED(CONFIG_ARM64_SME) && cpus_have_final_cap(ARM64_SME))
+		write_sysreg(read_sysreg(sctlr_el2) | SCTLR_ELx_ENTP2,
+			     sctlr_el2);
+
 	write_sysreg(CPACR_EL1_DEFAULT, cpacr_el1);
 	write_sysreg(vectors, vbar_el1);
 }
-- 
2.30.2

