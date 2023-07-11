Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 418A174EB1C
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Jul 2023 11:49:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232140AbjGKJtw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 11 Jul 2023 05:49:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231653AbjGKJto (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 11 Jul 2023 05:49:44 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 788AE10A;
        Tue, 11 Jul 2023 02:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1689068974;
        bh=txFukGFwyweVshf0G5po0roPtMNzdkZKHFjAEnu9/v8=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=iJVfM8jhI7hf1IL/Hbtk6PTdCqgNpdT5w0yqGi2ujcL/IWdndcmRAx5JMXDvrZuSp
         YETS5twab4qxJqE2CMXiwwDjmZdVpVmulX6ypO7HkoCldobpmLAt2vIySkWI940UUN
         S57wVw1oJwticAFObWXMJWJBHnxsACo7kbdKvGhk=
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date:   Tue, 11 Jul 2023 11:48:40 +0200
Subject: [PATCH 2/4] selftests/nolibc: simplify status printing
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230711-nolibc-sizeof-long-gaps-v1-2-dc78c3b85fc3@weissschuh.net>
References: <20230711-nolibc-sizeof-long-gaps-v1-0-dc78c3b85fc3@weissschuh.net>
In-Reply-To: <20230711-nolibc-sizeof-long-gaps-v1-0-dc78c3b85fc3@weissschuh.net>
To:     Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zhangjin Wu <falcon@tinylab.org>,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1689068953; l=16359;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=txFukGFwyweVshf0G5po0roPtMNzdkZKHFjAEnu9/v8=;
 b=ffZCKr1Wzpbq7cuSyuk0E+DlmtB/1JAot5oohiM7uH420wiOd8ZSh0H9ElBMBuojb18LA2CfG
 Z22zBOIehOdCySNi7x9dZdoMbspvXfFkjG6N1PwBmFrD5ZCti/bfuDg
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

pad_spc() is only ever used to print the status message of testcases.
The line size is always constant, the return value is never used and the
format string is never used as such.

Remove all the unneeded logic and simplify the API and its users.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/testing/selftests/nolibc/nolibc-test.c | 154 ++++++++++++++-------------
 1 file changed, 81 insertions(+), 73 deletions(-)

diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index c252ea0c2f01..b7ed10512d67 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -127,17 +127,25 @@ static void putcharn(char c, size_t n)
 	fputs(buf, stdout);
 }
 
-static int pad_spc(int llen, int cnt, const char *fmt, ...)
+enum RESULT {
+	OK,
+	FAIL,
+	SKIPPED,
+};
+
+static void result(int llen, enum RESULT r)
 {
-	va_list args;
-	int ret;
+	const char *msg;
 
-	putcharn(' ', cnt - llen);
+	if (r == OK)
+		msg = " [OK]";
+	else if (r == SKIPPED)
+		msg = "[SKIPPED]";
+	else
+		msg = "[FAIL]";
 
-	va_start(args, fmt);
-	ret = vfprintf(stdout, fmt, args);
-	va_end(args);
-	return ret < 0 ? ret : ret + cnt - llen;
+	putcharn(' ', 64 - llen);
+	puts(msg);
 }
 
 /* The tests below are intended to be used by the macroes, which evaluate
@@ -147,111 +155,111 @@ static int pad_spc(int llen, int cnt, const char *fmt, ...)
  */
 
 #define EXPECT_ZR(cond, expr)				\
-	do { if (!(cond)) pad_spc(llen, 64, "[SKIPPED]\n"); else ret += expect_zr(expr, llen); } while (0)
+	do { if (!(cond)) result(llen, SKIPPED); else ret += expect_zr(expr, llen); } while (0)
 
 static int expect_zr(int expr, int llen)
 {
 	int ret = !(expr == 0);
 
 	llen += printf(" = %d ", expr);
-	pad_spc(llen, 64, ret ? "[FAIL]\n" : " [OK]\n");
+	result(llen, ret ? FAIL : OK);
 	return ret;
 }
 
 
 #define EXPECT_NZ(cond, expr, val)			\
-	do { if (!(cond)) pad_spc(llen, 64, "[SKIPPED]\n"); else ret += expect_nz(expr, llen; } while (0)
+	do { if (!(cond)) result(llen, SKIPPED); else ret += expect_nz(expr, llen; } while (0)
 
 static int expect_nz(int expr, int llen)
 {
 	int ret = !(expr != 0);
 
 	llen += printf(" = %d ", expr);
-	pad_spc(llen, 64, ret ? "[FAIL]\n" : " [OK]\n");
+	result(llen, ret ? FAIL : OK);
 	return ret;
 }
 
 
 #define EXPECT_EQ(cond, expr, val)				\
-	do { if (!(cond)) pad_spc(llen, 64, "[SKIPPED]\n"); else ret += expect_eq(expr, llen, val); } while (0)
+	do { if (!(cond)) result(llen, SKIPPED); else ret += expect_eq(expr, llen, val); } while (0)
 
 static int expect_eq(uint64_t expr, int llen, uint64_t val)
 {
 	int ret = !(expr == val);
 
 	llen += printf(" = %lld ", (long long)expr);
-	pad_spc(llen, 64, ret ? "[FAIL]\n" : " [OK]\n");
+	result(llen, ret ? FAIL : OK);
 	return ret;
 }
 
 
 #define EXPECT_NE(cond, expr, val)				\
-	do { if (!(cond)) pad_spc(llen, 64, "[SKIPPED]\n"); else ret += expect_ne(expr, llen, val); } while (0)
+	do { if (!(cond)) result(llen, SKIPPED); else ret += expect_ne(expr, llen, val); } while (0)
 
 static int expect_ne(int expr, int llen, int val)
 {
 	int ret = !(expr != val);
 
 	llen += printf(" = %d ", expr);
-	pad_spc(llen, 64, ret ? "[FAIL]\n" : " [OK]\n");
+	result(llen, ret ? FAIL : OK);
 	return ret;
 }
 
 
 #define EXPECT_GE(cond, expr, val)				\
-	do { if (!(cond)) pad_spc(llen, 64, "[SKIPPED]\n"); else ret += expect_ge(expr, llen, val); } while (0)
+	do { if (!(cond)) result(llen, SKIPPED); else ret += expect_ge(expr, llen, val); } while (0)
 
 static int expect_ge(int expr, int llen, int val)
 {
 	int ret = !(expr >= val);
 
 	llen += printf(" = %d ", expr);
-	pad_spc(llen, 64, ret ? "[FAIL]\n" : " [OK]\n");
+	result(llen, ret ? FAIL : OK);
 	return ret;
 }
 
 
 #define EXPECT_GT(cond, expr, val)				\
-	do { if (!(cond)) pad_spc(llen, 64, "[SKIPPED]\n"); else ret += expect_gt(expr, llen, val); } while (0)
+	do { if (!(cond)) result(llen, SKIPPED); else ret += expect_gt(expr, llen, val); } while (0)
 
 static int expect_gt(int expr, int llen, int val)
 {
 	int ret = !(expr > val);
 
 	llen += printf(" = %d ", expr);
-	pad_spc(llen, 64, ret ? "[FAIL]\n" : " [OK]\n");
+	result(llen, ret ? FAIL : OK);
 	return ret;
 }
 
 
 #define EXPECT_LE(cond, expr, val)				\
-	do { if (!(cond)) pad_spc(llen, 64, "[SKIPPED]\n"); else ret += expect_le(expr, llen, val); } while (0)
+	do { if (!(cond)) result(llen, SKIPPED); else ret += expect_le(expr, llen, val); } while (0)
 
 static int expect_le(int expr, int llen, int val)
 {
 	int ret = !(expr <= val);
 
 	llen += printf(" = %d ", expr);
-	pad_spc(llen, 64, ret ? "[FAIL]\n" : " [OK]\n");
+	result(llen, ret ? FAIL : OK);
 	return ret;
 }
 
 
 #define EXPECT_LT(cond, expr, val)				\
-	do { if (!(cond)) pad_spc(llen, 64, "[SKIPPED]\n"); else ret += expect_lt(expr, llen, val); } while (0)
+	do { if (!(cond)) result(llen, SKIPPED); else ret += expect_lt(expr, llen, val); } while (0)
 
 static int expect_lt(int expr, int llen, int val)
 {
 	int ret = !(expr < val);
 
 	llen += printf(" = %d ", expr);
-	pad_spc(llen, 64, ret ? "[FAIL]\n" : " [OK]\n");
+	result(llen, ret ? FAIL : OK);
 	return ret;
 }
 
 
 #define EXPECT_SYSZR(cond, expr)				\
-	do { if (!(cond)) pad_spc(llen, 64, "[SKIPPED]\n"); else ret += expect_syszr(expr, llen); } while (0)
+	do { if (!(cond)) result(llen, SKIPPED); else ret += expect_syszr(expr, llen); } while (0)
 
 static int expect_syszr(int expr, int llen)
 {
@@ -260,17 +268,17 @@ static int expect_syszr(int expr, int llen)
 	if (expr) {
 		ret = 1;
 		llen += printf(" = %d %s ", expr, errorname(errno));
-		llen += pad_spc(llen, 64, "[FAIL]\n");
+		result(llen, FAIL);
 	} else {
 		llen += printf(" = %d ", expr);
-		llen += pad_spc(llen, 64, " [OK]\n");
+		result(llen, OK);
 	}
 	return ret;
 }
 
 
 #define EXPECT_SYSEQ(cond, expr, val)				\
-	do { if (!(cond)) pad_spc(llen, 64, "[SKIPPED]\n"); else ret += expect_syseq(expr, llen, val); } while (0)
+	do { if (!(cond)) result(llen, SKIPPED); else ret += expect_syseq(expr, llen, val); } while (0)
 
 static int expect_syseq(int expr, int llen, int val)
 {
@@ -279,17 +287,17 @@ static int expect_syseq(int expr, int llen, int val)
 	if (expr != val) {
 		ret = 1;
 		llen += printf(" = %d %s ", expr, errorname(errno));
-		llen += pad_spc(llen, 64, "[FAIL]\n");
+		result(llen, FAIL);
 	} else {
 		llen += printf(" = %d ", expr);
-		llen += pad_spc(llen, 64, " [OK]\n");
+		result(llen, OK);
 	}
 	return ret;
 }
 
 
 #define EXPECT_SYSNE(cond, expr, val)				\
-	do { if (!(cond)) pad_spc(llen, 64, "[SKIPPED]\n"); else ret += expect_sysne(expr, llen, val); } while (0)
+	do { if (!(cond)) result(llen, SKIPPED); else ret += expect_sysne(expr, llen, val); } while (0)
 
 static int expect_sysne(int expr, int llen, int val)
 {
@@ -298,17 +306,17 @@ static int expect_sysne(int expr, int llen, int val)
 	if (expr == val) {
 		ret = 1;
 		llen += printf(" = %d %s ", expr, errorname(errno));
-		llen += pad_spc(llen, 64, "[FAIL]\n");
+		result(llen, FAIL);
 	} else {
 		llen += printf(" = %d ", expr);
-		llen += pad_spc(llen, 64, " [OK]\n");
+		result(llen, OK);
 	}
 	return ret;
 }
 
 
 #define EXPECT_SYSER2(cond, expr, expret, experr1, experr2)		\
-	do { if (!(cond)) pad_spc(llen, 64, "[SKIPPED]\n"); else ret += expect_syserr2(expr, expret, experr1, experr2, llen); } while (0)
+	do { if (!(cond)) result(llen, SKIPPED); else ret += expect_syserr2(expr, expret, experr1, experr2, llen); } while (0)
 
 #define EXPECT_SYSER(cond, expr, expret, experr)			\
 	EXPECT_SYSER2(cond, expr, expret, experr, 0)
@@ -325,16 +333,16 @@ static int expect_syserr2(int expr, int expret, int experr1, int experr2, int ll
 			llen += printf(" != (%d %s) ", expret, errorname(experr1));
 		else
 			llen += printf(" != (%d %s %s) ", expret, errorname(experr1), errorname(experr2));
-		llen += pad_spc(llen, 64, "[FAIL]\n");
+		result(llen, FAIL);
 	} else {
-		llen += pad_spc(llen, 64, " [OK]\n");
+		result(llen, OK);
 	}
 	return ret;
 }
 
 
 #define EXPECT_PTRZR(cond, expr)				\
-	do { if (!(cond)) pad_spc(llen, 64, "[SKIPPED]\n"); else ret += expect_ptrzr(expr, llen); } while (0)
+	do { if (!(cond)) result(llen, SKIPPED); else ret += expect_ptrzr(expr, llen); } while (0)
 
 static int expect_ptrzr(const void *expr, int llen)
 {
@@ -343,16 +351,16 @@ static int expect_ptrzr(const void *expr, int llen)
 	llen += printf(" = <%p> ", expr);
 	if (expr) {
 		ret = 1;
-		llen += pad_spc(llen, 64, "[FAIL]\n");
+		result(llen, FAIL);
 	} else {
-		llen += pad_spc(llen, 64, " [OK]\n");
+		result(llen, OK);
 	}
 	return ret;
 }
 
 
 #define EXPECT_PTRNZ(cond, expr)				\
-	do { if (!(cond)) pad_spc(llen, 64, "[SKIPPED]\n"); else ret += expect_ptrnz(expr, llen); } while (0)
+	do { if (!(cond)) result(llen, SKIPPED); else ret += expect_ptrnz(expr, llen); } while (0)
 
 static int expect_ptrnz(const void *expr, int llen)
 {
@@ -361,15 +369,15 @@ static int expect_ptrnz(const void *expr, int llen)
 	llen += printf(" = <%p> ", expr);
 	if (!expr) {
 		ret = 1;
-		llen += pad_spc(llen, 64, "[FAIL]\n");
+		result(llen, FAIL);
 	} else {
-		llen += pad_spc(llen, 64, " [OK]\n");
+		result(llen, OK);
 	}
 	return ret;
 }
 
 #define EXPECT_PTREQ(cond, expr, cmp)				\
-	do { if (!(cond)) pad_spc(llen, 64, "[SKIPPED]\n"); else ret += expect_ptreq(expr, llen, cmp); } while (0)
+	do { if (!(cond)) result(llen, SKIPPED); else ret += expect_ptreq(expr, llen, cmp); } while (0)
 
 static int expect_ptreq(const void *expr, int llen, const void *cmp)
 {
@@ -378,15 +386,15 @@ static int expect_ptreq(const void *expr, int llen, const void *cmp)
 	llen += printf(" = <%p> ", expr);
 	if (expr != cmp) {
 		ret = 1;
-		llen += pad_spc(llen, 64, "[FAIL]\n");
+		result(llen, FAIL);
 	} else {
-		llen += pad_spc(llen, 64, " [OK]\n");
+		result(llen, OK);
 	}
 	return ret;
 }
 
 #define EXPECT_PTRNE(cond, expr, cmp)				\
-	do { if (!(cond)) pad_spc(llen, 64, "[SKIPPED]\n"); else ret += expect_ptrne(expr, llen, cmp); } while (0)
+	do { if (!(cond)) result(llen, SKIPPED); else ret += expect_ptrne(expr, llen, cmp); } while (0)
 
 static int expect_ptrne(const void *expr, int llen, const void *cmp)
 {
@@ -395,15 +403,15 @@ static int expect_ptrne(const void *expr, int llen, const void *cmp)
 	llen += printf(" = <%p> ", expr);
 	if (expr == cmp) {
 		ret = 1;
-		llen += pad_spc(llen, 64, "[FAIL]\n");
+		result(llen, FAIL);
 	} else {
-		llen += pad_spc(llen, 64, " [OK]\n");
+		result(llen, OK);
 	}
 	return ret;
 }
 
 #define EXPECT_PTRER2(cond, expr, expret, experr1, experr2)		\
-	do { if (!(cond)) pad_spc(llen, 64, "[SKIPPED]\n"); else ret += expect_ptrerr2(expr, expret, experr1, experr2, llen); } while (0)
+	do { if (!(cond)) result(llen, SKIPPED); else ret += expect_ptrerr2(expr, expret, experr1, experr2, llen); } while (0)
 
 #define EXPECT_PTRER(cond, expr, expret, experr)			\
 	EXPECT_PTRER2(cond, expr, expret, experr, 0)
@@ -420,15 +428,15 @@ static int expect_ptrerr2(const void *expr, const void *expret, int experr1, int
 			llen += printf(" != (<%p> %s) ", expret, errorname(experr1));
 		else
 			llen += printf(" != (<%p> %s %s) ", expret, errorname(experr1), errorname(experr2));
-		llen += pad_spc(llen, 64, "[FAIL]\n");
+		result(llen, FAIL);
 	} else {
-		llen += pad_spc(llen, 64, " [OK]\n");
+		result(llen, OK);
 	}
 	return ret;
 }
 
 #define EXPECT_STRZR(cond, expr)				\
-	do { if (!(cond)) pad_spc(llen, 64, "[SKIPPED]\n"); else ret += expect_strzr(expr, llen); } while (0)
+	do { if (!(cond)) result(llen, SKIPPED); else ret += expect_strzr(expr, llen); } while (0)
 
 static int expect_strzr(const char *expr, int llen)
 {
@@ -437,16 +445,16 @@ static int expect_strzr(const char *expr, int llen)
 	llen += printf(" = <%s> ", expr);
 	if (expr) {
 		ret = 1;
-		llen += pad_spc(llen, 64, "[FAIL]\n");
+		result(llen, FAIL);
 	} else {
-		llen += pad_spc(llen, 64, " [OK]\n");
+		result(llen, OK);
 	}
 	return ret;
 }
 
 
 #define EXPECT_STRNZ(cond, expr)				\
-	do { if (!(cond)) pad_spc(llen, 64, "[SKIPPED]\n"); else ret += expect_strnz(expr, llen); } while (0)
+	do { if (!(cond)) result(llen, SKIPPED); else ret += expect_strnz(expr, llen); } while (0)
 
 static int expect_strnz(const char *expr, int llen)
 {
@@ -455,16 +463,16 @@ static int expect_strnz(const char *expr, int llen)
 	llen += printf(" = <%s> ", expr);
 	if (!expr) {
 		ret = 1;
-		llen += pad_spc(llen, 64, "[FAIL]\n");
+		result(llen, FAIL);
 	} else {
-		llen += pad_spc(llen, 64, " [OK]\n");
+		result(llen, OK);
 	}
 	return ret;
 }
 
 
 #define EXPECT_STREQ(cond, expr, cmp)				\
-	do { if (!(cond)) pad_spc(llen, 64, "[SKIPPED]\n"); else ret += expect_streq(expr, llen, cmp); } while (0)
+	do { if (!(cond)) result(llen, SKIPPED); else ret += expect_streq(expr, llen, cmp); } while (0)
 
 static int expect_streq(const char *expr, int llen, const char *cmp)
 {
@@ -473,16 +481,16 @@ static int expect_streq(const char *expr, int llen, const char *cmp)
 	llen += printf(" = <%s> ", expr);
 	if (strcmp(expr, cmp) != 0) {
 		ret = 1;
-		llen += pad_spc(llen, 64, "[FAIL]\n");
+		result(llen, FAIL);
 	} else {
-		llen += pad_spc(llen, 64, " [OK]\n");
+		result(llen, OK);
 	}
 	return ret;
 }
 
 
 #define EXPECT_STRNE(cond, expr, cmp)				\
-	do { if (!(cond)) pad_spc(llen, 64, "[SKIPPED]\n"); else ret += expect_strne(expr, llen, cmp); } while (0)
+	do { if (!(cond)) result(llen, SKIPPED); else ret += expect_strne(expr, llen, cmp); } while (0)
 
 static int expect_strne(const char *expr, int llen, const char *cmp)
 {
@@ -491,9 +499,9 @@ static int expect_strne(const char *expr, int llen, const char *cmp)
 	llen += printf(" = <%s> ", expr);
 	if (strcmp(expr, cmp) == 0) {
 		ret = 1;
-		llen += pad_spc(llen, 64, "[FAIL]\n");
+		result(llen, FAIL);
 	} else {
-		llen += pad_spc(llen, 64, " [OK]\n");
+		result(llen, OK);
 	}
 	return ret;
 }
@@ -879,13 +887,13 @@ static int expect_vfprintf(int llen, size_t c, const char *expected, const char
 
 	fd = open("/tmp", O_TMPFILE | O_EXCL | O_RDWR, 0600);
 	if (fd == -1) {
-		pad_spc(llen, 64, "[SKIPPED]\n");
+		result(llen, SKIPPED);
 		return 0;
 	}
 
 	memfile = fdopen(fd, "w+");
 	if (!memfile) {
-		pad_spc(llen, 64, "[FAIL]\n");
+		result(llen, FAIL);
 		return 1;
 	}
 
@@ -895,7 +903,7 @@ static int expect_vfprintf(int llen, size_t c, const char *expected, const char
 
 	if (w != c) {
 		llen += printf(" written(%d) != %d", w, (int) c);
-		pad_spc(llen, 64, "[FAIL]\n");
+		result(llen, FAIL);
 		return 1;
 	}
 
@@ -909,14 +917,14 @@ static int expect_vfprintf(int llen, size_t c, const char *expected, const char
 
 	if (r != w) {
 		llen += printf(" written(%d) != read(%d)", w, r);
-		pad_spc(llen, 64, "[FAIL]\n");
+		result(llen, FAIL);
 		return 1;
 	}
 
 	llen += printf(" \"%s\" = \"%s\"", expected, buf);
 	ret = strncmp(expected, buf, c);
 
-	pad_spc(llen, 64, ret ? "[FAIL]\n" : " [OK]\n");
+	result(llen, ret ? FAIL : OK);
 	return ret;
 }
 
@@ -972,14 +980,14 @@ static int run_protection(int min, int max)
 
 #if !defined(_NOLIBC_STACKPROTECTOR)
 	llen += printf("not supported");
-	pad_spc(llen, 64, "[SKIPPED]\n");
+	result(llen, SKIPPED);
 	return 0;
 #endif
 
 #if defined(_NOLIBC_STACKPROTECTOR)
 	if (!__stack_chk_guard) {
 		llen += printf("__stack_chk_guard not initialized");
-		pad_spc(llen, 64, "[FAIL]\n");
+		result(llen, FAIL);
 		return 1;
 	}
 #endif
@@ -990,7 +998,7 @@ static int run_protection(int min, int max)
 	switch (pid) {
 	case -1:
 		llen += printf("fork()");
-		pad_spc(llen, 64, "[FAIL]\n");
+		result(llen, FAIL);
 		return 1;
 
 	case 0:
@@ -1006,10 +1014,10 @@ static int run_protection(int min, int max)
 
 		if (pid == -1 || !WIFSIGNALED(status) || WTERMSIG(status) != SIGABRT) {
 			llen += printf("waitpid()");
-			pad_spc(llen, 64, "[FAIL]\n");
+			result(llen, FAIL);
 			return 1;
 		}
-		pad_spc(llen, 64, " [OK]\n");
+		result(llen, OK);
 		return 0;
 	}
 }

-- 
2.41.0

