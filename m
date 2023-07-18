Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4545758831
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Jul 2023 00:06:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231559AbjGRWGT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 18 Jul 2023 18:06:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231512AbjGRWGQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 18 Jul 2023 18:06:16 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4CD01BF3;
        Tue, 18 Jul 2023 15:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1689717870;
        bh=aqVd9xLtq21+UynUvtTIi67kU86K5eTdtQ2fKTaL4r0=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=kV56SCDKepjOI1WTdtZJAeMyBjdSXKMtd3/2w/zzpd4UjOe4jN5UsniXxP3I8D50j
         FMM97CK6Va0uAnnziG0el70H4IbBOahFSn6wUlWAoT+0vKEu0WwRTjfvN+qePVx9QK
         vprOaG2M/SFS6hoiPFKcIq6yjqKEjKwe/ndEQNu8=
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date:   Wed, 19 Jul 2023 00:00:45 +0200
Subject: [PATCH RFC 7/7] selftests/nolibc: proof of concept for TAP output
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230719-nolibc-ktap-tmp-v1-7-930bd0c52ff1@weissschuh.net>
References: <20230719-nolibc-ktap-tmp-v1-0-930bd0c52ff1@weissschuh.net>
In-Reply-To: <20230719-nolibc-ktap-tmp-v1-0-930bd0c52ff1@weissschuh.net>
To:     Willy Tarreau <w@1wt.eu>
Cc:     Zhangjin Wu <falcon@tinylab.org>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1689717869; l=13539;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=aqVd9xLtq21+UynUvtTIi67kU86K5eTdtQ2fKTaL4r0=;
 b=GZj4U1deTPI7X6WaN6Humx2Gyo4aRY75z28gUfV15NnEA+rYSxhHMq1oU4kUgoP2iMWz3jUot
 lRi4+NyGrBQAJI0ejNi0F8P35Arf6HsNH74kjKwGjfgOF6aG+s1IocC
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Dirty proof of concept to show how (K)TAP output can look and how it can
be used.

Currently test selection is not supported and for simplicity only the
startup tests are enabled.

Example output:

$ ./nolibc-test
 KTAP version 1
 1..15
 ok 1 argc = 1
 ok 2 argv_addr = <0x7ffdc66173a8>
 ok 3 argv_environ = <0x7ffdc66173a8>
 ok 4 argv_total = 1
 ok 5 argv0_addr = <0x7ffdc6618bca>
 ok 6 argv0_str = <0x7ffdc6618bca>
 ok 7 argv0_len = 13
 ok 8 environ_addr = <0x7ffdc66173b8>
 ok 9 environ_envp = <0x7ffdc66173b8>
 ok 10 environ_auxv = <0x7ffdc66173b8>
 ok 11 environ_total = 271
 ok 12 environ_HOME = <0x7ffdc6618cc7>
 ok 13 auxv_addr = <0x7ffdc66174c8>
 ok 14 auxv_AT_UID = 1000
 ok 15 auxv_AT_PAGESZ = 4096
 # Exiting with status 0
 # Totals: pass:15 fail:0 xfail:0 xpass:0 skip:0 error:0

$ ./libc-test
 KTAP version 1
 1..15
 ok 1 argc = 1
 ok 2 argv_addr = <0x7ffd5f3d43e8>
 ok 3 argv_environ = <0x7ffd5f3d43e8>
 ok 4 argv_total = 1
 ok 5 argv0_addr = <0x7ffd5f3d5bd0>
 ok 6 argv0_str = <0x7ffd5f3d5bd0>
 ok 7 argv0_len = 11
 ok 8 environ_addr = <0x7ffd5f3d43f8>
 ok 9 environ_envp = <0x7ffd5f3d43f8>
 ok 10 environ_auxv # SKIP test_auxv != (void *)-1
 ok 11 environ_total # SKIP test_auxv != (void *)-1
 ok 12 environ_HOME = <0x7ffd5f3d5ccb>
 ok 13 auxv_addr # SKIP test_auxv != (void *)-1
 ok 14 auxv_AT_UID = 1000
 ok 15 auxv_AT_PAGESZ = 4096
 # Exiting with status 0
 # Totals: pass:12 fail:0 xfail:0 xpass:0 skip:3 error:0

./run-all-tests.sh | $SRC/tools/testing/kunit/kunit.py parse
 [23:47:26] ============================================================
 [23:47:26] ====================== (15 subtests) =======================
 [23:47:26] [PASSED] argc = 1
 [23:47:26] [PASSED] argv_addr = <0x7ffcac1b8bc8>
 [23:47:26] [PASSED] argv_environ = <0x7ffcac1b8bc8>
 [23:47:26] [PASSED] argv_total = 1
 [23:47:26] [PASSED] argv0_addr = <0x7ffcac1b9bd0>
 [23:47:26] [PASSED] argv0_str = <0x7ffcac1b9bd0>
 [23:47:26] [PASSED] argv0_len = 11
 [23:47:26] [PASSED] environ_addr = <0x7ffcac1b8bd8>
 [23:47:26] [PASSED] environ_envp = <0x7ffcac1b8bd8>
 [23:47:26] [SKIPPED] environ_auxv
 [23:47:26] [SKIPPED] environ_total
 [23:47:26] [PASSED] environ_HOME = <0x7ffcac1b9ccb>
 [23:47:26] [SKIPPED] auxv_addr
 [23:47:26] [PASSED] auxv_AT_UID = 1000
 [23:47:26] [PASSED] auxv_AT_PAGESZ = 4096
 [23:47:26] ====================== [PASSED] arm64 ======================
 [23:47:26] ====================== (15 subtests) =======================
 [23:47:26] [PASSED] argc = 1
 [23:47:26] [PASSED] argv_addr = <0x7ffdee178188>
 [23:47:26] [PASSED] argv_environ = <0x7ffdee178188>
 [23:47:26] [PASSED] argv_total = 1
 [23:47:26] [PASSED] argv0_addr = <0x7ffdee178bd0>
 [23:47:26] [PASSED] argv0_str = <0x7ffdee178bd0>
 [23:47:26] [PASSED] argv0_len = 11
 [23:47:26] [PASSED] environ_addr = <0x7ffdee178198>
 [23:47:26] [PASSED] environ_envp = <0x7ffdee178198>
 [23:47:26] [SKIPPED] environ_auxv
 [23:47:26] [SKIPPED] environ_total
 [23:47:26] [PASSED] environ_HOME = <0x7ffdee178ccb>
 [23:47:26] [SKIPPED] auxv_addr
 [23:47:26] [PASSED] auxv_AT_UID = 1000
 [23:47:26] [PASSED] auxv_AT_PAGESZ = 4096
 [23:47:26] ===================== [PASSED] x86_64 ======================
 [23:47:26] ====================== (15 subtests) =======================
 [23:47:26] [PASSED] argc = 1
 [23:47:26] [PASSED] argv_addr = <0x7ffc16bf3628>
 [23:47:26] [PASSED] argv_environ = <0x7ffc16bf3628>
 [23:47:26] [PASSED] argv_total = 1
 [23:47:26] [PASSED] argv0_addr = <0x7ffc16bf4bd0>
 [23:47:26] [PASSED] argv0_str = <0x7ffc16bf4bd0>
 [23:47:26] [PASSED] argv0_len = 11
 [23:47:26] [PASSED] environ_addr = <0x7ffc16bf3638>
 [23:47:26] [PASSED] environ_envp = <0x7ffc16bf3638>
 [23:47:26] [SKIPPED] environ_auxv
 [23:47:26] [SKIPPED] environ_total
 [23:47:26] [PASSED] environ_HOME = <0x7ffc16bf4ccb>
 [23:47:26] [SKIPPED] auxv_addr
 [23:47:26] [PASSED] auxv_AT_UID = 1000
 [23:47:26] [PASSED] auxv_AT_PAGESZ = 4096
 [23:47:26] ===================== [PASSED] riscv64 =====================
 [23:47:26] ============================================================
 [23:47:26] Testing complete. Ran 45 tests: passed: 36, skipped: 9

The output of kunit.py is colored after the test results.

Not-signed-off
---
 tools/testing/selftests/nolibc/nolibc-test.c    | 121 ++++++++----------------
 tools/testing/selftests/nolibc/run-all-tests.sh |  22 +++++
 2 files changed, 63 insertions(+), 80 deletions(-)

diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index 03f64ce1dda6..f8064cd58783 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -41,12 +41,13 @@
 #endif
 #endif
 
+#define inline __inline__
+#include "../kselftest.h"
+
 /* for the type of int_fast16_t and int_fast32_t, musl differs from glibc and nolibc */
 #define SINT_MAX_OF_TYPE(type) (((type)1 << (sizeof(type) * 8 - 2)) - (type)1 + ((type)1 << (sizeof(type) * 8 - 2)))
 #define SINT_MIN_OF_TYPE(type) (-SINT_MAX_OF_TYPE(type) - 1)
 
-#define ARRAY_SIZE(x) (sizeof(x) / sizeof(x[0]))
-
 /* will be used to test initialization of environ */
 static char **test_envp;
 
@@ -59,6 +60,8 @@ static int test_argc;
 /* will be used by some test cases as readable file, please don't write it */
 static const char *argv0;
 
+static const char *test_name;
+
 /* definition of a series of tests */
 struct test {
 	const char *name;              /* test name */
@@ -197,15 +200,11 @@ static int expect_nz(int expr, int llen)
 
 
 #define EXPECT_EQ(cond, expr, val)				\
-	do { if (!(cond)) result(llen, SKIPPED); else ret += expect_eq(expr, llen, val); } while (0)
+	do { if (!(cond)) ksft_test_result_skip2(test_name, "%s\n", #cond); else expect_eq(expr, val); } while (0)
 
-static int expect_eq(uint64_t expr, int llen, uint64_t val)
+static int expect_eq(uint64_t expr, uint64_t val)
 {
-	int ret = !(expr == val);
-
-	llen += printf(" = %lld ", (long long)expr);
-	result(llen, ret ? FAIL : OK);
-	return ret;
+	ksft_test_result(expr = val, "%s = %lld\n", test_name, (long long) expr);
 }
 
 
@@ -223,15 +222,11 @@ static int expect_ne(int expr, int llen, int val)
 
 
 #define EXPECT_GE(cond, expr, val)				\
-	do { if (!(cond)) result(llen, SKIPPED); else ret += expect_ge(expr, llen, val); } while (0)
+	do { if (!(cond)) ksft_test_result_skip2(test_name, "%s\n", #cond); else expect_ge(expr, val); } while (0)
 
-static int expect_ge(int expr, int llen, int val)
+static int expect_ge(int expr, int val)
 {
-	int ret = !(expr >= val);
-
-	llen += printf(" = %d ", expr);
-	result(llen, ret ? FAIL : OK);
-	return ret;
+	ksft_test_result(expr >= val, "%s = %d\n", test_name, expr);
 }
 
 
@@ -376,37 +371,19 @@ static int expect_ptrzr(const void *expr, int llen)
 
 
 #define EXPECT_PTRNZ(cond, expr)				\
-	do { if (!(cond)) result(llen, SKIPPED); else ret += expect_ptrnz(expr, llen); } while (0)
+	do { if (!(cond)) ksft_test_result_skip("%s: %s\n", test_name, #cond); else expect_ptrnz(expr); } while (0)
 
-static int expect_ptrnz(const void *expr, int llen)
+static int expect_ptrnz(const void *expr)
 {
-	int ret = 0;
-
-	llen += printf(" = <%p> ", expr);
-	if (!expr) {
-		ret = 1;
-		result(llen, FAIL);
-	} else {
-		result(llen, OK);
-	}
-	return ret;
+	ksft_test_result(expr, "%s = <%p>\n", test_name, expr);
 }
 
 #define EXPECT_PTREQ(cond, expr, cmp)				\
-	do { if (!(cond)) result(llen, SKIPPED); else ret += expect_ptreq(expr, llen, cmp); } while (0)
+	do { if (!(cond)) ksft_test_result_skip("%s: %s\n", test_name, #cond); else expect_ptreq(expr, cmp); } while (0)
 
-static int expect_ptreq(const void *expr, int llen, const void *cmp)
+static void expect_ptreq(const void *expr, const void *cmp)
 {
-	int ret = 0;
-
-	llen += printf(" = <%p> ", expr);
-	if (expr != cmp) {
-		ret = 1;
-		result(llen, FAIL);
-	} else {
-		result(llen, OK);
-	}
-	return ret;
+	ksft_test_result(expr == cmp, "%s = <%p>\n", test_name, expr);
 }
 
 #define EXPECT_PTRNE(cond, expr, cmp)				\
@@ -439,41 +416,28 @@ static int expect_ptrge(const void *expr, int llen, const void *cmp)
 }
 
 #define EXPECT_PTRGT(cond, expr, cmp)				\
-	do { if (!(cond)) result(llen, SKIPPED); else ret += expect_ptrgt(expr, llen, cmp); } while (0)
+	do { if (!(cond)) ksft_test_result_skip2(test_name, "%s\n", #cond); else expect_ptrgt(expr, cmp); } while (0)
 
-static int expect_ptrgt(const void *expr, int llen, const void *cmp)
+static void expect_ptrgt(const void *expr, const void *cmp)
 {
-	int ret = !(expr > cmp);
-
-	llen += printf(" = <%p> ", expr);
-	result(llen, ret ? FAIL : OK);
-	return ret;
+	ksft_test_result(expr > cmp, "%s = <%p>\n", test_name, expr);
 }
 
-
 #define EXPECT_PTRLE(cond, expr, cmp)				\
-	do { if (!(cond)) result(llen, SKIPPED); else ret += expect_ptrle(expr, llen, cmp); } while (0)
+	do { if (!(cond)) ksft_test_result_skip("%s: %s\n", test_name, #cond); else expect_ptrle(expr, cmp); } while (0)
 
 static int expect_ptrle(const void *expr, int llen, const void *cmp)
 {
-	int ret = !(expr <= cmp);
-
-	llen += printf(" = <%p> ", expr);
-	result(llen, ret ? FAIL : OK);
-	return ret;
+	ksft_test_result(expr <= cmp, "%s = <%p>\n", test_name, expr);
 }
 
 
 #define EXPECT_PTRLT(cond, expr, cmp)				\
-	do { if (!(cond)) result(llen, SKIPPED); else ret += expect_ptrlt(expr, llen, cmp); } while (0)
+	do { if (!(cond)) ksft_test_result_skip2(test_name, "%s\n", #cond); else expect_ptrlt(expr, cmp); } while (0)
 
-static int expect_ptrlt(const void *expr, int llen, const void *cmp)
+static int expect_ptrlt(const void *expr, const void *cmp)
 {
-	int ret = !(expr < cmp);
-
-	llen += printf(" = <%p> ", expr);
-	result(llen, ret ? FAIL : OK);
-	return ret;
+	ksft_test_result(expr < cmp, "%s = <%p>\n", test_name, expr);
 }
 
 #define EXPECT_PTRER2(cond, expr, expret, experr1, experr2)		\
@@ -520,20 +484,11 @@ static int expect_strzr(const char *expr, int llen)
 
 
 #define EXPECT_STRNZ(cond, expr)				\
-	do { if (!(cond)) result(llen, SKIPPED); else ret += expect_strnz(expr, llen); } while (0)
+	do { if (!(cond)) ksft_test_result_skip("%s: %s\n", test_name, #cond); else expect_strnz(expr); } while (0)
 
-static int expect_strnz(const char *expr, int llen)
+static int expect_strnz(const char *expr)
 {
-	int ret = 0;
-
-	llen += printf(" = <%s> ", expr);
-	if (!expr) {
-		ret = 1;
-		result(llen, FAIL);
-	} else {
-		result(llen, OK);
-	}
-	return ret;
+	ksft_test_result(expr, "%s = <%p>\n", test_name, expr);
 }
 
 
@@ -575,7 +530,7 @@ static int expect_strne(const char *expr, int llen, const char *cmp)
 
 /* declare tests based on line numbers. There must be exactly one test per line. */
 #define CASE_TEST(name) \
-	case __LINE__: llen += printf("%d %s", test, #name);
+	case __LINE__: test_name = #name;
 
 #define SWITCH_TEST \
 	int _tests_start = __LINE__; switch (test + __LINE__ + 1) {
@@ -1187,10 +1142,12 @@ int prepare(void)
 static const struct test test_names[] = {
 	/* add new tests here */
 	{ .name = "startup",    .func = run_startup    },
+	/*
 	{ .name = "syscall",    .func = run_syscall    },
 	{ .name = "stdlib",     .func = run_stdlib     },
 	{ .name = "vfprintf",   .func = run_vfprintf   },
 	{ .name = "protection", .func = run_protection },
+	*/
 };
 
 int is_setting_valid(char *test)
@@ -1317,16 +1274,19 @@ int main(int argc, char **argv, char **envp)
 		} while (test && *test);
 	} else {
 		/* no test mentioned, run everything */
+
+		ksft_print_header_ktap();
+		int total = 0;
+		for (idx = 0; idx < ARRAY_SIZE(test_names); idx++)
+			total += count_subtests(&test_names[idx]);
+		ksft_set_plan(total);
+
 		for (idx = 0; idx < ARRAY_SIZE(test_names); idx++) {
-			printf("Running test '%s'\n", test_names[idx].name);
 			err = test_names[idx].func(min, max);
 			ret += err;
-			printf("Errors during this test: %d\n\n", err);
 		}
 	}
 
-	printf("Total number of errors: %d\n", ret);
-
 	if (getpid() == 1) {
 		/* we're running as init, there's no other process on the
 		 * system, thus likely started from a VM for a quick check.
@@ -1335,7 +1295,7 @@ int main(int argc, char **argv, char **envp)
 		 * cleanly will often be reported as a success. This allows
 		 * to use the output of this program for bisecting kernels.
 		 */
-		printf("Leaving init with final status: %d\n", !!ret);
+		ksft_print_msg("Leaving init with final status: %d\n", !!ret);
 		if (ret == 0)
 			reboot(RB_POWER_OFF);
 #if defined(__x86_64__)
@@ -1349,6 +1309,7 @@ int main(int argc, char **argv, char **envp)
 #endif
 	}
 
-	printf("Exiting with status %d\n", !!ret);
+	ksft_print_msg("Exiting with status %d\n", !!ret);
+	ksft_finished();
 	return !!ret;
 }
diff --git a/tools/testing/selftests/nolibc/run-all-tests.sh b/tools/testing/selftests/nolibc/run-all-tests.sh
new file mode 100755
index 000000000000..8f37b8b36ef4
--- /dev/null
+++ b/tools/testing/selftests/nolibc/run-all-tests.sh
@@ -0,0 +1,22 @@
+#!/bin/bash
+
+set -o pipefail
+
+archs=(arm64 x86_64 riscv64)
+
+echo "KTAP version 1"
+echo "1..${#archs[@]}"
+
+for i in "${!archs[@]}"; do
+	arch="${archs[$i]}"
+	./libc-test | sed -e 's/^/  /'
+	rc=$?
+
+	if [ $rc -eq 0 ]; then
+		res=ok
+	else
+		res="not ok"
+	fi
+
+	echo "$res $(( i + 1 )) $arch"
+done

-- 
2.41.0

