Return-Path: <linux-kselftest+bounces-3346-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 21483836D54
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Jan 2024 18:28:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4C2128B9D6
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Jan 2024 17:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F64B6D1B6;
	Mon, 22 Jan 2024 16:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rs8IC+JO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04A076BB4B;
	Mon, 22 Jan 2024 16:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705940949; cv=none; b=G0b1t+u732CrdSpv3y8INGOqNU/ezLih6Wr3xBdOFbnAiGiy/XuFRlY326tKj0OJKqWFlNJK9p9/6XXLkMSFZx5og8ZU9GICucnbuaUD6owRYmVrHWY1G61wpheYNQGNcoX4ryJ/9vAQiW++nKcipBDXKdmaoK0Bzdm1kpIpasE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705940949; c=relaxed/simple;
	bh=7A2dpOvesOfQJ87ZmujRjxmcur7728PJYmyR4No26B8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aPSId25b24+GgGeFi8e93cZFwJaJdmXoPsCa9lFlMczAgtX1rlFD95gl4tBpJlSgraq667BFO4PZtdt78ew01vJi7RYDtQaMDVctwZ3BjfzA9GQ3bWRlRk4IepFQwWC7EIRnujpvRdiv70z6ijJnF4fwOEKHtMYM0giyN4eC3/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rs8IC+JO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C343BC433C7;
	Mon, 22 Jan 2024 16:29:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705940948;
	bh=7A2dpOvesOfQJ87ZmujRjxmcur7728PJYmyR4No26B8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Rs8IC+JO3z97qJ3h1+xeBF8rT5+pJZqZMPSj62xzZBfD1uNF89Vd3pT+9zShJ9kLE
	 4Hx+MwUWJXbvFhAZ4btQ07lZSZ/pRRbS7YBOEJuLt6HpKX4patEtoFzzt1eowx5Pss
	 EOlaNKWOMJQjXGF7/mETEP0bT6orl7HnlJ3W/ahS+tkogyQhWeFbfr/CBighDyD4fF
	 bNNpCKL3ReK3y6CjKHykwpRGH21jfO3/mWl7VVZhV2aKzLv74zKKqaQpfagVcxqzV7
	 l/ePsGtuXBbPIzAbbJk0VdS9tNOLAt2ehtrTNsZEYxIzL9URybZY9Rfqq5cvRwvK01
	 q41sUJcf2r60g==
From: Mark Brown <broonie@kernel.org>
Date: Mon, 22 Jan 2024 16:28:15 +0000
Subject: [PATCH v4 12/14] KVM: arm64: Support FEAT_FPMR for guests
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240122-arm64-2023-dpisa-v4-12-776e094861df@kernel.org>
References: <20240122-arm64-2023-dpisa-v4-0-776e094861df@kernel.org>
In-Reply-To: <20240122-arm64-2023-dpisa-v4-0-776e094861df@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, 
 Oliver Upton <oliver.upton@linux.dev>, James Morse <james.morse@arm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Dave Martin <dave.martin@arm.com>, kvmarm@lists.linux.dev, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-5c066
X-Developer-Signature: v=1; a=openpgp-sha256; l=6027; i=broonie@kernel.org;
 h=from:subject:message-id; bh=7A2dpOvesOfQJ87ZmujRjxmcur7728PJYmyR4No26B8=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlrpekCfPKPnh2d6twp8c04FFIEDculZSY65+xbO7C
 1Zqom0CJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZa6XpAAKCRAk1otyXVSH0OiJB/
 9RZ5MDi3Xy79SXJXPu+AJiDbG0wZ8huV/b7YgIOrI7mDlWzaPMFU03Z9mnn0nbs/N+nZJ4aQD47SRt
 dDuio5RhOTIPzdAarqRqfQfxpu9UI9kRvH1tpkFkdWQbl/pk0RGFw0TGVbwD8Tjf8WTC4URIorwCtG
 g2VaYCS0srksvgc5umitamBJidA1bDYMe7kArk3v0bMOd59+snDFsWeampSudq+6tlxgyz9SqEerBm
 sKsX9p0LSK1Qdu+EDZkaO4IDGwKE98I4Rxl23+FrNN7PiMAmDUOG8v8vhAriVN65NlrXt8fvLOg8XF
 CGKMDdQKNh8LmtQtiwtJ7Td427irF0
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

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
 arch/arm64/include/asm/kvm_host.h       |  3 ++-
 arch/arm64/kvm/emulate-nested.c         |  8 ++++++++
 arch/arm64/kvm/fpsimd.c                 |  2 +-
 arch/arm64/kvm/hyp/include/hyp/switch.h |  7 ++++++-
 arch/arm64/kvm/sys_regs.c               | 11 +++++++++++
 6 files changed, 29 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_arm.h b/arch/arm64/include/asm/kvm_arm.h
index 7f45ce9170bb..b2ddb6165953 100644
--- a/arch/arm64/include/asm/kvm_arm.h
+++ b/arch/arm64/include/asm/kvm_arm.h
@@ -103,7 +103,7 @@
 #define HCR_HOST_VHE_FLAGS (HCR_RW | HCR_TGE | HCR_E2H)
 
 #define HCRX_GUEST_FLAGS \
-	(HCRX_EL2_SMPME | HCRX_EL2_TCR2En | \
+	(HCRX_EL2_SMPME | HCRX_EL2_TCR2En | HCRX_EL2_EnFPM | \
 	 (cpus_have_final_cap(ARM64_HAS_MOPS) ? (HCRX_EL2_MSCEn | HCRX_EL2_MCE2) : 0))
 #define HCRX_HOST_FLAGS (HCRX_EL2_MSCEn | HCRX_EL2_TCR2En | HCRX_EL2_EnFPM)
 
diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index c4fdcc94d733..99c0f8944f04 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -384,6 +384,8 @@ enum vcpu_sysreg {
 	APGAKEYLO_EL1,
 	APGAKEYHI_EL1,
 
+	FPMR,
+
 	/* Memory Tagging Extension registers */
 	RGSR_EL1,	/* Random Allocation Tag Seed Register */
 	GCR_EL1,	/* Tag Control Register */
@@ -544,7 +546,6 @@ struct kvm_vcpu_arch {
 	enum fp_type fp_type;
 	unsigned int sve_max_vl;
 	u64 svcr;
-	unsigned long fpmr;
 
 	/* Stage 2 paging state used by the hardware on next switch */
 	struct kvm_s2_mmu *hw_mmu;
diff --git a/arch/arm64/kvm/emulate-nested.c b/arch/arm64/kvm/emulate-nested.c
index 431fd429932d..3af5fd0e28dc 100644
--- a/arch/arm64/kvm/emulate-nested.c
+++ b/arch/arm64/kvm/emulate-nested.c
@@ -67,6 +67,8 @@ enum cgt_group_id {
 	CGT_HCR_TTLBIS,
 	CGT_HCR_TTLBOS,
 
+	CGT_HCRX_EnFPM,
+
 	CGT_MDCR_TPMCR,
 	CGT_MDCR_TPM,
 	CGT_MDCR_TDE,
@@ -279,6 +281,11 @@ static const struct trap_bits coarse_trap_bits[] = {
 		.mask		= HCR_TTLBOS,
 		.behaviour	= BEHAVE_FORWARD_ANY,
 	},
+	[CGT_HCRX_EnFPM] = {
+		.index		= HCRX_EL2,
+		.mask		= HCRX_EL2_EnFPM,
+		.behaviour	= BEHAVE_FORWARD_ANY,
+	},
 	[CGT_MDCR_TPMCR] = {
 		.index		= MDCR_EL2,
 		.value		= MDCR_EL2_TPMCR,
@@ -478,6 +485,7 @@ static const struct encoding_to_trap_config encoding_to_cgt[] __initconst = {
 	SR_TRAP(SYS_AIDR_EL1,		CGT_HCR_TID1),
 	SR_TRAP(SYS_SMIDR_EL1,		CGT_HCR_TID1),
 	SR_TRAP(SYS_CTR_EL0,		CGT_HCR_TID2),
+	SR_TRAP(SYS_FPMR,		CGT_HCRX_EnFPM),
 	SR_TRAP(SYS_CCSIDR_EL1,		CGT_HCR_TID2_TID4),
 	SR_TRAP(SYS_CCSIDR2_EL1,	CGT_HCR_TID2_TID4),
 	SR_TRAP(SYS_CLIDR_EL1,		CGT_HCR_TID2_TID4),
diff --git a/arch/arm64/kvm/fpsimd.c b/arch/arm64/kvm/fpsimd.c
index 6cf22cd8f020..9e002489c843 100644
--- a/arch/arm64/kvm/fpsimd.c
+++ b/arch/arm64/kvm/fpsimd.c
@@ -152,7 +152,7 @@ void kvm_arch_vcpu_ctxsync_fp(struct kvm_vcpu *vcpu)
 		fp_state.sve_vl = vcpu->arch.sve_max_vl;
 		fp_state.sme_state = NULL;
 		fp_state.svcr = &vcpu->arch.svcr;
-		fp_state.fpmr = &vcpu->arch.fpmr;
+		fp_state.fpmr = (unsigned long *)&__vcpu_sys_reg(vcpu, FPMR);
 		fp_state.fp_type = &vcpu->arch.fp_type;
 
 		if (vcpu_has_sve(vcpu))
diff --git a/arch/arm64/kvm/hyp/include/hyp/switch.h b/arch/arm64/kvm/hyp/include/hyp/switch.h
index 27fcdfd432b9..abf785c473d0 100644
--- a/arch/arm64/kvm/hyp/include/hyp/switch.h
+++ b/arch/arm64/kvm/hyp/include/hyp/switch.h
@@ -370,10 +370,15 @@ static bool kvm_hyp_handle_fpsimd(struct kvm_vcpu *vcpu, u64 *exit_code)
 	isb();
 
 	/* Write out the host state if it's in the registers */
-	if (vcpu->arch.fp_state == FP_STATE_HOST_OWNED)
+	if (vcpu->arch.fp_state == FP_STATE_HOST_OWNED) {
 		__fpsimd_save_state(&(vcpu->arch.host_uw->fpsimd_state));
+		if (cpus_have_final_cap(ARM64_HAS_FPMR))
+			vcpu->arch.host_uw->fpmr = read_sysreg_s(SYS_FPMR);
+	}
 
 	/* Restore the guest state */
+	if (cpus_have_final_cap(ARM64_HAS_FPMR))
+		write_sysreg_s(__vcpu_sys_reg(vcpu, FPMR), SYS_FPMR);
 	if (sve_guest)
 		__hyp_sve_restore_guest(vcpu);
 	else
diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 38503b1cd2eb..216eac44c124 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -2067,6 +2067,15 @@ static unsigned int hidden_user_visibility(const struct kvm_vcpu *vcpu,
 	.visibility = hidden_user_visibility,	\
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
@@ -2463,6 +2472,8 @@ static const struct sys_reg_desc sys_reg_descs[] = {
 	{ SYS_DESC(SYS_CSSELR_EL1), access_csselr, reset_unknown, CSSELR_EL1 },
 	{ SYS_DESC(SYS_CTR_EL0), access_ctr },
 	{ SYS_DESC(SYS_SVCR), undef_access },
+	{ SYS_DESC(SYS_FPMR), access_rw, reset_unknown, FPMR,
+	  .visibility = fpmr_visibility },
 
 	{ PMU_SYS_REG(PMCR_EL0), .access = access_pmcr, .reset = reset_pmcr,
 	  .reg = PMCR_EL0, .get_user = get_pmcr, .set_user = set_pmcr },

-- 
2.30.2


