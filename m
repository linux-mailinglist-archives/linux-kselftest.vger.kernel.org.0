Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A5937A4096
	for <lists+linux-kselftest@lfdr.de>; Sat, 31 Aug 2019 00:31:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728181AbfH3Wbl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 30 Aug 2019 18:31:41 -0400
Received: from esa4.mentor.iphmx.com ([68.232.137.252]:12348 "EHLO
        esa4.mentor.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728176AbfH3Wbl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 30 Aug 2019 18:31:41 -0400
IronPort-SDR: O05l+jUxCjmHsNnF4cxKCr8VXWBTKAFC8Gt2oD2R9os82WupN4uWgwtTMvGFRAK6aC/AT/xzYs
 FzQYoY8LpXIZV7Zf2rkAmFo2DGEXxXQudUihYOkLtisI97iGJBAoc66jot8oBGxVkqSrB3NgME
 YqjOP/QKpZBh+HiR3No+/M1ckKlKSbsNJbZXrUEYUfzKCdeDdngL/h/NEVee0gWT0I7grmBytB
 KHtLOYtLPMmWarE3qprSJ6k3gTgCwhbdGpB1rWUzt5VfeQ7gv9z11Uaa/Q7rJHESLNg3I9JBey
 5xU=
X-IronPort-AV: E=Sophos;i="5.64,447,1559548800"; 
   d="scan'208";a="40928797"
Received: from orw-gwy-02-in.mentorg.com ([192.94.38.167])
  by esa4.mentor.iphmx.com with ESMTP; 30 Aug 2019 14:31:40 -0800
IronPort-SDR: Hhsgt2LVcsTRNobsyoISTMBeOSJZieSPCWyRNFLMy1hsywW6cmFcaqWUXH10I335KUWuOhbbxD
 0fZf++EvhI0MPbm5r23d7tfd+gb8SMlrZfmXYU0Z20Qlq6loZ4ezQf8kF7mcCipN1wyU19wORd
 8K+Ovc+OlFfui1qNsmC/SuiX0h+Vxo/gszHEdECWs4HckiTo6pxv0x0JsIrMQmfoj1seZlSsOy
 jqoT383wp+HsoiKrNwQt3qaF6Mx59hW+LRrZGr/EmYctq/ITxKwn91AM4+1Gimkdrt/ch8P6QA
 510=
From:   "George G. Davis" <george_davis@mentor.com>
To:     <shuah@kernel.org>, Jerry Hoemann <jerry.hoemann@hpe.com>,
        "George G. Davis" <george_davis@mentor.com>,
        Colin Ian King <colin.king@canonical.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
CC:     Eugeniu Rosca <erosca@de.adit-jv.com>
Subject: [PATCH] selftests: watchdog: cleanup whitespace in usage options
Date:   Fri, 30 Aug 2019 18:31:33 -0400
Message-ID: <1567204294-8840-1-git-send-email-george_davis@mentor.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: svr-orw-mbx-04.mgc.mentorg.com (147.34.90.204) To
 svr-orw-mbx-01.mgc.mentorg.com (147.34.90.201)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Convert hard spaces to tabs in usage options.

Suggested-by: Shuah Khan <shuah@kernel.org>
Signed-off-by: George G. Davis <george_davis@mentor.com>
---
 tools/testing/selftests/watchdog/watchdog-test.c | 25 ++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/watchdog/watchdog-test.c b/tools/testing/selftests/watchdog/watchdog-test.c
index c35989ffbc6b..3fff1ee20a7f 100644
--- a/tools/testing/selftests/watchdog/watchdog-test.c
+++ b/tools/testing/selftests/watchdog/watchdog-test.c
@@ -70,18 +70,19 @@ static void term(int sig)
 static void usage(char *progname)
 {
 	printf("Usage: %s [options]\n", progname);
-	printf(" -f, --file          Open watchdog device file\n");
-	printf("                     Default is /dev/watchdog\n");
-	printf(" -b, --bootstatus    Get last boot status (Watchdog/POR)\n");
-	printf(" -d, --disable       Turn off the watchdog timer\n");
-	printf(" -e, --enable        Turn on the watchdog timer\n");
-	printf(" -h, --help          Print the help message\n");
-	printf(" -p, --pingrate=P    Set ping rate to P seconds (default %d)\n", DEFAULT_PING_RATE);
-	printf(" -t, --timeout=T     Set timeout to T seconds\n");
-	printf(" -T, --gettimeout    Get the timeout\n");
-	printf(" -n, --pretimeout=T  Set the pretimeout to T seconds\n");
-	printf(" -N, --getpretimeout Get the pretimeout\n");
-	printf(" -L, --gettimeleft   Get the time left until timer expires\n");
+	printf(" -f, --file\t\tOpen watchdog device file\n");
+	printf("\t\t\tDefault is /dev/watchdog\n");
+	printf(" -b, --bootstatus\tGet last boot status (Watchdog/POR)\n");
+	printf(" -d, --disable\t\tTurn off the watchdog timer\n");
+	printf(" -e, --enable\t\tTurn on the watchdog timer\n");
+	printf(" -h, --help\t\tPrint the help message\n");
+	printf(" -p, --pingrate=P\tSet ping rate to P seconds (default %d)\n",
+	       DEFAULT_PING_RATE);
+	printf(" -t, --timeout=T\tSet timeout to T seconds\n");
+	printf(" -T, --gettimeout\tGet the timeout\n");
+	printf(" -n, --pretimeout=T\tSet the pretimeout to T seconds\n");
+	printf(" -N, --getpretimeout\tGet the pretimeout\n");
+	printf(" -L, --gettimeleft\tGet the time left until timer expires\n");
 	printf("\n");
 	printf("Parameters are parsed left-to-right in real-time.\n");
 	printf("Example: %s -d -t 10 -p 5 -e\n", progname);
-- 
2.7.4

