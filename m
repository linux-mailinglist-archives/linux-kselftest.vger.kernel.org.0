Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6052845084D
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Nov 2021 16:29:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236614AbhKOPcb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 15 Nov 2021 10:32:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:52278 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236500AbhKOPcT (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 15 Nov 2021 10:32:19 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 958186322D;
        Mon, 15 Nov 2021 15:29:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636990162;
        bh=f5n1TsPixB4+4OIX1WMAI5WWPXhWMkcXz0KmtgFs79o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VXLyLPSo/8OMSga+KqWoSoyguZfhmz1CS4xTZ89j/f8FWIhynWcNhxvO6soQv1Xg0
         yX8GsV+Jyzxzg9maqidTDSdLrz9fvM/vL6v95b8YwGfqHRoHE4YiOJlQNAUpfktcKA
         WdRX1BoKHJgMrBzx2MmOonyIB2mfHioTsD9GGWSCMaOa9rjWfo0PW9Xy8Li0TnO8Mu
         1jS0asY6yR6EEbBSWSBKh+TcZd+8E+2mwsZ/FCDscLlhj3WaS9kC+UUxMaXmLsggSZ
         qpG4hZkQQoYFNpebLTDhqA0z7VsTh5+yFkgQuseq9DpFnNzDt6SSG0/Gtle5GRo/qk
         QyxEjcHQXq1Hg==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     Alan Hayward <alan.hayward@arm.com>,
        Luis Machado <luis.machado@arm.com>,
        Salil Akerkar <Salil.Akerkar@arm.com>,
        Basant Kumar Dwivedi <Basant.KumarDwivedi@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH v6 10/37] arm64/sme: System register and exception syndrome definitions
Date:   Mon, 15 Nov 2021 15:28:08 +0000
Message-Id: <20211115152835.3212149-11-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211115152835.3212149-1-broonie@kernel.org>
References: <20211115152835.3212149-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8581; h=from:subject; bh=f5n1TsPixB4+4OIX1WMAI5WWPXhWMkcXz0KmtgFs79o=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBhknyMYqyhS5SKz/NIFMqYu15LDoCG3cASMS4MjDhA O8JIZUuJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYZJ8jAAKCRAk1otyXVSH0HERB/ wI6vfBJwYOlNflqmsN8mOU4ZsFHrGy9NdgTOsxGIDPAsYoXPqG3HmozuWCkbTFLdhY6jvRI1hlI1LY uSTEWtEA46fGmo/JyX93o5lRo4c+lOYh4Q4/mr4nJiu0IpodljY9sit1AZJL0rCj4z75mlOpRpbatm KYUd8bfEgZMMb+VJPqbX+cXDWB633ghDOqc9yF891cO/MSZGRjRqd495goA3BibL/+ItnbN1fMj5Bq YuCVefBw3AA88O5tb9oyAQcAzQDQ/1oUuEskpmbeQsdhDnYjxwglIqeqTbnbgKQDdFBetcHXLyEwca KVxJ12gwYstnHn//lP+zuDzuA7lhsR
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
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
---
 arch/arm64/include/asm/esr.h     | 12 ++++++-
 arch/arm64/include/asm/kvm_arm.h |  1 +
 arch/arm64/include/asm/sysreg.h  | 58 ++++++++++++++++++++++++++++++++
 arch/arm64/kernel/traps.c        |  1 +
 4 files changed, 71 insertions(+), 1 deletion(-)

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
index a39fcf318c77..0400b3f895ef 100644
--- a/arch/arm64/include/asm/kvm_arm.h
+++ b/arch/arm64/include/asm/kvm_arm.h
@@ -279,6 +279,7 @@
 #define CPTR_EL2_TCPAC	(1 << 31)
 #define CPTR_EL2_TAM	(1 << 30)
 #define CPTR_EL2_TTA	(1 << 20)
+#define CPTR_EL2_TSM	(1 << 12)
 #define CPTR_EL2_TFP	(1 << CPTR_EL2_TFP_SHIFT)
 #define CPTR_EL2_TZ	(1 << 8)
 #define CPTR_NVHE_EL2_RES1	0x000032ff /* known RES1 bits in CPTR_EL2 (nVHE) */
diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index 16b3f1a1d468..3b767c84a480 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -173,6 +173,7 @@
 #define SYS_ID_AA64PFR0_EL1		sys_reg(3, 0, 0, 4, 0)
 #define SYS_ID_AA64PFR1_EL1		sys_reg(3, 0, 0, 4, 1)
 #define SYS_ID_AA64ZFR0_EL1		sys_reg(3, 0, 0, 4, 4)
+#define SYS_ID_AA64SMFR0_EL1		sys_reg(3, 0, 0, 4, 5)
 
 #define SYS_ID_AA64DFR0_EL1		sys_reg(3, 0, 0, 5, 0)
 #define SYS_ID_AA64DFR1_EL1		sys_reg(3, 0, 0, 5, 1)
@@ -195,6 +196,8 @@
 
 #define SYS_ZCR_EL1			sys_reg(3, 0, 1, 2, 0)
 #define SYS_TRFCR_EL1			sys_reg(3, 0, 1, 2, 1)
+#define SYS_SMPRI_EL1			sys_reg(3, 0, 1, 2, 4)
+#define SYS_SMCR_EL1			sys_reg(3, 0, 1, 2, 6)
 
 #define SYS_TTBR0_EL1			sys_reg(3, 0, 2, 0, 0)
 #define SYS_TTBR1_EL1			sys_reg(3, 0, 2, 0, 1)
@@ -387,6 +390,8 @@
 #define TRBIDR_ALIGN_MASK		GENMASK(3, 0)
 #define TRBIDR_ALIGN_SHIFT		0
 
+#define SMPRI_EL1_PRIORITY_MASK		0xf
+
 #define SYS_PMINTENSET_EL1		sys_reg(3, 0, 9, 14, 1)
 #define SYS_PMINTENCLR_EL1		sys_reg(3, 0, 9, 14, 2)
 
@@ -442,8 +447,13 @@
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
@@ -452,6 +462,10 @@
 #define SYS_RNDR_EL0			sys_reg(3, 3, 2, 4, 0)
 #define SYS_RNDRRS_EL0			sys_reg(3, 3, 2, 4, 1)
 
+#define SYS_SVCR_EL0			sys_reg(3, 3, 4, 2, 2)
+#define SYS_SVCR_EL0_ZA_MASK		2
+#define SYS_SVCR_EL0_SM_MASK		1
+
 #define SYS_PMCR_EL0			sys_reg(3, 3, 9, 12, 0)
 #define SYS_PMCNTENSET_EL0		sys_reg(3, 3, 9, 12, 1)
 #define SYS_PMCNTENCLR_EL0		sys_reg(3, 3, 9, 12, 2)
@@ -468,6 +482,7 @@
 
 #define SYS_TPIDR_EL0			sys_reg(3, 3, 13, 0, 2)
 #define SYS_TPIDRRO_EL0			sys_reg(3, 3, 13, 0, 3)
+#define SYS_TPIDR2_EL0			sys_reg(3, 3, 13, 0, 5)
 
 #define SYS_SCXTNUM_EL0			sys_reg(3, 3, 13, 0, 7)
 
@@ -537,6 +552,9 @@
 #define SYS_HFGITR_EL2			sys_reg(3, 4, 1, 1, 6)
 #define SYS_ZCR_EL2			sys_reg(3, 4, 1, 2, 0)
 #define SYS_TRFCR_EL2			sys_reg(3, 4, 1, 2, 1)
+#define SYS_HCRX_EL2			sys_reg(3, 4, 1, 2, 2)
+#define SYS_SMPRIMAP_EL2		sys_reg(3, 4, 1, 2, 5)
+#define SYS_SMCR_EL2			sys_reg(3, 4, 1, 2, 6)
 #define SYS_DACR32_EL2			sys_reg(3, 4, 3, 0, 0)
 #define SYS_HDFGRTR_EL2			sys_reg(3, 4, 3, 1, 4)
 #define SYS_HDFGWTR_EL2			sys_reg(3, 4, 3, 1, 5)
@@ -596,6 +614,7 @@
 #define SYS_SCTLR_EL12			sys_reg(3, 5, 1, 0, 0)
 #define SYS_CPACR_EL12			sys_reg(3, 5, 1, 0, 2)
 #define SYS_ZCR_EL12			sys_reg(3, 5, 1, 2, 0)
+#define SYS_SMCR_EL12			sys_reg(3, 5, 1, 2, 6)
 #define SYS_TTBR0_EL12			sys_reg(3, 5, 2, 0, 0)
 #define SYS_TTBR1_EL12			sys_reg(3, 5, 2, 0, 1)
 #define SYS_TCR_EL12			sys_reg(3, 5, 2, 0, 2)
@@ -619,6 +638,7 @@
 #define SYS_CNTV_CVAL_EL02		sys_reg(3, 5, 14, 3, 2)
 
 /* Common SCTLR_ELx flags. */
+#define SCTLR_ELx_ENTP2	(BIT(60))
 #define SCTLR_ELx_DSSBS	(BIT(44))
 #define SCTLR_ELx_ATA	(BIT(43))
 
@@ -800,6 +820,7 @@
 #define ID_AA64PFR0_ELx_32BIT_64BIT	0x2
 
 /* id_aa64pfr1 */
+#define ID_AA64PFR1_SME_SHIFT		24
 #define ID_AA64PFR1_MPAMFRAC_SHIFT	16
 #define ID_AA64PFR1_RASFRAC_SHIFT	12
 #define ID_AA64PFR1_MTE_SHIFT		8
@@ -810,6 +831,7 @@
 #define ID_AA64PFR1_SSBS_PSTATE_ONLY	1
 #define ID_AA64PFR1_SSBS_PSTATE_INSNS	2
 #define ID_AA64PFR1_BT_BTI		0x1
+#define ID_AA64PFR1_SME			1
 
 #define ID_AA64PFR1_MTE_NI		0x0
 #define ID_AA64PFR1_MTE_EL0		0x1
@@ -838,6 +860,23 @@
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
@@ -889,6 +928,7 @@
 #endif
 
 /* id_aa64mmfr1 */
+#define ID_AA64MMFR1_HCX_SHIFT		40
 #define ID_AA64MMFR1_ETS_SHIFT		36
 #define ID_AA64MMFR1_TWED_SHIFT		32
 #define ID_AA64MMFR1_XNX_SHIFT		28
@@ -1080,6 +1120,22 @@
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
+#define CPACR_EL1_SMEN_EL1EN	(BIT(24)) /* enable EL1 access */
+#define CPACR_EL1_SMEN_EL0EN	(BIT(25)) /* enable EL0 access, if EL1EN set */
+#define CPACR_EL1_SMEN		(CPACR_EL1_SMEN_EL1EN | CPACR_EL1_SMEN_EL0EN)
+
 #define CPACR_EL1_ZEN_EL1EN	(BIT(16)) /* enable EL1 access */
 #define CPACR_EL1_ZEN_EL0EN	(BIT(17)) /* enable EL0 access, if EL1EN set */
 #define CPACR_EL1_ZEN		(CPACR_EL1_ZEN_EL1EN | CPACR_EL1_ZEN_EL0EN)
@@ -1133,6 +1189,8 @@
 #define TRFCR_ELx_ExTRE			BIT(1)
 #define TRFCR_ELx_E0TRE			BIT(0)
 
+/* HCRX_EL2 definitions */
+#define HCRX_EL2_SMPME_MASK		(1 << 5)
 
 /* GIC Hypervisor interface registers */
 /* ICH_MISR_EL2 bit definitions */
diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index 7b21213a570f..bd2bd39d49a8 100644
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

