Return-Path: <linux-kselftest+bounces-4701-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D25188557DD
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Feb 2024 00:58:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 033AB1C20F81
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Feb 2024 23:58:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C50E014AD3A;
	Wed, 14 Feb 2024 23:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b="aqPqoxM9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.codeweavers.com (mail.codeweavers.com [4.36.192.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BC7F14AD0F;
	Wed, 14 Feb 2024 23:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.36.192.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707954826; cv=none; b=aboVrI63MqeSvaMScZYhXf6WgeLYbfbqOMFp6o7STbial0JP6TzSXMyPJ58CMlsSCLOnXUXr1j2X98BwICAgyp47uMQpSlXpcx+NI7eoGTF83sV2bJBGMj5n1A4Ulv3gPFTm3uLZJp1icn+C5HpofyGjmrr8xjm0ptq+lb+3XXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707954826; c=relaxed/simple;
	bh=/whYOeACwtu31Fu1HZzhtAvXvBVbIbJitm1kfNTCQdc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TdsiWf8FUgeaLUwu44Bjgj8648uGeyjHcNCemQlUkbaQieRWY1haFzvdMxuY4sXa+cg1TujIck4K1Htl9isFq04EjMZyrYdyJh9Iazo+p61Lwcx1t/pAb1hrGYs7k9GtvMwKRvVD4EMKXCuKFjza/AtoRCWAsyqB9bqTMKrVgEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com; spf=pass smtp.mailfrom=codeweavers.com; dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b=aqPqoxM9; arc=none smtp.client-ip=4.36.192.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeweavers.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codeweavers.com; s=s1; h=Message-ID:Date:Subject:Cc:To:From:Sender;
	bh=YSaDBCGA1golPpmWfwYA367banBPgBVmSEy31tHzCEo=; b=aqPqoxM9ZJ606x8AqtcLyW3yYU
	L17z4eErFppbYR5lXYblhEswyJRE9thuDNFBDaxbGUWhEtM7ncSlB03Jfj2lu36NqG+pszFhZUMuE
	yR2QKUDaemXWBGt0aNN8hNmB72+Qgl7nzGX0kh8YF9OwzBkJTvUgCvvwdQQR2qOkXeDcoNGzyQqLm
	Uglv8NmTvBeC7pNn8rqddonKhuv49xBEdA8NQflu0Xe5xs87SeR1OIBB7Nemwum0RxFvVens4TmTa
	LRlAJ9ixWHrDi9B2Y9n67LuFgLmY4Ms78dt/Ed+ctG98spREKeJo5bkdMV0uFOafM3awh6CeE0B1l
	uMob4zhw==;
Received: from cw137ip160.mn.codeweavers.com ([10.69.137.160] helo=camazotz.mn.codeweavers.com)
	by mail.codeweavers.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <zfigura@codeweavers.com>)
	id 1raP4O-00GcSK-0d;
	Wed, 14 Feb 2024 17:53:41 -0600
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
Subject: [PATCH 22/31] selftests: ntsync: Add some tests for wakeup signaling with WINESYNC_IOC_WAIT_ANY.
Date: Wed, 14 Feb 2024 17:52:57 -0600
Message-ID: <20240214235307.10494-13-zfigura@codeweavers.com>
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

Test contended "wait-for-any" waits, to make sure that scheduling and wakeup
logic works correctly.

Signed-off-by: Elizabeth Figura <zfigura@codeweavers.com>
---
 .../testing/selftests/drivers/ntsync/ntsync.c | 150 ++++++++++++++++++
 1 file changed, 150 insertions(+)

diff --git a/tools/testing/selftests/drivers/ntsync/ntsync.c b/tools/testing/selftests/drivers/ntsync/ntsync.c
index 6bb3bdc2ef3c..e825e115f11f 100644
--- a/tools/testing/selftests/drivers/ntsync/ntsync.c
+++ b/tools/testing/selftests/drivers/ntsync/ntsync.c
@@ -556,4 +556,154 @@ TEST(test_wait_all)
 	close(fd);
 }
 
+struct wake_args {
+	int fd;
+	int obj;
+};
+
+struct wait_args {
+	int fd;
+	unsigned long request;
+	struct ntsync_wait_args *args;
+	int ret;
+	int err;
+};
+
+static void *wait_thread(void *arg)
+{
+	struct wait_args *args = arg;
+
+	args->ret = ioctl(args->fd, args->request, args->args);
+	args->err = errno;
+	return NULL;
+}
+
+static __u64 get_abs_timeout(unsigned int ms)
+{
+	struct timespec timeout;
+	clock_gettime(CLOCK_MONOTONIC, &timeout);
+	return (timeout.tv_sec * 1000000000) + timeout.tv_nsec + (ms * 1000000);
+}
+
+static int wait_for_thread(pthread_t thread, unsigned int ms)
+{
+	struct timespec timeout;
+
+	clock_gettime(CLOCK_REALTIME, &timeout);
+	timeout.tv_nsec += ms * 1000000;
+	timeout.tv_sec += (timeout.tv_nsec / 1000000000);
+	timeout.tv_nsec %= 1000000000;
+	return pthread_timedjoin_np(thread, NULL, &timeout);
+}
+
+TEST(wake_any)
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
+	/* test waking the semaphore */
+
+	wait_args.timeout = get_abs_timeout(1000);
+	wait_args.objs = (uintptr_t)objs;
+	wait_args.count = 2;
+	wait_args.owner = 456;
+	wait_args.index = 0xdeadbeef;
+	thread_args.fd = fd;
+	thread_args.args = &wait_args;
+	thread_args.request = NTSYNC_IOC_WAIT_ANY;
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
+	check_sem_state(sem_args.sem, 0, 3);
+
+	ret = wait_for_thread(thread, 100);
+	EXPECT_EQ(0, ret);
+	EXPECT_EQ(0, thread_args.ret);
+	EXPECT_EQ(0, wait_args.index);
+
+	/* test waking the mutex */
+
+	/* first grab it again for owner 123 */
+	ret = wait_any(fd, 1, &mutex_args.mutex, 123, &index);
+	EXPECT_EQ(0, ret);
+	EXPECT_EQ(0, index);
+
+	wait_args.timeout = get_abs_timeout(1000);
+	wait_args.owner = 456;
+	ret = pthread_create(&thread, NULL, wait_thread, &thread_args);
+	EXPECT_EQ(0, ret);
+
+	ret = wait_for_thread(thread, 100);
+	EXPECT_EQ(ETIMEDOUT, ret);
+
+	ret = unlock_mutex(mutex_args.mutex, 123, &count);
+	EXPECT_EQ(0, ret);
+	EXPECT_EQ(2, count);
+
+	ret = pthread_tryjoin_np(thread, NULL);
+	EXPECT_EQ(EBUSY, ret);
+
+	ret = unlock_mutex(mutex_args.mutex, 123, &count);
+	EXPECT_EQ(0, ret);
+	EXPECT_EQ(1, mutex_args.count);
+	check_mutex_state(mutex_args.mutex, 1, 456);
+
+	ret = wait_for_thread(thread, 100);
+	EXPECT_EQ(0, ret);
+	EXPECT_EQ(0, thread_args.ret);
+	EXPECT_EQ(1, wait_args.index);
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


