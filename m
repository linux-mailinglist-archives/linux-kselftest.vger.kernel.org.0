Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A02D715C92
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 May 2023 13:05:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231534AbjE3LFl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 30 May 2023 07:05:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231794AbjE3LFk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 30 May 2023 07:05:40 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.221.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE56AE5;
        Tue, 30 May 2023 04:05:37 -0700 (PDT)
X-QQ-mid: bizesmtp81t1685444733t0w0xo7y
Received: from linux-lab-host.localdomain ( [119.123.130.226])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 30 May 2023 19:05:31 +0800 (CST)
X-QQ-SSF: 01200000000000D0V000000A0000000
X-QQ-FEAT: qTKqCPEPPMCW9B1ysKllWVaS1wh2y0szvr/5UcMtnZhWY6OZeO5K63HX3I6/W
        atmSrvFCqT6B3PWqAH4eaVk9KM8ij4PXLpSQf/GawIFbw+MFWjENtkYYCm+naDAuhSnhq4o
        +atjjVW3SRGVc0dHTJSWfZkCjNxM95CxppAWnLgiyovSI3Q2XLudaYo7w/UBTy1gAkDjVuH
        FmnLv8kj/vZr2bVMhpwWuT1SvZ9BvFhk0SjKzItfPgeavl68QSlRSlZ6kr5e2b3WIC+1VD3
        4wJ6i6DNRmFbIikucPYfFvJ8S+y5NTMbkGbrrH0vFJWYwDwNgKKXZtTYdpP036OuHTi3Y5e
        E+xAC2HBsqZ+DRTj+RP7AcVM7Do3v5xQzuBIULzGLkcx+0utUD8sFgEwkcye24itOyMdb8z
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 1177987213565950779
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     falcon@tinylab.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org,
        thomas@t-8ch.de
Subject: [PATCH 3/4] selftests/nolibc: add user space efault handler
Date:   Tue, 30 May 2023 19:05:29 +0800
Message-Id: <ba63fb0dd083c679249c41cb7d931437ca3598a8.1685443199.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1685443199.git.falcon@tinylab.org>
References: <cover.1685443199.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrsz:qybglogicsvrsz3a-3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Some hooks are added to record the test case and the test context, while
traps on invalid data pointer access, try to continue next test if
possible.

Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/testing/selftests/nolibc/nolibc-test.c | 151 ++++++++++++++++++-
 1 file changed, 149 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index b8fd7fcf56a6..9f9a09529a4f 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -114,6 +114,149 @@ const char *errorname(int err)
 	}
 }
 
+/* emulate EFAULT return in user space with isigaction/sigsetjmp/siglongjmp */
+#ifndef NOLIBC
+#ifndef NO_USER_SPACE_EFAULT
+#define USER_SPACE_EFAULT
+#endif
+#endif
+
+#ifdef USER_SPACE_EFAULT
+#include <setjmp.h>
+
+static int next_test = 0;
+static int test_llen = 0;
+static int test_sig = 0;
+static int expect_sig = 0;
+static int test_idx = 0;
+static int test_ret = 0;
+static int test_iteration = 0;
+static int test_iterations = 0;
+static sigjmp_buf mark;
+
+static int pad_spc(int llen, int cnt, const char *fmt, ...);
+static struct test test_names[];
+typedef int (*func_t)(int min, int max);
+static func_t test_func = NULL;
+
+#define CASE_SIG(sig) \
+	case sig: return #sig
+
+/* returns the signal name or the decimal value for less common ones. */
+const char *signame(int sig)
+{
+	switch (sig) {
+	CASE_SIG(SIGSEGV);
+	default:
+		return itoa(sig);
+	}
+}
+
+static void record_test_context(int idx, int iteration, int iterations)
+{
+	test_idx = idx;
+	test_iteration = iteration;
+	test_iterations = iterations;
+}
+
+static void record_test_case(int test, int llen, int ret, char *name)
+{
+	test_llen = llen - 1;
+	test_ret = ret;
+	next_test = test + 1;
+}
+
+static void restore_from_trap(void)
+{
+	int idx;
+	int err;
+	int i;
+	int min = 0;
+	int max = INT_MAX;
+
+	test_llen += printf(" ! %d %s ", test_sig, signame(test_sig));
+	if (test_sig == expect_sig)
+		pad_spc(test_llen, 64, "[OK]\n");
+	else {
+		test_ret++;
+		pad_spc(test_llen, 64, "[FAIL]\n");
+	}
+
+	if (next_test <= test_names[test_idx].max) {
+		test_func = test_names[test_idx].func;
+		err = test_func(next_test, test_names[test_idx].max);
+		test_ret += err;
+		printf("Errors during this test: %d\n\n", err);
+	}
+
+	for (i = test_iteration; i < test_iterations; i++) {
+		/* for current iterations */
+		if (i == test_iteration) {
+			idx = test_idx + 1;
+		} else {
+			printf("Current iteration: %d\n\n", i + 1);
+
+			/* for left iterations */
+			idx = 0;
+			test_ret = 0;
+		}
+
+		for (; test_names[idx].name; idx++) {
+			if (test_names[idx].run != 0) {
+				printf("Running test '%s'\n", test_names[idx].name);
+				record_test_context(idx, i, test_iterations);
+				err = test_names[idx].func(test_names[idx].min, test_names[idx].max);
+				test_ret += err;
+				printf("Errors during this test: %d\n\n", err);
+			}
+		}
+		printf("Total number of errors in the %d iteration(s): %d\n\n", i + 1, test_ret);
+	}
+}
+
+static void trap_handler(int sig, siginfo_t *si, void *p)
+{
+	test_sig = sig;
+	if (sig != SIGKILL)
+		siglongjmp(mark, -1);
+}
+
+static void register_expect_trap(int experr1, int experr2)
+{
+	if (experr1 == EFAULT || experr2 == EFAULT)
+		expect_sig = SIGSEGV;
+	else
+		expect_sig = 0;
+}
+
+static void register_trap_handler(void)
+{
+	int ret = 0;
+
+	struct sigaction sa = {0};
+	sa.sa_sigaction = trap_handler;
+	sa.sa_flags = SA_SIGINFO;
+	ret = sigaction(SIGSEGV, &sa, NULL);
+	if (ret == -1) {
+		perror("sigaction");
+		exit(1);
+	}
+
+	if (sigsetjmp(mark, 1) != 0) {
+		restore_from_trap();
+		exit(0);
+	}
+}
+
+#define has_user_space_efault() (1)
+#else
+#define record_test_context(idx, iteration, iterations) do { } while (0)
+#define record_test_case(test, llen, name, ret) do { } while (0)
+#define register_expect_trap(experr1, experr2) do { } while (0)
+#define register_trap_handler() do { } while (0)
+#define has_user_space_efault() (0)
+#endif
+
 static void putcharn(char c, size_t n)
 {
 	char buf[64];
@@ -304,7 +447,7 @@ static int expect_sysne(int expr, int llen, int val)
 
 
 #define EXPECT_SYSER2(cond, expr, expret, experr1, experr2)		\
-	do { if (!cond) pad_spc(llen, 64, "[SKIPPED]\n"); else ret += expect_syserr2(expr, expret, experr1, experr2, llen); } while (0)
+	do { if (!cond) pad_spc(llen, 64, "[SKIPPED]\n"); else { register_expect_trap(experr1, experr2); ret += expect_syserr2(expr, expret, experr1, experr2, llen); } } while (0)
 
 #define EXPECT_SYSER(cond, expr, expret, experr)			\
 	EXPECT_SYSER2(cond, expr, expret, experr, 0)
@@ -439,7 +582,7 @@ static int expect_strne(const char *expr, int llen, const char *cmp)
 
 /* declare tests based on line numbers. There must be exactly one test per line. */
 #define CASE_TEST(name) \
-	case __LINE__: llen += printf("%d %s", test, #name);
+	case __LINE__: llen += printf("%d %s", test, #name); record_test_case(test, llen, ret, #name);
 
 
 /* used by some syscall tests below */
@@ -974,6 +1117,9 @@ int main(int argc, char **argv, char **envp)
 	if (getpid() == 1)
 		prepare();
 
+	/* register exception restore support if enabled */
+	register_trap_handler();
+
 	/* the definition of a series of tests comes from either argv[1] or the
 	 * "NOLIBC_TEST" environment variable. It's made of a comma-delimited
 	 * series of test names and optional ranges:
@@ -1071,6 +1217,7 @@ int main(int argc, char **argv, char **envp)
 		for (idx = 0; test_names[idx].name; idx++) {
 			if (test_names[idx].run != 0) {
 				printf("Running test '%s', from %d to %d\n", test_names[idx].name, test_names[idx].min, test_names[idx].max);
+				record_test_context(idx, i, run);
 				err = test_names[idx].func(test_names[idx].min, test_names[idx].max);
 				ret += err;
 				printf("Errors during this test: %d\n\n", err);
-- 
2.25.1

