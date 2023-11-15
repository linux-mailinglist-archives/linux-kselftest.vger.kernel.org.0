Return-Path: <linux-kselftest+bounces-180-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 38E217ED5A3
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Nov 2023 22:08:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 672B21C20832
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Nov 2023 21:08:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C51345BF3;
	Wed, 15 Nov 2023 21:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="lwUkw52S"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FD66195;
	Wed, 15 Nov 2023 13:08:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1700082503;
	bh=HlSA1SyHbLq+YLFgo/K4APNgaXuxFOwOIDINMxgazBk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=lwUkw52SjhgseNzhWNUcDL4EgTb60nQ2kTWQI6bN4LRoS8jcR4La5NRgLaL2KX8xj
	 WIhaXgex4MZVqFFuiHKAnhyIZO1unxjREcXIwtUMG1qHke5Lxq/9HGDTsDmUbO5z73
	 rgVCWOT0ZYUmHC4kNz6A3DiNmqFr3chBiK5uAlfQ=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Wed, 15 Nov 2023 22:08:20 +0100
Subject: [PATCH RFC 2/3] selftests/nolibc: migrate startup tests to new
 harness
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20231115-nolibc-harness-v1-2-4d61382d9bf3@weissschuh.net>
References: <20231115-nolibc-harness-v1-0-4d61382d9bf3@weissschuh.net>
In-Reply-To: <20231115-nolibc-harness-v1-0-4d61382d9bf3@weissschuh.net>
To: Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1700082502; l=5892;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=HlSA1SyHbLq+YLFgo/K4APNgaXuxFOwOIDINMxgazBk=;
 b=hP6P1B3BWV+XJ3MuqSoF74Y2TB2e0zgYdrHYExJ5gDFTtX8x6RLmSG5V607IUYDAiBQJ1t73k
 bNKapL4H31oDxyvQtjxqRrz681odDRxHFAnmUbzVU79Vpx8J8qD2tOD
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Migrate part of nolibc-test.c to the new test harness.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/testing/selftests/nolibc/nolibc-test.c | 106 ++++++++++++++-------------
 1 file changed, 56 insertions(+), 50 deletions(-)

diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index e173014f6b66..6c1b42b58e3e 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -42,6 +42,7 @@
 #endif
 
 #include "nolibc-test-linkage.h"
+#include "nolibc-harness.h"
 
 /* for the type of int_fast16_t and int_fast32_t, musl differs from glibc and nolibc */
 #define SINT_MAX_OF_TYPE(type) (((type)1 << (sizeof(type) * 8 - 2)) - (type)1 + ((type)1 << (sizeof(type) * 8 - 2)))
@@ -130,15 +131,6 @@ static const char *errorname(int err)
 	}
 }
 
-static void putcharn(char c, size_t n)
-{
-	char buf[64];
-
-	memset(buf, c, n);
-	buf[n] = '\0';
-	fputs(buf, stdout);
-}
-
 enum RESULT {
 	OK,
 	FAIL,
@@ -599,6 +591,19 @@ int expect_strne(const char *expr, int llen, const char *cmp)
 #define CASE_TEST(name) \
 	case __LINE__: llen += printf("%d %s", test, #name);
 
+#if defined(NOLIBC)
+
+#define ASSUME_NOLIBC(stmt)
+
+#else /* defined(NOLIBC) */
+
+/* differ from nolibc, both glibc and musl have no global _auxv */
+unsigned long *_auxv = (void *)-1;
+#define ASSUME_NOLIBC(stmt) SKIP(stmt)
+
+#endif /* defined(NOLIBC) */
+
+
 /* constructors validate that they are executed in definition order */
 __attribute__((constructor))
 static void constructor1(void)
@@ -612,53 +617,54 @@ static void constructor2(void)
 	constructor_test_value *= 2;
 }
 
-int run_startup(int min, int max)
+static const void *pbrk(void)
 {
-	int test;
-	int ret = 0;
-	/* kernel at least passes HOME and TERM, shell passes more */
-	int env_total = 2;
-	/* checking NULL for argv/argv0, environ and _auxv is not enough, let's compare with sbrk(0) or &end */
 	extern char end;
-	char *brk = sbrk(0) != (void *)-1 ? sbrk(0) : &end;
-	/* differ from nolibc, both glibc and musl have no global _auxv */
-	const unsigned long *test_auxv = (void *)-1;
-#ifdef NOLIBC
-	test_auxv = _auxv;
-#endif
+	static char *brk;
 
-	for (test = min; test >= 0 && test <= max; test++) {
-		int llen = 0; /* line length */
+	if (brk)
+		return brk;
 
-		/* avoid leaving empty lines below, this will insert holes into
-		 * test numbers.
-		 */
-		switch (test + __LINE__ + 1) {
-		CASE_TEST(argc);             EXPECT_GE(1, test_argc, 1); break;
-		CASE_TEST(argv_addr);        EXPECT_PTRGT(1, test_argv, brk); break;
-		CASE_TEST(argv_environ);     EXPECT_PTRLT(1, test_argv, environ); break;
-		CASE_TEST(argv_total);       EXPECT_EQ(1, environ - test_argv - 1, test_argc ?: 1); break;
-		CASE_TEST(argv0_addr);       EXPECT_PTRGT(1, argv0, brk); break;
-		CASE_TEST(argv0_str);        EXPECT_STRNZ(1, argv0 > brk ? argv0 : NULL); break;
-		CASE_TEST(argv0_len);        EXPECT_GE(1,  argv0 > brk ? strlen(argv0) : 0, 1); break;
-		CASE_TEST(environ_addr);     EXPECT_PTRGT(1, environ, brk); break;
-		CASE_TEST(environ_envp);     EXPECT_PTREQ(1, environ, test_envp); break;
-		CASE_TEST(environ_auxv);     EXPECT_PTRLT(test_auxv != (void *)-1, environ, test_auxv); break;
-		CASE_TEST(environ_total);    EXPECT_GE(test_auxv != (void *)-1, (void *)test_auxv - (void *)environ - 1, env_total); break;
-		CASE_TEST(environ_HOME);     EXPECT_PTRNZ(1, getenv("HOME")); break;
-		CASE_TEST(auxv_addr);        EXPECT_PTRGT(test_auxv != (void *)-1, test_auxv, brk); break;
-		CASE_TEST(auxv_AT_UID);      EXPECT_EQ(1, getauxval(AT_UID), getuid()); break;
-		CASE_TEST(constructor);      EXPECT_EQ(1, constructor_test_value, 2); break;
-		CASE_TEST(linkage_errno);    EXPECT_PTREQ(1, linkage_test_errno_addr(), &errno); break;
-		CASE_TEST(linkage_constr);   EXPECT_EQ(1, linkage_test_constructor_test_value, 6); break;
-		case __LINE__:
-			return ret; /* must be last */
-		/* note: do not set any defaults so as to permit holes above */
-		}
-	}
-	return ret;
+	brk = sbrk(0);
+
+	if (brk == (void *)-1)
+		brk = &end;
+
+	return brk;
 }
 
+TEST(startup, argc)           { ASSERT_GE(test_argc, 1); }
+TEST(startup, argv_addr)      { ASSERT_GT((void *)test_argv, pbrk()); }
+TEST(startup, argv_environ)   { ASSERT_LT(test_argv, environ); }
+TEST(startup, argv_total)     { ASSERT_EQ(environ - test_argv - 1, test_argc ?: 1); }
+TEST(startup, argv0_addr)     { ASSERT_GT((void *)argv0, pbrk()); }
+TEST(startup, argv0_str)      { ASSERT_STRNZ((void *)argv0 > pbrk() ? argv0 : NULL); }
+TEST(startup, argv0_len)      { ASSERT_GE((void *)argv0 > pbrk() ? strlen(argv0) : 0U, 1U); }
+TEST(startup, environ_addr)   { ASSERT_GT((void *)environ, pbrk()); }
+TEST(startup, environ_envp)   { ASSERT_EQ(environ, test_envp); }
+TEST(startup, environ_auxv)   {
+	ASSUME_NOLIBC(return);
+	ASSERT_LT((void *)environ, (void *)_auxv);
+}
+TEST(startup, environ_total)  {
+	ASSUME_NOLIBC(return);
+	/* kernel at least passes HOME and TERM, shell passes more */
+	ASSERT_GE((void *)_auxv - (void *)environ - 1, 2);
+}
+TEST(startup, environ_HOME)   { ASSERT_NE(getenv("HOME"), NULL); }
+TEST(startup, auxv_addr)      {
+	ASSUME_NOLIBC(return);
+	ASSERT_GT((void *)_auxv, pbrk());
+}
+TEST(startup, auxv_AT_UID)    { ASSERT_EQ(getauxval(AT_UID), getuid()); }
+TEST(startup, constructor)    { ASSERT_EQ(constructor_test_value, 2); }
+TEST(startup, linkage_errno)  { ASSERT_EQ(linkage_test_errno_addr(), &errno); }
+TEST(startup, linkage_constr) { ASSERT_EQ(linkage_test_constructor_test_value, 6); }
+
+int run_startup(int min, int max)
+{
+	return run_test_suite("startup", min, max);
+}
 
 /* used by some syscall tests below */
 int test_getdents64(const char *dir)

-- 
2.42.1


