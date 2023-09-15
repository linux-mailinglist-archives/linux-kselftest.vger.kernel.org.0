Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C47F97A1E91
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Sep 2023 14:23:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234842AbjIOMXS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 15 Sep 2023 08:23:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234775AbjIOMXR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 15 Sep 2023 08:23:17 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63C7A2719;
        Fri, 15 Sep 2023 05:23:05 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1FC2C433C7;
        Fri, 15 Sep 2023 12:23:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694780585;
        bh=7nmSY2IBO2ss+85+/z+2wByeosLu0eXMtwkNZQM09ss=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=p6leozD4+6WJH8HejfUeDqXiQl+81buGkvrwdGwPRR/2eaUlpxs3iovia0HTgxuqn
         qogL2tMDf9xip5QbGMDCCjH3JBM4m9cgQaOzN7xnt9n8fHHl6S7kIMhZ45GNB40bwG
         nh4IENPpd7MqQNARYY9KMhUgRWNE4O45fwelduK/bLXwGGwuiGX/JeQCX4byDDYnp7
         iwOYwr234NhJPlpXYdk5xXAae8jD+T0vtAd7gSkjDF0zj14OJecx36s16Yi6lxmJFI
         GsAeH+K7y6c6pbqbZ3JLhhT/TX/T/vwlkg/nT+vq4JPdshpdRaogdDIamwUxyBKE/7
         fk2mehr6aaPxA==
From:   Mark Brown <broonie@kernel.org>
Date:   Fri, 15 Sep 2023 13:18:06 +0100
Subject: [PATCH 1/2] arm64/sve: Report FEAT_SVE_B16B16 to userspace
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230915-arm64-zfr-b16b16-el0-v1-1-f9aba807bdb5@kernel.org>
References: <20230915-arm64-zfr-b16b16-el0-v1-0-f9aba807bdb5@kernel.org>
In-Reply-To: <20230915-arm64-zfr-b16b16-el0-v1-0-f9aba807bdb5@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Peter Maydell <peter.maydell@linaro.org>
X-Mailer: b4 0.13-dev-034f2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5300; i=broonie@kernel.org;
 h=from:subject:message-id; bh=7nmSY2IBO2ss+85+/z+2wByeosLu0eXMtwkNZQM09ss=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlBEygWMcXV4DNLSaftWR/S4JRxQTKbVgCSn9WZsVz
 a6ETsOeJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZQRMoAAKCRAk1otyXVSH0J9cB/
 sHvglsvgrJQokpYHMFgMYlr1icMl7BHlfaRNePktkZdwJAoOahZ5QctMbGhu3l1OZFIxo4tZ80sPUg
 HfvR0de7+TJ1MtoRjcs2V8/wRDyR5Lmy7WdYhh1JbHSWOHuFhTRCbzYbiteYAAooOZGhPPzFJyKmYf
 ynkMNHiD9PNh6dTEF4l+OyKbaRDappWrjGcJ7BUifmOhTlECYqGJlG3d3Mb2qGVTXfypomyE0Ow8nF
 /JWdg49ipewW0zTdsunmQhd54eiysjExN7fdkBwX4iNBTEG8KYyxbCwhhFeUNMVair7ObYvyy8vrCB
 CsNtVbTox5xbvjP/Khxez7fHIvurku
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

SVE 2.1 introduced a new feature FEAT_SVE_B16B16 which adds instructions
supporting the BFloat16 floating point format. Report this to userspace
through the ID registers and hwcap.

Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/arch/arm64/cpu-feature-registers.rst | 2 ++
 Documentation/arch/arm64/elf_hwcaps.rst            | 3 +++
 arch/arm64/include/asm/hwcap.h                     | 1 +
 arch/arm64/include/uapi/asm/hwcap.h                | 1 +
 arch/arm64/kernel/cpufeature.c                     | 3 +++
 arch/arm64/kernel/cpuinfo.c                        | 1 +
 arch/arm64/tools/sysreg                            | 6 +++++-
 7 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/Documentation/arch/arm64/cpu-feature-registers.rst b/Documentation/arch/arm64/cpu-feature-registers.rst
index 4e4625f2455f..0c9edc3adb7b 100644
--- a/Documentation/arch/arm64/cpu-feature-registers.rst
+++ b/Documentation/arch/arm64/cpu-feature-registers.rst
@@ -266,6 +266,8 @@ infrastructure:
      +------------------------------+---------+---------+
      | SHA3                         | [35-32] |    y    |
      +------------------------------+---------+---------+
+     | B16B16                       | [27-24] |    y    |
+     +------------------------------+---------+---------+
      | BF16                         | [23-20] |    y    |
      +------------------------------+---------+---------+
      | BitPerm                      | [19-16] |    y    |
diff --git a/Documentation/arch/arm64/elf_hwcaps.rst b/Documentation/arch/arm64/elf_hwcaps.rst
index 8c8addb4194c..077b9552ef38 100644
--- a/Documentation/arch/arm64/elf_hwcaps.rst
+++ b/Documentation/arch/arm64/elf_hwcaps.rst
@@ -305,6 +305,9 @@ HWCAP2_SMEF16F16
 HWCAP2_MOPS
     Functionality implied by ID_AA64ISAR2_EL1.MOPS == 0b0001.
 
+HWCAP2_SVE_B16B16
+    Functionality implied by ID_AA64ZFR0_EL1.B16B16 == 0b0001.
+
 4. Unused AT_HWCAP bits
 -----------------------
 
diff --git a/arch/arm64/include/asm/hwcap.h b/arch/arm64/include/asm/hwcap.h
index 521267478d18..210a41f8b10a 100644
--- a/arch/arm64/include/asm/hwcap.h
+++ b/arch/arm64/include/asm/hwcap.h
@@ -139,6 +139,7 @@
 #define KERNEL_HWCAP_SME_F16F16		__khwcap2_feature(SME_F16F16)
 #define KERNEL_HWCAP_MOPS		__khwcap2_feature(MOPS)
 #define KERNEL_HWCAP_HBC		__khwcap2_feature(HBC)
+#define KERNEL_HWCAP_SVE_B16B16		__khwcap2_feature(SVE_B16B16)
 
 /*
  * This yields a mask that user programs can use to figure out what
diff --git a/arch/arm64/include/uapi/asm/hwcap.h b/arch/arm64/include/uapi/asm/hwcap.h
index 53026f45a509..6faf549077c5 100644
--- a/arch/arm64/include/uapi/asm/hwcap.h
+++ b/arch/arm64/include/uapi/asm/hwcap.h
@@ -104,5 +104,6 @@
 #define HWCAP2_SME_F16F16	(1UL << 42)
 #define HWCAP2_MOPS		(1UL << 43)
 #define HWCAP2_HBC		(1UL << 44)
+#define HWCAP2_SVE_B16B16	(1UL << 45)
 
 #endif /* _UAPI__ASM_HWCAP_H */
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index b018ae12ff5f..a8d373c0e476 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -277,6 +277,8 @@ static const struct arm64_ftr_bits ftr_id_aa64zfr0[] = {
 		       FTR_STRICT, FTR_LOWER_SAFE, ID_AA64ZFR0_EL1_SM4_SHIFT, 4, 0),
 	ARM64_FTR_BITS(FTR_VISIBLE_IF_IS_ENABLED(CONFIG_ARM64_SVE),
 		       FTR_STRICT, FTR_LOWER_SAFE, ID_AA64ZFR0_EL1_SHA3_SHIFT, 4, 0),
+	ARM64_FTR_BITS(FTR_VISIBLE_IF_IS_ENABLED(CONFIG_ARM64_SVE),
+		       FTR_STRICT, FTR_LOWER_SAFE, ID_AA64ZFR0_EL1_B16B16_SHIFT, 4, 0),
 	ARM64_FTR_BITS(FTR_VISIBLE_IF_IS_ENABLED(CONFIG_ARM64_SVE),
 		       FTR_STRICT, FTR_LOWER_SAFE, ID_AA64ZFR0_EL1_BF16_SHIFT, 4, 0),
 	ARM64_FTR_BITS(FTR_VISIBLE_IF_IS_ENABLED(CONFIG_ARM64_SVE),
@@ -2820,6 +2822,7 @@ static const struct arm64_cpu_capabilities arm64_elf_hwcaps[] = {
 	HWCAP_CAP(ID_AA64ZFR0_EL1, AES, IMP, CAP_HWCAP, KERNEL_HWCAP_SVEAES),
 	HWCAP_CAP(ID_AA64ZFR0_EL1, AES, PMULL128, CAP_HWCAP, KERNEL_HWCAP_SVEPMULL),
 	HWCAP_CAP(ID_AA64ZFR0_EL1, BitPerm, IMP, CAP_HWCAP, KERNEL_HWCAP_SVEBITPERM),
+	HWCAP_CAP(ID_AA64ZFR0_EL1, B16B16, IMP, CAP_HWCAP, KERNEL_HWCAP_SVE_B16B16),
 	HWCAP_CAP(ID_AA64ZFR0_EL1, BF16, IMP, CAP_HWCAP, KERNEL_HWCAP_SVEBF16),
 	HWCAP_CAP(ID_AA64ZFR0_EL1, BF16, EBF16, CAP_HWCAP, KERNEL_HWCAP_SVE_EBF16),
 	HWCAP_CAP(ID_AA64ZFR0_EL1, SHA3, IMP, CAP_HWCAP, KERNEL_HWCAP_SVESHA3),
diff --git a/arch/arm64/kernel/cpuinfo.c b/arch/arm64/kernel/cpuinfo.c
index 98fda8500535..ea2a31988103 100644
--- a/arch/arm64/kernel/cpuinfo.c
+++ b/arch/arm64/kernel/cpuinfo.c
@@ -127,6 +127,7 @@ static const char *const hwcap_str[] = {
 	[KERNEL_HWCAP_SME_F16F16]	= "smef16f16",
 	[KERNEL_HWCAP_MOPS]		= "mops",
 	[KERNEL_HWCAP_HBC]		= "hbc",
+	[KERNEL_HWCAP_SVE_B16B16]	= "sveb16b16",
 };
 
 #ifdef CONFIG_COMPAT
diff --git a/arch/arm64/tools/sysreg b/arch/arm64/tools/sysreg
index 2517ef7c21cf..90bb04603811 100644
--- a/arch/arm64/tools/sysreg
+++ b/arch/arm64/tools/sysreg
@@ -1026,7 +1026,11 @@ UnsignedEnum	35:32	SHA3
 	0b0000	NI
 	0b0001	IMP
 EndEnum
-Res0	31:24
+Res0	31:28
+UnsignedEnum	27:24	B16B16
+	0b0000	NI
+	0b0001	IMP
+EndEnum
 UnsignedEnum	23:20	BF16
 	0b0000	NI
 	0b0001	IMP

-- 
2.30.2

