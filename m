Return-Path: <linux-kselftest+bounces-23356-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ACC2F9F1660
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Dec 2024 20:40:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A840816C3CB
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Dec 2024 19:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E4CC1F75A0;
	Fri, 13 Dec 2024 19:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b="WyoJxUfF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.codeweavers.com (mail.codeweavers.com [4.36.192.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 299B81F7084;
	Fri, 13 Dec 2024 19:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.36.192.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734118557; cv=none; b=C+Jm78vHKF/Aqd7lm6Ik1odfKKDLmGh/lmg65D8PTPgrVxWW0p5vO+5FgvvDA6bq7BQ1VwWmikPahSBlHCD4+rdPQhIji4hmk9rHdmezRtRJNpwEGJnYaEy+AlqOXaW4JpfV+D5USXunSGrnvYFzssBvzrNSYQtL4NJCZ9N7eWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734118557; c=relaxed/simple;
	bh=gSHc45DGNYG1E3iLOYO3GXFbuenIeiEb8xg9XIOmqC0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HyRT3Rm8ObZC/EQZtAShrtXKSmqc7ddqFL25XlDwFGNQL4LpKnit/FB3Ik9pY1/nD8t7O7kqRcVMuWrGTcTmbZfJA/r4ng0WF/Quhk9YIk+h0AEjL6MU32UXCGnPa/fQHy8EeEAKFS6tobaB1yZhsCo9rWOSa/XHKFbnj3nKUtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com; spf=pass smtp.mailfrom=codeweavers.com; dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b=WyoJxUfF; arc=none smtp.client-ip=4.36.192.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeweavers.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codeweavers.com; s=s1; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=yfMVapCbapaQ/YU+QYgXZNRHixjKjPdGAIR4ZIs/GHU=; b=WyoJxUfFxWrrq01CYxTUjbTwyb
	VhOEAdCtWe95JsakGh6pJ9EpuoqipYIeBLzGk3I1GnCbKC9lrM/B9XxQWLR3TuveAlVapZjhuq3os
	6AIE3BNU5YrvBoGAYAt2d1a0KuHj9z+KOjr7sBObqP4QTvOqTE01jg+bm8eXgHBQYYjonY7Kuk+gg
	2s7YZYVn3bwDM5yLtEEefl8G0/F7d6IAKjc6sd7GLRW51NcnrANACkZma0XrL0K2HkA+NX0Goj3gn
	dm5Y9rqrPnvhIinG6jkwidruHco6ebP1zi+L1pxOwNJO6xTj9vm/COSF0HyvHO5WZjZhU1fB+XGi/
	3rlsOiCw==;
Received: from cw137ip160.mn.codeweavers.com ([10.69.137.160] helo=camazotz.mn.codeweavers.com)
	by mail.codeweavers.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <zfigura@codeweavers.com>)
	id 1tMBS3-00ASsZ-1H;
	Fri, 13 Dec 2024 13:35:51 -0600
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
Subject: [PATCH v7 20/30] selftests: ntsync: Add some tests for wakeup signaling with WINESYNC_IOC_WAIT_ANY.
Date: Fri, 13 Dec 2024 13:35:01 -0600
Message-ID: <20241213193511.457338-21-zfigura@codeweavers.com>
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

Test contended "wait-for-any" waits, to make sure that scheduling and wakeup
logic works correctly.

Signed-off-by: Elizabeth Figura <zfigura@codeweavers.com>
---
 .../testing/selftests/drivers/ntsync/ntsync.c | 143 ++++++++++++++++++
 1 file changed, 143 insertions(+)

diff --git a/tools/testing/selftests/drivers/ntsync/ntsync.c b/tools/testing/selftests/drivers/ntsync/ntsync.c
index aba11eaf9a7c..ad3f031c0b92 100644
--- a/tools/testing/selftests/drivers/ntsync/ntsync.c
+++ b/tools/testing/selftests/drivers/ntsync/ntsync.c
@@ -532,4 +532,147 @@ TEST(test_wait_all)
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
+	objs[0] = ioctl(fd, NTSYNC_IOC_CREATE_SEM, &sem_args);
+	EXPECT_LE(0, objs[0]);
+
+	mutex_args.owner = 123;
+	mutex_args.count = 1;
+	objs[1] = ioctl(fd, NTSYNC_IOC_CREATE_MUTEX, &mutex_args);
+	EXPECT_LE(0, objs[1]);
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
+	ret = release_sem(objs[0], &count);
+	EXPECT_EQ(0, ret);
+	EXPECT_EQ(0, count);
+	check_sem_state(objs[0], 0, 3);
+
+	ret = wait_for_thread(thread, 100);
+	EXPECT_EQ(0, ret);
+	EXPECT_EQ(0, thread_args.ret);
+	EXPECT_EQ(0, wait_args.index);
+
+	/* test waking the mutex */
+
+	/* first grab it again for owner 123 */
+	ret = wait_any(fd, 1, &objs[1], 123, &index);
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
+	ret = unlock_mutex(objs[1], 123, &count);
+	EXPECT_EQ(0, ret);
+	EXPECT_EQ(2, count);
+
+	ret = pthread_tryjoin_np(thread, NULL);
+	EXPECT_EQ(EBUSY, ret);
+
+	ret = unlock_mutex(objs[1], 123, &count);
+	EXPECT_EQ(0, ret);
+	EXPECT_EQ(1, mutex_args.count);
+	check_mutex_state(objs[1], 1, 456);
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
+	close(objs[0]);
+	close(objs[1]);
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


