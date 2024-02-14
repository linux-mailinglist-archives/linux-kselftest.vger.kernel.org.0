Return-Path: <linux-kselftest+bounces-4709-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F904855800
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Feb 2024 01:00:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8DCCB23F8B
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Feb 2024 00:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEA6614F9F6;
	Wed, 14 Feb 2024 23:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b="pagQl5wR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.codeweavers.com (mail.codeweavers.com [4.36.192.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3069E14E2FF;
	Wed, 14 Feb 2024 23:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.36.192.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707954833; cv=none; b=LoKhLV7KiTqKEYev7djmC+IYI6NSAqZlVLnZ3bfU925HlSNNlyPaAySfxbFxL/yBZOZWV62BcJLM6vw+sVgDgqOYu+Pf2BmrvxzTU/DymET4gv4Fqi9A0172EOewl9Kq09KKif+Lj8bdbEdKL2N81J0pK2L8BvgPrlnNnKHLgvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707954833; c=relaxed/simple;
	bh=JSJjrS6/HIsLRNVgq0a/m5f+xAZEV6uV7P3DcKoDXdM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sSAJTUsXeXxlmU4deGJmak+BL0zHnRWcxEEgIXAjr41eXLAWckSygtW12tNji9lKgfSxelbblSsUkptPp+ZkB1Y7nByA6zsrKd//G9LGhbkCMLLYWY/vAIU7phSJG9IXML4yxzE48c95uHq1smiMmg39mUSJ+30Oi4F2foLXvP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com; spf=pass smtp.mailfrom=codeweavers.com; dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b=pagQl5wR; arc=none smtp.client-ip=4.36.192.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeweavers.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codeweavers.com; s=s1; h=Message-ID:Date:Subject:Cc:To:From:Sender;
	bh=O5x1+ZiMnbiqyFsH/wrAVPmGqzEerXqsvIsYFOmQUQU=; b=pagQl5wRuWCa6WkER4yA4C8ryk
	6+tmAPG7Xrs4dfTp1JZ7K5i5EbTB/3nSSCBQPOJKMb/JQWxh9aehokEIazZU+gSgka3YrfqYMO8/o
	zRhh/7fVSACZs6EOV0zaDWWDIM3vn9V0J4Lgbkvagfis1lRX1wU/9whsMR8pkDznBrI69N4ocxlzx
	ZrcUJRC/uAEmiYWLRGmFXSGZ2DFDvaEEzIyv+eJHYhyMgEP3x7UdQ4YUBpfyKPXGQFr5rNJyY87lA
	BoN61CkpnhrCa8D9VbcON8x7UuoQR+Qh1P28ULatk/upY9IpDcsoklHigMZBOMG+/b+DI9gU0398W
	fbUi7IIg==;
Received: from cw137ip160.mn.codeweavers.com ([10.69.137.160] helo=camazotz.mn.codeweavers.com)
	by mail.codeweavers.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <zfigura@codeweavers.com>)
	id 1raP4W-00GcSK-1F;
	Wed, 14 Feb 2024 17:53:48 -0600
From: Elizabeth Figura <zfigura@codeweavers.com>
To: Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org,
	wine-devel@winehq.org,
	=?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>,
	Wolfram Sang <wsa@kernel.org>,
	Arkadiusz Hiler <ahiler@codeweavers.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Andy Lutomirski <luto@kernel.org>,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Elizabeth Figura <zfigura@codeweavers.com>
Subject: [PATCH 29/31] selftests: ntsync: Add a stress test for contended waits.
Date: Wed, 14 Feb 2024 17:53:04 -0600
Message-ID: <20240214235307.10494-20-zfigura@codeweavers.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240214235307.10494-1-zfigura@codeweavers.com>
References: <20240214233645.9273-1-zfigura@codeweavers.com>
 <20240214235307.10494-1-zfigura@codeweavers.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Test a more realistic usage pattern, and one with heavy contention, in order to
actually exercise ntsync's internal synchronization.

This test has several threads in a tight loop acquiring a mutex, modifying some
shared data, and then releasing the mutex. At the end we check if the data is
consistent.

Signed-off-by: Elizabeth Figura <zfigura@codeweavers.com>
---
 .../testing/selftests/drivers/ntsync/ntsync.c | 74 +++++++++++++++++++
 1 file changed, 74 insertions(+)

diff --git a/tools/testing/selftests/drivers/ntsync/ntsync.c b/tools/testing/selftests/drivers/ntsync/ntsync.c
index 40cfdd356ef4..aba513c9af01 100644
--- a/tools/testing/selftests/drivers/ntsync/ntsync.c
+++ b/tools/testing/selftests/drivers/ntsync/ntsync.c
@@ -1330,4 +1330,78 @@ TEST(alert_all)
 	close(fd);
 }
 
+#define STRESS_LOOPS 10000
+#define STRESS_THREADS 4
+
+static unsigned int stress_counter;
+static int stress_device, stress_start_event, stress_mutex;
+
+static void *stress_thread(void *arg)
+{
+	struct ntsync_wait_args wait_args = {0};
+	__u32 index, count, i;
+	int ret;
+
+	wait_args.timeout = UINT64_MAX;
+	wait_args.count = 1;
+	wait_args.objs = (uintptr_t)&stress_start_event;
+	wait_args.owner = gettid();
+	wait_args.index = 0xdeadbeef;
+
+	ioctl(stress_device, NTSYNC_IOC_WAIT_ANY, &wait_args);
+
+	wait_args.objs = (uintptr_t)&stress_mutex;
+
+	for (i = 0; i < STRESS_LOOPS; ++i) {
+		ioctl(stress_device, NTSYNC_IOC_WAIT_ANY, &wait_args);
+
+		++stress_counter;
+
+		unlock_mutex(stress_mutex, wait_args.owner, &count);
+	}
+
+	return NULL;
+}
+
+TEST(stress_wait)
+{
+	struct ntsync_event_args event_args;
+	struct ntsync_mutex_args mutex_args;
+	pthread_t threads[STRESS_THREADS];
+	__u32 signaled, i;
+	int ret;
+
+	stress_device = open("/dev/ntsync", O_CLOEXEC | O_RDONLY);
+	ASSERT_LE(0, stress_device);
+
+	mutex_args.owner = 0;
+	mutex_args.count = 0;
+	ret = ioctl(stress_device, NTSYNC_IOC_CREATE_MUTEX, &mutex_args);
+	EXPECT_EQ(0, ret);
+	stress_mutex = mutex_args.mutex;
+
+	event_args.manual = 1;
+	event_args.signaled = 0;
+	ret = ioctl(stress_device, NTSYNC_IOC_CREATE_EVENT, &event_args);
+	EXPECT_EQ(0, ret);
+	stress_start_event = event_args.event;
+
+	for (i = 0; i < STRESS_THREADS; ++i)
+		pthread_create(&threads[i], NULL, stress_thread, NULL);
+
+	ret = ioctl(stress_start_event, NTSYNC_IOC_EVENT_SET, &signaled);
+	EXPECT_EQ(0, ret);
+
+	for (i = 0; i < STRESS_THREADS; ++i) {
+		ret = pthread_join(threads[i], NULL);
+		EXPECT_EQ(0, ret);
+	}
+
+	EXPECT_EQ(STRESS_LOOPS * STRESS_THREADS, stress_counter);
+
+	close(stress_start_event);
+	close(stress_mutex);
+	close(stress_device);
+}
+
 TEST_HARNESS_MAIN
-- 
2.43.0


