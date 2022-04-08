Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12A3F4F94D6
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Apr 2022 13:56:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235323AbiDHL6x (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 8 Apr 2022 07:58:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235321AbiDHL6v (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 8 Apr 2022 07:58:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79F4681672
        for <linux-kselftest@vger.kernel.org>; Fri,  8 Apr 2022 04:56:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1476F62068
        for <linux-kselftest@vger.kernel.org>; Fri,  8 Apr 2022 11:56:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC2D2C385B5;
        Fri,  8 Apr 2022 11:56:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649419007;
        bh=QiQWOAG6guUlHh1r4QfEv9Nuphr6daVHep+hct28ThE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dtcxkiny24CAXIlxnVu1PEgFR73050E7vHSrj9GnWXh+1BO8xOr+i8WLmf6Qb4pLc
         fdWxTRviN9uesbLGyg/P0zoetLB+/TWMujtnf0+qiudtRa6nLxTpFhxkmFEphs60bD
         dkxNV8F7FekH4eUxrhbDo+s8h9BJ1n2TpXKg9zNQhrAoQb5VzeTv2QJYqnVbf8p2sL
         JMsODMqazr2mWyoyuh6WQgultyPyI3h4kog5F89Q/AcSl9ZHnksY3Gk1cyBELB5QXJ
         GGmdAC/kM6xO2Yii0prCsSbjmUh4oV09ywrldAFmnuZLhmd4zvc6O/clNi4658XNpw
         KCNivSXsZWE5A==
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
        Luca Salabrino <luca.scalabrino@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, kvmarm@lists.cs.columbia.edu,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH v13 23/39] arm64/sme: Save and restore streaming mode over EFI runtime calls
Date:   Fri,  8 Apr 2022 12:43:12 +0100
Message-Id: <20220408114328.1401034-24-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220408114328.1401034-1-broonie@kernel.org>
References: <20220408114328.1401034-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3704; h=from:subject; bh=QiQWOAG6guUlHh1r4QfEv9Nuphr6daVHep+hct28ThE=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBiUB/Rl8cjgYtFjqQelYlyRJi0i9JCk/9yCt2/7nCb zv7bDUiJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYlAf0QAKCRAk1otyXVSH0NLLB/ 9fMYG9bH5XJwoS3zD54pCNRqbtBsGC3qPomGJdFJdqp2WZArH9KMULhep8RvgzP5hSb8slz3eLegoU JxT4jrWL4BC1vOTrrI0rMncuLcRvWhqOvR2aGCKAH8/3t6zGoOgjOJNT1dfjTH/gehsD53ucfs+Yso IP62+xjXmMJnPCdC19nGWSPwk5aqD6ZOuaDoPFM1dD6Qde8Q+ymF+tl8SNyQ3wLNbaoP1t/Od9lSgD S5Jc9hvRCUD/e3YO3ZCVimoIBl9a3hMGZHk1uiNamo1KqjMNrmQ5LM8bJ+DbjWIzX087mGlOihTVcB fn2rev9Bv2nTfboWSiSKKhXCxVH//3
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm64/kernel/fpsimd.c | 48 +++++++++++++++++++++++++++++++++-----
 1 file changed, 42 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index 9592cdd7d635..64431bc62472 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -1056,21 +1056,25 @@ int vec_verify_vq_map(enum vec_type type)
 
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
 
@@ -1845,6 +1849,7 @@ EXPORT_SYMBOL(kernel_neon_end);
 static DEFINE_PER_CPU(struct user_fpsimd_state, efi_fpsimd_state);
 static DEFINE_PER_CPU(bool, efi_fpsimd_state_used);
 static DEFINE_PER_CPU(bool, efi_sve_state_used);
+static DEFINE_PER_CPU(bool, efi_sm_state);
 
 /*
  * EFI runtime services support functions
@@ -1879,12 +1884,28 @@ void __efi_fpsimd_begin(void)
 		 */
 		if (system_supports_sve() && likely(efi_sve_state)) {
 			char *sve_state = this_cpu_ptr(efi_sve_state);
+			bool ffr = true;
+			u64 svcr;
 
 			__this_cpu_write(efi_sve_state_used, true);
 
+			if (system_supports_sme()) {
+				svcr = read_sysreg_s(SYS_SVCR_EL0);
+
+				if (!system_supports_fa64())
+					ffr = svcr & SYS_SVCR_EL0_SM_MASK;
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
@@ -1907,11 +1928,26 @@ void __efi_fpsimd_end(void)
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
+					if (!system_supports_fa64())
+						ffr = efi_sm_state;
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

