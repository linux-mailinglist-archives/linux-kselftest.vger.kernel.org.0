Return-Path: <linux-kselftest+bounces-23360-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37CCE9F1673
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Dec 2024 20:42:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E683D287499
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Dec 2024 19:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFDFB1F8937;
	Fri, 13 Dec 2024 19:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b="KaMlHFSa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.codeweavers.com (mail.codeweavers.com [4.36.192.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FD531F893E;
	Fri, 13 Dec 2024 19:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.36.192.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734118567; cv=none; b=am1QxYG9aaJzo3/twBeP52V4yfS05FHUzNkfCvPTjTjAEA+8oCfXEkTEH6DQnRTo43zJGRAhYn9HeTITKww1jDi7KK1L6CgTTWRJcdBDrr1AgUUdB7gXws2Pa0Adks3S7glUniXkg2gH5ymYctd3yonqC8NXJMUmdNFt5/Pat9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734118567; c=relaxed/simple;
	bh=ziNNF+eemfyIzWiqHeOj6exSd2GtlkvyYwXNc4FBf/M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RZXHGCYU7wpUo4/tCPSdTAylkcfKjOf9cNcCvd7Na0A42dTm4wma1wChBB/b2eMqg9FOR3U3nyCUH2/KGmk+sljAo1sTmxAa7w8PMOIqNaCa7Lv9QV1+2H0CC+5NUB59A5syAXOdVTv0Tcna2OAZzpT1+2PsZoCoTaBY3jJ9vrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com; spf=pass smtp.mailfrom=codeweavers.com; dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b=KaMlHFSa; arc=none smtp.client-ip=4.36.192.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeweavers.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codeweavers.com; s=s1; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=TS9GmVpa2XxVuKA80owcQFjY+iJcMD70YPuFzs1aeQs=; b=KaMlHFSawbxNFbuMz4JgcQ/erX
	JBh1MVjQCNJvT57xbKEA7HHbk3Iy33c6121g1T0oQNH5VP8PloZHqbNeicJS8FoGVl3+YfAnvOhu0
	YwCih0KAzk6aLmPYdcNxRcah428wphzLDUUZ3mbMbDpbYGEVEpERRjqdgXeAEvUlPnOQCxVOVOQ0v
	Mtopi5JuG+i0NX9c+PAQhI6HQ2th1zA/rdb6wRae53+iKeAeChHHgJ7BzSMy58QCaWGuu5hNVLr2g
	SbMqMMyB8AOIZ1o1cDj+TvXGuYpk7+H9BMH72rKMVeeIl9DTDmFGv6RGNzsy4z1BZVJPkTNaTF2zV
	cOQ2iGvg==;
Received: from cw137ip160.mn.codeweavers.com ([10.69.137.160] helo=camazotz.mn.codeweavers.com)
	by mail.codeweavers.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <zfigura@codeweavers.com>)
	id 1tMBS6-00ASsZ-32;
	Fri, 13 Dec 2024 13:35:55 -0600
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
Subject: [PATCH v7 24/30] selftests: ntsync: Add some tests for wakeup signaling with events.
Date: Fri, 13 Dec 2024 13:35:05 -0600
Message-ID: <20241213193511.457338-25-zfigura@codeweavers.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241213193511.457338-1-zfigura@codeweavers.com>
References: <20241213193511.457338-1-zfigura@codeweavers.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Expand the contended wait tests, which previously only covered events and
semaphores, to cover events as well.

Signed-off-by: Elizabeth Figura <zfigura@codeweavers.com>
---
 .../testing/selftests/drivers/ntsync/ntsync.c | 145 +++++++++++++++++-
 1 file changed, 141 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/drivers/ntsync/ntsync.c b/tools/testing/selftests/drivers/ntsync/ntsync.c
index 66a096cb2045..33348f0b621f 100644
--- a/tools/testing/selftests/drivers/ntsync/ntsync.c
+++ b/tools/testing/selftests/drivers/ntsync/ntsync.c
@@ -598,6 +598,7 @@ TEST(test_wait_any)
 
 TEST(test_wait_all)
 {
+	struct ntsync_event_args event_args = {0};
 	struct ntsync_mutex_args mutex_args = {0};
 	struct ntsync_sem_args sem_args = {0};
 	__u32 owner, index, count;
@@ -663,6 +664,19 @@ TEST(test_wait_all)
 
 	close(objs[1]);
 
+	event_args.manual = true;
+	event_args.signaled = true;
+	objs[1] = ioctl(fd, NTSYNC_IOC_CREATE_EVENT, &event_args);
+	EXPECT_LE(0, objs[1]);
+
+	ret = wait_all(fd, 2, objs, 123, &index);
+	EXPECT_EQ(0, ret);
+	EXPECT_EQ(0, index);
+	check_sem_state(objs[0], 0, 3);
+	check_event_state(objs[1], 1, 1);
+
+	close(objs[1]);
+
 	/* test waiting on the same object twice */
 	objs[1] = objs[0];
 	ret = wait_all(fd, 2, objs, 123, &index);
@@ -716,12 +730,13 @@ static int wait_for_thread(pthread_t thread, unsigned int ms)
 
 TEST(wake_any)
 {
+	struct ntsync_event_args event_args = {0};
 	struct ntsync_mutex_args mutex_args = {0};
 	struct ntsync_wait_args wait_args = {0};
 	struct ntsync_sem_args sem_args = {0};
 	struct wait_args thread_args;
+	__u32 count, index, signaled;
 	int objs[2], fd, ret;
-	__u32 count, index;
 	pthread_t thread;
 
 	fd = open("/dev/ntsync", O_CLOEXEC | O_RDONLY);
@@ -796,6 +811,94 @@ TEST(wake_any)
 	EXPECT_EQ(0, thread_args.ret);
 	EXPECT_EQ(1, wait_args.index);
 
+	close(objs[1]);
+
+	/* test waking events */
+
+	event_args.manual = false;
+	event_args.signaled = false;
+	objs[1] = ioctl(fd, NTSYNC_IOC_CREATE_EVENT, &event_args);
+	EXPECT_LE(0, objs[1]);
+
+	wait_args.timeout = get_abs_timeout(1000);
+	ret = pthread_create(&thread, NULL, wait_thread, &thread_args);
+	EXPECT_EQ(0, ret);
+
+	ret = wait_for_thread(thread, 100);
+	EXPECT_EQ(ETIMEDOUT, ret);
+
+	ret = ioctl(objs[1], NTSYNC_IOC_EVENT_SET, &signaled);
+	EXPECT_EQ(0, ret);
+	EXPECT_EQ(0, signaled);
+	check_event_state(objs[1], 0, 0);
+
+	ret = wait_for_thread(thread, 100);
+	EXPECT_EQ(0, ret);
+	EXPECT_EQ(0, thread_args.ret);
+	EXPECT_EQ(1, wait_args.index);
+
+	wait_args.timeout = get_abs_timeout(1000);
+	ret = pthread_create(&thread, NULL, wait_thread, &thread_args);
+	EXPECT_EQ(0, ret);
+
+	ret = wait_for_thread(thread, 100);
+	EXPECT_EQ(ETIMEDOUT, ret);
+
+	ret = ioctl(objs[1], NTSYNC_IOC_EVENT_PULSE, &signaled);
+	EXPECT_EQ(0, ret);
+	EXPECT_EQ(0, signaled);
+	check_event_state(objs[1], 0, 0);
+
+	ret = wait_for_thread(thread, 100);
+	EXPECT_EQ(0, ret);
+	EXPECT_EQ(0, thread_args.ret);
+	EXPECT_EQ(1, wait_args.index);
+
+	close(objs[1]);
+
+	event_args.manual = true;
+	event_args.signaled = false;
+	objs[1] = ioctl(fd, NTSYNC_IOC_CREATE_EVENT, &event_args);
+	EXPECT_LE(0, objs[1]);
+
+	wait_args.timeout = get_abs_timeout(1000);
+	ret = pthread_create(&thread, NULL, wait_thread, &thread_args);
+	EXPECT_EQ(0, ret);
+
+	ret = wait_for_thread(thread, 100);
+	EXPECT_EQ(ETIMEDOUT, ret);
+
+	ret = ioctl(objs[1], NTSYNC_IOC_EVENT_SET, &signaled);
+	EXPECT_EQ(0, ret);
+	EXPECT_EQ(0, signaled);
+	check_event_state(objs[1], 1, 1);
+
+	ret = wait_for_thread(thread, 100);
+	EXPECT_EQ(0, ret);
+	EXPECT_EQ(0, thread_args.ret);
+	EXPECT_EQ(1, wait_args.index);
+
+	ret = ioctl(objs[1], NTSYNC_IOC_EVENT_RESET, &signaled);
+	EXPECT_EQ(0, ret);
+	EXPECT_EQ(1, signaled);
+
+	wait_args.timeout = get_abs_timeout(1000);
+	ret = pthread_create(&thread, NULL, wait_thread, &thread_args);
+	EXPECT_EQ(0, ret);
+
+	ret = wait_for_thread(thread, 100);
+	EXPECT_EQ(ETIMEDOUT, ret);
+
+	ret = ioctl(objs[1], NTSYNC_IOC_EVENT_PULSE, &signaled);
+	EXPECT_EQ(0, ret);
+	EXPECT_EQ(0, signaled);
+	check_event_state(objs[1], 0, 1);
+
+	ret = wait_for_thread(thread, 100);
+	EXPECT_EQ(0, ret);
+	EXPECT_EQ(0, thread_args.ret);
+	EXPECT_EQ(1, wait_args.index);
+
 	/* delete an object while it's being waited on */
 
 	wait_args.timeout = get_abs_timeout(200);
@@ -819,12 +922,14 @@ TEST(wake_any)
 
 TEST(wake_all)
 {
+	struct ntsync_event_args manual_event_args = {0};
+	struct ntsync_event_args auto_event_args = {0};
 	struct ntsync_mutex_args mutex_args = {0};
 	struct ntsync_wait_args wait_args = {0};
 	struct ntsync_sem_args sem_args = {0};
 	struct wait_args thread_args;
-	int objs[2], fd, ret;
-	__u32 count, index;
+	__u32 count, index, signaled;
+	int objs[4], fd, ret;
 	pthread_t thread;
 
 	fd = open("/dev/ntsync", O_CLOEXEC | O_RDONLY);
@@ -840,9 +945,19 @@ TEST(wake_all)
 	objs[1] = ioctl(fd, NTSYNC_IOC_CREATE_MUTEX, &mutex_args);
 	EXPECT_LE(0, objs[1]);
 
+	manual_event_args.manual = true;
+	manual_event_args.signaled = true;
+	objs[2] = ioctl(fd, NTSYNC_IOC_CREATE_EVENT, &manual_event_args);
+	EXPECT_LE(0, objs[2]);
+
+	auto_event_args.manual = false;
+	auto_event_args.signaled = true;
+	objs[3] = ioctl(fd, NTSYNC_IOC_CREATE_EVENT, &auto_event_args);
+	EXPECT_EQ(0, objs[3]);
+
 	wait_args.timeout = get_abs_timeout(1000);
 	wait_args.objs = (uintptr_t)objs;
-	wait_args.count = 2;
+	wait_args.count = 4;
 	wait_args.owner = 456;
 	thread_args.fd = fd;
 	thread_args.args = &wait_args;
@@ -876,12 +991,32 @@ TEST(wake_all)
 
 	check_mutex_state(objs[1], 0, 0);
 
+	ret = ioctl(objs[2], NTSYNC_IOC_EVENT_RESET, &signaled);
+	EXPECT_EQ(0, ret);
+	EXPECT_EQ(1, signaled);
+
 	count = 2;
 	ret = release_sem(objs[0], &count);
 	EXPECT_EQ(0, ret);
 	EXPECT_EQ(0, count);
+	check_sem_state(objs[0], 2, 3);
+
+	ret = ioctl(objs[3], NTSYNC_IOC_EVENT_RESET, &signaled);
+	EXPECT_EQ(0, ret);
+	EXPECT_EQ(1, signaled);
+
+	ret = ioctl(objs[2], NTSYNC_IOC_EVENT_SET, &signaled);
+	EXPECT_EQ(0, ret);
+	EXPECT_EQ(0, signaled);
+
+	ret = ioctl(objs[3], NTSYNC_IOC_EVENT_SET, &signaled);
+	EXPECT_EQ(0, ret);
+	EXPECT_EQ(0, signaled);
+
 	check_sem_state(objs[0], 1, 3);
 	check_mutex_state(objs[1], 1, 456);
+	check_event_state(objs[2], 1, 1);
+	check_event_state(objs[3], 0, 0);
 
 	ret = wait_for_thread(thread, 100);
 	EXPECT_EQ(0, ret);
@@ -899,6 +1034,8 @@ TEST(wake_all)
 
 	close(objs[0]);
 	close(objs[1]);
+	close(objs[2]);
+	close(objs[3]);
 
 	ret = wait_for_thread(thread, 200);
 	EXPECT_EQ(0, ret);
-- 
2.45.2


