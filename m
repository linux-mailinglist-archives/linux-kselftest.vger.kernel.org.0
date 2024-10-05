Return-Path: <linux-kselftest+bounces-19103-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44BA899162B
	for <lists+linux-kselftest@lfdr.de>; Sat,  5 Oct 2024 12:38:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB6C01F2475E
	for <lists+linux-kselftest@lfdr.de>; Sat,  5 Oct 2024 10:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 153531509BF;
	Sat,  5 Oct 2024 10:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YAwCRfHd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCCCB149DF4;
	Sat,  5 Oct 2024 10:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728124677; cv=none; b=of+pBcTDuBN9ljuoAdsvdCtDw4HRYt6xlnTZtuTviBKoS2AvgMTHAnJ4hz4qD/K5pbgOMyYyrGjoVn9zC7D/aUX/oxHOpBA5ZiuWL++s14GS0bV6BJ4DipE5MLUC7hAzgZugSxOutdLSdNfjkmzLOlGspf3x8liis0uiZ7nvyaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728124677; c=relaxed/simple;
	bh=dzX0F6AkcdLZYT5mpocXi/GY4x2mPuF9cmobEMLRggA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Vr7q3DMo1+DEf/tyR9Z/Pd7riOfbbsoaO2PGgCCPyfZeprZuNEXmm9gHPBsPmJezDYPESPgeAC1P6pXHcyqKJMjNq499lXvpBKAHvh3RNRdub0fkX7qJWdcRnokVoA6dHoX9tXJ5cWYrT6JCJ1eRKZIXR7geGe5SqbhfX36pFw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YAwCRfHd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FFE7C4CECC;
	Sat,  5 Oct 2024 10:37:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728124676;
	bh=dzX0F6AkcdLZYT5mpocXi/GY4x2mPuF9cmobEMLRggA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=YAwCRfHdNOg0sMHndi8ixDMIeWqSvh2+SJmTQyHHEScnn5LBrs/NlM6YUYhZunA4R
	 +Mi7wIoz2lV5pHO/ZAHEwTcp8FjBbEFDAia6DTkG5XSu5XDXxjNatCD79veo8ovLNA
	 gRBwoCgzo5Y0CJ+NnmJ0avIwCRMstrR+JYBw8cY6atdFtDQm9jttj4Q+tuQkLIVMzB
	 OZGd8sB2aauE6DZpPsuPBgCNXtyM+0SRV2H+vkjfN/oA1yY7QecomCkuP7fKuOwmah
	 CygxV7uGuDWFq7fwVY18W61XJNaSjH0B5mw0ZrCjiUJXkh/dCpzyWRBVN5ulqoZkOl
	 2oSrShERUHGTw==
From: Mark Brown <broonie@kernel.org>
Date: Sat, 05 Oct 2024 11:37:30 +0100
Subject: [PATCH v14 3/5] KVM: arm64: Manage GCS access and registers for
 guests
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241005-arm64-gcs-v14-3-59060cd6092b@kernel.org>
References: <20241005-arm64-gcs-v14-0-59060cd6092b@kernel.org>
In-Reply-To: <20241005-arm64-gcs-v14-0-59060cd6092b@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, 
 Oliver Upton <oliver.upton@linux.dev>, Joey Gouly <joey.gouly@arm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, Shuah Khan <shuah@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, 
 kvmarm@lists.linux.dev, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-9b746
X-Developer-Signature: v=1; a=openpgp-sha256; l=8836; i=broonie@kernel.org;
 h=from:subject:message-id; bh=dzX0F6AkcdLZYT5mpocXi/GY4x2mPuF9cmobEMLRggA=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBnARb2lQ6Qnt7ZiWaHHFmsh/ZOmgb9W5Q7C7sibDJa
 e9SyCJSJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZwEW9gAKCRAk1otyXVSH0Aw0B/
 9p00D662X983Uc3hA/Z7Y9PuwjrekynLAB4kqlvf5lv64bpIvazAPegeYEIigTOUYjJhqlA9mMScdK
 ER+lOfSYmvatW/E7F6s3opDOdMUFU4VGcwTkaXChlih4y865dez0nN8kduBPg3u9lXSL/Kxl4QXXyy
 1/YJ77lDaBwOCLN33fvVedNSll4ooXPXeakYzA0oim1CRmlaSm5O7ygdJHojFI0P0L5MMRylEuKT6k
 GJGtVppZ/hmls6OjESObLzCA4cTeEieERXRtNu+17/GM6UA216e4kS4QwFVw9xUYbNrB44Ib6Sugc1
 jPW0q0rlnc6VJSkPC8sO07JT56Vu1a
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
 arch/arm64/include/asm/kvm_host.h          | 12 ++++++++++++
 arch/arm64/include/asm/vncr_mapping.h      |  2 ++
 arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h | 31 ++++++++++++++++++++++++++++++
 arch/arm64/kvm/sys_regs.c                  | 31 +++++++++++++++++++++++++++++-
 4 files changed, 75 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 329619c6fa9611b474dc4823fccf01a3b9dd61a8..31887d3f3de18bf1936ce4329256894f6210c67e 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -448,6 +448,10 @@ enum vcpu_sysreg {
 
 	POR_EL0,	/* Permission Overlay Register 0 (EL0) */
 
+	/* Guarded Control Stack registers */
+	GCSCRE0_EL1,	/* Guarded Control Stack Control (EL0) */
+	GCSPR_EL0,	/* Guarded Control Stack Pointer (EL0) */
+
 	/* FP/SIMD/SVE */
 	SVCR,
 	FPMR,
@@ -525,6 +529,10 @@ enum vcpu_sysreg {
 
 	VNCR(POR_EL1),	/* Permission Overlay Register 1 (EL1) */
 
+	/* Guarded Control Stack registers */
+	VNCR(GCSPR_EL1),	/* Guarded Control Stack Pointer (EL1) */
+	VNCR(GCSCR_EL1),	/* Guarded Control Stack Control (EL1) */
+
 	VNCR(HFGRTR_EL2),
 	VNCR(HFGWTR_EL2),
 	VNCR(HFGITR_EL2),
@@ -1495,4 +1503,8 @@ void kvm_set_vm_id_reg(struct kvm *kvm, u32 reg, u64 val);
 	(system_supports_fpmr() &&			\
 	 kvm_has_feat((k), ID_AA64PFR2_EL1, FPMR, IMP))
 
+#define kvm_has_gcs(k) 					\
+	(system_supports_gcs() &&			\
+	 kvm_has_feat((k), ID_AA64PFR1_EL1, GCS, IMP))
+
 #endif /* __ARM64_KVM_HOST_H__ */
diff --git a/arch/arm64/include/asm/vncr_mapping.h b/arch/arm64/include/asm/vncr_mapping.h
index 06f8ec0906a6e92b6dd57c692e1293ac3d4244fd..e289064148b3268a00830c6fee708029c4c0fbbb 100644
--- a/arch/arm64/include/asm/vncr_mapping.h
+++ b/arch/arm64/include/asm/vncr_mapping.h
@@ -89,6 +89,8 @@
 #define VNCR_PMSIRR_EL1         0x840
 #define VNCR_PMSLATFR_EL1       0x848
 #define VNCR_TRFCR_EL1          0x880
+#define VNCR_GCSPR_EL1		0x8C0
+#define VNCR_GCSCR_EL1		0x8D0
 #define VNCR_MPAM1_EL1          0x900
 #define VNCR_MPAMHCR_EL2        0x930
 #define VNCR_MPAMVPMV_EL2       0x938
diff --git a/arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h b/arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h
index 1579a3c08a36b989fec7fdc3f38b64cb498326f3..70bd6143083439d75387eccc17f5c3811c689047 100644
--- a/arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h
+++ b/arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h
@@ -17,6 +17,7 @@
 #include <asm/kvm_mmu.h>
 
 static inline bool ctxt_has_s1poe(struct kvm_cpu_context *ctxt);
+static inline bool ctxt_has_gcs(struct kvm_cpu_context *ctxt);
 
 static inline void __sysreg_save_common_state(struct kvm_cpu_context *ctxt)
 {
@@ -31,6 +32,11 @@ static inline void __sysreg_save_user_state(struct kvm_cpu_context *ctxt)
 {
 	ctxt_sys_reg(ctxt, TPIDR_EL0)	= read_sysreg(tpidr_el0);
 	ctxt_sys_reg(ctxt, TPIDRRO_EL0)	= read_sysreg(tpidrro_el0);
+
+	if (ctxt_has_gcs(ctxt)) {
+		ctxt_sys_reg(ctxt, GCSPR_EL0) = read_sysreg_s(SYS_GCSPR_EL0);
+		ctxt_sys_reg(ctxt, GCSCRE0_EL1)	= read_sysreg_s(SYS_GCSCRE0_EL1);
+	}
 }
 
 static inline struct kvm_vcpu *ctxt_to_vcpu(struct kvm_cpu_context *ctxt)
@@ -83,6 +89,17 @@ static inline bool ctxt_has_s1poe(struct kvm_cpu_context *ctxt)
 	return kvm_has_feat(kern_hyp_va(vcpu->kvm), ID_AA64MMFR3_EL1, S1POE, IMP);
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
@@ -96,6 +113,10 @@ static inline void __sysreg_save_el1_state(struct kvm_cpu_context *ctxt)
 		if (ctxt_has_s1pie(ctxt)) {
 			ctxt_sys_reg(ctxt, PIR_EL1)	= read_sysreg_el1(SYS_PIR);
 			ctxt_sys_reg(ctxt, PIRE0_EL1)	= read_sysreg_el1(SYS_PIRE0);
+			if (ctxt_has_gcs(ctxt)) {
+				ctxt_sys_reg(ctxt, GCSPR_EL1)	= read_sysreg_el1(SYS_GCSPR);
+				ctxt_sys_reg(ctxt, GCSCR_EL1)	= read_sysreg_el1(SYS_GCSCR);
+			}
 		}
 
 		if (ctxt_has_s1poe(ctxt))
@@ -150,6 +171,11 @@ static inline void __sysreg_restore_user_state(struct kvm_cpu_context *ctxt)
 {
 	write_sysreg(ctxt_sys_reg(ctxt, TPIDR_EL0),	tpidr_el0);
 	write_sysreg(ctxt_sys_reg(ctxt, TPIDRRO_EL0),	tpidrro_el0);
+	if (ctxt_has_gcs(ctxt)) {
+		write_sysreg_s(ctxt_sys_reg(ctxt, GCSPR_EL0), SYS_GCSPR_EL0);
+		write_sysreg_s(ctxt_sys_reg(ctxt, GCSCRE0_EL1),
+			       SYS_GCSCRE0_EL1);
+	}
 }
 
 static inline void __sysreg_restore_el1_state(struct kvm_cpu_context *ctxt)
@@ -181,6 +207,11 @@ static inline void __sysreg_restore_el1_state(struct kvm_cpu_context *ctxt)
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
diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index d48f89ad6aa7139078e7991ce6c8ebc4a0543551..0d0c400ce15f0db2ffbe71d310eee6dbc2280429 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -1642,6 +1642,15 @@ static unsigned int raz_visibility(const struct kvm_vcpu *vcpu,
 	return REG_RAZ;
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
 /* cpufeature ID register access trap handlers */
 
 static bool access_id_reg(struct kvm_vcpu *vcpu,
@@ -2377,7 +2386,7 @@ static const struct sys_reg_desc sys_reg_descs[] = {
 		   ID_AA64PFR0_EL1_RAS |
 		   ID_AA64PFR0_EL1_AdvSIMD |
 		   ID_AA64PFR0_EL1_FP), },
-	ID_SANITISED(ID_AA64PFR1_EL1),
+	ID_WRITABLE(ID_AA64PFR1_EL1, ID_AA64PFR1_EL1_GCS),
 	ID_WRITABLE(ID_AA64PFR2_EL1, ID_AA64PFR2_EL1_FPMR),
 	ID_UNALLOCATED(4,3),
 	ID_WRITABLE(ID_AA64ZFR0_EL1, ~ID_AA64ZFR0_EL1_RES0),
@@ -2463,6 +2472,13 @@ static const struct sys_reg_desc sys_reg_descs[] = {
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
 
@@ -2569,6 +2585,8 @@ static const struct sys_reg_desc sys_reg_descs[] = {
 			     CTR_EL0_IDC_MASK |
 			     CTR_EL0_DminLine_MASK |
 			     CTR_EL0_IminLine_MASK),
+	{ SYS_DESC(SYS_GCSPR_EL0), NULL, reset_unknown, GCSPR_EL0,
+	  .visibility = gcs_visibility },
 	{ SYS_DESC(SYS_SVCR), undef_access, reset_val, SVCR, 0, .visibility = sme_visibility  },
 	{ SYS_DESC(SYS_FPMR), undef_access, reset_val, FPMR, 0, .visibility = fp8_visibility },
 
@@ -4663,6 +4681,9 @@ void kvm_calculate_traps(struct kvm_vcpu *vcpu)
 
 		if (kvm_has_fpmr(kvm))
 			vcpu->arch.hcrx_el2 |= HCRX_EL2_EnFPM;
+
+		if (kvm_has_gcs(kvm))
+			vcpu->arch.hcrx_el2 |= HCRX_EL2_GCSEn;
 	}
 
 	if (test_bit(KVM_ARCH_FLAG_FGU_INITIALIZED, &kvm->arch.flags))
@@ -4716,6 +4737,14 @@ void kvm_calculate_traps(struct kvm_vcpu *vcpu)
 		kvm->arch.fgu[HFGxTR_GROUP] |= (HFGxTR_EL2_nPOR_EL1 |
 						HFGxTR_EL2_nPOR_EL0);
 
+	if (!kvm_has_gcs(kvm)) {
+		kvm->arch.fgu[HFGxTR_GROUP] |= (HFGxTR_EL2_nGCS_EL0 |
+						HFGxTR_EL2_nGCS_EL1);
+		kvm->arch.fgu[HFGITR_GROUP] |= (HFGITR_EL2_nGCSEPP |
+						HFGITR_EL2_nGCSSTR_EL1 |
+						HFGITR_EL2_nGCSPUSHM_EL1);
+	}
+
 	if (!kvm_has_feat(kvm, ID_AA64PFR0_EL1, AMU, IMP))
 		kvm->arch.fgu[HAFGRTR_GROUP] |= ~(HAFGRTR_EL2_RES0 |
 						  HAFGRTR_EL2_RES1);

-- 
2.39.2


