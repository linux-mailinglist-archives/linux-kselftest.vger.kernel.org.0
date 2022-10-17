Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4833B6012B8
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Oct 2022 17:26:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230135AbiJQP0r (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 17 Oct 2022 11:26:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230171AbiJQP0q (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 17 Oct 2022 11:26:46 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D12F37191
        for <linux-kselftest@vger.kernel.org>; Mon, 17 Oct 2022 08:26:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1436CB81909
        for <linux-kselftest@vger.kernel.org>; Mon, 17 Oct 2022 15:26:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 463EEC4347C;
        Mon, 17 Oct 2022 15:26:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666020402;
        bh=FrpsB5GqMNt+LthRzZXRIsR6Armhvx2HZji/9oIAvao=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dHFqYCi8BobaRwxMjx1NMqAOIKmiJStpfULuJlP3ppz0WtangHYoQ+rfujSFhGEgv
         ETnRWdqAXhmcI8nqibxJmIUUIQkDVkRdtLR/dzgSa2WT1o87fffP03TH7GdIbJFm0C
         Bk46DfTu0yk+PKpx6xE6134M3ThX+w+gimyYiimylpzEtR4RHTtIpocUvhmdjSw2D5
         4XYOaMwcjRuQTYwzt8krJQBl1dA8T/Qo+jrTdbypmqwz7yjJZf4yTjHg6Zn0AKBI1W
         1JZkiWfSTCtlWWt4BVcm+Hm++JwxK81IJ2ZYp+NX1dX80SC2V0MwFcjdHADlwclTd5
         ZTXdnPsYUgDOw==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH v1 1/6] arm64/hwcap: Add support for FEAT_CSSC
Date:   Mon, 17 Oct 2022 16:25:15 +0100
Message-Id: <20221017152520.1039165-2-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221017152520.1039165-1-broonie@kernel.org>
References: <20221017152520.1039165-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4235; i=broonie@kernel.org; h=from:subject; bh=FrpsB5GqMNt+LthRzZXRIsR6Armhvx2HZji/9oIAvao=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBjTXPaysKcpY9Yd7nbeFkVFU26JqW8OOddEQtBnz2d URJBx1GJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCY01z2gAKCRAk1otyXVSH0CN8B/ 9CeBuLo/TZznqESGhp3KRmd7+1yKp3MhKsuWGxz8yqbyotZXBgE+u6Ud5urUIiHiaPkH3P+P/RzZ1l LGYaV4DHUDqCw49qSFHWY8doml1LTfgo0raIpgRj7mp7ryYp84rUW5Eoig/V7vM05/P3oSCYK6SuXz IGbie94AZbp/3BSUhMefy8Ao8DwGWWcAWNP8/RiKlJqqG2zgTKcvvpS4S8gfay5nz1npApLFxVYOhL JVzi1BqnNcvQqIN+qiJmxJ+9RgZJk7tLf7/gaewN+wAfhCbPwRUAjM8OSouCsoD7blbrqn7zZdemnc EbxQ2iHOS26Y0b48DrO02QEQC+JHWN
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

FEAT_CSSC adds a number of new instructions usable to optimise common short
sequences of instructions, add a hwcap indicating that the feature is
available and can be used by userspace.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/arm64/elf_hwcaps.rst  | 3 +++
 arch/arm64/include/asm/hwcap.h      | 1 +
 arch/arm64/include/uapi/asm/hwcap.h | 1 +
 arch/arm64/kernel/cpufeature.c      | 2 ++
 arch/arm64/kernel/cpuinfo.c         | 1 +
 arch/arm64/tools/sysreg             | 7 ++++++-
 6 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/Documentation/arm64/elf_hwcaps.rst b/Documentation/arm64/elf_hwcaps.rst
index bb34287c8e01..58197e9ccb6d 100644
--- a/Documentation/arm64/elf_hwcaps.rst
+++ b/Documentation/arm64/elf_hwcaps.rst
@@ -275,6 +275,9 @@ HWCAP2_EBF16
 HWCAP2_SVE_EBF16
     Functionality implied by ID_AA64ZFR0_EL1.BF16 == 0b0010.
 
+HWCAP2_CSSC
+    Functionality implied by ID_AA64ISAR2_EL1.CSSC == 0b0001.
+
 4. Unused AT_HWCAP bits
 -----------------------
 
diff --git a/arch/arm64/include/asm/hwcap.h b/arch/arm64/include/asm/hwcap.h
index 298b386d3ebe..a0e080df9a62 100644
--- a/arch/arm64/include/asm/hwcap.h
+++ b/arch/arm64/include/asm/hwcap.h
@@ -120,6 +120,7 @@
 #define KERNEL_HWCAP_WFXT		__khwcap2_feature(WFXT)
 #define KERNEL_HWCAP_EBF16		__khwcap2_feature(EBF16)
 #define KERNEL_HWCAP_SVE_EBF16		__khwcap2_feature(SVE_EBF16)
+#define KERNEL_HWCAP_CSSC		__khwcap2_feature(CSSC)
 
 /*
  * This yields a mask that user programs can use to figure out what
diff --git a/arch/arm64/include/uapi/asm/hwcap.h b/arch/arm64/include/uapi/asm/hwcap.h
index 9b245da6f507..a43dddd94b4a 100644
--- a/arch/arm64/include/uapi/asm/hwcap.h
+++ b/arch/arm64/include/uapi/asm/hwcap.h
@@ -93,5 +93,6 @@
 #define HWCAP2_WFXT		(1UL << 31)
 #define HWCAP2_EBF16		(1UL << 32)
 #define HWCAP2_SVE_EBF16	(1UL << 33)
+#define HWCAP2_CSSC		(1UL << 34)
 
 #endif /* _UAPI__ASM_HWCAP_H */
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 6062454a9067..130cc9127dde 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -212,6 +212,7 @@ static const struct arm64_ftr_bits ftr_id_aa64isar1[] = {
 };
 
 static const struct arm64_ftr_bits ftr_id_aa64isar2[] = {
+	ARM64_FTR_BITS(FTR_VISIBLE, FTR_NONSTRICT, FTR_LOWER_SAFE, ID_AA64ISAR2_EL1_CSSC_SHIFT, 4, 0),
 	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_HIGHER_SAFE, ID_AA64ISAR2_EL1_BC_SHIFT, 4, 0),
 	ARM64_FTR_BITS(FTR_VISIBLE_IF_IS_ENABLED(CONFIG_ARM64_PTR_AUTH),
 		       FTR_STRICT, FTR_EXACT, ID_AA64ISAR2_EL1_APA3_SHIFT, 4, 0),
@@ -2774,6 +2775,7 @@ static const struct arm64_cpu_capabilities arm64_elf_hwcaps[] = {
 #endif /* CONFIG_ARM64_MTE */
 	HWCAP_CAP(SYS_ID_AA64MMFR0_EL1, ID_AA64MMFR0_EL1_ECV_SHIFT, 4, FTR_UNSIGNED, 1, CAP_HWCAP, KERNEL_HWCAP_ECV),
 	HWCAP_CAP(SYS_ID_AA64MMFR1_EL1, ID_AA64MMFR1_EL1_AFP_SHIFT, 4, FTR_UNSIGNED, 1, CAP_HWCAP, KERNEL_HWCAP_AFP),
+	HWCAP_CAP(SYS_ID_AA64ISAR2_EL1, ID_AA64ISAR2_EL1_CSSC_SHIFT, 4, FTR_UNSIGNED, ID_AA64ISAR2_EL1_CSSC_IMP, CAP_HWCAP, KERNEL_HWCAP_CSSC),
 	HWCAP_CAP(SYS_ID_AA64ISAR2_EL1, ID_AA64ISAR2_EL1_RPRES_SHIFT, 4, FTR_UNSIGNED, 1, CAP_HWCAP, KERNEL_HWCAP_RPRES),
 	HWCAP_CAP(SYS_ID_AA64ISAR2_EL1, ID_AA64ISAR2_EL1_WFxT_SHIFT, 4, FTR_UNSIGNED, ID_AA64ISAR2_EL1_WFxT_IMP, CAP_HWCAP, KERNEL_HWCAP_WFXT),
 #ifdef CONFIG_ARM64_SME
diff --git a/arch/arm64/kernel/cpuinfo.c b/arch/arm64/kernel/cpuinfo.c
index 28d4f442b0bc..3160550c0cc9 100644
--- a/arch/arm64/kernel/cpuinfo.c
+++ b/arch/arm64/kernel/cpuinfo.c
@@ -116,6 +116,7 @@ static const char *const hwcap_str[] = {
 	[KERNEL_HWCAP_WFXT]		= "wfxt",
 	[KERNEL_HWCAP_EBF16]		= "ebf16",
 	[KERNEL_HWCAP_SVE_EBF16]	= "sveebf16",
+	[KERNEL_HWCAP_CSSC]		= "cssc",
 };
 
 #ifdef CONFIG_COMPAT
diff --git a/arch/arm64/tools/sysreg b/arch/arm64/tools/sysreg
index 384757a7eda9..629d119151bf 100644
--- a/arch/arm64/tools/sysreg
+++ b/arch/arm64/tools/sysreg
@@ -484,7 +484,12 @@ EndEnum
 EndSysreg
 
 Sysreg	ID_AA64ISAR2_EL1	3	0	0	6	2
-Res0	63:28
+Res0	63:56
+Enum	55:52	CSSC
+	0b0000	NI
+	0b0001	IMP
+EndEnum
+Res0	51:28
 Enum	27:24	PAC_frac
 	0b0000	NI
 	0b0001	IMP
-- 
2.30.2

