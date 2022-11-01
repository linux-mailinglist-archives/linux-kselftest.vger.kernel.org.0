Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E693D614CD7
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Nov 2022 15:39:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbiKAOjx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 1 Nov 2022 10:39:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230335AbiKAOjv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 1 Nov 2022 10:39:51 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB012120B8
        for <linux-kselftest@vger.kernel.org>; Tue,  1 Nov 2022 07:39:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6FFB2B81DDF
        for <linux-kselftest@vger.kernel.org>; Tue,  1 Nov 2022 14:39:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 111ADC433D7;
        Tue,  1 Nov 2022 14:39:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667313588;
        bh=EzLh9y/wWpOrmNDMdT1ovFCSwFhlQ56HhItuIoPkVgw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TrgBANjIf5PT6Z4k1hSdSE1sXPbTZ8geZvBZsUHfghtuo74dFE+HRcD3OIPu29QNb
         mJQ404k4srL8+598v7f8pqCBw+64eL7x3Rim7eK76y8oNIuFtey004qeJ7zmOwlpTw
         Bxr1+7QNtmSgQCzXl6W1DRADVE8U11OYruzSUAd38co++bQzRf6umZQs1blMqLtimo
         UETmy/iqMSJ90YlteY28OySFkfMNQ5hzXZPYZ+ISGAHVTOeI40DiEXxxBiWOHgRF0O
         PPbJf0SJp3ADHG8+CbTTryOK884kwFFbFLRRvu+yJ5LrDKSzOyQ/YbrpduJGyP6H4d
         bTbAp0Hdiqrjg==
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
Subject: [PATCH v2 13/21] arm64/sme: Add hwcaps for SME 2 and 2.1 features
Date:   Tue,  1 Nov 2022 14:33:28 +0000
Message-Id: <20221101143336.254445-14-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221101143336.254445-1-broonie@kernel.org>
References: <20221101143336.254445-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7092; i=broonie@kernel.org; h=from:subject; bh=EzLh9y/wWpOrmNDMdT1ovFCSwFhlQ56HhItuIoPkVgw=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBjYS42tXWhw3c5emwbCVSBcNlWm7BnECun0MgWc8Db mIn7X4CJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCY2EuNgAKCRAk1otyXVSH0KQCB/ 9iuOJ0+xC03W+EFw5J3xR0eBuHwjcpysfy098bbCLFGuH9I8pBKh5rAwrFEO4NhgvMemjF7bH4Z/rk vQ1vfLC4omUdzQrAB1cLukslOMpFRjXJQH0Nd5p6d2WHsLzbB5ex7bOjQ35Lw4ut/49uq7aZw4Qou4 VRxVcayfPD/B++KfwZAQDd+UAUxDq5XwufEj3U51XunDMa+2bv9cNCESPEk1mMhbRYiAAI3+Mq29tO TE6atB4DN6o3B9q25ajCD/G8zQHtmy4e6uuKvAgYmkg1WhtYfvjvCcW8DxbyzyHJ9470fW2Ap1SYZF +VTcKXrdCG5PJcudPy4rH/3ZtdBeZS
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
index 416785eeb512..fd517dfe909a 100644
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
@@ -2798,11 +2806,16 @@ static const struct arm64_cpu_capabilities arm64_elf_hwcaps[] = {
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

