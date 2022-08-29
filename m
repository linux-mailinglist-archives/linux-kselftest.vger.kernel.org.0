Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DD4B5A51E8
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Aug 2022 18:35:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbiH2Qff (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 29 Aug 2022 12:35:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbiH2Qfe (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 29 Aug 2022 12:35:34 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16E421835A
        for <linux-kselftest@vger.kernel.org>; Mon, 29 Aug 2022 09:35:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BD0A8B81115
        for <linux-kselftest@vger.kernel.org>; Mon, 29 Aug 2022 16:35:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98F26C433D7;
        Mon, 29 Aug 2022 16:35:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661790928;
        bh=CIPBmVfQzkh057P6zvdPDrIMmBHR91ofrbBRCTsg6JQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K21x9x1Xpk2h7QV3UuBjRbmSAzTyid4A11nSpWe7VUPAyBS1sI75gehm0nq0NaGhX
         XHau+hUfcRwCby32PJGAiK779BthPT4biTYJ8Ydfb10vJsnYVJ4IIo1729zIuyhaLH
         nS/Z7XIGf4CbjhwskfDLIece3ersPtMINV2+6dJaYoSo9A2TTIuKLuM8ZXs7W6cTjy
         kJMyttlQdtr87oCjviaVs18ntXypWef4lTeOiE94agu55wxW14Www81nRUJ1ayp7IV
         zhPFX1vqs+o8lYIbx4cSXQdBSJSxLoo2+OorJYovNFYQTb1kooMht+Myt81hv2KuEU
         2UK5GWQMFUdPg==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc:     Marc Zyngier <maz@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Zhang Lei <zhang.lei@jp.fujitsu.com>,
        linux-kselftest@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH v3 3/3] kselftest/arm64: Enforce actual ABI for SVE syscalls
Date:   Mon, 29 Aug 2022 17:25:02 +0100
Message-Id: <20220829162502.886816-4-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220829162502.886816-1-broonie@kernel.org>
References: <20220829162502.886816-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3860; i=broonie@kernel.org; h=from:subject; bh=CIPBmVfQzkh057P6zvdPDrIMmBHR91ofrbBRCTsg6JQ=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBjDOhdnpEhoEDG2B+XRiPlA45vp9CEmQ5KfPZbT89A 7vNdv/KJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYwzoXQAKCRAk1otyXVSH0OUcB/ 92h0A6InK6c2NEtI1HC27AWXr3nj9Zl22xRI57h4ksygZu4rqq+QrKab32Gl0ijHNYrlixfPkzAvai q/Cd0QAmxXuTc4JAG/1I8b5bqtRReDL0bEPeK9IHA2oZ38zT4QrvyFtmbe3Q+pBSP3BK4PDMVj4YO/ lApm3njoUCu3L5tr0w7z+o9+W4lN4lVRrASmUb7eJWp2e7UDJw/lPFeQBUDMCoxhNv3bw9JvI9zWpb L3kUHCNsZrteX/eQ4UwEs+r+Up3F3V8mg1crCueJ/NBDEr9ltIBYlS+glpalpyU7fJLL7PSVnPGXJu JrKXdfg5F0s9Rp1lhvYgNxg5ycXC5X
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

Currently syscall-abi permits the bits in Z registers not shared with the
V registers as well as all of the predicate registers to be preserved on
syscall but the actual implementation has always cleared them and our
documentation has now been updated to make that the documented ABI so
update the syscall-abi test to match.

Signed-off-by: Mark Brown <broonie@kernel.org>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
---
 .../testing/selftests/arm64/abi/syscall-abi.c | 57 ++++++++++++-------
 1 file changed, 38 insertions(+), 19 deletions(-)

diff --git a/tools/testing/selftests/arm64/abi/syscall-abi.c b/tools/testing/selftests/arm64/abi/syscall-abi.c
index 95229fa73232..dd7ebe536d05 100644
--- a/tools/testing/selftests/arm64/abi/syscall-abi.c
+++ b/tools/testing/selftests/arm64/abi/syscall-abi.c
@@ -112,6 +112,8 @@ static int check_fpr(struct syscall_cfg *cfg, int sve_vl, int sme_vl,
 	return errors;
 }
 
+#define SVE_Z_SHARED_BYTES (128 / 8)
+
 static uint8_t z_zero[__SVE_ZREG_SIZE(SVE_VQ_MAX)];
 uint8_t z_in[SVE_NUM_ZREGS * __SVE_ZREG_SIZE(SVE_VQ_MAX)];
 uint8_t z_out[SVE_NUM_ZREGS * __SVE_ZREG_SIZE(SVE_VQ_MAX)];
@@ -133,22 +135,39 @@ static int check_z(struct syscall_cfg *cfg, int sve_vl, int sme_vl,
 	if (!sve_vl)
 		return 0;
 
-	/*
-	 * After a syscall the low 128 bits of the Z registers should
-	 * be preserved and the rest be zeroed or preserved, except if
-	 * we were in streaming mode in which case the low 128 bits may
-	 * also be cleared by the transition out of streaming mode.
-	 */
 	for (i = 0; i < SVE_NUM_ZREGS; i++) {
-		void *in = &z_in[reg_size * i];
-		void *out = &z_out[reg_size * i];
-
-		if ((memcmp(in, out, SVE_VQ_BYTES) != 0) &&
-		    !((svcr & SVCR_SM_MASK) &&
-		      memcmp(z_zero, out, SVE_VQ_BYTES) == 0)) {
-			ksft_print_msg("%s SVE VL %d Z%d low 128 bits changed\n",
-				       cfg->name, sve_vl, i);
-			errors++;
+		uint8_t *in = &z_in[reg_size * i];
+		uint8_t *out = &z_out[reg_size * i];
+
+		if (svcr & SVCR_SM_MASK) {
+			/*
+			 * In streaming mode the whole register should
+			 * be cleared by the transition out of
+			 * streaming mode.
+			 */
+			if (memcmp(z_zero, out, reg_size) != 0) {
+				ksft_print_msg("%s SVE VL %d Z%d non-zero\n",
+					       cfg->name, sve_vl, i);
+				errors++;
+			}
+		} else {
+			/*
+			 * For standard SVE the low 128 bits should be
+			 * preserved and any additional bits cleared.
+			 */
+			if (memcmp(in, out, SVE_Z_SHARED_BYTES) != 0) {
+				ksft_print_msg("%s SVE VL %d Z%d low 128 bits changed\n",
+					       cfg->name, sve_vl, i);
+				errors++;
+			}
+
+			if (reg_size > SVE_Z_SHARED_BYTES &&
+			    (memcmp(z_zero, out + SVE_Z_SHARED_BYTES,
+				    reg_size - SVE_Z_SHARED_BYTES) != 0)) {
+				ksft_print_msg("%s SVE VL %d Z%d high bits non-zero\n",
+					       cfg->name, sve_vl, i);
+				errors++;
+			}
 		}
 	}
 
@@ -176,9 +195,9 @@ static int check_p(struct syscall_cfg *cfg, int sve_vl, int sme_vl,
 	if (!sve_vl)
 		return 0;
 
-	/* After a syscall the P registers should be preserved or zeroed */
+	/* After a syscall the P registers should be zeroed */
 	for (i = 0; i < SVE_NUM_PREGS * reg_size; i++)
-		if (p_out[i] && (p_in[i] != p_out[i]))
+		if (p_out[i])
 			errors++;
 	if (errors)
 		ksft_print_msg("%s SVE VL %d predicate registers non-zero\n",
@@ -226,9 +245,9 @@ static int check_ffr(struct syscall_cfg *cfg, int sve_vl, int sme_vl,
 	    !(getauxval(AT_HWCAP2) & HWCAP2_SME_FA64))
 		return 0;
 
-	/* After a syscall the P registers should be preserved or zeroed */
+	/* After a syscall FFR should be zeroed */
 	for (i = 0; i < reg_size; i++)
-		if (ffr_out[i] && (ffr_in[i] != ffr_out[i]))
+		if (ffr_out[i])
 			errors++;
 	if (errors)
 		ksft_print_msg("%s SVE VL %d FFR non-zero\n",
-- 
2.30.2

