Return-Path: <linux-kselftest+bounces-1165-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C63D805A5F
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Dec 2023 17:51:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D60B1C21006
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Dec 2023 16:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 001905D4B6;
	Tue,  5 Dec 2023 16:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bBWaZQoc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA5294174B;
	Tue,  5 Dec 2023 16:51:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFDC5C43395;
	Tue,  5 Dec 2023 16:51:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701795100;
	bh=eZaW7Q4M/zzv5URqk5Jj7aBPK/YCTtlJ1HieBEOkpao=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=bBWaZQocRhiNGcMzExKptjvdMKYY9uQuAuXUZMhW9T9J4vUcl5HOkuq3hEyTiqijO
	 SUmD6zu7bv7fs7Y9Cnf0c8QGImbjHvvJBskGSbw7eKBGcCFl2k/yeJ8qo7HTQXoEcC
	 QikVOTxSOn3QJK7cEjfB9p1vM/BBf7BHS+CI2Fpb0A/EOnbX/IXS30bGFFZJdoiZ21
	 cdbzaqsVTpQGmF/yLWK/LlQc8ctYky7BBG8oimVkNEmladGBWVetwYCz3OEYWbsMLm
	 j1ffH0900SOyJQWOwKfe4tEE5ExKHWt3KbaLk42QdV8XN+14d4ozEkcvKFEyYW3k+5
	 c/FliUCDv2Keg==
From: Mark Brown <broonie@kernel.org>
Date: Tue, 05 Dec 2023 16:48:07 +0000
Subject: [PATCH v3 09/21] arm64/cpufeature: Hook new identification
 registers up to cpufeature
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231205-arm64-2023-dpisa-v3-9-dbcbcd867a7f@kernel.org>
References: <20231205-arm64-2023-dpisa-v3-0-dbcbcd867a7f@kernel.org>
In-Reply-To: <20231205-arm64-2023-dpisa-v3-0-dbcbcd867a7f@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, 
 Oliver Upton <oliver.upton@linux.dev>, James Morse <james.morse@arm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 kvmarm@lists.linux.dev, linux-doc@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-5c066
X-Developer-Signature: v=1; a=openpgp-sha256; l=7888; i=broonie@kernel.org;
 h=from:subject:message-id; bh=eZaW7Q4M/zzv5URqk5Jj7aBPK/YCTtlJ1HieBEOkpao=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlb1TvB4kqRIuWdm/XtcE3Xoa/DtcNqTxztLLEbe1V
 NgqXT4aJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZW9U7wAKCRAk1otyXVSH0MIAB/
 9nLWOvCtl841avw2UHuEX/lY24I927HPDN949RGj3vb5YblN07M7O5U6mrunper7oTFNI8GCjbel6Z
 PkQIhqPBbNXC7PADTlofG0KJHrLTGs+PcxzPQd/qTSinXkrrHVI6hZ24vLO6iQ0tEtpVZgI0ghrc9C
 LKgtheJ6zFJcxVPyTWK2VyRP5yx2czrtv0p3IzatcWVu2eufrgpIDVIW/9G4fk/1jE2YXYcUNGzcVO
 pZGYpWQSZc1jM4c593dw2lkgYgWYWST/1rXEyvJPiU8z0/nhuh+CuCpRbehU/61g/WgGquAvJ5XZqr
 5dbvY8BaR17lpwmyh+I8QqvmzfLTW7
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
index f3034099fd95..b99138bc3d4a 100644
--- a/arch/arm64/include/asm/cpu.h
+++ b/arch/arm64/include/asm/cpu.h
@@ -53,14 +53,17 @@ struct cpuinfo_arm64 {
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
index 646591c67e7a..c8d38e5ce997 100644
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
@@ -1291,6 +1309,8 @@ void update_cpu_features(int cpu,
 				      info->reg_id_aa64isar1, boot->reg_id_aa64isar1);
 	taint |= check_update_ftr_reg(SYS_ID_AA64ISAR2_EL1, cpu,
 				      info->reg_id_aa64isar2, boot->reg_id_aa64isar2);
+	taint |= check_update_ftr_reg(SYS_ID_AA64ISAR3_EL1, cpu,
+				      info->reg_id_aa64isar3, boot->reg_id_aa64isar3);
 
 	/*
 	 * Differing PARange support is fine as long as all peripherals and
@@ -1310,6 +1330,8 @@ void update_cpu_features(int cpu,
 				      info->reg_id_aa64pfr0, boot->reg_id_aa64pfr0);
 	taint |= check_update_ftr_reg(SYS_ID_AA64PFR1_EL1, cpu,
 				      info->reg_id_aa64pfr1, boot->reg_id_aa64pfr1);
+	taint |= check_update_ftr_reg(SYS_ID_AA64PFR2_EL1, cpu,
+				      info->reg_id_aa64pfr2, boot->reg_id_aa64pfr2);
 
 	taint |= check_update_ftr_reg(SYS_ID_AA64ZFR0_EL1, cpu,
 				      info->reg_id_aa64zfr0, boot->reg_id_aa64zfr0);
@@ -1317,6 +1339,9 @@ void update_cpu_features(int cpu,
 	taint |= check_update_ftr_reg(SYS_ID_AA64SMFR0_EL1, cpu,
 				      info->reg_id_aa64smfr0, boot->reg_id_aa64smfr0);
 
+	taint |= check_update_ftr_reg(SYS_ID_AA64FPFR0_EL1, cpu,
+				      info->reg_id_aa64fpfr0, boot->reg_id_aa64fpfr0);
+
 	/* Probe vector lengths */
 	if (IS_ENABLED(CONFIG_ARM64_SVE) &&
 	    id_aa64pfr0_sve(read_sanitised_ftr_reg(SYS_ID_AA64PFR0_EL1))) {
@@ -1429,8 +1454,10 @@ u64 __read_sysreg_by_encoding(u32 sys_id)
 
 	read_sysreg_case(SYS_ID_AA64PFR0_EL1);
 	read_sysreg_case(SYS_ID_AA64PFR1_EL1);
+	read_sysreg_case(SYS_ID_AA64PFR2_EL1);
 	read_sysreg_case(SYS_ID_AA64ZFR0_EL1);
 	read_sysreg_case(SYS_ID_AA64SMFR0_EL1);
+	read_sysreg_case(SYS_ID_AA64FPFR0_EL1);
 	read_sysreg_case(SYS_ID_AA64DFR0_EL1);
 	read_sysreg_case(SYS_ID_AA64DFR1_EL1);
 	read_sysreg_case(SYS_ID_AA64MMFR0_EL1);
@@ -1440,6 +1467,7 @@ u64 __read_sysreg_by_encoding(u32 sys_id)
 	read_sysreg_case(SYS_ID_AA64ISAR0_EL1);
 	read_sysreg_case(SYS_ID_AA64ISAR1_EL1);
 	read_sysreg_case(SYS_ID_AA64ISAR2_EL1);
+	read_sysreg_case(SYS_ID_AA64ISAR3_EL1);
 
 	read_sysreg_case(SYS_CNTFRQ_EL0);
 	read_sysreg_case(SYS_CTR_EL0);
diff --git a/arch/arm64/kernel/cpuinfo.c b/arch/arm64/kernel/cpuinfo.c
index a257da7b56fe..8322e968fd0d 100644
--- a/arch/arm64/kernel/cpuinfo.c
+++ b/arch/arm64/kernel/cpuinfo.c
@@ -448,14 +448,17 @@ static void __cpuinfo_store_cpu(struct cpuinfo_arm64 *info)
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


