Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5CF77159B8
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 May 2023 11:18:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbjE3JSK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 30 May 2023 05:18:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbjE3JSJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 30 May 2023 05:18:09 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC40FE8;
        Tue, 30 May 2023 02:18:07 -0700 (PDT)
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1685438285;
        bh=GOtVnXfIJlGURLj2ERPngUrj5IRyyiUMPq6o2r0EbhE=;
        h=From:Date:Subject:To:Cc:From;
        b=pmfwR3LJPtVG6ULCMXXmvrxPwnuXsJA93eTyeeR2KUCBvHrcOQCj8ziKxAiXM6HLr
         5zgIjk0MgL1AFO0UJok7z0u1jI4FoXILUU0Tha0vv4ZVtGyIwxJ0ctKXkEhY2BdEcB
         wZ+MBssUXnaSTB8qkwiSdOVsrBPzqzgShQ0p4MGk=
Date:   Tue, 30 May 2023 11:18:00 +0200
Subject: [PATCH] tools/nolibc: ensure fast64 integer types have 64 bits
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230530-nolibc-fast64-v1-1-883dea6bc666@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIAEe/dWQC/x2NywrCQAwAf6XkbGD70BV/RTzspqkNLKlsWhFK/
 93Q4wwMs4NxFTZ4NDtU/orJog7tpQGak74ZZXSGLnR9uPYBdSmSCadk623Ae4yRxkyRQwve5GS
 MuSal2SvdSnH5qTzJ75w8X8fxB/hkzyR0AAAA
To:     Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Vincent Dagonneau <v@vda.io>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1685438284; l=2858;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=GOtVnXfIJlGURLj2ERPngUrj5IRyyiUMPq6o2r0EbhE=;
 b=eCm+xH2GZu1IbNP0TDgCOh3vmlEw8pcefoAp5YcxRxoQ89BgMVhVmIKnNAIN7VtZCVE6oxyuL
 iRk3stIxcuAD3qkezPIEcO+xISsIk8tnq6efc6yysJpg/5vfTIb5wti
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 32bit platforms size_t is not enough to represent [u]int_fast64_t.

Fixes: 3e9fd4e9a1d5 ("tools/nolibc: add integer types and integer limit macros")
Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
Cc: Vincent Dagonneau <v@vda.io>

Note: We could also fall back to compiler-provided data like:

__UINT_FAST{8,16,32,64}_{TYPE,MIN,MAX}__
---
 tools/include/nolibc/stdint.h                | 4 ++--
 tools/testing/selftests/nolibc/nolibc-test.c | 6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/include/nolibc/stdint.h b/tools/include/nolibc/stdint.h
index c1ce4f5e0603..3fc418cfc3d7 100644
--- a/tools/include/nolibc/stdint.h
+++ b/tools/include/nolibc/stdint.h
@@ -36,8 +36,8 @@ typedef  ssize_t       int_fast16_t;
 typedef   size_t      uint_fast16_t;
 typedef  ssize_t       int_fast32_t;
 typedef   size_t      uint_fast32_t;
-typedef  ssize_t       int_fast64_t;
-typedef   size_t      uint_fast64_t;
+typedef  int64_t       int_fast64_t;
+typedef uint64_t      uint_fast64_t;
 
 typedef  int64_t           intmax_t;
 typedef uint64_t          uintmax_t;
diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index 7de46305f419..65be0317d184 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -696,9 +696,9 @@ int run_stdlib(int min, int max)
 		CASE_TEST(limit_int_fast32_min);    EXPECT_EQ(1, INT_FAST32_MIN,   (int_fast32_t)    INTPTR_MIN); break;
 		CASE_TEST(limit_int_fast32_max);    EXPECT_EQ(1, INT_FAST32_MAX,   (int_fast32_t)    INTPTR_MAX); break;
 		CASE_TEST(limit_uint_fast32_max);   EXPECT_EQ(1, UINT_FAST32_MAX,  (uint_fast32_t)   UINTPTR_MAX); break;
-		CASE_TEST(limit_int_fast64_min);    EXPECT_EQ(1, INT_FAST64_MIN,   (int_fast64_t)    INTPTR_MIN); break;
-		CASE_TEST(limit_int_fast64_max);    EXPECT_EQ(1, INT_FAST64_MAX,   (int_fast64_t)    INTPTR_MAX); break;
-		CASE_TEST(limit_uint_fast64_max);   EXPECT_EQ(1, UINT_FAST64_MAX,  (uint_fast64_t)   UINTPTR_MAX); break;
+		CASE_TEST(limit_int_fast64_min);    EXPECT_EQ(1, INT_FAST64_MIN,   (int_fast64_t)    INT64_MIN); break;
+		CASE_TEST(limit_int_fast64_max);    EXPECT_EQ(1, INT_FAST64_MAX,   (int_fast64_t)    INT64_MAX); break;
+		CASE_TEST(limit_uint_fast64_max);   EXPECT_EQ(1, UINT_FAST64_MAX,  (uint_fast64_t)   UINT64_MAX); break;
 #if __SIZEOF_LONG__ == 8
 		CASE_TEST(limit_intptr_min);        EXPECT_EQ(1, INTPTR_MIN,       (intptr_t)        0x8000000000000000LL); break;
 		CASE_TEST(limit_intptr_max);        EXPECT_EQ(1, INTPTR_MAX,       (intptr_t)        0x7fffffffffffffffLL); break;

---
base-commit: 5b21219d67d3483144d10332709d0c04f733ab93
change-id: 20230530-nolibc-fast64-8777cdbc7e01

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>

