Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 191737D8315
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Oct 2023 14:48:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345060AbjJZMsE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 26 Oct 2023 08:48:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345047AbjJZMrk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 26 Oct 2023 08:47:40 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3328F19A6;
        Thu, 26 Oct 2023 05:47:23 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DACC3C433C7;
        Thu, 26 Oct 2023 12:47:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698324442;
        bh=/zcZQXH55IEw2G57GbBx/NCqs0MSdE6qvhCHAjYd0rQ=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=ry+Mpe1V3rsDrUXZ71r8myb+U2s0CLSPgfTxe98suCR9Rx9+KCuekGAXZYWnootDc
         vKwLHang/k1B4NxAlBVXoZfc1WzS0rbzlGWMxZba7HcXyIznken2n2eakTGRhyOU66
         trIxOqzmQXKgwNOv38n8f7Iw7iBhY2GFWAlDAnihF1VZRmoT26KUPqlOHEeezy5Plc
         VYur9X9zqeLeskQdtQZv/w4D9WgB5dvx2Wro42iMdXs8yvAhqtWsNcphKHLucnb4lj
         ADypDEHvcxpp5SW/ApWGHyPiKLmnghgG1PM1r61AET3PwmQkst2/UTqJXyfSPGpqag
         +gizJ/I9RHShA==
From:   Mark Brown <broonie@kernel.org>
Date:   Thu, 26 Oct 2023 13:44:29 +0100
Subject: [PATCH 15/21] KVM: arm64: Support FEAT_FPMR for guests
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231026-arm64-2023-dpisa-v1-15-8470dd989bb2@kernel.org>
References: <20231026-arm64-2023-dpisa-v1-0-8470dd989bb2@kernel.org>
In-Reply-To: <20231026-arm64-2023-dpisa-v1-0-8470dd989bb2@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kvmarm@lists.linux.dev, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-0438c
X-Developer-Signature: v=1; a=openpgp-sha256; l=6361; i=broonie@kernel.org;
 h=from:subject:message-id; bh=/zcZQXH55IEw2G57GbBx/NCqs0MSdE6qvhCHAjYd0rQ=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlOl+gYc6HbU08LvxZczTbgEDPccS28EHZB1p9z1xq
 F6RAz+2JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZTpfoAAKCRAk1otyXVSH0OjEB/
 95LgZW+8G2B1ksIATpSdo7h6pCG6ILnUjWt2+WgZVeAJiirxhv8pLI2zcuVI7+ECoKgRNYzbkVlV/q
 lskTpCLOkAfi1WNx3Vfb452zJn4J6tykFOe4HfNZdVfxQNO4HZXt/TkWZW6piiEBgQ2Xd7I+VZ5TGi
 JLSWpCKA6X0uSwqbJ76OdXrbn0xN80MEu6sdLzv+yjUeYUBu/cj3v/q2iB9kQBZsEOZ3QAyaSvlQdd
 HL/ZYV3j4PRZXtJLZlMyOtNbOmnh8blqD9BP6LzDVEKGRuFI4Nl5XXBrlA1CPrBZKHYl8ICg/Pf4iw
 jCJk87Jw908KAVGj3F3sTdhAhHJ5Rn
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

FEAT_FPMR introduces a new system register FPMR which allows configuration
of floating point behaviour, currently for FP8 specific features. Allow use
of this in guests, disabling the trap while guests are running and saving
and restoring the value along with the rest of the floating point state.
Since FPMR is stored immediately after the main floating point state we
share it with the hypervisor by adjusting the size of the shared region.

Access to FPMR is covered by both a register specific trap HCRX_EL2.EnFPM
and the overall floating point access trap so we just unconditionally
enable the FPMR specific trap and rely on the floating point access trap to
detect guest floating point usage.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/include/asm/kvm_arm.h        |  2 +-
 arch/arm64/include/asm/kvm_host.h       |  4 +++-
 arch/arm64/kvm/fpsimd.c                 | 20 +++++++++++++++++---
 arch/arm64/kvm/hyp/include/hyp/switch.h |  7 ++++++-
 arch/arm64/kvm/sys_regs.c               | 11 +++++++++++
 5 files changed, 38 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_arm.h b/arch/arm64/include/asm/kvm_arm.h
index ef033c6c745c..2efc7107c9a1 100644
--- a/arch/arm64/include/asm/kvm_arm.h
+++ b/arch/arm64/include/asm/kvm_arm.h
@@ -102,7 +102,7 @@
 #define HCR_HOST_NVHE_PROTECTED_FLAGS (HCR_HOST_NVHE_FLAGS | HCR_TSC)
 #define HCR_HOST_VHE_FLAGS (HCR_RW | HCR_TGE | HCR_E2H)
 
-#define HCRX_GUEST_FLAGS (HCRX_EL2_SMPME | HCRX_EL2_TCR2En)
+#define HCRX_GUEST_FLAGS (HCRX_EL2_SMPME | HCRX_EL2_TCR2En | HCRX_EL2_EnFPM)
 #define HCRX_HOST_FLAGS (HCRX_EL2_MSCEn | HCRX_EL2_TCR2En | HCRX_EL2_EnFPM)
 
 /* TCR_EL2 Registers bits */
diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 2151c1cbc53d..ddd31b41bec7 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -355,6 +355,8 @@ enum vcpu_sysreg {
 	CNTP_CVAL_EL0,
 	CNTP_CTL_EL0,
 
+	FPMR,
+
 	/* Memory Tagging Extension registers */
 	RGSR_EL1,	/* Random Allocation Tag Seed Register */
 	GCR_EL1,	/* Tag Control Register */
@@ -481,7 +483,6 @@ struct kvm_vcpu_arch {
 	enum fp_type fp_type;
 	unsigned int sve_max_vl;
 	u64 svcr;
-	u64 fpmr;
 
 	/* Stage 2 paging state used by the hardware on next switch */
 	struct kvm_s2_mmu *hw_mmu;
@@ -540,6 +541,7 @@ struct kvm_vcpu_arch {
 	struct kvm_guest_debug_arch external_debug_state;
 
 	struct user_fpsimd_state *host_fpsimd_state;	/* hyp VA */
+	u64 *host_fpmr;					/* hyp VA */
 	struct task_struct *parent_task;
 
 	struct {
diff --git a/arch/arm64/kvm/fpsimd.c b/arch/arm64/kvm/fpsimd.c
index e3e611e30e91..dee078625d0d 100644
--- a/arch/arm64/kvm/fpsimd.c
+++ b/arch/arm64/kvm/fpsimd.c
@@ -14,6 +14,16 @@
 #include <asm/kvm_mmu.h>
 #include <asm/sysreg.h>
 
+static void *fpsimd_share_end(struct user_fpsimd_state *fpsimd)
+{
+	void *share_end = fpsimd + 1;
+
+	if (cpus_have_final_cap(ARM64_HAS_FPMR))
+		share_end += sizeof(u64);
+
+	return share_end;
+}
+
 void kvm_vcpu_unshare_task_fp(struct kvm_vcpu *vcpu)
 {
 	struct task_struct *p = vcpu->arch.parent_task;
@@ -23,7 +33,7 @@ void kvm_vcpu_unshare_task_fp(struct kvm_vcpu *vcpu)
 		return;
 
 	fpsimd = &p->thread.uw.fpsimd_state;
-	kvm_unshare_hyp(fpsimd, fpsimd + 1);
+	kvm_unshare_hyp(fpsimd, fpsimd_share_end(fpsimd));
 	put_task_struct(p);
 }
 
@@ -45,11 +55,15 @@ int kvm_arch_vcpu_run_map_fp(struct kvm_vcpu *vcpu)
 	kvm_vcpu_unshare_task_fp(vcpu);
 
 	/* Make sure the host task fpsimd state is visible to hyp: */
-	ret = kvm_share_hyp(fpsimd, fpsimd + 1);
+	ret = kvm_share_hyp(fpsimd, fpsimd_share_end(fpsimd));
 	if (ret)
 		return ret;
 
 	vcpu->arch.host_fpsimd_state = kern_hyp_va(fpsimd);
+	if (cpus_have_final_cap(ARM64_HAS_FPMR)) {
+		WARN_ON_ONCE(&current->thread.fpmr + 1 != fpsimd_share_end(fpsimd));
+		vcpu->arch.host_fpmr = kern_hyp_va(&current->thread.fpmr);
+	}
 
 	/*
 	 * We need to keep current's task_struct pinned until its data has been
@@ -153,7 +167,7 @@ void kvm_arch_vcpu_ctxsync_fp(struct kvm_vcpu *vcpu)
 		fp_state.sve_vl = vcpu->arch.sve_max_vl;
 		fp_state.sme_state = NULL;
 		fp_state.svcr = &vcpu->arch.svcr;
-		fp_state.fpmr = &vcpu->arch.fpmr;
+		fp_state.fpmr = &__vcpu_sys_reg(vcpu, FPMR);
 		fp_state.fp_type = &vcpu->arch.fp_type;
 
 		if (vcpu_has_sve(vcpu))
diff --git a/arch/arm64/kvm/hyp/include/hyp/switch.h b/arch/arm64/kvm/hyp/include/hyp/switch.h
index 9cfe6bd1dbe4..4fad3c7d2d89 100644
--- a/arch/arm64/kvm/hyp/include/hyp/switch.h
+++ b/arch/arm64/kvm/hyp/include/hyp/switch.h
@@ -322,10 +322,15 @@ static bool kvm_hyp_handle_fpsimd(struct kvm_vcpu *vcpu, u64 *exit_code)
 	isb();
 
 	/* Write out the host state if it's in the registers */
-	if (vcpu->arch.fp_state == FP_STATE_HOST_OWNED)
+	if (vcpu->arch.fp_state == FP_STATE_HOST_OWNED) {
 		__fpsimd_save_state(vcpu->arch.host_fpsimd_state);
+		if (cpus_have_final_cap(ARM64_HAS_FPMR))
+			*vcpu->arch.host_fpmr = read_sysreg_s(SYS_FPMR);
+	}
 
 	/* Restore the guest state */
+	if (cpus_have_final_cap(ARM64_HAS_FPMR))
+		write_sysreg_s(__vcpu_sys_reg(vcpu, FPMR), SYS_FPMR);
 	if (sve_guest)
 		__hyp_sve_restore_guest(vcpu);
 	else
diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 99cdaa594b06..ad6c39178edc 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -1806,6 +1806,15 @@ static unsigned int elx2_visibility(const struct kvm_vcpu *vcpu,
 	.visibility = elx2_visibility,		\
 }
 
+static unsigned int fpmr_visibility(const struct kvm_vcpu *vcpu,
+				    const struct sys_reg_desc *rd)
+{
+	if (cpus_have_final_cap(ARM64_HAS_FPMR))
+		return 0;
+
+	return REG_HIDDEN;
+}
+
 /*
  * Since reset() callback and field val are not used for idregs, they will be
  * used for specific purposes for idregs.
@@ -2165,6 +2174,8 @@ static const struct sys_reg_desc sys_reg_descs[] = {
 	{ SYS_DESC(SYS_CSSELR_EL1), access_csselr, reset_unknown, CSSELR_EL1 },
 	{ SYS_DESC(SYS_CTR_EL0), access_ctr },
 	{ SYS_DESC(SYS_SVCR), undef_access },
+	{ SYS_DESC(SYS_FPMR), access_rw, reset_unknown, FPMR,
+	  .visibility = fpmr_visibility },
 
 	{ PMU_SYS_REG(PMCR_EL0), .access = access_pmcr,
 	  .reset = reset_pmcr, .reg = PMCR_EL0 },

-- 
2.30.2

