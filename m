Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE40776A843
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Aug 2023 07:30:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbjHAFaW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 1 Aug 2023 01:30:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230136AbjHAFaV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 1 Aug 2023 01:30:21 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 867AC1FC3;
        Mon, 31 Jul 2023 22:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1690867812;
        bh=j96CuOLvJppfEA70wZqqPAJsnlrN3A9fJ6xA4htw4tY=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=R35OYw1zLozA6mdagb67ZWoj6xAVDTadUXownJy7jL8pv5aqZeCLokMpx2sCtNLxl
         6kE1tAb6W84xwAP/dJXnGR3z+uM+1FUIVnL3Uh7t+hftKSzb8HYXPOuzXQt4sGJoja
         JS+5dO3mCd7v6TPhJXnmxh0JRr3WZ2KyAJbCwXYQ=
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date:   Tue, 01 Aug 2023 07:30:11 +0200
Subject: [PATCH v2 04/10] selftests/nolibc: drop unused variables
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230801-nolibc-warnings-v2-4-1ba5ca57bd9b@weissschuh.net>
References: <20230801-nolibc-warnings-v2-0-1ba5ca57bd9b@weissschuh.net>
In-Reply-To: <20230801-nolibc-warnings-v2-0-1ba5ca57bd9b@weissschuh.net>
To:     Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yuan Tan <tanyuan@tinylab.org>,
        Zhangjin Wu <falcon@tinylab.org>,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1690867811; l=1031;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=j96CuOLvJppfEA70wZqqPAJsnlrN3A9fJ6xA4htw4tY=;
 b=SElh9ZEtkHumDZa9Llk+sszzBJ4Sddw5iSXmUudN8LRkmWmuPYLugrF3XUh4J0KOPv7AhPuD0
 Psa9lbfPYAqAP+CZbuiKmFN2e/CWRjkl+ouZhqVkXyzX3CzEqfx26W6
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

These got copied around as new testcases where created.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/testing/selftests/nolibc/nolibc-test.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index 03b1d30f5507..9a5a212ea55c 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -885,9 +885,7 @@ int run_syscall(int min, int max)
 int run_stdlib(int min, int max)
 {
 	int test;
-	int tmp;
 	int ret = 0;
-	void *p1, *p2;
 
 	for (test = min; test >= 0 && test <= max; test++) {
 		int llen = 0; /* line length */
@@ -1028,9 +1026,7 @@ static int expect_vfprintf(int llen, size_t c, const char *expected, const char
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

