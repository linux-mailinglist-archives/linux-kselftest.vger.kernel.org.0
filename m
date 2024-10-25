Return-Path: <linux-kselftest+bounces-20592-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE7BB9AF6E9
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Oct 2024 03:39:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C8801C20E08
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Oct 2024 01:39:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB3B51173F;
	Fri, 25 Oct 2024 01:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="QQQfNITR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from esa5.hc1455-7.c3s2.iphmx.com (esa5.hc1455-7.c3s2.iphmx.com [68.232.139.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65A3A2261D;
	Fri, 25 Oct 2024 01:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.139.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729820345; cv=none; b=SmTsKuXkmDEXQFTmoJwpMBKZHB9EjcBnsHw19Jcmt2Jc21l+WaF5ThWrBTyeV48QVIgzTf4/W25HzmfcBVJRLYhx+h1qEijhK/GstTItbhJ1wonBSKWQhbcEdrhIWTjFMb2SSxvMtDZ28omoPF15L19CuhvBfS9KAgO3A3hFnss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729820345; c=relaxed/simple;
	bh=HnPtkT7fpVyFtq4I3xKJYtqJTPjsAp1EyhBqcABcKp4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AMqMh4fmlscSP5jgNElSZJmddCe5pcMvUjZOUuDSKuaajUG2keqD+FxoJlqD/3w21Fl3adcWgdZAM1Ol9ipHZ4eyzfiN9Mvwf63YzZrV/Mv3eDf3fk6rs9+/j6phfqpBPCIM2Uu2ioe0DeGz9fPfw8bOO0d7szm2hpod7iqyg7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=QQQfNITR; arc=none smtp.client-ip=68.232.139.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1729820343; x=1761356343;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HnPtkT7fpVyFtq4I3xKJYtqJTPjsAp1EyhBqcABcKp4=;
  b=QQQfNITRcemzSMwnoEAY6N7JQvK+hvCnZzpWnZ5O2kLp82G04KT6P2m8
   CQfDPC9lzx/edN/ZXHDYrIxwP+4VWuk66vOq4v7vYHnYGuUNukXp65/A3
   deith+kxZQbp0fCLWhSWfot6XdN2HjuPMonn/U8DItgZE4kwKjasii+kc
   JGarlh0Owwbz4Mq1ib/+b3bACJiw/OZJ7ccY9LWXQk73pMqRdCMJCrxM5
   tVe1gyZ9ErKxdC8hHXqgcnjOqOzUhbzhU4rqS8gDvsdsqvQJehen4pcXa
   ai8TRS7rBEYkmPcnbb4rcM29jJIehHAHIWA6beEBTJ6CcEm2TnwJiQpg9
   Q==;
X-CSE-ConnectionGUID: Bc0kWaKDQBCj/QXMfEtG0A==
X-CSE-MsgGUID: XRmRSx5zSJO/O8SPjJqGFA==
X-IronPort-AV: E=McAfee;i="6700,10204,11235"; a="177131237"
X-IronPort-AV: E=Sophos;i="6.11,230,1725289200"; 
   d="scan'208";a="177131237"
Received: from unknown (HELO oym-r2.gw.nic.fujitsu.com) ([210.162.30.90])
  by esa5.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2024 10:38:55 +0900
Received: from oym-m2.gw.nic.fujitsu.com (oym-nat-oym-m2.gw.nic.fujitsu.com [192.168.87.59])
	by oym-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id 61A84D922F;
	Fri, 25 Oct 2024 10:38:53 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com [192.51.206.21])
	by oym-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id 9CAF9BF3FF;
	Fri, 25 Oct 2024 10:38:52 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id 3D91920074739;
	Fri, 25 Oct 2024 10:38:52 +0900 (JST)
Received: from iaas-rdma.. (unknown [10.167.135.44])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id C1C9E1A01E9;
	Fri, 25 Oct 2024 09:38:51 +0800 (CST)
From: Li Zhijian <lizhijian@fujitsu.com>
To: linux-kselftest@vger.kernel.org
Cc: shuah@kernel.org,
	linux-kernel@vger.kernel.org,
	Li Zhijian <lizhijian@fujitsu.com>
Subject: [PATCH for-next 2/3] selftests/watchdog: exit watchdog-test with error code
Date: Fri, 25 Oct 2024 09:39:32 +0800
Message-ID: <20241025013933.6516-2-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20241025013933.6516-1-lizhijian@fujitsu.com>
References: <20241025013933.6516-1-lizhijian@fujitsu.com>
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
X-TMASE-Result: 10-6.818500-10.000000
X-TMASE-MatchedRID: J0iUJQuzfPCq4Yzi/atV+4XQ/hu1OV/0FcWhaEbO5t1xxW5R7o+bOdnf
	JrUSEbFDTaQ+iJAfFMooSJ1XMXiioS/7QU2czuUNOWUWxTQJdI8hBMJtJ3C24rytpyEazVjcVXF
	z93jC3xdkdVEclM52h7c/bhbftAlrIg67HHizFeEZgmFGHqyx69DEMPvvoocvDx0O254JWHYoK3
	Mur/AaLNfzNj9c+mz2VfvWvmVRqVkfE8yM4pjsD7q9UFRTJ0kKxEHRux+uk8jHUU+U0ACZwFcl5
	PKwJcGA/gQCdRKK8PSt9N+2v8PC/h8zRhcWZIiE9Ree/Crsuxe5aq1sNoQWdcAeeCEAgQxHRNs/
	ohMOgYsNDF8g51SDmQ==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0

So that we can check its exit code to judge whether it succeeds
or not.

Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
 .../testing/selftests/watchdog/watchdog-test.c  | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/watchdog/watchdog-test.c b/tools/testing/selftests/watchdog/watchdog-test.c
index 2f8fd2670897..d42fc2fd790d 100644
--- a/tools/testing/selftests/watchdog/watchdog-test.c
+++ b/tools/testing/selftests/watchdog/watchdog-test.c
@@ -51,7 +51,7 @@ static const struct option lopts[] = {
  * the PC Watchdog card to reset its internal timer so it doesn't trigger
  * a computer reset.
  */
-static void keep_alive(void)
+static int keep_alive(void)
 {
 	int dummy;
 	int ret;
@@ -59,6 +59,8 @@ static void keep_alive(void)
 	ret = ioctl(fd, WDIOC_KEEPALIVE, &dummy);
 	if (!ret)
 		printf(".");
+
+	return ret;
 }
 
 /*
@@ -175,7 +177,7 @@ int main(int argc, char *argv[])
 	int flags;
 	unsigned int ping_rate = DEFAULT_PING_RATE;
 	int ret;
-	int c;
+	int c, n;
 	int oneshot = 0, stop = 1, count = 0;
 	char *file = "/dev/watchdog";
 	struct watchdog_info info;
@@ -342,7 +344,9 @@ int main(int argc, char *argv[])
 	signal(SIGINT, term);
 
 	while (stop || count--) {
-		exit_code = keep_alive();
+		ret = keep_alive();
+		if (ret)
+			goto end;
 		sleep(ping_rate);
 	}
 end:
@@ -350,9 +354,10 @@ int main(int argc, char *argv[])
 	 * Send specific magic character 'V' just in case Magic Close is
 	 * enabled to ensure watchdog gets disabled on close.
 	 */
-	ret = write(fd, &v, 1);
-	if (ret < 0)
+	n = write(fd, &v, 1);
+	if (n < 0)
 		printf("Stopping watchdog ticks failed (%d)...\n", errno);
 	close(fd);
-	return 0;
+
+	return ret || n < 0;
 }
-- 
2.44.0


