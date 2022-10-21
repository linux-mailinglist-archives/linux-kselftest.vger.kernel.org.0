Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B4BA606FCA
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Oct 2022 08:04:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbiJUGEG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 21 Oct 2022 02:04:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbiJUGD6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 21 Oct 2022 02:03:58 -0400
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4978D4521E;
        Thu, 20 Oct 2022 23:03:56 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 29L63lSF007564;
        Fri, 21 Oct 2022 08:03:47 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Willy Tarreau <w@1wt.eu>
Subject: [PATCH] selftests/nolibc: add 7 tests for memcmp()
Date:   Fri, 21 Oct 2022 08:03:40 +0200
Message-Id: <20221021060340.7515-1-w@1wt.eu>
X-Mailer: git-send-email 2.17.5
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This adds 7 combinations of input values for memcmp() using signed and
unsigned bytes, which will trigger on the original code before Rasmus'
fix. This is mostly aimed at helping backporters verify their work, and
showing how tests for corner cases can be added to the selftests suite.

Before the fix it reports:
  12 memcmp_20_20 = 0                      [OK]
  13 memcmp_20_60 = -64                    [OK]
  14 memcmp_60_20 = 64                     [OK]
  15 memcmp_20_e0 = 64                    [FAIL]
  16 memcmp_e0_20 = -64                   [FAIL]
  17 memcmp_80_e0 = -96                    [OK]
  18 memcmp_e0_80 = 96                     [OK]

And after:
  12 memcmp_20_20 = 0                      [OK]
  13 memcmp_20_60 = -64                    [OK]
  14 memcmp_60_20 = 64                     [OK]
  15 memcmp_20_e0 = -192                   [OK]
  16 memcmp_e0_20 = 192                    [OK]
  17 memcmp_80_e0 = -96                    [OK]
  18 memcmp_e0_80 = 96                     [OK]

Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Signed-off-by: Willy Tarreau <w@1wt.eu>
---
 tools/testing/selftests/nolibc/nolibc-test.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index 78bced95ac63..f14f5076fb6d 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -565,6 +565,13 @@ int run_stdlib(int min, int max)
 		CASE_TEST(strchr_foobar_z);    EXPECT_STRZR(1, strchr("foobar", 'z')); break;
 		CASE_TEST(strrchr_foobar_o);   EXPECT_STREQ(1, strrchr("foobar", 'o'), "obar"); break;
 		CASE_TEST(strrchr_foobar_z);   EXPECT_STRZR(1, strrchr("foobar", 'z')); break;
+		CASE_TEST(memcmp_20_20);       EXPECT_EQ(1, memcmp("aaa\x20", "aaa\x20", 4), 0); break;
+		CASE_TEST(memcmp_20_60);       EXPECT_LT(1, memcmp("aaa\x20", "aaa\x60", 4), 0); break;
+		CASE_TEST(memcmp_60_20);       EXPECT_GT(1, memcmp("aaa\x60", "aaa\x20", 4), 0); break;
+		CASE_TEST(memcmp_20_e0);       EXPECT_LT(1, memcmp("aaa\x20", "aaa\xe0", 4), 0); break;
+		CASE_TEST(memcmp_e0_20);       EXPECT_GT(1, memcmp("aaa\xe0", "aaa\x20", 4), 0); break;
+		CASE_TEST(memcmp_80_e0);       EXPECT_LT(1, memcmp("aaa\x80", "aaa\xe0", 4), 0); break;
+		CASE_TEST(memcmp_e0_80);       EXPECT_GT(1, memcmp("aaa\xe0", "aaa\x80", 4), 0); break;
 		case __LINE__:
 			return ret; /* must be last */
 		/* note: do not set any defaults so as to permit holes above */
-- 
2.17.5

