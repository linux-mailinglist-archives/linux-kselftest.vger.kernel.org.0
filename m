Return-Path: <linux-kselftest+bounces-4698-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26C598557D3
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Feb 2024 00:58:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D372F2868BD
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Feb 2024 23:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEB5114A4F0;
	Wed, 14 Feb 2024 23:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b="fcbfpW1a"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.codeweavers.com (mail.codeweavers.com [4.36.192.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00B38145352;
	Wed, 14 Feb 2024 23:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.36.192.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707954823; cv=none; b=dXbqLrWqRQVlO33eWu8jZku6yDQbXICnyqjM+pGn7Kumhju39HLMwkjNsZL3e62Ihmf2l3FllOOorjts6CROiuFkZjFbub7++kfiaSHvkK6ZfAmdGC1oGqJ5BFNgEI49pr+kXLnyeUCoX+8L1OQ/+GGFVSXKvyAjabw9Qgyd2tY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707954823; c=relaxed/simple;
	bh=vv/+JGmQGe3Qq3Euywo0D/0Z6gsPsvDvAvr3zg9+Bas=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p2ghHxvIMQ7PKNBGvY6cS54D4n/AJIjmuimrTGrQ7TsA3nYBu0aX5yEzEOIrwG5flGYHgca3Jbn8JYlGxhOqBhbO5UbNii9tqKs+9uS+/Yt+tLcWnr+UQLm1vvnud3aMD6W6N9MIqyqJZxE4GBjTftOa6SfUwGu8BNLqpLf3ZdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com; spf=pass smtp.mailfrom=codeweavers.com; dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b=fcbfpW1a; arc=none smtp.client-ip=4.36.192.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeweavers.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codeweavers.com; s=s1; h=Message-ID:Date:Subject:Cc:To:From:Sender;
	bh=ZF4vcia88ZreqFYvisq7ptV14EhxENO+K11K9xG70PQ=; b=fcbfpW1alVSUbLp45kmqjpTago
	Nv6pG7K/54jOx9h+dXSKXJuIvSBd1V+Y1arlqg76q0TW88iLeSD3DqHsqJCejAe3wlWwW+xRXGbi6
	NJnWKr8oB53GAsZ+h6nlOajP7hcsDfcypF8XtwC59FGxupq0vaWdV0wOhqhdqhFUj8hWEdxO7N/V0
	SHdgJtp3UjboqT+NDJnkDS9FzvWKAkOxVjJgpR5ZGIIBbk7oo1QanmPcKWofJnIwl/6kkwkg6kv4Q
	jdhoopJ8RH5oXUIsLbXjLkdwAPnN0RVBzGxin74s9HEOZ9ceJSI3NOXNjkmY1pJNxaZi3W2Iz19Nx
	xeBtmJ0A==;
Received: from cw137ip160.mn.codeweavers.com ([10.69.137.160] helo=camazotz.mn.codeweavers.com)
	by mail.codeweavers.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <zfigura@codeweavers.com>)
	id 1raP4K-00GcSK-0v;
	Wed, 14 Feb 2024 17:53:36 -0600
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
Subject: [PATCH 19/31] selftests: ntsync: Add some tests for mutex state.
Date: Wed, 14 Feb 2024 17:52:54 -0600
Message-ID: <20240214235307.10494-10-zfigura@codeweavers.com>
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

Test mutex-specific ioctls NTSYNC_IOC_MUTEX_UNLOCK and NTSYNC_IOC_MUTEX_READ,
and waiting on mutexes.

Signed-off-by: Elizabeth Figura <zfigura@codeweavers.com>
---
 .../testing/selftests/drivers/ntsync/ntsync.c | 196 ++++++++++++++++++
 1 file changed, 196 insertions(+)

diff --git a/tools/testing/selftests/drivers/ntsync/ntsync.c b/tools/testing/selftests/drivers/ntsync/ntsync.c
index bda88233b427..d2c0c97839ba 100644
--- a/tools/testing/selftests/drivers/ntsync/ntsync.c
+++ b/tools/testing/selftests/drivers/ntsync/ntsync.c
@@ -40,6 +40,39 @@ static int post_sem(int sem, __u32 *count)
 	return ioctl(sem, NTSYNC_IOC_SEM_POST, count);
 }
 
+static int read_mutex_state(int mutex, __u32 *count, __u32 *owner)
+{
+	struct ntsync_mutex_args args;
+	int ret;
+
+	memset(&args, 0xcc, sizeof(args));
+	ret = ioctl(mutex, NTSYNC_IOC_MUTEX_READ, &args);
+	*count = args.count;
+	*owner = args.owner;
+	return ret;
+}
+
+#define check_mutex_state(mutex, count, owner) \
+	({ \
+		__u32 __count, __owner; \
+		int ret = read_mutex_state((mutex), &__count, &__owner); \
+		EXPECT_EQ(0, ret); \
+		EXPECT_EQ((count), __count); \
+		EXPECT_EQ((owner), __owner); \
+	})
+
+static int unlock_mutex(int mutex, __u32 owner, __u32 *count)
+{
+	struct ntsync_mutex_args args;
+	int ret;
+
+	args.owner = owner;
+	args.count = 0xdeadbeef;
+	ret = ioctl(mutex, NTSYNC_IOC_MUTEX_UNLOCK, &args);
+	*count = args.count;
+	return ret;
+}
+
 static int wait_any(int fd, __u32 count, const int *objs, __u32 owner, __u32 *index)
 {
 	struct ntsync_wait_args args = {0};
@@ -146,4 +179,167 @@ TEST(semaphore_state)
 	close(fd);
 }
 
+TEST(mutex_state)
+{
+	struct ntsync_mutex_args mutex_args;
+	__u32 owner, count, index;
+	struct timespec timeout;
+	int fd, ret, mutex;
+
+	clock_gettime(CLOCK_MONOTONIC, &timeout);
+
+	fd = open("/dev/ntsync", O_CLOEXEC | O_RDONLY);
+	ASSERT_LE(0, fd);
+
+	mutex_args.owner = 123;
+	mutex_args.count = 0;
+	ret = ioctl(fd, NTSYNC_IOC_CREATE_MUTEX, &mutex_args);
+	EXPECT_EQ(-1, ret);
+	EXPECT_EQ(EINVAL, errno);
+
+	mutex_args.owner = 0;
+	mutex_args.count = 2;
+	ret = ioctl(fd, NTSYNC_IOC_CREATE_MUTEX, &mutex_args);
+	EXPECT_EQ(-1, ret);
+	EXPECT_EQ(EINVAL, errno);
+
+	mutex_args.owner = 123;
+	mutex_args.count = 2;
+	mutex_args.mutex = 0xdeadbeef;
+	ret = ioctl(fd, NTSYNC_IOC_CREATE_MUTEX, &mutex_args);
+	EXPECT_EQ(0, ret);
+	EXPECT_NE(0xdeadbeef, mutex_args.mutex);
+	mutex = mutex_args.mutex;
+	check_mutex_state(mutex, 2, 123);
+
+	ret = unlock_mutex(mutex, 0, &count);
+	EXPECT_EQ(-1, ret);
+	EXPECT_EQ(EINVAL, errno);
+
+	ret = unlock_mutex(mutex, 456, &count);
+	EXPECT_EQ(-1, ret);
+	EXPECT_EQ(EPERM, errno);
+	check_mutex_state(mutex, 2, 123);
+
+	ret = unlock_mutex(mutex, 123, &count);
+	EXPECT_EQ(0, ret);
+	EXPECT_EQ(2, count);
+	check_mutex_state(mutex, 1, 123);
+
+	ret = unlock_mutex(mutex, 123, &count);
+	EXPECT_EQ(0, ret);
+	EXPECT_EQ(1, count);
+	check_mutex_state(mutex, 0, 0);
+
+	ret = unlock_mutex(mutex, 123, &count);
+	EXPECT_EQ(-1, ret);
+	EXPECT_EQ(EPERM, errno);
+
+	ret = wait_any(fd, 1, &mutex, 456, &index);
+	EXPECT_EQ(0, ret);
+	EXPECT_EQ(0, index);
+	check_mutex_state(mutex, 1, 456);
+
+	ret = wait_any(fd, 1, &mutex, 456, &index);
+	EXPECT_EQ(0, ret);
+	EXPECT_EQ(0, index);
+	check_mutex_state(mutex, 2, 456);
+
+	ret = unlock_mutex(mutex, 456, &count);
+	EXPECT_EQ(0, ret);
+	EXPECT_EQ(2, count);
+	check_mutex_state(mutex, 1, 456);
+
+	ret = wait_any(fd, 1, &mutex, 123, &index);
+	EXPECT_EQ(-1, ret);
+	EXPECT_EQ(ETIMEDOUT, errno);
+
+	owner = 0;
+	ret = ioctl(mutex, NTSYNC_IOC_MUTEX_KILL, &owner);
+	EXPECT_EQ(-1, ret);
+	EXPECT_EQ(EINVAL, errno);
+
+	owner = 123;
+	ret = ioctl(mutex, NTSYNC_IOC_MUTEX_KILL, &owner);
+	EXPECT_EQ(-1, ret);
+	EXPECT_EQ(EPERM, errno);
+	check_mutex_state(mutex, 1, 456);
+
+	owner = 456;
+	ret = ioctl(mutex, NTSYNC_IOC_MUTEX_KILL, &owner);
+	EXPECT_EQ(0, ret);
+
+	memset(&mutex_args, 0xcc, sizeof(mutex_args));
+	ret = ioctl(mutex, NTSYNC_IOC_MUTEX_READ, &mutex_args);
+	EXPECT_EQ(-1, ret);
+	EXPECT_EQ(EOWNERDEAD, errno);
+	EXPECT_EQ(0, mutex_args.count);
+	EXPECT_EQ(0, mutex_args.owner);
+
+	memset(&mutex_args, 0xcc, sizeof(mutex_args));
+	ret = ioctl(mutex, NTSYNC_IOC_MUTEX_READ, &mutex_args);
+	EXPECT_EQ(-1, ret);
+	EXPECT_EQ(EOWNERDEAD, errno);
+	EXPECT_EQ(0, mutex_args.count);
+	EXPECT_EQ(0, mutex_args.owner);
+
+	ret = wait_any(fd, 1, &mutex, 123, &index);
+	EXPECT_EQ(-1, ret);
+	EXPECT_EQ(EOWNERDEAD, errno);
+	EXPECT_EQ(0, index);
+	check_mutex_state(mutex, 1, 123);
+
+	owner = 123;
+	ret = ioctl(mutex, NTSYNC_IOC_MUTEX_KILL, &owner);
+	EXPECT_EQ(0, ret);
+
+	memset(&mutex_args, 0xcc, sizeof(mutex_args));
+	ret = ioctl(mutex, NTSYNC_IOC_MUTEX_READ, &mutex_args);
+	EXPECT_EQ(-1, ret);
+	EXPECT_EQ(EOWNERDEAD, errno);
+	EXPECT_EQ(0, mutex_args.count);
+	EXPECT_EQ(0, mutex_args.owner);
+
+	ret = wait_any(fd, 1, &mutex, 123, &index);
+	EXPECT_EQ(-1, ret);
+	EXPECT_EQ(EOWNERDEAD, errno);
+	EXPECT_EQ(0, index);
+	check_mutex_state(mutex, 1, 123);
+
+	close(mutex);
+
+	mutex_args.owner = 0;
+	mutex_args.count = 0;
+	mutex_args.mutex = 0xdeadbeef;
+	ret = ioctl(fd, NTSYNC_IOC_CREATE_MUTEX, &mutex_args);
+	EXPECT_EQ(0, ret);
+	EXPECT_NE(0xdeadbeef, mutex_args.mutex);
+	mutex = mutex_args.mutex;
+	check_mutex_state(mutex, 0, 0);
+
+	ret = wait_any(fd, 1, &mutex, 123, &index);
+	EXPECT_EQ(0, ret);
+	EXPECT_EQ(0, index);
+	check_mutex_state(mutex, 1, 123);
+
+	close(mutex);
+
+	mutex_args.owner = 123;
+	mutex_args.count = ~0u;
+	mutex_args.mutex = 0xdeadbeef;
+	ret = ioctl(fd, NTSYNC_IOC_CREATE_MUTEX, &mutex_args);
+	EXPECT_EQ(0, ret);
+	EXPECT_NE(0xdeadbeef, mutex_args.mutex);
+	mutex = mutex_args.mutex;
+	check_mutex_state(mutex, ~0u, 123);
+
+	ret = wait_any(fd, 1, &mutex, 123, &index);
+	EXPECT_EQ(-1, ret);
+	EXPECT_EQ(ETIMEDOUT, errno);
+
+	close(mutex);
+
+	close(fd);
+}
+
 TEST_HARNESS_MAIN
-- 
2.43.0


