Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2983DB557C
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Sep 2019 20:41:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728508AbfIQSlF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 17 Sep 2019 14:41:05 -0400
Received: from smtp1.de.adit-jv.com ([93.241.18.167]:45584 "EHLO
        smtp1.de.adit-jv.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727120AbfIQSlF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 17 Sep 2019 14:41:05 -0400
Received: from localhost (smtp1.de.adit-jv.com [127.0.0.1])
        by smtp1.de.adit-jv.com (Postfix) with ESMTP id DACC43C04C0;
        Tue, 17 Sep 2019 20:41:01 +0200 (CEST)
Received: from smtp1.de.adit-jv.com ([127.0.0.1])
        by localhost (smtp1.de.adit-jv.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id mTwY-P88r50i; Tue, 17 Sep 2019 20:40:56 +0200 (CEST)
Received: from HI2EXCH01.adit-jv.com (hi2exch01.adit-jv.com [10.72.92.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp1.de.adit-jv.com (Postfix) with ESMTPS id 4ACD83C00C4;
        Tue, 17 Sep 2019 20:40:56 +0200 (CEST)
Received: from vmlxhi-102.adit-jv.com (10.72.93.184) by HI2EXCH01.adit-jv.com
 (10.72.92.24) with Microsoft SMTP Server (TLS) id 14.3.468.0; Tue, 17 Sep
 2019 20:40:55 +0200
From:   Eugeniu Rosca <erosca@de.adit-jv.com>
To:     Shuah Khan <shuah@kernel.org>,
        "George G. Davis" <george_davis@mentor.com>,
        Jerry Hoemann <jerry.hoemann@hpe.com>,
        Colin Ian King <colin.king@canonical.com>,
        <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Eugeniu Rosca <erosca@de.adit-jv.com>,
        Eugeniu Rosca <roscaeugeniu@gmail.com>
Subject: [PATCH v3 2/2] selftests: watchdog: Add command line option to show watchdog_info
Date:   Tue, 17 Sep 2019 20:40:23 +0200
Message-ID: <20190917184023.16701-2-erosca@de.adit-jv.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190917184023.16701-1-erosca@de.adit-jv.com>
References: <20190917184023.16701-1-erosca@de.adit-jv.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.72.93.184]
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: "George G. Davis" <george_davis@mentor.com>

With the new ioctl(WDIOC_GETSUPPORT) call in place, add a command
line option to show the watchdog_info.

Suggested-by: Eugeniu Rosca <erosca@de.adit-jv.com>
Signed-off-by: George G. Davis <george_davis@mentor.com>
Signed-off-by: Eugeniu Rosca <erosca@de.adit-jv.com>
---
v3:
 - Used v1 as starting point and simplified commit description
 - No change in the contents
 - Applied cleanly to the same base as used in [v1]
v2:
 - https://patchwork.kernel.org/patch/11147663/
v1:
 - https://patchwork.kernel.org/patch/11136285/
 - Applied/tested on commit ce54eab71e210f ("kunit: fix failure to build without printk") of
   https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git/log/?h=next
---
 tools/testing/selftests/watchdog/watchdog-test.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/watchdog/watchdog-test.c b/tools/testing/selftests/watchdog/watchdog-test.c
index 6ed822dc2222..f45e510500c0 100644
--- a/tools/testing/selftests/watchdog/watchdog-test.c
+++ b/tools/testing/selftests/watchdog/watchdog-test.c
@@ -19,7 +19,7 @@
 
 int fd;
 const char v = 'V';
-static const char sopts[] = "bdehp:t:Tn:NLf:";
+static const char sopts[] = "bdehp:t:Tn:NLf:i";
 static const struct option lopts[] = {
 	{"bootstatus",          no_argument, NULL, 'b'},
 	{"disable",             no_argument, NULL, 'd'},
@@ -32,6 +32,7 @@ static const struct option lopts[] = {
 	{"getpretimeout",       no_argument, NULL, 'N'},
 	{"gettimeleft",		no_argument, NULL, 'L'},
 	{"file",          required_argument, NULL, 'f'},
+	{"info",		no_argument, NULL, 'i'},
 	{NULL,                  no_argument, NULL, 0x0}
 };
 
@@ -72,6 +73,7 @@ static void usage(char *progname)
 	printf("Usage: %s [options]\n", progname);
 	printf(" -f, --file\t\tOpen watchdog device file\n");
 	printf("\t\t\tDefault is /dev/watchdog\n");
+	printf(" -i, --info\t\tShow watchdog_info\n");
 	printf(" -b, --bootstatus\tGet last boot status (Watchdog/POR)\n");
 	printf(" -d, --disable\t\tTurn off the watchdog timer\n");
 	printf(" -e, --enable\t\tTurn on the watchdog timer\n");
@@ -216,6 +218,18 @@ int main(int argc, char *argv[])
 		case 'f':
 			/* Handled above */
 			break;
+		case 'i':
+			/*
+			 * watchdog_info was obtained as part of file open
+			 * validation. So we just show it here.
+			 */
+			oneshot = 1;
+			printf("watchdog_info:\n");
+			printf(" identity:\t\t%s\n", info.identity);
+			printf(" firmware_version:\t%u\n",
+			       info.firmware_version);
+			printf(" options:\t\t%08x\n", info.options);
+			break;
 
 		default:
 			usage(argv[0]);
-- 
2.23.0

