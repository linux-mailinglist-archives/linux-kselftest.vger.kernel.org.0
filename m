Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52A0066C5BA
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Jan 2023 17:09:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232397AbjAPQJS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 16 Jan 2023 11:09:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232443AbjAPQIZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 16 Jan 2023 11:08:25 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C9FE26596;
        Mon, 16 Jan 2023 08:06:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DFAE56102A;
        Mon, 16 Jan 2023 16:06:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E8A3C433F1;
        Mon, 16 Jan 2023 16:05:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673885163;
        bh=R+IYlIyvmEdZ8+QXxgaJU2HXCj1NBVBbwnvl5hvpC7E=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=FR23K/CvPy7nYff5zYpijlkEn+T8AfGtXDueIRq+jKM6ZfJ/5dnoicAR+Vk9jM0Ly
         +Gpc+HA/2P0/eZGYIPHc9AkAn+eEZM6L7C01PQjlgrxhbSZzs3kyzLT7a15ZZPSXlS
         7gcw6h0yUH9rPrblWORRT7gKZvqf7G0LnmH1EjzLnn1EkDEfrBh0r/GTQNpL4uIOU4
         UrM3iFpg7bh92tnTcdCFC9fkk9uaXATujvKCQ4RFuIE4eHyJ0JGLVO2BBtw7A1lRj8
         WCdFKe0FgMAQLs6a/2Ov07r31esFdB5eBqn84DHrj7ETAgJyWXrRn0asMXQw1ovvyH
         2ZgURq9SSF8/w==
From:   Mark Brown <broonie@kernel.org>
Date:   Mon, 16 Jan 2023 16:04:43 +0000
Subject: [PATCH v4 08/21] arm64/sme: Add basic enumeration for SME2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20221208-arm64-sme2-v4-8-f2fa0aef982f@kernel.org>
References: <20221208-arm64-sme2-v4-0-f2fa0aef982f@kernel.org>
In-Reply-To: <20221208-arm64-sme2-v4-0-f2fa0aef982f@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Oleg Nesterov <oleg@redhat.com>,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Oliver Upton <oliver.upton@linux.dev>,
        Shuah Khan <shuah@kernel.org>
Cc:     Alan Hayward <alan.hayward@arm.com>,
        Luis Machado <luis.machado@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kvmarm@lists.linux.dev, linux-kselftest@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.12-dev-77e06
X-Developer-Signature: v=1; a=openpgp-sha256; l=4151; i=broonie@kernel.org;
 h=from:subject:message-id; bh=R+IYlIyvmEdZ8+QXxgaJU2HXCj1NBVBbwnvl5hvpC7E=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBjxXWn7WQ0GR8fKoYK+J6yhaPRNfCgyP69/mLAj300
 Ygdxr3CJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCY8V1pwAKCRAk1otyXVSH0J5fB/
 0aboTaduK/Uk7K9rZF0Xr9ma+uhhxsuQCjPOzQjYK/LyyrO2ulR0p1dzdKUAnOmENMXATyRtc65nA3
 f7kDyl7prbXO8RyHVgxxdPsP38Yqr/bPXozKtL6j8KjIbV12NpSB0+9vDYYwlru47mdCk31QtDWyhB
 WEtwKgYVPAQpUgq8FuEYAyHW7vqoRIaUkPBSGIN3EkBKCruwpBAwi1O9SkoH9DANal/zrGbc010Bcq
 zXPRaB13i7hWFMDn+jMbYNPrSsQqFnumtMd4b3QyCS6xDa4At01J5wIJHpRGrplBD380GWSfCc17Yu
 jsIhgFtmE+Xfwcp/fHPJRW2Ysv+i4S
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
index 03d1c9d7af82..fc2c739f48f1 100644
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
index 2d3fa80cd95d..2a66e3b94553 100644
--- a/arch/arm64/include/asm/fpsimd.h
+++ b/arch/arm64/include/asm/fpsimd.h
@@ -118,6 +118,7 @@ extern void za_load_state(void const *state);
 struct arm64_cpu_capabilities;
 extern void sve_kernel_enable(const struct arm64_cpu_capabilities *__unused);
 extern void sme_kernel_enable(const struct arm64_cpu_capabilities *__unused);
+extern void sme2_kernel_enable(const struct arm64_cpu_capabilities *__unused);
 extern void fa64_kernel_enable(const struct arm64_cpu_capabilities *__unused);
 
 extern u64 read_zcr_features(void);
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index a77315b338e6..fd90905bc2e6 100644
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
@@ -2649,6 +2651,18 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 		.matches = has_cpuid_feature,
 		.cpu_enable = fa64_kernel_enable,
 	},
+	{
+		.desc = "SME2",
+		.type = ARM64_CPUCAP_SYSTEM_FEATURE,
+		.capability = ARM64_SME2,
+		.sys_reg = SYS_ID_AA64PFR1_EL1,
+		.sign = FTR_UNSIGNED,
+		.field_pos = ID_AA64PFR1_EL1_SME_SHIFT,
+		.field_width = ID_AA64PFR1_EL1_SME_WIDTH,
+		.min_field_value = ID_AA64PFR1_EL1_SME_SME2,
+		.matches = has_cpuid_feature,
+		.cpu_enable = sme2_kernel_enable,
+	},
 #endif /* CONFIG_ARM64_SME */
 	{
 		.desc = "WFx with timeout",
diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index 9e168a9eb615..717ae4aaa021 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -1298,6 +1298,17 @@ void sme_kernel_enable(const struct arm64_cpu_capabilities *__always_unused p)
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
index a86ee376920a..1222b0ed63a2 100644
--- a/arch/arm64/tools/cpucaps
+++ b/arch/arm64/tools/cpucaps
@@ -50,6 +50,7 @@ MTE
 MTE_ASYMM
 SME
 SME_FA64
+SME2
 SPECTRE_V2
 SPECTRE_V3A
 SPECTRE_V4

-- 
2.34.1

