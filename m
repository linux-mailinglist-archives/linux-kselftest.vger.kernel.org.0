Return-Path: <linux-kselftest+bounces-4979-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E4AA85AF01
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Feb 2024 23:41:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D78C7285F32
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Feb 2024 22:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48D3B5BADE;
	Mon, 19 Feb 2024 22:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b="lsLBJ0mf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.codeweavers.com (mail.codeweavers.com [4.36.192.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDFD056760;
	Mon, 19 Feb 2024 22:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.36.192.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708382383; cv=none; b=jsl3YSxFfOJWwjHoIGShd0d7UTcoOyVWK22/NrYasgEVvKkmUINFFNJgXQdQdPYdER2NvxrWR7rD/uZFCICYVmksikQuliQQ5Y2VRlgPCjQtTvCFcrQVBAHI5mAwIzm2Y7vGietSNanVTBiCVwQwOoM8xo/Rl67PA/xBmGKhn5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708382383; c=relaxed/simple;
	bh=BZw7zShBTT5PfD4hawcGoNVQjDPKfhLnloDinunlfUc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ep086e6wWeorTPcVnMTPV68Y/7YmxVbtCI0INfQI8YdiP3mCYcga0Qql060pxEt5gkq0cDJzV98f1xMd4SnTVGf4svPITli/Zp1jtyaGROSl+OeP9DiVKm05e9IaXHHQRqrU/modkuIEy/a1x7J1zRKIn+URUBi5e2g0sZru/Iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com; spf=pass smtp.mailfrom=codeweavers.com; dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b=lsLBJ0mf; arc=none smtp.client-ip=4.36.192.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeweavers.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codeweavers.com; s=s1; h=Message-ID:Date:Subject:Cc:To:From:Sender;
	bh=sRVvK3PXYm0eOCy4h040E2JuAl2v9xoXVKyVT6JY+Rw=; b=lsLBJ0mfYfA07EzwEPdhS32PEg
	/GHDs3wzD3576ItezKBFTAef5mlNlfJdaDyj03K77DMkkrVYm94pb017mtWXrAYdnzDndUloaMOea
	Y7yBKoC4nRkr43znD8qxvOT9+95/WOIYAOEoYNz4u4i6z0RfKPTzWJ5PbpLZ7CSPfoBtUNm9BJPxX
	iJ6QwNizdmLugD7FTeBDz2U17VayvBmXZLBg5D0thV1nz5HFDuTDFeHipLQhOe3K8szedKKdAHsvr
	B165J9rLRsZg1+o1sRhzcdLEqGoJrNiHvDsZAfUjoFxkRFgIGQ3V4xbSPh5KVIhdDmAGMaqG+qyOE
	S4SFEPgg==;
Received: from cw137ip160.mn.codeweavers.com ([10.69.137.160] helo=camazotz.mn.codeweavers.com)
	by mail.codeweavers.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <zfigura@codeweavers.com>)
	id 1rcCIR-0037Oz-1h;
	Mon, 19 Feb 2024 16:39:35 -0600
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
	Randy Dunlap <rdunlap@infradead.org>,
	Elizabeth Figura <zfigura@codeweavers.com>
Subject: [PATCH v2 23/31] selftests: ntsync: Add some tests for wakeup signaling with WINESYNC_IOC_WAIT_ALL.
Date: Mon, 19 Feb 2024 16:38:25 -0600
Message-ID: <20240219223833.95710-24-zfigura@codeweavers.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240219223833.95710-1-zfigura@codeweavers.com>
References: <20240219223833.95710-1-zfigura@codeweavers.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Test contended "wait-for-all" waits, to make sure that scheduling and wakeup
logic works correctly, and that the wait only exits once objects are all
simultaneously signaled.

Signed-off-by: Elizabeth Figura <zfigura@codeweavers.com>
---
 .../testing/selftests/drivers/ntsync/ntsync.c | 98 +++++++++++++++++++
 1 file changed, 98 insertions(+)

diff --git a/tools/testing/selftests/drivers/ntsync/ntsync.c b/tools/testing/selftests/drivers/ntsync/ntsync.c
index 993f5db23768..b77fb0b2c4b1 100644
--- a/tools/testing/selftests/drivers/ntsync/ntsync.c
+++ b/tools/testing/selftests/drivers/ntsync/ntsync.c
@@ -706,4 +706,102 @@ TEST(wake_any)
 	close(fd);
 }
 
+TEST(wake_all)
+{
+	struct ntsync_mutex_args mutex_args = {0};
+	struct ntsync_wait_args wait_args = {0};
+	struct ntsync_sem_args sem_args = {0};
+	struct wait_args thread_args;
+	int objs[2], fd, ret;
+	__u32 count, index;
+	pthread_t thread;
+
+	fd = open("/dev/ntsync", O_CLOEXEC | O_RDONLY);
+	ASSERT_LE(0, fd);
+
+	sem_args.count = 0;
+	sem_args.max = 3;
+	sem_args.sem = 0xdeadbeef;
+	ret = ioctl(fd, NTSYNC_IOC_CREATE_SEM, &sem_args);
+	EXPECT_EQ(0, ret);
+	EXPECT_NE(0xdeadbeef, sem_args.sem);
+
+	mutex_args.owner = 123;
+	mutex_args.count = 1;
+	mutex_args.mutex = 0xdeadbeef;
+	ret = ioctl(fd, NTSYNC_IOC_CREATE_MUTEX, &mutex_args);
+	EXPECT_EQ(0, ret);
+	EXPECT_NE(0xdeadbeef, mutex_args.mutex);
+
+	objs[0] = sem_args.sem;
+	objs[1] = mutex_args.mutex;
+
+	wait_args.timeout = get_abs_timeout(1000);
+	wait_args.objs = (uintptr_t)objs;
+	wait_args.count = 2;
+	wait_args.owner = 456;
+	thread_args.fd = fd;
+	thread_args.args = &wait_args;
+	thread_args.request = NTSYNC_IOC_WAIT_ALL;
+	ret = pthread_create(&thread, NULL, wait_thread, &thread_args);
+	EXPECT_EQ(0, ret);
+
+	ret = wait_for_thread(thread, 100);
+	EXPECT_EQ(ETIMEDOUT, ret);
+
+	count = 1;
+	ret = post_sem(sem_args.sem, &count);
+	EXPECT_EQ(0, ret);
+	EXPECT_EQ(0, count);
+
+	ret = pthread_tryjoin_np(thread, NULL);
+	EXPECT_EQ(EBUSY, ret);
+
+	check_sem_state(sem_args.sem, 1, 3);
+
+	ret = wait_any(fd, 1, &sem_args.sem, 123, &index);
+	EXPECT_EQ(0, ret);
+	EXPECT_EQ(0, index);
+
+	ret = unlock_mutex(mutex_args.mutex, 123, &count);
+	EXPECT_EQ(0, ret);
+	EXPECT_EQ(1, count);
+
+	ret = pthread_tryjoin_np(thread, NULL);
+	EXPECT_EQ(EBUSY, ret);
+
+	check_mutex_state(mutex_args.mutex, 0, 0);
+
+	count = 2;
+	ret = post_sem(sem_args.sem, &count);
+	EXPECT_EQ(0, ret);
+	EXPECT_EQ(0, count);
+	check_sem_state(sem_args.sem, 1, 3);
+	check_mutex_state(mutex_args.mutex, 1, 456);
+
+	ret = wait_for_thread(thread, 100);
+	EXPECT_EQ(0, ret);
+	EXPECT_EQ(0, thread_args.ret);
+
+	/* delete an object while it's being waited on */
+
+	wait_args.timeout = get_abs_timeout(200);
+	wait_args.owner = 123;
+	ret = pthread_create(&thread, NULL, wait_thread, &thread_args);
+	EXPECT_EQ(0, ret);
+
+	ret = wait_for_thread(thread, 100);
+	EXPECT_EQ(ETIMEDOUT, ret);
+
+	close(sem_args.sem);
+	close(mutex_args.mutex);
+
+	ret = wait_for_thread(thread, 200);
+	EXPECT_EQ(0, ret);
+	EXPECT_EQ(-1, thread_args.ret);
+	EXPECT_EQ(ETIMEDOUT, thread_args.err);
+
+	close(fd);
+}
+
 TEST_HARNESS_MAIN
-- 
2.43.0


