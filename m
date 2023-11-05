Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F62C7E13DD
	for <lists+linux-kselftest@lfdr.de>; Sun,  5 Nov 2023 15:22:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbjKEOWi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 5 Nov 2023 09:22:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbjKEOWh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 5 Nov 2023 09:22:37 -0500
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57AE6D9;
        Sun,  5 Nov 2023 06:22:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1699194152;
        bh=FhnRHVVe+PHf+ugZHAO2JXY1kUkT30VNjI8oHcu7ofI=;
        h=From:Date:Subject:To:Cc:From;
        b=YUBKJcLHqXU2ru+rtoKJxlq5qZmu11rDpDlc6so4DqTFycyLQPp+tV4eeT4b3adUr
         gTEkDRAayn0i6DRitO9TRjHNNX/0c9s60VswSGwK5wYA4ZL3eJKEIqkSkY6GDX9RVa
         Bu6LW67WSauno+GM1f7ujnrO4DdlNXaac4RckWfg=
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date:   Sun, 05 Nov 2023 15:22:30 +0100
Subject: [PATCH] selftests/nolibc: fix testcase status alignment
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20231105-nolibc-align-v1-1-5bfc542cb6ee@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIACWlR2UC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI2NDQwNT3bz8nMykZN3EnMz0PF1zU0tLo6SUtDRTExMloJaCotS0zAqwcdG
 xtbUAXDeqqF4AAAA=
To:     Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1699194151; l=2095;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=FhnRHVVe+PHf+ugZHAO2JXY1kUkT30VNjI8oHcu7ofI=;
 b=mdM3igfqOhDiyq9aAsX9NxePvbRBJPTaK5DAcDpvpQdAAEgJTxRpIWCr3/x867hlU0Wk2+Qhm
 FlGM/Hz72RzBFUuzYLzYw7S+JIqJgGEVUjfIGN8eDv3tAYW+9bM0Hn5
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

Center-align all possible status reports.
Before OK and FAIL were center-aligned in relation to each other but
SKIPPED and FAILED would be left-aligned.

Before:

7 environ_addr = <0x7fffef3e7c50>                                [OK]
8 environ_envp = <0x7fffef3e7c58>                               [FAIL]
9 environ_auxv                                                  [SKIPPED]
10 environ_total                                                [SKIPPED]
11 environ_HOME = <0x7fffef3e99bd>                               [OK]
12 auxv_addr                                                    [SKIPPED]
13 auxv_AT_UID = 1000                                            [OK]

After:

7 environ_addr = <0x7ffff13b00a0>                                 [OK]
8 environ_envp = <0x7ffff13b00a8>                                [FAIL]
9 environ_auxv                                                  [SKIPPED]
10 environ_total                                                [SKIPPED]
11 environ_HOME = <0x7ffff13b19bd>                                [OK]
12 auxv_addr                                                    [SKIPPED]
13 auxv_AT_UID = 1000                                             [OK]

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/testing/selftests/nolibc/nolibc-test.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index 2f10541e6f38..e173014f6b66 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -150,11 +150,11 @@ static void result(int llen, enum RESULT r)
 	const char *msg;
 
 	if (r == OK)
-		msg = " [OK]";
+		msg = "  [OK]";
 	else if (r == SKIPPED)
 		msg = "[SKIPPED]";
 	else
-		msg = "[FAIL]";
+		msg = " [FAIL]";
 
 	if (llen < 64)
 		putcharn(' ', 64 - llen);

---
base-commit: 6de6466e41182875252fe09658f9b7d74c4fa43c
change-id: 20231105-nolibc-align-75992bdff544

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>

