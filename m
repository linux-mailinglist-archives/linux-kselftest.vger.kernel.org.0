Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C70097D8316
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Oct 2023 14:48:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345135AbjJZMsH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 26 Oct 2023 08:48:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235029AbjJZMrn (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 26 Oct 2023 08:47:43 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43068D4D;
        Thu, 26 Oct 2023 05:47:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 169DCC433C9;
        Thu, 26 Oct 2023 12:47:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698324445;
        bh=4OXDOFakN2kGeGyBUbfy2pFYD4qDL67ZeSXZ8Z9LAmA=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=gk9ihdiGGV3KC1p2YzsPscPeHTn8J0JTqJG/cZ1rAhV2detVB0thWf3bSlpZt2LMD
         y7ShSDegeMFN/DgJNTSu+Bb6Dbv4bLRJoahHs06BE8d6AT20oDLoZ5JOS4y3IFf3Bh
         H8wGhArBm6igko4WihWjN+tF6GVOxZktgELX9VmKKE2mfbPKips0o7Z1Jitxwpuvyc
         5rQk2bKOi9D7oRclFQUdseBUWjAE7fJ6DNMlYdc808Zni/PPEFA62rjT4fVZmiUpOa
         ag+Zx7rIthCk9hfN9l16ELs8Rh5clsS8rrbLaLcC1di5VHC1rHdYv9UASb4bz4ezrf
         /pd+mQhFdlR9A==
From:   Mark Brown <broonie@kernel.org>
Date:   Thu, 26 Oct 2023 13:44:30 +0100
Subject: [PATCH 16/21] arm64/hwcap: Define hwcaps for 2023 DPISA features
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231026-arm64-2023-dpisa-v1-16-8470dd989bb2@kernel.org>
References: <20231026-arm64-2023-dpisa-v1-0-8470dd989bb2@kernel.org>
In-Reply-To: <20231026-arm64-2023-dpisa-v1-0-8470dd989bb2@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kvmarm@lists.linux.dev, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-0438c
X-Developer-Signature: v=1; a=openpgp-sha256; l=12791; i=broonie@kernel.org;
 h=from:subject:message-id; bh=4OXDOFakN2kGeGyBUbfy2pFYD4qDL67ZeSXZ8Z9LAmA=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlOl+gtbgo+cGG4P4PmvpcGxxA5j1nYbpjslXq2Tjr
 CGkljGOJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZTpfoAAKCRAk1otyXVSH0P1JB/
 9U8bkUm8lJD5GRHO3INoQInYh8KdGuaSYUkzl/LdxsTRZKVVlClrJHqRXOEbacKewVcfud/y2oB/sc
 4NMFahxfzpv15VmFjdFwYW2CdGxJQu2/BNSgk2E0VULyS06YOdfEVCCa0d5355L0QNzS2as4JKJhKp
 tGC51WidN6o3gu9oozYQz86Z78j7bx8XCX2AYhEyEnD35V5lYpHJ6m7NAbZpEmkuhfLqUaaVN1vpF4
 xV5pJlO5GRHTvQYL8dOF0TyfBHswVRBkYI2fjZdbDizCDJdT6DiG/eq+bru0IqD608b3BMnVNVNzU2
 hA1VJ9XIA2DxlNCjeURQ9CI05BgUI5
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The 2023 architecture extensions include a large number of floating point
features, most of which simply add new instructions. Add hwcaps so that
userspace can enumerate these features.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/arch/arm64/elf_hwcaps.rst | 49 +++++++++++++++++++++++++++++++++
 arch/arm64/include/asm/hwcap.h          | 15 ++++++++++
 arch/arm64/include/uapi/asm/hwcap.h     | 15 ++++++++++
 arch/arm64/kernel/cpufeature.c          | 35 +++++++++++++++++++++++
 arch/arm64/kernel/cpuinfo.c             | 15 ++++++++++
 5 files changed, 129 insertions(+)

diff --git a/Documentation/arch/arm64/elf_hwcaps.rst b/Documentation/arch/arm64/elf_hwcaps.rst
index 76ff9d7398fd..777d8b868f98 100644
--- a/Documentation/arch/arm64/elf_hwcaps.rst
+++ b/Documentation/arch/arm64/elf_hwcaps.rst
@@ -308,6 +308,55 @@ HWCAP2_MOPS
 HWCAP2_HBC
     Functionality implied by ID_AA64ISAR2_EL1.BC == 0b0001.
 
+HWCAP2_FPMR
+    Functionality implied by ID_AA64PFR2_EL1.FMR == 0b0001.
+
+HWCAP2_LUT
+    Functionality implied by ID_AA64ISAR2_EL1.LUT == 0b0001.
+
+HWCAP2_FAMINMAX
+    Functionality implied by ID_AA64ISAR3_EL1.FAMINMAX == 0b0001.
+
+HWCAP2_F8CVT
+    Functionality implied by ID_AA64FPFR0_EL1.F8CVT == 0b1.
+
+HWCAP2_F8FMA
+    Functionality implied by ID_AA64FPFR0_EL1.F8FMA == 0b1.
+
+HWCAP2_F8DP4
+    Functionality implied by ID_AA64FPFR0_EL1.F8DP4 == 0b1.
+
+HWCAP2_F8DP2
+    Functionality implied by ID_AA64FPFR0_EL1.F8DP2 == 0b1.
+
+HWCAP2_F8E4M3
+    Functionality implied by ID_AA64FPFR0_EL1.F8E4M3 == 0b1.
+
+HWCAP2_F8E5M2
+    Functionality implied by ID_AA64FPFR0_EL1.F8E5M2 == 0b1.
+
+HWCAP2_SME_LUTV2
+    Functionality implied by ID_AA64SMFR0_EL1.LUTv2 == 0b1.
+
+HWCAP2_SME_F8F16
+    Functionality implied by ID_AA64SMFR0_EL1.F8F16 == 0b1.
+
+HWCAP2_SME_F8F32
+    Functionality implied by ID_AA64SMFR0_EL1.F8F32 == 0b1.
+
+HWCAP2_SME_SF8FMA
+    Functionality implied by ID_AA64SMFR0_EL1.SF8FMA == 0b1.
+
+HWCAP2_SME_SF8DP4
+    Functionality implied by ID_AA64SMFR0_EL1.SF8DP4 == 0b1.
+
+HWCAP2_SME_SF8DP2
+    Functionality implied by ID_AA64SMFR0_EL1.SF8DP2 == 0b1.
+
+HWCAP2_SME_SF8DP4
+    Functionality implied by ID_AA64SMFR0_EL1.SF8DP4 == 0b1.
+
+
 4. Unused AT_HWCAP bits
 -----------------------
 
diff --git a/arch/arm64/include/asm/hwcap.h b/arch/arm64/include/asm/hwcap.h
index 521267478d18..046978936d25 100644
--- a/arch/arm64/include/asm/hwcap.h
+++ b/arch/arm64/include/asm/hwcap.h
@@ -139,6 +139,21 @@
 #define KERNEL_HWCAP_SME_F16F16		__khwcap2_feature(SME_F16F16)
 #define KERNEL_HWCAP_MOPS		__khwcap2_feature(MOPS)
 #define KERNEL_HWCAP_HBC		__khwcap2_feature(HBC)
+#define KERNEL_HWCAP_FPMR		__khwcap2_feature(FPMR)
+#define KERNEL_HWCAP_LUT		__khwcap2_feature(LUT)
+#define KERNEL_HWCAP_FAMINMAX		__khwcap2_feature(FAMINMAX)
+#define KERNEL_HWCAP_F8CVT		__khwcap2_feature(F8CVT)
+#define KERNEL_HWCAP_F8FMA		__khwcap2_feature(F8FMA)
+#define KERNEL_HWCAP_F8DP4		__khwcap2_feature(F8DP4)
+#define KERNEL_HWCAP_F8DP2		__khwcap2_feature(F8DP2)
+#define KERNEL_HWCAP_F8E4M3		__khwcap2_feature(F8E4M3)
+#define KERNEL_HWCAP_F8E5M2		__khwcap2_feature(F8E5M2)
+#define KERNEL_HWCAP_SME_LUTV2		__khwcap2_feature(SME_LUTV2)
+#define KERNEL_HWCAP_SME_F8F16		__khwcap2_feature(SME_F8F16)
+#define KERNEL_HWCAP_SME_F8F32		__khwcap2_feature(SME_F8F32)
+#define KERNEL_HWCAP_SME_SF8FMA		__khwcap2_feature(SME_SF8FMA)
+#define KERNEL_HWCAP_SME_SF8DP4		__khwcap2_feature(SME_SF8DP4)
+#define KERNEL_HWCAP_SME_SF8DP2		__khwcap2_feature(SME_SF8DP2)
 
 /*
  * This yields a mask that user programs can use to figure out what
diff --git a/arch/arm64/include/uapi/asm/hwcap.h b/arch/arm64/include/uapi/asm/hwcap.h
index 53026f45a509..0f0aa9006cef 100644
--- a/arch/arm64/include/uapi/asm/hwcap.h
+++ b/arch/arm64/include/uapi/asm/hwcap.h
@@ -104,5 +104,20 @@
 #define HWCAP2_SME_F16F16	(1UL << 42)
 #define HWCAP2_MOPS		(1UL << 43)
 #define HWCAP2_HBC		(1UL << 44)
+#define HWCAP2_FPMR		(1UL << 45)
+#define HWCAP2_LUT		(1UL << 46)
+#define HWCAP2_FAMINMAX		(1UL << 47)
+#define HWCAP2_F8CVT		(1UL << 48)
+#define HWCAP2_F8FMA		(1UL << 49)
+#define HWCAP2_F8DP4		(1UL << 50)
+#define HWCAP2_F8DP2		(1UL << 51)
+#define HWCAP2_F8E4M3		(1UL << 52)
+#define HWCAP2_F8E5M2		(1UL << 53)
+#define HWCAP2_SME_LUTV2	(1UL << 54)
+#define HWCAP2_SME_F8F16	(1UL << 55)
+#define HWCAP2_SME_F8F32	(1UL << 56)
+#define HWCAP2_SME_SF8FMA	(1UL << 57)
+#define HWCAP2_SME_SF8DP4	(1UL << 58)
+#define HWCAP2_SME_SF8DP2	(1UL << 59)
 
 #endif /* _UAPI__ASM_HWCAP_H */
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 8e8cd411d1a2..2c85bc9e644c 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -220,6 +220,7 @@ static const struct arm64_ftr_bits ftr_id_aa64isar1[] = {
 };
 
 static const struct arm64_ftr_bits ftr_id_aa64isar2[] = {
+	ARM64_FTR_BITS(FTR_VISIBLE, FTR_NONSTRICT, FTR_LOWER_SAFE, ID_AA64ISAR2_EL1_LUT_SHIFT, 4, 0),
 	ARM64_FTR_BITS(FTR_VISIBLE, FTR_NONSTRICT, FTR_LOWER_SAFE, ID_AA64ISAR2_EL1_CSSC_SHIFT, 4, 0),
 	ARM64_FTR_BITS(FTR_VISIBLE, FTR_NONSTRICT, FTR_LOWER_SAFE, ID_AA64ISAR2_EL1_RPRFM_SHIFT, 4, 0),
 	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64ISAR2_EL1_CLRBHB_SHIFT, 4, 0),
@@ -235,6 +236,7 @@ static const struct arm64_ftr_bits ftr_id_aa64isar2[] = {
 };
 
 static const struct arm64_ftr_bits ftr_id_aa64isar3[] = {
+	ARM64_FTR_BITS(FTR_VISIBLE, FTR_NONSTRICT, FTR_LOWER_SAFE, ID_AA64ISAR3_EL1_FAMINMAX_SHIFT, 4, 0),
 	ARM64_FTR_END,
 };
 
@@ -301,6 +303,8 @@ static const struct arm64_ftr_bits ftr_id_aa64zfr0[] = {
 static const struct arm64_ftr_bits ftr_id_aa64smfr0[] = {
 	ARM64_FTR_BITS(FTR_VISIBLE_IF_IS_ENABLED(CONFIG_ARM64_SME),
 		       FTR_STRICT, FTR_EXACT, ID_AA64SMFR0_EL1_FA64_SHIFT, 1, 0),
+	ARM64_FTR_BITS(FTR_VISIBLE_IF_IS_ENABLED(CONFIG_ARM64_SME),
+		       FTR_STRICT, FTR_EXACT, ID_AA64SMFR0_EL1_LUTv2_SHIFT, 1, 0),
 	ARM64_FTR_BITS(FTR_VISIBLE_IF_IS_ENABLED(CONFIG_ARM64_SME),
 		       FTR_STRICT, FTR_EXACT, ID_AA64SMFR0_EL1_SMEver_SHIFT, 4, 0),
 	ARM64_FTR_BITS(FTR_VISIBLE_IF_IS_ENABLED(CONFIG_ARM64_SME),
@@ -313,6 +317,10 @@ static const struct arm64_ftr_bits ftr_id_aa64smfr0[] = {
 		       FTR_STRICT, FTR_EXACT, ID_AA64SMFR0_EL1_B16B16_SHIFT, 1, 0),
 	ARM64_FTR_BITS(FTR_VISIBLE_IF_IS_ENABLED(CONFIG_ARM64_SME),
 		       FTR_STRICT, FTR_EXACT, ID_AA64SMFR0_EL1_F16F16_SHIFT, 1, 0),
+	ARM64_FTR_BITS(FTR_VISIBLE_IF_IS_ENABLED(CONFIG_ARM64_SME),
+		       FTR_STRICT, FTR_EXACT, ID_AA64SMFR0_EL1_F8F16_SHIFT, 1, 0),
+	ARM64_FTR_BITS(FTR_VISIBLE_IF_IS_ENABLED(CONFIG_ARM64_SME),
+		       FTR_STRICT, FTR_EXACT, ID_AA64SMFR0_EL1_F8F32_SHIFT, 1, 0),
 	ARM64_FTR_BITS(FTR_VISIBLE_IF_IS_ENABLED(CONFIG_ARM64_SME),
 		       FTR_STRICT, FTR_EXACT, ID_AA64SMFR0_EL1_I8I32_SHIFT, 4, 0),
 	ARM64_FTR_BITS(FTR_VISIBLE_IF_IS_ENABLED(CONFIG_ARM64_SME),
@@ -323,10 +331,22 @@ static const struct arm64_ftr_bits ftr_id_aa64smfr0[] = {
 		       FTR_STRICT, FTR_EXACT, ID_AA64SMFR0_EL1_BI32I32_SHIFT, 1, 0),
 	ARM64_FTR_BITS(FTR_VISIBLE_IF_IS_ENABLED(CONFIG_ARM64_SME),
 		       FTR_STRICT, FTR_EXACT, ID_AA64SMFR0_EL1_F32F32_SHIFT, 1, 0),
+	ARM64_FTR_BITS(FTR_VISIBLE_IF_IS_ENABLED(CONFIG_ARM64_SME),
+		       FTR_STRICT, FTR_EXACT, ID_AA64SMFR0_EL1_SF8FMA_SHIFT, 1, 0),
+	ARM64_FTR_BITS(FTR_VISIBLE_IF_IS_ENABLED(CONFIG_ARM64_SME),
+		       FTR_STRICT, FTR_EXACT, ID_AA64SMFR0_EL1_SF8DP4_SHIFT, 1, 0),
+	ARM64_FTR_BITS(FTR_VISIBLE_IF_IS_ENABLED(CONFIG_ARM64_SME),
+		       FTR_STRICT, FTR_EXACT, ID_AA64SMFR0_EL1_SF8DP2_SHIFT, 1, 0),
 	ARM64_FTR_END,
 };
 
 static const struct arm64_ftr_bits ftr_id_aa64fpfr0[] = {
+	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_EXACT, ID_AA64FPFR0_EL1_F8CVT_SHIFT, 1, 0),
+	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_EXACT, ID_AA64FPFR0_EL1_F8FMA_SHIFT, 1, 0),
+	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_EXACT, ID_AA64FPFR0_EL1_F8DP4_SHIFT, 1, 0),
+	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_EXACT, ID_AA64FPFR0_EL1_F8DP2_SHIFT, 1, 0),
+	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_EXACT, ID_AA64FPFR0_EL1_F8E4M3_SHIFT, 1, 0),
+	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_EXACT, ID_AA64FPFR0_EL1_F8E5M2_SHIFT, 1, 0),
 	ARM64_FTR_END,
 };
 
@@ -2838,6 +2858,7 @@ static const struct arm64_cpu_capabilities arm64_elf_hwcaps[] = {
 	HWCAP_CAP(ID_AA64PFR0_EL1, AdvSIMD, IMP, CAP_HWCAP, KERNEL_HWCAP_ASIMD),
 	HWCAP_CAP(ID_AA64PFR0_EL1, AdvSIMD, FP16, CAP_HWCAP, KERNEL_HWCAP_ASIMDHP),
 	HWCAP_CAP(ID_AA64PFR0_EL1, DIT, IMP, CAP_HWCAP, KERNEL_HWCAP_DIT),
+	HWCAP_CAP(ID_AA64PFR2_EL1, FPMR, IMP, CAP_HWCAP, KERNEL_HWCAP_FPMR),
 	HWCAP_CAP(ID_AA64ISAR1_EL1, DPB, IMP, CAP_HWCAP, KERNEL_HWCAP_DCPOP),
 	HWCAP_CAP(ID_AA64ISAR1_EL1, DPB, DPB2, CAP_HWCAP, KERNEL_HWCAP_DCPODP),
 	HWCAP_CAP(ID_AA64ISAR1_EL1, JSCVT, IMP, CAP_HWCAP, KERNEL_HWCAP_JSCVT),
@@ -2850,6 +2871,8 @@ static const struct arm64_cpu_capabilities arm64_elf_hwcaps[] = {
 	HWCAP_CAP(ID_AA64ISAR1_EL1, BF16, EBF16, CAP_HWCAP, KERNEL_HWCAP_EBF16),
 	HWCAP_CAP(ID_AA64ISAR1_EL1, DGH, IMP, CAP_HWCAP, KERNEL_HWCAP_DGH),
 	HWCAP_CAP(ID_AA64ISAR1_EL1, I8MM, IMP, CAP_HWCAP, KERNEL_HWCAP_I8MM),
+	HWCAP_CAP(ID_AA64ISAR2_EL1, LUT, IMP, CAP_HWCAP, KERNEL_HWCAP_LUT),
+	HWCAP_CAP(ID_AA64ISAR3_EL1, FAMINMAX, IMP, CAP_HWCAP, KERNEL_HWCAP_FAMINMAX),
 	HWCAP_CAP(ID_AA64MMFR2_EL1, AT, IMP, CAP_HWCAP, KERNEL_HWCAP_USCAT),
 #ifdef CONFIG_ARM64_SVE
 	HWCAP_CAP(ID_AA64PFR0_EL1, SVE, IMP, CAP_HWCAP, KERNEL_HWCAP_SVE),
@@ -2889,6 +2912,7 @@ static const struct arm64_cpu_capabilities arm64_elf_hwcaps[] = {
 #ifdef CONFIG_ARM64_SME
 	HWCAP_CAP(ID_AA64PFR1_EL1, SME, IMP, CAP_HWCAP, KERNEL_HWCAP_SME),
 	HWCAP_CAP(ID_AA64SMFR0_EL1, FA64, IMP, CAP_HWCAP, KERNEL_HWCAP_SME_FA64),
+	HWCAP_CAP(ID_AA64SMFR0_EL1, LUTv2, IMP, CAP_HWCAP, KERNEL_HWCAP_SME_LUTV2),
 	HWCAP_CAP(ID_AA64SMFR0_EL1, SMEver, SME2p1, CAP_HWCAP, KERNEL_HWCAP_SME2P1),
 	HWCAP_CAP(ID_AA64SMFR0_EL1, SMEver, SME2, CAP_HWCAP, KERNEL_HWCAP_SME2),
 	HWCAP_CAP(ID_AA64SMFR0_EL1, I16I64, IMP, CAP_HWCAP, KERNEL_HWCAP_SME_I16I64),
@@ -2896,12 +2920,23 @@ static const struct arm64_cpu_capabilities arm64_elf_hwcaps[] = {
 	HWCAP_CAP(ID_AA64SMFR0_EL1, I16I32, IMP, CAP_HWCAP, KERNEL_HWCAP_SME_I16I32),
 	HWCAP_CAP(ID_AA64SMFR0_EL1, B16B16, IMP, CAP_HWCAP, KERNEL_HWCAP_SME_B16B16),
 	HWCAP_CAP(ID_AA64SMFR0_EL1, F16F16, IMP, CAP_HWCAP, KERNEL_HWCAP_SME_F16F16),
+	HWCAP_CAP(ID_AA64SMFR0_EL1, F8F16, IMP, CAP_HWCAP, KERNEL_HWCAP_SME_F8F16),
+	HWCAP_CAP(ID_AA64SMFR0_EL1, F8F32, IMP, CAP_HWCAP, KERNEL_HWCAP_SME_F8F32),
 	HWCAP_CAP(ID_AA64SMFR0_EL1, I8I32, IMP, CAP_HWCAP, KERNEL_HWCAP_SME_I8I32),
 	HWCAP_CAP(ID_AA64SMFR0_EL1, F16F32, IMP, CAP_HWCAP, KERNEL_HWCAP_SME_F16F32),
 	HWCAP_CAP(ID_AA64SMFR0_EL1, B16F32, IMP, CAP_HWCAP, KERNEL_HWCAP_SME_B16F32),
 	HWCAP_CAP(ID_AA64SMFR0_EL1, BI32I32, IMP, CAP_HWCAP, KERNEL_HWCAP_SME_BI32I32),
 	HWCAP_CAP(ID_AA64SMFR0_EL1, F32F32, IMP, CAP_HWCAP, KERNEL_HWCAP_SME_F32F32),
+	HWCAP_CAP(ID_AA64SMFR0_EL1, SF8FMA, IMP, CAP_HWCAP, KERNEL_HWCAP_SME_SF8FMA),
+	HWCAP_CAP(ID_AA64SMFR0_EL1, SF8DP4, IMP, CAP_HWCAP, KERNEL_HWCAP_SME_SF8DP4),
+	HWCAP_CAP(ID_AA64SMFR0_EL1, SF8DP2, IMP, CAP_HWCAP, KERNEL_HWCAP_SME_SF8DP2),
 #endif /* CONFIG_ARM64_SME */
+	HWCAP_CAP(ID_AA64FPFR0_EL1, F8CVT, IMP, CAP_HWCAP, KERNEL_HWCAP_F8CVT),
+	HWCAP_CAP(ID_AA64FPFR0_EL1, F8FMA, IMP, CAP_HWCAP, KERNEL_HWCAP_F8FMA),
+	HWCAP_CAP(ID_AA64FPFR0_EL1, F8DP4, IMP, CAP_HWCAP, KERNEL_HWCAP_F8DP4),
+	HWCAP_CAP(ID_AA64FPFR0_EL1, F8DP2, IMP, CAP_HWCAP, KERNEL_HWCAP_F8DP2),
+	HWCAP_CAP(ID_AA64FPFR0_EL1, F8E4M3, IMP, CAP_HWCAP, KERNEL_HWCAP_F8E4M3),
+	HWCAP_CAP(ID_AA64FPFR0_EL1, F8E5M2, IMP, CAP_HWCAP, KERNEL_HWCAP_F8E5M2),
 	{},
 };
 
diff --git a/arch/arm64/kernel/cpuinfo.c b/arch/arm64/kernel/cpuinfo.c
index e153c6d2b3fd..9ff497ca70b4 100644
--- a/arch/arm64/kernel/cpuinfo.c
+++ b/arch/arm64/kernel/cpuinfo.c
@@ -127,6 +127,21 @@ static const char *const hwcap_str[] = {
 	[KERNEL_HWCAP_SME_F16F16]	= "smef16f16",
 	[KERNEL_HWCAP_MOPS]		= "mops",
 	[KERNEL_HWCAP_HBC]		= "hbc",
+	[KERNEL_HWCAP_FPMR]		= "fpmr",
+	[KERNEL_HWCAP_LUT]		= "lut",
+	[KERNEL_HWCAP_FAMINMAX]		= "faminmax",
+	[KERNEL_HWCAP_F8CVT]		= "f8cvt",
+	[KERNEL_HWCAP_F8FMA]		= "f8fma",
+	[KERNEL_HWCAP_F8DP4]		= "f8dp4",
+	[KERNEL_HWCAP_F8DP2]		= "f8dp2",
+	[KERNEL_HWCAP_F8E4M3]		= "f8e4m3",
+	[KERNEL_HWCAP_F8E5M2]		= "f8e5m2",
+	[KERNEL_HWCAP_SME_LUTV2]	= "smelutv2",
+	[KERNEL_HWCAP_SME_F8F16]	= "smef8f16",
+	[KERNEL_HWCAP_SME_F8F32]	= "smef8f32",
+	[KERNEL_HWCAP_SME_SF8FMA]	= "smesf8fma",
+	[KERNEL_HWCAP_SME_SF8DP4]	= "smesf8dp4",
+	[KERNEL_HWCAP_SME_SF8DP2]	= "smesf8dp2",
 };
 
 #ifdef CONFIG_COMPAT

-- 
2.30.2

