Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3AEB2A3728
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Aug 2019 14:53:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727976AbfH3Mx2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 30 Aug 2019 08:53:28 -0400
Received: from esa4.mentor.iphmx.com ([68.232.137.252]:1367 "EHLO
        esa4.mentor.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727170AbfH3Mx2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 30 Aug 2019 08:53:28 -0400
IronPort-SDR: ftUQrbgKZqMqXP0GgI/qioBlKP7RWDhlP49AneyLRcaH2p0FHsqa3cxezZUcLXII9rIWl7MZrM
 1lFuZxgXuMKfK4oNjBS319mcKxcVOnvP13RPddtU3Y41Yh2i5DhoSNBnR8cvqgvjzdc8koOSUh
 rMNvqd2OE4Gs9Fab9iswKUL4kYsQ7COgMWoO5WFiH0YlOFZ9tyULA8SrQIz2DCxvSU4PMUC3K0
 1RuXzIgdF6MMsHZJ0AOaXOQY3aLgcuAeTnVhmZXEiu3rGKZwSusaij+ZYCxaK64L3ejvQo5BI6
 Y7w=
X-IronPort-AV: E=Sophos;i="5.64,447,1559548800"; 
   d="scan'208";a="40914045"
Received: from orw-gwy-01-in.mentorg.com ([192.94.38.165])
  by esa4.mentor.iphmx.com with ESMTP; 30 Aug 2019 04:53:27 -0800
IronPort-SDR: BfUqS4T6iM8gFkQUoQ5yVoMCEwqCwm3BatoU4xc4GNO8X3symaUxj3awZnPIVWZIm+uGGVxW3j
 +ixhfIqIx5hfG5RcUY22cgNSPbAOkG8iLlIlQElMc/z9EsOf3XqNjpulN3w9a2pyZXaXBuLqnm
 cS6ahfirX6UJGmCrcI/xfwreHjx4V3b3BDzrD7927b/3k5vEhEdnmqo1GoFugo8w60OkxQKQOD
 XynQ4rbKai8ol54UlLsHzDczMScsifjTcqQw8YQKxaZng5YfftVOLTiiLiyyjidGO/zq7Yv+Ey
 NFY=
From:   "George G. Davis" <george_davis@mentor.com>
To:     Shuah Khan <shuah@kernel.org>,
        Jerry Hoemann <jerry.hoemann@hpe.com>,
        Colin Ian King <colin.king@canonical.com>,
        "George G. Davis" <george_davis@mentor.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
CC:     Eugeniu Rosca <erosca@de.adit-jv.com>
Subject: [PATCH v2] selftests: watchdog: Add optional file argument
Date:   Fri, 30 Aug 2019 08:53:16 -0400
Message-ID: <1567169597-10330-1-git-send-email-george_davis@mentor.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SVR-ORW-MBX-09.mgc.mentorg.com (147.34.90.209) To
 svr-orw-mbx-01.mgc.mentorg.com (147.34.90.201)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Some systems have multiple watchdog devices where the first device
registered is assigned to the /dev/watchdog device file. In order
to test other watchdog devices, add an optional file argument for
selecting non-default watchdog devices for testing.

Tested-by: Eugeniu Rosca <erosca@de.adit-jv.com>
Signed-off-by: George G. Davis <george_davis@mentor.com>
---
v1:
- https://lkml.org/lkml/2019/8/29/16
v2:
- Update printf for ENOENT case based on report from Eugeniu Rosca
---
 tools/testing/selftests/watchdog/watchdog-test.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/watchdog/watchdog-test.c b/tools/testing/selftests/watchdog/watchdog-test.c
index c2333c78cf04..9f17cae61007 100644
--- a/tools/testing/selftests/watchdog/watchdog-test.c
+++ b/tools/testing/selftests/watchdog/watchdog-test.c
@@ -19,7 +19,7 @@
 
 int fd;
 const char v = 'V';
-static const char sopts[] = "bdehp:t:Tn:NL";
+static const char sopts[] = "bdehp:t:Tn:NLf:";
 static const struct option lopts[] = {
 	{"bootstatus",          no_argument, NULL, 'b'},
 	{"disable",             no_argument, NULL, 'd'},
@@ -31,6 +31,7 @@ static const struct option lopts[] = {
 	{"pretimeout",    required_argument, NULL, 'n'},
 	{"getpretimeout",       no_argument, NULL, 'N'},
 	{"gettimeleft",		no_argument, NULL, 'L'},
+	{"file",          required_argument, NULL, 'f'},
 	{NULL,                  no_argument, NULL, 0x0}
 };
 
@@ -69,6 +70,7 @@ static void term(int sig)
 static void usage(char *progname)
 {
 	printf("Usage: %s [options]\n", progname);
+	printf(" -f, --file          Open watchdog device file (default is /dev/watchdog)\n");
 	printf(" -b, --bootstatus    Get last boot status (Watchdog/POR)\n");
 	printf(" -d, --disable       Turn off the watchdog timer\n");
 	printf(" -e, --enable        Turn on the watchdog timer\n");
@@ -92,14 +94,20 @@ int main(int argc, char *argv[])
 	int ret;
 	int c;
 	int oneshot = 0;
+	char *file = "/dev/watchdog";
 
 	setbuf(stdout, NULL);
 
-	fd = open("/dev/watchdog", O_WRONLY);
+	while ((c = getopt_long(argc, argv, sopts, lopts, NULL)) != -1) {
+		if (c == 'f')
+			file = optarg;
+	}
+
+	fd = open(file, O_WRONLY);
 
 	if (fd == -1) {
 		if (errno == ENOENT)
-			printf("Watchdog device not enabled.\n");
+			printf("Watchdog device (%s) not found.\n", file);
 		else if (errno == EACCES)
 			printf("Run watchdog as root.\n");
 		else
@@ -108,6 +116,8 @@ int main(int argc, char *argv[])
 		exit(-1);
 	}
 
+	optind = 0;
+
 	while ((c = getopt_long(argc, argv, sopts, lopts, NULL)) != -1) {
 		switch (c) {
 		case 'b':
@@ -190,6 +200,9 @@ int main(int argc, char *argv[])
 			else
 				printf("WDIOC_GETTIMELEFT error '%s'\n", strerror(errno));
 			break;
+		case 'f':
+			/* Handled above */
+			break;
 
 		default:
 			usage(argv[0]);
-- 
2.7.4

