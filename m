Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CA5057BF5E
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Jul 2022 22:53:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbiGTUxe (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 20 Jul 2022 16:53:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiGTUxd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 20 Jul 2022 16:53:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 004E250720
        for <linux-kselftest@vger.kernel.org>; Wed, 20 Jul 2022 13:53:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8E37B61CD8
        for <linux-kselftest@vger.kernel.org>; Wed, 20 Jul 2022 20:53:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C67DC341CB;
        Wed, 20 Jul 2022 20:53:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658350412;
        bh=xI9/ziBwA/RxA1BzIzLCj2TiKjYRcBC95soNIqe1ahk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LpVFWjao4Li5OK/N7UOq2B//R9oU/wnN8zSqNnp2Hdqj/X1FgQknDukq3VMsFDauy
         Qnm1uq6tUw58uHusnVKph6efC4YVfmKH3p3/e23pKDUhhCPzPqReU45Im2/gCQI+t0
         V8g03SUzFzc8y7ChLZWVmQ3bABrzoVVAe6FUFBCkXLelmh5vK0BwuieSiCgiD4RzmN
         CVhAwL0MB96unnGL6yDxH7Rw/NGE1bXUC2MDpglk9nL8MaNZ34FebH1wQ+eHnCcPxB
         H/jMqpoCPFHHEOfR3CebzeqoPvirD+bn0PTbmgmmt9Ou6F6Qx5MojluCYPko3R2sfD
         KanbiZvwod8Hw==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc:     Marc Zyngier <maz@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Zhang Lei <zhang.lei@jp.fujitsu.com>,
        linux-kselftest@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH v1 3/3] kselftest/arm64: Enforce actual ABI for SVE syscalls
Date:   Wed, 20 Jul 2022 21:50:13 +0100
Message-Id: <20220720205013.890942-4-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220720205013.890942-1-broonie@kernel.org>
References: <20220720205013.890942-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3807; h=from:subject; bh=xI9/ziBwA/RxA1BzIzLCj2TiKjYRcBC95soNIqe1ahk=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBi2GqE9yoz9T+w5w8Op1zqjlELGHagINF6z1B7kxU/ cQ5PpLKJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYthqhAAKCRAk1otyXVSH0PUpB/ 9M8wVPKL8aDFzwi+rV1IoIYGDWImCax9JeFQTmPCJUpLGS+TO1FfKNy5JqkfjLp+wf1u6EnmzmuyGj qKeJAPt5uQYz49odpkxGqMbNDRRWq8VA3mAwwRbBN7ElDszHcWN1oIpTPqXEU4ziFuHpowN1jer80s PVmLIkhxzavmG4499PyMP/CM+bDZ8P3g5/QUR/9MGKRWygMUAqvtBceP0Y84RnIdgT1Y1LqgkqFxLV Ie2+1SY5ArDcSKN3xvX4MDbniPXxB61tWrjOymrGyKFVNZ7e9U4pohEcK2lqpK6c/9mREgGYy3LPzM NGetX7xvbCwnWtNMvGtVW39yOxghZv
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

