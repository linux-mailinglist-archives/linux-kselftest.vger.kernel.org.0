Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68251506A2A
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Apr 2022 13:26:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351267AbiDSL1I (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 19 Apr 2022 07:27:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351540AbiDSL05 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 19 Apr 2022 07:26:57 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15BA62B1B6
        for <linux-kselftest@vger.kernel.org>; Tue, 19 Apr 2022 04:23:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BF607B8184D
        for <linux-kselftest@vger.kernel.org>; Tue, 19 Apr 2022 11:23:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA24DC385AE;
        Tue, 19 Apr 2022 11:23:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650367427;
        bh=5+T+3GznUT4MTp4ZcrBbVBX7/NksI3onuv4PY+QPmRk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=shJxJQ9/WuJhocUst4uhnVfCPIHwR/PX2dImDnqjPvNuO/8/6vQd8JQHNMfjMk7F6
         9ZTRtGa/CEvXB3rvOzJoy2Ru6ivUW4iDJzZF0pZKZ19CtXLrZaDxokdvuNY9iu5AnR
         g8fEcSh0e8CV7Odji/iHeHl63XEsOOieilEc7w3xBMIyulIvYT+Kdn/753UJp6xV3L
         0KnYSuojNq8pr9l6MZRRBlh2I1YiOYDz6xx6vJ6zjdYDZoiPD1jP1V/NRfzY1xy/j1
         A5Ca4AfHuIcSbs0clN8hwFUIToFQogaBgiLXgYH2Kab3mjzosqAavGgsgGWI/Ubkmu
         VTFkbZyvlupYA==
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
Subject: [PATCH v14 05/39] arm64/sme: System register and exception syndrome definitions
Date:   Tue, 19 Apr 2022 12:22:13 +0100
Message-Id: <20220419112247.711548-6-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220419112247.711548-1-broonie@kernel.org>
References: <20220419112247.711548-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=9668; h=from:subject; bh=5+T+3GznUT4MTp4ZcrBbVBX7/NksI3onuv4PY+QPmRk=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBiXptsC4UDhAG7sC0Ha7FPWBfJVm1E/r8E+JfWtn3C xF7IEUaJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYl6bbAAKCRAk1otyXVSH0GrpB/ 4wHWubIFNd3cxDcZa6eH64uTpfY8TGf0ladum8D55fYHWpxV6Hbsyu6ZcCJ1wOBvwRq84ckBvrQID7 oPIZnjTJ5WezilGFcNeIX5pjFBIBPwkbuJdG1MQbjrBBZv45WBxnWnjVYHQrEobPfuIjzfKbJqyrDo xrC3XpU53A91StF3YAg6UbT8vrE8lOLpcSY5CAdGR1v/t9/BKmHHM7xpukFvj7by9miTLRRbLyogxx CzLJdDdoprl5r73LI0dTrD4Ie13kNuK1kwCRKNcqJicr85MWLRe2AVfD6KxkUDKtDuuaCIyZ4L3b7h BJbDbXkCB6dcMX/l5gFVIi12Rua/lY
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
index fbf5f8bb9055..bebfdd27296a 100644
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
@@ -181,6 +185,7 @@
 #define SYS_ID_AA64PFR0_EL1		sys_reg(3, 0, 0, 4, 0)
 #define SYS_ID_AA64PFR1_EL1		sys_reg(3, 0, 0, 4, 1)
 #define SYS_ID_AA64ZFR0_EL1		sys_reg(3, 0, 0, 4, 4)
+#define SYS_ID_AA64SMFR0_EL1		sys_reg(3, 0, 0, 4, 5)
 
 #define SYS_ID_AA64DFR0_EL1		sys_reg(3, 0, 0, 5, 0)
 #define SYS_ID_AA64DFR1_EL1		sys_reg(3, 0, 0, 5, 1)
@@ -204,6 +209,8 @@
 
 #define SYS_ZCR_EL1			sys_reg(3, 0, 1, 2, 0)
 #define SYS_TRFCR_EL1			sys_reg(3, 0, 1, 2, 1)
+#define SYS_SMPRI_EL1			sys_reg(3, 0, 1, 2, 4)
+#define SYS_SMCR_EL1			sys_reg(3, 0, 1, 2, 6)
 
 #define SYS_TTBR0_EL1			sys_reg(3, 0, 2, 0, 0)
 #define SYS_TTBR1_EL1			sys_reg(3, 0, 2, 0, 1)
@@ -396,6 +403,8 @@
 #define TRBIDR_ALIGN_MASK		GENMASK(3, 0)
 #define TRBIDR_ALIGN_SHIFT		0
 
+#define SMPRI_EL1_PRIORITY_MASK		0xf
+
 #define SYS_PMINTENSET_EL1		sys_reg(3, 0, 9, 14, 1)
 #define SYS_PMINTENCLR_EL1		sys_reg(3, 0, 9, 14, 2)
 
@@ -451,8 +460,13 @@
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
@@ -461,6 +475,10 @@
 #define SYS_RNDR_EL0			sys_reg(3, 3, 2, 4, 0)
 #define SYS_RNDRRS_EL0			sys_reg(3, 3, 2, 4, 1)
 
+#define SYS_SVCR_EL0			sys_reg(3, 3, 4, 2, 2)
+#define SYS_SVCR_EL0_ZA_MASK		2
+#define SYS_SVCR_EL0_SM_MASK		1
+
 #define SYS_PMCR_EL0			sys_reg(3, 3, 9, 12, 0)
 #define SYS_PMCNTENSET_EL0		sys_reg(3, 3, 9, 12, 1)
 #define SYS_PMCNTENCLR_EL0		sys_reg(3, 3, 9, 12, 2)
@@ -477,6 +495,7 @@
 
 #define SYS_TPIDR_EL0			sys_reg(3, 3, 13, 0, 2)
 #define SYS_TPIDRRO_EL0			sys_reg(3, 3, 13, 0, 3)
+#define SYS_TPIDR2_EL0			sys_reg(3, 3, 13, 0, 5)
 
 #define SYS_SCXTNUM_EL0			sys_reg(3, 3, 13, 0, 7)
 
@@ -546,6 +565,9 @@
 #define SYS_HFGITR_EL2			sys_reg(3, 4, 1, 1, 6)
 #define SYS_ZCR_EL2			sys_reg(3, 4, 1, 2, 0)
 #define SYS_TRFCR_EL2			sys_reg(3, 4, 1, 2, 1)
+#define SYS_HCRX_EL2			sys_reg(3, 4, 1, 2, 2)
+#define SYS_SMPRIMAP_EL2		sys_reg(3, 4, 1, 2, 5)
+#define SYS_SMCR_EL2			sys_reg(3, 4, 1, 2, 6)
 #define SYS_DACR32_EL2			sys_reg(3, 4, 3, 0, 0)
 #define SYS_HDFGRTR_EL2			sys_reg(3, 4, 3, 1, 4)
 #define SYS_HDFGWTR_EL2			sys_reg(3, 4, 3, 1, 5)
@@ -605,6 +627,7 @@
 #define SYS_SCTLR_EL12			sys_reg(3, 5, 1, 0, 0)
 #define SYS_CPACR_EL12			sys_reg(3, 5, 1, 0, 2)
 #define SYS_ZCR_EL12			sys_reg(3, 5, 1, 2, 0)
+#define SYS_SMCR_EL12			sys_reg(3, 5, 1, 2, 6)
 #define SYS_TTBR0_EL12			sys_reg(3, 5, 2, 0, 0)
 #define SYS_TTBR1_EL12			sys_reg(3, 5, 2, 0, 1)
 #define SYS_TCR_EL12			sys_reg(3, 5, 2, 0, 2)
@@ -628,6 +651,7 @@
 #define SYS_CNTV_CVAL_EL02		sys_reg(3, 5, 14, 3, 2)
 
 /* Common SCTLR_ELx flags. */
+#define SCTLR_ELx_ENTP2	(BIT(60))
 #define SCTLR_ELx_DSSBS	(BIT(44))
 #define SCTLR_ELx_ATA	(BIT(43))
 
@@ -836,6 +860,7 @@
 #define ID_AA64PFR0_ELx_32BIT_64BIT	0x2
 
 /* id_aa64pfr1 */
+#define ID_AA64PFR1_SME_SHIFT		24
 #define ID_AA64PFR1_MPAMFRAC_SHIFT	16
 #define ID_AA64PFR1_RASFRAC_SHIFT	12
 #define ID_AA64PFR1_MTE_SHIFT		8
@@ -846,6 +871,7 @@
 #define ID_AA64PFR1_SSBS_PSTATE_ONLY	1
 #define ID_AA64PFR1_SSBS_PSTATE_INSNS	2
 #define ID_AA64PFR1_BT_BTI		0x1
+#define ID_AA64PFR1_SME			1
 
 #define ID_AA64PFR1_MTE_NI		0x0
 #define ID_AA64PFR1_MTE_EL0		0x1
@@ -874,6 +900,23 @@
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
@@ -926,6 +969,7 @@
 
 /* id_aa64mmfr1 */
 #define ID_AA64MMFR1_ECBHB_SHIFT	60
+#define ID_AA64MMFR1_HCX_SHIFT		40
 #define ID_AA64MMFR1_AFP_SHIFT		44
 #define ID_AA64MMFR1_ETS_SHIFT		36
 #define ID_AA64MMFR1_TWED_SHIFT		32
@@ -1119,9 +1163,24 @@
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
 
@@ -1170,6 +1229,8 @@
 #define TRFCR_ELx_ExTRE			BIT(1)
 #define TRFCR_ELx_E0TRE			BIT(0)
 
+/* HCRX_EL2 definitions */
+#define HCRX_EL2_SMPME_MASK		(1 << 5)
 
 /* GIC Hypervisor interface registers */
 /* ICH_MISR_EL2 bit definitions */
@@ -1233,6 +1294,12 @@
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
index 0529fd57567e..6751621e5bea 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -821,6 +821,7 @@ static const char *esr_class_str[] = {
 	[ESR_ELx_EC_SVE]		= "SVE",
 	[ESR_ELx_EC_ERET]		= "ERET/ERETAA/ERETAB",
 	[ESR_ELx_EC_FPAC]		= "FPAC",
+	[ESR_ELx_EC_SME]		= "SME",
 	[ESR_ELx_EC_IMP_DEF]		= "EL3 IMP DEF",
 	[ESR_ELx_EC_IABT_LOW]		= "IABT (lower EL)",
 	[ESR_ELx_EC_IABT_CUR]		= "IABT (current EL)",
-- 
2.30.2

