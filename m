Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D7815068C5
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Apr 2022 12:29:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350686AbiDSKbB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 19 Apr 2022 06:31:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242200AbiDSKbA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 19 Apr 2022 06:31:00 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A936E2AC65
        for <linux-kselftest@vger.kernel.org>; Tue, 19 Apr 2022 03:28:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6AF4BB81651
        for <linux-kselftest@vger.kernel.org>; Tue, 19 Apr 2022 10:28:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74567C385A9;
        Tue, 19 Apr 2022 10:28:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650364096;
        bh=xDJBAJu/5veMEVeVdUV21/gXIWmfA4m9JztlrzCV77E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W3Mj9yuM2Vr2L1pf6j7NLQVSPQ0ieOu2Rc9pbSHZbBxvlUXEfCG5LApc/jN4rdsF7
         hPFlOIY/EpYCOwSuPiegVbak8OdGrbgdozGvSClv6PXsUdlDRwp/WRh5E6zhuKwBgs
         ptx/kWsmVprwtWb6RfI13i5PZov/QsgkEEwEvW+tBsAFziG4cTV4lU5M12HhV4oW4q
         nmNXrsOGT7lNLrPj8RdW0JSp6bRrQJT21tm5uBZJoUjBwe908br/39Fw2M115PenHF
         U6aX55mPlSzgEOUlBsJg9nCGCjq1MMMm+XSKoLWre+99sdJRsEyA0e1BJ393B5M/ZJ
         Dp9MIltLL9Jyw==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc:     Joey Gouly <joey.gouly@arm.com>,
        inux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Subject: [PATCH v2 1/4] kselftest/arm64: Handle more kselftest result codes in MTE helpers
Date:   Tue, 19 Apr 2022 11:28:05 +0100
Message-Id: <20220419102808.24522-2-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220419102808.24522-1-broonie@kernel.org>
References: <20220419102808.24522-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1496; h=from:subject; bh=xDJBAJu/5veMEVeVdUV21/gXIWmfA4m9JztlrzCV77E=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBiXo6yPQt3fHsS6WLGobnHqIeZInPVzKOE7Uw0KVpH GpocEQKJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYl6OsgAKCRAk1otyXVSH0KNDB/ 49M4qXwbVvJ5u5swAL/9RwFF4G7MQ32EnNOcRCLkAO+26a302ndC05Mlq1vN7LAsw9Vh+uJ3q4lLFg H0G5+pFWw5Ibxp0QXqfPv8wSkPxTqopMi0Grr6WCA9U6eQncdABjAb8wjJ+7CAy9WqmO150AfrcoN2 SjA/xNbKhiF0KbsR73GsR8ukUpde3WGav39/YVy3zW7XZ7/Vpb/rViMswLpZxke2/yzdfn2qiEY4f+ +mwwiAYu5OofHMLjhuI2YEx6gR54+FZo6wo5Va7sSKK8qeucJ/Vc3fssWJTM6S1BKOP0aGCUnthi2F XlpnPfVPe0Boctsx51Ultsy9LaCYCf
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The MTE selftests have a helper evaluate_test() which translates a return
code into a call to ksft_test_result_*(). Currently this only handles pass
and fail, silently ignoring any other code. Update the helper to support
skipped tests and log any unknown return codes as an error so we get at
least some diagnostic if anything goes wrong.

Signed-off-by: Mark Brown <broonie@kernel.org>
Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>
---
 .../testing/selftests/arm64/mte/mte_common_util.h | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/arm64/mte/mte_common_util.h b/tools/testing/selftests/arm64/mte/mte_common_util.h
index 195a7d1879e6..2d3e71724e55 100644
--- a/tools/testing/selftests/arm64/mte/mte_common_util.h
+++ b/tools/testing/selftests/arm64/mte/mte_common_util.h
@@ -75,10 +75,21 @@ unsigned int mte_get_pstate_tco(void);
 /* Test framework static inline functions/macros */
 static inline void evaluate_test(int err, const char *msg)
 {
-	if (err == KSFT_PASS)
+	switch (err) {
+	case KSFT_PASS:
 		ksft_test_result_pass(msg);
-	else if (err == KSFT_FAIL)
+		break;
+	case KSFT_FAIL:
 		ksft_test_result_fail(msg);
+		break;
+	case KSFT_SKIP:
+		ksft_test_result_skip(msg);
+		break;
+	default:
+		ksft_test_result_error("Unknown return code %d from %s",
+				       err, msg);
+		break;
+	}
 }
 
 static inline int check_allocated_memory(void *ptr, size_t size,
-- 
2.30.2

