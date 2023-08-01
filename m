Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32C7176A84C
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Aug 2023 07:30:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230260AbjHAFa3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 1 Aug 2023 01:30:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230204AbjHAFaZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 1 Aug 2023 01:30:25 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBDF41FC9;
        Mon, 31 Jul 2023 22:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1690867813;
        bh=t0qk+AwJl3e2iYM6YfPN4zCJ2i2DkKFX7aAcqHYG5aA=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=WFrragxd5fLMtRVUxOPQ/n6rmX73PLARLJYW9GdmtaAnXAhlESunZamp8M3cUXor3
         A6NMBubKMopQhR7bbx5ggJCGtwwEB9MZb1Hj0j6wx/twdEfhU7eXy85u5fne+NZlu9
         GTuIEI4fOS584zki+fR/9vtQyTIlhEQdR3DJ39cQ=
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date:   Tue, 01 Aug 2023 07:30:12 +0200
Subject: [PATCH v2 05/10] selftests/nolibc: mark test helpers as
 potentially unused
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230801-nolibc-warnings-v2-5-1ba5ca57bd9b@weissschuh.net>
References: <20230801-nolibc-warnings-v2-0-1ba5ca57bd9b@weissschuh.net>
In-Reply-To: <20230801-nolibc-warnings-v2-0-1ba5ca57bd9b@weissschuh.net>
To:     Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yuan Tan <tanyuan@tinylab.org>,
        Zhangjin Wu <falcon@tinylab.org>,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1690867811; l=10728;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=t0qk+AwJl3e2iYM6YfPN4zCJ2i2DkKFX7aAcqHYG5aA=;
 b=At9i11TsxMuGKJoH9+QjkI+INCTwFKJ0R3w/+/5KqKD2gt74Q9anxUpepv72jzpom7vZBXf0C
 o6GV9FAuRARBlaxz+ZQQLT2uo8JGOGXvPoqlEW7JWvrEXqpDzA+sk85
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_HELO_TEMPERROR,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

When warning about unused functions these would be reported by we want
to keep them for future use.

Suggested-by: Zhangjin Wu <falcon@tinylab.org>
Link: https://lore.kernel.org/lkml/20230731064826.16584-1-falcon@tinylab.org/
Suggested-by: Willy Tarreau <w@1wt.eu>
Link: https://lore.kernel.org/lkml/20230731224929.GA18296@1wt.eu/
Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/testing/selftests/nolibc/nolibc-test.c | 75 ++++++++++++++++++----------
 1 file changed, 50 insertions(+), 25 deletions(-)

diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index 9a5a212ea55c..1555759bb164 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -164,7 +164,8 @@ static void result(int llen, enum RESULT r)
 #define EXPECT_ZR(cond, expr)				\
 	do { if (!(cond)) result(llen, SKIPPED); else ret += expect_zr(expr, llen); } while (0)
 
-static int expect_zr(int expr, int llen)
+static __attribute__((unused))
+int expect_zr(int expr, int llen)
 {
 	int ret = !(expr == 0);
 
@@ -177,7 +178,8 @@ static int expect_zr(int expr, int llen)
 #define EXPECT_NZ(cond, expr, val)			\
 	do { if (!(cond)) result(llen, SKIPPED); else ret += expect_nz(expr, llen; } while (0)
 
-static int expect_nz(int expr, int llen)
+static __attribute__((unused))
+int expect_nz(int expr, int llen)
 {
 	int ret = !(expr != 0);
 
@@ -190,7 +192,8 @@ static int expect_nz(int expr, int llen)
 #define EXPECT_EQ(cond, expr, val)				\
 	do { if (!(cond)) result(llen, SKIPPED); else ret += expect_eq(expr, llen, val); } while (0)
 
-static int expect_eq(uint64_t expr, int llen, uint64_t val)
+static __attribute__((unused))
+int expect_eq(uint64_t expr, int llen, uint64_t val)
 {
 	int ret = !(expr == val);
 
@@ -203,7 +206,8 @@ static int expect_eq(uint64_t expr, int llen, uint64_t val)
 #define EXPECT_NE(cond, expr, val)				\
 	do { if (!(cond)) result(llen, SKIPPED); else ret += expect_ne(expr, llen, val); } while (0)
 
-static int expect_ne(int expr, int llen, int val)
+static __attribute__((unused))
+int expect_ne(int expr, int llen, int val)
 {
 	int ret = !(expr != val);
 
@@ -216,7 +220,8 @@ static int expect_ne(int expr, int llen, int val)
 #define EXPECT_GE(cond, expr, val)				\
 	do { if (!(cond)) result(llen, SKIPPED); else ret += expect_ge(expr, llen, val); } while (0)
 
-static int expect_ge(int expr, int llen, int val)
+static __attribute__((unused))
+int expect_ge(int expr, int llen, int val)
 {
 	int ret = !(expr >= val);
 
@@ -229,7 +234,8 @@ static int expect_ge(int expr, int llen, int val)
 #define EXPECT_GT(cond, expr, val)				\
 	do { if (!(cond)) result(llen, SKIPPED); else ret += expect_gt(expr, llen, val); } while (0)
 
-static int expect_gt(int expr, int llen, int val)
+static __attribute__((unused))
+int expect_gt(int expr, int llen, int val)
 {
 	int ret = !(expr > val);
 
@@ -242,7 +248,8 @@ static int expect_gt(int expr, int llen, int val)
 #define EXPECT_LE(cond, expr, val)				\
 	do { if (!(cond)) result(llen, SKIPPED); else ret += expect_le(expr, llen, val); } while (0)
 
-static int expect_le(int expr, int llen, int val)
+static __attribute__((unused))
+int expect_le(int expr, int llen, int val)
 {
 	int ret = !(expr <= val);
 
@@ -255,7 +262,8 @@ static int expect_le(int expr, int llen, int val)
 #define EXPECT_LT(cond, expr, val)				\
 	do { if (!(cond)) result(llen, SKIPPED); else ret += expect_lt(expr, llen, val); } while (0)
 
-static int expect_lt(int expr, int llen, int val)
+static __attribute__((unused))
+int expect_lt(int expr, int llen, int val)
 {
 	int ret = !(expr < val);
 
@@ -268,7 +276,8 @@ static int expect_lt(int expr, int llen, int val)
 #define EXPECT_SYSZR(cond, expr)				\
 	do { if (!(cond)) result(llen, SKIPPED); else ret += expect_syszr(expr, llen); } while (0)
 
-static int expect_syszr(int expr, int llen)
+static __attribute__((unused))
+int expect_syszr(int expr, int llen)
 {
 	int ret = 0;
 
@@ -287,7 +296,8 @@ static int expect_syszr(int expr, int llen)
 #define EXPECT_SYSEQ(cond, expr, val)				\
 	do { if (!(cond)) result(llen, SKIPPED); else ret += expect_syseq(expr, llen, val); } while (0)
 
-static int expect_syseq(int expr, int llen, int val)
+static __attribute__((unused))
+int expect_syseq(int expr, int llen, int val)
 {
 	int ret = 0;
 
@@ -306,7 +316,8 @@ static int expect_syseq(int expr, int llen, int val)
 #define EXPECT_SYSNE(cond, expr, val)				\
 	do { if (!(cond)) result(llen, SKIPPED); else ret += expect_sysne(expr, llen, val); } while (0)
 
-static int expect_sysne(int expr, int llen, int val)
+static __attribute__((unused))
+int expect_sysne(int expr, int llen, int val)
 {
 	int ret = 0;
 
@@ -328,7 +339,8 @@ static int expect_sysne(int expr, int llen, int val)
 #define EXPECT_SYSER(cond, expr, expret, experr)			\
 	EXPECT_SYSER2(cond, expr, expret, experr, 0)
 
-static int expect_syserr2(int expr, int expret, int experr1, int experr2, int llen)
+static __attribute__((unused))
+int expect_syserr2(int expr, int expret, int experr1, int experr2, int llen)
 {
 	int ret = 0;
 	int _errno = errno;
@@ -351,7 +363,8 @@ static int expect_syserr2(int expr, int expret, int experr1, int experr2, int ll
 #define EXPECT_PTRZR(cond, expr)				\
 	do { if (!(cond)) result(llen, SKIPPED); else ret += expect_ptrzr(expr, llen); } while (0)
 
-static int expect_ptrzr(const void *expr, int llen)
+static __attribute__((unused))
+int expect_ptrzr(const void *expr, int llen)
 {
 	int ret = 0;
 
@@ -369,7 +382,8 @@ static int expect_ptrzr(const void *expr, int llen)
 #define EXPECT_PTRNZ(cond, expr)				\
 	do { if (!(cond)) result(llen, SKIPPED); else ret += expect_ptrnz(expr, llen); } while (0)
 
-static int expect_ptrnz(const void *expr, int llen)
+static __attribute__((unused))
+int expect_ptrnz(const void *expr, int llen)
 {
 	int ret = 0;
 
@@ -386,7 +400,8 @@ static int expect_ptrnz(const void *expr, int llen)
 #define EXPECT_PTREQ(cond, expr, cmp)				\
 	do { if (!(cond)) result(llen, SKIPPED); else ret += expect_ptreq(expr, llen, cmp); } while (0)
 
-static int expect_ptreq(const void *expr, int llen, const void *cmp)
+static __attribute__((unused))
+int expect_ptreq(const void *expr, int llen, const void *cmp)
 {
 	int ret = 0;
 
@@ -403,7 +418,8 @@ static int expect_ptreq(const void *expr, int llen, const void *cmp)
 #define EXPECT_PTRNE(cond, expr, cmp)				\
 	do { if (!(cond)) result(llen, SKIPPED); else ret += expect_ptrne(expr, llen, cmp); } while (0)
 
-static int expect_ptrne(const void *expr, int llen, const void *cmp)
+static __attribute__((unused))
+int expect_ptrne(const void *expr, int llen, const void *cmp)
 {
 	int ret = 0;
 
@@ -420,7 +436,8 @@ static int expect_ptrne(const void *expr, int llen, const void *cmp)
 #define EXPECT_PTRGE(cond, expr, cmp)				\
 	do { if (!(cond)) result(llen, SKIPPED); else ret += expect_ptrge(expr, llen, cmp); } while (0)
 
-static int expect_ptrge(const void *expr, int llen, const void *cmp)
+static __attribute__((unused))
+int expect_ptrge(const void *expr, int llen, const void *cmp)
 {
 	int ret = !(expr >= cmp);
 
@@ -432,7 +449,8 @@ static int expect_ptrge(const void *expr, int llen, const void *cmp)
 #define EXPECT_PTRGT(cond, expr, cmp)				\
 	do { if (!(cond)) result(llen, SKIPPED); else ret += expect_ptrgt(expr, llen, cmp); } while (0)
 
-static int expect_ptrgt(const void *expr, int llen, const void *cmp)
+static __attribute__((unused))
+int expect_ptrgt(const void *expr, int llen, const void *cmp)
 {
 	int ret = !(expr > cmp);
 
@@ -445,7 +463,8 @@ static int expect_ptrgt(const void *expr, int llen, const void *cmp)
 #define EXPECT_PTRLE(cond, expr, cmp)				\
 	do { if (!(cond)) result(llen, SKIPPED); else ret += expect_ptrle(expr, llen, cmp); } while (0)
 
-static int expect_ptrle(const void *expr, int llen, const void *cmp)
+static __attribute__((unused))
+int expect_ptrle(const void *expr, int llen, const void *cmp)
 {
 	int ret = !(expr <= cmp);
 
@@ -458,7 +477,8 @@ static int expect_ptrle(const void *expr, int llen, const void *cmp)
 #define EXPECT_PTRLT(cond, expr, cmp)				\
 	do { if (!(cond)) result(llen, SKIPPED); else ret += expect_ptrlt(expr, llen, cmp); } while (0)
 
-static int expect_ptrlt(const void *expr, int llen, const void *cmp)
+static __attribute__((unused))
+int expect_ptrlt(const void *expr, int llen, const void *cmp)
 {
 	int ret = !(expr < cmp);
 
@@ -473,7 +493,8 @@ static int expect_ptrlt(const void *expr, int llen, const void *cmp)
 #define EXPECT_PTRER(cond, expr, expret, experr)			\
 	EXPECT_PTRER2(cond, expr, expret, experr, 0)
 
-static int expect_ptrerr2(const void *expr, const void *expret, int experr1, int experr2, int llen)
+static __attribute__((unused))
+int expect_ptrerr2(const void *expr, const void *expret, int experr1, int experr2, int llen)
 {
 	int ret = 0;
 	int _errno = errno;
@@ -495,7 +516,8 @@ static int expect_ptrerr2(const void *expr, const void *expret, int experr1, int
 #define EXPECT_STRZR(cond, expr)				\
 	do { if (!(cond)) result(llen, SKIPPED); else ret += expect_strzr(expr, llen); } while (0)
 
-static int expect_strzr(const char *expr, int llen)
+static __attribute__((unused))
+int expect_strzr(const char *expr, int llen)
 {
 	int ret = 0;
 
@@ -513,7 +535,8 @@ static int expect_strzr(const char *expr, int llen)
 #define EXPECT_STRNZ(cond, expr)				\
 	do { if (!(cond)) result(llen, SKIPPED); else ret += expect_strnz(expr, llen); } while (0)
 
-static int expect_strnz(const char *expr, int llen)
+static __attribute__((unused))
+int expect_strnz(const char *expr, int llen)
 {
 	int ret = 0;
 
@@ -531,7 +554,8 @@ static int expect_strnz(const char *expr, int llen)
 #define EXPECT_STREQ(cond, expr, cmp)				\
 	do { if (!(cond)) result(llen, SKIPPED); else ret += expect_streq(expr, llen, cmp); } while (0)
 
-static int expect_streq(const char *expr, int llen, const char *cmp)
+static __attribute__((unused))
+int expect_streq(const char *expr, int llen, const char *cmp)
 {
 	int ret = 0;
 
@@ -549,7 +573,8 @@ static int expect_streq(const char *expr, int llen, const char *cmp)
 #define EXPECT_STRNE(cond, expr, cmp)				\
 	do { if (!(cond)) result(llen, SKIPPED); else ret += expect_strne(expr, llen, cmp); } while (0)
 
-static int expect_strne(const char *expr, int llen, const char *cmp)
+static __attribute__((unused))
+int expect_strne(const char *expr, int llen, const char *cmp)
 {
 	int ret = 0;
 

-- 
2.41.0

