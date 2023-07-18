Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26187758825
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Jul 2023 00:05:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbjGRWFm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 18 Jul 2023 18:05:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbjGRWFk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 18 Jul 2023 18:05:40 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C706E19AD;
        Tue, 18 Jul 2023 15:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1689717869;
        bh=Ep1Rg7y74qHacqZZsLEFQcfo3UPaVM/TmmdadAIahJk=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=UJzTeD3OsequcHeWcbggbUKDuNcPttt8OuZ3CwItIwHPs71doCPcqOIaUTIfC6Yoq
         LL2JpWcIRfuoazUISOFJ9W8tI1iwWWKY1gSXZ/GqQNdQx4GYmEIMqNMelPkRKR3l6Z
         fK82Q7OE/yMklMUbDI4tgi86NofiTwS60YGLZ8qc=
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date:   Wed, 19 Jul 2023 00:00:39 +0200
Subject: [PATCH RFC 1/7] selftests/nolibc: statically calculate number of
 testsuites
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230719-nolibc-ktap-tmp-v1-1-930bd0c52ff1@weissschuh.net>
References: <20230719-nolibc-ktap-tmp-v1-0-930bd0c52ff1@weissschuh.net>
In-Reply-To: <20230719-nolibc-ktap-tmp-v1-0-930bd0c52ff1@weissschuh.net>
To:     Willy Tarreau <w@1wt.eu>
Cc:     Zhangjin Wu <falcon@tinylab.org>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1689717869; l=1791;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=Ep1Rg7y74qHacqZZsLEFQcfo3UPaVM/TmmdadAIahJk=;
 b=79r3iwydv7BrzBJ8xeBIw44ZpL3k0y40bdLfhfvYVY+oBgQRzCaqFx3T1ppjjEgqqGDlwwn8x
 dSJ99c4HJvQBBm/b+h0QAYqtQeAAm1qZAvGu+olghIfWsyCDiAuaIW/
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

This makes it slightly nicer to report the number of suites.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/testing/selftests/nolibc/nolibc-test.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index 03b1d30f5507..698af242d3e4 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -45,6 +45,8 @@
 #define SINT_MAX_OF_TYPE(type) (((type)1 << (sizeof(type) * 8 - 2)) - (type)1 + ((type)1 << (sizeof(type) * 8 - 2)))
 #define SINT_MIN_OF_TYPE(type) (-SINT_MAX_OF_TYPE(type) - 1)
 
+#define ARRAY_SIZE(x) (sizeof(x) / sizeof(x[0]))
+
 /* will be used to test initialization of environ */
 static char **test_envp;
 
@@ -1184,7 +1186,6 @@ static const struct test test_names[] = {
 	{ .name = "stdlib",     .func = run_stdlib     },
 	{ .name = "vfprintf",   .func = run_vfprintf   },
 	{ .name = "protection", .func = run_protection },
-	{ 0 }
 };
 
 int is_setting_valid(char *test)
@@ -1259,7 +1260,7 @@ int main(int argc, char **argv, char **envp)
 			if (colon)
 				*(colon++) = '\0';
 
-			for (idx = 0; test_names[idx].name; idx++) {
+			for (idx = 0; idx < ARRAY_SIZE(test_names); idx++) {
 				if (strcmp(test, test_names[idx].name) == 0)
 					break;
 			}
@@ -1305,7 +1306,7 @@ int main(int argc, char **argv, char **envp)
 		} while (test && *test);
 	} else {
 		/* no test mentioned, run everything */
-		for (idx = 0; test_names[idx].name; idx++) {
+		for (idx = 0; idx < ARRAY_SIZE(test_names); idx++) {
 			printf("Running test '%s'\n", test_names[idx].name);
 			err = test_names[idx].func(min, max);
 			ret += err;

-- 
2.41.0

