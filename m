Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66B9366156E
	for <lists+linux-kselftest@lfdr.de>; Sun,  8 Jan 2023 14:11:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235082AbjAHNL0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 8 Jan 2023 08:11:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235087AbjAHNLI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 8 Jan 2023 08:11:08 -0500
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB2C7F5BA;
        Sun,  8 Jan 2023 05:10:59 -0800 (PST)
Received: from localhost.localdomain (unknown [182.253.183.184])
        by gnuweeb.org (Postfix) with ESMTPSA id 51D877E6B3;
        Sun,  8 Jan 2023 13:10:56 +0000 (UTC)
X-GW-Data: lPqxHiMPbJw1wb7CM9QUryAGzr0yq5atzVDdxTR0iA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1673183459;
        bh=HR/stZAKrmeLGzDqyWnPp7zQ1g2rp8o4A70mrDeKDAw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qh7iQnaZ6dK/A66O/KPZUCDFE3aI1s74lIbvLwrNV8CX/kUjKf+/aa330KJJ+Bs0S
         B8IcBKLhSogg8yz5aDjbIB6KyGxwep+pZY/T0K8cAdxZliSc9kAOmrWESTgSPzMpZ/
         TLMLXVe9xuj1/VXQKAmefegnws1GJaYulLt3sKbIyqCc1v1QrWiksZpmfz8tmCKHvD
         QWJViHt+DlKLXHufYR40irB3IZRa8n2SMxzydTHJLeSREl7oUwEFW3z64PqTogNMri
         Etxr/amZKm7nUYI6GonL52Wx0CFkYG1e9tzTP/2F5Qlpd4Bmnr9szvLde7S/Rq8xIw
         ZZLCWzQjMgBrw==
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
Subject: [PATCH v2 4/4] selftests/nolibc: Add `sigaction(2)` selftest
Date:   Sun,  8 Jan 2023 20:10:38 +0700
Message-Id: <20230108131038.841204-5-ammar.faizi@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230108131038.841204-1-ammar.faizi@intel.com>
References: <20221222035134.3467659-1-ammar.faizi@intel.com> <20221222043452.GB29086@1wt.eu> <20221222134615.3535422-1-ammar.faizi@intel.com> <20221227062640.GA5337@1wt.eu> <00eee75f-59fa-83b2-c7e1-f0da347b2dde@gnuweeb.org> <20221227184902.GA6287@1wt.eu> <23e84c59-4f2c-01b4-5b8a-80af39a1d761@gnuweeb.org> <20221228133513.GA7457@1wt.eu> <39d68044-2641-75da-929a-f5e852f0a3d0@gnuweeb.org> <CAOG64qOT6wa+ShCuV3wM0QYy6TBOYap8xoAbUBU5DM_bhdafYg@mail.gmail.com> <20230103035427.GA4474@1wt.eu> <086ff43d-2647-0459-d993-6fc90d7ae779@gnuweeb.org>
 <20230108131038.841204-1-ammar.faizi@intel.com>
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
 tools/testing/selftests/nolibc/nolibc-test.c | 127 +++++++++++++++++++
 1 file changed, 127 insertions(+)

diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index cb6ec9f71aae..946ed0132f93 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -515,6 +515,131 @@ static int test_fork(void)
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
+static int test_signal(void)
+{
+	size_t i;
+	int ret;
+
+	for (i = 0; i < (sizeof(g_sig_to_test) / sizeof(g_sig_to_test[0])); i++) {
+		ret = test_signal_sig(g_sig_to_test[i]);
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
@@ -596,6 +721,8 @@ int run_syscall(int min, int max)
 		CASE_TEST(select_null);       EXPECT_SYSZR(1, ({ struct timeval tv = { 0 }; select(0, NULL, NULL, NULL, &tv); })); break;
 		CASE_TEST(select_stdout);     EXPECT_SYSNE(1, ({ fd_set fds; FD_ZERO(&fds); FD_SET(1, &fds); select(2, NULL, &fds, NULL, NULL); }), -1); break;
 		CASE_TEST(select_fault);      EXPECT_SYSER(1, select(1, (void *)1, NULL, NULL, 0), -1, EFAULT); break;
+		CASE_TEST(sigaction);         EXPECT_SYSZR(1, test_sigaction()); break;
+		CASE_TEST(signal);            EXPECT_SYSZR(1, test_signal()); break;
 		CASE_TEST(stat_blah);         EXPECT_SYSER(1, stat("/proc/self/blah", &stat_buf), -1, ENOENT); break;
 		CASE_TEST(stat_fault);        EXPECT_SYSER(1, stat(NULL, &stat_buf), -1, EFAULT); break;
 		CASE_TEST(symlink_root);      EXPECT_SYSER(1, symlink("/", "/"), -1, EEXIST); break;
-- 
Ammar Faizi

