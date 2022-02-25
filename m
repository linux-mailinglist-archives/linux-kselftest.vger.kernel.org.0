Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20A234C4C52
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Feb 2022 18:35:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242030AbiBYRf2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 25 Feb 2022 12:35:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243767AbiBYRfZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 25 Feb 2022 12:35:25 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3D381B1DC1
        for <linux-kselftest@vger.kernel.org>; Fri, 25 Feb 2022 09:34:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 43718B832CD
        for <linux-kselftest@vger.kernel.org>; Fri, 25 Feb 2022 17:34:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83A11C340F2;
        Fri, 25 Feb 2022 17:34:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645810489;
        bh=Gc0gUgV2lehHJCVTaAZ18CcKS0Bz6npKGWGO2NP1650=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Om1TqDcc8sb/tHRgnXcMN5zavJQlaKN7V1/E9Mvkv8Hb6Q1LVG572Co4+saJ0E1mP
         xO9/rZtp1+b/KCLhxsyNk4OT1cPz8FU4TZfPai9YmNXORWgAxhuK/KGUSJT2paWZnB
         fGjz5Hp8+HsDSoCeBwgxJhq6/GjthkwYfgvD6GduAemTp/3anqE543HInkhXDsARD/
         S46m7cL4n6mfFGjDODlqR3flnxFWsfC2l3dRiWMmj/Sb3x4RqqOl84gwknUcqz2xPq
         0y3zKYDLt4E1xQ6njDU6MmGx4b9eKu41g+9O7KeRrt6V4rcsHriYl2cGk7s+QmjSSg
         FV5McTOkekfpA==
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
Subject: [PATCH v12 07/40] arm64/sme: System register and exception syndrome definitions
Date:   Fri, 25 Feb 2022 16:58:50 +0000
Message-Id: <20220225165923.1474372-8-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220225165923.1474372-1-broonie@kernel.org>
References: <20220225165923.1474372-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=9639; h=from:subject; bh=Gc0gUgV2lehHJCVTaAZ18CcKS0Bz6npKGWGO2NP1650=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBiGQrPkabbV9T7pkFz7A6AhYX6Wxb7lbyIPkUcmwEe RH2mnQyJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYhkKzwAKCRAk1otyXVSH0J9mB/ 0cbS/w64P642ZZW1EqKvcxwRoW6+A7MVYfJuLXLeSjFkmx8HXcexdnMyp/OUX+7FUrZARsPPybGjwS o+nfQxOZpA0Xxg/EsW2xi738tuL2FxsK0bxQxppWynRD06NaEhChH3PB/mYf/8CC1IVxJukUJCEy97 rV+UKXM3qQSpvDEo8XxH3E8y+iIdlwYUMkqPvbNr+Iw9giyeW/gzOcUUAAGWaAaqXhQ0XfqEJCr1f7 WCUvhUPOtCVzyxmHWRxWBD/yBkEqlIoVcjFZpMjoq/hcqvCtJcVKF4Qu1OFblzhuO7MYQ+mJMm8aj1 GO9soUTyQQKboL6afivaqxgVIUzeUp
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

The arm64 Scalable Matrix Extension (SME) adds some new system registers,
fields in existing system registers and exception syndromes. This patch
adds definitions for these for use in future patches implementing support
for this extension.

Since SME will be the first user of FEAT_HCX in the kernel also include
the definitions for enumerating it and the HCRX system register it adds.

Signed-off-by: Mark Brown <broonie@kernel.org>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm64/include/asm/esr.h     | 12 +++++-
 arch/arm64/include/asm/kvm_arm.h |  1 +
 arch/arm64/include/asm/sysreg.h  | 67 ++++++++++++++++++++++++++++++++
 arch/arm64/kernel/traps.c        |  1 +
 4 files changed, 80 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/esr.h b/arch/arm64/include/asm/esr.h
index d52a0b269ee8..43872e0cfd1e 100644
--- a/arch/arm64/include/asm/esr.h
+++ b/arch/arm64/include/asm/esr.h
@@ -37,7 +37,8 @@
 #define ESR_ELx_EC_ERET		(0x1a)	/* EL2 only */
 /* Unallocated EC: 0x1B */
 #define ESR_ELx_EC_FPAC		(0x1C)	/* EL1 and above */
-/* Unallocated EC: 0x1D - 0x1E */
+#define ESR_ELx_EC_SME		(0x1D)
+/* Unallocated EC: 0x1E */
 #define ESR_ELx_EC_IMP_DEF	(0x1f)	/* EL3 only */
 #define ESR_ELx_EC_IABT_LOW	(0x20)
 #define ESR_ELx_EC_IABT_CUR	(0x21)
@@ -327,6 +328,15 @@
 #define ESR_ELx_CP15_32_ISS_SYS_CNTFRQ	(ESR_ELx_CP15_32_ISS_SYS_VAL(0, 0, 14, 0) |\
 					 ESR_ELx_CP15_32_ISS_DIR_READ)
 
+/*
+ * ISS values for SME traps
+ */
+
+#define ESR_ELx_SME_ISS_SME_DISABLED	0
+#define ESR_ELx_SME_ISS_ILL		1
+#define ESR_ELx_SME_ISS_SM_DISABLED	2
+#define ESR_ELx_SME_ISS_ZA_DISABLED	3
+
 #ifndef __ASSEMBLY__
 #include <asm/types.h>
 
diff --git a/arch/arm64/include/asm/kvm_arm.h b/arch/arm64/include/asm/kvm_arm.h
index 1767ded83888..13ae232ec4a1 100644
--- a/arch/arm64/include/asm/kvm_arm.h
+++ b/arch/arm64/include/asm/kvm_arm.h
@@ -279,6 +279,7 @@
 #define CPTR_EL2_TCPAC	(1U << 31)
 #define CPTR_EL2_TAM	(1 << 30)
 #define CPTR_EL2_TTA	(1 << 20)
+#define CPTR_EL2_TSM	(1 << 12)
 #define CPTR_EL2_TFP	(1 << CPTR_EL2_TFP_SHIFT)
 #define CPTR_EL2_TZ	(1 << 8)
 #define CPTR_NVHE_EL2_RES1	0x000032ff /* known RES1 bits in CPTR_EL2 (nVHE) */
diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index e66dd9ebc337..77d1d4cd8e2f 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -118,6 +118,10 @@
  * System registers, organised loosely by encoding but grouped together
  * where the architected name contains an index. e.g. ID_MMFR<n>_EL1.
  */
+#define SYS_SVCR_SMSTOP_SM_EL0		sys_reg(0, 3, 4, 2, 3)
+#define SYS_SVCR_SMSTART_SM_EL0		sys_reg(0, 3, 4, 3, 3)
+#define SYS_SVCR_SMSTOP_SMZA_EL0	sys_reg(0, 3, 4, 6, 3)
+
 #define SYS_OSDTRRX_EL1			sys_reg(2, 0, 0, 0, 2)
 #define SYS_MDCCINT_EL1			sys_reg(2, 0, 0, 2, 0)
 #define SYS_MDSCR_EL1			sys_reg(2, 0, 0, 2, 2)
@@ -173,6 +177,7 @@
 #define SYS_ID_AA64PFR0_EL1		sys_reg(3, 0, 0, 4, 0)
 #define SYS_ID_AA64PFR1_EL1		sys_reg(3, 0, 0, 4, 1)
 #define SYS_ID_AA64ZFR0_EL1		sys_reg(3, 0, 0, 4, 4)
+#define SYS_ID_AA64SMFR0_EL1		sys_reg(3, 0, 0, 4, 5)
 
 #define SYS_ID_AA64DFR0_EL1		sys_reg(3, 0, 0, 5, 0)
 #define SYS_ID_AA64DFR1_EL1		sys_reg(3, 0, 0, 5, 1)
@@ -196,6 +201,8 @@
 
 #define SYS_ZCR_EL1			sys_reg(3, 0, 1, 2, 0)
 #define SYS_TRFCR_EL1			sys_reg(3, 0, 1, 2, 1)
+#define SYS_SMPRI_EL1			sys_reg(3, 0, 1, 2, 4)
+#define SYS_SMCR_EL1			sys_reg(3, 0, 1, 2, 6)
 
 #define SYS_TTBR0_EL1			sys_reg(3, 0, 2, 0, 0)
 #define SYS_TTBR1_EL1			sys_reg(3, 0, 2, 0, 1)
@@ -388,6 +395,8 @@
 #define TRBIDR_ALIGN_MASK		GENMASK(3, 0)
 #define TRBIDR_ALIGN_SHIFT		0
 
+#define SMPRI_EL1_PRIORITY_MASK		0xf
+
 #define SYS_PMINTENSET_EL1		sys_reg(3, 0, 9, 14, 1)
 #define SYS_PMINTENCLR_EL1		sys_reg(3, 0, 9, 14, 2)
 
@@ -443,8 +452,13 @@
 #define SYS_CCSIDR_EL1			sys_reg(3, 1, 0, 0, 0)
 #define SYS_CLIDR_EL1			sys_reg(3, 1, 0, 0, 1)
 #define SYS_GMID_EL1			sys_reg(3, 1, 0, 0, 4)
+#define SYS_SMIDR_EL1			sys_reg(3, 1, 0, 0, 6)
 #define SYS_AIDR_EL1			sys_reg(3, 1, 0, 0, 7)
 
+#define SYS_SMIDR_EL1_IMPLEMENTER_SHIFT	24
+#define SYS_SMIDR_EL1_SMPS_SHIFT	15
+#define SYS_SMIDR_EL1_AFFINITY_SHIFT	0
+
 #define SYS_CSSELR_EL1			sys_reg(3, 2, 0, 0, 0)
 
 #define SYS_CTR_EL0			sys_reg(3, 3, 0, 0, 1)
@@ -453,6 +467,10 @@
 #define SYS_RNDR_EL0			sys_reg(3, 3, 2, 4, 0)
 #define SYS_RNDRRS_EL0			sys_reg(3, 3, 2, 4, 1)
 
+#define SYS_SVCR_EL0			sys_reg(3, 3, 4, 2, 2)
+#define SYS_SVCR_EL0_ZA_MASK		2
+#define SYS_SVCR_EL0_SM_MASK		1
+
 #define SYS_PMCR_EL0			sys_reg(3, 3, 9, 12, 0)
 #define SYS_PMCNTENSET_EL0		sys_reg(3, 3, 9, 12, 1)
 #define SYS_PMCNTENCLR_EL0		sys_reg(3, 3, 9, 12, 2)
@@ -469,6 +487,7 @@
 
 #define SYS_TPIDR_EL0			sys_reg(3, 3, 13, 0, 2)
 #define SYS_TPIDRRO_EL0			sys_reg(3, 3, 13, 0, 3)
+#define SYS_TPIDR2_EL0			sys_reg(3, 3, 13, 0, 5)
 
 #define SYS_SCXTNUM_EL0			sys_reg(3, 3, 13, 0, 7)
 
@@ -538,6 +557,9 @@
 #define SYS_HFGITR_EL2			sys_reg(3, 4, 1, 1, 6)
 #define SYS_ZCR_EL2			sys_reg(3, 4, 1, 2, 0)
 #define SYS_TRFCR_EL2			sys_reg(3, 4, 1, 2, 1)
+#define SYS_HCRX_EL2			sys_reg(3, 4, 1, 2, 2)
+#define SYS_SMPRIMAP_EL2		sys_reg(3, 4, 1, 2, 5)
+#define SYS_SMCR_EL2			sys_reg(3, 4, 1, 2, 6)
 #define SYS_DACR32_EL2			sys_reg(3, 4, 3, 0, 0)
 #define SYS_HDFGRTR_EL2			sys_reg(3, 4, 3, 1, 4)
 #define SYS_HDFGWTR_EL2			sys_reg(3, 4, 3, 1, 5)
@@ -597,6 +619,7 @@
 #define SYS_SCTLR_EL12			sys_reg(3, 5, 1, 0, 0)
 #define SYS_CPACR_EL12			sys_reg(3, 5, 1, 0, 2)
 #define SYS_ZCR_EL12			sys_reg(3, 5, 1, 2, 0)
+#define SYS_SMCR_EL12			sys_reg(3, 5, 1, 2, 6)
 #define SYS_TTBR0_EL12			sys_reg(3, 5, 2, 0, 0)
 #define SYS_TTBR1_EL12			sys_reg(3, 5, 2, 0, 1)
 #define SYS_TCR_EL12			sys_reg(3, 5, 2, 0, 2)
@@ -620,6 +643,7 @@
 #define SYS_CNTV_CVAL_EL02		sys_reg(3, 5, 14, 3, 2)
 
 /* Common SCTLR_ELx flags. */
+#define SCTLR_ELx_ENTP2	(BIT(60))
 #define SCTLR_ELx_DSSBS	(BIT(44))
 #define SCTLR_ELx_ATA	(BIT(43))
 
@@ -815,6 +839,7 @@
 #define ID_AA64PFR0_ELx_32BIT_64BIT	0x2
 
 /* id_aa64pfr1 */
+#define ID_AA64PFR1_SME_SHIFT		24
 #define ID_AA64PFR1_MPAMFRAC_SHIFT	16
 #define ID_AA64PFR1_RASFRAC_SHIFT	12
 #define ID_AA64PFR1_MTE_SHIFT		8
@@ -825,6 +850,7 @@
 #define ID_AA64PFR1_SSBS_PSTATE_ONLY	1
 #define ID_AA64PFR1_SSBS_PSTATE_INSNS	2
 #define ID_AA64PFR1_BT_BTI		0x1
+#define ID_AA64PFR1_SME			1
 
 #define ID_AA64PFR1_MTE_NI		0x0
 #define ID_AA64PFR1_MTE_EL0		0x1
@@ -853,6 +879,23 @@
 #define ID_AA64ZFR0_AES_PMULL		0x2
 #define ID_AA64ZFR0_SVEVER_SVE2		0x1
 
+/* id_aa64smfr0 */
+#define ID_AA64SMFR0_FA64_SHIFT		63
+#define ID_AA64SMFR0_I16I64_SHIFT	52
+#define ID_AA64SMFR0_F64F64_SHIFT	48
+#define ID_AA64SMFR0_I8I32_SHIFT	36
+#define ID_AA64SMFR0_F16F32_SHIFT	35
+#define ID_AA64SMFR0_B16F32_SHIFT	34
+#define ID_AA64SMFR0_F32F32_SHIFT	32
+
+#define ID_AA64SMFR0_FA64		0x1
+#define ID_AA64SMFR0_I16I64		0x4
+#define ID_AA64SMFR0_F64F64		0x1
+#define ID_AA64SMFR0_I8I32		0x4
+#define ID_AA64SMFR0_F16F32		0x1
+#define ID_AA64SMFR0_B16F32		0x1
+#define ID_AA64SMFR0_F32F32		0x1
+
 /* id_aa64mmfr0 */
 #define ID_AA64MMFR0_ECV_SHIFT		60
 #define ID_AA64MMFR0_FGT_SHIFT		56
@@ -904,6 +947,7 @@
 #endif
 
 /* id_aa64mmfr1 */
+#define ID_AA64MMFR1_HCX_SHIFT		40
 #define ID_AA64MMFR1_AFP_SHIFT		44
 #define ID_AA64MMFR1_ETS_SHIFT		36
 #define ID_AA64MMFR1_TWED_SHIFT		32
@@ -1097,9 +1141,24 @@
 #define ZCR_ELx_LEN_SIZE	9
 #define ZCR_ELx_LEN_MASK	0x1ff
 
+#define SMCR_ELx_FA64_SHIFT	31
+#define SMCR_ELx_FA64_MASK	(1 << SMCR_ELx_FA64_SHIFT)
+
+/*
+ * The SMCR_ELx_LEN_* definitions intentionally include bits [8:4] which
+ * are reserved by the SME architecture for future expansion of the LEN
+ * field, with compatible semantics.
+ */
+#define SMCR_ELx_LEN_SHIFT	0
+#define SMCR_ELx_LEN_SIZE	9
+#define SMCR_ELx_LEN_MASK	0x1ff
+
 #define CPACR_EL1_FPEN_EL1EN	(BIT(20)) /* enable EL1 access */
 #define CPACR_EL1_FPEN_EL0EN	(BIT(21)) /* enable EL0 access, if EL1EN set */
 
+#define CPACR_EL1_SMEN_EL1EN	(BIT(24)) /* enable EL1 access */
+#define CPACR_EL1_SMEN_EL0EN	(BIT(25)) /* enable EL0 access, if EL1EN set */
+
 #define CPACR_EL1_ZEN_EL1EN	(BIT(16)) /* enable EL1 access */
 #define CPACR_EL1_ZEN_EL0EN	(BIT(17)) /* enable EL0 access, if EL1EN set */
 
@@ -1152,6 +1211,8 @@
 #define TRFCR_ELx_ExTRE			BIT(1)
 #define TRFCR_ELx_E0TRE			BIT(0)
 
+/* HCRX_EL2 definitions */
+#define HCRX_EL2_SMPME_MASK		(1 << 5)
 
 /* GIC Hypervisor interface registers */
 /* ICH_MISR_EL2 bit definitions */
@@ -1215,6 +1276,12 @@
 #define ICH_VTR_TDS_SHIFT	19
 #define ICH_VTR_TDS_MASK	(1 << ICH_VTR_TDS_SHIFT)
 
+/* HFG[WR]TR_EL2 bit definitions */
+#define HFGxTR_EL2_nTPIDR2_EL0_SHIFT	55
+#define HFGxTR_EL2_nTPIDR2_EL0_MASK	BIT_MASK(HFGxTR_EL2_nTPIDR2_EL0_SHIFT)
+#define HFGxTR_EL2_nSMPRI_EL1_SHIFT	54
+#define HFGxTR_EL2_nSMPRI_EL1_MASK	BIT_MASK(HFGxTR_EL2_nSMPRI_EL1_SHIFT)
+
 #define ARM64_FEATURE_FIELD_BITS	4
 
 /* Create a mask for the feature bits of the specified feature. */
diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index 70fc42470f13..88effb25c399 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -822,6 +822,7 @@ static const char *esr_class_str[] = {
 	[ESR_ELx_EC_SVE]		= "SVE",
 	[ESR_ELx_EC_ERET]		= "ERET/ERETAA/ERETAB",
 	[ESR_ELx_EC_FPAC]		= "FPAC",
+	[ESR_ELx_EC_SME]		= "SME",
 	[ESR_ELx_EC_IMP_DEF]		= "EL3 IMP DEF",
 	[ESR_ELx_EC_IABT_LOW]		= "IABT (lower EL)",
 	[ESR_ELx_EC_IABT_CUR]		= "IABT (current EL)",
-- 
2.30.2

