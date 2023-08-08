Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46E9A773CE4
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Aug 2023 18:11:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231229AbjHHQLg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Aug 2023 12:11:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231979AbjHHQJf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Aug 2023 12:09:35 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C876D3A91
        for <linux-kselftest@vger.kernel.org>; Tue,  8 Aug 2023 08:46:28 -0700 (PDT)
Received: from kwepemi500024.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4RKjdq4NFmz1KCKK;
        Tue,  8 Aug 2023 14:17:19 +0800 (CST)
Received: from huawei.com (10.175.103.91) by kwepemi500024.china.huawei.com
 (7.221.188.100) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 8 Aug
 2023 14:18:28 +0800
From:   Zeng Heng <zengheng4@huawei.com>
To:     <kristina.martsenko@arm.com>, <shuah@kernel.org>,
        <catalin.marinas@arm.com>, <broonie@kernel.org>, <will@kernel.org>
CC:     <zengheng4@huawei.com>, <linux-kselftest@vger.kernel.org>,
        <xiexiuqi@huawei.com>, <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 3/5] kselftest/arm64: add DEF_SIGHANDLER_FUNC() and DEF_INST_RAISE_SIG() helpers
Date:   Tue, 8 Aug 2023 14:13:53 +0800
Message-ID: <20230808061356.2215158-3-zengheng4@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230808061356.2215158-1-zengheng4@huawei.com>
References: <20230808061356.2215158-1-zengheng4@huawei.com>
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

Add macro definition functions DEF_SIGHANDLER_FUNC() and
DEF_INST_RAISE_SIG() helpers.

Furthermore, there is no need to modify the default SIGILL handling
function throughout the entire testing lifecycle in the main() function.
It is reasonable to narrow the scope to the context of the sig_fn
function only.

This is a pre-patch for the subsequent SIGBUS handler patch.

Signed-off-by: Zeng Heng <zengheng4@huawei.com>
---
 tools/testing/selftests/arm64/abi/hwcap.c | 118 ++++++++++++++--------
 1 file changed, 75 insertions(+), 43 deletions(-)

diff --git a/tools/testing/selftests/arm64/abi/hwcap.c b/tools/testing/selftests/arm64/abi/hwcap.c
index 7ea526e7934e..eebadb2bc9bf 100644
--- a/tools/testing/selftests/arm64/abi/hwcap.c
+++ b/tools/testing/selftests/arm64/abi/hwcap.c
@@ -440,18 +440,21 @@ static const struct hwcap_data {
 	},
 };
 
-static bool seen_sigill;
-
-static void handle_sigill(int sig, siginfo_t *info, void *context)
-{
-	ucontext_t *uc = context;
-
-	seen_sigill = true;
-
-	/* Skip over the offending instruction */
-	uc->uc_mcontext.pc += 4;
+typedef void (*sighandler_fn)(int, siginfo_t *, void *);
+
+#define DEF_SIGHANDLER_FUNC(SIG, NUM)					\
+static bool seen_##SIG;							\
+static void handle_##SIG(int sig, siginfo_t *info, void *context)	\
+{									\
+	ucontext_t *uc = context;					\
+									\
+	seen_##SIG = true;						\
+	/* Skip over the offending instruction */			\
+	uc->uc_mcontext.pc += 4;					\
 }
 
+DEF_SIGHANDLER_FUNC(sigill, SIGILL);
+
 bool cpuinfo_present(const char *name)
 {
 	FILE *f;
@@ -494,25 +497,77 @@ bool cpuinfo_present(const char *name)
 	return false;
 }
 
-int main(void)
+static int install_sigaction(int signum, sighandler_fn handler)
 {
-	const struct hwcap_data *hwcap;
-	int i, ret;
-	bool have_cpuinfo, have_hwcap;
+	int ret;
 	struct sigaction sa;
 
-	ksft_print_header();
-	ksft_set_plan(ARRAY_SIZE(hwcaps) * TESTS_PER_HWCAP);
-
 	memset(&sa, 0, sizeof(sa));
-	sa.sa_sigaction = handle_sigill;
+	sa.sa_sigaction = handler;
 	sa.sa_flags = SA_RESTART | SA_SIGINFO;
 	sigemptyset(&sa.sa_mask);
-	ret = sigaction(SIGILL, &sa, NULL);
+	ret = sigaction(signum, &sa, NULL);
 	if (ret < 0)
 		ksft_exit_fail_msg("Failed to install SIGILL handler: %s (%d)\n",
 				   strerror(errno), errno);
 
+	return ret;
+}
+
+static void uninstall_sigaction(int signum)
+{
+	if (sigaction(signum, NULL, NULL) < 0)
+		ksft_exit_fail_msg("Failed to uninstall SIGILL handler: %s (%d)\n",
+				   strerror(errno), errno);
+}
+
+#define DEF_INST_RAISE_SIG(SIG, NUM)					\
+static bool inst_raise_##SIG(const struct hwcap_data *hwcap,		\
+				bool have_hwcap)			\
+{									\
+	if (!hwcap->SIG##_fn) {						\
+		ksft_test_result_skip(#SIG"_%s\n", hwcap->name);	\
+		/* assume that it would raise exception in default */	\
+		return true;						\
+	}								\
+									\
+	install_sigaction(NUM, handle_##SIG);				\
+									\
+	seen_##SIG = false;						\
+	hwcap->SIG##_fn();						\
+									\
+	if (have_hwcap) {						\
+		/* Should be able to use the extension */		\
+		ksft_test_result(!seen_##SIG,				\
+				#SIG"_%s\n", hwcap->name);		\
+	} else if (hwcap->SIG##_reliable) {				\
+		/* Guaranteed a SIGNAL */				\
+		ksft_test_result(seen_##SIG,				\
+				#SIG"_%s\n", hwcap->name);		\
+	} else {							\
+		/* Missing SIGNAL might be fine */			\
+		ksft_print_msg(#SIG"_%sreported for %s\n",		\
+				seen_##SIG ? "" : "not ",		\
+				hwcap->name);				\
+		ksft_test_result_skip(#SIG"_%s\n",			\
+					hwcap->name);			\
+	}								\
+									\
+	uninstall_sigaction(NUM);					\
+	return seen_##SIG;						\
+}
+
+DEF_INST_RAISE_SIG(sigill, SIGILL);
+
+int main(void)
+{
+	int i;
+	const struct hwcap_data *hwcap;
+	bool have_cpuinfo, have_hwcap;
+
+	ksft_print_header();
+	ksft_set_plan(ARRAY_SIZE(hwcaps) * TESTS_PER_HWCAP);
+
 	for (i = 0; i < ARRAY_SIZE(hwcaps); i++) {
 		hwcap = &hwcaps[i];
 
@@ -525,30 +580,7 @@ int main(void)
 		ksft_test_result(have_hwcap == have_cpuinfo,
 				 "cpuinfo_match_%s\n", hwcap->name);
 
-		if (hwcap->sigill_fn) {
-			seen_sigill = false;
-			hwcap->sigill_fn();
-
-			if (have_hwcap) {
-				/* Should be able to use the extension */
-				ksft_test_result(!seen_sigill, "sigill_%s\n",
-						 hwcap->name);
-			} else if (hwcap->sigill_reliable) {
-				/* Guaranteed a SIGILL */
-				ksft_test_result(seen_sigill, "sigill_%s\n",
-						 hwcap->name);
-			} else {
-				/* Missing SIGILL might be fine */
-				ksft_print_msg("SIGILL %sreported for %s\n",
-					       seen_sigill ? "" : "not ",
-					       hwcap->name);
-				ksft_test_result_skip("sigill_%s\n",
-						      hwcap->name);
-			}
-		} else {
-			ksft_test_result_skip("sigill_%s\n",
-					      hwcap->name);
-		}
+		inst_raise_sigill(hwcap, have_hwcap);
 	}
 
 	ksft_print_cnts();
-- 
2.25.1

