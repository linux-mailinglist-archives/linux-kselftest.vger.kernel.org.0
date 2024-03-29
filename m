Return-Path: <linux-kselftest+bounces-6795-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DDEBE890F2F
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Mar 2024 01:23:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 576A61F2360A
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Mar 2024 00:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1694A3F;
	Fri, 29 Mar 2024 00:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b="YL4nDdWV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.codeweavers.com (mail.codeweavers.com [4.36.192.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AE54101E2;
	Fri, 29 Mar 2024 00:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.36.192.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711671811; cv=none; b=C4cBauBqtrg7wjiHiuih7wNDTFo8qgKTA4T9LtZrlJAHJPJs0SZZqtcEg+K6BfBuNDnd//Z7BFFNM9kpFtvj3nygcWSjMoDjAUHGR/SDKCBQZWso0wBp10G/4qFFIFu9YAyOA2WHXWyLkkuyaBNbAlhQOS3iN/fc2//c+1HVJpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711671811; c=relaxed/simple;
	bh=ndUmoE2NV9+WeOkOEqF67OKbQbe/bdhyixSY54pcM0Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pk5JFY+IiwGcpoebHoQrTTvF9fIWfSp+0bF/Wzkr5hjeHk6v66I6SuFigQ+SlH3Bex4AEgC6lT8fcGeD5oPWx9PolA4f4ppjMsYytTWcSK7gv7ltsU5qbg0bzVFXtPrRsD1WPudbLttfQ+W8RBfq6CNeQAKoyqtF3+Wnk+iaZHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com; spf=pass smtp.mailfrom=codeweavers.com; dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b=YL4nDdWV; arc=none smtp.client-ip=4.36.192.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeweavers.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codeweavers.com; s=s1; h=Message-ID:Date:Subject:Cc:To:From:Sender;
	bh=VqcveN9RvbaElZOWRtg2p1KLPGz7XiKBHU5wR2tZ85M=; b=YL4nDdWVjScSKzOB46wWxtffXh
	fBY5+WIPr0O7rnRt/Myx2ZoG+k5Rz1pfJllvFLvFFORYSuhNAuUAuMK9V+6gjBEcOA0XeB+ElJF2t
	ipCrdqHz4HJO4TPiZt5eBcgzlMZvl6SHQHdIMaejptqTe8VzLOhv3HSErIm+9eyuPRkUSaDfNsEdl
	sksp0MNagaRjy6beqx7eL20uWrZPtQ/uinv+MYhvNMfOdxAsHivjQ5F5g3h/OIu9IwngDvVhCCle4
	1N/EV+Z7YnkBcdcLCRIyy4BQDpvzjJQyr6aXyu1Xag2DTBKO4HlTPzyM0OIqzRmMgjipvpc7pvj7F
	g/rP7PgQ==;
Received: from cw137ip160.mn.codeweavers.com ([10.69.137.160] helo=camazotz.mn.codeweavers.com)
	by mail.codeweavers.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <zfigura@codeweavers.com>)
	id 1rpzlQ-000iik-35;
	Thu, 28 Mar 2024 19:06:33 -0500
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
Subject: [PATCH v3 18/30] selftests: ntsync: Add some tests for mutex state.
Date: Thu, 28 Mar 2024 19:06:09 -0500
Message-ID: <20240329000621.148791-19-zfigura@codeweavers.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329000621.148791-1-zfigura@codeweavers.com>
References: <20240329000621.148791-1-zfigura@codeweavers.com>
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


