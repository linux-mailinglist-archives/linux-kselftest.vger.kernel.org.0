Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59F5749CD92
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Jan 2022 16:13:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235709AbiAZPNM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 26 Jan 2022 10:13:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235791AbiAZPNM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 26 Jan 2022 10:13:12 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27410C06161C
        for <linux-kselftest@vger.kernel.org>; Wed, 26 Jan 2022 07:13:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D94F5B81E71
        for <linux-kselftest@vger.kernel.org>; Wed, 26 Jan 2022 15:13:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E9B7C36AE7;
        Wed, 26 Jan 2022 15:13:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643209989;
        bh=9LPfnNjILhCHVOzA/ALZlaZgBfzu64ZFSV1uulmc3Ng=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rgi/d6kBOI52gpRmnESktU1dKyIDT4yMQyZv+CDysuJnKwigOcl5Hnu0F+gjsZ2sC
         +FvvPBUic+twOJ4oFqspW3m2FOK9Vp4maO4sPaAN5aew2ICztl0aNt3zpPKIUtREBx
         Xd5V6Jap6kMt4O1Ei2iJOYGh7AJwSFRy9uLhtjvQnsEW7zbnPeuu42sPWR7iq4qbBM
         1YTfklr3Jhc7FSw9E176lbNAFg7U/xPBrOgojudOE2J3ush5sDh5gMqng9UjKx28H5
         ALCmG0G0U9C27QPkIo+vRaCXjhIXy+XvJSK+qjwjJ+lxCY0pxSIZGAxoh1wAwR1isV
         TGMdfgoOijYDQ==
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
Subject: [PATCH v9 24/40] arm64/sme: Save and restore streaming mode over EFI runtime calls
Date:   Wed, 26 Jan 2022 15:11:04 +0000
Message-Id: <20220126151120.3811248-25-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220126151120.3811248-1-broonie@kernel.org>
References: <20220126151120.3811248-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3623; h=from:subject; bh=9LPfnNjILhCHVOzA/ALZlaZgBfzu64ZFSV1uulmc3Ng=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBh8WSJ+1rMeb1w4VGXA4pCLW80Hj1ML4fkGBbtIMNG NJ0XdkiJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYfFkiQAKCRAk1otyXVSH0GvhCA CA2HQJOmg20/ZgXWPzessQE+AMxQ+RsrIOt4TaHURYEB94KBQNRY+4ZbgTDjo7ZyGwvydCC9KFt8ln BscZneyG2rV/WvrfvV1InDIosV/4DhIrO36eb9pRKqXC5kABQ9pns32FoOi9kJCjmR+ZC2CBcFPvuM f9XL9Tx9chgmgKj82cFUNhn5OLaJfeUXXLguAFSQbnCvjTwxOSqgsKuA0qtsAaoP9kw9tMIk+fxmKW rdZauPCdF4fUxxdUoZmFLnql0fsEc9orpIl2IX2aR/vdA756rSCNdEFiExG/Vsxk0BZGNrfoJG0JoC iwYByeB6oZSkuStc+n3/yEx8uD6mqo
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

When saving and restoring the floating point state over an EFI runtime
call ensure that we handle streaming mode, only handling FFR if we are not
in streaming mode and ensuring that we are in normal mode over the call
into runtime services.

We currently assume that ZA will not be modified by runtime services, the
specification is not yet finalised so this may need updating if that
changes.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/kernel/fpsimd.c | 47 +++++++++++++++++++++++++++++++++-----
 1 file changed, 41 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index e00d3a9e919c..a7077a5d1ed2 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -1059,21 +1059,25 @@ int vec_verify_vq_map(enum vec_type type)
 
 static void __init sve_efi_setup(void)
 {
-	struct vl_info *info = &vl_info[ARM64_VEC_SVE];
+	int max_vl = 0;
+	int i;
 
 	if (!IS_ENABLED(CONFIG_EFI))
 		return;
 
+	for (i = 0; i < ARRAY_SIZE(vl_info); i++)
+		max_vl = max(vl_info[i].max_vl, max_vl);
+
 	/*
 	 * alloc_percpu() warns and prints a backtrace if this goes wrong.
 	 * This is evidence of a crippled system and we are returning void,
 	 * so no attempt is made to handle this situation here.
 	 */
-	if (!sve_vl_valid(info->max_vl))
+	if (!sve_vl_valid(max_vl))
 		goto fail;
 
 	efi_sve_state = __alloc_percpu(
-		SVE_SIG_REGS_SIZE(sve_vq_from_vl(info->max_vl)), SVE_VQ_BYTES);
+		SVE_SIG_REGS_SIZE(sve_vq_from_vl(max_vl)), SVE_VQ_BYTES);
 	if (!efi_sve_state)
 		goto fail;
 
@@ -1848,6 +1852,7 @@ EXPORT_SYMBOL(kernel_neon_end);
 static DEFINE_PER_CPU(struct user_fpsimd_state, efi_fpsimd_state);
 static DEFINE_PER_CPU(bool, efi_fpsimd_state_used);
 static DEFINE_PER_CPU(bool, efi_sve_state_used);
+static DEFINE_PER_CPU(bool, efi_sm_state);
 
 /*
  * EFI runtime services support functions
@@ -1882,12 +1887,28 @@ void __efi_fpsimd_begin(void)
 		 */
 		if (system_supports_sve() && likely(efi_sve_state)) {
 			char *sve_state = this_cpu_ptr(efi_sve_state);
+			bool ffr = true;
+			u64 svcr;
 
 			__this_cpu_write(efi_sve_state_used, true);
 
+			/* If we are in streaming mode don't touch FFR */
+			if (system_supports_sme()) {
+				svcr = read_sysreg_s(SYS_SVCR_EL0);
+
+				ffr = svcr & SYS_SVCR_EL0_SM_MASK;
+
+				__this_cpu_write(efi_sm_state, ffr);
+			}
+
 			sve_save_state(sve_state + sve_ffr_offset(sve_max_vl()),
 				       &this_cpu_ptr(&efi_fpsimd_state)->fpsr,
-				       true);
+				       ffr);
+
+			if (system_supports_sme())
+				sysreg_clear_set_s(SYS_SVCR_EL0,
+						   SYS_SVCR_EL0_SM_MASK, 0);
+
 		} else {
 			fpsimd_save_state(this_cpu_ptr(&efi_fpsimd_state));
 		}
@@ -1910,11 +1931,25 @@ void __efi_fpsimd_end(void)
 		if (system_supports_sve() &&
 		    likely(__this_cpu_read(efi_sve_state_used))) {
 			char const *sve_state = this_cpu_ptr(efi_sve_state);
+			bool ffr = true;
+
+			/*
+			 * Restore streaming mode; EFI calls are
+			 * normal function calls so should not return in
+			 * streaming mode.
+			 */
+			if (system_supports_sme()) {
+				if (__this_cpu_read(efi_sm_state)) {
+					sysreg_clear_set_s(SYS_SVCR_EL0,
+							   0,
+							   SYS_SVCR_EL0_SM_MASK);
+					ffr = false;
+				}
+			}
 
-			sve_set_vq(sve_vq_from_vl(sve_get_vl()) - 1);
 			sve_load_state(sve_state + sve_ffr_offset(sve_max_vl()),
 				       &this_cpu_ptr(&efi_fpsimd_state)->fpsr,
-				       true);
+				       ffr);
 
 			__this_cpu_write(efi_sve_state_used, false);
 		} else {
-- 
2.30.2

