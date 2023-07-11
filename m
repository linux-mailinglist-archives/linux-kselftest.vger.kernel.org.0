Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C94EA74EB1E
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Jul 2023 11:49:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232192AbjGKJtw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 11 Jul 2023 05:49:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231558AbjGKJtj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 11 Jul 2023 05:49:39 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA627CE;
        Tue, 11 Jul 2023 02:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1689068974;
        bh=I1822N+UF+jAkDVQCrbQ8SL5nFp5rcCn28BvKolp1T0=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=K1wwGeeiZLUuLz5EfSTlgeD9okS63NQoo1Tkqi1sQK+cf4c8HB3Rt4GStYqZxNHco
         j0iRPgWFTRpuqwOKAjwQCrz2RGNChL5o4A0qx+etal8HxRobDGwTBLStTg55g3tWq6
         3u+2jD06VpeTYxIVe0mXJqg3F5z8N96ZobUSwv5Q=
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date:   Tue, 11 Jul 2023 11:48:39 +0200
Subject: [PATCH 1/4] selftests/nolibc: make evaluation of test conditions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230711-nolibc-sizeof-long-gaps-v1-1-dc78c3b85fc3@weissschuh.net>
References: <20230711-nolibc-sizeof-long-gaps-v1-0-dc78c3b85fc3@weissschuh.net>
In-Reply-To: <20230711-nolibc-sizeof-long-gaps-v1-0-dc78c3b85fc3@weissschuh.net>
To:     Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zhangjin Wu <falcon@tinylab.org>,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1689068953; l=9411;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=I1822N+UF+jAkDVQCrbQ8SL5nFp5rcCn28BvKolp1T0=;
 b=36egk9Q28laXJBW735eeY0D8ibWEWySVagip/C12PtxgH5iGGQ3nuqnyRTaT/PRjT7fhCwjw7
 3awFzQGKK7hDZr1s1igHthGfEgjUkmV0Ti+U2xaBfo3EGSuC2YTZ4Wn
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

If "cond" is a multi-token statement the behavior of the preprocessor
will lead to the negation "!" to be only applied to the first token.
Although currently no test uses such multi-token conditions but it can
happen at any time.

Put braces around "cond" to ensure the negation works as expected.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/testing/selftests/nolibc/nolibc-test.c | 42 ++++++++++++++--------------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index f357bd815abc..c252ea0c2f01 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -147,7 +147,7 @@ static int pad_spc(int llen, int cnt, const char *fmt, ...)
  */
 
 #define EXPECT_ZR(cond, expr)				\
-	do { if (!cond) pad_spc(llen, 64, "[SKIPPED]\n"); else ret += expect_zr(expr, llen); } while (0)
+	do { if (!(cond)) pad_spc(llen, 64, "[SKIPPED]\n"); else ret += expect_zr(expr, llen); } while (0)
 
 static int expect_zr(int expr, int llen)
 {
@@ -160,7 +160,7 @@ static int expect_zr(int expr, int llen)
 
 
 #define EXPECT_NZ(cond, expr, val)			\
-	do { if (!cond) pad_spc(llen, 64, "[SKIPPED]\n"); else ret += expect_nz(expr, llen; } while (0)
+	do { if (!(cond)) pad_spc(llen, 64, "[SKIPPED]\n"); else ret += expect_nz(expr, llen; } while (0)
 
 static int expect_nz(int expr, int llen)
 {
@@ -173,7 +173,7 @@ static int expect_nz(int expr, int llen)
 
 
 #define EXPECT_EQ(cond, expr, val)				\
-	do { if (!cond) pad_spc(llen, 64, "[SKIPPED]\n"); else ret += expect_eq(expr, llen, val); } while (0)
+	do { if (!(cond)) pad_spc(llen, 64, "[SKIPPED]\n"); else ret += expect_eq(expr, llen, val); } while (0)
 
 static int expect_eq(uint64_t expr, int llen, uint64_t val)
 {
@@ -186,7 +186,7 @@ static int expect_eq(uint64_t expr, int llen, uint64_t val)
 
 
 #define EXPECT_NE(cond, expr, val)				\
-	do { if (!cond) pad_spc(llen, 64, "[SKIPPED]\n"); else ret += expect_ne(expr, llen, val); } while (0)
+	do { if (!(cond)) pad_spc(llen, 64, "[SKIPPED]\n"); else ret += expect_ne(expr, llen, val); } while (0)
 
 static int expect_ne(int expr, int llen, int val)
 {
@@ -199,7 +199,7 @@ static int expect_ne(int expr, int llen, int val)
 
 
 #define EXPECT_GE(cond, expr, val)				\
-	do { if (!cond) pad_spc(llen, 64, "[SKIPPED]\n"); else ret += expect_ge(expr, llen, val); } while (0)
+	do { if (!(cond)) pad_spc(llen, 64, "[SKIPPED]\n"); else ret += expect_ge(expr, llen, val); } while (0)
 
 static int expect_ge(int expr, int llen, int val)
 {
@@ -212,7 +212,7 @@ static int expect_ge(int expr, int llen, int val)
 
 
 #define EXPECT_GT(cond, expr, val)				\
-	do { if (!cond) pad_spc(llen, 64, "[SKIPPED]\n"); else ret += expect_gt(expr, llen, val); } while (0)
+	do { if (!(cond)) pad_spc(llen, 64, "[SKIPPED]\n"); else ret += expect_gt(expr, llen, val); } while (0)
 
 static int expect_gt(int expr, int llen, int val)
 {
@@ -225,7 +225,7 @@ static int expect_gt(int expr, int llen, int val)
 
 
 #define EXPECT_LE(cond, expr, val)				\
-	do { if (!cond) pad_spc(llen, 64, "[SKIPPED]\n"); else ret += expect_le(expr, llen, val); } while (0)
+	do { if (!(cond)) pad_spc(llen, 64, "[SKIPPED]\n"); else ret += expect_le(expr, llen, val); } while (0)
 
 static int expect_le(int expr, int llen, int val)
 {
@@ -238,7 +238,7 @@ static int expect_le(int expr, int llen, int val)
 
 
 #define EXPECT_LT(cond, expr, val)				\
-	do { if (!cond) pad_spc(llen, 64, "[SKIPPED]\n"); else ret += expect_lt(expr, llen, val); } while (0)
+	do { if (!(cond)) pad_spc(llen, 64, "[SKIPPED]\n"); else ret += expect_lt(expr, llen, val); } while (0)
 
 static int expect_lt(int expr, int llen, int val)
 {
@@ -251,7 +251,7 @@ static int expect_lt(int expr, int llen, int val)
 
 
 #define EXPECT_SYSZR(cond, expr)				\
-	do { if (!cond) pad_spc(llen, 64, "[SKIPPED]\n"); else ret += expect_syszr(expr, llen); } while (0)
+	do { if (!(cond)) pad_spc(llen, 64, "[SKIPPED]\n"); else ret += expect_syszr(expr, llen); } while (0)
 
 static int expect_syszr(int expr, int llen)
 {
@@ -270,7 +270,7 @@ static int expect_syszr(int expr, int llen)
 
 
 #define EXPECT_SYSEQ(cond, expr, val)				\
-	do { if (!cond) pad_spc(llen, 64, "[SKIPPED]\n"); else ret += expect_syseq(expr, llen, val); } while (0)
+	do { if (!(cond)) pad_spc(llen, 64, "[SKIPPED]\n"); else ret += expect_syseq(expr, llen, val); } while (0)
 
 static int expect_syseq(int expr, int llen, int val)
 {
@@ -289,7 +289,7 @@ static int expect_syseq(int expr, int llen, int val)
 
 
 #define EXPECT_SYSNE(cond, expr, val)				\
-	do { if (!cond) pad_spc(llen, 64, "[SKIPPED]\n"); else ret += expect_sysne(expr, llen, val); } while (0)
+	do { if (!(cond)) pad_spc(llen, 64, "[SKIPPED]\n"); else ret += expect_sysne(expr, llen, val); } while (0)
 
 static int expect_sysne(int expr, int llen, int val)
 {
@@ -308,7 +308,7 @@ static int expect_sysne(int expr, int llen, int val)
 
 
 #define EXPECT_SYSER2(cond, expr, expret, experr1, experr2)		\
-	do { if (!cond) pad_spc(llen, 64, "[SKIPPED]\n"); else ret += expect_syserr2(expr, expret, experr1, experr2, llen); } while (0)
+	do { if (!(cond)) pad_spc(llen, 64, "[SKIPPED]\n"); else ret += expect_syserr2(expr, expret, experr1, experr2, llen); } while (0)
 
 #define EXPECT_SYSER(cond, expr, expret, experr)			\
 	EXPECT_SYSER2(cond, expr, expret, experr, 0)
@@ -334,7 +334,7 @@ static int expect_syserr2(int expr, int expret, int experr1, int experr2, int ll
 
 
 #define EXPECT_PTRZR(cond, expr)				\
-	do { if (!cond) pad_spc(llen, 64, "[SKIPPED]\n"); else ret += expect_ptrzr(expr, llen); } while (0)
+	do { if (!(cond)) pad_spc(llen, 64, "[SKIPPED]\n"); else ret += expect_ptrzr(expr, llen); } while (0)
 
 static int expect_ptrzr(const void *expr, int llen)
 {
@@ -352,7 +352,7 @@ static int expect_ptrzr(const void *expr, int llen)
 
 
 #define EXPECT_PTRNZ(cond, expr)				\
-	do { if (!cond) pad_spc(llen, 64, "[SKIPPED]\n"); else ret += expect_ptrnz(expr, llen); } while (0)
+	do { if (!(cond)) pad_spc(llen, 64, "[SKIPPED]\n"); else ret += expect_ptrnz(expr, llen); } while (0)
 
 static int expect_ptrnz(const void *expr, int llen)
 {
@@ -369,7 +369,7 @@ static int expect_ptrnz(const void *expr, int llen)
 }
 
 #define EXPECT_PTREQ(cond, expr, cmp)				\
-	do { if (!cond) pad_spc(llen, 64, "[SKIPPED]\n"); else ret += expect_ptreq(expr, llen, cmp); } while (0)
+	do { if (!(cond)) pad_spc(llen, 64, "[SKIPPED]\n"); else ret += expect_ptreq(expr, llen, cmp); } while (0)
 
 static int expect_ptreq(const void *expr, int llen, const void *cmp)
 {
@@ -386,7 +386,7 @@ static int expect_ptreq(const void *expr, int llen, const void *cmp)
 }
 
 #define EXPECT_PTRNE(cond, expr, cmp)				\
-	do { if (!cond) pad_spc(llen, 64, "[SKIPPED]\n"); else ret += expect_ptrne(expr, llen, cmp); } while (0)
+	do { if (!(cond)) pad_spc(llen, 64, "[SKIPPED]\n"); else ret += expect_ptrne(expr, llen, cmp); } while (0)
 
 static int expect_ptrne(const void *expr, int llen, const void *cmp)
 {
@@ -403,7 +403,7 @@ static int expect_ptrne(const void *expr, int llen, const void *cmp)
 }
 
 #define EXPECT_PTRER2(cond, expr, expret, experr1, experr2)		\
-	do { if (!cond) pad_spc(llen, 64, "[SKIPPED]\n"); else ret += expect_ptrerr2(expr, expret, experr1, experr2, llen); } while (0)
+	do { if (!(cond)) pad_spc(llen, 64, "[SKIPPED]\n"); else ret += expect_ptrerr2(expr, expret, experr1, experr2, llen); } while (0)
 
 #define EXPECT_PTRER(cond, expr, expret, experr)			\
 	EXPECT_PTRER2(cond, expr, expret, experr, 0)
@@ -428,7 +428,7 @@ static int expect_ptrerr2(const void *expr, const void *expret, int experr1, int
 }
 
 #define EXPECT_STRZR(cond, expr)				\
-	do { if (!cond) pad_spc(llen, 64, "[SKIPPED]\n"); else ret += expect_strzr(expr, llen); } while (0)
+	do { if (!(cond)) pad_spc(llen, 64, "[SKIPPED]\n"); else ret += expect_strzr(expr, llen); } while (0)
 
 static int expect_strzr(const char *expr, int llen)
 {
@@ -446,7 +446,7 @@ static int expect_strzr(const char *expr, int llen)
 
 
 #define EXPECT_STRNZ(cond, expr)				\
-	do { if (!cond) pad_spc(llen, 64, "[SKIPPED]\n"); else ret += expect_strnz(expr, llen); } while (0)
+	do { if (!(cond)) pad_spc(llen, 64, "[SKIPPED]\n"); else ret += expect_strnz(expr, llen); } while (0)
 
 static int expect_strnz(const char *expr, int llen)
 {
@@ -464,7 +464,7 @@ static int expect_strnz(const char *expr, int llen)
 
 
 #define EXPECT_STREQ(cond, expr, cmp)				\
-	do { if (!cond) pad_spc(llen, 64, "[SKIPPED]\n"); else ret += expect_streq(expr, llen, cmp); } while (0)
+	do { if (!(cond)) pad_spc(llen, 64, "[SKIPPED]\n"); else ret += expect_streq(expr, llen, cmp); } while (0)
 
 static int expect_streq(const char *expr, int llen, const char *cmp)
 {
@@ -482,7 +482,7 @@ static int expect_streq(const char *expr, int llen, const char *cmp)
 
 
 #define EXPECT_STRNE(cond, expr, cmp)				\
-	do { if (!cond) pad_spc(llen, 64, "[SKIPPED]\n"); else ret += expect_strne(expr, llen, cmp); } while (0)
+	do { if (!(cond)) pad_spc(llen, 64, "[SKIPPED]\n"); else ret += expect_strne(expr, llen, cmp); } while (0)
 
 static int expect_strne(const char *expr, int llen, const char *cmp)
 {

-- 
2.41.0

