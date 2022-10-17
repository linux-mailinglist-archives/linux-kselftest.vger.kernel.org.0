Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0651E6012BA
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Oct 2022 17:26:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbiJQP0x (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 17 Oct 2022 11:26:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230171AbiJQP0w (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 17 Oct 2022 11:26:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D52876048F
        for <linux-kselftest@vger.kernel.org>; Mon, 17 Oct 2022 08:26:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6FFDB61196
        for <linux-kselftest@vger.kernel.org>; Mon, 17 Oct 2022 15:26:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D430C4347C;
        Mon, 17 Oct 2022 15:26:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666020410;
        bh=Tjv7ZeQYxBe/fAaH0j7yWZHO73Wm1EozZK4lzOQMXao=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M7l+mr5Vxap2C+2cM6q1u/6+IhyV+bvGsRsTHMIWKHEFJ3dSEH+UwWB++Xnh86s+n
         l5OhCF+M6GXi6U6KAuVwkbll6n2VkLLozIGuKyKnbxG3Xxn3APXZe+LkJRNsFUUIPe
         kWqK8/InehMh2cbfLnzpiNaTkCL6v14DU1zmaIPPSYer+xLxFaKiafsYqoO4/pn+gI
         6KQm2SwM+jw980yGzUY5Gs33qE9obwHWsRlfIrKHR9Tb7cQRu1XYF73hGwIYbSsxj5
         WnIWBhX3tPIZtF/gCGn+LO1dhVF5yniTSrXYiLxX5+scSShIO6h49r28Dwg6sfpceH
         VFYNXofNpVjaQ==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH v1 5/6] arm64/hwcap: Add support for SVE 2.1
Date:   Mon, 17 Oct 2022 16:25:19 +0100
Message-Id: <20221017152520.1039165-6-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221017152520.1039165-1-broonie@kernel.org>
References: <20221017152520.1039165-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4260; i=broonie@kernel.org; h=from:subject; bh=Tjv7ZeQYxBe/fAaH0j7yWZHO73Wm1EozZK4lzOQMXao=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBjTXPe6wTFaGbqYj0+wKgsXfSXDZxgPM+0RFN5kTNc HjU5tp2JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCY01z3gAKCRAk1otyXVSH0MoGB/ 9kA8MUESkZ+LHM/akdLbCuhlPLRzrYJ5bbiPsvg4s0p6uJ/ei1r2VsIrilldHcL+1vk/Dnokr3wB0h pdfjGyxwayxgUrTagM0ioafuHLfBbrwHbFGLELI8+kXabkORwY5cAhII+irduXJ79cRKWEw6FPKJJO QiBv9xwMHT+FYkvPENJOT/dKYdTmBK2KA5M6k81iCbNpfObyHKWoQjyyMR5zlG4e8OxIgSJfbSS77C 8MkfAbyogWfD08XOsheQ9c6xzjGr7mWLfPxtA3YTSwdP1brmJgWw3qX7j5isNRtRIFvPB0dPb0yRVy 3XPBqkjqn4C6kU+0GZYomtSFAu7lC4
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

FEAT_SVE2p1 introduces a number of new SVE instructions. Since there is no
new architectural state added kernel support is simply a new hwcap which
lets userspace know that the feature is supported.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/arm64/elf_hwcaps.rst  | 3 +++
 Documentation/arm64/sve.rst         | 1 +
 arch/arm64/include/asm/hwcap.h      | 1 +
 arch/arm64/include/uapi/asm/hwcap.h | 1 +
 arch/arm64/kernel/cpufeature.c      | 1 +
 arch/arm64/kernel/cpuinfo.c         | 1 +
 arch/arm64/tools/sysreg             | 1 +
 7 files changed, 9 insertions(+)

diff --git a/Documentation/arm64/elf_hwcaps.rst b/Documentation/arm64/elf_hwcaps.rst
index a82b2cdff680..6fed84f935df 100644
--- a/Documentation/arm64/elf_hwcaps.rst
+++ b/Documentation/arm64/elf_hwcaps.rst
@@ -281,6 +281,9 @@ HWCAP2_CSSC
 HWCAP2_RPRFM
     Functionality implied by ID_AA64ISAR2_EL1.RPRFM == 0b0001.
 
+HWCAP2_SVE2P1
+    Functionality implied by ID_AA64ZFR0_EL1.SVEver == 0b0010.
+
 4. Unused AT_HWCAP bits
 -----------------------
 
diff --git a/Documentation/arm64/sve.rst b/Documentation/arm64/sve.rst
index f338ee2df46d..c7a356bf4e8f 100644
--- a/Documentation/arm64/sve.rst
+++ b/Documentation/arm64/sve.rst
@@ -52,6 +52,7 @@ model features for SVE is included in Appendix A.
 	HWCAP2_SVEBITPERM
 	HWCAP2_SVESHA3
 	HWCAP2_SVESM4
+	HWCAP2_SVE2P1
 
   This list may be extended over time as the SVE architecture evolves.
 
diff --git a/arch/arm64/include/asm/hwcap.h b/arch/arm64/include/asm/hwcap.h
index 605ec55cee70..06dd12c514e6 100644
--- a/arch/arm64/include/asm/hwcap.h
+++ b/arch/arm64/include/asm/hwcap.h
@@ -122,6 +122,7 @@
 #define KERNEL_HWCAP_SVE_EBF16		__khwcap2_feature(SVE_EBF16)
 #define KERNEL_HWCAP_CSSC		__khwcap2_feature(CSSC)
 #define KERNEL_HWCAP_RPRFM		__khwcap2_feature(RPRFM)
+#define KERNEL_HWCAP_SVE2P1		__khwcap2_feature(SVE2P1)
 
 /*
  * This yields a mask that user programs can use to figure out what
diff --git a/arch/arm64/include/uapi/asm/hwcap.h b/arch/arm64/include/uapi/asm/hwcap.h
index 063cc6ea560f..b713d30544f1 100644
--- a/arch/arm64/include/uapi/asm/hwcap.h
+++ b/arch/arm64/include/uapi/asm/hwcap.h
@@ -95,5 +95,6 @@
 #define HWCAP2_SVE_EBF16	(1UL << 33)
 #define HWCAP2_CSSC		(1UL << 34)
 #define HWCAP2_RPRFM		(1UL << 35)
+#define HWCAP2_SVE2P1		(1UL << 36)
 
 #endif /* _UAPI__ASM_HWCAP_H */
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 01bd72ff9617..bb1ef8cf7d04 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -2750,6 +2750,7 @@ static const struct arm64_cpu_capabilities arm64_elf_hwcaps[] = {
 	HWCAP_CAP(SYS_ID_AA64MMFR2_EL1, ID_AA64MMFR2_EL1_AT_SHIFT, 4, FTR_UNSIGNED, 1, CAP_HWCAP, KERNEL_HWCAP_USCAT),
 #ifdef CONFIG_ARM64_SVE
 	HWCAP_CAP(SYS_ID_AA64PFR0_EL1, ID_AA64PFR0_EL1_SVE_SHIFT, 4, FTR_UNSIGNED, ID_AA64PFR0_EL1_SVE_IMP, CAP_HWCAP, KERNEL_HWCAP_SVE),
+	HWCAP_CAP(SYS_ID_AA64ZFR0_EL1, ID_AA64ZFR0_EL1_SVEver_SHIFT, 4, FTR_UNSIGNED, ID_AA64ZFR0_EL1_SVEver_SVE2p1, CAP_HWCAP, KERNEL_HWCAP_SVE2P1),
 	HWCAP_CAP(SYS_ID_AA64ZFR0_EL1, ID_AA64ZFR0_EL1_SVEver_SHIFT, 4, FTR_UNSIGNED, ID_AA64ZFR0_EL1_SVEver_SVE2, CAP_HWCAP, KERNEL_HWCAP_SVE2),
 	HWCAP_CAP(SYS_ID_AA64ZFR0_EL1, ID_AA64ZFR0_EL1_AES_SHIFT, 4, FTR_UNSIGNED, ID_AA64ZFR0_EL1_AES_IMP, CAP_HWCAP, KERNEL_HWCAP_SVEAES),
 	HWCAP_CAP(SYS_ID_AA64ZFR0_EL1, ID_AA64ZFR0_EL1_AES_SHIFT, 4, FTR_UNSIGNED, ID_AA64ZFR0_EL1_AES_PMULL128, CAP_HWCAP, KERNEL_HWCAP_SVEPMULL),
diff --git a/arch/arm64/kernel/cpuinfo.c b/arch/arm64/kernel/cpuinfo.c
index 85108832d86e..379695262b77 100644
--- a/arch/arm64/kernel/cpuinfo.c
+++ b/arch/arm64/kernel/cpuinfo.c
@@ -118,6 +118,7 @@ static const char *const hwcap_str[] = {
 	[KERNEL_HWCAP_SVE_EBF16]	= "sveebf16",
 	[KERNEL_HWCAP_CSSC]		= "cssc",
 	[KERNEL_HWCAP_RPRFM]		= "rprfm",
+	[KERNEL_HWCAP_SVE2P1]		= "sve2p1",
 };
 
 #ifdef CONFIG_COMPAT
diff --git a/arch/arm64/tools/sysreg b/arch/arm64/tools/sysreg
index a2b2e4c1c3f2..b2782b8faa01 100644
--- a/arch/arm64/tools/sysreg
+++ b/arch/arm64/tools/sysreg
@@ -210,6 +210,7 @@ EndEnum
 Enum	3:0	SVEver
 	0b0000	IMP
 	0b0001	SVE2
+	0b0010	SVE2p1
 EndEnum
 EndSysreg
 
-- 
2.30.2

