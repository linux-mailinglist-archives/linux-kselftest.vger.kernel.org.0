Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA4DE74EB1B
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Jul 2023 11:49:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231588AbjGKJtu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 11 Jul 2023 05:49:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231754AbjGKJtk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 11 Jul 2023 05:49:40 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6944FBE;
        Tue, 11 Jul 2023 02:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1689068974;
        bh=83SeGYY069UVxi94jP42yD5YlEmP07oKsxDCaS0DfLI=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=TNM11yR3/EprBB8Zbx+0ReDPGkWTXEKW/tR6mFLRKWeS0yDsvVYAvKCvNEj22jmXr
         QiruHvFuP7v+Ul65XonvTuwOJZUx2xPR5HXMQba2CRi1TDBarqS/7JYXYhXhiHjTia
         Yw9+hHwo52a1ZdtdUwY6lPhwCKBGcvweP2NSDX7g=
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date:   Tue, 11 Jul 2023 11:48:42 +0200
Subject: [PATCH 4/4] selftests/nolibc: avoid gaps in test numbers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230711-nolibc-sizeof-long-gaps-v1-4-dc78c3b85fc3@weissschuh.net>
References: <20230711-nolibc-sizeof-long-gaps-v1-0-dc78c3b85fc3@weissschuh.net>
In-Reply-To: <20230711-nolibc-sizeof-long-gaps-v1-0-dc78c3b85fc3@weissschuh.net>
To:     Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zhangjin Wu <falcon@tinylab.org>,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1689068953; l=4197;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=83SeGYY069UVxi94jP42yD5YlEmP07oKsxDCaS0DfLI=;
 b=8p8gHUPx37Id6K1WBhsyn1nlAsIFAof0sMQzd2/vZgcKJXeXQWUEwdPYT6QawzH40qigiipqz
 odYARoIC+dNAl6l63qU37l8GCLYsuDye8XNvqOWxRTy12Iuf6/MZ7pB
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

As the test numbers are based on line numbers gaps without testcases are
to be avoided.
Instead use the already existing test condition logic to implement
conditional execution.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/testing/selftests/nolibc/nolibc-test.c | 30 ++++++++++++----------------
 1 file changed, 13 insertions(+), 17 deletions(-)

diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index 754815c142f6..09660b362645 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -815,23 +815,19 @@ int run_stdlib(int min, int max)
 		CASE_TEST(limit_int_fast64_min);    EXPECT_EQ(1, INT_FAST64_MIN,   (int_fast64_t)    INT64_MIN); break;
 		CASE_TEST(limit_int_fast64_max);    EXPECT_EQ(1, INT_FAST64_MAX,   (int_fast64_t)    INT64_MAX); break;
 		CASE_TEST(limit_uint_fast64_max);   EXPECT_EQ(1, UINT_FAST64_MAX,  (uint_fast64_t)   UINT64_MAX); break;
-#if __SIZEOF_LONG__ == 8
-		CASE_TEST(limit_intptr_min);        EXPECT_EQ(1, INTPTR_MIN,       (intptr_t)        0x8000000000000000LL); break;
-		CASE_TEST(limit_intptr_max);        EXPECT_EQ(1, INTPTR_MAX,       (intptr_t)        0x7fffffffffffffffLL); break;
-		CASE_TEST(limit_uintptr_max);       EXPECT_EQ(1, UINTPTR_MAX,      (uintptr_t)       0xffffffffffffffffULL); break;
-		CASE_TEST(limit_ptrdiff_min);       EXPECT_EQ(1, PTRDIFF_MIN,      (ptrdiff_t)       0x8000000000000000LL); break;
-		CASE_TEST(limit_ptrdiff_max);       EXPECT_EQ(1, PTRDIFF_MAX,      (ptrdiff_t)       0x7fffffffffffffffLL); break;
-		CASE_TEST(limit_size_max);          EXPECT_EQ(1, SIZE_MAX,         (size_t)          0xffffffffffffffffULL); break;
-#elif __SIZEOF_LONG__ == 4
-		CASE_TEST(limit_intptr_min);        EXPECT_EQ(1, INTPTR_MIN,       (intptr_t)        0x80000000); break;
-		CASE_TEST(limit_intptr_max);        EXPECT_EQ(1, INTPTR_MAX,       (intptr_t)        0x7fffffff); break;
-		CASE_TEST(limit_uintptr_max);       EXPECT_EQ(1, UINTPTR_MAX,      (uintptr_t)       0xffffffffU); break;
-		CASE_TEST(limit_ptrdiff_min);       EXPECT_EQ(1, PTRDIFF_MIN,      (ptrdiff_t)       0x80000000); break;
-		CASE_TEST(limit_ptrdiff_max);       EXPECT_EQ(1, PTRDIFF_MAX,      (ptrdiff_t)       0x7fffffff); break;
-		CASE_TEST(limit_size_max);          EXPECT_EQ(1, SIZE_MAX,         (size_t)          0xffffffffU); break;
-#else
-# warning "__SIZEOF_LONG__ is undefined"
-#endif /* __SIZEOF_LONG__ */
+		CASE_TEST(sizeof_long_sane);        EXPECT_EQ(1, sizeof(long) == 8 || sizeof(long) == 4, 1); break;
+		CASE_TEST(limit_intptr_min_64);     EXPECT_EQ(sizeof(long) == 8, INTPTR_MIN,  (intptr_t)  0x8000000000000000LL); break;
+		CASE_TEST(limit_intptr_max_64);     EXPECT_EQ(sizeof(long) == 8, INTPTR_MAX,  (intptr_t)  0x7fffffffffffffffLL); break;
+		CASE_TEST(limit_uintptr_max_64);    EXPECT_EQ(sizeof(long) == 8, UINTPTR_MAX, (uintptr_t) 0xffffffffffffffffULL); break;
+		CASE_TEST(limit_ptrdiff_min_64);    EXPECT_EQ(sizeof(long) == 8, PTRDIFF_MIN, (ptrdiff_t) 0x8000000000000000LL); break;
+		CASE_TEST(limit_ptrdiff_max_64);    EXPECT_EQ(sizeof(long) == 8, PTRDIFF_MAX, (ptrdiff_t) 0x7fffffffffffffffLL); break;
+		CASE_TEST(limit_size_max_64);       EXPECT_EQ(sizeof(long) == 8, SIZE_MAX,    (size_t)    0xffffffffffffffffULL); break;
+		CASE_TEST(limit_intptr_min_32);     EXPECT_EQ(sizeof(long) == 4, INTPTR_MIN,  (intptr_t)  0x80000000); break;
+		CASE_TEST(limit_intptr_max_32);     EXPECT_EQ(sizeof(long) == 4, INTPTR_MAX,  (intptr_t)  0x7fffffff); break;
+		CASE_TEST(limit_uintptr_max_32);    EXPECT_EQ(sizeof(long) == 4, UINTPTR_MAX, (uintptr_t) 0xffffffffU); break;
+		CASE_TEST(limit_ptrdiff_min_32);    EXPECT_EQ(sizeof(long) == 4, PTRDIFF_MIN, (ptrdiff_t) 0x80000000); break;
+		CASE_TEST(limit_ptrdiff_max_32);    EXPECT_EQ(sizeof(long) == 4, PTRDIFF_MAX, (ptrdiff_t) 0x7fffffff); break;
+		CASE_TEST(limit_size_max_32);       EXPECT_EQ(sizeof(long) == 4, SIZE_MAX,    (size_t)    0xffffffffU); break;
 		case __LINE__:
 			return ret; /* must be last */
 		/* note: do not set any defaults so as to permit holes above */

-- 
2.41.0

