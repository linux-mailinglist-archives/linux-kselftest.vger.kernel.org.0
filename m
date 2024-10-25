Return-Path: <linux-kselftest+bounces-20597-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EBE809AF701
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Oct 2024 03:41:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55CFAB22717
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Oct 2024 01:41:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C93E13BC0E;
	Fri, 25 Oct 2024 01:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="lwvq1DJm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from esa10.hc1455-7.c3s2.iphmx.com (esa10.hc1455-7.c3s2.iphmx.com [139.138.36.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E59AB13C807;
	Fri, 25 Oct 2024 01:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.138.36.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729820409; cv=none; b=uuNYkRpj3kjtRKFh9kgc+l2X1lGa+DLIijfSYjVTWSbNw/g4iT/b4zN4S5KRHfITnJc1S0ldbqew/nFooS+zBIecMC4QR9PE1iJ4qeB60t6nBVUcZsEig41Q+8UFt00keLW72JkjHSpi3j2dwkIsaEOmPfuAS2allF8XxudgCnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729820409; c=relaxed/simple;
	bh=654YXOvVil3Euww5pKDgv0JcyWBr1+LQI/p2Mq/PP/8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HA71vRAyif2208xHMQXBBmwm0KYs1bmSNWZUYuOTArZJB5wttlxjOCto9A9YkKnWb+BI12yWVn2D4RPN6ixJZlJUtfdmwQVGoC9rpLJULTPNwxwLXMYY3nnAlCMJFjJpWUUEALYqmVK+ldJiBXKi2BcJj4u/4CsmY7lM5SWGvIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=lwvq1DJm; arc=none smtp.client-ip=139.138.36.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1729820407; x=1761356407;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=654YXOvVil3Euww5pKDgv0JcyWBr1+LQI/p2Mq/PP/8=;
  b=lwvq1DJmuXhPOT0HI9PAS7Pr0kBJmt3UkmRp2oeM5Vin4VVxKLeLiUpo
   aAHTE5wYUR/fOjMpx53VN6Stayl17Utz9tF6MydOxoYDUxKaUToodns7f
   xSCdCOjP3QRAyf8Ks5Jjs2yUj8ITxRG0d9fXUdBrxiUlGpPogBgAZRU66
   nH7Sab53OFGXA1QPzJA5lrWP5QbzIfLriuK93/9ZdEQR+CEfgplS+HLJr
   0S1FjXg/QF83PV+S10Lzs9PBxq05sbObrIk76DEzxZdmzpcGEhXiBg1Na
   waG9rSg3X2nxKy3eNZVWsASQtqZEmlr8L7764x/ZD8xf7jy7DaUD06uoJ
   w==;
X-CSE-ConnectionGUID: GOyUv8r9SPi4NbADffMEoQ==
X-CSE-MsgGUID: O1b4NVXJQZm6tFDhRfmDLg==
X-IronPort-AV: E=McAfee;i="6700,10204,11235"; a="165295778"
X-IronPort-AV: E=Sophos;i="6.11,230,1725289200"; 
   d="scan'208";a="165295778"
Received: from unknown (HELO oym-r1.gw.nic.fujitsu.com) ([210.162.30.89])
  by esa10.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2024 10:38:55 +0900
Received: from oym-m1.gw.nic.fujitsu.com (oym-nat-oym-m1.gw.nic.fujitsu.com [192.168.87.58])
	by oym-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id 3EE2FCC152;
	Fri, 25 Oct 2024 10:38:53 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com [192.51.206.21])
	by oym-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id 63905D5013;
	Fri, 25 Oct 2024 10:38:52 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id EBC3320071A06;
	Fri, 25 Oct 2024 10:38:51 +0900 (JST)
Received: from iaas-rdma.. (unknown [10.167.135.44])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 5CF191A000B;
	Fri, 25 Oct 2024 09:38:51 +0800 (CST)
From: Li Zhijian <lizhijian@fujitsu.com>
To: linux-kselftest@vger.kernel.org
Cc: shuah@kernel.org,
	linux-kernel@vger.kernel.org,
	Li Zhijian <lizhijian@fujitsu.com>
Subject: [PATCH for-next 1/3] selftests/watchdog: add count parameter for watchdog-test
Date: Fri, 25 Oct 2024 09:39:31 +0800
Message-ID: <20241025013933.6516-1-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28752.003
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28752.003
X-TMASE-Result: 10-2.222800-10.000000
X-TMASE-MatchedRID: Kkkx1MdXpTzySUS2aTJPt6qHmm/V4M/PNYERielKfYX+Aw16GgqpO4xj
	ZK20axcml2GUABdhPswYdpOYDB3YU/t1xYHpY/PCZXF1SJUAUOAkPki1Yfh9IlQuGn5b9r2Zegt
	0aF43NdcMI2dvwKu82tH/OWESXaHnrL+gHLQ9jwn0hv/rD7WVZHh8J8VFDfTIzAdJD7JeNMOLcY
	4IaAaI5iJiCpji5j3MJsa2Z1JGRPDR6RKL7TRTbhF4zyLyne+ATJDl9FKHbrkwAYdq1VTXowzbM
	QAfPhMUD/OFpcSAvwt2a8dgHy0BPpmXURexwsOZlXePXNM4FjOiNCtus+nPOsfASe7knCttB82G
	yGpZHXu27qf8B6e0g4Ay6p60ZV62fJ5/bZ6npdjGVuWouVipcsEjzginPrvIy/G5i9qoEvVK3Zk
	bMcfUPlORukGQ8Sf4QFRYfcbPnszysA5ID5qdCN0ImZe79YchhtKgqFgRxGM9KJnm0nW3ihFltG
	xCTkwFQHVA+r1vGdZmQDEDCMiuswfP8fSSIvISoYC0cwOOST0=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0

Currently, watchdog-test keep running until it gets a SIGINT. However,
when watchdog-test is executed from the kselftests framework, where it
launches test via timeout which will send SIGTERM in time up. This could
lead to
1. watchdog haven't stop, a watchdog reset is triggered to reboot the OS
   in silent.
2. kselftests gets an timeout exit code, and judge watchdog-test as
  'not ok'

This patch is prepare to fix above 2 issues

Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
Hey,
Cover letter is here.

It's notice that a OS reboot was triggerred after ran the watchdog-test
in kselftests framwork 'make run_tests', that's because watchdog-test
didn't stop feeding the watchdog after enable it.

In addition, current watchdog-test didn't adapt to the kselftests
framework which launchs the test with /usr/bin/timeout and no timeout
is expected.
---
 tools/testing/selftests/watchdog/watchdog-test.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/watchdog/watchdog-test.c b/tools/testing/selftests/watchdog/watchdog-test.c
index bc71cbca0dde..2f8fd2670897 100644
--- a/tools/testing/selftests/watchdog/watchdog-test.c
+++ b/tools/testing/selftests/watchdog/watchdog-test.c
@@ -27,7 +27,7 @@
 
 int fd;
 const char v = 'V';
-static const char sopts[] = "bdehp:st:Tn:NLf:i";
+static const char sopts[] = "bdehp:st:Tn:NLf:c:i";
 static const struct option lopts[] = {
 	{"bootstatus",          no_argument, NULL, 'b'},
 	{"disable",             no_argument, NULL, 'd'},
@@ -42,6 +42,7 @@ static const struct option lopts[] = {
 	{"gettimeleft",		no_argument, NULL, 'L'},
 	{"file",          required_argument, NULL, 'f'},
 	{"info",		no_argument, NULL, 'i'},
+	{"count",         required_argument, NULL, 'c'},
 	{NULL,                  no_argument, NULL, 0x0}
 };
 
@@ -95,6 +96,7 @@ static void usage(char *progname)
 	printf(" -n, --pretimeout=T\tSet the pretimeout to T seconds\n");
 	printf(" -N, --getpretimeout\tGet the pretimeout\n");
 	printf(" -L, --gettimeleft\tGet the time left until timer expires\n");
+	printf(" -c, --count\tStop after feeding the watchdog count times\n");
 	printf("\n");
 	printf("Parameters are parsed left-to-right in real-time.\n");
 	printf("Example: %s -d -t 10 -p 5 -e\n", progname);
@@ -174,7 +176,7 @@ int main(int argc, char *argv[])
 	unsigned int ping_rate = DEFAULT_PING_RATE;
 	int ret;
 	int c;
-	int oneshot = 0;
+	int oneshot = 0, stop = 1, count = 0;
 	char *file = "/dev/watchdog";
 	struct watchdog_info info;
 	int temperature;
@@ -307,6 +309,9 @@ int main(int argc, char *argv[])
 			else
 				printf("WDIOC_GETTIMELEFT error '%s'\n", strerror(errno));
 			break;
+		case 'c':
+			stop = 0;
+			count = strtoul(optarg, NULL, 0);
 		case 'f':
 			/* Handled above */
 			break;
@@ -336,8 +341,8 @@ int main(int argc, char *argv[])
 
 	signal(SIGINT, term);
 
-	while (1) {
-		keep_alive();
+	while (stop || count--) {
+		exit_code = keep_alive();
 		sleep(ping_rate);
 	}
 end:
-- 
2.44.0


