Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FCB143D12C
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Oct 2021 20:52:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243645AbhJ0Syi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 27 Oct 2021 14:54:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:34018 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240514AbhJ0Syh (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 27 Oct 2021 14:54:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id ABE98610A4;
        Wed, 27 Oct 2021 18:52:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635360732;
        bh=w9neO4oaPkEsAc6oQd3BhnMrlpysFuz4AbIXFSLqygM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=E20HGtMW9NwPDwF6yHTL/OZeeXZ/ipLfNno7IelZdvjJF3dbCHRQNKGTG0E0tZQ/r
         YZCDiPu2RebdlVPfrhOj5DhjAihhvXxtmBIGsvE/W4DbG0u0RevYNZZMYKmjB+pMTK
         IXXMn79ySoQUQNx5SbdC5WEFaBfeJWpBc2h1TkaJu8omZ4FnpFz9z0G9Kcj3981J1E
         bedjImE2aDNXL+61mSDHk/TR+sj2Q7zi+viKKXgEcDAWQkhp1Rjd2ZCuw88Kt0JOA+
         unLNHaAclnd5Fkqs14naxlQ9ORWvNJHNiI9jN5ttumUb4QDdqR5gSUMPHHxm2ucfjp
         XvE2I2ogcvRfg==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     Alan Hayward <alan.hayward@arm.com>,
        Luis Machado <luis.machado@arm.com>,
        Salil Akerkar <Salil.Akerkar@arm.com>,
        Basant Kumar Dwivedi <Basant.KumarDwivedi@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH v5 28/38] arm64/sme: Save and restore streaming mode over EFI runtime calls
Date:   Wed, 27 Oct 2021 19:44:14 +0100
Message-Id: <20211027184424.166237-29-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211027184424.166237-1-broonie@kernel.org>
References: <20211027184424.166237-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3623; h=from:subject; bh=w9neO4oaPkEsAc6oQd3BhnMrlpysFuz4AbIXFSLqygM=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBheZ38c3YO9Y4YNpxxycjm7q8Tn4D6AjLpZNbR7kiR 1LTWPVyJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYXmd/AAKCRAk1otyXVSH0AlLB/ 9RxsaXqGiFPnBpXOzT4eF2N65zP7s5fCx/rUvsyZFbLdmIaTLDliAzuHrcjoyP1iteyHD8n7gx4oWI A35lma2hRaADWs04QtZ7QTgdzUbWYvJ+WRcJQjl/uqLlp3YzThawXRrGKMg24o0tcfbKZebh3Q1CDh 9BnT7I1alM4TXrER9Cnhtwl3zcc2FOb2otC+7tHLvFn1t/xrIGguJyL46EuKW169DUXeUwMhQZMaR7 nvy9+ute34ekbMNRUG2yTWLT5r8rubMu48rieXKfNFTYKH6Byy7s5h6DemQXDpJiU+GiOKw9BhN37H W7/ZOSxxQCt8gQHTUZ4zfkLVd2HZkM
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
index ebaf174bdf82..3551ed97e0f3 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -1046,21 +1046,25 @@ int vec_verify_vq_map(enum vec_type type)
 
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
 
@@ -1841,6 +1845,7 @@ EXPORT_SYMBOL(kernel_neon_end);
 static DEFINE_PER_CPU(struct user_fpsimd_state, efi_fpsimd_state);
 static DEFINE_PER_CPU(bool, efi_fpsimd_state_used);
 static DEFINE_PER_CPU(bool, efi_sve_state_used);
+static DEFINE_PER_CPU(bool, efi_sm_state);
 
 /*
  * EFI runtime services support functions
@@ -1875,12 +1880,28 @@ void __efi_fpsimd_begin(void)
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
@@ -1903,11 +1924,25 @@ void __efi_fpsimd_end(void)
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

