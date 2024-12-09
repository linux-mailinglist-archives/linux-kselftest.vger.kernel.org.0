Return-Path: <linux-kselftest+bounces-23065-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E12999E9EC9
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Dec 2024 20:03:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D3DA1665C3
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Dec 2024 19:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A81319ABD4;
	Mon,  9 Dec 2024 18:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b="SExVDlED"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.codeweavers.com (mail.codeweavers.com [4.36.192.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A67CF199EAD;
	Mon,  9 Dec 2024 18:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.36.192.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733770778; cv=none; b=Jyd8Uyu/cTo1fKKTZiMb0E2LSDEh4xZNSCNn0vidjSPUn3oM4ifhcbY7cxQHNECZoFysv+gpCK3aOleAfLIZ0pKwj+lwMIpBlBOC7qpuJljqKJjKxXtCiaRjhqaJgs/igWomv6qFBnU6U5vRx4hpA1BfCFzap6YO1WW8D3VL15o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733770778; c=relaxed/simple;
	bh=UvuUUiKl0TXB4gj3KcmBPnL2z48m1/i2HNcvwWZlHU0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WaeZMjawAcljITre1I617GjaqczPyyw1OTOrO5t/ajyEl4Jcvi7eVQKkh65jTQ2oJ1qZU2liB2lDCEhTAOVVrKmD9sH/Kj52DfkRDcgiygC8y5Zkp8bGsv0lvCxSMRCT+OIpbFQWPuXckDgwQxf/XZlwSlRbxwjZTPTtM4oItjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com; spf=pass smtp.mailfrom=codeweavers.com; dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b=SExVDlED; arc=none smtp.client-ip=4.36.192.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeweavers.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codeweavers.com; s=s1; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=M/LBZlwH5ARcKJyd/bNhiFQzDMVjAnUNfHR23x8Gew4=; b=SExVDlEDv875MyQ/z/+3uiktO2
	oEdKUN5qGUvsN1IwQoUKnXcmztxr+4DQyiyaSFSd0kcvoAqnuiNHkx4WugU5lwyNkl2/nVC60nUb8
	pxH8z5S1Wisf5fXCm7sjqVC+piS9jmOG/JpnkftNfmfWwl0Q2/6Jv7xMVhV0aPoVuPLCG3zJ2HV07
	33LjCz145mfdf0AOSHK5ShXd7JJMsArDijXIsqOiNWkc/FHB3utTvXRC9vEShh5/SCutvLVkdU3/M
	OMf2Oyj2iav2JjfCirBUdQq9KghirLMerqPfubo/mq78H+7bqu9HVWk2M4yTmXz50f2kwzN30SyUF
	K+xYvSzQ==;
Received: from cw137ip160.mn.codeweavers.com ([10.69.137.160] helo=camazotz.mn.codeweavers.com)
	by mail.codeweavers.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <zfigura@codeweavers.com>)
	id 1tKiyi-001Gd5-2p;
	Mon, 09 Dec 2024 12:59:33 -0600
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
	Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Elizabeth Figura <zfigura@codeweavers.com>
Subject: [PATCH v6 19/28] selftests: ntsync: Add some tests for wakeup signaling with WINESYNC_IOC_WAIT_ALL.
Date: Mon,  9 Dec 2024 12:58:55 -0600
Message-ID: <20241209185904.507350-20-zfigura@codeweavers.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241209185904.507350-1-zfigura@codeweavers.com>
References: <20241209185904.507350-1-zfigura@codeweavers.com>
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
2.45.2


