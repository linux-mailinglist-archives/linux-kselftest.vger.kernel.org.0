Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E56AB653B14
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Dec 2022 04:52:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230462AbiLVDwx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 21 Dec 2022 22:52:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234973AbiLVDwt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 21 Dec 2022 22:52:49 -0500
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98ECF1FCFA;
        Wed, 21 Dec 2022 19:52:48 -0800 (PST)
Received: from localhost.localdomain (unknown [182.253.88.132])
        by gnuweeb.org (Postfix) with ESMTPSA id 2AE9F81A0E;
        Thu, 22 Dec 2022 03:52:43 +0000 (UTC)
X-GW-Data: lPqxHiMPbJw1wb7CM9QUryAGzr0yq5atzVDdxTR0iA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1671681168;
        bh=Pbtd2HHhDQ00BHSBZ/yOcX52AXNgYKhg1gIsAxcbhSk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qONtcf5VH641sO9ylZviZVjfcwZaksNMVTMBM1Pa/MzgIftb/CHu2rGiJT4S+fbYJ
         iddrlIvb+kOp2eEK82N0vGYGrxMHmcZStq8pSYCuG3i1EnZcyTQp1N507HS7CXNky2
         OjMRQc3j0TfeSM3ServnH2owi3WXCdTfZVSi2dm3YAXMHUQk/RfcSupFwi4NAiXMqU
         /1AU8i80aXH58Cu3DufG4OmcIiiIVkkaXrk76Gwbhwnm9BtMCBuzFzTNVsgUiAjcAq
         gjy/0BM0owQXbuI8boSjgGgecyZJfpj60Qg0D9PFjU96dYdZvpTomgijhusEjsHo/B
         zF2Pb3mIClRsQ==
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
Subject: [RFC PATCH v1 7/8] selftests/nolibc: Add `signal(2)` selftest
Date:   Thu, 22 Dec 2022 10:51:33 +0700
Message-Id: <20221222035134.3467659-8-ammar.faizi@intel.com>
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

Just like the sigaction() selftest, but for signal().

Signed-off-by: Ammar Faizi <ammarfaizi2@gnuweeb.org>
---
 tools/testing/selftests/nolibc/nolibc-test.c | 84 +++++++++++++++++---
 1 file changed, 72 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index 562766e0f63c..a65cc6b83779 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -488,7 +488,7 @@ static int test_fork(void)
 
 static volatile int g_test_sig;
 
-static void test_sigaction_signal_handler(int sig)
+static void test_signal_handler(int sig)
 {
 	g_test_sig = sig;
 }
@@ -496,7 +496,7 @@ static void test_sigaction_signal_handler(int sig)
 static int test_sigaction_sig(int sig)
 {
 	const struct sigaction new = {
-		.sa_handler = test_sigaction_signal_handler
+		.sa_handler = test_signal_handler
 	};
 	struct sigaction old;
 	int ret;
@@ -517,7 +517,7 @@ static int test_sigaction_sig(int sig)
 	kill(getpid(), sig);
 
 	/*
-	 * test_sigaction_signal_handler() must set @g_test_sig to @sig.
+	 * test_signal_handler() must set @g_test_sig to @sig.
 	 */
 	if (g_test_sig != sig) {
 		printf("test_sigaction_sig(%d): Invalid g_test_sig value (%d != %d)\n", sig, g_test_sig, sig);
@@ -536,20 +536,74 @@ static int test_sigaction_sig(int sig)
 	return 0;
 }
 
+static int test_signal_sig(int sig)
+{
+	sighandler_t old;
+
+	/*
+	 * Set the signal handler.
+	 */
+	old = signal(sig, test_signal_handler);
+	if (old == SIG_ERR) {
+		printf("test_signal_sig(%d): Failed to set a signal handler\n", sig);
+		return -1;
+	}
+
+	/*
+	 * Test the signal handler.
+	 */
+	g_test_sig = 0;
+	kill(getpid(), sig);
+
+	/*
+	 * test_signal_handler() must set @g_test_sig to @sig.
+	 */
+	if (g_test_sig != sig) {
+		printf("test_signal_sig(%d): Invalid g_test_sig value (%d != %d)\n", sig, g_test_sig, sig);
+		return -1;
+	}
+
+	/*
+	 * Restore the original signal handler.
+	 */
+	old = signal(sig, old);
+	if (old == SIG_ERR) {
+		printf("test_signal_sig(%d): Failed to restore the signal handler\n", sig);
+		return -1;
+	}
+
+	return 0;
+}
+
+static const int g_sig_to_test[] = {
+	SIGINT,
+	SIGHUP,
+	SIGTERM,
+	SIGQUIT,
+	SIGSEGV
+};
+
 static int test_sigaction(void)
 {
-	static const int sig_to_test[] = {
-		SIGINT,
-		SIGHUP,
-		SIGTERM,
-		SIGQUIT,
-		SIGSEGV
-	};
 	size_t i;
 	int ret;
 
-	for (i = 0; i < (sizeof(sig_to_test) / sizeof(sig_to_test[0])); i++) {
-		ret = test_sigaction_sig(sig_to_test[i]);
+	for (i = 0; i < (sizeof(g_sig_to_test) / sizeof(g_sig_to_test[0])); i++) {
+		ret = test_sigaction_sig(g_sig_to_test[i]);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int test_signal(void)
+{
+	size_t i;
+	int ret;
+
+	for (i = 0; i < (sizeof(g_sig_to_test) / sizeof(g_sig_to_test[0])); i++) {
+		ret = test_signal_sig(g_sig_to_test[i]);
 		if (ret)
 			return ret;
 	}
@@ -566,6 +620,11 @@ static int should_test_sigaction(void)
 #endif
 }
 
+static int should_test_signal(void)
+{
+	return should_test_sigaction();
+}
+
 /* Run syscall tests between IDs <min> and <max>.
  * Return 0 on success, non-zero on failure.
  */
@@ -647,6 +706,7 @@ int run_syscall(int min, int max)
 		CASE_TEST(select_stdout);     EXPECT_SYSNE(1, ({ fd_set fds; FD_ZERO(&fds); FD_SET(1, &fds); select(2, NULL, &fds, NULL, NULL); }), -1); break;
 		CASE_TEST(select_fault);      EXPECT_SYSER(1, select(1, (void *)1, NULL, NULL, 0), -1, EFAULT); break;
 		CASE_TEST(sigaction);         EXPECT_SYSZR(should_test_sigaction(), test_sigaction()); break;
+		CASE_TEST(signal);            EXPECT_SYSZR(should_test_signal(), test_signal()); break;
 		CASE_TEST(stat_blah);         EXPECT_SYSER(1, stat("/proc/self/blah", &stat_buf), -1, ENOENT); break;
 		CASE_TEST(stat_fault);        EXPECT_SYSER(1, stat(NULL, &stat_buf), -1, EFAULT); break;
 		CASE_TEST(symlink_root);      EXPECT_SYSER(1, symlink("/", "/"), -1, EEXIST); break;
-- 
Ammar Faizi

