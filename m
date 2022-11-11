Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF40E6263DC
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Nov 2022 22:52:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231300AbiKKVv7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 11 Nov 2022 16:51:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233542AbiKKVvc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 11 Nov 2022 16:51:32 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D96286B203
        for <linux-kselftest@vger.kernel.org>; Fri, 11 Nov 2022 13:51:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 93E00B827F1
        for <linux-kselftest@vger.kernel.org>; Fri, 11 Nov 2022 21:51:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32854C433C1;
        Fri, 11 Nov 2022 21:51:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668203488;
        bh=vPYzsNjtJTSrcRndtJjAv6zm4FdNQ4M6zDgeHljobWI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aJTIwW0a1iVZ0F5dLrtY5rH+Z8+AyRZreUWopoOy1LrCJkBp/pYPTBt1W5Iqg1kUp
         A2R/PBURK1OuaY9nPZAl+IY2RADQIDGFbGfPvOG2tepNI4MsBgy59jpEmDFnczXQju
         TMwLn332iGlERDcF/vp7hgJkCH/hpbRHRNS1xiK7XNf77OHqfZNmqdLFjFwx2CuKQK
         by3b9F7i3wFnQIg9iabMiSRgfnPhH/gOMUQL2tICylQFZsYKtp9cxejXCg9P+0obNh
         /OEZ3MebJhv+u+7R895v8BfqTL9e0NuZHY8iYhX28Z75tADYifgF8rBHkw3CeSdqyi
         ZtR41kVPFsBhg==
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
Subject: [PATCH v3 13/21] arm64/sme: Add hwcaps for SME 2 and 2.1 features
Date:   Fri, 11 Nov 2022 21:50:18 +0000
Message-Id: <20221111215026.813348-14-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221111215026.813348-1-broonie@kernel.org>
References: <20221111215026.813348-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7092; i=broonie@kernel.org; h=from:subject; bh=vPYzsNjtJTSrcRndtJjAv6zm4FdNQ4M6zDgeHljobWI=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBjbsOZ13bfukO5EhwINQon5yT727+0B7x0J//3/Ji6 Xjopj3uJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCY27DmQAKCRAk1otyXVSH0FTfB/ 9kkzGnGVEKuw2WogGWqQVhqbHY5ngNMlAVnm0nJbtLhfnEdRxG8W02N43n+B+M3Tz0EW99r8fxdSri Zwd9ztjikEcm4v2Rbv8wzdById7i93vHrySvxYmJgFLDKgPdQ44C1f38SljeWuj2N98q3IkwD1gOUj wuDdBarwrMcLjFgA4L+V4fPVlYx/l9eN32zcNX/aTPGWTr4Ir/v0fILKayXhjZL2FZPsNNDEZZoEj8 /c1cZa82UCwBdQqRa5kD2m40SqN8EkBovON2A8tP0fQIsGkrWUii5sXoGYxOAgBijy8jr/CM3+qol+ E2cDBW9btBHHPsySqyDEwoS7YPRC5B
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75 autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

In order to allow userspace to discover the presence of the new SME features
add hwcaps for them.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/arm64/elf_hwcaps.rst  | 18 ++++++++++++++++++
 arch/arm64/include/asm/hwcap.h      |  6 ++++++
 arch/arm64/include/uapi/asm/hwcap.h |  6 ++++++
 arch/arm64/kernel/cpufeature.c      | 13 +++++++++++++
 arch/arm64/kernel/cpuinfo.c         |  6 ++++++
 5 files changed, 49 insertions(+)

diff --git a/Documentation/arm64/elf_hwcaps.rst b/Documentation/arm64/elf_hwcaps.rst
index 6fed84f935df..29a3dd1b8f5a 100644
--- a/Documentation/arm64/elf_hwcaps.rst
+++ b/Documentation/arm64/elf_hwcaps.rst
@@ -284,6 +284,24 @@ HWCAP2_RPRFM
 HWCAP2_SVE2P1
     Functionality implied by ID_AA64ZFR0_EL1.SVEver == 0b0010.
 
+HWCAP2_SME2
+    Functionality implied by ID_AA64SMFR0_EL1.SMEver == 0b0001.
+
+HWCAP2_SME2P1
+    Functionality implied by ID_AA64SMFR0_EL1.SMEver == 0b0010.
+
+HWCAP2_SMEI16I32
+    Functionality implied by ID_AA64SMFR0_EL1.I16I32 == 0b0101
+
+HWCAP2_SMEBI32I32
+    Functionality implied by ID_AA64SMFR0_EL1.I32I32 == 0b1
+
+HWCAP2_SMEB16B16
+    Functionality implied by ID_AA64SMFR0_EL1.B16B16 == 0b1
+
+HWCAP2_SMEF16F16
+    Functionality implied by ID_AA64SMFR0_EL1.F16F16 == 0b1
+
 4. Unused AT_HWCAP bits
 -----------------------
 
diff --git a/arch/arm64/include/asm/hwcap.h b/arch/arm64/include/asm/hwcap.h
index 06dd12c514e6..475c803ecf42 100644
--- a/arch/arm64/include/asm/hwcap.h
+++ b/arch/arm64/include/asm/hwcap.h
@@ -123,6 +123,12 @@
 #define KERNEL_HWCAP_CSSC		__khwcap2_feature(CSSC)
 #define KERNEL_HWCAP_RPRFM		__khwcap2_feature(RPRFM)
 #define KERNEL_HWCAP_SVE2P1		__khwcap2_feature(SVE2P1)
+#define KERNEL_HWCAP_SME2		__khwcap2_feature(SME2)
+#define KERNEL_HWCAP_SME2P1		__khwcap2_feature(SME2P1)
+#define KERNEL_HWCAP_SME_I16I32		__khwcap2_feature(SME_I16I32)
+#define KERNEL_HWCAP_SME_BI32I32	__khwcap2_feature(SME_BI32I32)
+#define KERNEL_HWCAP_SME_B16B16		__khwcap2_feature(SME_B16B16)
+#define KERNEL_HWCAP_SME_F16F16		__khwcap2_feature(SME_F16F16)
 
 /*
  * This yields a mask that user programs can use to figure out what
diff --git a/arch/arm64/include/uapi/asm/hwcap.h b/arch/arm64/include/uapi/asm/hwcap.h
index b713d30544f1..69a4fb749c65 100644
--- a/arch/arm64/include/uapi/asm/hwcap.h
+++ b/arch/arm64/include/uapi/asm/hwcap.h
@@ -96,5 +96,11 @@
 #define HWCAP2_CSSC		(1UL << 34)
 #define HWCAP2_RPRFM		(1UL << 35)
 #define HWCAP2_SVE2P1		(1UL << 36)
+#define HWCAP2_SME2		(1UL << 37)
+#define HWCAP2_SME2P1		(1UL << 38)
+#define HWCAP2_SME_I16I32	(1UL << 39)
+#define HWCAP2_SME_BI32I32	(1UL << 40)
+#define HWCAP2_SME_B16B16	(1UL << 41)
+#define HWCAP2_SME_F16F16	(1UL << 42)
 
 #endif /* _UAPI__ASM_HWCAP_H */
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 5b0d79f026aa..efb980ea7653 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -288,12 +288,20 @@ static const struct arm64_ftr_bits ftr_id_aa64smfr0[] = {
 		       FTR_STRICT, FTR_EXACT, ID_AA64SMFR0_EL1_I16I64_SHIFT, 4, 0),
 	ARM64_FTR_BITS(FTR_VISIBLE_IF_IS_ENABLED(CONFIG_ARM64_SME),
 		       FTR_STRICT, FTR_EXACT, ID_AA64SMFR0_EL1_F64F64_SHIFT, 1, 0),
+	ARM64_FTR_BITS(FTR_VISIBLE_IF_IS_ENABLED(CONFIG_ARM64_SME),
+		       FTR_STRICT, FTR_EXACT, ID_AA64SMFR0_EL1_I16I32_SHIFT, 4, 0),
+	ARM64_FTR_BITS(FTR_VISIBLE_IF_IS_ENABLED(CONFIG_ARM64_SME),
+		       FTR_STRICT, FTR_EXACT, ID_AA64SMFR0_EL1_B16B16_SHIFT, 1, 0),
+	ARM64_FTR_BITS(FTR_VISIBLE_IF_IS_ENABLED(CONFIG_ARM64_SME),
+		       FTR_STRICT, FTR_EXACT, ID_AA64SMFR0_EL1_F16F16_SHIFT, 1, 0),
 	ARM64_FTR_BITS(FTR_VISIBLE_IF_IS_ENABLED(CONFIG_ARM64_SME),
 		       FTR_STRICT, FTR_EXACT, ID_AA64SMFR0_EL1_I8I32_SHIFT, 4, 0),
 	ARM64_FTR_BITS(FTR_VISIBLE_IF_IS_ENABLED(CONFIG_ARM64_SME),
 		       FTR_STRICT, FTR_EXACT, ID_AA64SMFR0_EL1_F16F32_SHIFT, 1, 0),
 	ARM64_FTR_BITS(FTR_VISIBLE_IF_IS_ENABLED(CONFIG_ARM64_SME),
 		       FTR_STRICT, FTR_EXACT, ID_AA64SMFR0_EL1_B16F32_SHIFT, 1, 0),
+	ARM64_FTR_BITS(FTR_VISIBLE_IF_IS_ENABLED(CONFIG_ARM64_SME),
+		       FTR_STRICT, FTR_EXACT, ID_AA64SMFR0_EL1_BI32I32_SHIFT, 1, 0),
 	ARM64_FTR_BITS(FTR_VISIBLE_IF_IS_ENABLED(CONFIG_ARM64_SME),
 		       FTR_STRICT, FTR_EXACT, ID_AA64SMFR0_EL1_F32F32_SHIFT, 1, 0),
 	ARM64_FTR_END,
@@ -2839,11 +2847,16 @@ static const struct arm64_cpu_capabilities arm64_elf_hwcaps[] = {
 #ifdef CONFIG_ARM64_SME
 	HWCAP_CAP(SYS_ID_AA64PFR1_EL1, ID_AA64PFR1_EL1_SME_SHIFT, 4, FTR_UNSIGNED, ID_AA64PFR1_EL1_SME_IMP, CAP_HWCAP, KERNEL_HWCAP_SME),
 	HWCAP_CAP(SYS_ID_AA64SMFR0_EL1, ID_AA64SMFR0_EL1_FA64_SHIFT, 1, FTR_UNSIGNED, ID_AA64SMFR0_EL1_FA64_IMP, CAP_HWCAP, KERNEL_HWCAP_SME_FA64),
+	HWCAP_CAP(SYS_ID_AA64SMFR0_EL1, ID_AA64SMFR0_EL1_SMEver_SHIFT, 4, FTR_UNSIGNED, ID_AA64SMFR0_EL1_SMEver_SME2p1, CAP_HWCAP, KERNEL_HWCAP_SME2P1),
+	HWCAP_CAP(SYS_ID_AA64SMFR0_EL1, ID_AA64SMFR0_EL1_SMEver_SHIFT, 4, FTR_UNSIGNED, ID_AA64SMFR0_EL1_SMEver_SME2, CAP_HWCAP, KERNEL_HWCAP_SME2),
 	HWCAP_CAP(SYS_ID_AA64SMFR0_EL1, ID_AA64SMFR0_EL1_I16I64_SHIFT, 4, FTR_UNSIGNED, ID_AA64SMFR0_EL1_I16I64_IMP, CAP_HWCAP, KERNEL_HWCAP_SME_I16I64),
 	HWCAP_CAP(SYS_ID_AA64SMFR0_EL1, ID_AA64SMFR0_EL1_F64F64_SHIFT, 1, FTR_UNSIGNED, ID_AA64SMFR0_EL1_F64F64_IMP, CAP_HWCAP, KERNEL_HWCAP_SME_F64F64),
+	HWCAP_CAP(SYS_ID_AA64SMFR0_EL1, ID_AA64SMFR0_EL1_F64F64_SHIFT, 1, FTR_UNSIGNED, ID_AA64SMFR0_EL1_B16B16_IMP, CAP_HWCAP, KERNEL_HWCAP_SME_B16B16),
+	HWCAP_CAP(SYS_ID_AA64SMFR0_EL1, ID_AA64SMFR0_EL1_F64F64_SHIFT, 1, FTR_UNSIGNED, ID_AA64SMFR0_EL1_F16F16_IMP, CAP_HWCAP, KERNEL_HWCAP_SME_F16F16),
 	HWCAP_CAP(SYS_ID_AA64SMFR0_EL1, ID_AA64SMFR0_EL1_I8I32_SHIFT, 4, FTR_UNSIGNED, ID_AA64SMFR0_EL1_I8I32_IMP, CAP_HWCAP, KERNEL_HWCAP_SME_I8I32),
 	HWCAP_CAP(SYS_ID_AA64SMFR0_EL1, ID_AA64SMFR0_EL1_F16F32_SHIFT, 1, FTR_UNSIGNED, ID_AA64SMFR0_EL1_F16F32_IMP, CAP_HWCAP, KERNEL_HWCAP_SME_F16F32),
 	HWCAP_CAP(SYS_ID_AA64SMFR0_EL1, ID_AA64SMFR0_EL1_B16F32_SHIFT, 1, FTR_UNSIGNED, ID_AA64SMFR0_EL1_B16F32_IMP, CAP_HWCAP, KERNEL_HWCAP_SME_B16F32),
+	HWCAP_CAP(SYS_ID_AA64SMFR0_EL1, ID_AA64SMFR0_EL1_B16F32_SHIFT, 1, FTR_UNSIGNED, ID_AA64SMFR0_EL1_BI32I32_IMP, CAP_HWCAP, KERNEL_HWCAP_SME_BI32I32),
 	HWCAP_CAP(SYS_ID_AA64SMFR0_EL1, ID_AA64SMFR0_EL1_F32F32_SHIFT, 1, FTR_UNSIGNED, ID_AA64SMFR0_EL1_F32F32_IMP, CAP_HWCAP, KERNEL_HWCAP_SME_F32F32),
 #endif /* CONFIG_ARM64_SME */
 	{},
diff --git a/arch/arm64/kernel/cpuinfo.c b/arch/arm64/kernel/cpuinfo.c
index 379695262b77..85e54417d141 100644
--- a/arch/arm64/kernel/cpuinfo.c
+++ b/arch/arm64/kernel/cpuinfo.c
@@ -119,6 +119,12 @@ static const char *const hwcap_str[] = {
 	[KERNEL_HWCAP_CSSC]		= "cssc",
 	[KERNEL_HWCAP_RPRFM]		= "rprfm",
 	[KERNEL_HWCAP_SVE2P1]		= "sve2p1",
+	[KERNEL_HWCAP_SME2]		= "sme2",
+	[KERNEL_HWCAP_SME2P1]		= "sme2p1",
+	[KERNEL_HWCAP_SME_I16I32]	= "smei16i32",
+	[KERNEL_HWCAP_SME_BI32I32]	= "smebi32i32",
+	[KERNEL_HWCAP_SME_B16B16]	= "smeb16b16",
+	[KERNEL_HWCAP_SME_F16F16]	= "smef16f16",
 };
 
 #ifdef CONFIG_COMPAT
-- 
2.30.2

