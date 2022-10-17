Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28D526012B9
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Oct 2022 17:26:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230251AbiJQP0t (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 17 Oct 2022 11:26:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230171AbiJQP0s (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 17 Oct 2022 11:26:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C85F537191
        for <linux-kselftest@vger.kernel.org>; Mon, 17 Oct 2022 08:26:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 67CB961194
        for <linux-kselftest@vger.kernel.org>; Mon, 17 Oct 2022 15:26:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48988C43140;
        Mon, 17 Oct 2022 15:26:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666020406;
        bh=mmTGPzJIZgaNZHR9ynJ1gWHkWfgKy7hHPGj3lGvogQc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Dhl5+9qtgWNp/Wj4FHfgT7TYb4zDStro0ZHOTKMlel8iSbcjHN4wpSjp3NlU0FM6N
         D0O/+UZJ/4zaC/9cMu+5fMncclMiejE3BmXrS6ir+PKirDe1No8QWEM1R3W5nndqq0
         myMXnWA21WcscM9GPLJyLumEVypp9Q0D6PPmu+TzlIGjPinqOwq5rDmMIRubTKcNvi
         hQer5Ob5Km9p+wnngvqUo8DQ/GAzHXb7gAXm519SaBUVNiL0c/+A/LgNgwWGh26UvO
         mIAlGNWqv7qM3yTBAqLieyrrjIOekETXrFGrjHdQqqzxyFplH20F1Ea/xRGoqzlSVQ
         4rwuu8x3ZXxuA==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH v1 3/6] arm64/hwcap: Add support for FEAT_RPRFM
Date:   Mon, 17 Oct 2022 16:25:17 +0100
Message-Id: <20221017152520.1039165-4-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221017152520.1039165-1-broonie@kernel.org>
References: <20221017152520.1039165-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4422; i=broonie@kernel.org; h=from:subject; bh=mmTGPzJIZgaNZHR9ynJ1gWHkWfgKy7hHPGj3lGvogQc=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBjTXPc1FV6hpuWaDY5jv0K3+xN/zh6Z/+mVfLp5aKM ve89OGOJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCY01z3AAKCRAk1otyXVSH0FXKB/ 9PSjosbjkUQV/WA7kcASGjS4jDtvVA5iYOZEWYLGStfiHRa3RwVDGfhBieoDSmnOUcqIf6ePXn68pM ZuwuoUboKfqWhFWFayrvDh7eFHPN/WVaRjYYp0h8HZpEjgkKN44aNo57lAX3wjVyHMMTUN7sO6U8D+ O8ta4wDtBC1NxsVfyDSG+P4+A+YujxsrwO+Ij0cfZr1tVWZsWrZ79EWadbiLSK63cBDmhlvWXtHU/6 xSqNFlIRFE2dXE/lTIV9G6Sn32PX45c5bS0iBkgT/L3oQD3TxvQmAOo2JoAZ0qZuFwjsdwlNQV5VpZ QtY2cotdeylZAZi9JFnvKtBdBcxDlC
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

FEAT_RPRFM adds a new range prefetch hint within the existing PRFM space
for range prefetch hinting. Add a new hwcap to allow userspace to discover
support for the new instruction.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/arm64/elf_hwcaps.rst  | 3 +++
 arch/arm64/include/asm/hwcap.h      | 1 +
 arch/arm64/include/uapi/asm/hwcap.h | 1 +
 arch/arm64/kernel/cpufeature.c      | 2 ++
 arch/arm64/kernel/cpuinfo.c         | 1 +
 arch/arm64/tools/sysreg             | 6 +++++-
 6 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/Documentation/arm64/elf_hwcaps.rst b/Documentation/arm64/elf_hwcaps.rst
index 58197e9ccb6d..a82b2cdff680 100644
--- a/Documentation/arm64/elf_hwcaps.rst
+++ b/Documentation/arm64/elf_hwcaps.rst
@@ -278,6 +278,9 @@ HWCAP2_SVE_EBF16
 HWCAP2_CSSC
     Functionality implied by ID_AA64ISAR2_EL1.CSSC == 0b0001.
 
+HWCAP2_RPRFM
+    Functionality implied by ID_AA64ISAR2_EL1.RPRFM == 0b0001.
+
 4. Unused AT_HWCAP bits
 -----------------------
 
diff --git a/arch/arm64/include/asm/hwcap.h b/arch/arm64/include/asm/hwcap.h
index a0e080df9a62..605ec55cee70 100644
--- a/arch/arm64/include/asm/hwcap.h
+++ b/arch/arm64/include/asm/hwcap.h
@@ -121,6 +121,7 @@
 #define KERNEL_HWCAP_EBF16		__khwcap2_feature(EBF16)
 #define KERNEL_HWCAP_SVE_EBF16		__khwcap2_feature(SVE_EBF16)
 #define KERNEL_HWCAP_CSSC		__khwcap2_feature(CSSC)
+#define KERNEL_HWCAP_RPRFM		__khwcap2_feature(RPRFM)
 
 /*
  * This yields a mask that user programs can use to figure out what
diff --git a/arch/arm64/include/uapi/asm/hwcap.h b/arch/arm64/include/uapi/asm/hwcap.h
index a43dddd94b4a..063cc6ea560f 100644
--- a/arch/arm64/include/uapi/asm/hwcap.h
+++ b/arch/arm64/include/uapi/asm/hwcap.h
@@ -94,5 +94,6 @@
 #define HWCAP2_EBF16		(1UL << 32)
 #define HWCAP2_SVE_EBF16	(1UL << 33)
 #define HWCAP2_CSSC		(1UL << 34)
+#define HWCAP2_RPRFM		(1UL << 35)
 
 #endif /* _UAPI__ASM_HWCAP_H */
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 130cc9127dde..01bd72ff9617 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -213,6 +213,7 @@ static const struct arm64_ftr_bits ftr_id_aa64isar1[] = {
 
 static const struct arm64_ftr_bits ftr_id_aa64isar2[] = {
 	ARM64_FTR_BITS(FTR_VISIBLE, FTR_NONSTRICT, FTR_LOWER_SAFE, ID_AA64ISAR2_EL1_CSSC_SHIFT, 4, 0),
+	ARM64_FTR_BITS(FTR_VISIBLE, FTR_NONSTRICT, FTR_LOWER_SAFE, ID_AA64ISAR2_EL1_RPRFM_SHIFT, 4, 0),
 	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_HIGHER_SAFE, ID_AA64ISAR2_EL1_BC_SHIFT, 4, 0),
 	ARM64_FTR_BITS(FTR_VISIBLE_IF_IS_ENABLED(CONFIG_ARM64_PTR_AUTH),
 		       FTR_STRICT, FTR_EXACT, ID_AA64ISAR2_EL1_APA3_SHIFT, 4, 0),
@@ -2776,6 +2777,7 @@ static const struct arm64_cpu_capabilities arm64_elf_hwcaps[] = {
 	HWCAP_CAP(SYS_ID_AA64MMFR0_EL1, ID_AA64MMFR0_EL1_ECV_SHIFT, 4, FTR_UNSIGNED, 1, CAP_HWCAP, KERNEL_HWCAP_ECV),
 	HWCAP_CAP(SYS_ID_AA64MMFR1_EL1, ID_AA64MMFR1_EL1_AFP_SHIFT, 4, FTR_UNSIGNED, 1, CAP_HWCAP, KERNEL_HWCAP_AFP),
 	HWCAP_CAP(SYS_ID_AA64ISAR2_EL1, ID_AA64ISAR2_EL1_CSSC_SHIFT, 4, FTR_UNSIGNED, ID_AA64ISAR2_EL1_CSSC_IMP, CAP_HWCAP, KERNEL_HWCAP_CSSC),
+	HWCAP_CAP(SYS_ID_AA64ISAR2_EL1, ID_AA64ISAR2_EL1_RPRFM_SHIFT, 4, FTR_UNSIGNED, ID_AA64ISAR2_EL1_RPRFM_IMP, CAP_HWCAP, KERNEL_HWCAP_RPRFM),
 	HWCAP_CAP(SYS_ID_AA64ISAR2_EL1, ID_AA64ISAR2_EL1_RPRES_SHIFT, 4, FTR_UNSIGNED, 1, CAP_HWCAP, KERNEL_HWCAP_RPRES),
 	HWCAP_CAP(SYS_ID_AA64ISAR2_EL1, ID_AA64ISAR2_EL1_WFxT_SHIFT, 4, FTR_UNSIGNED, ID_AA64ISAR2_EL1_WFxT_IMP, CAP_HWCAP, KERNEL_HWCAP_WFXT),
 #ifdef CONFIG_ARM64_SME
diff --git a/arch/arm64/kernel/cpuinfo.c b/arch/arm64/kernel/cpuinfo.c
index 3160550c0cc9..85108832d86e 100644
--- a/arch/arm64/kernel/cpuinfo.c
+++ b/arch/arm64/kernel/cpuinfo.c
@@ -117,6 +117,7 @@ static const char *const hwcap_str[] = {
 	[KERNEL_HWCAP_EBF16]		= "ebf16",
 	[KERNEL_HWCAP_SVE_EBF16]	= "sveebf16",
 	[KERNEL_HWCAP_CSSC]		= "cssc",
+	[KERNEL_HWCAP_RPRFM]		= "rprfm",
 };
 
 #ifdef CONFIG_COMPAT
diff --git a/arch/arm64/tools/sysreg b/arch/arm64/tools/sysreg
index 629d119151bf..a2b2e4c1c3f2 100644
--- a/arch/arm64/tools/sysreg
+++ b/arch/arm64/tools/sysreg
@@ -489,7 +489,11 @@ Enum	55:52	CSSC
 	0b0000	NI
 	0b0001	IMP
 EndEnum
-Res0	51:28
+Enum	51:48	RPRFM
+	0b0000	NI
+	0b0001	IMP
+EndEnum
+Res0	47:28
 Enum	27:24	PAC_frac
 	0b0000	NI
 	0b0001	IMP
-- 
2.30.2

