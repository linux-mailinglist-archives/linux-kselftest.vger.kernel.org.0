Return-Path: <linux-kselftest+bounces-39376-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 625F7B2DF06
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Aug 2025 16:21:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5A78A05B24
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Aug 2025 14:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7115F26FDBB;
	Wed, 20 Aug 2025 14:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nUDpos7x"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40AFF1DDC07;
	Wed, 20 Aug 2025 14:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755699327; cv=none; b=YfX/jTDzrkLs0GLFunapnLAixhjePflaHYUx7IJZwJvEzJ9gwXVrJj9PsGgZYz3XiVFIZwqBy/bsh4LqlUKZ/37kAmEyZ0KUbgu2MfqnMzE/Y3j5+p7OSvuNTWTvop3jdhZASnioyxU4EuvUMePg4Sbmb1YZpI441InQXdakSW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755699327; c=relaxed/simple;
	bh=B4WhVhWlQUV3RpMfPy1jJwJQZNUp60IegucsTo4ATog=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Zx1QJCyvj9xx8D6Wat2S5MHaoy0RKoMpo3RmQJacLKdhXLsm3FpaMtcAgAbSkcTvPMoiLOZIB3RzBJMSs32HEuEHt1EH5vnzdIVk2+f52T3i7NL0g5YpYwOhJYkWnTm5Ir41QVA8Zl92sa96PED+1TL00PnCXTQjAHm3qTYDlqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nUDpos7x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B65ADC4CEEB;
	Wed, 20 Aug 2025 14:15:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755699326;
	bh=B4WhVhWlQUV3RpMfPy1jJwJQZNUp60IegucsTo4ATog=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=nUDpos7xrXgjtqzp3CDyvOXF6pQiYoh/KaWKpyPkwFCY9YliG0GAg5Nguy6yhRgg6
	 5JkLElC6leZZgB8o5qUwa5VrkvwHVf7v6yibqOPJj5EYMBqiTM7JvOjmENzHBZszdr
	 BaVfXQK4xmxcuWsShzyl2QRjGEmltkd4Ie/Dj4vU0gE+1rI9MXAfprRdZs15vRsJFQ
	 DWWclEGnpJ1TVS4aLKpP3WRmfJygHitmpnLjStcug8ZOIlci3gBpgugOVXbfbI+OPH
	 kIaZFdbk9/jNliUbCznYU/dcVxNg+L4awte9Hd48JA/eBeoxCWZJJV+FK0ZOJOjB9O
	 F97ii1moXTTtw==
From: Mark Brown <broonie@kernel.org>
Date: Wed, 20 Aug 2025 15:14:42 +0100
Subject: [PATCH v15 2/6] KVM: arm64: Manage GCS access and registers for
 guests
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250820-arm64-gcs-v15-2-5e334da18b84@kernel.org>
References: <20250820-arm64-gcs-v15-0-5e334da18b84@kernel.org>
In-Reply-To: <20250820-arm64-gcs-v15-0-5e334da18b84@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, 
 Oliver Upton <oliver.upton@linux.dev>, Joey Gouly <joey.gouly@arm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, Shuah Khan <shuah@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, 
 kvmarm@lists.linux.dev, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-cff91
X-Developer-Signature: v=1; a=openpgp-sha256; l=11187; i=broonie@kernel.org;
 h=from:subject:message-id; bh=B4WhVhWlQUV3RpMfPy1jJwJQZNUp60IegucsTo4ATog=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBopdhviGgNplkjClTHjWrZtr1pJS4vcCbdGO3Zz
 CtQQ6PD83KJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaKXYbwAKCRAk1otyXVSH
 0KTuB/0ax7Wx15WnfHmcHCsYRmxPIS95dIb20hblOakOgbr9FGsksE8YJG5pdqm2uAH5526sgse
 sa6tO9TkQywXAom79DNd4K3uy6QeRaiJj2YPLAh2Ohi8gWLh8udHB55Wc8xoOAkowHObyHW0hJK
 ZcWJZrre0ZtupoLLUGH/yzGuqn1Xd18CH4FEo9XWXw5ftWKSjQANpUjpozxWyT8sm3fF9H51j+G
 C5+URaUA9iAfMDvWGV2/tlK60Q1F4iLWKFIMpz/3a+6oFqsuDA5ZdSBssfnhmjq1aCv+Mc2VPPD
 fFcHGQjiew+vCrJbWjb07oI8/84B9MDA5BVpWxX1InLaDUAX
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

GCS introduces a number of system registers for EL1 and EL0, on systems
with GCS we need to context switch them and expose them to VMMs to allow
guests to use GCS.

In order to allow guests to use GCS we also need to configure
HCRX_EL2.GCSEn, if this is not set GCS instructions will be noops and
CHKFEAT will report GCS as disabled.  Also enable fine grained traps for
access to the GCS registers by guests which do not have the feature
enabled.

In order to allow userspace to control availability of the feature to
guests we enable writability for only ID_AA64PFR1_EL1.GCS, this is a
deliberately conservative choice to avoid errors due to oversights.
Further fields should be made writable in future.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/include/asm/kvm_emulate.h       |  3 +++
 arch/arm64/include/asm/kvm_host.h          | 14 ++++++++++++++
 arch/arm64/include/asm/vncr_mapping.h      |  2 ++
 arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h | 31 ++++++++++++++++++++++++++++++
 arch/arm64/kvm/hyp/vhe/sysreg-sr.c         | 10 ++++++++++
 arch/arm64/kvm/sys_regs.c                  | 31 +++++++++++++++++++++++++++++-
 6 files changed, 90 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/kvm_emulate.h b/arch/arm64/include/asm/kvm_emulate.h
index fa8a08a1ccd5..9ab1e7616854 100644
--- a/arch/arm64/include/asm/kvm_emulate.h
+++ b/arch/arm64/include/asm/kvm_emulate.h
@@ -672,6 +672,9 @@ static inline void vcpu_set_hcrx(struct kvm_vcpu *vcpu)
 
 		if (kvm_has_sctlr2(kvm))
 			vcpu->arch.hcrx_el2 |= HCRX_EL2_SCTLR2En;
+
+		if (kvm_has_gcs(kvm))
+			vcpu->arch.hcrx_el2 |= HCRX_EL2_GCSEn;
 	}
 }
 #endif /* __ARM64_KVM_EMULATE_H__ */
diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 2f2394cce24e..22a3fa9d97aa 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -480,6 +480,10 @@ enum vcpu_sysreg {
 
 	POR_EL0,	/* Permission Overlay Register 0 (EL0) */
 
+	/* Guarded Control Stack registers */
+	GCSCRE0_EL1,	/* Guarded Control Stack Control (EL0) */
+	GCSPR_EL0,	/* Guarded Control Stack Pointer (EL0) */
+
 	/* FP/SIMD/SVE */
 	SVCR,
 	FPMR,
@@ -502,6 +506,8 @@ enum vcpu_sysreg {
 	PIRE0_EL2,	/* Permission Indirection Register 0 (EL2) */
 	PIR_EL2,	/* Permission Indirection Register 1 (EL2) */
 	POR_EL2,	/* Permission Overlay Register 2 (EL2) */
+	GCSCR_EL2,	/* Guarded Control Stack Control Register (EL2) */
+	GCSPR_EL2,	/* Guarded Control Stack Pointer Register (EL2) */
 	SPSR_EL2,	/* EL2 saved program status register */
 	ELR_EL2,	/* EL2 exception link register */
 	AFSR0_EL2,	/* Auxiliary Fault Status Register 0 (EL2) */
@@ -571,6 +577,10 @@ enum vcpu_sysreg {
 	VNCR(VDISR_EL2),
 	VNCR(VSESR_EL2),
 
+	/* Guarded Control Stack registers */
+	VNCR(GCSPR_EL1),	/* Guarded Control Stack Pointer (EL1) */
+	VNCR(GCSCR_EL1),	/* Guarded Control Stack Control (EL1) */
+
 	VNCR(HFGRTR_EL2),
 	VNCR(HFGWTR_EL2),
 	VNCR(HFGITR_EL2),
@@ -1697,6 +1707,10 @@ void kvm_set_vm_id_reg(struct kvm *kvm, u32 reg, u64 val);
 #define kvm_has_sctlr2(k)				\
 	(kvm_has_feat((k), ID_AA64MMFR3_EL1, SCTLRX, IMP))
 
+#define kvm_has_gcs(k)					\
+	(system_supports_gcs() &&			\
+	 kvm_has_feat((k), ID_AA64PFR1_EL1, GCS, IMP))
+
 static inline bool kvm_arch_has_irq_bypass(void)
 {
 	return true;
diff --git a/arch/arm64/include/asm/vncr_mapping.h b/arch/arm64/include/asm/vncr_mapping.h
index f6ec500ad3fa..e9fac6218d44 100644
--- a/arch/arm64/include/asm/vncr_mapping.h
+++ b/arch/arm64/include/asm/vncr_mapping.h
@@ -95,6 +95,8 @@
 #define VNCR_PMSIRR_EL1         0x840
 #define VNCR_PMSLATFR_EL1       0x848
 #define VNCR_TRFCR_EL1          0x880
+#define VNCR_GCSPR_EL1		0x8C0
+#define VNCR_GCSCR_EL1		0x8D0
 #define VNCR_MPAM1_EL1          0x900
 #define VNCR_MPAMHCR_EL2        0x930
 #define VNCR_MPAMVPMV_EL2       0x938
diff --git a/arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h b/arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h
index a17cbe7582de..053d7b3c5104 100644
--- a/arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h
+++ b/arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h
@@ -17,6 +17,7 @@
 #include <asm/kvm_mmu.h>
 
 static inline bool ctxt_has_s1poe(struct kvm_cpu_context *ctxt);
+static inline bool ctxt_has_gcs(struct kvm_cpu_context *ctxt);
 
 static inline struct kvm_vcpu *ctxt_to_vcpu(struct kvm_cpu_context *ctxt)
 {
@@ -67,6 +68,11 @@ static inline void __sysreg_save_user_state(struct kvm_cpu_context *ctxt)
 {
 	ctxt_sys_reg(ctxt, TPIDR_EL0)	= read_sysreg(tpidr_el0);
 	ctxt_sys_reg(ctxt, TPIDRRO_EL0)	= read_sysreg(tpidrro_el0);
+
+	if (ctxt_has_gcs(ctxt)) {
+		ctxt_sys_reg(ctxt, GCSPR_EL0) = read_sysreg_s(SYS_GCSPR_EL0);
+		ctxt_sys_reg(ctxt, GCSCRE0_EL1)	= read_sysreg_s(SYS_GCSCRE0_EL1);
+	}
 }
 
 static inline bool ctxt_has_mte(struct kvm_cpu_context *ctxt)
@@ -131,6 +137,17 @@ static inline bool ctxt_has_sctlr2(struct kvm_cpu_context *ctxt)
 	return kvm_has_sctlr2(kern_hyp_va(vcpu->kvm));
 }
 
+static inline bool ctxt_has_gcs(struct kvm_cpu_context *ctxt)
+{
+	struct kvm_vcpu *vcpu;
+
+	if (!cpus_have_final_cap(ARM64_HAS_GCS))
+		return false;
+
+	vcpu = ctxt_to_vcpu(ctxt);
+	return kvm_has_feat(kern_hyp_va(vcpu->kvm), ID_AA64PFR1_EL1, GCS, IMP);
+}
+
 static inline void __sysreg_save_el1_state(struct kvm_cpu_context *ctxt)
 {
 	ctxt_sys_reg(ctxt, SCTLR_EL1)	= read_sysreg_el1(SYS_SCTLR);
@@ -144,6 +161,10 @@ static inline void __sysreg_save_el1_state(struct kvm_cpu_context *ctxt)
 		if (ctxt_has_s1pie(ctxt)) {
 			ctxt_sys_reg(ctxt, PIR_EL1)	= read_sysreg_el1(SYS_PIR);
 			ctxt_sys_reg(ctxt, PIRE0_EL1)	= read_sysreg_el1(SYS_PIRE0);
+			if (ctxt_has_gcs(ctxt)) {
+				ctxt_sys_reg(ctxt, GCSPR_EL1)	= read_sysreg_el1(SYS_GCSPR);
+				ctxt_sys_reg(ctxt, GCSCR_EL1)	= read_sysreg_el1(SYS_GCSCR);
+			}
 		}
 
 		if (ctxt_has_s1poe(ctxt))
@@ -206,6 +227,11 @@ static inline void __sysreg_restore_user_state(struct kvm_cpu_context *ctxt)
 {
 	write_sysreg(ctxt_sys_reg(ctxt, TPIDR_EL0),	tpidr_el0);
 	write_sysreg(ctxt_sys_reg(ctxt, TPIDRRO_EL0),	tpidrro_el0);
+	if (ctxt_has_gcs(ctxt)) {
+		write_sysreg_s(ctxt_sys_reg(ctxt, GCSPR_EL0), SYS_GCSPR_EL0);
+		write_sysreg_s(ctxt_sys_reg(ctxt, GCSCRE0_EL1),
+			       SYS_GCSCRE0_EL1);
+	}
 }
 
 static inline void __sysreg_restore_el1_state(struct kvm_cpu_context *ctxt,
@@ -239,6 +265,11 @@ static inline void __sysreg_restore_el1_state(struct kvm_cpu_context *ctxt,
 		if (ctxt_has_s1pie(ctxt)) {
 			write_sysreg_el1(ctxt_sys_reg(ctxt, PIR_EL1),	SYS_PIR);
 			write_sysreg_el1(ctxt_sys_reg(ctxt, PIRE0_EL1),	SYS_PIRE0);
+
+			if (ctxt_has_gcs(ctxt)) {
+				write_sysreg_el1(ctxt_sys_reg(ctxt, GCSPR_EL1),	SYS_GCSPR);
+				write_sysreg_el1(ctxt_sys_reg(ctxt, GCSCR_EL1),	SYS_GCSCR);
+			}
 		}
 
 		if (ctxt_has_s1poe(ctxt))
diff --git a/arch/arm64/kvm/hyp/vhe/sysreg-sr.c b/arch/arm64/kvm/hyp/vhe/sysreg-sr.c
index f28c6cf4fe1b..e63b473d66d1 100644
--- a/arch/arm64/kvm/hyp/vhe/sysreg-sr.c
+++ b/arch/arm64/kvm/hyp/vhe/sysreg-sr.c
@@ -61,6 +61,11 @@ static void __sysreg_save_vel2_state(struct kvm_vcpu *vcpu)
 
 			if (ctxt_has_s1poe(&vcpu->arch.ctxt))
 				__vcpu_assign_sys_reg(vcpu, POR_EL2, read_sysreg_el1(SYS_POR));
+
+			if (ctxt_has_gcs(&vcpu->arch.ctxt)) {
+				__vcpu_assign_sys_reg(vcpu, GCSCR_EL2, read_sysreg_el1(SYS_GCSCR));
+				__vcpu_assign_sys_reg(vcpu, GCSPR_EL2, read_sysreg_el1(SYS_GCSPR));
+			}
 		}
 
 		/*
@@ -133,6 +138,11 @@ static void __sysreg_restore_vel2_state(struct kvm_vcpu *vcpu)
 
 		if (ctxt_has_s1poe(&vcpu->arch.ctxt))
 			write_sysreg_el1(__vcpu_sys_reg(vcpu, POR_EL2), SYS_POR);
+
+		if (ctxt_has_gcs(&vcpu->arch.ctxt)) {
+			write_sysreg_el1(__vcpu_sys_reg(vcpu, GCSCR_EL2), SYS_GCSCR);
+			write_sysreg_el1(__vcpu_sys_reg(vcpu, GCSPR_EL2), SYS_GCSPR);
+		}
 	}
 
 	write_sysreg_el1(__vcpu_sys_reg(vcpu, ESR_EL2),		SYS_ESR);
diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 82ffb3b3b3cf..592cb5d6497a 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -138,6 +138,8 @@ static bool get_el2_to_el1_mapping(unsigned int reg,
 		MAPPED_EL2_SYSREG(PIR_EL2,     PIR_EL1,     NULL	     );
 		MAPPED_EL2_SYSREG(PIRE0_EL2,   PIRE0_EL1,   NULL	     );
 		MAPPED_EL2_SYSREG(POR_EL2,     POR_EL1,     NULL	     );
+		MAPPED_EL2_SYSREG(GCSCR_EL2,   GCSCR_EL1,   NULL             );
+		MAPPED_EL2_SYSREG(GCSPR_EL2,   GCSPR_EL1,   NULL             );
 		MAPPED_EL2_SYSREG(AMAIR_EL2,   AMAIR_EL1,   NULL	     );
 		MAPPED_EL2_SYSREG(ELR_EL2,     ELR_EL1,	    NULL	     );
 		MAPPED_EL2_SYSREG(SPSR_EL2,    SPSR_EL1,    NULL	     );
@@ -2654,6 +2656,21 @@ static unsigned int s1pie_el2_visibility(const struct kvm_vcpu *vcpu,
 	return __el2_visibility(vcpu, rd, s1pie_visibility);
 }
 
+static unsigned int gcs_visibility(const struct kvm_vcpu *vcpu,
+				   const struct sys_reg_desc *r)
+{
+	if (kvm_has_gcs(vcpu->kvm))
+		return 0;
+
+	return REG_HIDDEN;
+}
+
+static unsigned int gcs_el2_visibility(const struct kvm_vcpu *vcpu,
+				       const struct sys_reg_desc *rd)
+{
+	return __el2_visibility(vcpu, rd, gcs_visibility);
+}
+
 static bool access_mdcr(struct kvm_vcpu *vcpu,
 			struct sys_reg_params *p,
 			const struct sys_reg_desc *r)
@@ -2936,7 +2953,6 @@ static const struct sys_reg_desc sys_reg_descs[] = {
 				     ~(ID_AA64PFR1_EL1_PFAR |
 				       ID_AA64PFR1_EL1_MTEX |
 				       ID_AA64PFR1_EL1_THE |
-				       ID_AA64PFR1_EL1_GCS |
 				       ID_AA64PFR1_EL1_MTE_frac |
 				       ID_AA64PFR1_EL1_NMI |
 				       ID_AA64PFR1_EL1_RNDR_trap |
@@ -3048,6 +3064,13 @@ static const struct sys_reg_desc sys_reg_descs[] = {
 	PTRAUTH_KEY(APDB),
 	PTRAUTH_KEY(APGA),
 
+	{ SYS_DESC(SYS_GCSCR_EL1), NULL, reset_val, GCSCR_EL1, 0,
+	  .visibility = gcs_visibility },
+	{ SYS_DESC(SYS_GCSPR_EL1), NULL, reset_unknown, GCSPR_EL1,
+	  .visibility = gcs_visibility },
+	{ SYS_DESC(SYS_GCSCRE0_EL1), NULL, reset_val, GCSCRE0_EL1, 0,
+	  .visibility = gcs_visibility },
+
 	{ SYS_DESC(SYS_SPSR_EL1), access_spsr},
 	{ SYS_DESC(SYS_ELR_EL1), access_elr},
 
@@ -3162,6 +3185,8 @@ static const struct sys_reg_desc sys_reg_descs[] = {
 		    CTR_EL0_DminLine_MASK |
 		    CTR_EL0_L1Ip_MASK |
 		    CTR_EL0_IminLine_MASK),
+	{ SYS_DESC(SYS_GCSPR_EL0), NULL, reset_unknown, GCSPR_EL0,
+	  .visibility = gcs_visibility },
 	{ SYS_DESC(SYS_SVCR), undef_access, reset_val, SVCR, 0, .visibility = sme_visibility  },
 	{ SYS_DESC(SYS_FPMR), undef_access, reset_val, FPMR, 0, .visibility = fp8_visibility },
 
@@ -3401,6 +3426,10 @@ static const struct sys_reg_desc sys_reg_descs[] = {
 	EL2_REG_FILTERED(VNCR_EL2, bad_vncr_trap, reset_val, 0,
 			 vncr_el2_visibility),
 
+	EL2_REG_FILTERED(GCSCR_EL2, access_rw, reset_val, 0,
+			 gcs_el2_visibility),
+	EL2_REG_FILTERED(GCSPR_EL2, access_rw, reset_val, 0,
+			 gcs_el2_visibility),
 	{ SYS_DESC(SYS_DACR32_EL2), undef_access, reset_unknown, DACR32_EL2 },
 	EL2_REG_VNCR_FILT(HDFGRTR2_EL2, fgt2_visibility),
 	EL2_REG_VNCR_FILT(HDFGWTR2_EL2, fgt2_visibility),

-- 
2.39.5


