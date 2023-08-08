Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21AC77746B4
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Aug 2023 20:59:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231956AbjHHS7T (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Aug 2023 14:59:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjHHS7B (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Aug 2023 14:59:01 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDB421775A1
        for <linux-kselftest@vger.kernel.org>; Tue,  8 Aug 2023 10:20:51 -0700 (PDT)
Received: from kwepemi500024.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4RKvTZ15Fmz1hwHK;
        Tue,  8 Aug 2023 21:40:50 +0800 (CST)
Received: from huawei.com (10.175.103.91) by kwepemi500024.china.huawei.com
 (7.221.188.100) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 8 Aug
 2023 21:43:38 +0800
From:   Zeng Heng <zengheng4@huawei.com>
To:     <kristina.martsenko@arm.com>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <broonie@kernel.org>, <shuah@kernel.org>
CC:     <linux-kselftest@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <xiexiuqi@huawei.com>,
        <zengheng4@huawei.com>
Subject: [PATCH v2 4/5] kselftest/arm64: add test item that support to capturing the SIGBUS signal
Date:   Tue, 8 Aug 2023 21:40:35 +0800
Message-ID: <20230808134036.668954-5-zengheng4@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230808134036.668954-1-zengheng4@huawei.com>
References: <20230808134036.668954-1-zengheng4@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemi500024.china.huawei.com (7.221.188.100)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Some enhanced features, such as the LSE2 feature, do not result in
SILLILL if LSE2 is missing and LSE is present, but will generate a
SIGBUS exception when atomic access unaligned.

Therefore, we add test item to test this type of features.

Notice that testing for SIGBUS only makes sense after make sure that
the instruction does not cause a SIGILL signal.

Signed-off-by: Zeng Heng <zengheng4@huawei.com>
---
 tools/testing/selftests/arm64/abi/hwcap.c | 33 ++++++++++++++++-------
 1 file changed, 23 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/arm64/abi/hwcap.c b/tools/testing/selftests/arm64/abi/hwcap.c
index 141e50c16f21..69234a8e8c59 100644
--- a/tools/testing/selftests/arm64/abi/hwcap.c
+++ b/tools/testing/selftests/arm64/abi/hwcap.c
@@ -19,19 +19,20 @@

 #include "../../kselftest.h"

-#define TESTS_PER_HWCAP 2
+#define TESTS_PER_HWCAP 3

 /*
- * Function expected to generate SIGILL when the feature is not
- * supported and return when it is supported. If SIGILL is generated
- * then the handler must be able to skip over the instruction safely.
+ * Function expected to generate exception when the feature is not
+ * supported and return when it is supported. If the specific exception
+ * is generated then the handler must be able to skip over the
+ * instruction safely.
  *
  * Note that it is expected that for many architecture extensions
  * there are no specific traps due to no architecture state being
  * added so we may not fault if running on a kernel which doesn't know
  * to add the hwcap.
  */
-typedef void (*sigill_fn)(void);
+typedef void (*sig_fn)(void);

 static void crc32_sigill(void)
 {
@@ -235,8 +236,10 @@ static const struct hwcap_data {
 	unsigned long at_hwcap;
 	unsigned long hwcap_bit;
 	const char *cpuinfo;
-	sigill_fn sigill_fn;
+	sig_fn sigill_fn;
 	bool sigill_reliable;
+	sig_fn sigbus_fn;
+	bool sigbus_reliable;
 } hwcaps[] = {
 	{
 		.name = "CRC32",
@@ -452,6 +455,7 @@ static void handle_##SIG(int sig, siginfo_t *info, void *context)	\
 }

 DEF_SIGHANDLER_FUNC(sigill, SIGILL);
+DEF_SIGHANDLER_FUNC(sigbus, SIGBUS);

 bool cpuinfo_present(const char *name)
 {
@@ -506,7 +510,7 @@ static int install_sigaction(int signum, sighandler_fn handler)
 	sigemptyset(&sa.sa_mask);
 	ret = sigaction(signum, &sa, NULL);
 	if (ret < 0)
-		ksft_exit_fail_msg("Failed to install SIGILL handler: %s (%d)\n",
+		ksft_exit_fail_msg("Failed to install SIGNAL handler: %s (%d)\n",
 				   strerror(errno), errno);

 	return ret;
@@ -515,7 +519,7 @@ static int install_sigaction(int signum, sighandler_fn handler)
 static void uninstall_sigaction(int signum)
 {
 	if (sigaction(signum, NULL, NULL) < 0)
-		ksft_exit_fail_msg("Failed to uninstall SIGILL handler: %s (%d)\n",
+		ksft_exit_fail_msg("Failed to uninstall SIGNAL handler: %s (%d)\n",
 				   strerror(errno), errno);
 }

@@ -556,12 +560,13 @@ static bool inst_raise_##SIG(const struct hwcap_data *hwcap,		\
 }

 DEF_INST_RAISE_SIG(sigill, SIGILL);
+DEF_INST_RAISE_SIG(sigbus, SIGBUS);

 int main(void)
 {
 	int i;
 	const struct hwcap_data *hwcap;
-	bool have_cpuinfo, have_hwcap;
+	bool have_cpuinfo, have_hwcap, raise_sigill;

 	ksft_print_header();
 	ksft_set_plan(ARRAY_SIZE(hwcaps) * TESTS_PER_HWCAP);
@@ -578,7 +583,15 @@ int main(void)
 		ksft_test_result(have_hwcap == have_cpuinfo,
 				 "cpuinfo_match_%s\n", hwcap->name);

-		inst_raise_sigill(hwcap, have_hwcap);
+		/*
+		 * Testing for SIGBUS only makes sense after make sure
+		 * that the instruction does not cause a SIGILL signal.
+		 */
+		raise_sigill = inst_raise_sigill(hwcap, have_hwcap);
+		if (!raise_sigill)
+			inst_raise_sigbus(hwcap, have_hwcap);
+		else
+			ksft_test_result_skip("sigbus_%s\n", hwcap->name);
 	}

 	ksft_print_cnts();
--
2.25.1

