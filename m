Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 544D3A1091
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Aug 2019 06:46:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725844AbfH2Eqo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 29 Aug 2019 00:46:44 -0400
Received: from esa4.mentor.iphmx.com ([68.232.137.252]:9024 "EHLO
        esa4.mentor.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725837AbfH2Eqo (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 29 Aug 2019 00:46:44 -0400
X-Greylist: delayed 426 seconds by postgrey-1.27 at vger.kernel.org; Thu, 29 Aug 2019 00:46:43 EDT
IronPort-SDR: 4b+pR+b8aqDVXxG0TQLWCqdE+PswQUB5Z5vV6p0f1OGkMKX/1ykaEWTRmBC2vLVdYE0ImILweG
 hVU/VJkkV13VpnjbAXI19IVNSlOLynvPOriDqn47JlsdwpBnt1QXvuD1fqmWeSSluYoU8teKPt
 j6RcsbP2Ye716QPWW3ngjhq0IJfnGGZnPzLMKrpLfZyQXj+jK5xzCkOKq6rwY17AfpcojbU71O
 z1DRDt4Synq3lVe1gXtpanaoWyJ/rfuqh/thipCClosKgUX+L39VbqsMaSSAfEibKYyld5ZRAQ
 D1s=
X-IronPort-AV: E=Sophos;i="5.64,442,1559548800"; 
   d="scan'208";a="40867782"
Received: from orw-gwy-02-in.mentorg.com ([192.94.38.167])
  by esa4.mentor.iphmx.com with ESMTP; 28 Aug 2019 20:39:37 -0800
IronPort-SDR: OUgLd41S3pCS25b7dGPxjQLhQJUHImdHM9Qu76yK0BruNKKmvzIxAdU5WKIHEoEZ72hGvKc4Md
 F9D5nwbRIR1LK1qI4LVN/0xLMzjHAjM19Cf2tr/Pgm3/tXGcvAiD2EzuJNz0bInKcPGwwMJiQW
 VP3DN0DbOlzaBfHShlQTS030XKuiAHCPni3MN9X5AJtehnmOSHJBwW/f+u7wBHCn4NRp+kLHnd
 iHVzE4mc4XE+aN6nQzYBHOyjCRHXgG/ob2pqcRSI6GY2G4Gga8vviwbeKQ+fRsT69pY0oSsLN1
 z1M=
From:   "George G. Davis" <george_davis@mentor.com>
To:     Shuah Khan <shuah@kernel.org>,
        Jerry Hoemann <jerry.hoemann@hpe.com>,
        Colin Ian King <colin.king@canonical.com>,
        "George G. Davis" <george_davis@mentor.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH] selftests: watchdog: Add optional file argument
Date:   Thu, 29 Aug 2019 00:39:25 -0400
Message-ID: <1567053566-18971-1-git-send-email-george_davis@mentor.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: svr-orw-mbx-03.mgc.mentorg.com (147.34.90.203) To
 svr-orw-mbx-01.mgc.mentorg.com (147.34.90.201)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Some systems have multiple watchdog devices where the first device
registered is assigned to the /dev/watchdog device file. In order
to test other watchdog devices, add an optional file argument for
selecting non-default watchdog devices for testing.

Signed-off-by: George G. Davis <george_davis@mentor.com>
---
 tools/testing/selftests/watchdog/watchdog-test.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/watchdog/watchdog-test.c b/tools/testing/selftests/watchdog/watchdog-test.c
index c2333c78cf04..ebeb684552b9 100644
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
@@ -92,10 +94,16 @@ int main(int argc, char *argv[])
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

