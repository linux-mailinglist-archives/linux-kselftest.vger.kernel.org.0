Return-Path: <linux-kselftest+bounces-45375-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 85BCAC50B5B
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Nov 2025 07:30:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D8731896EBE
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Nov 2025 06:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D3922C08AD;
	Wed, 12 Nov 2025 06:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="3XOqYvCL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com [113.46.200.224])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E3C202F9C;
	Wed, 12 Nov 2025 06:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.224
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762929012; cv=none; b=KiJ4x7JIVRz0A8ibJ0HLhKFVjfVrddaDevr6Mt9AqLs644CzKV+dGvqm+eRQGK2y6F/AIyjGtjqENnYfd15Qov/ZUdS+uvx9gLF5zkM4Qmw/i2e2OgHvhMidws2+rEDkBfBnaV/CZGmf00OAuZoqClOq2ARKd4892oiheWQlJpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762929012; c=relaxed/simple;
	bh=Wazx6jWArPi5hlBgtqnEmzLdaAEYpi5VGgrqSmnHRX4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KD3bS3zORe1gDJ+UDBc1P/flBJ2CqDD30qmtsmVZ/XKIEe7a8LW1vZYfmPJBeRo1BgyeemEcJskn73IQXIsUFDIifedonqxwoFXUk0v5XewTfkGj7lgta6+KsRkVTP2mVEoYNxR07nLhp5H3FTDerB38MEYN0N2qYyP1r7xxNXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=3XOqYvCL; arc=none smtp.client-ip=113.46.200.224
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=lY6cQ7KxBIYOYros9QrVDrG6tiuFNXUR7hTsPWOK194=;
	b=3XOqYvCLFX80YxJ9ENVokqyC/kaKLmqB/FyTeHFbts6CXUhsfaiVYetlpMThBXja3qRB1kiR/
	WXBis9tWdTnnCkWhg1jcVxe5HU121vTwQWQY933lINtZUWNIGtxUoRBLGMy17FlzVv81CIpd+sg
	BGGWO4n2DtBAxKFR9izX35I=
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4d5tkz6dVyz1cyNs;
	Wed, 12 Nov 2025 14:28:27 +0800 (CST)
Received: from dggpemr200006.china.huawei.com (unknown [7.185.36.167])
	by mail.maildlp.com (Postfix) with ESMTPS id B18221402CC;
	Wed, 12 Nov 2025 14:30:07 +0800 (CST)
Received: from hulk-vt.huawei.com (10.67.175.28) by
 dggpemr200006.china.huawei.com (7.185.36.167) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 12 Nov 2025 14:30:07 +0800
From: Xinyu Zheng <zhengxinyu6@huawei.com>
To: Shuah Khan <shuah@kernel.org>
CC: Moon Hee Lee <moonhee.lee.ca@gmail.com>, <yifei.l.liu@oracle.com>,
	<zhujun2@cmss.chinamobile.com>, <linux-kselftest@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <zouyipeng@huawei.com>,
	<zhengxinyu6@huawei.com>
Subject: [PATCH] selftests: breakpoints: check RTC wakeup alarm support before test
Date: Wed, 12 Nov 2025 06:15:32 +0000
Message-ID: <20251112061532.2867859-1-zhengxinyu6@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 dggpemr200006.china.huawei.com (7.185.36.167)

If RTC wakeup alarm feature is unsupported, this testcase may cause
infinite suspend if there is no other wakeup source. To solve this
problem, set wakeup alarm up before we trigger suspend. In this case,
we can test if RTC support RTC_FEATURE_ALARM and efi_set_alarm function.

Signed-off-by: Xinyu Zheng <zhengxinyu6@huawei.com>
---
 .../breakpoints/step_after_suspend_test.c     | 23 +++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/tools/testing/selftests/breakpoints/step_after_suspend_test.c b/tools/testing/selftests/breakpoints/step_after_suspend_test.c
index 8d233ac95696..e738af896ce1 100644
--- a/tools/testing/selftests/breakpoints/step_after_suspend_test.c
+++ b/tools/testing/selftests/breakpoints/step_after_suspend_test.c
@@ -13,6 +13,8 @@
 #include <stdio.h>
 #include <string.h>
 #include <unistd.h>
+#include <linux/rtc.h>
+#include <sys/ioctl.h>
 #include <sys/ptrace.h>
 #include <sys/stat.h>
 #include <sys/timerfd.h>
@@ -159,10 +161,30 @@ void suspend(void)
 	int count_before;
 	int count_after;
 	struct itimerspec spec = {};
+	char *rtc_file = "/dev/rtc0";
+	int rtc_fd;
+	struct rtc_wkalrm alarm = { 0 };
+	time_t secs;
 
 	if (getuid() != 0)
 		ksft_exit_skip("Please run the test as root - Exiting.\n");
 
+	rtc_fd = open(rtc_file, O_RDONLY);
+	if (rtc_fd < 0)
+		ksft_exit_fail_msg("open rtc0 failed\n");
+
+	err = ioctl(rtc_fd, RTC_RD_TIME, &alarm.time);
+	if (err < 0)
+		ksft_exit_fail_msg("get rtc time failed\n");
+
+	secs = timegm((struct tm *)&alarm.time) + 3;
+	gmtime_r(&secs, (struct tm *)&alarm.time);
+	alarm.enabled = 1;
+
+	err = ioctl(rtc_fd, RTC_WKALM_SET, &alarm);
+	if (err < 0)
+		ksft_exit_fail_msg("set wake alarm test failed, errno %d\n", errno);
+
 	timerfd = timerfd_create(CLOCK_BOOTTIME_ALARM, 0);
 	if (timerfd < 0)
 		ksft_exit_fail_msg("timerfd_create() failed\n");
@@ -180,6 +202,7 @@ void suspend(void)
 	if (count_after <= count_before)
 		ksft_exit_fail_msg("Failed to enter Suspend state\n");
 
+	close(rtc_fd);
 	close(timerfd);
 }
 
-- 
2.34.1


