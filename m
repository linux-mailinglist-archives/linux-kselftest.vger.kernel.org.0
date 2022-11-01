Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52886614CD2
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Nov 2022 15:39:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230341AbiKAOjj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 1 Nov 2022 10:39:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230335AbiKAOji (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 1 Nov 2022 10:39:38 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD64C120B8
        for <linux-kselftest@vger.kernel.org>; Tue,  1 Nov 2022 07:39:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8ECB9B81DE9
        for <linux-kselftest@vger.kernel.org>; Tue,  1 Nov 2022 14:39:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19A97C433D7;
        Tue,  1 Nov 2022 14:39:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667313575;
        bh=BSyGAKOSO0WbIOVL+wJlQnvdBXIuBCty+6/13InEecc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S5OZanB0HojKRgjE1GwTyoKubtFZqxwVAo8qBvGt8aKmK5dmLszeSBuuCErpZODB6
         gJ/ltzkbotFpP0U+bNzcGrmW/MqlpRifjP0lXG6/XsL67p3SD4w07X4rA3toIOrNGU
         2CnM+iP84uCggMWl09g+FR97IxR+QxGRH8vnOJUhYC1DC/rAyHeJUvw6841l7VVJgI
         EBnZp0cNS2LvZsO0R3SGQuXG7fGE3xDYlGi4su5Cn4td6zms/3wN5Nltx1zg10cmOB
         x5/DZjgr9iZdNi2/YOHp4RcP/gTFDZiaNW+0os7q9s1drUV6tJtIVAlVx6zzi/8vZ5
         YJQY4kRs+GTQQ==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     Alan Hayward <alan.hayward@arm.com>,
        Luis Machado <luis.machado@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH v2 08/21] arm64/sme: Add basic enumeration for SME2
Date:   Tue,  1 Nov 2022 14:33:23 +0000
Message-Id: <20221101143336.254445-9-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221101143336.254445-1-broonie@kernel.org>
References: <20221101143336.254445-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4162; i=broonie@kernel.org; h=from:subject; bh=BSyGAKOSO0WbIOVL+wJlQnvdBXIuBCty+6/13InEecc=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBjYS4x+GTOqkjCcFogoV8A1E6gb1xJeqE7gKHANrgO rXkTfpqJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCY2EuMQAKCRAk1otyXVSH0MFKB/ 4h0jn7E9AbZMAME+6KM2iFM/oeKHUFooaUjgNh9DnVOtUdQk2JtTqcbZfGCCPFGfmnBfGamj0kPIg4 kkjDUkGjCDA6OOAsicq0hzv221vRtLninqRhXIYvqx0W1oTAR3cgQpSMY2gJ3/5nNyTxaVhkySLtse X5C5JxDcAPh+ua07HhLsQ+Loc6tAC1zGxXYtGAcPShvuSYhd061OOqSdOokkoYFGxyZnKdYd+t3B3L 7R3AXB/irUkmkyAJgR6vOP1NUjQqPAQu1GBhBGFEhByVTo8KBsHwTfdFRsaG59TzI8db5OfD5bhlV/ biUsS5ZG4hRdFkbtQxDh4kJu2ggSPX
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add basic feature detection for SME2, detecting that the feature is present
and disabling traps for ZT0.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/include/asm/cpufeature.h |  6 ++++++
 arch/arm64/include/asm/fpsimd.h     |  1 +
 arch/arm64/kernel/cpufeature.c      | 14 ++++++++++++++
 arch/arm64/kernel/fpsimd.c          | 11 +++++++++++
 arch/arm64/tools/cpucaps            |  1 +
 5 files changed, 33 insertions(+)

diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index f73f11b55042..3ad41c26c9e7 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -769,6 +769,12 @@ static __always_inline bool system_supports_sme(void)
 		cpus_have_const_cap(ARM64_SME);
 }
 
+static __always_inline bool system_supports_sme2(void)
+{
+	return IS_ENABLED(CONFIG_ARM64_SME) &&
+		cpus_have_const_cap(ARM64_SME2);
+}
+
 static __always_inline bool system_supports_fa64(void)
 {
 	return IS_ENABLED(CONFIG_ARM64_SME) &&
diff --git a/arch/arm64/include/asm/fpsimd.h b/arch/arm64/include/asm/fpsimd.h
index a18a86ccfd82..f2bda963cfe5 100644
--- a/arch/arm64/include/asm/fpsimd.h
+++ b/arch/arm64/include/asm/fpsimd.h
@@ -109,6 +109,7 @@ extern void za_load_state(void const *state);
 struct arm64_cpu_capabilities;
 extern void sve_kernel_enable(const struct arm64_cpu_capabilities *__unused);
 extern void sme_kernel_enable(const struct arm64_cpu_capabilities *__unused);
+extern void sme2_kernel_enable(const struct arm64_cpu_capabilities *__unused);
 extern void fa64_kernel_enable(const struct arm64_cpu_capabilities *__unused);
 
 extern u64 read_zcr_features(void);
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index bb1ef8cf7d04..416785eeb512 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -282,6 +282,8 @@ static const struct arm64_ftr_bits ftr_id_aa64zfr0[] = {
 static const struct arm64_ftr_bits ftr_id_aa64smfr0[] = {
 	ARM64_FTR_BITS(FTR_VISIBLE_IF_IS_ENABLED(CONFIG_ARM64_SME),
 		       FTR_STRICT, FTR_EXACT, ID_AA64SMFR0_EL1_FA64_SHIFT, 1, 0),
+	ARM64_FTR_BITS(FTR_VISIBLE_IF_IS_ENABLED(CONFIG_ARM64_SME),
+		       FTR_STRICT, FTR_EXACT, ID_AA64SMFR0_EL1_SMEver_SHIFT, 4, 0),
 	ARM64_FTR_BITS(FTR_VISIBLE_IF_IS_ENABLED(CONFIG_ARM64_SME),
 		       FTR_STRICT, FTR_EXACT, ID_AA64SMFR0_EL1_I16I64_SHIFT, 4, 0),
 	ARM64_FTR_BITS(FTR_VISIBLE_IF_IS_ENABLED(CONFIG_ARM64_SME),
@@ -2618,6 +2620,18 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 		.matches = has_cpuid_feature,
 		.cpu_enable = fa64_kernel_enable,
 	},
+	{
+		.desc = "SME2",
+		.type = ARM64_CPUCAP_SYSTEM_FEATURE,
+		.capability = ARM64_SME2,
+		.sys_reg = SYS_ID_AA64SMFR0_EL1,
+		.sign = FTR_UNSIGNED,
+		.field_pos = ID_AA64SMFR0_EL1_SMEver_SHIFT,
+		.field_width = ID_AA64SMFR0_EL1_SMEver_WIDTH,
+		.min_field_value = ID_AA64SMFR0_EL1_SMEver_SME2,
+		.matches = has_cpuid_feature,
+		.cpu_enable = sme2_kernel_enable,
+	},
 #endif /* CONFIG_ARM64_SME */
 	{
 		.desc = "WFx with timeout",
diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index b677b5a3e0f6..73ec8850a402 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -1254,6 +1254,17 @@ void sme_kernel_enable(const struct arm64_cpu_capabilities *__always_unused p)
 	isb();
 }
 
+/*
+ * This must be called after sme_kernel_enable(), we rely on the
+ * feature table being sorted to ensure this.
+ */
+void sme2_kernel_enable(const struct arm64_cpu_capabilities *__always_unused p)
+{
+	/* Allow use of ZT0 */
+	write_sysreg_s(read_sysreg_s(SYS_SMCR_EL1) | SMCR_ELx_EZT0_MASK,
+		       SYS_SMCR_EL1);
+}
+
 /*
  * This must be called after sme_kernel_enable(), we rely on the
  * feature table being sorted to ensure this.
diff --git a/arch/arm64/tools/cpucaps b/arch/arm64/tools/cpucaps
index f1c0347ec31a..79f511ef3195 100644
--- a/arch/arm64/tools/cpucaps
+++ b/arch/arm64/tools/cpucaps
@@ -49,6 +49,7 @@ MTE
 MTE_ASYMM
 SME
 SME_FA64
+SME2
 SPECTRE_V2
 SPECTRE_V3A
 SPECTRE_V4
-- 
2.30.2

