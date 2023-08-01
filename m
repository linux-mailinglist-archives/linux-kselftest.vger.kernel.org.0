Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FCC676A84A
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Aug 2023 07:30:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbjHAFa2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 1 Aug 2023 01:30:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230187AbjHAFaZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 1 Aug 2023 01:30:25 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D44361FC8;
        Mon, 31 Jul 2023 22:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1690867813;
        bh=8JUgAV5EcZ7Ceowdi0aIq4X8Gxvivj8ysQlFLj7p6c0=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=Zgy7/+IPfRl0O1LMksFDmy6N7NQcNdJG67rCdDSGcvKRewPhw8NeCamE3SYH0z4ga
         54Gb9wxDJQGsNhmU8s991DJqr6IcthpZZUGO3P/yLUUSQ4ZBZ6L45uDVmntv2z4srd
         YbBUtpPGNiP22z8lqs5m9RD3temuxgDnOKEXXA6o=
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date:   Tue, 01 Aug 2023 07:30:15 +0200
Subject: [PATCH v2 08/10] selftests/nolibc: avoid sign-compare warnings
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230801-nolibc-warnings-v2-8-1ba5ca57bd9b@weissschuh.net>
References: <20230801-nolibc-warnings-v2-0-1ba5ca57bd9b@weissschuh.net>
In-Reply-To: <20230801-nolibc-warnings-v2-0-1ba5ca57bd9b@weissschuh.net>
To:     Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yuan Tan <tanyuan@tinylab.org>,
        Zhangjin Wu <falcon@tinylab.org>,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1690867811; l=1128;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=8JUgAV5EcZ7Ceowdi0aIq4X8Gxvivj8ysQlFLj7p6c0=;
 b=pCV2p6S7run/8FWyjhQPMKcAGy/+ZpJLIc6UU7mZGDa4K0Jxx09bm7WJogGjHGrYzJ/Jei5Hm
 TDZs9FG2TfvDwsVcJD+zPQG8eTjqSJOlWmM5yVJFcWbY+Ba8mxEZJOw
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

These warnings will be enabled later so avoid triggering them.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/testing/selftests/nolibc/nolibc-test.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index cb17cccd0bc7..82714051c72f 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -749,7 +749,7 @@ static int test_mmap_munmap(void)
 	};
 
 	page_size = getpagesize();
-	if (page_size < 0)
+	if (page_size == 0)
 		return -1;
 
 	/* find a right file to mmap, existed and accessible */
@@ -998,7 +998,7 @@ static int run_stdlib(int min, int max)
 #define EXPECT_VFPRINTF(c, expected, fmt, ...)				\
 	ret += expect_vfprintf(llen, c, expected, fmt, ##__VA_ARGS__)
 
-static int expect_vfprintf(int llen, size_t c, const char *expected, const char *fmt, ...)
+static int expect_vfprintf(int llen, int c, const char *expected, const char *fmt, ...)
 {
 	int ret, fd, w, r;
 	char buf[100];

-- 
2.41.0

