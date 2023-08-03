Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8322D76E160
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Aug 2023 09:29:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233321AbjHCH27 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 3 Aug 2023 03:28:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232135AbjHCH2y (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 3 Aug 2023 03:28:54 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13F4530D3;
        Thu,  3 Aug 2023 00:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1691047729;
        bh=7/upWQanP2NdVX/m2HsjLqivjxgPsVRP62MNXJPVjBs=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=pDCJQB/6zSpH57Tm0znGvuuTr48rVmGwWK+gxxzbT1uZ6l9v3D94yJ3zMCx01Yu3w
         JQSHvrzFzK/d2gggLQtGpaa2ARHTb62C3jdcoXq6jaalffGB7WIk0ALWbXgKfH0Ddh
         qFtBmd/WR5P6Ek+DZtIkjNC6w2waEIz9YO0PS3MU=
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date:   Thu, 03 Aug 2023 09:28:54 +0200
Subject: [PATCH v3 10/14] selftests/nolibc: avoid sign-compare warnings
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230803-nolibc-warnings-v3-10-bcc1a096ae02@weissschuh.net>
References: <20230803-nolibc-warnings-v3-0-bcc1a096ae02@weissschuh.net>
In-Reply-To: <20230803-nolibc-warnings-v3-0-bcc1a096ae02@weissschuh.net>
To:     Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yuan Tan <tanyuan@tinylab.org>,
        Zhangjin Wu <falcon@tinylab.org>,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1691047727; l=1503;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=7/upWQanP2NdVX/m2HsjLqivjxgPsVRP62MNXJPVjBs=;
 b=xlSvro4wwyBj3Yf5UMu6IxMPThA02+KbWyFtkG9C+3wj3599ZfkxP1KA7qJUBL0Jp5smv3vop
 0YnzSAL5MCXC7xBNeaNaIgxqJ24fQr08g30dknm0qRcY66CulIs20ts
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

These warnings will be enabled later so avoid triggering them.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/testing/selftests/nolibc/nolibc-test.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index d6aa12c3f9ff..0ab241d61508 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -737,9 +737,9 @@ int test_stat_timestamps(void)
 
 int test_mmap_munmap(void)
 {
-	int ret, fd, i;
+	int ret, fd, i, page_size;
 	void *mem;
-	size_t page_size, file_size, length;
+	size_t file_size, length;
 	off_t offset, pa_offset;
 	struct stat stat_buf;
 	const char * const files[] = {
@@ -1021,7 +1021,7 @@ int run_stdlib(int min, int max)
 #define EXPECT_VFPRINTF(c, expected, fmt, ...)				\
 	ret += expect_vfprintf(llen, c, expected, fmt, ##__VA_ARGS__)
 
-static int expect_vfprintf(int llen, size_t c, const char *expected, const char *fmt, ...)
+static int expect_vfprintf(int llen, int c, const char *expected, const char *fmt, ...)
 {
 	int ret, fd, w, r;
 	char buf[100];
@@ -1045,7 +1045,7 @@ static int expect_vfprintf(int llen, size_t c, const char *expected, const char
 	va_end(args);
 
 	if (w != c) {
-		llen += printf(" written(%d) != %d", w, (int) c);
+		llen += printf(" written(%d) != %d", w, c);
 		result(llen, FAIL);
 		return 1;
 	}

-- 
2.41.0

