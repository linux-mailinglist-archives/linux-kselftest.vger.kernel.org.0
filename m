Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACB0B470914
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Dec 2021 19:44:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237523AbhLJSrg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 10 Dec 2021 13:47:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237207AbhLJSrf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 10 Dec 2021 13:47:35 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 218ECC061746
        for <linux-kselftest@vger.kernel.org>; Fri, 10 Dec 2021 10:44:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 36E63CE2C8E
        for <linux-kselftest@vger.kernel.org>; Fri, 10 Dec 2021 18:43:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BAB6C341CC;
        Fri, 10 Dec 2021 18:43:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639161836;
        bh=kwQHg7mnNHuLQFDl2yrEF2wymwTBQvgzBbrgS9dPDQc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SOQ3GzBZexfNqJSNw+KdU7trjpWmXHwnWyBgh2H2dKk/zoGvasyVM25g+cPq9/PHR
         nEp+axcHxF2sRdoP6rhIRqD6EQz9I2QGR9m6y+hAqha+/i2N/TzUGJsNDzoaTqs9Yd
         onKJacZovPE4XO3t3PEWeqKJAPkvHfZkgC0wJYEl2Q9vgJ6C3DORh30ZxcHtf7Bh95
         jrGNe6cjOaqfbLaC8SuSxrFYDS3rsnD/TT58tv2E/A8sUli4vIUiVBbctV5gcRUm8X
         uSkSHMIOEYgxHpy7yH5OPapfmPOqTsWZPv55eVWlZpVn984xXzbcrR05mVPH12T5qn
         Q57pVta06EbtQ==
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
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH v7 07/37] arm64: cpufeature: Always specify and use a field width for capabilities
Date:   Fri, 10 Dec 2021 18:41:03 +0000
Message-Id: <20211210184133.320748-8-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211210184133.320748-1-broonie@kernel.org>
References: <20211210184133.320748-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=26281; h=from:subject; bh=kwQHg7mnNHuLQFDl2yrEF2wymwTBQvgzBbrgS9dPDQc=; b=owGbwMvMwMWocq27KDak/QLjabUkhsTN8523PRFt2SQlJ+dokuSwXXS5Qe9K/uygx/8mJh7tqmeq m+vTyWjMwsDIxSArpsiy9lnGqvRwia3zH81/BTOIlQlkCgMXpwBcZDr7/4hnoSk2W0wsAzasWLd/78 vVCUfnv7KqM5besObaDjMx5ufvuDyZnPrEXCLSbk17m6kp8Fn6aui7gvPVNYrf9kxczrDnwet0p5zb JXmH933SlZ+/NddCWpaTeapmYGv6prc5KhvtbQy8op01rrW7zVjkG+bhcVHrWVZOmKTMu3n/Zwfcrf VqmsJY2buGMbLhdLn2xOuLE3cfiNv2guHZiRVySz68MdTynb9XyW4+l8Fs2dbDOyz5IjXtVvz9pC/z xpdd+KOTskPt9z0H39rq9z+vbVKo6tvOfzW/9Og3ryNel62UEhwXdLEV+DjdifTLqBDwbLadl7zA/o AGa0OwhHvNhU2Gqj+eHrp+ZvUuAA==
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Since all the fields in the main ID registers are 4 bits wide we have up
until now not bothered specifying the width in the code. Since we now
wish to use this mechanism to enumerate features from the floating point
feature registers which do not follow this pattern add a width to the
table.  This means updating all the existing table entries but makes it
less likely that we run into issues in future due to implicitly assuming
a 4 bit width.

Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 arch/arm64/include/asm/cpufeature.h |   1 +
 arch/arm64/kernel/cpufeature.c      | 163 +++++++++++++++++-----------
 2 files changed, 100 insertions(+), 64 deletions(-)

diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index ef6be92b1921..2728abd9cae4 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -356,6 +356,7 @@ struct arm64_cpu_capabilities {
 		struct {	/* Feature register checking */
 			u32 sys_reg;
 			u8 field_pos;
+			u8 field_width;
 			u8 min_field_value;
 			u8 hwcap_type;
 			bool sign;
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 6f3e677d88f1..cbeea7a2475c 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -1296,7 +1296,9 @@ u64 __read_sysreg_by_encoding(u32 sys_id)
 static bool
 feature_matches(u64 reg, const struct arm64_cpu_capabilities *entry)
 {
-	int val = cpuid_feature_extract_field(reg, entry->field_pos, entry->sign);
+	int val = cpuid_feature_extract_field_width(reg, entry->field_pos,
+						    entry->field_width,
+						    entry->sign);
 
 	return val >= entry->min_field_value;
 }
@@ -1941,6 +1943,7 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 		.matches = has_cpuid_feature,
 		.sys_reg = SYS_ID_AA64MMFR0_EL1,
 		.field_pos = ID_AA64MMFR0_ECV_SHIFT,
+		.field_width = 4,
 		.sign = FTR_UNSIGNED,
 		.min_field_value = 1,
 	},
@@ -1952,6 +1955,7 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 		.matches = has_cpuid_feature,
 		.sys_reg = SYS_ID_AA64MMFR1_EL1,
 		.field_pos = ID_AA64MMFR1_PAN_SHIFT,
+		.field_width = 4,
 		.sign = FTR_UNSIGNED,
 		.min_field_value = 1,
 		.cpu_enable = cpu_enable_pan,
@@ -1965,6 +1969,7 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 		.matches = has_cpuid_feature,
 		.sys_reg = SYS_ID_AA64MMFR1_EL1,
 		.field_pos = ID_AA64MMFR1_PAN_SHIFT,
+		.field_width = 4,
 		.sign = FTR_UNSIGNED,
 		.min_field_value = 3,
 	},
@@ -1977,6 +1982,7 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 		.matches = has_cpuid_feature,
 		.sys_reg = SYS_ID_AA64ISAR0_EL1,
 		.field_pos = ID_AA64ISAR0_ATOMICS_SHIFT,
+		.field_width = 4,
 		.sign = FTR_UNSIGNED,
 		.min_field_value = 2,
 	},
@@ -2001,6 +2007,7 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 		.sys_reg = SYS_ID_AA64PFR0_EL1,
 		.sign = FTR_UNSIGNED,
 		.field_pos = ID_AA64PFR0_EL0_SHIFT,
+		.field_width = 4,
 		.min_field_value = ID_AA64PFR0_ELx_32BIT_64BIT,
 	},
 #ifdef CONFIG_KVM
@@ -2012,6 +2019,7 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 		.sys_reg = SYS_ID_AA64PFR0_EL1,
 		.sign = FTR_UNSIGNED,
 		.field_pos = ID_AA64PFR0_EL1_SHIFT,
+		.field_width = 4,
 		.min_field_value = ID_AA64PFR0_ELx_32BIT_64BIT,
 	},
 	{
@@ -2032,6 +2040,7 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 		 */
 		.sys_reg = SYS_ID_AA64PFR0_EL1,
 		.field_pos = ID_AA64PFR0_CSV3_SHIFT,
+		.field_width = 4,
 		.min_field_value = 1,
 		.matches = unmap_kernel_at_el0,
 		.cpu_enable = kpti_install_ng_mappings,
@@ -2051,6 +2060,7 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 		.matches = has_cpuid_feature,
 		.sys_reg = SYS_ID_AA64ISAR1_EL1,
 		.field_pos = ID_AA64ISAR1_DPB_SHIFT,
+		.field_width = 4,
 		.min_field_value = 1,
 	},
 	{
@@ -2061,6 +2071,7 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 		.sys_reg = SYS_ID_AA64ISAR1_EL1,
 		.sign = FTR_UNSIGNED,
 		.field_pos = ID_AA64ISAR1_DPB_SHIFT,
+		.field_width = 4,
 		.min_field_value = 2,
 	},
 #endif
@@ -2072,6 +2083,7 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 		.sys_reg = SYS_ID_AA64PFR0_EL1,
 		.sign = FTR_UNSIGNED,
 		.field_pos = ID_AA64PFR0_SVE_SHIFT,
+		.field_width = 4,
 		.min_field_value = ID_AA64PFR0_SVE,
 		.matches = has_cpuid_feature,
 		.cpu_enable = sve_kernel_enable,
@@ -2086,6 +2098,7 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 		.sys_reg = SYS_ID_AA64PFR0_EL1,
 		.sign = FTR_UNSIGNED,
 		.field_pos = ID_AA64PFR0_RAS_SHIFT,
+		.field_width = 4,
 		.min_field_value = ID_AA64PFR0_RAS_V1,
 		.cpu_enable = cpu_clear_disr,
 	},
@@ -2104,6 +2117,7 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 		.sys_reg = SYS_ID_AA64PFR0_EL1,
 		.sign = FTR_UNSIGNED,
 		.field_pos = ID_AA64PFR0_AMU_SHIFT,
+		.field_width = 4,
 		.min_field_value = ID_AA64PFR0_AMU,
 		.cpu_enable = cpu_amu_enable,
 	},
@@ -2128,6 +2142,7 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 		.sys_reg = SYS_ID_AA64MMFR2_EL1,
 		.sign = FTR_UNSIGNED,
 		.field_pos = ID_AA64MMFR2_FWB_SHIFT,
+		.field_width = 4,
 		.min_field_value = 1,
 		.matches = has_cpuid_feature,
 		.cpu_enable = cpu_has_fwb,
@@ -2139,6 +2154,7 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 		.sys_reg = SYS_ID_AA64MMFR2_EL1,
 		.sign = FTR_UNSIGNED,
 		.field_pos = ID_AA64MMFR2_TTL_SHIFT,
+		.field_width = 4,
 		.min_field_value = 1,
 		.matches = has_cpuid_feature,
 	},
@@ -2149,6 +2165,7 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 		.matches = has_cpuid_feature,
 		.sys_reg = SYS_ID_AA64ISAR0_EL1,
 		.field_pos = ID_AA64ISAR0_TLB_SHIFT,
+		.field_width = 4,
 		.sign = FTR_UNSIGNED,
 		.min_field_value = ID_AA64ISAR0_TLB_RANGE,
 	},
@@ -2167,6 +2184,7 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 		.sys_reg = SYS_ID_AA64MMFR1_EL1,
 		.sign = FTR_UNSIGNED,
 		.field_pos = ID_AA64MMFR1_HADBS_SHIFT,
+		.field_width = 4,
 		.min_field_value = 2,
 		.matches = has_hw_dbm,
 		.cpu_enable = cpu_enable_hw_dbm,
@@ -2179,6 +2197,7 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 		.matches = has_cpuid_feature,
 		.sys_reg = SYS_ID_AA64ISAR0_EL1,
 		.field_pos = ID_AA64ISAR0_CRC32_SHIFT,
+		.field_width = 4,
 		.min_field_value = 1,
 	},
 	{
@@ -2188,6 +2207,7 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 		.matches = has_cpuid_feature,
 		.sys_reg = SYS_ID_AA64PFR1_EL1,
 		.field_pos = ID_AA64PFR1_SSBS_SHIFT,
+		.field_width = 4,
 		.sign = FTR_UNSIGNED,
 		.min_field_value = ID_AA64PFR1_SSBS_PSTATE_ONLY,
 	},
@@ -2200,6 +2220,7 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 		.sys_reg = SYS_ID_AA64MMFR2_EL1,
 		.sign = FTR_UNSIGNED,
 		.field_pos = ID_AA64MMFR2_CNP_SHIFT,
+		.field_width = 4,
 		.min_field_value = 1,
 		.cpu_enable = cpu_enable_cnp,
 	},
@@ -2211,6 +2232,7 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 		.matches = has_cpuid_feature,
 		.sys_reg = SYS_ID_AA64ISAR1_EL1,
 		.field_pos = ID_AA64ISAR1_SB_SHIFT,
+		.field_width = 4,
 		.sign = FTR_UNSIGNED,
 		.min_field_value = 1,
 	},
@@ -2222,6 +2244,7 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 		.sys_reg = SYS_ID_AA64ISAR1_EL1,
 		.sign = FTR_UNSIGNED,
 		.field_pos = ID_AA64ISAR1_APA_SHIFT,
+		.field_width = 4,
 		.min_field_value = ID_AA64ISAR1_APA_ARCHITECTED,
 		.matches = has_address_auth_cpucap,
 	},
@@ -2232,6 +2255,7 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 		.sys_reg = SYS_ID_AA64ISAR1_EL1,
 		.sign = FTR_UNSIGNED,
 		.field_pos = ID_AA64ISAR1_API_SHIFT,
+		.field_width = 4,
 		.min_field_value = ID_AA64ISAR1_API_IMP_DEF,
 		.matches = has_address_auth_cpucap,
 	},
@@ -2247,6 +2271,7 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 		.sys_reg = SYS_ID_AA64ISAR1_EL1,
 		.sign = FTR_UNSIGNED,
 		.field_pos = ID_AA64ISAR1_GPA_SHIFT,
+		.field_width = 4,
 		.min_field_value = ID_AA64ISAR1_GPA_ARCHITECTED,
 		.matches = has_cpuid_feature,
 	},
@@ -2257,6 +2282,7 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 		.sys_reg = SYS_ID_AA64ISAR1_EL1,
 		.sign = FTR_UNSIGNED,
 		.field_pos = ID_AA64ISAR1_GPI_SHIFT,
+		.field_width = 4,
 		.min_field_value = ID_AA64ISAR1_GPI_IMP_DEF,
 		.matches = has_cpuid_feature,
 	},
@@ -2277,6 +2303,7 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 		.matches = can_use_gic_priorities,
 		.sys_reg = SYS_ID_AA64PFR0_EL1,
 		.field_pos = ID_AA64PFR0_GIC_SHIFT,
+		.field_width = 4,
 		.sign = FTR_UNSIGNED,
 		.min_field_value = 1,
 	},
@@ -2288,6 +2315,7 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 		.type = ARM64_CPUCAP_SYSTEM_FEATURE,
 		.sys_reg = SYS_ID_AA64MMFR2_EL1,
 		.sign = FTR_UNSIGNED,
+		.field_width = 4,
 		.field_pos = ID_AA64MMFR2_E0PD_SHIFT,
 		.matches = has_cpuid_feature,
 		.min_field_value = 1,
@@ -2302,6 +2330,7 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 		.matches = has_cpuid_feature,
 		.sys_reg = SYS_ID_AA64ISAR0_EL1,
 		.field_pos = ID_AA64ISAR0_RNDR_SHIFT,
+		.field_width = 4,
 		.sign = FTR_UNSIGNED,
 		.min_field_value = 1,
 	},
@@ -2319,6 +2348,7 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 		.cpu_enable = bti_enable,
 		.sys_reg = SYS_ID_AA64PFR1_EL1,
 		.field_pos = ID_AA64PFR1_BT_SHIFT,
+		.field_width = 4,
 		.min_field_value = ID_AA64PFR1_BT_BTI,
 		.sign = FTR_UNSIGNED,
 	},
@@ -2331,6 +2361,7 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 		.matches = has_cpuid_feature,
 		.sys_reg = SYS_ID_AA64PFR1_EL1,
 		.field_pos = ID_AA64PFR1_MTE_SHIFT,
+		.field_width = 4,
 		.min_field_value = ID_AA64PFR1_MTE,
 		.sign = FTR_UNSIGNED,
 		.cpu_enable = cpu_enable_mte,
@@ -2342,6 +2373,7 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 		.matches = has_cpuid_feature,
 		.sys_reg = SYS_ID_AA64PFR1_EL1,
 		.field_pos = ID_AA64PFR1_MTE_SHIFT,
+		.field_width = 4,
 		.min_field_value = ID_AA64PFR1_MTE_ASYMM,
 		.sign = FTR_UNSIGNED,
 	},
@@ -2353,16 +2385,18 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 		.sys_reg = SYS_ID_AA64ISAR1_EL1,
 		.sign = FTR_UNSIGNED,
 		.field_pos = ID_AA64ISAR1_LRCPC_SHIFT,
+		.field_width = 4,
 		.matches = has_cpuid_feature,
 		.min_field_value = 1,
 	},
 	{},
 };
 
-#define HWCAP_CPUID_MATCH(reg, field, s, min_value)				\
+#define HWCAP_CPUID_MATCH(reg, field, width, s, min_value)			\
 		.matches = has_cpuid_feature,					\
 		.sys_reg = reg,							\
 		.field_pos = field,						\
+		.field_width = width,						\
 		.sign = s,							\
 		.min_field_value = min_value,
 
@@ -2372,10 +2406,10 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 		.hwcap_type = cap_type,						\
 		.hwcap = cap,							\
 
-#define HWCAP_CAP(reg, field, s, min_value, cap_type, cap)			\
+#define HWCAP_CAP(reg, field, width, s, min_value, cap_type, cap)		\
 	{									\
 		__HWCAP_CAP(#cap, cap_type, cap)				\
-		HWCAP_CPUID_MATCH(reg, field, s, min_value)			\
+		HWCAP_CPUID_MATCH(reg, field, width, s, min_value) 		\
 	}
 
 #define HWCAP_MULTI_CAP(list, cap_type, cap)					\
@@ -2395,11 +2429,12 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 static const struct arm64_cpu_capabilities ptr_auth_hwcap_addr_matches[] = {
 	{
 		HWCAP_CPUID_MATCH(SYS_ID_AA64ISAR1_EL1, ID_AA64ISAR1_APA_SHIFT,
-				  FTR_UNSIGNED, ID_AA64ISAR1_APA_ARCHITECTED)
+				  4, FTR_UNSIGNED,
+				  ID_AA64ISAR1_APA_ARCHITECTED)
 	},
 	{
 		HWCAP_CPUID_MATCH(SYS_ID_AA64ISAR1_EL1, ID_AA64ISAR1_API_SHIFT,
-				  FTR_UNSIGNED, ID_AA64ISAR1_API_IMP_DEF)
+				  4, FTR_UNSIGNED, ID_AA64ISAR1_API_IMP_DEF)
 	},
 	{},
 };
@@ -2407,75 +2442,75 @@ static const struct arm64_cpu_capabilities ptr_auth_hwcap_addr_matches[] = {
 static const struct arm64_cpu_capabilities ptr_auth_hwcap_gen_matches[] = {
 	{
 		HWCAP_CPUID_MATCH(SYS_ID_AA64ISAR1_EL1, ID_AA64ISAR1_GPA_SHIFT,
-				  FTR_UNSIGNED, ID_AA64ISAR1_GPA_ARCHITECTED)
+				  4, FTR_UNSIGNED, ID_AA64ISAR1_GPA_ARCHITECTED)
 	},
 	{
 		HWCAP_CPUID_MATCH(SYS_ID_AA64ISAR1_EL1, ID_AA64ISAR1_GPI_SHIFT,
-				  FTR_UNSIGNED, ID_AA64ISAR1_GPI_IMP_DEF)
+				  4, FTR_UNSIGNED, ID_AA64ISAR1_GPI_IMP_DEF)
 	},
 	{},
 };
 #endif
 
 static const struct arm64_cpu_capabilities arm64_elf_hwcaps[] = {
-	HWCAP_CAP(SYS_ID_AA64ISAR0_EL1, ID_AA64ISAR0_AES_SHIFT, FTR_UNSIGNED, 2, CAP_HWCAP, KERNEL_HWCAP_PMULL),
-	HWCAP_CAP(SYS_ID_AA64ISAR0_EL1, ID_AA64ISAR0_AES_SHIFT, FTR_UNSIGNED, 1, CAP_HWCAP, KERNEL_HWCAP_AES),
-	HWCAP_CAP(SYS_ID_AA64ISAR0_EL1, ID_AA64ISAR0_SHA1_SHIFT, FTR_UNSIGNED, 1, CAP_HWCAP, KERNEL_HWCAP_SHA1),
-	HWCAP_CAP(SYS_ID_AA64ISAR0_EL1, ID_AA64ISAR0_SHA2_SHIFT, FTR_UNSIGNED, 1, CAP_HWCAP, KERNEL_HWCAP_SHA2),
-	HWCAP_CAP(SYS_ID_AA64ISAR0_EL1, ID_AA64ISAR0_SHA2_SHIFT, FTR_UNSIGNED, 2, CAP_HWCAP, KERNEL_HWCAP_SHA512),
-	HWCAP_CAP(SYS_ID_AA64ISAR0_EL1, ID_AA64ISAR0_CRC32_SHIFT, FTR_UNSIGNED, 1, CAP_HWCAP, KERNEL_HWCAP_CRC32),
-	HWCAP_CAP(SYS_ID_AA64ISAR0_EL1, ID_AA64ISAR0_ATOMICS_SHIFT, FTR_UNSIGNED, 2, CAP_HWCAP, KERNEL_HWCAP_ATOMICS),
-	HWCAP_CAP(SYS_ID_AA64ISAR0_EL1, ID_AA64ISAR0_RDM_SHIFT, FTR_UNSIGNED, 1, CAP_HWCAP, KERNEL_HWCAP_ASIMDRDM),
-	HWCAP_CAP(SYS_ID_AA64ISAR0_EL1, ID_AA64ISAR0_SHA3_SHIFT, FTR_UNSIGNED, 1, CAP_HWCAP, KERNEL_HWCAP_SHA3),
-	HWCAP_CAP(SYS_ID_AA64ISAR0_EL1, ID_AA64ISAR0_SM3_SHIFT, FTR_UNSIGNED, 1, CAP_HWCAP, KERNEL_HWCAP_SM3),
-	HWCAP_CAP(SYS_ID_AA64ISAR0_EL1, ID_AA64ISAR0_SM4_SHIFT, FTR_UNSIGNED, 1, CAP_HWCAP, KERNEL_HWCAP_SM4),
-	HWCAP_CAP(SYS_ID_AA64ISAR0_EL1, ID_AA64ISAR0_DP_SHIFT, FTR_UNSIGNED, 1, CAP_HWCAP, KERNEL_HWCAP_ASIMDDP),
-	HWCAP_CAP(SYS_ID_AA64ISAR0_EL1, ID_AA64ISAR0_FHM_SHIFT, FTR_UNSIGNED, 1, CAP_HWCAP, KERNEL_HWCAP_ASIMDFHM),
-	HWCAP_CAP(SYS_ID_AA64ISAR0_EL1, ID_AA64ISAR0_TS_SHIFT, FTR_UNSIGNED, 1, CAP_HWCAP, KERNEL_HWCAP_FLAGM),
-	HWCAP_CAP(SYS_ID_AA64ISAR0_EL1, ID_AA64ISAR0_TS_SHIFT, FTR_UNSIGNED, 2, CAP_HWCAP, KERNEL_HWCAP_FLAGM2),
-	HWCAP_CAP(SYS_ID_AA64ISAR0_EL1, ID_AA64ISAR0_RNDR_SHIFT, FTR_UNSIGNED, 1, CAP_HWCAP, KERNEL_HWCAP_RNG),
-	HWCAP_CAP(SYS_ID_AA64PFR0_EL1, ID_AA64PFR0_FP_SHIFT, FTR_SIGNED, 0, CAP_HWCAP, KERNEL_HWCAP_FP),
-	HWCAP_CAP(SYS_ID_AA64PFR0_EL1, ID_AA64PFR0_FP_SHIFT, FTR_SIGNED, 1, CAP_HWCAP, KERNEL_HWCAP_FPHP),
-	HWCAP_CAP(SYS_ID_AA64PFR0_EL1, ID_AA64PFR0_ASIMD_SHIFT, FTR_SIGNED, 0, CAP_HWCAP, KERNEL_HWCAP_ASIMD),
-	HWCAP_CAP(SYS_ID_AA64PFR0_EL1, ID_AA64PFR0_ASIMD_SHIFT, FTR_SIGNED, 1, CAP_HWCAP, KERNEL_HWCAP_ASIMDHP),
-	HWCAP_CAP(SYS_ID_AA64PFR0_EL1, ID_AA64PFR0_DIT_SHIFT, FTR_SIGNED, 1, CAP_HWCAP, KERNEL_HWCAP_DIT),
-	HWCAP_CAP(SYS_ID_AA64ISAR1_EL1, ID_AA64ISAR1_DPB_SHIFT, FTR_UNSIGNED, 1, CAP_HWCAP, KERNEL_HWCAP_DCPOP),
-	HWCAP_CAP(SYS_ID_AA64ISAR1_EL1, ID_AA64ISAR1_DPB_SHIFT, FTR_UNSIGNED, 2, CAP_HWCAP, KERNEL_HWCAP_DCPODP),
-	HWCAP_CAP(SYS_ID_AA64ISAR1_EL1, ID_AA64ISAR1_JSCVT_SHIFT, FTR_UNSIGNED, 1, CAP_HWCAP, KERNEL_HWCAP_JSCVT),
-	HWCAP_CAP(SYS_ID_AA64ISAR1_EL1, ID_AA64ISAR1_FCMA_SHIFT, FTR_UNSIGNED, 1, CAP_HWCAP, KERNEL_HWCAP_FCMA),
-	HWCAP_CAP(SYS_ID_AA64ISAR1_EL1, ID_AA64ISAR1_LRCPC_SHIFT, FTR_UNSIGNED, 1, CAP_HWCAP, KERNEL_HWCAP_LRCPC),
-	HWCAP_CAP(SYS_ID_AA64ISAR1_EL1, ID_AA64ISAR1_LRCPC_SHIFT, FTR_UNSIGNED, 2, CAP_HWCAP, KERNEL_HWCAP_ILRCPC),
-	HWCAP_CAP(SYS_ID_AA64ISAR1_EL1, ID_AA64ISAR1_FRINTTS_SHIFT, FTR_UNSIGNED, 1, CAP_HWCAP, KERNEL_HWCAP_FRINT),
-	HWCAP_CAP(SYS_ID_AA64ISAR1_EL1, ID_AA64ISAR1_SB_SHIFT, FTR_UNSIGNED, 1, CAP_HWCAP, KERNEL_HWCAP_SB),
-	HWCAP_CAP(SYS_ID_AA64ISAR1_EL1, ID_AA64ISAR1_BF16_SHIFT, FTR_UNSIGNED, 1, CAP_HWCAP, KERNEL_HWCAP_BF16),
-	HWCAP_CAP(SYS_ID_AA64ISAR1_EL1, ID_AA64ISAR1_DGH_SHIFT, FTR_UNSIGNED, 1, CAP_HWCAP, KERNEL_HWCAP_DGH),
-	HWCAP_CAP(SYS_ID_AA64ISAR1_EL1, ID_AA64ISAR1_I8MM_SHIFT, FTR_UNSIGNED, 1, CAP_HWCAP, KERNEL_HWCAP_I8MM),
-	HWCAP_CAP(SYS_ID_AA64MMFR2_EL1, ID_AA64MMFR2_AT_SHIFT, FTR_UNSIGNED, 1, CAP_HWCAP, KERNEL_HWCAP_USCAT),
+	HWCAP_CAP(SYS_ID_AA64ISAR0_EL1, ID_AA64ISAR0_AES_SHIFT, 4, FTR_UNSIGNED, 2, CAP_HWCAP, KERNEL_HWCAP_PMULL),
+	HWCAP_CAP(SYS_ID_AA64ISAR0_EL1, ID_AA64ISAR0_AES_SHIFT, 4, FTR_UNSIGNED, 1, CAP_HWCAP, KERNEL_HWCAP_AES),
+	HWCAP_CAP(SYS_ID_AA64ISAR0_EL1, ID_AA64ISAR0_SHA1_SHIFT, 4, FTR_UNSIGNED, 1, CAP_HWCAP, KERNEL_HWCAP_SHA1),
+	HWCAP_CAP(SYS_ID_AA64ISAR0_EL1, ID_AA64ISAR0_SHA2_SHIFT, 4, FTR_UNSIGNED, 1, CAP_HWCAP, KERNEL_HWCAP_SHA2),
+	HWCAP_CAP(SYS_ID_AA64ISAR0_EL1, ID_AA64ISAR0_SHA2_SHIFT, 4, FTR_UNSIGNED, 2, CAP_HWCAP, KERNEL_HWCAP_SHA512),
+	HWCAP_CAP(SYS_ID_AA64ISAR0_EL1, ID_AA64ISAR0_CRC32_SHIFT, 4, FTR_UNSIGNED, 1, CAP_HWCAP, KERNEL_HWCAP_CRC32),
+	HWCAP_CAP(SYS_ID_AA64ISAR0_EL1, ID_AA64ISAR0_ATOMICS_SHIFT, 4, FTR_UNSIGNED, 2, CAP_HWCAP, KERNEL_HWCAP_ATOMICS),
+	HWCAP_CAP(SYS_ID_AA64ISAR0_EL1, ID_AA64ISAR0_RDM_SHIFT, 4, FTR_UNSIGNED, 1, CAP_HWCAP, KERNEL_HWCAP_ASIMDRDM),
+	HWCAP_CAP(SYS_ID_AA64ISAR0_EL1, ID_AA64ISAR0_SHA3_SHIFT, 4, FTR_UNSIGNED, 1, CAP_HWCAP, KERNEL_HWCAP_SHA3),
+	HWCAP_CAP(SYS_ID_AA64ISAR0_EL1, ID_AA64ISAR0_SM3_SHIFT, 4, FTR_UNSIGNED, 1, CAP_HWCAP, KERNEL_HWCAP_SM3),
+	HWCAP_CAP(SYS_ID_AA64ISAR0_EL1, ID_AA64ISAR0_SM4_SHIFT, 4, FTR_UNSIGNED, 1, CAP_HWCAP, KERNEL_HWCAP_SM4),
+	HWCAP_CAP(SYS_ID_AA64ISAR0_EL1, ID_AA64ISAR0_DP_SHIFT, 4, FTR_UNSIGNED, 1, CAP_HWCAP, KERNEL_HWCAP_ASIMDDP),
+	HWCAP_CAP(SYS_ID_AA64ISAR0_EL1, ID_AA64ISAR0_FHM_SHIFT, 4, FTR_UNSIGNED, 1, CAP_HWCAP, KERNEL_HWCAP_ASIMDFHM),
+	HWCAP_CAP(SYS_ID_AA64ISAR0_EL1, ID_AA64ISAR0_TS_SHIFT, 4, FTR_UNSIGNED, 1, CAP_HWCAP, KERNEL_HWCAP_FLAGM),
+	HWCAP_CAP(SYS_ID_AA64ISAR0_EL1, ID_AA64ISAR0_TS_SHIFT, 4, FTR_UNSIGNED, 2, CAP_HWCAP, KERNEL_HWCAP_FLAGM2),
+	HWCAP_CAP(SYS_ID_AA64ISAR0_EL1, ID_AA64ISAR0_RNDR_SHIFT, 4, FTR_UNSIGNED, 1, CAP_HWCAP, KERNEL_HWCAP_RNG),
+	HWCAP_CAP(SYS_ID_AA64PFR0_EL1, ID_AA64PFR0_FP_SHIFT, 4, FTR_SIGNED, 0, CAP_HWCAP, KERNEL_HWCAP_FP),
+	HWCAP_CAP(SYS_ID_AA64PFR0_EL1, ID_AA64PFR0_FP_SHIFT, 4, FTR_SIGNED, 1, CAP_HWCAP, KERNEL_HWCAP_FPHP),
+	HWCAP_CAP(SYS_ID_AA64PFR0_EL1, ID_AA64PFR0_ASIMD_SHIFT, 4, FTR_SIGNED, 0, CAP_HWCAP, KERNEL_HWCAP_ASIMD),
+	HWCAP_CAP(SYS_ID_AA64PFR0_EL1, ID_AA64PFR0_ASIMD_SHIFT, 4, FTR_SIGNED, 1, CAP_HWCAP, KERNEL_HWCAP_ASIMDHP),
+	HWCAP_CAP(SYS_ID_AA64PFR0_EL1, ID_AA64PFR0_DIT_SHIFT, 4, FTR_SIGNED, 1, CAP_HWCAP, KERNEL_HWCAP_DIT),
+	HWCAP_CAP(SYS_ID_AA64ISAR1_EL1, ID_AA64ISAR1_DPB_SHIFT, 4, FTR_UNSIGNED, 1, CAP_HWCAP, KERNEL_HWCAP_DCPOP),
+	HWCAP_CAP(SYS_ID_AA64ISAR1_EL1, ID_AA64ISAR1_DPB_SHIFT, 4, FTR_UNSIGNED, 2, CAP_HWCAP, KERNEL_HWCAP_DCPODP),
+	HWCAP_CAP(SYS_ID_AA64ISAR1_EL1, ID_AA64ISAR1_JSCVT_SHIFT, 4, FTR_UNSIGNED, 1, CAP_HWCAP, KERNEL_HWCAP_JSCVT),
+	HWCAP_CAP(SYS_ID_AA64ISAR1_EL1, ID_AA64ISAR1_FCMA_SHIFT, 4, FTR_UNSIGNED, 1, CAP_HWCAP, KERNEL_HWCAP_FCMA),
+	HWCAP_CAP(SYS_ID_AA64ISAR1_EL1, ID_AA64ISAR1_LRCPC_SHIFT, 4, FTR_UNSIGNED, 1, CAP_HWCAP, KERNEL_HWCAP_LRCPC),
+	HWCAP_CAP(SYS_ID_AA64ISAR1_EL1, ID_AA64ISAR1_LRCPC_SHIFT, 4, FTR_UNSIGNED, 2, CAP_HWCAP, KERNEL_HWCAP_ILRCPC),
+	HWCAP_CAP(SYS_ID_AA64ISAR1_EL1, ID_AA64ISAR1_FRINTTS_SHIFT, 4, FTR_UNSIGNED, 1, CAP_HWCAP, KERNEL_HWCAP_FRINT),
+	HWCAP_CAP(SYS_ID_AA64ISAR1_EL1, ID_AA64ISAR1_SB_SHIFT, 4, FTR_UNSIGNED, 1, CAP_HWCAP, KERNEL_HWCAP_SB),
+	HWCAP_CAP(SYS_ID_AA64ISAR1_EL1, ID_AA64ISAR1_BF16_SHIFT, 4, FTR_UNSIGNED, 1, CAP_HWCAP, KERNEL_HWCAP_BF16),
+	HWCAP_CAP(SYS_ID_AA64ISAR1_EL1, ID_AA64ISAR1_DGH_SHIFT, 4, FTR_UNSIGNED, 1, CAP_HWCAP, KERNEL_HWCAP_DGH),
+	HWCAP_CAP(SYS_ID_AA64ISAR1_EL1, ID_AA64ISAR1_I8MM_SHIFT, 4, FTR_UNSIGNED, 1, CAP_HWCAP, KERNEL_HWCAP_I8MM),
+	HWCAP_CAP(SYS_ID_AA64MMFR2_EL1, ID_AA64MMFR2_AT_SHIFT, 4, FTR_UNSIGNED, 1, CAP_HWCAP, KERNEL_HWCAP_USCAT),
 #ifdef CONFIG_ARM64_SVE
-	HWCAP_CAP(SYS_ID_AA64PFR0_EL1, ID_AA64PFR0_SVE_SHIFT, FTR_UNSIGNED, ID_AA64PFR0_SVE, CAP_HWCAP, KERNEL_HWCAP_SVE),
-	HWCAP_CAP(SYS_ID_AA64ZFR0_EL1, ID_AA64ZFR0_SVEVER_SHIFT, FTR_UNSIGNED, ID_AA64ZFR0_SVEVER_SVE2, CAP_HWCAP, KERNEL_HWCAP_SVE2),
-	HWCAP_CAP(SYS_ID_AA64ZFR0_EL1, ID_AA64ZFR0_AES_SHIFT, FTR_UNSIGNED, ID_AA64ZFR0_AES, CAP_HWCAP, KERNEL_HWCAP_SVEAES),
-	HWCAP_CAP(SYS_ID_AA64ZFR0_EL1, ID_AA64ZFR0_AES_SHIFT, FTR_UNSIGNED, ID_AA64ZFR0_AES_PMULL, CAP_HWCAP, KERNEL_HWCAP_SVEPMULL),
-	HWCAP_CAP(SYS_ID_AA64ZFR0_EL1, ID_AA64ZFR0_BITPERM_SHIFT, FTR_UNSIGNED, ID_AA64ZFR0_BITPERM, CAP_HWCAP, KERNEL_HWCAP_SVEBITPERM),
-	HWCAP_CAP(SYS_ID_AA64ZFR0_EL1, ID_AA64ZFR0_BF16_SHIFT, FTR_UNSIGNED, ID_AA64ZFR0_BF16, CAP_HWCAP, KERNEL_HWCAP_SVEBF16),
-	HWCAP_CAP(SYS_ID_AA64ZFR0_EL1, ID_AA64ZFR0_SHA3_SHIFT, FTR_UNSIGNED, ID_AA64ZFR0_SHA3, CAP_HWCAP, KERNEL_HWCAP_SVESHA3),
-	HWCAP_CAP(SYS_ID_AA64ZFR0_EL1, ID_AA64ZFR0_SM4_SHIFT, FTR_UNSIGNED, ID_AA64ZFR0_SM4, CAP_HWCAP, KERNEL_HWCAP_SVESM4),
-	HWCAP_CAP(SYS_ID_AA64ZFR0_EL1, ID_AA64ZFR0_I8MM_SHIFT, FTR_UNSIGNED, ID_AA64ZFR0_I8MM, CAP_HWCAP, KERNEL_HWCAP_SVEI8MM),
-	HWCAP_CAP(SYS_ID_AA64ZFR0_EL1, ID_AA64ZFR0_F32MM_SHIFT, FTR_UNSIGNED, ID_AA64ZFR0_F32MM, CAP_HWCAP, KERNEL_HWCAP_SVEF32MM),
-	HWCAP_CAP(SYS_ID_AA64ZFR0_EL1, ID_AA64ZFR0_F64MM_SHIFT, FTR_UNSIGNED, ID_AA64ZFR0_F64MM, CAP_HWCAP, KERNEL_HWCAP_SVEF64MM),
+	HWCAP_CAP(SYS_ID_AA64PFR0_EL1, ID_AA64PFR0_SVE_SHIFT, 4, FTR_UNSIGNED, ID_AA64PFR0_SVE, CAP_HWCAP, KERNEL_HWCAP_SVE),
+	HWCAP_CAP(SYS_ID_AA64ZFR0_EL1, ID_AA64ZFR0_SVEVER_SHIFT, 4, FTR_UNSIGNED, ID_AA64ZFR0_SVEVER_SVE2, CAP_HWCAP, KERNEL_HWCAP_SVE2),
+	HWCAP_CAP(SYS_ID_AA64ZFR0_EL1, ID_AA64ZFR0_AES_SHIFT, 4, FTR_UNSIGNED, ID_AA64ZFR0_AES, CAP_HWCAP, KERNEL_HWCAP_SVEAES),
+	HWCAP_CAP(SYS_ID_AA64ZFR0_EL1, ID_AA64ZFR0_AES_SHIFT, 4, FTR_UNSIGNED, ID_AA64ZFR0_AES_PMULL, CAP_HWCAP, KERNEL_HWCAP_SVEPMULL),
+	HWCAP_CAP(SYS_ID_AA64ZFR0_EL1, ID_AA64ZFR0_BITPERM_SHIFT, 4, FTR_UNSIGNED, ID_AA64ZFR0_BITPERM, CAP_HWCAP, KERNEL_HWCAP_SVEBITPERM),
+	HWCAP_CAP(SYS_ID_AA64ZFR0_EL1, ID_AA64ZFR0_BF16_SHIFT, 4, FTR_UNSIGNED, ID_AA64ZFR0_BF16, CAP_HWCAP, KERNEL_HWCAP_SVEBF16),
+	HWCAP_CAP(SYS_ID_AA64ZFR0_EL1, ID_AA64ZFR0_SHA3_SHIFT, 4, FTR_UNSIGNED, ID_AA64ZFR0_SHA3, CAP_HWCAP, KERNEL_HWCAP_SVESHA3),
+	HWCAP_CAP(SYS_ID_AA64ZFR0_EL1, ID_AA64ZFR0_SM4_SHIFT, 4, FTR_UNSIGNED, ID_AA64ZFR0_SM4, CAP_HWCAP, KERNEL_HWCAP_SVESM4),
+	HWCAP_CAP(SYS_ID_AA64ZFR0_EL1, ID_AA64ZFR0_I8MM_SHIFT, 4, FTR_UNSIGNED, ID_AA64ZFR0_I8MM, CAP_HWCAP, KERNEL_HWCAP_SVEI8MM),
+	HWCAP_CAP(SYS_ID_AA64ZFR0_EL1, ID_AA64ZFR0_F32MM_SHIFT, 4, FTR_UNSIGNED, ID_AA64ZFR0_F32MM, CAP_HWCAP, KERNEL_HWCAP_SVEF32MM),
+	HWCAP_CAP(SYS_ID_AA64ZFR0_EL1, ID_AA64ZFR0_F64MM_SHIFT, 4, FTR_UNSIGNED, ID_AA64ZFR0_F64MM, CAP_HWCAP, KERNEL_HWCAP_SVEF64MM),
 #endif
-	HWCAP_CAP(SYS_ID_AA64PFR1_EL1, ID_AA64PFR1_SSBS_SHIFT, FTR_UNSIGNED, ID_AA64PFR1_SSBS_PSTATE_INSNS, CAP_HWCAP, KERNEL_HWCAP_SSBS),
+	HWCAP_CAP(SYS_ID_AA64PFR1_EL1, ID_AA64PFR1_SSBS_SHIFT, 4, FTR_UNSIGNED, ID_AA64PFR1_SSBS_PSTATE_INSNS, CAP_HWCAP, KERNEL_HWCAP_SSBS),
 #ifdef CONFIG_ARM64_BTI
-	HWCAP_CAP(SYS_ID_AA64PFR1_EL1, ID_AA64PFR1_BT_SHIFT, FTR_UNSIGNED, ID_AA64PFR1_BT_BTI, CAP_HWCAP, KERNEL_HWCAP_BTI),
+	HWCAP_CAP(SYS_ID_AA64PFR1_EL1, ID_AA64PFR1_BT_SHIFT, 4, FTR_UNSIGNED, ID_AA64PFR1_BT_BTI, CAP_HWCAP, KERNEL_HWCAP_BTI),
 #endif
 #ifdef CONFIG_ARM64_PTR_AUTH
 	HWCAP_MULTI_CAP(ptr_auth_hwcap_addr_matches, CAP_HWCAP, KERNEL_HWCAP_PACA),
 	HWCAP_MULTI_CAP(ptr_auth_hwcap_gen_matches, CAP_HWCAP, KERNEL_HWCAP_PACG),
 #endif
 #ifdef CONFIG_ARM64_MTE
-	HWCAP_CAP(SYS_ID_AA64PFR1_EL1, ID_AA64PFR1_MTE_SHIFT, FTR_UNSIGNED, ID_AA64PFR1_MTE, CAP_HWCAP, KERNEL_HWCAP_MTE),
+	HWCAP_CAP(SYS_ID_AA64PFR1_EL1, ID_AA64PFR1_MTE_SHIFT, 4, FTR_UNSIGNED, ID_AA64PFR1_MTE, CAP_HWCAP, KERNEL_HWCAP_MTE),
 #endif /* CONFIG_ARM64_MTE */
-	HWCAP_CAP(SYS_ID_AA64MMFR0_EL1, ID_AA64MMFR0_ECV_SHIFT, FTR_UNSIGNED, 1, CAP_HWCAP, KERNEL_HWCAP_ECV),
+	HWCAP_CAP(SYS_ID_AA64MMFR0_EL1, ID_AA64MMFR0_ECV_SHIFT, 4, FTR_UNSIGNED, 1, CAP_HWCAP, KERNEL_HWCAP_ECV),
 	{},
 };
 
@@ -2504,15 +2539,15 @@ static bool compat_has_neon(const struct arm64_cpu_capabilities *cap, int scope)
 static const struct arm64_cpu_capabilities compat_elf_hwcaps[] = {
 #ifdef CONFIG_COMPAT
 	HWCAP_CAP_MATCH(compat_has_neon, CAP_COMPAT_HWCAP, COMPAT_HWCAP_NEON),
-	HWCAP_CAP(SYS_MVFR1_EL1, MVFR1_SIMDFMAC_SHIFT, FTR_UNSIGNED, 1, CAP_COMPAT_HWCAP, COMPAT_HWCAP_VFPv4),
+	HWCAP_CAP(SYS_MVFR1_EL1, MVFR1_SIMDFMAC_SHIFT, 4, FTR_UNSIGNED, 1, CAP_COMPAT_HWCAP, COMPAT_HWCAP_VFPv4),
 	/* Arm v8 mandates MVFR0.FPDP == {0, 2}. So, piggy back on this for the presence of VFP support */
-	HWCAP_CAP(SYS_MVFR0_EL1, MVFR0_FPDP_SHIFT, FTR_UNSIGNED, 2, CAP_COMPAT_HWCAP, COMPAT_HWCAP_VFP),
-	HWCAP_CAP(SYS_MVFR0_EL1, MVFR0_FPDP_SHIFT, FTR_UNSIGNED, 2, CAP_COMPAT_HWCAP, COMPAT_HWCAP_VFPv3),
-	HWCAP_CAP(SYS_ID_ISAR5_EL1, ID_ISAR5_AES_SHIFT, FTR_UNSIGNED, 2, CAP_COMPAT_HWCAP2, COMPAT_HWCAP2_PMULL),
-	HWCAP_CAP(SYS_ID_ISAR5_EL1, ID_ISAR5_AES_SHIFT, FTR_UNSIGNED, 1, CAP_COMPAT_HWCAP2, COMPAT_HWCAP2_AES),
-	HWCAP_CAP(SYS_ID_ISAR5_EL1, ID_ISAR5_SHA1_SHIFT, FTR_UNSIGNED, 1, CAP_COMPAT_HWCAP2, COMPAT_HWCAP2_SHA1),
-	HWCAP_CAP(SYS_ID_ISAR5_EL1, ID_ISAR5_SHA2_SHIFT, FTR_UNSIGNED, 1, CAP_COMPAT_HWCAP2, COMPAT_HWCAP2_SHA2),
-	HWCAP_CAP(SYS_ID_ISAR5_EL1, ID_ISAR5_CRC32_SHIFT, FTR_UNSIGNED, 1, CAP_COMPAT_HWCAP2, COMPAT_HWCAP2_CRC32),
+	HWCAP_CAP(SYS_MVFR0_EL1, MVFR0_FPDP_SHIFT, 4, FTR_UNSIGNED, 2, CAP_COMPAT_HWCAP, COMPAT_HWCAP_VFP),
+	HWCAP_CAP(SYS_MVFR0_EL1, MVFR0_FPDP_SHIFT, 4, FTR_UNSIGNED, 2, CAP_COMPAT_HWCAP, COMPAT_HWCAP_VFPv3),
+	HWCAP_CAP(SYS_ID_ISAR5_EL1, ID_ISAR5_AES_SHIFT, 4, FTR_UNSIGNED, 2, CAP_COMPAT_HWCAP2, COMPAT_HWCAP2_PMULL),
+	HWCAP_CAP(SYS_ID_ISAR5_EL1, ID_ISAR5_AES_SHIFT, 4, FTR_UNSIGNED, 1, CAP_COMPAT_HWCAP2, COMPAT_HWCAP2_AES),
+	HWCAP_CAP(SYS_ID_ISAR5_EL1, ID_ISAR5_SHA1_SHIFT, 4, FTR_UNSIGNED, 1, CAP_COMPAT_HWCAP2, COMPAT_HWCAP2_SHA1),
+	HWCAP_CAP(SYS_ID_ISAR5_EL1, ID_ISAR5_SHA2_SHIFT, 4, FTR_UNSIGNED, 1, CAP_COMPAT_HWCAP2, COMPAT_HWCAP2_SHA2),
+	HWCAP_CAP(SYS_ID_ISAR5_EL1, ID_ISAR5_CRC32_SHIFT, 4, FTR_UNSIGNED, 1, CAP_COMPAT_HWCAP2, COMPAT_HWCAP2_CRC32),
 #endif
 	{},
 };
-- 
2.30.2

