Return-Path: <linux-kselftest+bounces-4964-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 01DE185AECE
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Feb 2024 23:40:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A74C61F23C5A
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Feb 2024 22:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5341A5823B;
	Mon, 19 Feb 2024 22:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b="O3EeQI8w"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.codeweavers.com (mail.codeweavers.com [4.36.192.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E1AA56758;
	Mon, 19 Feb 2024 22:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.36.192.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708382381; cv=none; b=hmuNGuB8IUyavKRVuCqNtx9kslYBes1V6hvkz1zmci+cRIoHddG36DMnGq5gqaZYVaLXyCuwwoiVZ37vT/oCD+QV2ADBljRuVhTURPBqLT0eTBYtREky5XVF2GCm/DRsItawL90Ek5MfdEY7/GgrqlziuIBszxyuBsNNP56GyxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708382381; c=relaxed/simple;
	bh=c+6U+ZbefTz0YtyUBcA/usnu8kiO48W/n5csRaPODMw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cz6aH9RT9+/bny3NEEWEt4fCxibnZk1IUZE+srG7wSHkjWKjkzRya5oNz+r2canbnKfXwatFKn0Rf+QsE7DJwL2KYcJp1hW+YEjIfYWYtXzIBvTRDcbyYOExUup+8iHBZ0qq77dbax5v4x7lF7yiZXEtG3g9VSbBZYX/mUFVPso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com; spf=pass smtp.mailfrom=codeweavers.com; dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b=O3EeQI8w; arc=none smtp.client-ip=4.36.192.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeweavers.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codeweavers.com; s=s1; h=Message-ID:Date:Subject:Cc:To:From:Sender;
	bh=S+Bo60slTZYs+MASNA28omTt/46YdAeLaNdjfMjNW6Q=; b=O3EeQI8wiuddhqG6Vul1NSfZp6
	L7hxg2+pePmaEcdm8zwezsLQGfLPNnTBBH9Vxap8MEPnFr6Ihm4g1VARjTBWRwpfXNmx/oec3CKXM
	bz2DwGCWDHvPnMSBzWQV5ZvSpDtqNpXgUT1dCCH2/eSleyw0t5MI4Ej53/nTQeExqs06hde+ITYa5
	hMykxyr0CEzzs+y4nLHA/mN2XMpKbY+TZX/nRspuKRn0fEBRlUjI9DW1yIqKi3dUu7/1uT2dyQFxh
	rCHkXOzfIN7AxT3HG8zXJg7XMsJIXohEM8jtixCfX19yT8cj3hFUvUUzuM/qUqwfw0+nQFX5xK6DW
	eAtchFlg==;
Received: from cw137ip160.mn.codeweavers.com ([10.69.137.160] helo=camazotz.mn.codeweavers.com)
	by mail.codeweavers.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <zfigura@codeweavers.com>)
	id 1rcCIQ-0037Oz-1M;
	Mon, 19 Feb 2024 16:39:34 -0600
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
Subject: [PATCH v2 21/31] selftests: ntsync: Add some tests for NTSYNC_IOC_WAIT_ALL.
Date: Mon, 19 Feb 2024 16:38:23 -0600
Message-ID: <20240219223833.95710-22-zfigura@codeweavers.com>
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

Test basic synchronous functionality of NTSYNC_IOC_WAIT_ALL, and when objects
are considered simultaneously signaled.

Signed-off-by: Elizabeth Figura <zfigura@codeweavers.com>
---
 .../testing/selftests/drivers/ntsync/ntsync.c | 99 ++++++++++++++++++-
 1 file changed, 97 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/drivers/ntsync/ntsync.c b/tools/testing/selftests/drivers/ntsync/ntsync.c
index 40ad8cbd3138..c0f372167557 100644
--- a/tools/testing/selftests/drivers/ntsync/ntsync.c
+++ b/tools/testing/selftests/drivers/ntsync/ntsync.c
@@ -73,7 +73,8 @@ static int unlock_mutex(int mutex, __u32 owner, __u32 *count)
 	return ret;
 }
 
-static int wait_any(int fd, __u32 count, const int *objs, __u32 owner, __u32 *index)
+static int wait_objs(int fd, unsigned long request, __u32 count,
+		     const int *objs, __u32 owner, __u32 *index)
 {
 	struct ntsync_wait_args args = {0};
 	struct timespec timeout;
@@ -86,11 +87,21 @@ static int wait_any(int fd, __u32 count, const int *objs, __u32 owner, __u32 *in
 	args.objs = (uintptr_t)objs;
 	args.owner = owner;
 	args.index = 0xdeadbeef;
-	ret = ioctl(fd, NTSYNC_IOC_WAIT_ANY, &args);
+	ret = ioctl(fd, request, &args);
 	*index = args.index;
 	return ret;
 }
 
+static int wait_any(int fd, __u32 count, const int *objs, __u32 owner, __u32 *index)
+{
+	return wait_objs(fd, NTSYNC_IOC_WAIT_ANY, count, objs, owner, index);
+}
+
+static int wait_all(int fd, __u32 count, const int *objs, __u32 owner, __u32 *index)
+{
+	return wait_objs(fd, NTSYNC_IOC_WAIT_ALL, count, objs, owner, index);
+}
+
 TEST(semaphore_state)
 {
 	struct ntsync_sem_args sem_args;
@@ -461,4 +472,88 @@ TEST(test_wait_any)
 	close(fd);
 }
 
+TEST(test_wait_all)
+{
+	struct ntsync_mutex_args mutex_args = {0};
+	struct ntsync_sem_args sem_args = {0};
+	__u32 owner, index, count;
+	int objs[2], fd, ret;
+
+	fd = open("/dev/ntsync", O_CLOEXEC | O_RDONLY);
+	ASSERT_LE(0, fd);
+
+	sem_args.count = 2;
+	sem_args.max = 3;
+	sem_args.sem = 0xdeadbeef;
+	ret = ioctl(fd, NTSYNC_IOC_CREATE_SEM, &sem_args);
+	EXPECT_EQ(0, ret);
+	EXPECT_NE(0xdeadbeef, sem_args.sem);
+
+	mutex_args.owner = 0;
+	mutex_args.count = 0;
+	mutex_args.mutex = 0xdeadbeef;
+	ret = ioctl(fd, NTSYNC_IOC_CREATE_MUTEX, &mutex_args);
+	EXPECT_EQ(0, ret);
+	EXPECT_NE(0xdeadbeef, mutex_args.mutex);
+
+	objs[0] = sem_args.sem;
+	objs[1] = mutex_args.mutex;
+
+	ret = wait_all(fd, 2, objs, 123, &index);
+	EXPECT_EQ(0, ret);
+	EXPECT_EQ(0, index);
+	check_sem_state(sem_args.sem, 1, 3);
+	check_mutex_state(mutex_args.mutex, 1, 123);
+
+	ret = wait_all(fd, 2, objs, 456, &index);
+	EXPECT_EQ(-1, ret);
+	EXPECT_EQ(ETIMEDOUT, errno);
+	check_sem_state(sem_args.sem, 1, 3);
+	check_mutex_state(mutex_args.mutex, 1, 123);
+
+	ret = wait_all(fd, 2, objs, 123, &index);
+	EXPECT_EQ(0, ret);
+	EXPECT_EQ(0, index);
+	check_sem_state(sem_args.sem, 0, 3);
+	check_mutex_state(mutex_args.mutex, 2, 123);
+
+	ret = wait_all(fd, 2, objs, 123, &index);
+	EXPECT_EQ(-1, ret);
+	EXPECT_EQ(ETIMEDOUT, errno);
+	check_sem_state(sem_args.sem, 0, 3);
+	check_mutex_state(mutex_args.mutex, 2, 123);
+
+	count = 3;
+	ret = post_sem(sem_args.sem, &count);
+	EXPECT_EQ(0, ret);
+	EXPECT_EQ(0, count);
+
+	ret = wait_all(fd, 2, objs, 123, &index);
+	EXPECT_EQ(0, ret);
+	EXPECT_EQ(0, index);
+	check_sem_state(sem_args.sem, 2, 3);
+	check_mutex_state(mutex_args.mutex, 3, 123);
+
+	owner = 123;
+	ret = ioctl(mutex_args.mutex, NTSYNC_IOC_MUTEX_KILL, &owner);
+	EXPECT_EQ(0, ret);
+
+	ret = wait_all(fd, 2, objs, 123, &index);
+	EXPECT_EQ(-1, ret);
+	EXPECT_EQ(EOWNERDEAD, errno);
+	check_sem_state(sem_args.sem, 1, 3);
+	check_mutex_state(mutex_args.mutex, 1, 123);
+
+	/* test waiting on the same object twice */
+	objs[0] = objs[1] = sem_args.sem;
+	ret = wait_all(fd, 2, objs, 123, &index);
+	EXPECT_EQ(-1, ret);
+	EXPECT_EQ(EINVAL, errno);
+
+	close(sem_args.sem);
+	close(mutex_args.mutex);
+
+	close(fd);
+}
+
 TEST_HARNESS_MAIN
-- 
2.43.0


