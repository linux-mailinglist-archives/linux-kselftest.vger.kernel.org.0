Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFA72754AC0
	for <lists+linux-kselftest@lfdr.de>; Sat, 15 Jul 2023 20:34:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230330AbjGOSeq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 15 Jul 2023 14:34:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjGOSep (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 15 Jul 2023 14:34:45 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0ACE271E;
        Sat, 15 Jul 2023 11:34:43 -0700 (PDT)
X-QQ-mid: bizesmtp86t1689446074thn87dje
Received: from linux-lab-host.localdomain ( [119.123.131.162])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sun, 16 Jul 2023 02:34:33 +0800 (CST)
X-QQ-SSF: 01200000002000D0W000B00A0000000
X-QQ-FEAT: wPivafIDGPNnE4pgBteeGjfO4VitGccVNTEgGVrjyg0S3lkSPswFvUfEC3oYD
        lR/yUIvjnDtW9NVv0uFM2R+RdQk8VwJyFfBHaiQxbmxNK7GvzScYpqPtEbdH8hf8UaZ6ocU
        W9OIDjPXpG7lEOK8SZdxqOMXUWqRFMvzFxOtqBN1CcbXNmz1bj3D3b6vZ5/stbHDzDaynkm
        mb6T48L4NKMzGDgW3F46hFNKVVZQ2NGVpPn4kM7dWVJ38RkRIEOXwQJRAiEHS3xi8FNJeYl
        xZaLvacE8y2isu6V+Z7ViWKjJFmvUKQmedpKBzUtE89FJGx4mJn3Ssw1KhDN3XIFJoAs0vW
        jhrKySOJPajkDqNyEwWGXqPNd8pl0FJRIHjdZooVyEoUkvrDuX38US3435PeLzETAE2q1hT
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 1900254662054636365
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     arnd@arndb.de, falcon@tinylab.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, thomas@t-8ch.de
Subject: [PATCH v4 16/18] selftests/nolibc: add testcases for startup code
Date:   Sun, 16 Jul 2023 02:34:32 +0800
Message-Id: <f6b11dfc844fbbd231739bcab9d71e7b7710845d.1689444638.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1689444638.git.falcon@tinylab.org>
References: <cover.1689444638.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The startup code is critical to get the right argc, argv, envp/environ
and _auxv, let's add a startup test group and the corresponding
testcases.

The "environ" test case is also moved from the stdlib test group to this
new startup test group and it is renamed to "environ_envp".

Since argv0 has been used by many other test cases, let's add testcases
to gurantee it too.

Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/testing/selftests/nolibc/nolibc-test.c | 56 +++++++++++++++++++-
 1 file changed, 55 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index 3ff706078fbd..03b1d30f5507 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -15,6 +15,7 @@
 #include <string.h>
 #ifndef _NOLIBC_STDIO_H
 /* standard libcs need more includes */
+#include <sys/auxv.h>
 #include <sys/io.h>
 #include <sys/ioctl.h>
 #include <sys/mman.h>
@@ -47,6 +48,12 @@
 /* will be used to test initialization of environ */
 static char **test_envp;
 
+/* will be used to test initialization of argv */
+static char **test_argv;
+
+/* will be used to test initialization of argc */
+static int test_argc;
+
 /* will be used by some test cases as readable file, please don't write it */
 static const char *argv0;
 
@@ -561,6 +568,51 @@ static int expect_strne(const char *expr, int llen, const char *cmp)
 #define CASE_TEST(name) \
 	case __LINE__: llen += printf("%d %s", test, #name);
 
+int run_startup(int min, int max)
+{
+	int test;
+	int ret = 0;
+	/* kernel at least passes HOME and TERM, shell passes more */
+	int env_total = 2;
+	/* checking NULL for argv/argv0, environ and _auxv is not enough, let's compare with sbrk(0) or &end */
+	extern char end;
+	char *brk = sbrk(0) != (void *)-1 ? sbrk(0) : &end;
+	/* differ from nolibc, both glibc and musl have no global _auxv */
+	const unsigned long *test_auxv = (void *)-1;
+#ifdef NOLIBC
+	test_auxv = _auxv;
+#endif
+
+	for (test = min; test >= 0 && test <= max; test++) {
+		int llen = 0; /* line length */
+
+		/* avoid leaving empty lines below, this will insert holes into
+		 * test numbers.
+		 */
+		switch (test + __LINE__ + 1) {
+		CASE_TEST(argc);             EXPECT_GE(1, test_argc, 1); break;
+		CASE_TEST(argv_addr);        EXPECT_PTRGT(1, test_argv, brk); break;
+		CASE_TEST(argv_environ);     EXPECT_PTRLT(1, test_argv, environ); break;
+		CASE_TEST(argv_total);       EXPECT_EQ(1, environ - test_argv - 1, test_argc ?: 1); break;
+		CASE_TEST(argv0_addr);       EXPECT_PTRGT(1, argv0, brk); break;
+		CASE_TEST(argv0_str);        EXPECT_STRNZ(1, argv0 > brk ? argv0 : NULL); break;
+		CASE_TEST(argv0_len);        EXPECT_GE(1,  argv0 > brk ? strlen(argv0) : 0, 1); break;
+		CASE_TEST(environ_addr);     EXPECT_PTRGT(1, environ, brk); break;
+		CASE_TEST(environ_envp);     EXPECT_PTREQ(1, environ, test_envp); break;
+		CASE_TEST(environ_auxv);     EXPECT_PTRLT(test_auxv != (void *)-1, environ, test_auxv); break;
+		CASE_TEST(environ_total);    EXPECT_GE(test_auxv != (void *)-1, (void *)test_auxv - (void *)environ - 1, env_total); break;
+		CASE_TEST(environ_HOME);     EXPECT_PTRNZ(1, getenv("HOME")); break;
+		CASE_TEST(auxv_addr);        EXPECT_PTRGT(test_auxv != (void *)-1, test_auxv, brk); break;
+		CASE_TEST(auxv_AT_UID);      EXPECT_EQ(1, getauxval(AT_UID), getuid()); break;
+		CASE_TEST(auxv_AT_PAGESZ);   EXPECT_GE(1, getauxval(AT_PAGESZ), 4096); break;
+		case __LINE__:
+			return ret; /* must be last */
+		/* note: do not set any defaults so as to permit holes above */
+		}
+	}
+	return ret;
+}
+
 
 /* used by some syscall tests below */
 int test_getdents64(const char *dir)
@@ -844,7 +896,6 @@ int run_stdlib(int min, int max)
 		 * test numbers.
 		 */
 		switch (test + __LINE__ + 1) {
-		CASE_TEST(environ);            EXPECT_PTREQ(1, environ, test_envp); break;
 		CASE_TEST(getenv_TERM);        EXPECT_STRNZ(1, getenv("TERM")); break;
 		CASE_TEST(getenv_blah);        EXPECT_STRZR(1, getenv("blah")); break;
 		CASE_TEST(setcmp_blah_blah);   EXPECT_EQ(1, strcmp("blah", "blah"), 0); break;
@@ -1128,6 +1179,7 @@ int prepare(void)
 /* This is the definition of known test names, with their functions */
 static const struct test test_names[] = {
 	/* add new tests here */
+	{ .name = "startup",    .func = run_startup    },
 	{ .name = "syscall",    .func = run_syscall    },
 	{ .name = "stdlib",     .func = run_stdlib     },
 	{ .name = "vfprintf",   .func = run_vfprintf   },
@@ -1174,6 +1226,8 @@ int main(int argc, char **argv, char **envp)
 	char *test;
 
 	argv0 = argv[0];
+	test_argc = argc;
+	test_argv = argv;
 	test_envp = envp;
 
 	/* when called as init, it's possible that no console was opened, for
-- 
2.25.1

