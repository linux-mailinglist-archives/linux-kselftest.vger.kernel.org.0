Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4FDF592FE0
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Aug 2022 15:27:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230390AbiHON0s (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 15 Aug 2022 09:26:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243061AbiHON0q (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 15 Aug 2022 09:26:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98B181F2E5
        for <linux-kselftest@vger.kernel.org>; Mon, 15 Aug 2022 06:26:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3500760DE6
        for <linux-kselftest@vger.kernel.org>; Mon, 15 Aug 2022 13:26:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC9A9C43140;
        Mon, 15 Aug 2022 13:26:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660570004;
        bh=CIPBmVfQzkh057P6zvdPDrIMmBHR91ofrbBRCTsg6JQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uKxNE+ciAX3Iu1ZdHRLd0Th2/FVwLtIGfxRdY70jVw8eAbbwDFZkEtX1sKBwZpW9g
         zT5XZHiJLfHVrlb53bjeOJI8JtwTf+OElEnfcF98VsArM2/9Wv4DFyB/hfEpLwMqEy
         hRJj5uJ4t9pk1Zo1TAa8rpOwj3H9cPbhQSXFmWezT2e5K0ZCkn5UIjcjNuH9MREfOO
         y6lOgz3WBLWy5EiF2zX20OF8HWcan6xiix3jNDt2x1suYND4+Q62s5Oycn9zix0Qwz
         RHyDkGr9w5CsHBmW63Q2eZlhZHF0Q9QYQ1Z2fNr+utJ0j/PlS/VD48mYocJ3/m1cqi
         W1oA778M247dA==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc:     Marc Zyngier <maz@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Zhang Lei <zhang.lei@jp.fujitsu.com>,
        linux-kselftest@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH v2 3/3] kselftest/arm64: Enforce actual ABI for SVE syscalls
Date:   Mon, 15 Aug 2022 14:26:22 +0100
Message-Id: <20220815132622.220118-4-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220815132622.220118-1-broonie@kernel.org>
References: <20220815132622.220118-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3860; i=broonie@kernel.org; h=from:subject; bh=CIPBmVfQzkh057P6zvdPDrIMmBHR91ofrbBRCTsg6JQ=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBi+kl9npEhoEDG2B+XRiPlA45vp9CEmQ5KfPZbT89A 7vNdv/KJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYvpJfQAKCRAk1otyXVSH0LcXB/ 9ajMpNfh3SG97BkOcRiyfpa3IsNudPoMWGUICx9TFKjZsl3oou2tARnwN+nDzef/2/kL0OX+fgjlTh oQ41rLTlWsDBvG+fj9ZuxsEF/ZHZQjJP1hB44N+JB1AtHpC01SdeQvuFgoPjBsMxpN14z9JPquqmDg 4u1AmqTrO+DAxr4XErUI0KCd+Au1moGvkPwUaFMytaiNxXNRl6E++3TV7BX48crPqhXiOVfLVOwsBG hi/hvnfcBuebKHnDUHdjZu5JpriEfZxHXjJLQhXPbbMQG7YRBO1J08jU/MR+eHLTgOJ5DovE+5VruZ ye4uxOn9Fd8seROn+6veVkpTOHeVoE
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

