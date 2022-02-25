Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 617BE4C4C7A
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Feb 2022 18:36:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242461AbiBYRgo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 25 Feb 2022 12:36:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243824AbiBYRgn (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 25 Feb 2022 12:36:43 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F36D71CDDD7
        for <linux-kselftest@vger.kernel.org>; Fri, 25 Feb 2022 09:36:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8BBE261DCC
        for <linux-kselftest@vger.kernel.org>; Fri, 25 Feb 2022 17:36:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C641C36AE7;
        Fri, 25 Feb 2022 17:36:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645810568;
        bh=z1rA0aYrxNfbhwyFiqt7+3oVJ1dydeszqIiLjGiY+nk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VmkGraBd2K9AEbrndWRa/WQWIxaDEE0sBbfbRM7tcD9Bji4SX0BYq77kqKUqZL3WS
         Ep3GB6elVx0ISk0lG9/BtMkU1OHYDQBA3rlpspWTXUUVJRaQPVg2Xqv6KeU5P0mtVY
         Bbs9wMtiFli+o4S1w2qMvCXnTCQlyk9CjcavFs09rn7AE4q9WVByXQmRZKC+FUxP1Q
         BUD3xOTvvgw5fIqc2BZOtEN11/zo57lDVMezXf+/bkV04Q44cdDXNynSDXFbnsPvJT
         Uf7/uV7bC2RvXLdD10qjuzJ63QXaD0ULnUqm6PRnvoYNQOI+BFfuR08zggxKMxQ1ut
         o69YCirSYIcUw==
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
Subject: [PATCH v12 27/40] KVM: arm64: Trap SME usage in guest
Date:   Fri, 25 Feb 2022 16:59:10 +0000
Message-Id: <20220225165923.1474372-28-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220225165923.1474372-1-broonie@kernel.org>
References: <20220225165923.1474372-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3945; h=from:subject; bh=z1rA0aYrxNfbhwyFiqt7+3oVJ1dydeszqIiLjGiY+nk=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBiGQrfLAhB7IT7E2JVd2rw2+YnRkOiDo/pepFl8/PH jaxbgC+JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYhkK3wAKCRAk1otyXVSH0AJuB/ 9nMrFYKX9kN1XmSWy8gePfA1toLU5dchlbbW5Y7B56yBnaWopuCdoBe9eqLlG5w60PCN2XxMMMoxip 2+Lmt5LB3/KAOaVwZV9KC/su04WacTrn0BT7AZhLKBDShSyJNvne/EXaTsXwl1OPzlIgpIls3DlX40 Bud29xslwnjypjPPAQ+6XlvWnxQb9t2bqnRv/zv86qenfMavbD4+SDBQ66QS7sBsXY7HWW2d2Mvenk CpVYgBHP8FX3P2DYnk2thQjNRqxeMF3HSp/7j8h7oyhWf32Rr0LOZQbSrzzlHvbQa0R/r6LDzlJ+KV Qfs3KnmzdZulE+Z/JjZciUTN6Co00x
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
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm64/kvm/hyp/nvhe/switch.c | 30 ++++++++++++++++++++++++++++++
 arch/arm64/kvm/hyp/vhe/switch.c  | 11 ++++++++++-
 2 files changed, 40 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/hyp/nvhe/switch.c b/arch/arm64/kvm/hyp/nvhe/switch.c
index 6410d21d8695..caace61ea459 100644
--- a/arch/arm64/kvm/hyp/nvhe/switch.c
+++ b/arch/arm64/kvm/hyp/nvhe/switch.c
@@ -47,10 +47,24 @@ static void __activate_traps(struct kvm_vcpu *vcpu)
 		val |= CPTR_EL2_TFP | CPTR_EL2_TZ;
 		__activate_traps_fpsimd32(vcpu);
 	}
+	if (cpus_have_final_cap(ARM64_SME))
+		val |= CPTR_EL2_TSM;
 
 	write_sysreg(val, cptr_el2);
 	write_sysreg(__this_cpu_read(kvm_hyp_vector), vbar_el2);
 
+	if (cpus_have_final_cap(ARM64_SME)) {
+		val = read_sysreg_s(SYS_HFGRTR_EL2);
+		val &= ~(HFGxTR_EL2_nTPIDR2_EL0_MASK |
+			 HFGxTR_EL2_nSMPRI_EL1_MASK);
+		write_sysreg_s(val, SYS_HFGRTR_EL2);
+
+		val = read_sysreg_s(SYS_HFGWTR_EL2);
+		val &= ~(HFGxTR_EL2_nTPIDR2_EL0_MASK |
+			 HFGxTR_EL2_nSMPRI_EL1_MASK);
+		write_sysreg_s(val, SYS_HFGWTR_EL2);
+	}
+
 	if (cpus_have_final_cap(ARM64_WORKAROUND_SPECULATIVE_AT)) {
 		struct kvm_cpu_context *ctxt = &vcpu->arch.ctxt;
 
@@ -94,9 +108,25 @@ static void __deactivate_traps(struct kvm_vcpu *vcpu)
 
 	write_sysreg(this_cpu_ptr(&kvm_init_params)->hcr_el2, hcr_el2);
 
+	if (cpus_have_final_cap(ARM64_SME)) {
+		u64 val;
+
+		val = read_sysreg_s(SYS_HFGRTR_EL2);
+		val |= HFGxTR_EL2_nTPIDR2_EL0_MASK |
+			HFGxTR_EL2_nSMPRI_EL1_MASK;
+		write_sysreg_s(val, SYS_HFGRTR_EL2);
+
+		val = read_sysreg_s(SYS_HFGWTR_EL2);
+		val |= HFGxTR_EL2_nTPIDR2_EL0_MASK |
+			HFGxTR_EL2_nSMPRI_EL1_MASK;
+		write_sysreg_s(val, SYS_HFGWTR_EL2);
+	}
+
 	cptr = CPTR_EL2_DEFAULT;
 	if (vcpu_has_sve(vcpu) && (vcpu->arch.flags & KVM_ARM64_FP_ENABLED))
 		cptr |= CPTR_EL2_TZ;
+	if (cpus_have_final_cap(ARM64_SME))
+		cptr &= ~CPTR_EL2_TSM;
 
 	write_sysreg(cptr, cptr_el2);
 	write_sysreg(__kvm_hyp_host_vector, vbar_el2);
diff --git a/arch/arm64/kvm/hyp/vhe/switch.c b/arch/arm64/kvm/hyp/vhe/switch.c
index 619353b06e38..a4d2fb5c9710 100644
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
 
+	if (cpus_have_final_cap(ARM64_SME))
+		write_sysreg(read_sysreg(sctlr_el2) & ~SCTLR_ELx_ENTP2,
+			     sctlr_el2);
+
 	write_sysreg(val, cpacr_el1);
 
 	write_sysreg(__this_cpu_read(kvm_hyp_vector), vbar_el1);
@@ -80,6 +85,10 @@ static void __deactivate_traps(struct kvm_vcpu *vcpu)
 	 */
 	asm(ALTERNATIVE("nop", "isb", ARM64_WORKAROUND_SPECULATIVE_AT));
 
+	if (cpus_have_final_cap(ARM64_SME))
+		write_sysreg(read_sysreg(sctlr_el2) | SCTLR_ELx_ENTP2,
+			     sctlr_el2);
+
 	write_sysreg(CPACR_EL1_DEFAULT, cpacr_el1);
 	write_sysreg(vectors, vbar_el1);
 }
-- 
2.30.2

