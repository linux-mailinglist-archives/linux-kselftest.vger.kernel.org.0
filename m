Return-Path: <linux-kselftest+bounces-4705-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF1038557F0
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Feb 2024 00:59:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 668DA28380A
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Feb 2024 23:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0DB614E2CB;
	Wed, 14 Feb 2024 23:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b="V7iG6Kx8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.codeweavers.com (mail.codeweavers.com [4.36.192.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20D6614D42C;
	Wed, 14 Feb 2024 23:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.36.192.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707954830; cv=none; b=azaE2mFfZmegGwx1+jmxI4u7PXYeGuaHvrOqiXV377+SLdfhqSz4k3gPyTU659x90QPNL6aSP9tpRWAJNwGVAxTyGC7BFZgESR4V1lsDQdNNEjFqOHdKSqLNQFhw9gWBeEXGDZUn5wrfBqtVy77rqHiD/fvvk1K0fDANIAXPqrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707954830; c=relaxed/simple;
	bh=XMvFHFc2CGosZP7MDvd92+zIVqQ2HheCAZ7F1doC6pc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DKAOFiXKjAGI7jATWYuJN+cYj7zNpDA3mQY5ioBxLkSzTl4IV7AdBB+gWuzJcdCaDHZvWkl7zw43ZIoxeRkSuGYFPhNwstnAsSoC0dW8JuPh1NmV8i3XqXgitWYAHMDImUl5lrw2C4StUIZL9C5qG6W3DK1rNG8X9oId3doTz5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com; spf=pass smtp.mailfrom=codeweavers.com; dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b=V7iG6Kx8; arc=none smtp.client-ip=4.36.192.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeweavers.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codeweavers.com; s=s1; h=Message-ID:Date:Subject:Cc:To:From:Sender;
	bh=7dn5WolQcrK3uS9fWtUm2XVEVusDAXkpRvnTtBWnrzc=; b=V7iG6Kx8qAV3QNv+I3QCkxZZzH
	KaWhlVeuMPoIShH0A0/zt/96+sCoHqlZg1WOKikNN3+ZrYhyBelTssmpDF79S5E6+udQwSUN8YHK1
	IUeXn1QiQg+fLAJyC2DmeN7rg5kyXd1u0jlLzQycOjQX3uKDiRpVqBfN75ruKdSp18KyGw663JA/e
	J3zw+/PLS6ni+wWITGY+0lJmZFqdlaLjq9cP7jlueq4Qgi9fmdC70IoZLZcaWtIQGOOuO7WlK2IxU
	7JiWQ/p+5/74WOvJw2zILJ8EHAb7Gd4+S9l9CA+nrtLucd7VZY8B8rojwwwWzTnwwNrpHUD/m3Fxe
	GWSXNCBw==;
Received: from cw137ip160.mn.codeweavers.com ([10.69.137.160] helo=camazotz.mn.codeweavers.com)
	by mail.codeweavers.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <zfigura@codeweavers.com>)
	id 1raP4T-00GcSK-27;
	Wed, 14 Feb 2024 17:53:45 -0600
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
Subject: [PATCH 26/31] selftests: ntsync: Add some tests for wakeup signaling with events.
Date: Wed, 14 Feb 2024 17:53:01 -0600
Message-ID: <20240214235307.10494-17-zfigura@codeweavers.com>
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

Expand the contended wait tests, which previously only covered events and
semaphores, to cover events as well.

Signed-off-by: Elizabeth Figura <zfigura@codeweavers.com>
---
 .../testing/selftests/drivers/ntsync/ntsync.c | 151 +++++++++++++++++-
 1 file changed, 147 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/drivers/ntsync/ntsync.c b/tools/testing/selftests/drivers/ntsync/ntsync.c
index 49ee4be280f6..bcf33bcf8c51 100644
--- a/tools/testing/selftests/drivers/ntsync/ntsync.c
+++ b/tools/testing/selftests/drivers/ntsync/ntsync.c
@@ -622,6 +622,7 @@ TEST(test_wait_any)
 
 TEST(test_wait_all)
 {
+	struct ntsync_event_args event_args = {0};
 	struct ntsync_mutex_args mutex_args = {0};
 	struct ntsync_sem_args sem_args = {0};
 	__u32 owner, index, count;
@@ -644,6 +645,11 @@ TEST(test_wait_all)
 	EXPECT_EQ(0, ret);
 	EXPECT_NE(0xdeadbeef, mutex_args.mutex);
 
+	event_args.manual = true;
+	event_args.signaled = true;
+	ret = ioctl(fd, NTSYNC_IOC_CREATE_EVENT, &event_args);
+	EXPECT_EQ(0, ret);
+
 	objs[0] = sem_args.sem;
 	objs[1] = mutex_args.mutex;
 
@@ -692,6 +698,14 @@ TEST(test_wait_all)
 	check_sem_state(sem_args.sem, 1, 3);
 	check_mutex_state(mutex_args.mutex, 1, 123);
 
+	objs[0] = sem_args.sem;
+	objs[1] = event_args.event;
+	ret = wait_all(fd, 2, objs, 123, &index);
+	EXPECT_EQ(0, ret);
+	EXPECT_EQ(0, index);
+	check_sem_state(sem_args.sem, 0, 3);
+	check_event_state(event_args.event, 1, 1);
+
 	/* test waiting on the same object twice */
 	objs[0] = objs[1] = sem_args.sem;
 	ret = wait_all(fd, 2, objs, 123, &index);
@@ -700,6 +714,7 @@ TEST(test_wait_all)
 
 	close(sem_args.sem);
 	close(mutex_args.mutex);
+	close(event_args.event);
 
 	close(fd);
 }
@@ -746,12 +761,13 @@ static int wait_for_thread(pthread_t thread, unsigned int ms)
 
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
@@ -833,10 +849,101 @@ TEST(wake_any)
 	EXPECT_EQ(0, thread_args.ret);
 	EXPECT_EQ(1, wait_args.index);
 
+	/* test waking events */
+
+	event_args.manual = false;
+	event_args.signaled = false;
+	ret = ioctl(fd, NTSYNC_IOC_CREATE_EVENT, &event_args);
+	EXPECT_EQ(0, ret);
+
+	objs[1] = event_args.event;
+	wait_args.timeout = get_abs_timeout(1000);
+	ret = pthread_create(&thread, NULL, wait_thread, &thread_args);
+	EXPECT_EQ(0, ret);
+
+	ret = wait_for_thread(thread, 100);
+	EXPECT_EQ(ETIMEDOUT, ret);
+
+	ret = ioctl(event_args.event, NTSYNC_IOC_EVENT_SET, &signaled);
+	EXPECT_EQ(0, ret);
+	EXPECT_EQ(0, signaled);
+	check_event_state(event_args.event, 0, 0);
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
+	ret = ioctl(event_args.event, NTSYNC_IOC_EVENT_PULSE, &signaled);
+	EXPECT_EQ(0, ret);
+	EXPECT_EQ(0, signaled);
+	check_event_state(event_args.event, 0, 0);
+
+	ret = wait_for_thread(thread, 100);
+	EXPECT_EQ(0, ret);
+	EXPECT_EQ(0, thread_args.ret);
+	EXPECT_EQ(1, wait_args.index);
+
+	close(event_args.event);
+
+	event_args.manual = true;
+	event_args.signaled = false;
+	ret = ioctl(fd, NTSYNC_IOC_CREATE_EVENT, &event_args);
+	EXPECT_EQ(0, ret);
+
+	objs[1] = event_args.event;
+	wait_args.timeout = get_abs_timeout(1000);
+	ret = pthread_create(&thread, NULL, wait_thread, &thread_args);
+	EXPECT_EQ(0, ret);
+
+	ret = wait_for_thread(thread, 100);
+	EXPECT_EQ(ETIMEDOUT, ret);
+
+	ret = ioctl(event_args.event, NTSYNC_IOC_EVENT_SET, &signaled);
+	EXPECT_EQ(0, ret);
+	EXPECT_EQ(0, signaled);
+	check_event_state(event_args.event, 1, 1);
+
+	ret = wait_for_thread(thread, 100);
+	EXPECT_EQ(0, ret);
+	EXPECT_EQ(0, thread_args.ret);
+	EXPECT_EQ(1, wait_args.index);
+
+	ret = ioctl(event_args.event, NTSYNC_IOC_EVENT_RESET, &signaled);
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
+	ret = ioctl(event_args.event, NTSYNC_IOC_EVENT_PULSE, &signaled);
+	EXPECT_EQ(0, ret);
+	EXPECT_EQ(0, signaled);
+	check_event_state(event_args.event, 0, 1);
+
+	ret = wait_for_thread(thread, 100);
+	EXPECT_EQ(0, ret);
+	EXPECT_EQ(0, thread_args.ret);
+	EXPECT_EQ(1, wait_args.index);
+
+	close(event_args.event);
+
 	/* delete an object while it's being waited on */
 
 	wait_args.timeout = get_abs_timeout(200);
 	wait_args.owner = 123;
+	objs[1] = mutex_args.mutex;
 	ret = pthread_create(&thread, NULL, wait_thread, &thread_args);
 	EXPECT_EQ(0, ret);
 
@@ -856,12 +963,14 @@ TEST(wake_any)
 
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
@@ -881,12 +990,24 @@ TEST(wake_all)
 	EXPECT_EQ(0, ret);
 	EXPECT_NE(0xdeadbeef, mutex_args.mutex);
 
+	manual_event_args.manual = true;
+	manual_event_args.signaled = true;
+	ret = ioctl(fd, NTSYNC_IOC_CREATE_EVENT, &manual_event_args);
+	EXPECT_EQ(0, ret);
+
+	auto_event_args.manual = false;
+	auto_event_args.signaled = true;
+	ret = ioctl(fd, NTSYNC_IOC_CREATE_EVENT, &auto_event_args);
+	EXPECT_EQ(0, ret);
+
 	objs[0] = sem_args.sem;
 	objs[1] = mutex_args.mutex;
+	objs[2] = manual_event_args.event;
+	objs[3] = auto_event_args.event;
 
 	wait_args.timeout = get_abs_timeout(1000);
 	wait_args.objs = (uintptr_t)objs;
-	wait_args.count = 2;
+	wait_args.count = 4;
 	wait_args.owner = 456;
 	thread_args.fd = fd;
 	thread_args.args = &wait_args;
@@ -920,12 +1041,32 @@ TEST(wake_all)
 
 	check_mutex_state(mutex_args.mutex, 0, 0);
 
+	ret = ioctl(manual_event_args.event, NTSYNC_IOC_EVENT_RESET, &signaled);
+	EXPECT_EQ(0, ret);
+	EXPECT_EQ(1, signaled);
+
 	count = 2;
 	ret = post_sem(sem_args.sem, &count);
 	EXPECT_EQ(0, ret);
 	EXPECT_EQ(0, count);
+	check_sem_state(sem_args.sem, 2, 3);
+
+	ret = ioctl(auto_event_args.event, NTSYNC_IOC_EVENT_RESET, &signaled);
+	EXPECT_EQ(0, ret);
+	EXPECT_EQ(1, signaled);
+
+	ret = ioctl(manual_event_args.event, NTSYNC_IOC_EVENT_SET, &signaled);
+	EXPECT_EQ(0, ret);
+	EXPECT_EQ(0, signaled);
+
+	ret = ioctl(auto_event_args.event, NTSYNC_IOC_EVENT_SET, &signaled);
+	EXPECT_EQ(0, ret);
+	EXPECT_EQ(0, signaled);
+
 	check_sem_state(sem_args.sem, 1, 3);
 	check_mutex_state(mutex_args.mutex, 1, 456);
+	check_event_state(manual_event_args.event, 1, 1);
+	check_event_state(auto_event_args.event, 0, 0);
 
 	ret = wait_for_thread(thread, 100);
 	EXPECT_EQ(0, ret);
@@ -943,6 +1084,8 @@ TEST(wake_all)
 
 	close(sem_args.sem);
 	close(mutex_args.mutex);
+	close(manual_event_args.event);
+	close(auto_event_args.event);
 
 	ret = wait_for_thread(thread, 200);
 	EXPECT_EQ(0, ret);
-- 
2.43.0


