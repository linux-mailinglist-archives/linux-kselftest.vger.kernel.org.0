Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EEC876E168
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Aug 2023 09:29:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233875AbjHCH3E (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 3 Aug 2023 03:29:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232555AbjHCH2z (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 3 Aug 2023 03:28:55 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1828530E2;
        Thu,  3 Aug 2023 00:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1691047729;
        bh=7aEZiIikmC4dKxk18WeIZWuHGVLO6UKYLRF2uAPpdO8=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=cj9GrobY/1w3hDNxpr4Zm1kL8BwyH/MqQxk1lqSc06VM2+yzhPA4Xu/pKpAa2rnqp
         /qc+Q5gQ5Q/c8YPlfdlj8CwkXMLbUjNnGAarJTfniCD0lLWov95C4BZdbFsA9DJhXD
         xYIyXw8ObFwsJrKnyndSy4IbreOHNvNaFJWTec4g=
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date:   Thu, 03 Aug 2023 09:28:51 +0200
Subject: [PATCH v3 07/14] selftests/nolibc: mark test helpers as
 potentially unused
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230803-nolibc-warnings-v3-7-bcc1a096ae02@weissschuh.net>
References: <20230803-nolibc-warnings-v3-0-bcc1a096ae02@weissschuh.net>
In-Reply-To: <20230803-nolibc-warnings-v3-0-bcc1a096ae02@weissschuh.net>
To:     Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yuan Tan <tanyuan@tinylab.org>,
        Zhangjin Wu <falcon@tinylab.org>,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1691047727; l=10728;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=7aEZiIikmC4dKxk18WeIZWuHGVLO6UKYLRF2uAPpdO8=;
 b=3A2jdKeeuWHO4uH9MrH+U9tE7ow7q71eJ2fIj4ScJ6fyFsSP4JkrNV/nDUfvQkRjzS5qgYDn9
 BuiDQhHFWtuAZ/M1h/PbcjzhHi6HxQjwVVq0CAqX3NbP41nFdd9pEuf
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
index cff441c17f3e..154ec4787e8d 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -165,7 +165,8 @@ static void result(int llen, enum RESULT r)
 #define EXPECT_ZR(cond, expr)				\
 	do { if (!(cond)) result(llen, SKIPPED); else ret += expect_zr(expr, llen); } while (0)
 
-static int expect_zr(int expr, int llen)
+static __attribute__((unused))
+int expect_zr(int expr, int llen)
 {
 	int ret = !(expr == 0);
 
@@ -178,7 +179,8 @@ static int expect_zr(int expr, int llen)
 #define EXPECT_NZ(cond, expr, val)			\
 	do { if (!(cond)) result(llen, SKIPPED); else ret += expect_nz(expr, llen; } while (0)
 
-static int expect_nz(int expr, int llen)
+static __attribute__((unused))
+int expect_nz(int expr, int llen)
 {
 	int ret = !(expr != 0);
 
@@ -191,7 +193,8 @@ static int expect_nz(int expr, int llen)
 #define EXPECT_EQ(cond, expr, val)				\
 	do { if (!(cond)) result(llen, SKIPPED); else ret += expect_eq(expr, llen, val); } while (0)
 
-static int expect_eq(uint64_t expr, int llen, uint64_t val)
+static __attribute__((unused))
+int expect_eq(uint64_t expr, int llen, uint64_t val)
 {
 	int ret = !(expr == val);
 
@@ -204,7 +207,8 @@ static int expect_eq(uint64_t expr, int llen, uint64_t val)
 #define EXPECT_NE(cond, expr, val)				\
 	do { if (!(cond)) result(llen, SKIPPED); else ret += expect_ne(expr, llen, val); } while (0)
 
-static int expect_ne(int expr, int llen, int val)
+static __attribute__((unused))
+int expect_ne(int expr, int llen, int val)
 {
 	int ret = !(expr != val);
 
@@ -217,7 +221,8 @@ static int expect_ne(int expr, int llen, int val)
 #define EXPECT_GE(cond, expr, val)				\
 	do { if (!(cond)) result(llen, SKIPPED); else ret += expect_ge(expr, llen, val); } while (0)
 
-static int expect_ge(int expr, int llen, int val)
+static __attribute__((unused))
+int expect_ge(int expr, int llen, int val)
 {
 	int ret = !(expr >= val);
 
@@ -230,7 +235,8 @@ static int expect_ge(int expr, int llen, int val)
 #define EXPECT_GT(cond, expr, val)				\
 	do { if (!(cond)) result(llen, SKIPPED); else ret += expect_gt(expr, llen, val); } while (0)
 
-static int expect_gt(int expr, int llen, int val)
+static __attribute__((unused))
+int expect_gt(int expr, int llen, int val)
 {
 	int ret = !(expr > val);
 
@@ -243,7 +249,8 @@ static int expect_gt(int expr, int llen, int val)
 #define EXPECT_LE(cond, expr, val)				\
 	do { if (!(cond)) result(llen, SKIPPED); else ret += expect_le(expr, llen, val); } while (0)
 
-static int expect_le(int expr, int llen, int val)
+static __attribute__((unused))
+int expect_le(int expr, int llen, int val)
 {
 	int ret = !(expr <= val);
 
@@ -256,7 +263,8 @@ static int expect_le(int expr, int llen, int val)
 #define EXPECT_LT(cond, expr, val)				\
 	do { if (!(cond)) result(llen, SKIPPED); else ret += expect_lt(expr, llen, val); } while (0)
 
-static int expect_lt(int expr, int llen, int val)
+static __attribute__((unused))
+int expect_lt(int expr, int llen, int val)
 {
 	int ret = !(expr < val);
 
@@ -269,7 +277,8 @@ static int expect_lt(int expr, int llen, int val)
 #define EXPECT_SYSZR(cond, expr)				\
 	do { if (!(cond)) result(llen, SKIPPED); else ret += expect_syszr(expr, llen); } while (0)
 
-static int expect_syszr(int expr, int llen)
+static __attribute__((unused))
+int expect_syszr(int expr, int llen)
 {
 	int ret = 0;
 
@@ -288,7 +297,8 @@ static int expect_syszr(int expr, int llen)
 #define EXPECT_SYSEQ(cond, expr, val)				\
 	do { if (!(cond)) result(llen, SKIPPED); else ret += expect_syseq(expr, llen, val); } while (0)
 
-static int expect_syseq(int expr, int llen, int val)
+static __attribute__((unused))
+int expect_syseq(int expr, int llen, int val)
 {
 	int ret = 0;
 
@@ -307,7 +317,8 @@ static int expect_syseq(int expr, int llen, int val)
 #define EXPECT_SYSNE(cond, expr, val)				\
 	do { if (!(cond)) result(llen, SKIPPED); else ret += expect_sysne(expr, llen, val); } while (0)
 
-static int expect_sysne(int expr, int llen, int val)
+static __attribute__((unused))
+int expect_sysne(int expr, int llen, int val)
 {
 	int ret = 0;
 
@@ -329,7 +340,8 @@ static int expect_sysne(int expr, int llen, int val)
 #define EXPECT_SYSER(cond, expr, expret, experr)			\
 	EXPECT_SYSER2(cond, expr, expret, experr, 0)
 
-static int expect_syserr2(int expr, int expret, int experr1, int experr2, int llen)
+static __attribute__((unused))
+int expect_syserr2(int expr, int expret, int experr1, int experr2, int llen)
 {
 	int ret = 0;
 	int _errno = errno;
@@ -352,7 +364,8 @@ static int expect_syserr2(int expr, int expret, int experr1, int experr2, int ll
 #define EXPECT_PTRZR(cond, expr)				\
 	do { if (!(cond)) result(llen, SKIPPED); else ret += expect_ptrzr(expr, llen); } while (0)
 
-static int expect_ptrzr(const void *expr, int llen)
+static __attribute__((unused))
+int expect_ptrzr(const void *expr, int llen)
 {
 	int ret = 0;
 
@@ -370,7 +383,8 @@ static int expect_ptrzr(const void *expr, int llen)
 #define EXPECT_PTRNZ(cond, expr)				\
 	do { if (!(cond)) result(llen, SKIPPED); else ret += expect_ptrnz(expr, llen); } while (0)
 
-static int expect_ptrnz(const void *expr, int llen)
+static __attribute__((unused))
+int expect_ptrnz(const void *expr, int llen)
 {
 	int ret = 0;
 
@@ -387,7 +401,8 @@ static int expect_ptrnz(const void *expr, int llen)
 #define EXPECT_PTREQ(cond, expr, cmp)				\
 	do { if (!(cond)) result(llen, SKIPPED); else ret += expect_ptreq(expr, llen, cmp); } while (0)
 
-static int expect_ptreq(const void *expr, int llen, const void *cmp)
+static __attribute__((unused))
+int expect_ptreq(const void *expr, int llen, const void *cmp)
 {
 	int ret = 0;
 
@@ -404,7 +419,8 @@ static int expect_ptreq(const void *expr, int llen, const void *cmp)
 #define EXPECT_PTRNE(cond, expr, cmp)				\
 	do { if (!(cond)) result(llen, SKIPPED); else ret += expect_ptrne(expr, llen, cmp); } while (0)
 
-static int expect_ptrne(const void *expr, int llen, const void *cmp)
+static __attribute__((unused))
+int expect_ptrne(const void *expr, int llen, const void *cmp)
 {
 	int ret = 0;
 
@@ -421,7 +437,8 @@ static int expect_ptrne(const void *expr, int llen, const void *cmp)
 #define EXPECT_PTRGE(cond, expr, cmp)				\
 	do { if (!(cond)) result(llen, SKIPPED); else ret += expect_ptrge(expr, llen, cmp); } while (0)
 
-static int expect_ptrge(const void *expr, int llen, const void *cmp)
+static __attribute__((unused))
+int expect_ptrge(const void *expr, int llen, const void *cmp)
 {
 	int ret = !(expr >= cmp);
 
@@ -433,7 +450,8 @@ static int expect_ptrge(const void *expr, int llen, const void *cmp)
 #define EXPECT_PTRGT(cond, expr, cmp)				\
 	do { if (!(cond)) result(llen, SKIPPED); else ret += expect_ptrgt(expr, llen, cmp); } while (0)
 
-static int expect_ptrgt(const void *expr, int llen, const void *cmp)
+static __attribute__((unused))
+int expect_ptrgt(const void *expr, int llen, const void *cmp)
 {
 	int ret = !(expr > cmp);
 
@@ -446,7 +464,8 @@ static int expect_ptrgt(const void *expr, int llen, const void *cmp)
 #define EXPECT_PTRLE(cond, expr, cmp)				\
 	do { if (!(cond)) result(llen, SKIPPED); else ret += expect_ptrle(expr, llen, cmp); } while (0)
 
-static int expect_ptrle(const void *expr, int llen, const void *cmp)
+static __attribute__((unused))
+int expect_ptrle(const void *expr, int llen, const void *cmp)
 {
 	int ret = !(expr <= cmp);
 
@@ -459,7 +478,8 @@ static int expect_ptrle(const void *expr, int llen, const void *cmp)
 #define EXPECT_PTRLT(cond, expr, cmp)				\
 	do { if (!(cond)) result(llen, SKIPPED); else ret += expect_ptrlt(expr, llen, cmp); } while (0)
 
-static int expect_ptrlt(const void *expr, int llen, const void *cmp)
+static __attribute__((unused))
+int expect_ptrlt(const void *expr, int llen, const void *cmp)
 {
 	int ret = !(expr < cmp);
 
@@ -474,7 +494,8 @@ static int expect_ptrlt(const void *expr, int llen, const void *cmp)
 #define EXPECT_PTRER(cond, expr, expret, experr)			\
 	EXPECT_PTRER2(cond, expr, expret, experr, 0)
 
-static int expect_ptrerr2(const void *expr, const void *expret, int experr1, int experr2, int llen)
+static __attribute__((unused))
+int expect_ptrerr2(const void *expr, const void *expret, int experr1, int experr2, int llen)
 {
 	int ret = 0;
 	int _errno = errno;
@@ -496,7 +517,8 @@ static int expect_ptrerr2(const void *expr, const void *expret, int experr1, int
 #define EXPECT_STRZR(cond, expr)				\
 	do { if (!(cond)) result(llen, SKIPPED); else ret += expect_strzr(expr, llen); } while (0)
 
-static int expect_strzr(const char *expr, int llen)
+static __attribute__((unused))
+int expect_strzr(const char *expr, int llen)
 {
 	int ret = 0;
 
@@ -514,7 +536,8 @@ static int expect_strzr(const char *expr, int llen)
 #define EXPECT_STRNZ(cond, expr)				\
 	do { if (!(cond)) result(llen, SKIPPED); else ret += expect_strnz(expr, llen); } while (0)
 
-static int expect_strnz(const char *expr, int llen)
+static __attribute__((unused))
+int expect_strnz(const char *expr, int llen)
 {
 	int ret = 0;
 
@@ -532,7 +555,8 @@ static int expect_strnz(const char *expr, int llen)
 #define EXPECT_STREQ(cond, expr, cmp)				\
 	do { if (!(cond)) result(llen, SKIPPED); else ret += expect_streq(expr, llen, cmp); } while (0)
 
-static int expect_streq(const char *expr, int llen, const char *cmp)
+static __attribute__((unused))
+int expect_streq(const char *expr, int llen, const char *cmp)
 {
 	int ret = 0;
 
@@ -550,7 +574,8 @@ static int expect_streq(const char *expr, int llen, const char *cmp)
 #define EXPECT_STRNE(cond, expr, cmp)				\
 	do { if (!(cond)) result(llen, SKIPPED); else ret += expect_strne(expr, llen, cmp); } while (0)
 
-static int expect_strne(const char *expr, int llen, const char *cmp)
+static __attribute__((unused))
+int expect_strne(const char *expr, int llen, const char *cmp)
 {
 	int ret = 0;
 

-- 
2.41.0

