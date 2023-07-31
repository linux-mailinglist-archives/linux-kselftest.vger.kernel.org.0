Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 635F1768BFE
	for <lists+linux-kselftest@lfdr.de>; Mon, 31 Jul 2023 08:27:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229500AbjGaG1E (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 31 Jul 2023 02:27:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230209AbjGaG1D (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 31 Jul 2023 02:27:03 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1BCBE57;
        Sun, 30 Jul 2023 23:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1690784818;
        bh=ZTNcL4vPTjZ60aMHUaWTT+59KbRfzXeF9WrWuByRCEI=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=ruZdxOu/eS/x3/+CLg+xzeVSY2IKEkodIm3Pz6b0M9r99xWRNWQ1b7JQModhN6Cva
         h0NrlgrkRBYe4gHBmoidnteUOzwfqYVHWgj416iB6EfxPLmD0QsCAe00gtbdC0OaqC
         Q2GG9bcZOu/a8ttRKlKnvzcJZDSn/B/bamdymzPQ=
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date:   Mon, 31 Jul 2023 08:26:56 +0200
Subject: [PATCH 1/4] selftests/nolibc: drop unused test helpers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230731-nolibc-warnings-v1-1-74973d2a52d7@weissschuh.net>
References: <20230731-nolibc-warnings-v1-0-74973d2a52d7@weissschuh.net>
In-Reply-To: <20230731-nolibc-warnings-v1-0-74973d2a52d7@weissschuh.net>
To:     Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yuan Tan <tanyuan@tinylab.org>,
        Zhangjin Wu <falcon@tinylab.org>,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1690784818; l=4552;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=ZTNcL4vPTjZ60aMHUaWTT+59KbRfzXeF9WrWuByRCEI=;
 b=t3OE1zDz2rqRRHzMsf9yzWP9Si7c7FBETEnjLOpezbzOQsTduTB7DDKYWmO1G4ASQJsw01jK+
 RA17MHV1rFtAjjTQeUJU26jwDOzHkSRSu+ECvk0XAnv6Y3p1FbDRaQ2
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

As we want to enable compiler warnings in the future these would be
reported as unused functions.

If we need them in the future they are easy to recreate from their still
existing siblings.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/testing/selftests/nolibc/nolibc-test.c | 99 ----------------------------
 1 file changed, 99 deletions(-)

diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index 03b1d30f5507..53e2d448eded 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -161,31 +161,6 @@ static void result(int llen, enum RESULT r)
  * of failures, thus either 0 or 1.
  */
 
-#define EXPECT_ZR(cond, expr)				\
-	do { if (!(cond)) result(llen, SKIPPED); else ret += expect_zr(expr, llen); } while (0)
-
-static int expect_zr(int expr, int llen)
-{
-	int ret = !(expr == 0);
-
-	llen += printf(" = %d ", expr);
-	result(llen, ret ? FAIL : OK);
-	return ret;
-}
-
-
-#define EXPECT_NZ(cond, expr, val)			\
-	do { if (!(cond)) result(llen, SKIPPED); else ret += expect_nz(expr, llen; } while (0)
-
-static int expect_nz(int expr, int llen)
-{
-	int ret = !(expr != 0);
-
-	llen += printf(" = %d ", expr);
-	result(llen, ret ? FAIL : OK);
-	return ret;
-}
-
 
 #define EXPECT_EQ(cond, expr, val)				\
 	do { if (!(cond)) result(llen, SKIPPED); else ret += expect_eq(expr, llen, val); } while (0)
@@ -239,19 +214,6 @@ static int expect_gt(int expr, int llen, int val)
 }
 
 
-#define EXPECT_LE(cond, expr, val)				\
-	do { if (!(cond)) result(llen, SKIPPED); else ret += expect_le(expr, llen, val); } while (0)
-
-static int expect_le(int expr, int llen, int val)
-{
-	int ret = !(expr <= val);
-
-	llen += printf(" = %d ", expr);
-	result(llen, ret ? FAIL : OK);
-	return ret;
-}
-
-
 #define EXPECT_LT(cond, expr, val)				\
 	do { if (!(cond)) result(llen, SKIPPED); else ret += expect_lt(expr, llen, val); } while (0)
 
@@ -348,24 +310,6 @@ static int expect_syserr2(int expr, int expret, int experr1, int experr2, int ll
 }
 
 
-#define EXPECT_PTRZR(cond, expr)				\
-	do { if (!(cond)) result(llen, SKIPPED); else ret += expect_ptrzr(expr, llen); } while (0)
-
-static int expect_ptrzr(const void *expr, int llen)
-{
-	int ret = 0;
-
-	llen += printf(" = <%p> ", expr);
-	if (expr) {
-		ret = 1;
-		result(llen, FAIL);
-	} else {
-		result(llen, OK);
-	}
-	return ret;
-}
-
-
 #define EXPECT_PTRNZ(cond, expr)				\
 	do { if (!(cond)) result(llen, SKIPPED); else ret += expect_ptrnz(expr, llen); } while (0)
 
@@ -417,18 +361,6 @@ static int expect_ptrne(const void *expr, int llen, const void *cmp)
 	return ret;
 }
 
-#define EXPECT_PTRGE(cond, expr, cmp)				\
-	do { if (!(cond)) result(llen, SKIPPED); else ret += expect_ptrge(expr, llen, cmp); } while (0)
-
-static int expect_ptrge(const void *expr, int llen, const void *cmp)
-{
-	int ret = !(expr >= cmp);
-
-	llen += printf(" = <%p> ", expr);
-	result(llen, ret ? FAIL : OK);
-	return ret;
-}
-
 #define EXPECT_PTRGT(cond, expr, cmp)				\
 	do { if (!(cond)) result(llen, SKIPPED); else ret += expect_ptrgt(expr, llen, cmp); } while (0)
 
@@ -442,19 +374,6 @@ static int expect_ptrgt(const void *expr, int llen, const void *cmp)
 }
 
 
-#define EXPECT_PTRLE(cond, expr, cmp)				\
-	do { if (!(cond)) result(llen, SKIPPED); else ret += expect_ptrle(expr, llen, cmp); } while (0)
-
-static int expect_ptrle(const void *expr, int llen, const void *cmp)
-{
-	int ret = !(expr <= cmp);
-
-	llen += printf(" = <%p> ", expr);
-	result(llen, ret ? FAIL : OK);
-	return ret;
-}
-
-
 #define EXPECT_PTRLT(cond, expr, cmp)				\
 	do { if (!(cond)) result(llen, SKIPPED); else ret += expect_ptrlt(expr, llen, cmp); } while (0)
 
@@ -546,24 +465,6 @@ static int expect_streq(const char *expr, int llen, const char *cmp)
 }
 
 
-#define EXPECT_STRNE(cond, expr, cmp)				\
-	do { if (!(cond)) result(llen, SKIPPED); else ret += expect_strne(expr, llen, cmp); } while (0)
-
-static int expect_strne(const char *expr, int llen, const char *cmp)
-{
-	int ret = 0;
-
-	llen += printf(" = <%s> ", expr);
-	if (strcmp(expr, cmp) == 0) {
-		ret = 1;
-		result(llen, FAIL);
-	} else {
-		result(llen, OK);
-	}
-	return ret;
-}
-
-
 /* declare tests based on line numbers. There must be exactly one test per line. */
 #define CASE_TEST(name) \
 	case __LINE__: llen += printf("%d %s", test, #name);

-- 
2.41.0

