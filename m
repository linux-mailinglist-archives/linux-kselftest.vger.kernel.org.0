Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A82C76E164
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Aug 2023 09:29:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232987AbjHCH3B (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 3 Aug 2023 03:29:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232330AbjHCH2z (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 3 Aug 2023 03:28:55 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9606A187;
        Thu,  3 Aug 2023 00:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1691047729;
        bh=FOosJH/CmUX2d0gi9dET+M4ykNx0gigEkRwzseP0iBQ=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=mFfiRKlyRQ1RA8jAfiLWQNaBJouglzSvWbjxpUEHbrdgJGElid8O7uGRRKCNDkata
         Lm6yvEGonFX+awVTZ0VkBWNQEqPBau8BSTZTgGH5+LtlRHZ0Fb08Rru/GPjSE7Enoz
         vZELYSf3f2fXiqXFU385Ds9sucRx16qQJgQR4QpQ=
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date:   Thu, 03 Aug 2023 09:28:55 +0200
Subject: [PATCH v3 11/14] selftests/nolibc: use correct return type for
 read() and write()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230803-nolibc-warnings-v3-11-bcc1a096ae02@weissschuh.net>
References: <20230803-nolibc-warnings-v3-0-bcc1a096ae02@weissschuh.net>
In-Reply-To: <20230803-nolibc-warnings-v3-0-bcc1a096ae02@weissschuh.net>
To:     Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yuan Tan <tanyuan@tinylab.org>,
        Zhangjin Wu <falcon@tinylab.org>,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1691047727; l=1419;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=FOosJH/CmUX2d0gi9dET+M4ykNx0gigEkRwzseP0iBQ=;
 b=4jNwczucEessfNJbJG8Wi2UcI2FKtV4G8+Nx0CetT9ICUSxSaPgKRg7DdIBB2TwdxoPicmrBM
 D9BTJZbvnjMC78Q4K/x2E3FsSdqFaUiA6M/Oht8hc9RR+eqyUkW82f4
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

Avoid truncating values before comparing them.

As printf in nolibc doesn't support ssize_t add casts to int for
printing.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/testing/selftests/nolibc/nolibc-test.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index 0ab241d61508..63f09800057d 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -1023,7 +1023,8 @@ int run_stdlib(int min, int max)
 
 static int expect_vfprintf(int llen, int c, const char *expected, const char *fmt, ...)
 {
-	int ret, fd, w, r;
+	int ret, fd;
+	ssize_t w, r;
 	char buf[100];
 	FILE *memfile;
 	va_list args;
@@ -1045,7 +1046,7 @@ static int expect_vfprintf(int llen, int c, const char *expected, const char *fm
 	va_end(args);
 
 	if (w != c) {
-		llen += printf(" written(%d) != %d", w, c);
+		llen += printf(" written(%d) != %d", (int)w, c);
 		result(llen, FAIL);
 		return 1;
 	}
@@ -1059,7 +1060,7 @@ static int expect_vfprintf(int llen, int c, const char *expected, const char *fm
 	fclose(memfile);
 
 	if (r != w) {
-		llen += printf(" written(%d) != read(%d)", w, r);
+		llen += printf(" written(%d) != read(%d)", (int)w, (int)r);
 		result(llen, FAIL);
 		return 1;
 	}

-- 
2.41.0

