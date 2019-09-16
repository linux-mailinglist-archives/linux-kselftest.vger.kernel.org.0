Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C1B34B4091
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Sep 2019 20:49:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390538AbfIPStV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 16 Sep 2019 14:49:21 -0400
Received: from esa2.mentor.iphmx.com ([68.232.141.98]:58261 "EHLO
        esa2.mentor.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726084AbfIPStV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 16 Sep 2019 14:49:21 -0400
IronPort-SDR: fjuu+Bltv+XtFHMi48Xe8tGGCxbw6wxXyT12cWA6qGUnz2g+uEVhtm4LpUOL05bhEymuoSdDlg
 ngFk465xTpum8fmpwQzCDh2OWFBkSYZI8kxVltx4DV1lofGYMAc5zGguBQALkl3ntvcHb9/uoR
 sPqrZwqivFGFBKwjZU+PJ3nwMOXBkhyK5JP5KVvy7T+LEVYcOKkiwfjlJqhXL0UUwzyoF0y5tp
 U3FG2LrnbA30F6BJIcGvM/WHMS4qBIB/XfZzyuweS6UiONnZE6jvZsAGK3DT5dyP+FkMUKOaNf
 Ip0=
X-IronPort-AV: E=Sophos;i="5.64,513,1559548800"; 
   d="scan'208";a="41353811"
Received: from orw-gwy-01-in.mentorg.com ([192.94.38.165])
  by esa2.mentor.iphmx.com with ESMTP; 16 Sep 2019 10:49:20 -0800
IronPort-SDR: XdRCbK2JfQ+cysn9dTuhxIVqaUJz2uR4LsAepk3340hRb8Ksnjsbpe8GEKzf3MPj7WmxwUctgh
 lsAE5q3XnvLgTg5XGHGKaE2HiyZ3Uk5oQllQmnpbbovWohDQTTuR7q3TJFANnzbpM6HlJeXnEr
 kemm+wS6u350XuM1qhF0xSN+7sSlWQH5FWh653ARmchynWeOVtWbJH7oXIgBaN4Brcgdzzw5eP
 yS57oW3Xbak5eTRRBUmWw+6UM416R6jzXxUvjFK5UHLQDMttsLtZ7jCtJoabryqT5qZsNaGmqB
 io0=
From:   "George G. Davis" <george_davis@mentor.com>
To:     Eugeniu Rosca <erosca@de.adit-jv.com>,
        Eugeniu Rosca <roscaeugeniu@gmail.com>,
        Shuah Khan <shuah@kernel.org>,
        "George G. Davis" <george_davis@mentor.com>,
        Jerry Hoemann <jerry.hoemann@hpe.com>,
        Colin Ian King <colin.king@canonical.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] selftests: watchdog: Validate optional file argument
Date:   Mon, 16 Sep 2019 14:49:10 -0400
Message-ID: <1568659751-1845-1-git-send-email-george_davis@mentor.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: svr-orw-mbx-01.mgc.mentorg.com (147.34.90.201) To
 svr-orw-mbx-01.mgc.mentorg.com (147.34.90.201)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

As reported by Eugeniu Rosca, a side of affect of commit c3f2490d6e92
("selftests: watchdog: Add optional file argument") is that arbitrary files
may be opened for watchdog testing, e.g.

./watchdog-test  -f /dev/zero
Watchdog Ticking Away!

To prevent watchdog-test from operating on non-watchdog device files,
validate that a file is indeed a watchdog device via an
ioctl(WDIOC_GETSUPPORT) call.

While we're at it, since the watchdog_info is available as a result of the
ioctl(WDIOC_GETSUPPORT) call, add a command line option to optionally show
the watchdog_info.

Reported-by: Eugeniu Rosca <erosca@de.adit-jv.com>
Tested-by: Eugeniu Rosca <erosca@de.adit-jv.com>
Signed-off-by: George G. Davis <george_davis@mentor.com>
Signed-off-by: Eugeniu Rosca <erosca@de.adit-jv.com>
---
v1: Applied/tested on commit ce54eab71e210f ("kunit: fix failure to build without printk") of
    https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git/log/?h=next
v2: Squashed [1] and [2], and update commit description as discussed in [3].
    [1] https://patchwork.kernel.org/patch/11136283/
    [2] https://patchwork.kernel.org/patch/11136285/
    [3] https://patchwork.kernel.org/patch/11136285/#22883573
---
 tools/testing/selftests/watchdog/watchdog-test.c | 27 +++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/watchdog/watchdog-test.c b/tools/testing/selftests/watchdog/watchdog-test.c
index afff120c7be6..f45e510500c0 100644
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
@@ -97,6 +99,7 @@ int main(int argc, char *argv[])
 	int c;
 	int oneshot = 0;
 	char *file = "/dev/watchdog";
+	struct watchdog_info info;
 
 	setbuf(stdout, NULL);
 
@@ -118,6 +121,16 @@ int main(int argc, char *argv[])
 		exit(-1);
 	}
 
+	/*
+	 * Validate that `file` is a watchdog device
+	 */
+	ret = ioctl(fd, WDIOC_GETSUPPORT, &info);
+	if (ret) {
+		printf("WDIOC_GETSUPPORT error '%s'\n", strerror(errno));
+		close(fd);
+		exit(ret);
+	}
+
 	optind = 0;
 
 	while ((c = getopt_long(argc, argv, sopts, lopts, NULL)) != -1) {
@@ -205,6 +218,18 @@ int main(int argc, char *argv[])
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
2.7.4

