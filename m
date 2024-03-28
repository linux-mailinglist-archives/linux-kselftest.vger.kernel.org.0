Return-Path: <linux-kselftest+bounces-6026-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 31FFB8743B2
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Mar 2024 00:16:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C6AEB218D3
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Mar 2024 23:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01D152575D;
	Wed,  6 Mar 2024 23:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DiSbGwWv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C706F24B33;
	Wed,  6 Mar 2024 23:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709766942; cv=none; b=DgCO3lhOBG6/xuPUlvnYkxTm16RpwpbxsUTCkd7XxH1/F63b14rQ8+89Ck8UVyqu3WEUKbKRCFeR2qMxl3Viy9L8QUFGK99vls2aga0nBKpWpkl8a83mwNszI9yJhbJIGVA0qXvl1jeHw6IWR9fEtcW+XtQYg5A6cua7lR1VTBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709766942; c=relaxed/simple;
	bh=jexfU05OGE7oLoy+DZEqdOPt5JuRevjPtbcqQ7utAQg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=O8OdXNcnR/LkLeOmYmRm66Uz1SR0/WoNrmYJ9KBWUN4JcdjGPgIOQK0Ldgo9BvyK0Vm2WTZVQcMUHd/k+Oo2/e3eqZUQBG3w/mhfZF7/emVilzuiwR9iZTk5idoO8UwyQtjc3DbdRnYAEgutWCHWT7yKWs3Yy5hPtJJr0edNXPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DiSbGwWv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E53B0C433B2;
	Wed,  6 Mar 2024 23:15:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709766942;
	bh=jexfU05OGE7oLoy+DZEqdOPt5JuRevjPtbcqQ7utAQg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=DiSbGwWvTvqIkTwfv3UT3l3pQnyn5pydDjVVr915pOYcuSY++wz+9jgndTiyXm9MB
	 lj9WmjtXk9FsMZBP8YwE9LGLlztcphIC/tA+X+B+kfULa9oLLo7sBP6gOV8sa+QTkj
	 TYOHDLQsA2XosujZMjW4PY+d9NVMGz5z3OYbryAK8nok2sLp34QJyx11nMnlQoPDOv
	 bC4OUo+4c3/S6+Msk3g9B4sC5tP+ms7aR+hidjxiYd6x+woU3ZjLl4g+7+z0sAz6NC
	 bePUMSiHuqSIvzpt2iBqIZsYO7lN5REkM9sJQlg6pfHTnTcmbD4ZOfwwzMrh7jbsd5
	 rnDIPInHHwMjA==
From: Mark Brown <broonie@kernel.org>
Date: Wed, 06 Mar 2024 23:14:51 +0000
Subject: [PATCH v5 6/9] arm64/hwcap: Define hwcaps for 2023 DPISA features
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240306-arm64-2023-dpisa-v5-6-c568edc8ed7f@kernel.org>
References: <20240306-arm64-2023-dpisa-v5-0-c568edc8ed7f@kernel.org>
In-Reply-To: <20240306-arm64-2023-dpisa-v5-0-c568edc8ed7f@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, 
 Oliver Upton <oliver.upton@linux.dev>, James Morse <james.morse@arm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Dave Martin <Dave.Martin@arm.com>, kvmarm@lists.linux.dev, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-a684c
X-Developer-Signature: v=1; a=openpgp-sha256; l=12825; i=broonie@kernel.org;
 h=from:subject:message-id; bh=jexfU05OGE7oLoy+DZEqdOPt5JuRevjPtbcqQ7utAQg=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBl6PkFbufDutfoSQnz2E0lHIGq+DYFNjNW6Vk91eOq
 aVesD5WJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZej5BQAKCRAk1otyXVSH0IevB/
 4152e7/Uers+er/RxxHhlAVEBUcttho5gOyj47C49EWKoMLNIM3Jnquf5LliHjoeYeVdOHE59kQmgu
 noVvKNxvGe4AXwIauqZjvdA69XgjHX20lTVz/gEXGQCh7bVbA1o0l81Z5fFgbairCLnbsXtjo65kAS
 9x+1T/prcgqmnumHZe7St2srPZQnCr7fRkMrnyiiKEP3Twe5DoLSOuCAQ3cMSEckVVLRMg5fwf257v
 g4tTwI4hGj3ReZ7qSL2WuTrQA8KgY0ojaBpNwckQxfKHcXY6sfGQJit0WGiDAAVkWSeQKDiR25xIDc
 PD+1qe5w/46mhlebvevAoZKMbr84Wv
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

The 2023 architecture extensions include a large number of floating point
features, most of which simply add new instructions. Add hwcaps so that
userspace can enumerate these features.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/arch/arm64/elf_hwcaps.rst | 49 +++++++++++++++++++++++++++++++++
 arch/arm64/include/asm/hwcap.h          | 15 ++++++++++
 arch/arm64/include/uapi/asm/hwcap.h     | 15 ++++++++++
 arch/arm64/kernel/cpufeature.c          | 35 +++++++++++++++++++++++
 arch/arm64/kernel/cpuinfo.c             | 15 ++++++++++
 5 files changed, 129 insertions(+)

diff --git a/Documentation/arch/arm64/elf_hwcaps.rst b/Documentation/arch/arm64/elf_hwcaps.rst
index ced7b335e2e0..448c1664879b 100644
--- a/Documentation/arch/arm64/elf_hwcaps.rst
+++ b/Documentation/arch/arm64/elf_hwcaps.rst
@@ -317,6 +317,55 @@ HWCAP2_LRCPC3
 HWCAP2_LSE128
     Functionality implied by ID_AA64ISAR0_EL1.Atomic == 0b0011.
 
+HWCAP2_FPMR
+    Functionality implied by ID_AA64PFR2_EL1.FMR == 0b0001.
+
+HWCAP2_LUT
+    Functionality implied by ID_AA64ISAR2_EL1.LUT == 0b0001.
+
+HWCAP2_FAMINMAX
+    Functionality implied by ID_AA64ISAR3_EL1.FAMINMAX == 0b0001.
+
+HWCAP2_F8CVT
+    Functionality implied by ID_AA64FPFR0_EL1.F8CVT == 0b1.
+
+HWCAP2_F8FMA
+    Functionality implied by ID_AA64FPFR0_EL1.F8FMA == 0b1.
+
+HWCAP2_F8DP4
+    Functionality implied by ID_AA64FPFR0_EL1.F8DP4 == 0b1.
+
+HWCAP2_F8DP2
+    Functionality implied by ID_AA64FPFR0_EL1.F8DP2 == 0b1.
+
+HWCAP2_F8E4M3
+    Functionality implied by ID_AA64FPFR0_EL1.F8E4M3 == 0b1.
+
+HWCAP2_F8E5M2
+    Functionality implied by ID_AA64FPFR0_EL1.F8E5M2 == 0b1.
+
+HWCAP2_SME_LUTV2
+    Functionality implied by ID_AA64SMFR0_EL1.LUTv2 == 0b1.
+
+HWCAP2_SME_F8F16
+    Functionality implied by ID_AA64SMFR0_EL1.F8F16 == 0b1.
+
+HWCAP2_SME_F8F32
+    Functionality implied by ID_AA64SMFR0_EL1.F8F32 == 0b1.
+
+HWCAP2_SME_SF8FMA
+    Functionality implied by ID_AA64SMFR0_EL1.SF8FMA == 0b1.
+
+HWCAP2_SME_SF8DP4
+    Functionality implied by ID_AA64SMFR0_EL1.SF8DP4 == 0b1.
+
+HWCAP2_SME_SF8DP2
+    Functionality implied by ID_AA64SMFR0_EL1.SF8DP2 == 0b1.
+
+HWCAP2_SME_SF8DP4
+    Functionality implied by ID_AA64SMFR0_EL1.SF8DP4 == 0b1.
+
+
 4. Unused AT_HWCAP bits
 -----------------------
 
diff --git a/arch/arm64/include/asm/hwcap.h b/arch/arm64/include/asm/hwcap.h
index cd71e09ea14d..4edd3b61df11 100644
--- a/arch/arm64/include/asm/hwcap.h
+++ b/arch/arm64/include/asm/hwcap.h
@@ -142,6 +142,21 @@
 #define KERNEL_HWCAP_SVE_B16B16		__khwcap2_feature(SVE_B16B16)
 #define KERNEL_HWCAP_LRCPC3		__khwcap2_feature(LRCPC3)
 #define KERNEL_HWCAP_LSE128		__khwcap2_feature(LSE128)
+#define KERNEL_HWCAP_FPMR		__khwcap2_feature(FPMR)
+#define KERNEL_HWCAP_LUT		__khwcap2_feature(LUT)
+#define KERNEL_HWCAP_FAMINMAX		__khwcap2_feature(FAMINMAX)
+#define KERNEL_HWCAP_F8CVT		__khwcap2_feature(F8CVT)
+#define KERNEL_HWCAP_F8FMA		__khwcap2_feature(F8FMA)
+#define KERNEL_HWCAP_F8DP4		__khwcap2_feature(F8DP4)
+#define KERNEL_HWCAP_F8DP2		__khwcap2_feature(F8DP2)
+#define KERNEL_HWCAP_F8E4M3		__khwcap2_feature(F8E4M3)
+#define KERNEL_HWCAP_F8E5M2		__khwcap2_feature(F8E5M2)
+#define KERNEL_HWCAP_SME_LUTV2		__khwcap2_feature(SME_LUTV2)
+#define KERNEL_HWCAP_SME_F8F16		__khwcap2_feature(SME_F8F16)
+#define KERNEL_HWCAP_SME_F8F32		__khwcap2_feature(SME_F8F32)
+#define KERNEL_HWCAP_SME_SF8FMA		__khwcap2_feature(SME_SF8FMA)
+#define KERNEL_HWCAP_SME_SF8DP4		__khwcap2_feature(SME_SF8DP4)
+#define KERNEL_HWCAP_SME_SF8DP2		__khwcap2_feature(SME_SF8DP2)
 
 /*
  * This yields a mask that user programs can use to figure out what
diff --git a/arch/arm64/include/uapi/asm/hwcap.h b/arch/arm64/include/uapi/asm/hwcap.h
index 5023599fa278..285610e626f5 100644
--- a/arch/arm64/include/uapi/asm/hwcap.h
+++ b/arch/arm64/include/uapi/asm/hwcap.h
@@ -107,5 +107,20 @@
 #define HWCAP2_SVE_B16B16	(1UL << 45)
 #define HWCAP2_LRCPC3		(1UL << 46)
 #define HWCAP2_LSE128		(1UL << 47)
+#define HWCAP2_FPMR		(1UL << 48)
+#define HWCAP2_LUT		(1UL << 49)
+#define HWCAP2_FAMINMAX		(1UL << 50)
+#define HWCAP2_F8CVT		(1UL << 51)
+#define HWCAP2_F8FMA		(1UL << 52)
+#define HWCAP2_F8DP4		(1UL << 53)
+#define HWCAP2_F8DP2		(1UL << 54)
+#define HWCAP2_F8E4M3		(1UL << 55)
+#define HWCAP2_F8E5M2		(1UL << 56)
+#define HWCAP2_SME_LUTV2	(1UL << 57)
+#define HWCAP2_SME_F8F16	(1UL << 58)
+#define HWCAP2_SME_F8F32	(1UL << 59)
+#define HWCAP2_SME_SF8FMA	(1UL << 60)
+#define HWCAP2_SME_SF8DP4	(1UL << 61)
+#define HWCAP2_SME_SF8DP2	(1UL << 62)
 
 #endif /* _UAPI__ASM_HWCAP_H */
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 0263565f617a..aefda789f510 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -220,6 +220,7 @@ static const struct arm64_ftr_bits ftr_id_aa64isar1[] = {
 };
 
 static const struct arm64_ftr_bits ftr_id_aa64isar2[] = {
+	ARM64_FTR_BITS(FTR_VISIBLE, FTR_NONSTRICT, FTR_LOWER_SAFE, ID_AA64ISAR2_EL1_LUT_SHIFT, 4, 0),
 	ARM64_FTR_BITS(FTR_VISIBLE, FTR_NONSTRICT, FTR_LOWER_SAFE, ID_AA64ISAR2_EL1_CSSC_SHIFT, 4, 0),
 	ARM64_FTR_BITS(FTR_VISIBLE, FTR_NONSTRICT, FTR_LOWER_SAFE, ID_AA64ISAR2_EL1_RPRFM_SHIFT, 4, 0),
 	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64ISAR2_EL1_CLRBHB_SHIFT, 4, 0),
@@ -235,6 +236,7 @@ static const struct arm64_ftr_bits ftr_id_aa64isar2[] = {
 };
 
 static const struct arm64_ftr_bits ftr_id_aa64isar3[] = {
+	ARM64_FTR_BITS(FTR_VISIBLE, FTR_NONSTRICT, FTR_LOWER_SAFE, ID_AA64ISAR3_EL1_FAMINMAX_SHIFT, 4, 0),
 	ARM64_FTR_END,
 };
 
@@ -303,6 +305,8 @@ static const struct arm64_ftr_bits ftr_id_aa64zfr0[] = {
 static const struct arm64_ftr_bits ftr_id_aa64smfr0[] = {
 	ARM64_FTR_BITS(FTR_VISIBLE_IF_IS_ENABLED(CONFIG_ARM64_SME),
 		       FTR_STRICT, FTR_EXACT, ID_AA64SMFR0_EL1_FA64_SHIFT, 1, 0),
+	ARM64_FTR_BITS(FTR_VISIBLE_IF_IS_ENABLED(CONFIG_ARM64_SME),
+		       FTR_STRICT, FTR_EXACT, ID_AA64SMFR0_EL1_LUTv2_SHIFT, 1, 0),
 	ARM64_FTR_BITS(FTR_VISIBLE_IF_IS_ENABLED(CONFIG_ARM64_SME),
 		       FTR_STRICT, FTR_EXACT, ID_AA64SMFR0_EL1_SMEver_SHIFT, 4, 0),
 	ARM64_FTR_BITS(FTR_VISIBLE_IF_IS_ENABLED(CONFIG_ARM64_SME),
@@ -315,6 +319,10 @@ static const struct arm64_ftr_bits ftr_id_aa64smfr0[] = {
 		       FTR_STRICT, FTR_EXACT, ID_AA64SMFR0_EL1_B16B16_SHIFT, 1, 0),
 	ARM64_FTR_BITS(FTR_VISIBLE_IF_IS_ENABLED(CONFIG_ARM64_SME),
 		       FTR_STRICT, FTR_EXACT, ID_AA64SMFR0_EL1_F16F16_SHIFT, 1, 0),
+	ARM64_FTR_BITS(FTR_VISIBLE_IF_IS_ENABLED(CONFIG_ARM64_SME),
+		       FTR_STRICT, FTR_EXACT, ID_AA64SMFR0_EL1_F8F16_SHIFT, 1, 0),
+	ARM64_FTR_BITS(FTR_VISIBLE_IF_IS_ENABLED(CONFIG_ARM64_SME),
+		       FTR_STRICT, FTR_EXACT, ID_AA64SMFR0_EL1_F8F32_SHIFT, 1, 0),
 	ARM64_FTR_BITS(FTR_VISIBLE_IF_IS_ENABLED(CONFIG_ARM64_SME),
 		       FTR_STRICT, FTR_EXACT, ID_AA64SMFR0_EL1_I8I32_SHIFT, 4, 0),
 	ARM64_FTR_BITS(FTR_VISIBLE_IF_IS_ENABLED(CONFIG_ARM64_SME),
@@ -325,10 +333,22 @@ static const struct arm64_ftr_bits ftr_id_aa64smfr0[] = {
 		       FTR_STRICT, FTR_EXACT, ID_AA64SMFR0_EL1_BI32I32_SHIFT, 1, 0),
 	ARM64_FTR_BITS(FTR_VISIBLE_IF_IS_ENABLED(CONFIG_ARM64_SME),
 		       FTR_STRICT, FTR_EXACT, ID_AA64SMFR0_EL1_F32F32_SHIFT, 1, 0),
+	ARM64_FTR_BITS(FTR_VISIBLE_IF_IS_ENABLED(CONFIG_ARM64_SME),
+		       FTR_STRICT, FTR_EXACT, ID_AA64SMFR0_EL1_SF8FMA_SHIFT, 1, 0),
+	ARM64_FTR_BITS(FTR_VISIBLE_IF_IS_ENABLED(CONFIG_ARM64_SME),
+		       FTR_STRICT, FTR_EXACT, ID_AA64SMFR0_EL1_SF8DP4_SHIFT, 1, 0),
+	ARM64_FTR_BITS(FTR_VISIBLE_IF_IS_ENABLED(CONFIG_ARM64_SME),
+		       FTR_STRICT, FTR_EXACT, ID_AA64SMFR0_EL1_SF8DP2_SHIFT, 1, 0),
 	ARM64_FTR_END,
 };
 
 static const struct arm64_ftr_bits ftr_id_aa64fpfr0[] = {
+	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_EXACT, ID_AA64FPFR0_EL1_F8CVT_SHIFT, 1, 0),
+	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_EXACT, ID_AA64FPFR0_EL1_F8FMA_SHIFT, 1, 0),
+	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_EXACT, ID_AA64FPFR0_EL1_F8DP4_SHIFT, 1, 0),
+	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_EXACT, ID_AA64FPFR0_EL1_F8DP2_SHIFT, 1, 0),
+	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_EXACT, ID_AA64FPFR0_EL1_F8E4M3_SHIFT, 1, 0),
+	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_EXACT, ID_AA64FPFR0_EL1_F8E5M2_SHIFT, 1, 0),
 	ARM64_FTR_END,
 };
 
@@ -2859,6 +2879,7 @@ static const struct arm64_cpu_capabilities arm64_elf_hwcaps[] = {
 	HWCAP_CAP(ID_AA64PFR0_EL1, AdvSIMD, IMP, CAP_HWCAP, KERNEL_HWCAP_ASIMD),
 	HWCAP_CAP(ID_AA64PFR0_EL1, AdvSIMD, FP16, CAP_HWCAP, KERNEL_HWCAP_ASIMDHP),
 	HWCAP_CAP(ID_AA64PFR0_EL1, DIT, IMP, CAP_HWCAP, KERNEL_HWCAP_DIT),
+	HWCAP_CAP(ID_AA64PFR2_EL1, FPMR, IMP, CAP_HWCAP, KERNEL_HWCAP_FPMR),
 	HWCAP_CAP(ID_AA64ISAR1_EL1, DPB, IMP, CAP_HWCAP, KERNEL_HWCAP_DCPOP),
 	HWCAP_CAP(ID_AA64ISAR1_EL1, DPB, DPB2, CAP_HWCAP, KERNEL_HWCAP_DCPODP),
 	HWCAP_CAP(ID_AA64ISAR1_EL1, JSCVT, IMP, CAP_HWCAP, KERNEL_HWCAP_JSCVT),
@@ -2872,6 +2893,8 @@ static const struct arm64_cpu_capabilities arm64_elf_hwcaps[] = {
 	HWCAP_CAP(ID_AA64ISAR1_EL1, BF16, EBF16, CAP_HWCAP, KERNEL_HWCAP_EBF16),
 	HWCAP_CAP(ID_AA64ISAR1_EL1, DGH, IMP, CAP_HWCAP, KERNEL_HWCAP_DGH),
 	HWCAP_CAP(ID_AA64ISAR1_EL1, I8MM, IMP, CAP_HWCAP, KERNEL_HWCAP_I8MM),
+	HWCAP_CAP(ID_AA64ISAR2_EL1, LUT, IMP, CAP_HWCAP, KERNEL_HWCAP_LUT),
+	HWCAP_CAP(ID_AA64ISAR3_EL1, FAMINMAX, IMP, CAP_HWCAP, KERNEL_HWCAP_FAMINMAX),
 	HWCAP_CAP(ID_AA64MMFR2_EL1, AT, IMP, CAP_HWCAP, KERNEL_HWCAP_USCAT),
 #ifdef CONFIG_ARM64_SVE
 	HWCAP_CAP(ID_AA64PFR0_EL1, SVE, IMP, CAP_HWCAP, KERNEL_HWCAP_SVE),
@@ -2912,6 +2935,7 @@ static const struct arm64_cpu_capabilities arm64_elf_hwcaps[] = {
 #ifdef CONFIG_ARM64_SME
 	HWCAP_CAP(ID_AA64PFR1_EL1, SME, IMP, CAP_HWCAP, KERNEL_HWCAP_SME),
 	HWCAP_CAP(ID_AA64SMFR0_EL1, FA64, IMP, CAP_HWCAP, KERNEL_HWCAP_SME_FA64),
+	HWCAP_CAP(ID_AA64SMFR0_EL1, LUTv2, IMP, CAP_HWCAP, KERNEL_HWCAP_SME_LUTV2),
 	HWCAP_CAP(ID_AA64SMFR0_EL1, SMEver, SME2p1, CAP_HWCAP, KERNEL_HWCAP_SME2P1),
 	HWCAP_CAP(ID_AA64SMFR0_EL1, SMEver, SME2, CAP_HWCAP, KERNEL_HWCAP_SME2),
 	HWCAP_CAP(ID_AA64SMFR0_EL1, I16I64, IMP, CAP_HWCAP, KERNEL_HWCAP_SME_I16I64),
@@ -2919,12 +2943,23 @@ static const struct arm64_cpu_capabilities arm64_elf_hwcaps[] = {
 	HWCAP_CAP(ID_AA64SMFR0_EL1, I16I32, IMP, CAP_HWCAP, KERNEL_HWCAP_SME_I16I32),
 	HWCAP_CAP(ID_AA64SMFR0_EL1, B16B16, IMP, CAP_HWCAP, KERNEL_HWCAP_SME_B16B16),
 	HWCAP_CAP(ID_AA64SMFR0_EL1, F16F16, IMP, CAP_HWCAP, KERNEL_HWCAP_SME_F16F16),
+	HWCAP_CAP(ID_AA64SMFR0_EL1, F8F16, IMP, CAP_HWCAP, KERNEL_HWCAP_SME_F8F16),
+	HWCAP_CAP(ID_AA64SMFR0_EL1, F8F32, IMP, CAP_HWCAP, KERNEL_HWCAP_SME_F8F32),
 	HWCAP_CAP(ID_AA64SMFR0_EL1, I8I32, IMP, CAP_HWCAP, KERNEL_HWCAP_SME_I8I32),
 	HWCAP_CAP(ID_AA64SMFR0_EL1, F16F32, IMP, CAP_HWCAP, KERNEL_HWCAP_SME_F16F32),
 	HWCAP_CAP(ID_AA64SMFR0_EL1, B16F32, IMP, CAP_HWCAP, KERNEL_HWCAP_SME_B16F32),
 	HWCAP_CAP(ID_AA64SMFR0_EL1, BI32I32, IMP, CAP_HWCAP, KERNEL_HWCAP_SME_BI32I32),
 	HWCAP_CAP(ID_AA64SMFR0_EL1, F32F32, IMP, CAP_HWCAP, KERNEL_HWCAP_SME_F32F32),
+	HWCAP_CAP(ID_AA64SMFR0_EL1, SF8FMA, IMP, CAP_HWCAP, KERNEL_HWCAP_SME_SF8FMA),
+	HWCAP_CAP(ID_AA64SMFR0_EL1, SF8DP4, IMP, CAP_HWCAP, KERNEL_HWCAP_SME_SF8DP4),
+	HWCAP_CAP(ID_AA64SMFR0_EL1, SF8DP2, IMP, CAP_HWCAP, KERNEL_HWCAP_SME_SF8DP2),
 #endif /* CONFIG_ARM64_SME */
+	HWCAP_CAP(ID_AA64FPFR0_EL1, F8CVT, IMP, CAP_HWCAP, KERNEL_HWCAP_F8CVT),
+	HWCAP_CAP(ID_AA64FPFR0_EL1, F8FMA, IMP, CAP_HWCAP, KERNEL_HWCAP_F8FMA),
+	HWCAP_CAP(ID_AA64FPFR0_EL1, F8DP4, IMP, CAP_HWCAP, KERNEL_HWCAP_F8DP4),
+	HWCAP_CAP(ID_AA64FPFR0_EL1, F8DP2, IMP, CAP_HWCAP, KERNEL_HWCAP_F8DP2),
+	HWCAP_CAP(ID_AA64FPFR0_EL1, F8E4M3, IMP, CAP_HWCAP, KERNEL_HWCAP_F8E4M3),
+	HWCAP_CAP(ID_AA64FPFR0_EL1, F8E5M2, IMP, CAP_HWCAP, KERNEL_HWCAP_F8E5M2),
 	{},
 };
 
diff --git a/arch/arm64/kernel/cpuinfo.c b/arch/arm64/kernel/cpuinfo.c
index 12b192060156..f0abb150f73e 100644
--- a/arch/arm64/kernel/cpuinfo.c
+++ b/arch/arm64/kernel/cpuinfo.c
@@ -128,6 +128,21 @@ static const char *const hwcap_str[] = {
 	[KERNEL_HWCAP_SVE_B16B16]	= "sveb16b16",
 	[KERNEL_HWCAP_LRCPC3]		= "lrcpc3",
 	[KERNEL_HWCAP_LSE128]		= "lse128",
+	[KERNEL_HWCAP_FPMR]		= "fpmr",
+	[KERNEL_HWCAP_LUT]		= "lut",
+	[KERNEL_HWCAP_FAMINMAX]		= "faminmax",
+	[KERNEL_HWCAP_F8CVT]		= "f8cvt",
+	[KERNEL_HWCAP_F8FMA]		= "f8fma",
+	[KERNEL_HWCAP_F8DP4]		= "f8dp4",
+	[KERNEL_HWCAP_F8DP2]		= "f8dp2",
+	[KERNEL_HWCAP_F8E4M3]		= "f8e4m3",
+	[KERNEL_HWCAP_F8E5M2]		= "f8e5m2",
+	[KERNEL_HWCAP_SME_LUTV2]	= "smelutv2",
+	[KERNEL_HWCAP_SME_F8F16]	= "smef8f16",
+	[KERNEL_HWCAP_SME_F8F32]	= "smef8f32",
+	[KERNEL_HWCAP_SME_SF8FMA]	= "smesf8fma",
+	[KERNEL_HWCAP_SME_SF8DP4]	= "smesf8dp4",
+	[KERNEL_HWCAP_SME_SF8DP2]	= "smesf8dp2",
 };
 
 #ifdef CONFIG_COMPAT

-- 
2.30.2


