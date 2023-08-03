Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 297EF76E15E
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Aug 2023 09:28:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232805AbjHCH25 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 3 Aug 2023 03:28:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232085AbjHCH2y (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 3 Aug 2023 03:28:54 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03E7630CA;
        Thu,  3 Aug 2023 00:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1691047729;
        bh=FYW5QoP5+S9dB6umlL+oN4HnFsDZi3fajwjXFuBeuUU=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=oMQtMHW2hK8MsDIGfxKj8QjxtaszAil3iqby3nulpaimVFdvLIt+byK+Hw4lftq0J
         I701Ixx5pTSl6yAR6mqb62v12M2OtSPZ5Emv4/7csGRX1f3VuAv8OGsWvruJZnRcw2
         NbJ45WZBMBt4CizWfdJfQd3CjTMOWjUgWt2jbNH4=
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date:   Thu, 03 Aug 2023 09:28:50 +0200
Subject: [PATCH v3 06/14] selftests/nolibc: drop unused variables
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230803-nolibc-warnings-v3-6-bcc1a096ae02@weissschuh.net>
References: <20230803-nolibc-warnings-v3-0-bcc1a096ae02@weissschuh.net>
In-Reply-To: <20230803-nolibc-warnings-v3-0-bcc1a096ae02@weissschuh.net>
To:     Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yuan Tan <tanyuan@tinylab.org>,
        Zhangjin Wu <falcon@tinylab.org>,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1691047727; l=1031;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=FYW5QoP5+S9dB6umlL+oN4HnFsDZi3fajwjXFuBeuUU=;
 b=he62Hb+5paDBtJB0GmwLNxnwaODM5oItQzKuC9iP8SNeUOCQ8UB0xUKooDaG0vcYpYzy2BkES
 vYmj39D9oVlBl2AN9Kk2W+9HV8KtfK4ojW1isYN8e2g73HOKeOxSDDQ
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
index 52489455add8..cff441c17f3e 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -908,9 +908,7 @@ int run_syscall(int min, int max)
 int run_stdlib(int min, int max)
 {
 	int test;
-	int tmp;
 	int ret = 0;
-	void *p1, *p2;
 
 	for (test = min; test >= 0 && test <= max; test++) {
 		int llen = 0; /* line length */
@@ -1051,9 +1049,7 @@ static int expect_vfprintf(int llen, size_t c, const char *expected, const char
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

