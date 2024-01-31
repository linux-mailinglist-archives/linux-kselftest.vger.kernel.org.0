Return-Path: <linux-kselftest+bounces-3792-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30E5C84334F
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jan 2024 03:16:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4801289D23
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jan 2024 02:16:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63224EEB7;
	Wed, 31 Jan 2024 02:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b="RBVsFPvj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.codeweavers.com (mail.codeweavers.com [4.36.192.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 969415C89;
	Wed, 31 Jan 2024 02:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.36.192.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706667367; cv=none; b=KjcYQH/ORyjEf4N1NGzA4nWd75oydARYyi98Cw66k81h6JrKJZHJu68XPfwb8B8jJlAU1pirenkvcm+rmZs3JzcArGDFe9XIQgmB0iucU05++1y1d8lvQNq7mtQaRBW66upVruzN88HMUiKuT90dd8s8xuSaDA5uDtd4t16JmOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706667367; c=relaxed/simple;
	bh=Kxq4U91L+cNlWSbgSblxx75X7Ad/unW7tV8FCOgmvDE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tLpDhv/AEzszk0ESzQRWfXmUBynmRZKKXd26ITLT6Oeao39GyWpjrhiOXJ4VFy4FQsjlXQd6k1fwlQVWiKUW527Sw7zHc35mmXmgZ+S7Q7ImK7tfYS6GqG4CN/LQNZb1T2pEcHe4xOC6V0QRGbSTqKZscmPiVSuC5PtPkjeKJ2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com; spf=pass smtp.mailfrom=codeweavers.com; dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b=RBVsFPvj; arc=none smtp.client-ip=4.36.192.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeweavers.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codeweavers.com; s=s1; h=Message-ID:Date:Subject:Cc:To:From:Sender;
	bh=sOzqgnLGIgtRKny4Ao2xmWC9bt9j+bFRdf4xOt6jSBg=; b=RBVsFPvjaFUGQWiZ5fE3H2QHuK
	QNMwZ+In0cCqZ8//4V7v/9dSRYePTgH2Cdy/H2H4f7rdQiCnUjqSkdXYfUX1cRpWcY2oIcP1tXGHh
	e8liJK0QCXtXjDYL0oTWWnt4ldy5y6XPFfCyAky9RfEU8ms/TK924zqAMzZVAW2tw4d3qeKGl5UwH
	j4eRKwNgHKipTPLusD9c8ME4WpxMjjecaJzSnoKvcSYzkPBdnlASvN5WwDIZxwPRWnGObqbUr1+rj
	M0lIYOiWAFGWh3tQlrGtFTH0FIFQlAtY3KDUFbZA31Lgby0AosPS0Xr30a0thzUnlgl4RdvxAOWLB
	E4tdhVVg==;
Received: from cw137ip160.mn.codeweavers.com ([10.69.137.160] helo=camazotz.mn.codeweavers.com)
	by mail.codeweavers.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <zfigura@codeweavers.com>)
	id 1rV08p-0038Kv-2k;
	Tue, 30 Jan 2024 20:15:55 -0600
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
Subject: [RFC PATCH v2 20/29] selftests: ntsync: Add some tests for NTSYNC_IOC_WAIT_ALL.
Date: Tue, 30 Jan 2024 20:13:47 -0600
Message-ID: <20240131021356.10322-21-zfigura@codeweavers.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240131021356.10322-1-zfigura@codeweavers.com>
References: <20240131021356.10322-1-zfigura@codeweavers.com>
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
index 13e7c9d7441e..77f1b7e42d76 100644
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
@@ -426,4 +437,88 @@ TEST(test_wait_any)
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


