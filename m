Return-Path: <linux-kselftest+bounces-23067-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42FA59E9ED2
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Dec 2024 20:03:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBC521888FE7
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Dec 2024 19:02:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5D0519CC17;
	Mon,  9 Dec 2024 18:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b="RHJxmLBb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.codeweavers.com (mail.codeweavers.com [4.36.192.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA32019AA5D;
	Mon,  9 Dec 2024 18:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.36.192.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733770779; cv=none; b=cx7GjvJm01COQQhFKqRjFrNkc8J7kBW5AhFvDeimsf5kjb3OfautOps0za1Cm6lMtTh1ug7rXG2L74j86C4zd5FDLZKGrtfLZ0lpMOZls0wT5Jg30reTYAvYIV6aS0B/zQ5vW0bNmx11a0fT/lvxNIc7qwdZq04qwmdQZkzbc9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733770779; c=relaxed/simple;
	bh=DjnEbJDoB9Dul+eXHq8clKxcbVu75NwycVVhQWnf0ig=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EPElPRj0F8L+jA6PAnHFFp9vjIqodVkxtiMj5yM+3SnahnBr6c/75R6XvSnKuHGCOBIX7W+8Q2jskN8zkh+K+0Ub5RIdDb9hJdzjsYd1UQMOYrEBBsqFyEFV6gJ+WURQjnftq95zwtELh2dyUSMR62GNRjsaln++6V4yCeofeD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com; spf=pass smtp.mailfrom=codeweavers.com; dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b=RHJxmLBb; arc=none smtp.client-ip=4.36.192.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeweavers.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codeweavers.com; s=s1; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=X2FClKwDD6Y5NBJzrFcfOYwIT9ygvxJfJzIcvxri0Xc=; b=RHJxmLBbEv0UfgKHPNnS0TDckw
	BNjKqD83SPLehXu69xkLvUQJlpCujZ0rT2yqLkKSg4qNSZjtYUCugS6zo0uOWWrUYcSiA63iesJej
	ki8+qaqiYsH6mFSiJCBZjsRKHUv8vU1IQmzQw1WzrIpV5OF9udEetP5e6Bg/I5bplu3+pdQqYt+Eb
	myNQq9i2hTxn1ASU/NzJwFHpiup+auL4VBufMJy3WgB8KIe+5QXanjdYa8xgcYq9JsFQcEmmLZfqY
	vpytIHJVsiSl7rKX7nDbhxpjJSmBKj0b/x/Q3zRxf/isJa/2BnaPstFmGQB8JDK7YzFlYwzwqVcnV
	8HVhY+6g==;
Received: from cw137ip160.mn.codeweavers.com ([10.69.137.160] helo=camazotz.mn.codeweavers.com)
	by mail.codeweavers.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <zfigura@codeweavers.com>)
	id 1tKiyl-001Gd5-2u;
	Mon, 09 Dec 2024 12:59:36 -0600
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
Subject: [PATCH v6 22/28] selftests: ntsync: Add some tests for wakeup signaling with events.
Date: Mon,  9 Dec 2024 12:58:58 -0600
Message-ID: <20241209185904.507350-23-zfigura@codeweavers.com>
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

Expand the contended wait tests, which previously only covered events and
semaphores, to cover events as well.

Signed-off-by: Elizabeth Figura <zfigura@codeweavers.com>
---
 .../testing/selftests/drivers/ntsync/ntsync.c | 151 +++++++++++++++++-
 1 file changed, 147 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/drivers/ntsync/ntsync.c b/tools/testing/selftests/drivers/ntsync/ntsync.c
index 12ccb4ec28e4..5d17eff6a370 100644
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
2.45.2


