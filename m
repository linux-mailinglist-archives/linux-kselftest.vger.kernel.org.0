Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E50EA3E74
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Aug 2019 21:32:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728180AbfH3Tch (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 30 Aug 2019 15:32:37 -0400
Received: from esa1.mentor.iphmx.com ([68.232.129.153]:7426 "EHLO
        esa1.mentor.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728242AbfH3Tch (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 30 Aug 2019 15:32:37 -0400
IronPort-SDR: X8fYbZV9kIhBAz3xaiJwabvVgUuAjxpsXsdSwmUl3SrfMdDgOxkW5PUELxt5VDmo37YpDbo0dh
 ctlApsNp9KHshW36jxsUMOICVhhwtHslkpJbEl9QxX+TOZPFqTLxivmlNDEkNrJVqAObrLmDeg
 KqHpeNNBQKjAhVy5BM2nBAxNVj4ikDtWzeGVfeG8gRIbAAqMl2048B8aDM79HMUS2zeihQ+Z+Y
 82KUWKYqADKSQ/TdZainFbOv4fB80Oz5JgRFPLg+qWCoFZLKQHUXEknTTji+Z29iOwzoNMOSZf
 dNE=
X-IronPort-AV: E=Sophos;i="5.64,447,1559548800"; 
   d="scan'208";a="42727619"
Received: from orw-gwy-01-in.mentorg.com ([192.94.38.165])
  by esa1.mentor.iphmx.com with ESMTP; 30 Aug 2019 11:32:36 -0800
IronPort-SDR: iXn2p0LobRNISsxQgHKrhlc6v2VNwcoDy6dCvF6WpJxSsvAgXPJxbSy5CKSc+Q9tPh/GDd+VOj
 y1lihhvoh33Fhv3Cg/zBxV+F3Ghvy4HYxKNPOIJYyKIhr0cvtPbW1PauPj95uiavsgTEF8mbDd
 euluEADbiFelQM0bVUKgt6M8a7D/OYojZVWWUSacNZRqLLOq6SDuCc2Mdc1+99HHxgmDUwol/L
 f8u+ewf1A+52SnKw2gsRq+vJAppzgl3Y4Ob3vz6wUCPaBidZwSk5BXWSqPWgBGOOcKRVBIqPL9
 i0g=
From:   "George G. Davis" <george_davis@mentor.com>
To:     <shuah@kernel.org>, Jerry Hoemann <jerry.hoemann@hpe.com>,
        "George G. Davis" <george_davis@mentor.com>,
        Colin Ian King <colin.king@canonical.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
CC:     Eugeniu Rosca <erosca@de.adit-jv.com>
Subject: [PATCH v3] selftests: watchdog: Add optional file argument
Date:   Fri, 30 Aug 2019 15:32:23 -0400
Message-ID: <1567193545-25171-1-git-send-email-george_davis@mentor.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: svr-orw-mbx-04.mgc.mentorg.com (147.34.90.204) To
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
v3:
- Split long printf line in two as requested by Shuah Khan
---
 tools/testing/selftests/watchdog/watchdog-test.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/watchdog/watchdog-test.c b/tools/testing/selftests/watchdog/watchdog-test.c
index c2333c78cf04..6a68b486dd61 100644
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
 
@@ -69,6 +70,8 @@ static void term(int sig)
 static void usage(char *progname)
 {
 	printf("Usage: %s [options]\n", progname);
+	printf(" -f, --file          Open watchdog device file\n");
+	printf("                     Default is /dev/watchdog\n");
 	printf(" -b, --bootstatus    Get last boot status (Watchdog/POR)\n");
 	printf(" -d, --disable       Turn off the watchdog timer\n");
 	printf(" -e, --enable        Turn on the watchdog timer\n");
@@ -92,14 +95,20 @@ int main(int argc, char *argv[])
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
@@ -108,6 +117,8 @@ int main(int argc, char *argv[])
 		exit(-1);
 	}
 
+	optind = 0;
+
 	while ((c = getopt_long(argc, argv, sopts, lopts, NULL)) != -1) {
 		switch (c) {
 		case 'b':
@@ -190,6 +201,9 @@ int main(int argc, char *argv[])
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

