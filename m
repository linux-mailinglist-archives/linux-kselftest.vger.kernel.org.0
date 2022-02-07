Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 234B94AC3E9
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Feb 2022 16:40:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244022AbiBGPfR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 7 Feb 2022 10:35:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344042AbiBGPXV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 7 Feb 2022 10:23:21 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C84EC0401C1
        for <linux-kselftest@vger.kernel.org>; Mon,  7 Feb 2022 07:23:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 818C9614A2
        for <linux-kselftest@vger.kernel.org>; Mon,  7 Feb 2022 15:23:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5443AC340EF;
        Mon,  7 Feb 2022 15:23:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644247399;
        bh=lTH04iGTjfULvjabX1avJWxoaIWS1bex48Z21tPpQi8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=h23BHUC6IjO0j1j8Zj4o+1OVDcltyNHpgBPZupnRTx1gKMuQ6uqGagUh1c1vCeur8
         NxwHGLkL7+VTwx4I1LbaKThJdNN/+9dT665rJjzvFHu/OmditStXyZdpmhMccU+5WN
         MBPZW1OJtD0sw042/Rn7frdAqqskx9hYhSTKpq9okK9zVn7mnfs9oEpEGTqMDqGDYx
         tigTdb8Bg1ku4/aB4y2rnZCAw127dQJ8IL8EERM8zC1jihn5SsqDlvYh6kY13yaIK8
         LcREg9yRAIJ6iDezjWd2JK4TyYQprxVzsEUBK6TSUAwxIK9J90ANbPZny2Alm6LjiR
         szNm4ufOwg4Yw==
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
Subject: [PATCH v11 03/40] arm64: cpufeature: Always specify and use a field width for capabilities
Date:   Mon,  7 Feb 2022 15:20:32 +0000
Message-Id: <20220207152109.197566-4-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220207152109.197566-1-broonie@kernel.org>
References: <20220207152109.197566-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=26719; h=from:subject; bh=lTH04iGTjfULvjabX1avJWxoaIWS1bex48Z21tPpQi8=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBiATjHaoGmteimGG/YWSEGffYh4/eNy1xNGUjCOEfL 5zuA65CJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYgE4xwAKCRAk1otyXVSH0JWlB/ sHMq9KUXiV0zVHQ41BYPmqOlGQOseH0QuAYqQ6VEmd3nqDCzoJgaWWnWPO1jXQI/FWCYyJj7aJJ+So 6mtoPStMK1+1Nd3lEBQqhee7d/HoiEvOaePff8dNZFji+O8TWuul9UXc1HdJZIjyIdus3pO6uX+wgw ToVllL42HUID9eLauaZm0uIykqlKdQ/Nd7Hqt2zRYfvZaMER4V7atiCZsg/gDUcQpUGUDo4RThHEFj xIIGruUtSEnflys5FOC9tQJ1JJUAJ/aiU5ZNSv6lQRTVIRE42350OtrfGBkRdH5iPBGL6ICRJd5rRK cqLpDTU+tSKC2aLQhXZ1venaqQJlyg
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UPPERCASE_50_75
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
 arch/arm64/kernel/cpufeature.c      | 167 +++++++++++++++++-----------
 2 files changed, 102 insertions(+), 66 deletions(-)

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
index e5f23dab1c8d..64a748c2b351 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -1307,7 +1307,9 @@ u64 __read_sysreg_by_encoding(u32 sys_id)
 static bool
 feature_matches(u64 reg, const struct arm64_cpu_capabilities *entry)
 {
-	int val = cpuid_feature_extract_field(reg, entry->field_pos, entry->sign);
+	int val = cpuid_feature_extract_field_width(reg, entry->field_pos,
+						    entry->field_width,
+						    entry->sign);
 
 	return val >= entry->min_field_value;
 }
@@ -1955,6 +1957,7 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 		.matches = has_cpuid_feature,
 		.sys_reg = SYS_ID_AA64MMFR0_EL1,
 		.field_pos = ID_AA64MMFR0_ECV_SHIFT,
+		.field_width = 4,
 		.sign = FTR_UNSIGNED,
 		.min_field_value = 1,
 	},
@@ -1966,6 +1969,7 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 		.matches = has_cpuid_feature,
 		.sys_reg = SYS_ID_AA64MMFR1_EL1,
 		.field_pos = ID_AA64MMFR1_PAN_SHIFT,
+		.field_width = 4,
 		.sign = FTR_UNSIGNED,
 		.min_field_value = 1,
 		.cpu_enable = cpu_enable_pan,
@@ -1979,6 +1983,7 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 		.matches = has_cpuid_feature,
 		.sys_reg = SYS_ID_AA64MMFR1_EL1,
 		.field_pos = ID_AA64MMFR1_PAN_SHIFT,
+		.field_width = 4,
 		.sign = FTR_UNSIGNED,
 		.min_field_value = 3,
 	},
@@ -1991,6 +1996,7 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 		.matches = has_cpuid_feature,
 		.sys_reg = SYS_ID_AA64ISAR0_EL1,
 		.field_pos = ID_AA64ISAR0_ATOMICS_SHIFT,
+		.field_width = 4,
 		.sign = FTR_UNSIGNED,
 		.min_field_value = 2,
 	},
@@ -2015,6 +2021,7 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 		.sys_reg = SYS_ID_AA64PFR0_EL1,
 		.sign = FTR_UNSIGNED,
 		.field_pos = ID_AA64PFR0_EL0_SHIFT,
+		.field_width = 4,
 		.min_field_value = ID_AA64PFR0_ELx_32BIT_64BIT,
 	},
 #ifdef CONFIG_KVM
@@ -2026,6 +2033,7 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 		.sys_reg = SYS_ID_AA64PFR0_EL1,
 		.sign = FTR_UNSIGNED,
 		.field_pos = ID_AA64PFR0_EL1_SHIFT,
+		.field_width = 4,
 		.min_field_value = ID_AA64PFR0_ELx_32BIT_64BIT,
 	},
 	{
@@ -2046,6 +2054,7 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 		 */
 		.sys_reg = SYS_ID_AA64PFR0_EL1,
 		.field_pos = ID_AA64PFR0_CSV3_SHIFT,
+		.field_width = 4,
 		.min_field_value = 1,
 		.matches = unmap_kernel_at_el0,
 		.cpu_enable = kpti_install_ng_mappings,
@@ -2065,6 +2074,7 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 		.matches = has_cpuid_feature,
 		.sys_reg = SYS_ID_AA64ISAR1_EL1,
 		.field_pos = ID_AA64ISAR1_DPB_SHIFT,
+		.field_width = 4,
 		.min_field_value = 1,
 	},
 	{
@@ -2075,6 +2085,7 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 		.sys_reg = SYS_ID_AA64ISAR1_EL1,
 		.sign = FTR_UNSIGNED,
 		.field_pos = ID_AA64ISAR1_DPB_SHIFT,
+		.field_width = 4,
 		.min_field_value = 2,
 	},
 #endif
@@ -2086,6 +2097,7 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 		.sys_reg = SYS_ID_AA64PFR0_EL1,
 		.sign = FTR_UNSIGNED,
 		.field_pos = ID_AA64PFR0_SVE_SHIFT,
+		.field_width = 4,
 		.min_field_value = ID_AA64PFR0_SVE,
 		.matches = has_cpuid_feature,
 		.cpu_enable = sve_kernel_enable,
@@ -2100,6 +2112,7 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 		.sys_reg = SYS_ID_AA64PFR0_EL1,
 		.sign = FTR_UNSIGNED,
 		.field_pos = ID_AA64PFR0_RAS_SHIFT,
+		.field_width = 4,
 		.min_field_value = ID_AA64PFR0_RAS_V1,
 		.cpu_enable = cpu_clear_disr,
 	},
@@ -2118,6 +2131,7 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 		.sys_reg = SYS_ID_AA64PFR0_EL1,
 		.sign = FTR_UNSIGNED,
 		.field_pos = ID_AA64PFR0_AMU_SHIFT,
+		.field_width = 4,
 		.min_field_value = ID_AA64PFR0_AMU,
 		.cpu_enable = cpu_amu_enable,
 	},
@@ -2142,6 +2156,7 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 		.sys_reg = SYS_ID_AA64MMFR2_EL1,
 		.sign = FTR_UNSIGNED,
 		.field_pos = ID_AA64MMFR2_FWB_SHIFT,
+		.field_width = 4,
 		.min_field_value = 1,
 		.matches = has_cpuid_feature,
 		.cpu_enable = cpu_has_fwb,
@@ -2153,6 +2168,7 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 		.sys_reg = SYS_ID_AA64MMFR2_EL1,
 		.sign = FTR_UNSIGNED,
 		.field_pos = ID_AA64MMFR2_TTL_SHIFT,
+		.field_width = 4,
 		.min_field_value = 1,
 		.matches = has_cpuid_feature,
 	},
@@ -2163,6 +2179,7 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 		.matches = has_cpuid_feature,
 		.sys_reg = SYS_ID_AA64ISAR0_EL1,
 		.field_pos = ID_AA64ISAR0_TLB_SHIFT,
+		.field_width = 4,
 		.sign = FTR_UNSIGNED,
 		.min_field_value = ID_AA64ISAR0_TLB_RANGE,
 	},
@@ -2181,6 +2198,7 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 		.sys_reg = SYS_ID_AA64MMFR1_EL1,
 		.sign = FTR_UNSIGNED,
 		.field_pos = ID_AA64MMFR1_HADBS_SHIFT,
+		.field_width = 4,
 		.min_field_value = 2,
 		.matches = has_hw_dbm,
 		.cpu_enable = cpu_enable_hw_dbm,
@@ -2193,6 +2211,7 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 		.matches = has_cpuid_feature,
 		.sys_reg = SYS_ID_AA64ISAR0_EL1,
 		.field_pos = ID_AA64ISAR0_CRC32_SHIFT,
+		.field_width = 4,
 		.min_field_value = 1,
 	},
 	{
@@ -2202,6 +2221,7 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 		.matches = has_cpuid_feature,
 		.sys_reg = SYS_ID_AA64PFR1_EL1,
 		.field_pos = ID_AA64PFR1_SSBS_SHIFT,
+		.field_width = 4,
 		.sign = FTR_UNSIGNED,
 		.min_field_value = ID_AA64PFR1_SSBS_PSTATE_ONLY,
 	},
@@ -2214,6 +2234,7 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 		.sys_reg = SYS_ID_AA64MMFR2_EL1,
 		.sign = FTR_UNSIGNED,
 		.field_pos = ID_AA64MMFR2_CNP_SHIFT,
+		.field_width = 4,
 		.min_field_value = 1,
 		.cpu_enable = cpu_enable_cnp,
 	},
@@ -2225,6 +2246,7 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 		.matches = has_cpuid_feature,
 		.sys_reg = SYS_ID_AA64ISAR1_EL1,
 		.field_pos = ID_AA64ISAR1_SB_SHIFT,
+		.field_width = 4,
 		.sign = FTR_UNSIGNED,
 		.min_field_value = 1,
 	},
@@ -2236,6 +2258,7 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 		.sys_reg = SYS_ID_AA64ISAR1_EL1,
 		.sign = FTR_UNSIGNED,
 		.field_pos = ID_AA64ISAR1_APA_SHIFT,
+		.field_width = 4,
 		.min_field_value = ID_AA64ISAR1_APA_ARCHITECTED,
 		.matches = has_address_auth_cpucap,
 	},
@@ -2246,6 +2269,7 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 		.sys_reg = SYS_ID_AA64ISAR1_EL1,
 		.sign = FTR_UNSIGNED,
 		.field_pos = ID_AA64ISAR1_API_SHIFT,
+		.field_width = 4,
 		.min_field_value = ID_AA64ISAR1_API_IMP_DEF,
 		.matches = has_address_auth_cpucap,
 	},
@@ -2261,6 +2285,7 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 		.sys_reg = SYS_ID_AA64ISAR1_EL1,
 		.sign = FTR_UNSIGNED,
 		.field_pos = ID_AA64ISAR1_GPA_SHIFT,
+		.field_width = 4,
 		.min_field_value = ID_AA64ISAR1_GPA_ARCHITECTED,
 		.matches = has_cpuid_feature,
 	},
@@ -2271,6 +2296,7 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 		.sys_reg = SYS_ID_AA64ISAR1_EL1,
 		.sign = FTR_UNSIGNED,
 		.field_pos = ID_AA64ISAR1_GPI_SHIFT,
+		.field_width = 4,
 		.min_field_value = ID_AA64ISAR1_GPI_IMP_DEF,
 		.matches = has_cpuid_feature,
 	},
@@ -2291,6 +2317,7 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 		.matches = can_use_gic_priorities,
 		.sys_reg = SYS_ID_AA64PFR0_EL1,
 		.field_pos = ID_AA64PFR0_GIC_SHIFT,
+		.field_width = 4,
 		.sign = FTR_UNSIGNED,
 		.min_field_value = 1,
 	},
@@ -2302,6 +2329,7 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 		.type = ARM64_CPUCAP_SYSTEM_FEATURE,
 		.sys_reg = SYS_ID_AA64MMFR2_EL1,
 		.sign = FTR_UNSIGNED,
+		.field_width = 4,
 		.field_pos = ID_AA64MMFR2_E0PD_SHIFT,
 		.matches = has_cpuid_feature,
 		.min_field_value = 1,
@@ -2316,6 +2344,7 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 		.matches = has_cpuid_feature,
 		.sys_reg = SYS_ID_AA64ISAR0_EL1,
 		.field_pos = ID_AA64ISAR0_RNDR_SHIFT,
+		.field_width = 4,
 		.sign = FTR_UNSIGNED,
 		.min_field_value = 1,
 	},
@@ -2333,6 +2362,7 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 		.cpu_enable = bti_enable,
 		.sys_reg = SYS_ID_AA64PFR1_EL1,
 		.field_pos = ID_AA64PFR1_BT_SHIFT,
+		.field_width = 4,
 		.min_field_value = ID_AA64PFR1_BT_BTI,
 		.sign = FTR_UNSIGNED,
 	},
@@ -2345,6 +2375,7 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 		.matches = has_cpuid_feature,
 		.sys_reg = SYS_ID_AA64PFR1_EL1,
 		.field_pos = ID_AA64PFR1_MTE_SHIFT,
+		.field_width = 4,
 		.min_field_value = ID_AA64PFR1_MTE,
 		.sign = FTR_UNSIGNED,
 		.cpu_enable = cpu_enable_mte,
@@ -2356,6 +2387,7 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 		.matches = has_cpuid_feature,
 		.sys_reg = SYS_ID_AA64PFR1_EL1,
 		.field_pos = ID_AA64PFR1_MTE_SHIFT,
+		.field_width = 4,
 		.min_field_value = ID_AA64PFR1_MTE_ASYMM,
 		.sign = FTR_UNSIGNED,
 	},
@@ -2367,16 +2399,18 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
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
 
@@ -2386,10 +2420,10 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
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
@@ -2409,11 +2443,12 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
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
@@ -2421,77 +2456,77 @@ static const struct arm64_cpu_capabilities ptr_auth_hwcap_addr_matches[] = {
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
-	HWCAP_CAP(SYS_ID_AA64MMFR1_EL1, ID_AA64MMFR1_AFP_SHIFT, FTR_UNSIGNED, 1, CAP_HWCAP, KERNEL_HWCAP_AFP),
-	HWCAP_CAP(SYS_ID_AA64ISAR2_EL1, ID_AA64ISAR2_RPRES_SHIFT, FTR_UNSIGNED, 1, CAP_HWCAP, KERNEL_HWCAP_RPRES),
+	HWCAP_CAP(SYS_ID_AA64MMFR0_EL1, ID_AA64MMFR0_ECV_SHIFT, 4, FTR_UNSIGNED, 1, CAP_HWCAP, KERNEL_HWCAP_ECV),
+	HWCAP_CAP(SYS_ID_AA64MMFR1_EL1, ID_AA64MMFR1_AFP_SHIFT, 4, FTR_UNSIGNED, 1, CAP_HWCAP, KERNEL_HWCAP_AFP),
+	HWCAP_CAP(SYS_ID_AA64ISAR2_EL1, ID_AA64ISAR2_RPRES_SHIFT, 4, FTR_UNSIGNED, 1, CAP_HWCAP, KERNEL_HWCAP_RPRES),
 	{},
 };
 
@@ -2520,15 +2555,15 @@ static bool compat_has_neon(const struct arm64_cpu_capabilities *cap, int scope)
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

