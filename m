Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBFD6777755
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Aug 2023 13:39:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235413AbjHJLjf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 10 Aug 2023 07:39:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235421AbjHJLjd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 10 Aug 2023 07:39:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83489120;
        Thu, 10 Aug 2023 04:39:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 14CFF65A3A;
        Thu, 10 Aug 2023 11:39:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC500C43391;
        Thu, 10 Aug 2023 11:39:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691667569;
        bh=TWailZRjY0e+eZNG0KbVuBj7vwCo8+irTvS4gJ/TsSo=;
        h=From:Date:Subject:To:Cc:From;
        b=Ycec3jI++B2DemmO0X24rmDGt5uP/+g1lYJa9Hyfi6d7UELoLZXB2Z5ejbmN3GcDv
         EwUHHtrZ1gwmF3reOs3j0i8eihpBloUT0ls1xGLxo7AoC+9i3v2zRTYJBaiE2Aqrna
         SEIhk49XQm6fWl5yW1NHtYQ3SVJwn/+nG8Tz06hHyNJFv+bY7yudAOsGJ8lN/PsBJj
         hNUZVVGhKtExtD13jG4RganXxBb2d5fq568W7HS7B6fjT350Ndae6rFjw7jUDoIQIl
         EBhgGSTQpuxChF7NBVcTrXtGe/7l15wJAuslGWJAD+OPADnJiRzgz+if6YOL6FwM9v
         7ePKJCEaliyqw==
From:   Mark Brown <broonie@kernel.org>
Date:   Thu, 10 Aug 2023 12:39:19 +0100
Subject: [PATCH] kselftest/arm64: Size sycall-abi buffers for the actual
 maximum VL
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230810-arm64-syscall-abi-perf-v1-1-6a0d7656359c@kernel.org>
X-B4-Tracking: v=1; b=H4sIAGbM1GQC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI2MDCwNL3cSiXDMT3eLK4uTEnBzdxKRM3YLUojRdw1RTC3OzFEMzwyQjJaD
 mgqLUtMwKsMHRsbW1AHmPd99oAAAA
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-034f2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4518; i=broonie@kernel.org;
 h=from:subject:message-id; bh=TWailZRjY0e+eZNG0KbVuBj7vwCo8+irTvS4gJ/TsSo=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBk1Mxui0TdliWUY4lyyzPw0Wk8Ox8X4CucUB4Yx3uP
 ksqc6rmJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZNTMbgAKCRAk1otyXVSH0P6AB/
 9Pmv5jV7G7opPlIhRunsboaHBuLcjYK2tKjRx7V2lXPOa6FG/2vE309Uw9blivEmaaSMRnGeT3lQMP
 MvMBa4SWHtxc9gti0FdbitmV28cTVcn093jkUGITx6LjrMDp35HKZj3Nxxvg1ggIPfPijzm/U7m8ze
 bf6eHIzYh2SxWR6J3qz2N/utG3AxuR1j4sxl/FdynAbgXi5kF/dwelXg4PpDP7YHV7Fuwemng2lJSs
 MZ4fir0mayRVS2dfwTD+7MdeV9ISUgqi0WBNOoMdFJjIvppsTioRgi7x8NApwT1hwEoQFVwsfL0l5u
 R8W763tA9dyG9X9tzVbuYCr68YeHHj
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Our ABI opts to provide future proofing by defining a much larger
SVE_VQ_MAX than the architecture actually supports.  Since we use
this define to control the size of our vector data buffers this results
in a lot of overhead when we initialise which can be a very noticable
problem in emulation, we fill buffers that are orders of magnitude
larger than we will ever actually use even with virtual platforms that
provide the full range of architecturally supported vector lengths.

Define and use the actual architecture maximum to mitigate this.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/arm64/abi/syscall-abi.c | 38 +++++++++++++++----------
 1 file changed, 23 insertions(+), 15 deletions(-)

diff --git a/tools/testing/selftests/arm64/abi/syscall-abi.c b/tools/testing/selftests/arm64/abi/syscall-abi.c
index 18cc123e2347..d704511a0955 100644
--- a/tools/testing/selftests/arm64/abi/syscall-abi.c
+++ b/tools/testing/selftests/arm64/abi/syscall-abi.c
@@ -20,12 +20,20 @@
 
 #include "syscall-abi.h"
 
+/*
+ * The kernel defines a much larger SVE_VQ_MAX than is expressable in
+ * the architecture, this creates a *lot* of overhead filling the
+ * buffers (especially ZA) on emulated platforms so use the actual
+ * architectural maximum instead.
+ */
+#define ARCH_SVE_VQ_MAX 16
+
 static int default_sme_vl;
 
 static int sve_vl_count;
-static unsigned int sve_vls[SVE_VQ_MAX];
+static unsigned int sve_vls[ARCH_SVE_VQ_MAX];
 static int sme_vl_count;
-static unsigned int sme_vls[SVE_VQ_MAX];
+static unsigned int sme_vls[ARCH_SVE_VQ_MAX];
 
 extern void do_syscall(int sve_vl, int sme_vl);
 
@@ -130,9 +138,9 @@ static int check_fpr(struct syscall_cfg *cfg, int sve_vl, int sme_vl,
 
 #define SVE_Z_SHARED_BYTES (128 / 8)
 
-static uint8_t z_zero[__SVE_ZREG_SIZE(SVE_VQ_MAX)];
-uint8_t z_in[SVE_NUM_ZREGS * __SVE_ZREG_SIZE(SVE_VQ_MAX)];
-uint8_t z_out[SVE_NUM_ZREGS * __SVE_ZREG_SIZE(SVE_VQ_MAX)];
+static uint8_t z_zero[__SVE_ZREG_SIZE(ARCH_SVE_VQ_MAX)];
+uint8_t z_in[SVE_NUM_ZREGS * __SVE_ZREG_SIZE(ARCH_SVE_VQ_MAX)];
+uint8_t z_out[SVE_NUM_ZREGS * __SVE_ZREG_SIZE(ARCH_SVE_VQ_MAX)];
 
 static void setup_z(struct syscall_cfg *cfg, int sve_vl, int sme_vl,
 		    uint64_t svcr)
@@ -190,8 +198,8 @@ static int check_z(struct syscall_cfg *cfg, int sve_vl, int sme_vl,
 	return errors;
 }
 
-uint8_t p_in[SVE_NUM_PREGS * __SVE_PREG_SIZE(SVE_VQ_MAX)];
-uint8_t p_out[SVE_NUM_PREGS * __SVE_PREG_SIZE(SVE_VQ_MAX)];
+uint8_t p_in[SVE_NUM_PREGS * __SVE_PREG_SIZE(ARCH_SVE_VQ_MAX)];
+uint8_t p_out[SVE_NUM_PREGS * __SVE_PREG_SIZE(ARCH_SVE_VQ_MAX)];
 
 static void setup_p(struct syscall_cfg *cfg, int sve_vl, int sme_vl,
 		    uint64_t svcr)
@@ -222,8 +230,8 @@ static int check_p(struct syscall_cfg *cfg, int sve_vl, int sme_vl,
 	return errors;
 }
 
-uint8_t ffr_in[__SVE_PREG_SIZE(SVE_VQ_MAX)];
-uint8_t ffr_out[__SVE_PREG_SIZE(SVE_VQ_MAX)];
+uint8_t ffr_in[__SVE_PREG_SIZE(ARCH_SVE_VQ_MAX)];
+uint8_t ffr_out[__SVE_PREG_SIZE(ARCH_SVE_VQ_MAX)];
 
 static void setup_ffr(struct syscall_cfg *cfg, int sve_vl, int sme_vl,
 		      uint64_t svcr)
@@ -300,8 +308,8 @@ static int check_svcr(struct syscall_cfg *cfg, int sve_vl, int sme_vl,
 	return errors;
 }
 
-uint8_t za_in[ZA_SIG_REGS_SIZE(SVE_VQ_MAX)];
-uint8_t za_out[ZA_SIG_REGS_SIZE(SVE_VQ_MAX)];
+uint8_t za_in[ZA_SIG_REGS_SIZE(ARCH_SVE_VQ_MAX)];
+uint8_t za_out[ZA_SIG_REGS_SIZE(ARCH_SVE_VQ_MAX)];
 
 static void setup_za(struct syscall_cfg *cfg, int sve_vl, int sme_vl,
 		     uint64_t svcr)
@@ -470,9 +478,9 @@ void sve_count_vls(void)
 		return;
 
 	/*
-	 * Enumerate up to SVE_VQ_MAX vector lengths
+	 * Enumerate up to ARCH_SVE_VQ_MAX vector lengths
 	 */
-	for (vq = SVE_VQ_MAX; vq > 0; vq /= 2) {
+	for (vq = ARCH_SVE_VQ_MAX; vq > 0; vq /= 2) {
 		vl = prctl(PR_SVE_SET_VL, vq * 16);
 		if (vl == -1)
 			ksft_exit_fail_msg("PR_SVE_SET_VL failed: %s (%d)\n",
@@ -496,9 +504,9 @@ void sme_count_vls(void)
 		return;
 
 	/*
-	 * Enumerate up to SVE_VQ_MAX vector lengths
+	 * Enumerate up to ARCH_SVE_VQ_MAX vector lengths
 	 */
-	for (vq = SVE_VQ_MAX; vq > 0; vq /= 2) {
+	for (vq = ARCH_SVE_VQ_MAX; vq > 0; vq /= 2) {
 		vl = prctl(PR_SME_SET_VL, vq * 16);
 		if (vl == -1)
 			ksft_exit_fail_msg("PR_SME_SET_VL failed: %s (%d)\n",

---
base-commit: 52a93d39b17dc7eb98b6aa3edb93943248e03b2f
change-id: 20230809-arm64-syscall-abi-perf-1e5876d161b2

Best regards,
-- 
Mark Brown <broonie@kernel.org>

