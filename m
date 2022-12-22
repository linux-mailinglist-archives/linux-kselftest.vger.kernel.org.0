Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9E14653B12
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Dec 2022 04:52:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234953AbiLVDwq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 21 Dec 2022 22:52:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234961AbiLVDwo (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 21 Dec 2022 22:52:44 -0500
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAB8A183BB;
        Wed, 21 Dec 2022 19:52:43 -0800 (PST)
Received: from localhost.localdomain (unknown [182.253.88.132])
        by gnuweeb.org (Postfix) with ESMTPSA id 51EF781A09;
        Thu, 22 Dec 2022 03:52:39 +0000 (UTC)
X-GW-Data: lPqxHiMPbJw1wb7CM9QUryAGzr0yq5atzVDdxTR0iA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1671681163;
        bh=sHkHhBasF8Ss/nuP4oociGJDOz1JciWpxGd76+s8DY0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=H6nFm/1gBfuoB8yKWLxfxG6Kbbby018S+O2bZItLnMcqylkQWTclWqHDUnL30A195
         v5Su7gPABOFItiU1tj6bKiN0ZykO7rVAlx+bpeI2oVmXsRKKJeFD2wTTlc6HWvysjy
         sGqWEa4obA7Y460y3RzvxbJ424FFB6qGrkgKQfKLGEIVrlS/sLN6R/eZy/cEtaqzgF
         vouk9MRZpHdE88cGt++6mgYmDFUYjfYmk3hH/c2ajLVd9WoGEs020Lm57Ppank4O89
         sMYE8gZzN/4btGuacDcaXmTFBvRAfd0Hgylh0OjOqr1ZLIsx9SEXGL7ZjihlxHrlhh
         1UTO71M4jHsIQ==
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
To:     Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        Gilang Fachrezy <gilang4321@gmail.com>,
        VNLX Kernel Department <kernel@vnlx.org>,
        Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>,
        Kanna Scarlet <knscarlet@gnuweeb.org>,
        Muhammad Rizki <kiizuha@gnuweeb.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kselftest Mailing List 
        <linux-kselftest@vger.kernel.org>
Subject: [RFC PATCH v1 6/8] selftests/nolibc: Add `sigaction(2)` selftest
Date:   Thu, 22 Dec 2022 10:51:32 +0700
Message-Id: <20221222035134.3467659-7-ammar.faizi@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221222035134.3467659-1-ammar.faizi@intel.com>
References: <20221222035134.3467659-1-ammar.faizi@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Ammar Faizi <ammarfaizi2@gnuweeb.org>

Test the sigaction() function implementation. Test steps:

 - Set a signal handler.
 - Then send a signal to itself using the kill() syscall.
 - The program has to survive and store the caught signal number in a
   volatile global variable.
 - Validate the volatile global variable value.
 - Restore the original signal handler.

Only the x86-64 arch runs this test. Other architectures skip this test
for now.

Signed-off-by: Ammar Faizi <ammarfaizi2@gnuweeb.org>
---
 tools/testing/selftests/nolibc/nolibc-test.c | 81 ++++++++++++++++++++
 1 file changed, 81 insertions(+)

diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index 309cabbddeec..562766e0f63c 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -486,6 +486,86 @@ static int test_fork(void)
 	return 0;
 }
 
+static volatile int g_test_sig;
+
+static void test_sigaction_signal_handler(int sig)
+{
+	g_test_sig = sig;
+}
+
+static int test_sigaction_sig(int sig)
+{
+	const struct sigaction new = {
+		.sa_handler = test_sigaction_signal_handler
+	};
+	struct sigaction old;
+	int ret;
+
+	/*
+	 * Set the signal handler.
+	 */
+	ret = sigaction(sig, &new, &old);
+	if (ret) {
+		printf("test_sigaction_sig(%d): Failed to set a signal handler\n", sig);
+		return ret;
+	}
+
+	/*
+	 * Test the signal handler.
+	 */
+	g_test_sig = 0;
+	kill(getpid(), sig);
+
+	/*
+	 * test_sigaction_signal_handler() must set @g_test_sig to @sig.
+	 */
+	if (g_test_sig != sig) {
+		printf("test_sigaction_sig(%d): Invalid g_test_sig value (%d != %d)\n", sig, g_test_sig, sig);
+		return -1;
+	}
+
+	/*
+	 * Restore the original signal handler.
+	 */
+	ret = sigaction(sig, &old, NULL);
+	if (ret) {
+		printf("test_sigaction_sig(%d): Failed to restore the signal handler\n", sig);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int test_sigaction(void)
+{
+	static const int sig_to_test[] = {
+		SIGINT,
+		SIGHUP,
+		SIGTERM,
+		SIGQUIT,
+		SIGSEGV
+	};
+	size_t i;
+	int ret;
+
+	for (i = 0; i < (sizeof(sig_to_test) / sizeof(sig_to_test[0])); i++) {
+		ret = test_sigaction_sig(sig_to_test[i]);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int should_test_sigaction(void)
+{
+#if defined(__x86_64__)
+	return 1;
+#else
+	return 0;
+#endif
+}
+
 /* Run syscall tests between IDs <min> and <max>.
  * Return 0 on success, non-zero on failure.
  */
@@ -566,6 +646,7 @@ int run_syscall(int min, int max)
 		CASE_TEST(select_null);       EXPECT_SYSZR(1, ({ struct timeval tv = { 0 }; select(0, NULL, NULL, NULL, &tv); })); break;
 		CASE_TEST(select_stdout);     EXPECT_SYSNE(1, ({ fd_set fds; FD_ZERO(&fds); FD_SET(1, &fds); select(2, NULL, &fds, NULL, NULL); }), -1); break;
 		CASE_TEST(select_fault);      EXPECT_SYSER(1, select(1, (void *)1, NULL, NULL, 0), -1, EFAULT); break;
+		CASE_TEST(sigaction);         EXPECT_SYSZR(should_test_sigaction(), test_sigaction()); break;
 		CASE_TEST(stat_blah);         EXPECT_SYSER(1, stat("/proc/self/blah", &stat_buf), -1, ENOENT); break;
 		CASE_TEST(stat_fault);        EXPECT_SYSER(1, stat(NULL, &stat_buf), -1, EFAULT); break;
 		CASE_TEST(symlink_root);      EXPECT_SYSER(1, symlink("/", "/"), -1, EEXIST); break;
-- 
Ammar Faizi

