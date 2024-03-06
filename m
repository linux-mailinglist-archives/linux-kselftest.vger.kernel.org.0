Return-Path: <linux-kselftest+bounces-6021-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EDD3E8743A1
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Mar 2024 00:15:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BB971C20D5B
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Mar 2024 23:15:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F5121C6AD;
	Wed,  6 Mar 2024 23:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JPX3GW3h"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50AE41CA9A;
	Wed,  6 Mar 2024 23:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709766927; cv=none; b=PQtAEEkuXfv1Zzvl6Pqp2vtvCuFjqKh7szf3ZzZ6IIQzaAJM1/sdDIHSvk7REpYfG4D1y/90bPliwlGz/CN539Fr9p3QiQN0moy6DDxO6sonXYgJmRGy3n2T19lrb2KVSbdOP8/3sG4DyHDfLet+AI/Tt+2eKmFQWNDK/A6lZYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709766927; c=relaxed/simple;
	bh=jRN4B5UYlwEC32cOuYktHO41n76tptI1NFklKzKtBu8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ve/JgH/Ca1/Zt1+CeA+65rJCTZsMJasS70NhkYE9mAIihOo1LcV41foV++B4QOHxRlZpZkC6WOrP7R8vyDHvx6C+nH7crpS33kie1vKBDSccvdnh+gShEsLgKjR3kdS6WEAKd2qUujJkgU0FrORWRHlG7zwusJY6m8vdV9B3ky4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JPX3GW3h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3142FC433A6;
	Wed,  6 Mar 2024 23:15:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709766926;
	bh=jRN4B5UYlwEC32cOuYktHO41n76tptI1NFklKzKtBu8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=JPX3GW3haMuMlJGkSGtlvhfkS9HsU5V4QFr3Hvntf8I7jlrAA6IQAXJt45uj2SKJ3
	 tIwwS5rqEQzhHfaPIcy8wQraVyr+7300XMmX72XLZdvnTSOcTQDhb+CDYlRl/mo96A
	 oDFeFL7zLgAc9d96A1ZZQl1jXiEHeWIeohevIrJEGrOb9yy5d9PPdWiIGOyI9EDIEA
	 ADZdSmTY8Onnof5Hbznqzvk2hocyIo/OTfkF7gwRAl7GZIRhuVmCaCQfo9ZIrK6/bN
	 1JwJbTMCpeBZosvKeOyWa3Sru8kOA+PomsFuCXF5uj2d74AZ7FuN8QOhW0hZuqvikG
	 wbg8IeFpFdcwA==
From: Mark Brown <broonie@kernel.org>
Date: Wed, 06 Mar 2024 23:14:46 +0000
Subject: [PATCH v5 1/9] arm64/cpufeature: Hook new identification registers
 up to cpufeature
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240306-arm64-2023-dpisa-v5-1-c568edc8ed7f@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=7888; i=broonie@kernel.org;
 h=from:subject:message-id; bh=jRN4B5UYlwEC32cOuYktHO41n76tptI1NFklKzKtBu8=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBl6PkBbGNGuYOqfilctetfJFkpUh1ZfIJXXNHgHeJP
 2FJxrBSJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZej5AQAKCRAk1otyXVSH0DJcB/
 0S+JpKqNzjwjLgvhSt4p5KbL16MYCe75PzMIV1WJgUsHnfJcOBvzDVxGRa4Vga11un50kkifbN/4Er
 uPp2WN57jcjrh+wMQuCJECYIa6TtQ3eupdF8yQ+MwB2G7sPJXtKxP2wRNhmDEd23fAoCU5+e1Xixx4
 JpqGxT7uOY9D1yfa9ZU3shYtJXLFoDIsESgi7hvGVgvtQKX5Opmr3LT5406vF0PO4HpTOA4kl4yDJE
 q8i2WP0Wlh0D3dW/3VKqIyvcQ3yI3UxxeGpUDxPLp4LJsyrCfAmomvnqK17TGEnNDwq3qZ/RE4crcj
 paKKsjgcLt53DlJrQHjr3OGWDQPIx9
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

The 2023 architecture extensions have defined several new ID registers,
hook them up to the cpufeature code so we can add feature checks and hwcaps
based on their contents.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/include/asm/cpu.h   |  3 +++
 arch/arm64/kernel/cpufeature.c | 28 ++++++++++++++++++++++++++++
 arch/arm64/kernel/cpuinfo.c    |  3 +++
 3 files changed, 34 insertions(+)

diff --git a/arch/arm64/include/asm/cpu.h b/arch/arm64/include/asm/cpu.h
index b1e43f56ee46..96379be913cd 100644
--- a/arch/arm64/include/asm/cpu.h
+++ b/arch/arm64/include/asm/cpu.h
@@ -52,14 +52,17 @@ struct cpuinfo_arm64 {
 	u64		reg_id_aa64isar0;
 	u64		reg_id_aa64isar1;
 	u64		reg_id_aa64isar2;
+	u64		reg_id_aa64isar3;
 	u64		reg_id_aa64mmfr0;
 	u64		reg_id_aa64mmfr1;
 	u64		reg_id_aa64mmfr2;
 	u64		reg_id_aa64mmfr3;
 	u64		reg_id_aa64pfr0;
 	u64		reg_id_aa64pfr1;
+	u64		reg_id_aa64pfr2;
 	u64		reg_id_aa64zfr0;
 	u64		reg_id_aa64smfr0;
+	u64		reg_id_aa64fpfr0;
 
 	struct cpuinfo_32bit	aarch32;
 };
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 8d1a634a403e..eae59ec0f4b0 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -234,6 +234,10 @@ static const struct arm64_ftr_bits ftr_id_aa64isar2[] = {
 	ARM64_FTR_END,
 };
 
+static const struct arm64_ftr_bits ftr_id_aa64isar3[] = {
+	ARM64_FTR_END,
+};
+
 static const struct arm64_ftr_bits ftr_id_aa64pfr0[] = {
 	ARM64_FTR_BITS(FTR_HIDDEN, FTR_NONSTRICT, FTR_LOWER_SAFE, ID_AA64PFR0_EL1_CSV3_SHIFT, 4, 0),
 	ARM64_FTR_BITS(FTR_HIDDEN, FTR_NONSTRICT, FTR_LOWER_SAFE, ID_AA64PFR0_EL1_CSV2_SHIFT, 4, 0),
@@ -267,6 +271,10 @@ static const struct arm64_ftr_bits ftr_id_aa64pfr1[] = {
 	ARM64_FTR_END,
 };
 
+static const struct arm64_ftr_bits ftr_id_aa64pfr2[] = {
+	ARM64_FTR_END,
+};
+
 static const struct arm64_ftr_bits ftr_id_aa64zfr0[] = {
 	ARM64_FTR_BITS(FTR_VISIBLE_IF_IS_ENABLED(CONFIG_ARM64_SVE),
 		       FTR_STRICT, FTR_LOWER_SAFE, ID_AA64ZFR0_EL1_F64MM_SHIFT, 4, 0),
@@ -319,6 +327,10 @@ static const struct arm64_ftr_bits ftr_id_aa64smfr0[] = {
 	ARM64_FTR_END,
 };
 
+static const struct arm64_ftr_bits ftr_id_aa64fpfr0[] = {
+	ARM64_FTR_END,
+};
+
 static const struct arm64_ftr_bits ftr_id_aa64mmfr0[] = {
 	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64MMFR0_EL1_ECV_SHIFT, 4, 0),
 	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64MMFR0_EL1_FGT_SHIFT, 4, 0),
@@ -702,10 +714,12 @@ static const struct __ftr_reg_entry {
 			       &id_aa64pfr0_override),
 	ARM64_FTR_REG_OVERRIDE(SYS_ID_AA64PFR1_EL1, ftr_id_aa64pfr1,
 			       &id_aa64pfr1_override),
+	ARM64_FTR_REG(SYS_ID_AA64PFR2_EL1, ftr_id_aa64pfr2),
 	ARM64_FTR_REG_OVERRIDE(SYS_ID_AA64ZFR0_EL1, ftr_id_aa64zfr0,
 			       &id_aa64zfr0_override),
 	ARM64_FTR_REG_OVERRIDE(SYS_ID_AA64SMFR0_EL1, ftr_id_aa64smfr0,
 			       &id_aa64smfr0_override),
+	ARM64_FTR_REG(SYS_ID_AA64FPFR0_EL1, ftr_id_aa64fpfr0),
 
 	/* Op1 = 0, CRn = 0, CRm = 5 */
 	ARM64_FTR_REG(SYS_ID_AA64DFR0_EL1, ftr_id_aa64dfr0),
@@ -717,6 +731,7 @@ static const struct __ftr_reg_entry {
 			       &id_aa64isar1_override),
 	ARM64_FTR_REG_OVERRIDE(SYS_ID_AA64ISAR2_EL1, ftr_id_aa64isar2,
 			       &id_aa64isar2_override),
+	ARM64_FTR_REG(SYS_ID_AA64ISAR3_EL1, ftr_id_aa64isar3),
 
 	/* Op1 = 0, CRn = 0, CRm = 7 */
 	ARM64_FTR_REG(SYS_ID_AA64MMFR0_EL1, ftr_id_aa64mmfr0),
@@ -1043,14 +1058,17 @@ void __init init_cpu_features(struct cpuinfo_arm64 *info)
 	init_cpu_ftr_reg(SYS_ID_AA64ISAR0_EL1, info->reg_id_aa64isar0);
 	init_cpu_ftr_reg(SYS_ID_AA64ISAR1_EL1, info->reg_id_aa64isar1);
 	init_cpu_ftr_reg(SYS_ID_AA64ISAR2_EL1, info->reg_id_aa64isar2);
+	init_cpu_ftr_reg(SYS_ID_AA64ISAR3_EL1, info->reg_id_aa64isar3);
 	init_cpu_ftr_reg(SYS_ID_AA64MMFR0_EL1, info->reg_id_aa64mmfr0);
 	init_cpu_ftr_reg(SYS_ID_AA64MMFR1_EL1, info->reg_id_aa64mmfr1);
 	init_cpu_ftr_reg(SYS_ID_AA64MMFR2_EL1, info->reg_id_aa64mmfr2);
 	init_cpu_ftr_reg(SYS_ID_AA64MMFR3_EL1, info->reg_id_aa64mmfr3);
 	init_cpu_ftr_reg(SYS_ID_AA64PFR0_EL1, info->reg_id_aa64pfr0);
 	init_cpu_ftr_reg(SYS_ID_AA64PFR1_EL1, info->reg_id_aa64pfr1);
+	init_cpu_ftr_reg(SYS_ID_AA64PFR2_EL1, info->reg_id_aa64pfr2);
 	init_cpu_ftr_reg(SYS_ID_AA64ZFR0_EL1, info->reg_id_aa64zfr0);
 	init_cpu_ftr_reg(SYS_ID_AA64SMFR0_EL1, info->reg_id_aa64smfr0);
+	init_cpu_ftr_reg(SYS_ID_AA64FPFR0_EL1, info->reg_id_aa64fpfr0);
 
 	if (id_aa64pfr0_32bit_el0(info->reg_id_aa64pfr0))
 		init_32bit_cpu_features(&info->aarch32);
@@ -1272,6 +1290,8 @@ void update_cpu_features(int cpu,
 				      info->reg_id_aa64isar1, boot->reg_id_aa64isar1);
 	taint |= check_update_ftr_reg(SYS_ID_AA64ISAR2_EL1, cpu,
 				      info->reg_id_aa64isar2, boot->reg_id_aa64isar2);
+	taint |= check_update_ftr_reg(SYS_ID_AA64ISAR3_EL1, cpu,
+				      info->reg_id_aa64isar3, boot->reg_id_aa64isar3);
 
 	/*
 	 * Differing PARange support is fine as long as all peripherals and
@@ -1291,6 +1311,8 @@ void update_cpu_features(int cpu,
 				      info->reg_id_aa64pfr0, boot->reg_id_aa64pfr0);
 	taint |= check_update_ftr_reg(SYS_ID_AA64PFR1_EL1, cpu,
 				      info->reg_id_aa64pfr1, boot->reg_id_aa64pfr1);
+	taint |= check_update_ftr_reg(SYS_ID_AA64PFR2_EL1, cpu,
+				      info->reg_id_aa64pfr2, boot->reg_id_aa64pfr2);
 
 	taint |= check_update_ftr_reg(SYS_ID_AA64ZFR0_EL1, cpu,
 				      info->reg_id_aa64zfr0, boot->reg_id_aa64zfr0);
@@ -1298,6 +1320,9 @@ void update_cpu_features(int cpu,
 	taint |= check_update_ftr_reg(SYS_ID_AA64SMFR0_EL1, cpu,
 				      info->reg_id_aa64smfr0, boot->reg_id_aa64smfr0);
 
+	taint |= check_update_ftr_reg(SYS_ID_AA64FPFR0_EL1, cpu,
+				      info->reg_id_aa64fpfr0, boot->reg_id_aa64fpfr0);
+
 	/* Probe vector lengths */
 	if (IS_ENABLED(CONFIG_ARM64_SVE) &&
 	    id_aa64pfr0_sve(read_sanitised_ftr_reg(SYS_ID_AA64PFR0_EL1))) {
@@ -1410,8 +1435,10 @@ u64 __read_sysreg_by_encoding(u32 sys_id)
 
 	read_sysreg_case(SYS_ID_AA64PFR0_EL1);
 	read_sysreg_case(SYS_ID_AA64PFR1_EL1);
+	read_sysreg_case(SYS_ID_AA64PFR2_EL1);
 	read_sysreg_case(SYS_ID_AA64ZFR0_EL1);
 	read_sysreg_case(SYS_ID_AA64SMFR0_EL1);
+	read_sysreg_case(SYS_ID_AA64FPFR0_EL1);
 	read_sysreg_case(SYS_ID_AA64DFR0_EL1);
 	read_sysreg_case(SYS_ID_AA64DFR1_EL1);
 	read_sysreg_case(SYS_ID_AA64MMFR0_EL1);
@@ -1421,6 +1448,7 @@ u64 __read_sysreg_by_encoding(u32 sys_id)
 	read_sysreg_case(SYS_ID_AA64ISAR0_EL1);
 	read_sysreg_case(SYS_ID_AA64ISAR1_EL1);
 	read_sysreg_case(SYS_ID_AA64ISAR2_EL1);
+	read_sysreg_case(SYS_ID_AA64ISAR3_EL1);
 
 	read_sysreg_case(SYS_CNTFRQ_EL0);
 	read_sysreg_case(SYS_CTR_EL0);
diff --git a/arch/arm64/kernel/cpuinfo.c b/arch/arm64/kernel/cpuinfo.c
index 47043c0d95ec..12b192060156 100644
--- a/arch/arm64/kernel/cpuinfo.c
+++ b/arch/arm64/kernel/cpuinfo.c
@@ -443,14 +443,17 @@ static void __cpuinfo_store_cpu(struct cpuinfo_arm64 *info)
 	info->reg_id_aa64isar0 = read_cpuid(ID_AA64ISAR0_EL1);
 	info->reg_id_aa64isar1 = read_cpuid(ID_AA64ISAR1_EL1);
 	info->reg_id_aa64isar2 = read_cpuid(ID_AA64ISAR2_EL1);
+	info->reg_id_aa64isar3 = read_cpuid(ID_AA64ISAR3_EL1);
 	info->reg_id_aa64mmfr0 = read_cpuid(ID_AA64MMFR0_EL1);
 	info->reg_id_aa64mmfr1 = read_cpuid(ID_AA64MMFR1_EL1);
 	info->reg_id_aa64mmfr2 = read_cpuid(ID_AA64MMFR2_EL1);
 	info->reg_id_aa64mmfr3 = read_cpuid(ID_AA64MMFR3_EL1);
 	info->reg_id_aa64pfr0 = read_cpuid(ID_AA64PFR0_EL1);
 	info->reg_id_aa64pfr1 = read_cpuid(ID_AA64PFR1_EL1);
+	info->reg_id_aa64pfr2 = read_cpuid(ID_AA64PFR2_EL1);
 	info->reg_id_aa64zfr0 = read_cpuid(ID_AA64ZFR0_EL1);
 	info->reg_id_aa64smfr0 = read_cpuid(ID_AA64SMFR0_EL1);
+	info->reg_id_aa64fpfr0 = read_cpuid(ID_AA64FPFR0_EL1);
 
 	if (id_aa64pfr1_mte(info->reg_id_aa64pfr1))
 		info->reg_gmid = read_cpuid(GMID_EL1);

-- 
2.30.2


