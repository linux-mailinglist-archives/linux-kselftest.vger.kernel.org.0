Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 305956615A3
	for <lists+linux-kselftest@lfdr.de>; Sun,  8 Jan 2023 14:59:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233748AbjAHN7s (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 8 Jan 2023 08:59:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236072AbjAHN7j (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 8 Jan 2023 08:59:39 -0500
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE6A3101C0;
        Sun,  8 Jan 2023 05:59:27 -0800 (PST)
Received: from localhost.localdomain (unknown [182.253.183.184])
        by gnuweeb.org (Postfix) with ESMTPSA id A9ECD7E6FB;
        Sun,  8 Jan 2023 13:59:24 +0000 (UTC)
X-GW-Data: lPqxHiMPbJw1wb7CM9QUryAGzr0yq5atzVDdxTR0iA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1673186367;
        bh=mVPQCOGvQrQvEwk4wkn1H2/KyDcjp/35/HH0BBizaVM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WQ2Y0OZccoWJ4VANBonNBnyq71Wgvpfhn5CGvrm6AYqexv+K2s7V7t30BW/xYXusL
         O5DYYQh+Xh/aPVpg0O9yTWmZ1HSqMQNj86TkdE5PUzZlUy0Nx+QOdV20JqHzLGnTD/
         qjrwtAwR+sBLPRhrpOdIB7fQtF8033wdrV42z/HB0zINq9Q4a76ys5qAo3kfrnq6BC
         jOn82WccpkBxq6+dv1FI8APn/QEKawwh0pX68hC7LNrnbseq4WYUWsCPt6Xg3ltyE8
         9cXXxXVBYVZRkJZtamm9xC3GZQUReLXb4UELtiu646JxONbeLUbrEva3zcZVUopShv
         tpgmoEo7eKOVw==
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
Subject: [PATCH v3 5/5] selftests/nolibc: Add `signal(2)` selftest
Date:   Sun,  8 Jan 2023 20:59:04 +0700
Message-Id: <20230108135904.851762-6-ammar.faizi@intel.com>
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

Just like the sigaction() selftest, but for signal().

Signed-off-by: Ammar Faizi <ammarfaizi2@gnuweeb.org>
---
 tools/testing/selftests/nolibc/nolibc-test.c | 54 ++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index c348c92d26f6..946ed0132f93 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -565,6 +565,45 @@ static int test_sigaction_sig(int sig)
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
 static const int g_sig_to_test[] = {
 	SIGINT,
 	SIGHUP,
@@ -587,6 +626,20 @@ static int test_sigaction(void)
 	return 0;
 }
 
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
@@ -669,6 +722,7 @@ int run_syscall(int min, int max)
 		CASE_TEST(select_stdout);     EXPECT_SYSNE(1, ({ fd_set fds; FD_ZERO(&fds); FD_SET(1, &fds); select(2, NULL, &fds, NULL, NULL); }), -1); break;
 		CASE_TEST(select_fault);      EXPECT_SYSER(1, select(1, (void *)1, NULL, NULL, 0), -1, EFAULT); break;
 		CASE_TEST(sigaction);         EXPECT_SYSZR(1, test_sigaction()); break;
+		CASE_TEST(signal);            EXPECT_SYSZR(1, test_signal()); break;
 		CASE_TEST(stat_blah);         EXPECT_SYSER(1, stat("/proc/self/blah", &stat_buf), -1, ENOENT); break;
 		CASE_TEST(stat_fault);        EXPECT_SYSER(1, stat(NULL, &stat_buf), -1, EFAULT); break;
 		CASE_TEST(symlink_root);      EXPECT_SYSER(1, symlink("/", "/"), -1, EEXIST); break;
-- 
Ammar Faizi

