Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B57206615A2
	for <lists+linux-kselftest@lfdr.de>; Sun,  8 Jan 2023 14:59:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233444AbjAHN7q (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 8 Jan 2023 08:59:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235971AbjAHN7c (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 8 Jan 2023 08:59:32 -0500
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72E1810041;
        Sun,  8 Jan 2023 05:59:24 -0800 (PST)
Received: from localhost.localdomain (unknown [182.253.183.184])
        by gnuweeb.org (Postfix) with ESMTPSA id 61A7E7E6F8;
        Sun,  8 Jan 2023 13:59:21 +0000 (UTC)
X-GW-Data: lPqxHiMPbJw1wb7CM9QUryAGzr0yq5atzVDdxTR0iA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1673186364;
        bh=yxkyMaZ1H0PrseRu3i+/9FKOB8Exis+80uQ6H0Fm5qg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UfYI0qI/Hv6/rzfnBOPQbObnn0svGsHTjPGSXcL2MIGo8vz0dFd1mvQHTjLQY/ern
         v0Mmua/RMr9WNJPy8f284BKO8bNbHXgbXB7TWqzAWJP02aBOel5qagXaYONwJi1YiN
         uqfFj4PN2Qm9tP4NbzCdI5rPQafvO90gJHDBECn2qBmVlBYHNaD5WwcKiJCxCZmQsh
         F1ei5RX26v09CwUVHuP1+/UiHLC6MN0zct5PJ7fhz4v7wYZOy+hnLVOxcOlnjQeM9h
         nS5zyVw7sj5l/Q9IK/3s+pXj98y4viMXTes7Zjfimw7UxFX6p0Wp8BaceDPmkZH6Ys
         OBVfhCJxpVwzA==
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
To:     Willy Tarreau <w@1wt.eu>
Cc:     Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        Shuah Khan <shuah@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Gilang Fachrezy <gilang4321@gmail.com>,
        Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kselftest Mailing List 
        <linux-kselftest@vger.kernel.org>
Subject: [PATCH v3 4/5] selftests/nolibc: Add `sigaction(2)` selftest
Date:   Sun,  8 Jan 2023 20:59:03 +0700
Message-Id: <20230108135904.851762-5-ammar.faizi@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230108135904.851762-1-ammar.faizi@intel.com>
References: <20230108135904.851762-1-ammar.faizi@intel.com>
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

Signed-off-by: Ammar Faizi <ammarfaizi2@gnuweeb.org>
---
 tools/testing/selftests/nolibc/nolibc-test.c | 73 ++++++++++++++++++++
 1 file changed, 73 insertions(+)

diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index cb6ec9f71aae..c348c92d26f6 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -515,6 +515,78 @@ static int test_fork(void)
 	return 0;
 }
 
+static volatile int g_test_sig;
+
+static void test_signal_handler(int sig)
+{
+	g_test_sig = sig;
+}
+
+static int test_sigaction_sig(int sig)
+{
+	const struct sigaction new = {
+		.sa_handler = test_signal_handler
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
+	 * test_signal_handler() must set @g_test_sig to @sig.
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
+static const int g_sig_to_test[] = {
+	SIGINT,
+	SIGHUP,
+	SIGTERM,
+	SIGQUIT,
+	SIGSEGV
+};
+
+static int test_sigaction(void)
+{
+	size_t i;
+	int ret;
+
+	for (i = 0; i < (sizeof(g_sig_to_test) / sizeof(g_sig_to_test[0])); i++) {
+		ret = test_sigaction_sig(g_sig_to_test[i]);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
 /* Run syscall tests between IDs <min> and <max>.
  * Return 0 on success, non-zero on failure.
  */
@@ -596,6 +668,7 @@ int run_syscall(int min, int max)
 		CASE_TEST(select_null);       EXPECT_SYSZR(1, ({ struct timeval tv = { 0 }; select(0, NULL, NULL, NULL, &tv); })); break;
 		CASE_TEST(select_stdout);     EXPECT_SYSNE(1, ({ fd_set fds; FD_ZERO(&fds); FD_SET(1, &fds); select(2, NULL, &fds, NULL, NULL); }), -1); break;
 		CASE_TEST(select_fault);      EXPECT_SYSER(1, select(1, (void *)1, NULL, NULL, 0), -1, EFAULT); break;
+		CASE_TEST(sigaction);         EXPECT_SYSZR(1, test_sigaction()); break;
 		CASE_TEST(stat_blah);         EXPECT_SYSER(1, stat("/proc/self/blah", &stat_buf), -1, ENOENT); break;
 		CASE_TEST(stat_fault);        EXPECT_SYSER(1, stat(NULL, &stat_buf), -1, EFAULT); break;
 		CASE_TEST(symlink_root);      EXPECT_SYSER(1, symlink("/", "/"), -1, EEXIST); break;
-- 
Ammar Faizi

