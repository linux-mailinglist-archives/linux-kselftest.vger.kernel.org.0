Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5B9474EB19
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Jul 2023 11:49:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231825AbjGKJtt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 11 Jul 2023 05:49:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231553AbjGKJti (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 11 Jul 2023 05:49:38 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72294A8;
        Tue, 11 Jul 2023 02:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1689068974;
        bh=03IWGhZ8QhtZRHbntN3H9nx1jWn0im7jMDrqpZcDC9E=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=enZLzOOfdJZURIRYExyX4nKPwq7ZrcP6Uu30k8Z8FBnN5DX90an+CEoQpTtgBZ59C
         Iep6Ze5HZeB6caPqlPsg3BMNkMgxLiIqkF9u0h5BKomFfMvd91AUwIv0EjoSrvJWme
         SwemeWFdHQs/HFFbzwJHtGxZIypoDgJlcYSexLZo=
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date:   Tue, 11 Jul 2023 11:48:41 +0200
Subject: [PATCH 3/4] selftests/nolibc: simplify status argument
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230711-nolibc-sizeof-long-gaps-v1-3-dc78c3b85fc3@weissschuh.net>
References: <20230711-nolibc-sizeof-long-gaps-v1-0-dc78c3b85fc3@weissschuh.net>
In-Reply-To: <20230711-nolibc-sizeof-long-gaps-v1-0-dc78c3b85fc3@weissschuh.net>
To:     Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zhangjin Wu <falcon@tinylab.org>,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1689068953; l=8351;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=03IWGhZ8QhtZRHbntN3H9nx1jWn0im7jMDrqpZcDC9E=;
 b=GDj2A6NCENuF5duP+jAGRG273sGNnZpRTvbg/ryTcxFqm04Xf1W6x1W3XHtf6GRUuicM5bhWG
 a9hhDUb2lShA0D4j1P1LaZGu6iLgm3Gp4f/B6EF7zDxSoDNUi0UX71I
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

I'm not sure if this is an improvement over the previous patch.
If so it should be squashed into it.

Not-Signed-off-by
---
 tools/testing/selftests/nolibc/nolibc-test.c | 115 ++++++++++-----------------
 1 file changed, 40 insertions(+), 75 deletions(-)

diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index b7ed10512d67..754815c142f6 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -127,17 +127,13 @@ static void putcharn(char c, size_t n)
 	fputs(buf, stdout);
 }
 
-enum RESULT {
-	OK,
-	FAIL,
-	SKIPPED,
-};
+#define SKIPPED INT_MIN
 
-static void result(int llen, enum RESULT r)
+static void result(int llen, int r)
 {
 	const char *msg;
 
-	if (r == OK)
+	if (r == 0)
 		msg = " [OK]";
 	else if (r == SKIPPED)
 		msg = "[SKIPPED]";
@@ -162,7 +158,7 @@ static int expect_zr(int expr, int llen)
 	int ret = !(expr == 0);
 
 	llen += printf(" = %d ", expr);
-	result(llen, ret ? FAIL : OK);
+	result(llen, ret);
 	return ret;
 }
 
@@ -175,7 +171,7 @@ static int expect_nz(int expr, int llen)
 	int ret = !(expr != 0);
 
 	llen += printf(" = %d ", expr);
-	result(llen, ret ? FAIL : OK);
+	result(llen, ret);
 	return ret;
 }
 
@@ -188,7 +184,7 @@ static int expect_eq(uint64_t expr, int llen, uint64_t val)
 	int ret = !(expr == val);
 
 	llen += printf(" = %lld ", (long long)expr);
-	result(llen, ret ? FAIL : OK);
+	result(llen, ret);
 	return ret;
 }
 
@@ -201,7 +197,7 @@ static int expect_ne(int expr, int llen, int val)
 	int ret = !(expr != val);
 
 	llen += printf(" = %d ", expr);
-	result(llen, ret ? FAIL : OK);
+	result(llen, ret);
 	return ret;
 }
 
@@ -214,7 +210,7 @@ static int expect_ge(int expr, int llen, int val)
 	int ret = !(expr >= val);
 
 	llen += printf(" = %d ", expr);
-	result(llen, ret ? FAIL : OK);
+	result(llen, ret);
 	return ret;
 }
 
@@ -227,7 +223,7 @@ static int expect_gt(int expr, int llen, int val)
 	int ret = !(expr > val);
 
 	llen += printf(" = %d ", expr);
-	result(llen, ret ? FAIL : OK);
+	result(llen, ret);
 	return ret;
 }
 
@@ -240,7 +236,7 @@ static int expect_le(int expr, int llen, int val)
 	int ret = !(expr <= val);
 
 	llen += printf(" = %d ", expr);
-	result(llen, ret ? FAIL : OK);
+	result(llen, ret);
 	return ret;
 }
 
@@ -253,7 +249,7 @@ static int expect_lt(int expr, int llen, int val)
 	int ret = !(expr < val);
 
 	llen += printf(" = %d ", expr);
-	result(llen, ret ? FAIL : OK);
+	result(llen, ret);
 	return ret;
 }
 
@@ -268,11 +264,10 @@ static int expect_syszr(int expr, int llen)
 	if (expr) {
 		ret = 1;
 		llen += printf(" = %d %s ", expr, errorname(errno));
-		result(llen, FAIL);
 	} else {
 		llen += printf(" = %d ", expr);
-		result(llen, OK);
 	}
+	result(llen, ret);
 	return ret;
 }
 
@@ -287,11 +282,10 @@ static int expect_syseq(int expr, int llen, int val)
 	if (expr != val) {
 		ret = 1;
 		llen += printf(" = %d %s ", expr, errorname(errno));
-		result(llen, FAIL);
 	} else {
 		llen += printf(" = %d ", expr);
-		result(llen, OK);
 	}
+	result(llen, ret);
 	return ret;
 }
 
@@ -306,11 +300,10 @@ static int expect_sysne(int expr, int llen, int val)
 	if (expr == val) {
 		ret = 1;
 		llen += printf(" = %d %s ", expr, errorname(errno));
-		result(llen, FAIL);
 	} else {
 		llen += printf(" = %d ", expr);
-		result(llen, OK);
 	}
+	result(llen, ret);
 	return ret;
 }
 
@@ -333,10 +326,8 @@ static int expect_syserr2(int expr, int expret, int experr1, int experr2, int ll
 			llen += printf(" != (%d %s) ", expret, errorname(experr1));
 		else
 			llen += printf(" != (%d %s %s) ", expret, errorname(experr1), errorname(experr2));
-		result(llen, FAIL);
-	} else {
-		result(llen, OK);
 	}
+	result(llen, ret);
 	return ret;
 }
 
@@ -349,12 +340,9 @@ static int expect_ptrzr(const void *expr, int llen)
 	int ret = 0;
 
 	llen += printf(" = <%p> ", expr);
-	if (expr) {
+	if (expr)
 		ret = 1;
-		result(llen, FAIL);
-	} else {
-		result(llen, OK);
-	}
+	result(llen, ret);
 	return ret;
 }
 
@@ -367,12 +355,9 @@ static int expect_ptrnz(const void *expr, int llen)
 	int ret = 0;
 
 	llen += printf(" = <%p> ", expr);
-	if (!expr) {
+	if (!expr)
 		ret = 1;
-		result(llen, FAIL);
-	} else {
-		result(llen, OK);
-	}
+	result(llen, ret);
 	return ret;
 }
 
@@ -384,12 +369,9 @@ static int expect_ptreq(const void *expr, int llen, const void *cmp)
 	int ret = 0;
 
 	llen += printf(" = <%p> ", expr);
-	if (expr != cmp) {
+	if (expr != cmp)
 		ret = 1;
-		result(llen, FAIL);
-	} else {
-		result(llen, OK);
-	}
+	result(llen, ret);
 	return ret;
 }
 
@@ -401,12 +383,9 @@ static int expect_ptrne(const void *expr, int llen, const void *cmp)
 	int ret = 0;
 
 	llen += printf(" = <%p> ", expr);
-	if (expr == cmp) {
+	if (expr == cmp)
 		ret = 1;
-		result(llen, FAIL);
-	} else {
-		result(llen, OK);
-	}
+	result(llen, ret);
 	return ret;
 }
 
@@ -428,10 +407,8 @@ static int expect_ptrerr2(const void *expr, const void *expret, int experr1, int
 			llen += printf(" != (<%p> %s) ", expret, errorname(experr1));
 		else
 			llen += printf(" != (<%p> %s %s) ", expret, errorname(experr1), errorname(experr2));
-		result(llen, FAIL);
-	} else {
-		result(llen, OK);
 	}
+	result(llen, ret);
 	return ret;
 }
 
@@ -443,12 +420,9 @@ static int expect_strzr(const char *expr, int llen)
 	int ret = 0;
 
 	llen += printf(" = <%s> ", expr);
-	if (expr) {
+	if (expr)
 		ret = 1;
-		result(llen, FAIL);
-	} else {
-		result(llen, OK);
-	}
+	result(llen, ret);
 	return ret;
 }
 
@@ -461,12 +435,9 @@ static int expect_strnz(const char *expr, int llen)
 	int ret = 0;
 
 	llen += printf(" = <%s> ", expr);
-	if (!expr) {
+	if (!expr)
 		ret = 1;
-		result(llen, FAIL);
-	} else {
-		result(llen, OK);
-	}
+	result(llen, ret);
 	return ret;
 }
 
@@ -479,12 +450,9 @@ static int expect_streq(const char *expr, int llen, const char *cmp)
 	int ret = 0;
 
 	llen += printf(" = <%s> ", expr);
-	if (strcmp(expr, cmp) != 0) {
+	if (strcmp(expr, cmp) != 0)
 		ret = 1;
-		result(llen, FAIL);
-	} else {
-		result(llen, OK);
-	}
+	result(llen, ret);
 	return ret;
 }
 
@@ -497,12 +465,9 @@ static int expect_strne(const char *expr, int llen, const char *cmp)
 	int ret = 0;
 
 	llen += printf(" = <%s> ", expr);
-	if (strcmp(expr, cmp) == 0) {
+	if (strcmp(expr, cmp) == 0)
 		ret = 1;
-		result(llen, FAIL);
-	} else {
-		result(llen, OK);
-	}
+	result(llen, ret);
 	return ret;
 }
 
@@ -893,7 +858,7 @@ static int expect_vfprintf(int llen, size_t c, const char *expected, const char
 
 	memfile = fdopen(fd, "w+");
 	if (!memfile) {
-		result(llen, FAIL);
+		result(llen, 1);
 		return 1;
 	}
 
@@ -903,7 +868,7 @@ static int expect_vfprintf(int llen, size_t c, const char *expected, const char
 
 	if (w != c) {
 		llen += printf(" written(%d) != %d", w, (int) c);
-		result(llen, FAIL);
+		result(llen, 1);
 		return 1;
 	}
 
@@ -917,14 +882,14 @@ static int expect_vfprintf(int llen, size_t c, const char *expected, const char
 
 	if (r != w) {
 		llen += printf(" written(%d) != read(%d)", w, r);
-		result(llen, FAIL);
+		result(llen, 1);
 		return 1;
 	}
 
 	llen += printf(" \"%s\" = \"%s\"", expected, buf);
 	ret = strncmp(expected, buf, c);
 
-	result(llen, ret ? FAIL : OK);
+	result(llen, ret);
 	return ret;
 }
 
@@ -987,7 +952,7 @@ static int run_protection(int min, int max)
 #if defined(_NOLIBC_STACKPROTECTOR)
 	if (!__stack_chk_guard) {
 		llen += printf("__stack_chk_guard not initialized");
-		result(llen, FAIL);
+		result(llen, 1);
 		return 1;
 	}
 #endif
@@ -998,7 +963,7 @@ static int run_protection(int min, int max)
 	switch (pid) {
 	case -1:
 		llen += printf("fork()");
-		result(llen, FAIL);
+		result(llen, 1);
 		return 1;
 
 	case 0:
@@ -1014,10 +979,10 @@ static int run_protection(int min, int max)
 
 		if (pid == -1 || !WIFSIGNALED(status) || WTERMSIG(status) != SIGABRT) {
 			llen += printf("waitpid()");
-			result(llen, FAIL);
+			result(llen, 1);
 			return 1;
 		}
-		result(llen, OK);
+		result(llen, 0);
 		return 0;
 	}
 }

-- 
2.41.0

