Return-Path: <linux-kselftest+bounces-10398-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EAE6D8C964F
	for <lists+linux-kselftest@lfdr.de>; Sun, 19 May 2024 22:26:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A58D1C2085D
	for <lists+linux-kselftest@lfdr.de>; Sun, 19 May 2024 20:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB571757ED;
	Sun, 19 May 2024 20:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b="K2Oc/b7Z"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.codeweavers.com (mail.codeweavers.com [4.36.192.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C73866EB41;
	Sun, 19 May 2024 20:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.36.192.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716150318; cv=none; b=P6TJH4+ul0LPavf57Lm4oV4MNJtvp52dEXU894fgpIbDmTUTcvl2q+CDgj28+8WhghfUghCkwBIL2ufiQ4iToIb1utJf40+tpSS+fBcjp8KNlvuJ1LFVMLYmzTCZ4/9K/IvLuEGPl6pwR8oOjf30QQoa42NNzJigyiIVJyiON2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716150318; c=relaxed/simple;
	bh=ndUmoE2NV9+WeOkOEqF67OKbQbe/bdhyixSY54pcM0Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u6QiG7LMQ90jj+bQoXg0WgTji7z0XNv12hQ+Bt4TUlz/a2IkuZLSBHx1TTuiB0mvxXHNL2auZzW1CBdShJj7ftw6iuFbe1GaQkm/T756B8jzyJ5Fv5aA5shhtBxy6rgDwXury0jA0M1uZLVQiu2ihBdvq0AIMcXDqj5KpJXoJ3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com; spf=pass smtp.mailfrom=codeweavers.com; dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b=K2Oc/b7Z; arc=none smtp.client-ip=4.36.192.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeweavers.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codeweavers.com; s=s1; h=Message-ID:Date:Subject:Cc:To:From:Sender;
	bh=VqcveN9RvbaElZOWRtg2p1KLPGz7XiKBHU5wR2tZ85M=; b=K2Oc/b7ZdZ28WCF2udCpl3pNyJ
	ToZqMK7wBOJ/loNREmN7WQciFn0+tXUyZcHhKxK73M9kEO954j3L9bhZ0XCmFMnPoHIzFTAonS8fK
	bGv+DEhjWQB1zfrHpQdAlGyBvbZ9noOdKe3CvChIGZdJwlybM2zuhh3FHw01lWKNP0tOj+0pSbT1N
	N2gv3XkfiO2qsEtd8maB8W5xlxxjJHI6Gdhjl5kXaEsxWmBHDKAyuoF1k8M5++ggWRoJdJWF4ZnOZ
	l6xHWIo2WX8DgJW/x1zSMDfx/5IMN2tXeohX8jXRbCxz0WseT9H2zqvkOfwPzuGkrhnwC8kTewUj0
	6Lz4wN+w==;
Received: from cw137ip160.mn.codeweavers.com ([10.69.137.160] helo=camazotz.mn.codeweavers.com)
	by mail.codeweavers.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <zfigura@codeweavers.com>)
	id 1s8n5d-008wIn-2i;
	Sun, 19 May 2024 15:25:05 -0500
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
Subject: [PATCH v5 15/28] selftests: ntsync: Add some tests for mutex state.
Date: Sun, 19 May 2024 15:24:41 -0500
Message-ID: <20240519202454.1192826-16-zfigura@codeweavers.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240519202454.1192826-1-zfigura@codeweavers.com>
References: <20240519202454.1192826-1-zfigura@codeweavers.com>
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
index 1e145c6dfded..7cd0f40594fd 100644
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


