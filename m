Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 011D145086D
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Nov 2021 16:31:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232310AbhKOPeW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 15 Nov 2021 10:34:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:52876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236675AbhKOPdi (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 15 Nov 2021 10:33:38 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0EB2663232;
        Mon, 15 Nov 2021 15:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636990210;
        bh=jLrKauMo97jhxOy35VKRzK15Vz0tTJowtBEC7D/upGc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=o56RL78/23OnFSb1rBojKq8j/9Xb/ULvGAd0RqDd6FOiWSi+6HCVpWXtxsrKKnYgw
         O+/oSb1TQ61ZycdMA/wB5+v8lgwb+5Kej7Wx5+dilyp8WZNdb1OagLhUMKZmaRYWs5
         CdE5QNgY+2vt5UIKXTM7kkIYjrRKdbhaXelMxCBcHKP3Vpce6ouI7rZ2r70jrWF/jP
         UEUH8CQlsGLdMJSxQ43FnkmSvhN6FyW4agp/8eAGLGZksRx7yzUR7w28p3uwCDFj6k
         /caQ1rk3co1TZz/VH7XrZJgIY8R2/ZPWSiFuknL1ZpRprr2FMWEgv8l605zOHW4Cse
         Y2jeK/dpuDxTQ==
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
Subject: [PATCH v6 27/37] arm64/sme: Save and restore streaming mode over EFI runtime calls
Date:   Mon, 15 Nov 2021 15:28:25 +0000
Message-Id: <20211115152835.3212149-28-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211115152835.3212149-1-broonie@kernel.org>
References: <20211115152835.3212149-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3623; h=from:subject; bh=jLrKauMo97jhxOy35VKRzK15Vz0tTJowtBEC7D/upGc=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBhknya75M88oFp3XXYCMLvzif+Fo9rFzcyfxpqLgB8 f5GkBE2JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYZJ8mgAKCRAk1otyXVSH0CrjCA CCTyY8MMqo7qUQXkkFCaP3036bBqp0r/M3WKF3BuWSea3flaZipdxCtjWFEovier7SefE+N/nytxCv PPZoz0P5T5y5HRsH4FU1Un3ua8SL4xeYMoMIXTHrVAZLoZBAVXtkE7Aas5mRjM7EXRUC/DchbjZMYl q/3vCgWSEo8XvSUimrp2O1lsf6kxAuBV+n/tM4bitzqlw4bFsne82Zk6Gk34lrGWxu5Ui+QK8VdweH Zw+NEq9Q9eQeZ6U3lBt7I8z5nPv0wIO/gC/DCfA6IUVpQp11HkM2oPJyi5kafKp+DR2MMdzACFNy9L sN4IGpuveiKFHvhoSp7ZtvnAbqHMi7
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
index bb174c1b8ae0..7ad55fa54d03 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -1061,21 +1061,25 @@ int vec_verify_vq_map(enum vec_type type)
 
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
 
@@ -1857,6 +1861,7 @@ EXPORT_SYMBOL(kernel_neon_end);
 static DEFINE_PER_CPU(struct user_fpsimd_state, efi_fpsimd_state);
 static DEFINE_PER_CPU(bool, efi_fpsimd_state_used);
 static DEFINE_PER_CPU(bool, efi_sve_state_used);
+static DEFINE_PER_CPU(bool, efi_sm_state);
 
 /*
  * EFI runtime services support functions
@@ -1891,12 +1896,28 @@ void __efi_fpsimd_begin(void)
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
@@ -1919,11 +1940,25 @@ void __efi_fpsimd_end(void)
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

