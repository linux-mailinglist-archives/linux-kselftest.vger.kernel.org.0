Return-Path: <linux-kselftest+bounces-22277-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FC749D292D
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Nov 2024 16:09:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C18F282CC7
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Nov 2024 15:09:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 961D31D0432;
	Tue, 19 Nov 2024 15:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=laura.nao@collabora.com header.b="WsgRFdCH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 782841CFED1;
	Tue, 19 Nov 2024 15:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732028502; cv=pass; b=kPiIBC9Cw0hQKCn4PQX8OG3VeX5zbHPfc+3sQTUoxxnbbLAvlge4QcLhPbM0qB4F8kKu2/5u7c2aY0/B/pbxtB36c7A8d/SUgMjbCUS+1IPh04C/TWBGjTeQ9Ih5xc92RHYiVCazIiH57OFy0n7VFE1hvOJuofQZs5absX0/Rv0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732028502; c=relaxed/simple;
	bh=QHV3dXjSa3fv2LS5uDGfGq538fPdl5Py0UKH4lCMAIo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HAmFMh3zXGSYoY59jzE+tFss61jCVlGOptoRQmyLvEZOEM80yukh6Eha9mzBu4Q/RtgnFF18BZj879D2QyPzAeZDyoMDym3/ApTGvv0wr4Rd35zABD55pd7GsCk+J1V84F1Nz0nhEWdfIyBmtYdvYUmn5MAMbqoIH+5S52w5R30=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=laura.nao@collabora.com header.b=WsgRFdCH; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1732028488; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=didqN8AazB1vSgdlfnYiY3E+kQfWPqHl0tydQsNH/xj0lU22PEKvP+fGt5S/xMJuRkrWK8i0K50+IC4PbVTU4iTzJf5g+fTzqNMmbfOtv/+Jqw/gHFVR7jHEb6i++nyGP8Pj8IW/m2n+31fkIbumwQtprc6RPZBepoLdVMKx3vs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1732028488; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=057phoMJJrnzspv8LQ2k62XW69eK5B9pBPoY+XGK15s=; 
	b=NULzD6M1tSxiIPcYRtwr9UU+R4VOMyJkoR67fD1qpbHAMYfT9x+bRyDjZ0y4hpd3ztWktaI0w00OSQLuboL7gxXjddBBQotH4T743hcd/prq2NGijyhZeEepCv5+xBMBF34NRTXx4f9biPdzEhbHqOrBoGEhFG6j0ZJuTcQi/RM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=laura.nao@collabora.com;
	dmarc=pass header.from=<laura.nao@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1732028488;
	s=zohomail; d=collabora.com; i=laura.nao@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=057phoMJJrnzspv8LQ2k62XW69eK5B9pBPoY+XGK15s=;
	b=WsgRFdCHKA8kfveBYMigNvojjP7cTIQdiFaig0v53aW13v+lRJV10X6F34PnGddc
	YFo1UUEUkv1dxjXj2So6tXoJ2O4TB/7zKW3s/dy695myYRBUiq+W7ixBjDrfAvCPDYb
	1Uo1rMppbfnkmams6abLYKSOfnfutBaXpvfGWr9c=
Received: by mx.zohomail.com with SMTPS id 1732028487061923.0385676586997;
	Tue, 19 Nov 2024 07:01:27 -0800 (PST)
From: Laura Nao <laura.nao@collabora.com>
To: shuah@kernel.org
Cc: laura.nao@collabora.com,
	kernel@collabora.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v2 2/2] selftests/watchdog: convert the test output to KTAP format
Date: Tue, 19 Nov 2024 16:01:27 +0100
Message-Id: <20241119150127.152830-3-laura.nao@collabora.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20241119150127.152830-1-laura.nao@collabora.com>
References: <20241119150127.152830-1-laura.nao@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Conform the test output to the KTAP format standard. The number of tests
executed is determined by the script arguments, and options such as
-c, -f, -h, -i, and -p do not impact the total test count.

Signed-off-by: Laura Nao <laura.nao@collabora.com>
---
 .../selftests/watchdog/watchdog-test.c        | 158 ++++++++++--------
 1 file changed, 92 insertions(+), 66 deletions(-)

diff --git a/tools/testing/selftests/watchdog/watchdog-test.c b/tools/testing/selftests/watchdog/watchdog-test.c
index 58c25015d5e7..4781736070e3 100644
--- a/tools/testing/selftests/watchdog/watchdog-test.c
+++ b/tools/testing/selftests/watchdog/watchdog-test.c
@@ -22,12 +22,15 @@
 #include <sys/ioctl.h>
 #include <linux/types.h>
 #include <linux/watchdog.h>
+#include "../kselftest.h"
 
 #define DEFAULT_PING_RATE	1
 
 int fd;
+int keep_alive_res;
 const char v = 'V';
 static const char sopts[] = "bdehp:c:st:Tn:NLf:i";
+static const char topts[] = "bdeLn:Nst:T";
 static const struct option lopts[] = {
 	{"bootstatus",          no_argument, NULL, 'b'},
 	{"disable",             no_argument, NULL, 'd'},
@@ -51,7 +54,7 @@ static const struct option lopts[] = {
  * the PC Watchdog card to reset its internal timer so it doesn't trigger
  * a computer reset.
  */
-static void keep_alive(void)
+static int keep_alive(void)
 {
 	int dummy;
 	int ret;
@@ -59,6 +62,8 @@ static void keep_alive(void)
 	ret = ioctl(fd, WDIOC_KEEPALIVE, &dummy);
 	if (!ret)
 		printf(".");
+
+	return ret;
 }
 
 /*
@@ -72,35 +77,36 @@ static void term(int sig)
 
 	close(fd);
 	if (ret < 0)
-		printf("\nStopping watchdog ticks failed (%d)...\n", errno);
+		ksft_print_msg("\nStopping watchdog ticks failed (%d)...\n", errno);
 	else
-		printf("\nStopping watchdog ticks...\n");
-	exit(0);
+		ksft_print_msg("\nStopping watchdog ticks...\n");
+	ksft_test_result(!keep_alive_res, "WDIOC_KEEPALIVE\n");
+	ksft_finished();
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
-	printf(" -c, --pingcount=C\tLimit the number of pings to C (default infinite)\n");
-	printf(" -t, --timeout=T\tSet timeout to T seconds\n");
-	printf(" -T, --gettimeout\tGet the timeout\n");
-	printf(" -n, --pretimeout=T\tSet the pretimeout to T seconds\n");
-	printf(" -N, --getpretimeout\tGet the pretimeout\n");
-	printf(" -L, --gettimeleft\tGet the time left until timer expires\n");
-	printf("\n");
-	printf("Parameters are parsed left-to-right in real-time.\n");
-	printf("Example: %s -d -t 10 -p 5 -e\n", progname);
-	printf("Example: %s -t 12 -T -n 7 -N\n", progname);
+	ksft_print_msg(" -c, --pingcount=C\tSet number of pings to C (default infinite)\n");
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
@@ -126,13 +132,13 @@ static void print_status(int flags)
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
@@ -154,18 +160,18 @@ static void print_boot_status(int flags)
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
@@ -181,25 +187,28 @@ int main(int argc, char *argv[])
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
@@ -207,13 +216,15 @@ int main(int argc, char *argv[])
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
@@ -223,39 +234,42 @@ int main(int argc, char *argv[])
 			if (!ret)
 				print_boot_status(flags);
 			else
-				printf("WDIOC_GETBOOTSTATUS error '%s'\n", strerror(errno));
+				ksft_perror("WDIOC_GETBOOTSTATUS error");
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
+				ksft_perror("WDIOS_DISABLECARD error");
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
+				ksft_perror("WDIOS_ENABLECARD error");
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
 				oneshot = 1;
-			printf("Number of pings set to %u.\n", ping_count);
+			ksft_print_msg("Number of pings set to %u.\n", ping_count);
 			break;
 		case 's':
 			flags = 0;
@@ -264,57 +278,62 @@ int main(int argc, char *argv[])
 			if (!ret)
 				print_status(flags);
 			else
-				printf("WDIOC_GETSTATUS error '%s'\n", strerror(errno));
+				ksft_perror("WDIOC_GETSTATUS error");
+			ksft_test_result(!ret, "WDIOC_GETSTATUS\n");
 			ret = ioctl(fd, WDIOC_GETTEMP, &temperature);
 			if (ret)
-				printf("WDIOC_GETTEMP: '%s'\n", strerror(errno));
+				ksft_perror("WDIOC_GETTEMP");
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
+				ksft_perror("WDIOC_SETTIMEOUT error");
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
+				ksft_perror("WDIOC_GETTIMEOUT error");
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
+				ksft_perror("WDIOC_SETPRETIMEOUT error");
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
+				ksft_perror("WDIOC_GETPRETIMEOUT error");
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
+				ksft_perror("WDIOC_GETTIMELEFT error");
+			ksft_test_result(!ret, "WDIOC_GETTIMELEFT\n");
 			break;
 		case 'f':
 			/* Handled above */
@@ -325,32 +344,39 @@ int main(int argc, char *argv[])
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
 
 	while (ping_count != 0) {
-		keep_alive();
+		if (keep_alive())
+			keep_alive_res = -1;
+
 		sleep(ping_rate);
 		if (ping_count > 0)
 			ping_count--;
 	}
+	printf("\n");
+	ksft_test_result(!keep_alive_res, "WDIOC_KEEPALIVE\n");
 end:
 	/*
 	 * Send specific magic character 'V' just in case Magic Close is
@@ -358,7 +384,7 @@ int main(int argc, char *argv[])
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


