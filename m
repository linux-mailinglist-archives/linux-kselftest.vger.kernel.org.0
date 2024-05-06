Return-Path: <linux-kselftest+bounces-9516-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D1D6B8BCCA7
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 May 2024 13:14:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA174B22911
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 May 2024 11:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EED8114386A;
	Mon,  6 May 2024 11:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="x/QReSiT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB3D5142E79;
	Mon,  6 May 2024 11:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714994032; cv=none; b=JDAHOlr5d+DYJCv3HbDz6XK5Cg4Bq+j4SCeAW84zbVIReJ2oRUDXMAr9KtRYN4RrqlftABuf1rFybEXIFzNUz2EfZa5KPL0iVNm0qqEx/Z1Pn6u24XjrmhQD9hQaZefyY+1Bk54gSJDS8hrtIFbUnvAXzqM0gfZBtMJVepQpRUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714994032; c=relaxed/simple;
	bh=woWOTHnfh2HdoetPJoDszVlFfaBtsAUbrm3mH8JUU+k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JrKS9Uv9tEih7/v4oHcK4rtSK8ekTeD8qFk0UKV/u8owMsIiFwLacUJCCf6oVflOzd3q35ZngW388qdyKbQQZhPasXmkU7n01zlVpVqVJXhBRRdsImN7v1JuAS6KzHb5Sw97RUrs/IxTTkTO3RQ+lEDhKYbjghQgSPFyOUkeZU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=x/QReSiT; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1714994029;
	bh=woWOTHnfh2HdoetPJoDszVlFfaBtsAUbrm3mH8JUU+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=x/QReSiTRBJWVZvvJ1WLKaGYVs1lRDIZb3ymQVzvV1SEk73+mLAp6Fh0p9gIWK8do
	 QVm2bw4yc0MJJmFKp8ythX33PLe9MhD2EesJ3ZABVmmhud3DMgtY4xF4wBYTnMoYlD
	 KrJlcdEXEPMJuMSsLI01bm3kihskelLdnS31XKt3qM2xUHwUlWVQtsIbeIx9oTpFTs
	 G88bcKzd9qJfZYdmPvqJCs1+O+8OjCEZhl1Wq1l5kedVXQV28fyuHO8w4JUDD+EEGS
	 0bZ5NZ+OFJokcyx1b0d53snuV5pwMpGvN5g89Oa0xxGrJszuaM9Y/nMbXyc9pfObbr
	 NhPfdHGVvtGvg==
Received: from localhost.localdomain (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laura.nao)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id B421637820D8;
	Mon,  6 May 2024 11:13:48 +0000 (UTC)
From: Laura Nao <laura.nao@collabora.com>
To: shuah@kernel.org
Cc: kernel@collabora.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Laura Nao <laura.nao@collabora.com>
Subject: [PATCH 2/2] selftests/watchdog: convert the test output to KTAP format
Date: Mon,  6 May 2024 13:13:59 +0200
Message-Id: <20240506111359.224579-3-laura.nao@collabora.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240506111359.224579-1-laura.nao@collabora.com>
References: <20240506111359.224579-1-laura.nao@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Modify the script output to conform to the KTAP format standard. The
number of tests executed is determined by the script arguments, and
options such as -c, -f, -h, -i, and -p do not impact the total test
count.

No functional change is intended.

Signed-off-by: Laura Nao <laura.nao@collabora.com>
---
 .../selftests/watchdog/watchdog-test.c        | 154 ++++++++++--------
 1 file changed, 89 insertions(+), 65 deletions(-)

diff --git a/tools/testing/selftests/watchdog/watchdog-test.c b/tools/testing/selftests/watchdog/watchdog-test.c
index 786cc5a26206..90f32de9e194 100644
--- a/tools/testing/selftests/watchdog/watchdog-test.c
+++ b/tools/testing/selftests/watchdog/watchdog-test.c
@@ -22,6 +22,7 @@
 #include <sys/ioctl.h>
 #include <linux/types.h>
 #include <linux/watchdog.h>
+#include "../kselftest.h"
 
 #define DEFAULT_PING_RATE	1
 #define DEFAULT_PING_COUNT	5
@@ -29,6 +30,7 @@
 int fd;
 const char v = 'V';
 static const char sopts[] = "bdehp:c:st:Tn:NLf:i";
+static const char topts[] = "bdeLn:Nst:T";
 static const struct option lopts[] = {
 	{"bootstatus",          no_argument, NULL, 'b'},
 	{"disable",             no_argument, NULL, 'd'},
@@ -52,7 +54,7 @@ static const struct option lopts[] = {
  * the PC Watchdog card to reset its internal timer so it doesn't trigger
  * a computer reset.
  */
-static void keep_alive(void)
+static int keep_alive(void)
 {
 	int dummy;
 	int ret;
@@ -60,6 +62,8 @@ static void keep_alive(void)
 	ret = ioctl(fd, WDIOC_KEEPALIVE, &dummy);
 	if (!ret)
 		printf(".");
+
+	return ret;
 }
 
 /*
@@ -73,36 +77,36 @@ static void term(int sig)
 
 	close(fd);
 	if (ret < 0)
-		printf("\nStopping watchdog ticks failed (%d)...\n", errno);
+		ksft_print_msg("\nStopping watchdog ticks failed (%d)...\n", errno);
 	else
-		printf("\nStopping watchdog ticks...\n");
+		ksft_print_msg("\nStopping watchdog ticks...\n");
 	exit(0);
 }
 
 static void usage(char *progname)
 {
-	printf("Usage: %s [options]\n", progname);
-	printf(" -f, --file\t\tOpen watchdog device file\n");
-	printf("\t\t\tDefault is /dev/watchdog\n");
-	printf(" -i, --info\t\tShow watchdog_info\n");
-	printf(" -s, --status\t\tGet status & supported features\n");
-	printf(" -b, --bootstatus\tGet last boot status (Watchdog/POR)\n");
-	printf(" -d, --disable\t\tTurn off the watchdog timer\n");
-	printf(" -e, --enable\t\tTurn on the watchdog timer\n");
-	printf(" -h, --help\t\tPrint the help message\n");
-	printf(" -p, --pingrate=P\tSet ping rate to P seconds (default %d)\n",
+	ksft_print_msg("Usage: %s [options]\n", progname);
+	ksft_print_msg(" -f, --file\t\tOpen watchdog device file\n");
+	ksft_print_msg("\t\t\tDefault is /dev/watchdog\n");
+	ksft_print_msg(" -i, --info\t\tShow watchdog_info\n");
+	ksft_print_msg(" -s, --status\t\tGet status & supported features\n");
+	ksft_print_msg(" -b, --bootstatus\tGet last boot status (Watchdog/POR)\n");
+	ksft_print_msg(" -d, --disable\t\tTurn off the watchdog timer\n");
+	ksft_print_msg(" -e, --enable\t\tTurn on the watchdog timer\n");
+	ksft_print_msg(" -h, --help\t\tPrint the help message\n");
+	ksft_print_msg(" -p, --pingrate=P\tSet ping rate to P seconds (default %d)\n",
 	       DEFAULT_PING_RATE);
-	printf(" -c, --pingcount=C\tSet number of pings to C (default %d)\n",
+	ksft_print_msg(" -c, --pingcount=C\tSet number of pings to C (default %d)\n",
 	       DEFAULT_PING_COUNT);
-	printf(" -t, --timeout=T\tSet timeout to T seconds\n");
-	printf(" -T, --gettimeout\tGet the timeout\n");
-	printf(" -n, --pretimeout=T\tSet the pretimeout to T seconds\n");
-	printf(" -N, --getpretimeout\tGet the pretimeout\n");
-	printf(" -L, --gettimeleft\tGet the time left until timer expires\n");
-	printf("\n");
-	printf("Parameters are parsed left-to-right in real-time.\n");
-	printf("Example: %s -d -t 10 -p 5 -e\n", progname);
-	printf("Example: %s -t 12 -T -n 7 -N\n", progname);
+	ksft_print_msg(" -t, --timeout=T\tSet timeout to T seconds\n");
+	ksft_print_msg(" -T, --gettimeout\tGet the timeout\n");
+	ksft_print_msg(" -n, --pretimeout=T\tSet the pretimeout to T seconds\n");
+	ksft_print_msg(" -N, --getpretimeout\tGet the pretimeout\n");
+	ksft_print_msg(" -L, --gettimeleft\tGet the time left until timer expires\n");
+	ksft_print_msg("\n");
+	ksft_print_msg("Parameters are parsed left-to-right in real-time.\n");
+	ksft_print_msg("Example: %s -d -t 10 -p 5 -e\n", progname);
+	ksft_print_msg("Example: %s -t 12 -T -n 7 -N\n", progname);
 }
 
 struct wdiof_status {
@@ -128,13 +132,13 @@ static void print_status(int flags)
 	int wdiof = 0;
 
 	if (flags == WDIOS_UNKNOWN) {
-		printf("Unknown status error from WDIOC_GETSTATUS\n");
+		ksft_print_msg("Unknown status error from WDIOC_GETSTATUS\n");
 		return;
 	}
 
 	for (wdiof = 0; wdiof < WDIOF_NUM_STATUS; wdiof++) {
 		if (flags & wdiof_status[wdiof].flag)
-			printf("Support/Status: %s\n",
+			ksft_print_msg("Support/Status: %s\n",
 				wdiof_status[wdiof].status_str);
 	}
 }
@@ -156,18 +160,18 @@ static void print_boot_status(int flags)
 	int wdiof = 0;
 
 	if (flags == WDIOF_UNKNOWN) {
-		printf("Unknown flag error from WDIOC_GETBOOTSTATUS\n");
+		ksft_print_msg("Unknown flag error from WDIOC_GETBOOTSTATUS\n");
 		return;
 	}
 
 	if (flags == 0) {
-		printf("Last boot is caused by: Power-On-Reset\n");
+		ksft_print_msg("Last boot is caused by: Power-On-Reset\n");
 		return;
 	}
 
 	for (wdiof = 0; wdiof < WDIOF_NUM_BOOTSTATUS; wdiof++) {
 		if (flags & wdiof_bootstatus[wdiof].flag)
-			printf("Last boot is caused by: %s\n",
+			ksft_print_msg("Last boot is caused by: %s\n",
 				wdiof_bootstatus[wdiof].status_str);
 	}
 }
@@ -183,25 +187,28 @@ int main(int argc, char *argv[])
 	char *file = "/dev/watchdog";
 	struct watchdog_info info;
 	int temperature;
+	/* run WDIOC_KEEPALIVE test by default */
+	int test_num = 1;
 
 	setbuf(stdout, NULL);
 
 	while ((c = getopt_long(argc, argv, sopts, lopts, NULL)) != -1) {
 		if (c == 'f')
 			file = optarg;
+
+		if (strchr(topts, c))
+			test_num++;
 	}
 
 	fd = open(file, O_WRONLY);
 
 	if (fd == -1) {
 		if (errno == ENOENT)
-			printf("Watchdog device (%s) not found.\n", file);
+			ksft_exit_skip("Watchdog device (%s) not found.\n", file);
 		else if (errno == EACCES)
-			printf("Run watchdog as root.\n");
+			ksft_exit_skip("Run watchdog as root.\n");
 		else
-			printf("Watchdog device open failed %s\n",
-				strerror(errno));
-		exit(-1);
+			ksft_exit_skip("Watchdog device open failed %s\n", strerror(errno));
 	}
 
 	/*
@@ -209,13 +216,15 @@ int main(int argc, char *argv[])
 	 */
 	ret = ioctl(fd, WDIOC_GETSUPPORT, &info);
 	if (ret) {
-		printf("WDIOC_GETSUPPORT error '%s'\n", strerror(errno));
 		close(fd);
-		exit(ret);
+		ksft_exit_skip("WDIOC_GETSUPPORT error '%s'\n", strerror(errno));
 	}
 
 	optind = 0;
 
+	ksft_print_header();
+	ksft_set_plan(test_num);
+
 	while ((c = getopt_long(argc, argv, sopts, lopts, NULL)) != -1) {
 		switch (c) {
 		case 'b':
@@ -225,39 +234,42 @@ int main(int argc, char *argv[])
 			if (!ret)
 				print_boot_status(flags);
 			else
-				printf("WDIOC_GETBOOTSTATUS error '%s'\n", strerror(errno));
+				ksft_print_msg("WDIOC_GETBOOTSTATUS error '%s'\n", strerror(errno));
+			ksft_test_result(!ret, "WDIOC_GETBOOTSTATUS\n");
 			break;
 		case 'd':
 			flags = WDIOS_DISABLECARD;
 			ret = ioctl(fd, WDIOC_SETOPTIONS, &flags);
 			if (!ret)
-				printf("Watchdog card disabled.\n");
+				ksft_print_msg("Watchdog card disabled.\n");
 			else {
-				printf("WDIOS_DISABLECARD error '%s'\n", strerror(errno));
+				ksft_print_msg("WDIOS_DISABLECARD error '%s'\n", strerror(errno));
 				oneshot = 1;
 			}
+			ksft_test_result(!ret, "WDIOC_SETOPTIONS_WDIOS_DISABLECARD\n");
 			break;
 		case 'e':
 			flags = WDIOS_ENABLECARD;
 			ret = ioctl(fd, WDIOC_SETOPTIONS, &flags);
 			if (!ret)
-				printf("Watchdog card enabled.\n");
+				ksft_print_msg("Watchdog card enabled.\n");
 			else {
-				printf("WDIOS_ENABLECARD error '%s'\n", strerror(errno));
+				ksft_print_msg("WDIOS_ENABLECARD error '%s'\n", strerror(errno));
 				oneshot = 1;
 			}
+			ksft_test_result(!ret, "WDIOC_SETOPTIONS_WDIOS_ENABLECARD\n");
 			break;
 		case 'p':
 			ping_rate = strtoul(optarg, NULL, 0);
 			if (!ping_rate)
 				ping_rate = DEFAULT_PING_RATE;
-			printf("Watchdog ping rate set to %u seconds.\n", ping_rate);
+			ksft_print_msg("Watchdog ping rate set to %u seconds.\n", ping_rate);
 			break;
 		case 'c':
 			ping_count = strtoul(optarg, NULL, 0);
 			if (!ping_count)
 				ping_count = DEFAULT_PING_COUNT;
-			printf("Number of pings set to %u.\n", ping_count);
+			ksft_print_msg("Number of pings set to %u.\n", ping_count);
 			break;
 		case 's':
 			flags = 0;
@@ -266,57 +278,62 @@ int main(int argc, char *argv[])
 			if (!ret)
 				print_status(flags);
 			else
-				printf("WDIOC_GETSTATUS error '%s'\n", strerror(errno));
+				ksft_print_msg("WDIOC_GETSTATUS error '%s'\n", strerror(errno));
+			ksft_test_result(!ret, "WDIOC_GETSTATUS\n");
 			ret = ioctl(fd, WDIOC_GETTEMP, &temperature);
 			if (ret)
-				printf("WDIOC_GETTEMP: '%s'\n", strerror(errno));
+				ksft_print_msg("WDIOC_GETTEMP: '%s'\n", strerror(errno));
 			else
-				printf("Temperature %d\n", temperature);
-
+				ksft_print_msg("Temperature %d\n", temperature);
 			break;
 		case 't':
 			flags = strtoul(optarg, NULL, 0);
 			ret = ioctl(fd, WDIOC_SETTIMEOUT, &flags);
 			if (!ret)
-				printf("Watchdog timeout set to %u seconds.\n", flags);
+				ksft_print_msg("Watchdog timeout set to %u seconds.\n", flags);
 			else {
-				printf("WDIOC_SETTIMEOUT error '%s'\n", strerror(errno));
+				ksft_print_msg("WDIOC_SETTIMEOUT error '%s'\n", strerror(errno));
 				oneshot = 1;
 			}
+			ksft_test_result(!ret, "WDIOC_SETTIMEOUT\n");
 			break;
 		case 'T':
 			oneshot = 1;
 			ret = ioctl(fd, WDIOC_GETTIMEOUT, &flags);
 			if (!ret)
-				printf("WDIOC_GETTIMEOUT returns %u seconds.\n", flags);
+				ksft_print_msg("WDIOC_GETTIMEOUT returns %u seconds.\n", flags);
 			else
-				printf("WDIOC_GETTIMEOUT error '%s'\n", strerror(errno));
+				ksft_print_msg("WDIOC_GETTIMEOUT error '%s'\n", strerror(errno));
+			ksft_test_result(!ret, "WDIOC_GETTIMEOUT\n");
 			break;
 		case 'n':
 			flags = strtoul(optarg, NULL, 0);
 			ret = ioctl(fd, WDIOC_SETPRETIMEOUT, &flags);
 			if (!ret)
-				printf("Watchdog pretimeout set to %u seconds.\n", flags);
+				ksft_print_msg("Watchdog pretimeout set to %u seconds.\n", flags);
 			else {
-				printf("WDIOC_SETPRETIMEOUT error '%s'\n", strerror(errno));
+				ksft_print_msg("WDIOC_SETPRETIMEOUT error '%s'\n", strerror(errno));
 				oneshot = 1;
 			}
+			ksft_test_result(!ret, "WDIOC_SETPRETIMEOUT\n");
 			break;
 		case 'N':
 			oneshot = 1;
 			ret = ioctl(fd, WDIOC_GETPRETIMEOUT, &flags);
 			if (!ret)
-				printf("WDIOC_GETPRETIMEOUT returns %u seconds.\n", flags);
+				ksft_print_msg("WDIOC_GETPRETIMEOUT returns %u seconds.\n", flags);
 			else
-				printf("WDIOC_GETPRETIMEOUT error '%s'\n", strerror(errno));
+				ksft_print_msg("WDIOC_GETPRETIMEOUT error '%s'\n", strerror(errno));
+			ksft_test_result(!ret, "WDIOC_GETPRETIMEOUT\n");
 			break;
 		case 'L':
 			oneshot = 1;
 			ret = ioctl(fd, WDIOC_GETTIMELEFT, &flags);
 			if (!ret)
-				printf("WDIOC_GETTIMELEFT returns %u seconds.\n", flags);
+				ksft_print_msg("WDIOC_GETTIMELEFT returns %u seconds.\n", flags);
 			else
-				printf("WDIOC_GETTIMELEFT error '%s'\n", strerror(errno));
+				ksft_print_msg("WDIOC_GETTIMELEFT error '%s'\n", strerror(errno));
+			ksft_test_result(!ret, "WDIOC_GETTIMELEFT\n");
 			break;
 		case 'f':
 			/* Handled above */
@@ -327,31 +344,38 @@ int main(int argc, char *argv[])
 			 * validation. So we just show it here.
 			 */
 			oneshot = 1;
-			printf("watchdog_info:\n");
-			printf(" identity:\t\t%s\n", info.identity);
-			printf(" firmware_version:\t%u\n",
-			       info.firmware_version);
+			ksft_print_msg("watchdog_info:\n");
+			ksft_print_msg(" identity:\t\t%s\n", info.identity);
+			ksft_print_msg(" firmware_version:\t%u\n", info.firmware_version);
 			print_status(info.options);
 			break;
 
 		default:
 			usage(argv[0]);
+			ksft_test_result_skip("WDIOC_KEEPALIVE\n");
 			goto end;
 		}
 	}
 
-	if (oneshot)
+	if (oneshot) {
+		ksft_test_result_skip("WDIOC_KEEPALIVE\n");
 		goto end;
+	}
 
-	printf("Watchdog Ticking Away!\n");
+	ksft_print_msg("Watchdog Ticking Away!\n");
+	ksft_print_msg("");
 
 	signal(SIGINT, term);
 
 	while (ping_count > 0) {
-		keep_alive();
+		ret = keep_alive();
+		if (ret)
+			break;
 		sleep(ping_rate);
 		ping_count--;
 	}
+	printf("\n");
+	ksft_test_result(!ret, "WDIOC_KEEPALIVE\n");
 end:
 	/*
 	 * Send specific magic character 'V' just in case Magic Close is
@@ -359,7 +383,7 @@ int main(int argc, char *argv[])
 	 */
 	ret = write(fd, &v, 1);
 	if (ret < 0)
-		printf("Stopping watchdog ticks failed (%d)...\n", errno);
+		ksft_print_msg("Stopping watchdog ticks failed (%d)...\n", errno);
 	close(fd);
-	return 0;
+	ksft_finished();
 }
-- 
2.30.2


