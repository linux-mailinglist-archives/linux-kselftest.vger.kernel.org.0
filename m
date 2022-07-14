Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AF2E575581
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Jul 2022 20:58:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232128AbiGNS54 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 14 Jul 2022 14:57:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240896AbiGNS5f (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 14 Jul 2022 14:57:35 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12DEB6B257
        for <linux-kselftest@vger.kernel.org>; Thu, 14 Jul 2022 11:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=k1; bh=O6B474X8P2gxKKp7qXnpFakS0XL
        VtX/7FNJL6iki3kU=; b=XNplPfaLVlLVZl1NYESMAVjWqAyxa/XruwrOTvEXaA7
        HEnTSzeuh9HeTt2Yf+VmVbcD45hC2BfR1/ouh8pVtVgLfxAi2rsqgm2pwJoys1Lt
        OH42mL9E8+AMJvrIICLq0vJv4y170xd57sJmPXKMimDhAd7aY8MFg8H6FmMJ0a8w
        =
Received: (qmail 704724 invoked from network); 14 Jul 2022 20:57:30 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 14 Jul 2022 20:57:30 +0200
X-UD-Smtp-Session: l3s3148p1@4dM8ecjjRsIgAwDtxwdRAEXXn+yo/Rze
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-renesas-soc@vger.kernel.org
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        John Stultz <jstultz@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>, Shuah Khan <shuah@kernel.org>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH v2] selftests: timers: clocksource-switch: add 'runtime' command line parameter
Date:   Thu, 14 Jul 2022 20:57:21 +0200
Message-Id: <20220714185721.48125-1-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

So the user can decide how long the test should run.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Acked-by: John Stultz <jstultz@google.com>
---

Change since V1:
* added the new parameter to the help printout

 tools/testing/selftests/timers/clocksource-switch.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/timers/clocksource-switch.c b/tools/testing/selftests/timers/clocksource-switch.c
index 5256e6215980..577e4b74211a 100644
--- a/tools/testing/selftests/timers/clocksource-switch.c
+++ b/tools/testing/selftests/timers/clocksource-switch.c
@@ -124,17 +124,22 @@ int main(int argc, char **argv)
 	char orig_clk[512];
 	int count, i, status, opt;
 	int do_sanity_check = 1;
+	int runtime = 60;
 	pid_t pid;
 
 	/* Process arguments */
-	while ((opt = getopt(argc, argv, "s")) != -1) {
+	while ((opt = getopt(argc, argv, "st:")) != -1) {
 		switch (opt) {
 		case 's':
 			do_sanity_check = 0;
 			break;
+		case 't':
+			runtime = atoi(optarg);
+			break;
 		default:
-			printf("Usage: %s [-s]\n", argv[0]);
+			printf("Usage: %s [-s] [-t <secs>]\n", argv[0]);
 			printf("	-s: skip sanity checks\n");
+			printf("	-t: Number of seconds to run\n");
 			exit(-1);
 		}
 	}
@@ -167,7 +172,7 @@ int main(int argc, char **argv)
 	printf("Running Asynchronous Switching Tests...\n");
 	pid = fork();
 	if (!pid)
-		return run_tests(60);
+		return run_tests(runtime);
 
 	while (pid != waitpid(pid, &status, WNOHANG))
 		for (i = 0; i < count; i++)
-- 
2.35.1

