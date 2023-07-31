Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 764A2768BFB
	for <lists+linux-kselftest@lfdr.de>; Mon, 31 Jul 2023 08:27:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230077AbjGaG1C (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 31 Jul 2023 02:27:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbjGaG1B (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 31 Jul 2023 02:27:01 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF3D51A3;
        Sun, 30 Jul 2023 23:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1690784818;
        bh=k9l2McklzZ+f7yRkzY3nh6NN3e/IqcLnQTelqUxUMw8=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=n9igOyZGuaqKnQVBE5HfbFFsddmIwBR9WR4ZmGbZrNSe25048Ohf6zphGVYGNuWoF
         G/mcZcfL4ZtiPeReeA39j8/4bmWou/ynYarqyHj14A35hXRgWBQYA1adhm8NDVRIJc
         JK3pyawT4fz4lGn++rCtyEuDhClYUKJuovYcW2wU=
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date:   Mon, 31 Jul 2023 08:26:57 +0200
Subject: [PATCH 2/4] selftests/nolibc: drop unused variables
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230731-nolibc-warnings-v1-2-74973d2a52d7@weissschuh.net>
References: <20230731-nolibc-warnings-v1-0-74973d2a52d7@weissschuh.net>
In-Reply-To: <20230731-nolibc-warnings-v1-0-74973d2a52d7@weissschuh.net>
To:     Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yuan Tan <tanyuan@tinylab.org>,
        Zhangjin Wu <falcon@tinylab.org>,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1690784818; l=1029;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=k9l2McklzZ+f7yRkzY3nh6NN3e/IqcLnQTelqUxUMw8=;
 b=aJonl+8VdC7MJHCYyAUY48LuP1WOU57ea5CAhF2u1SPA6lIUOjRsfNDoKxZMc047hBCDfCuNU
 zaJ4m2GdcOWCTdv2NApJXy8//W/CSAv1pUpFT0ySGEf+epkGIY6p5Sn
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

These got copied around as new testcases where created.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/testing/selftests/nolibc/nolibc-test.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index 53e2d448eded..3064191681d0 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -786,9 +786,7 @@ int run_syscall(int min, int max)
 int run_stdlib(int min, int max)
 {
 	int test;
-	int tmp;
 	int ret = 0;
-	void *p1, *p2;
 
 	for (test = min; test >= 0 && test <= max; test++) {
 		int llen = 0; /* line length */
@@ -929,9 +927,7 @@ static int expect_vfprintf(int llen, size_t c, const char *expected, const char
 static int run_vfprintf(int min, int max)
 {
 	int test;
-	int tmp;
 	int ret = 0;
-	void *p1, *p2;
 
 	for (test = min; test >= 0 && test <= max; test++) {
 		int llen = 0; /* line length */

-- 
2.41.0

