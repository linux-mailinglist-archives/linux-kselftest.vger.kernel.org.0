Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F312758828
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Jul 2023 00:05:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231321AbjGRWFo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 18 Jul 2023 18:05:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231223AbjGRWFk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 18 Jul 2023 18:05:40 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FF851BD6;
        Tue, 18 Jul 2023 15:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1689717870;
        bh=9tYgx+WfYrn6xP3FZVHJby6ysrS/sMHOehZR3Xlpc/s=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=m5c+BWv6YKn4k+FgdJJMmiddQmYfpNXcxuVbDpi8jhkDyAlc/DyxeHZXm1f5KkEuO
         OnDjnRscwIQSNqrjq/clk1HBRYvK9B7cNZojEqiYtMWs8nMRfGq5fVWw1whtY/rG3r
         IbvQG2M3m/aJPVxi1zomUFbDs2Alhvogt03IZ2k8=
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date:   Wed, 19 Jul 2023 00:00:41 +0200
Subject: [PATCH RFC 3/7] selftests/nolibc: replace repetitive test
 structure with macro
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230719-nolibc-ktap-tmp-v1-3-930bd0c52ff1@weissschuh.net>
References: <20230719-nolibc-ktap-tmp-v1-0-930bd0c52ff1@weissschuh.net>
In-Reply-To: <20230719-nolibc-ktap-tmp-v1-0-930bd0c52ff1@weissschuh.net>
To:     Willy Tarreau <w@1wt.eu>
Cc:     Zhangjin Wu <falcon@tinylab.org>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1689717869; l=4783;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=9tYgx+WfYrn6xP3FZVHJby6ysrS/sMHOehZR3Xlpc/s=;
 b=QLADuxLfv/AYcoLNp9wB3i7VX2qqJEnF3qajtEePwoSYWiURCPvR1LwGEnA9HOXfedRfOYdML
 kScKc5X/uILAf4qMGy5RmainVcrSVU449j/L4QuH/QdY44R02w0rcqf
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

A future patch will change these, so prepare for that.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/testing/selftests/nolibc/nolibc-test.c | 35 ++++++++++++----------------
 1 file changed, 15 insertions(+), 20 deletions(-)

diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index 1bd99e0fab4d..76bd6a0a8132 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -570,6 +570,13 @@ static int expect_strne(const char *expr, int llen, const char *cmp)
 #define CASE_TEST(name) \
 	case __LINE__: llen += printf("%d %s", test, #name);
 
+#define SWITCH_TEST \
+	switch (test + __LINE__ + 1) {
+
+#define SWITCH_TEST_END \
+	case __LINE__: return ret; }
+
+
 int run_startup(unsigned int min, unsigned int max)
 {
 	int test;
@@ -591,7 +598,7 @@ int run_startup(unsigned int min, unsigned int max)
 		/* avoid leaving empty lines below, this will insert holes into
 		 * test numbers.
 		 */
-		switch (test + __LINE__ + 1) {
+		SWITCH_TEST
 		CASE_TEST(argc);             EXPECT_GE(1, test_argc, 1); break;
 		CASE_TEST(argv_addr);        EXPECT_PTRGT(1, test_argv, brk); break;
 		CASE_TEST(argv_environ);     EXPECT_PTRLT(1, test_argv, environ); break;
@@ -607,10 +614,7 @@ int run_startup(unsigned int min, unsigned int max)
 		CASE_TEST(auxv_addr);        EXPECT_PTRGT(test_auxv != (void *)-1, test_auxv, brk); break;
 		CASE_TEST(auxv_AT_UID);      EXPECT_EQ(1, getauxval(AT_UID), getuid()); break;
 		CASE_TEST(auxv_AT_PAGESZ);   EXPECT_GE(1, getauxval(AT_PAGESZ), 4096); break;
-		case __LINE__:
-			return ret; /* must be last */
-		/* note: do not set any defaults so as to permit holes above */
-		}
+		SWITCH_TEST_END
 	}
 	return ret;
 }
@@ -803,7 +807,7 @@ int run_syscall(unsigned int min, unsigned int max)
 		/* avoid leaving empty lines below, this will insert holes into
 		 * test numbers.
 		 */
-		switch (test + __LINE__ + 1) {
+		SWITCH_TEST
 		CASE_TEST(getpid);            EXPECT_SYSNE(1, getpid(), -1); break;
 		CASE_TEST(getppid);           EXPECT_SYSNE(1, getppid(), -1); break;
 		CASE_TEST(gettid);            EXPECT_SYSNE(has_gettid, gettid(), -1); break;
@@ -876,10 +880,7 @@ int run_syscall(unsigned int min, unsigned int max)
 		CASE_TEST(write_zero);        EXPECT_SYSZR(1, write(1, &tmp, 0)); break;
 		CASE_TEST(syscall_noargs);    EXPECT_SYSEQ(1, syscall(__NR_getpid), getpid()); break;
 		CASE_TEST(syscall_args);      EXPECT_SYSER(1, syscall(__NR_statx, 0, NULL, 0, 0, NULL), -1, EFAULT); break;
-		case __LINE__:
-			return ret; /* must be last */
-		/* note: do not set any defaults so as to permit holes above */
-		}
+		SWITCH_TEST_END
 	}
 	return ret;
 }
@@ -897,7 +898,7 @@ int run_stdlib(unsigned int min, unsigned int max)
 		/* avoid leaving empty lines below, this will insert holes into
 		 * test numbers.
 		 */
-		switch (test + __LINE__ + 1) {
+		SWITCH_TEST
 		CASE_TEST(getenv_TERM);        EXPECT_STRNZ(1, getenv("TERM")); break;
 		CASE_TEST(getenv_blah);        EXPECT_STRZR(1, getenv("blah")); break;
 		CASE_TEST(setcmp_blah_blah);   EXPECT_EQ(1, strcmp("blah", "blah"), 0); break;
@@ -966,10 +967,7 @@ int run_stdlib(unsigned int min, unsigned int max)
 		CASE_TEST(limit_ptrdiff_min_32);    EXPECT_EQ(sizeof(long) == 4, PTRDIFF_MIN, (ptrdiff_t) 0x80000000); break;
 		CASE_TEST(limit_ptrdiff_max_32);    EXPECT_EQ(sizeof(long) == 4, PTRDIFF_MAX, (ptrdiff_t) 0x7fffffff); break;
 		CASE_TEST(limit_size_max_32);       EXPECT_EQ(sizeof(long) == 4, SIZE_MAX,    (size_t)    0xffffffffU); break;
-		case __LINE__:
-			return ret; /* must be last */
-		/* note: do not set any defaults so as to permit holes above */
-		}
+		SWITCH_TEST_END
 	}
 	return ret;
 }
@@ -1040,7 +1038,7 @@ static int run_vfprintf(unsigned int min, unsigned int max)
 		/* avoid leaving empty lines below, this will insert holes into
 		 * test numbers.
 		 */
-		switch (test + __LINE__ + 1) {
+		SWITCH_TEST
 		CASE_TEST(empty);        EXPECT_VFPRINTF(0, "", ""); break;
 		CASE_TEST(simple);       EXPECT_VFPRINTF(3, "foo", "foo"); break;
 		CASE_TEST(string);       EXPECT_VFPRINTF(3, "foo", "%s", "foo"); break;
@@ -1050,10 +1048,7 @@ static int run_vfprintf(unsigned int min, unsigned int max)
 		CASE_TEST(char);         EXPECT_VFPRINTF(1, "c", "%c", 'c'); break;
 		CASE_TEST(hex);          EXPECT_VFPRINTF(1, "f", "%x", 0xf); break;
 		CASE_TEST(pointer);      EXPECT_VFPRINTF(3, "0x1", "%p", (void *) 0x1); break;
-		case __LINE__:
-			return ret; /* must be last */
-		/* note: do not set any defaults so as to permit holes above */
-		}
+		SWITCH_TEST_END
 	}
 	return ret;
 }

-- 
2.41.0

