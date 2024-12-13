Return-Path: <linux-kselftest+bounces-23355-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DF3A9F165F
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Dec 2024 20:40:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52F7D1884B6E
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Dec 2024 19:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC1601F7575;
	Fri, 13 Dec 2024 19:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b="n2fF+qx8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.codeweavers.com (mail.codeweavers.com [4.36.192.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C6D21F6699;
	Fri, 13 Dec 2024 19:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.36.192.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734118556; cv=none; b=dnVduFEqnZ3Z4Yyf7YGWWiZfCMB7rvxN3I2WSSsXgLGif2mBkx5gRKWEUogdDzcvmSiJFy9MIg0VDYc4UpGKLl0MrHXKljtc8NNQCVviS6nJA9KTBG71im4Vfxm/UKrItLlSGemGkW9horx6T2cpUCcut1a8O4/7bockWmRH8XU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734118556; c=relaxed/simple;
	bh=n7yww3p8EqREsKud2mKk4o8VfwSG0c63bsf+LJz27JY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=abHzdyHrb3AJmDzUd1mSgSdtlkXjPDQdxxRAiKPMw1MhafBDVGLX/ix30kKSjsxomNtg1wg2wt20140ATRUOvOMrPHQWkbthel/wyisZNmHBDPd516o4qv29bGY91kCRF23siOippMcu/HUEwir5n2jaXw0wL4qP4qMNnkj3ETg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com; spf=pass smtp.mailfrom=codeweavers.com; dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b=n2fF+qx8; arc=none smtp.client-ip=4.36.192.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeweavers.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codeweavers.com; s=s1; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=V73zxW3PdeX99bTlrhARp88DE1v+0t6dkPrPdn+wL3c=; b=n2fF+qx841lEC1aBqK1OMIU3aD
	FSGl3yc0eA3QWvZPlhcmqdPvH/GU64acYyc6/WICZ3dbVtjfbHLln77EBEVu/4MkSNyazbg58ZNu3
	BpzDuLKJvhz6Bnzef6Y1Ov79rId2cUkZL1b6blKa5ooXD9zqnnaNYtaQGciVe1V/caY8GIJssmc2l
	JFZek89zVZGRoln+UxWTWENxTVnR2+FFCLSnuJ2px/0FXxx+37Vk72RopAhK4y5Ytfd38If7nQPWf
	jLcQ4sfnH20X1NnKsK22+L9WbjS7iiZjQ9+ZAjbcNDh2rzo/tryDBg9yr1B+A0T/yxcBvFVDAnjTi
	eNg1j5Tg==;
Received: from cw137ip160.mn.codeweavers.com ([10.69.137.160] helo=camazotz.mn.codeweavers.com)
	by mail.codeweavers.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <zfigura@codeweavers.com>)
	id 1tMBS2-00ASsZ-2B;
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
Subject: [PATCH v7 19/30] selftests: ntsync: Add some tests for NTSYNC_IOC_WAIT_ALL.
Date: Fri, 13 Dec 2024 13:35:00 -0600
Message-ID: <20241213193511.457338-20-zfigura@codeweavers.com>
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

Test basic synchronous functionality of NTSYNC_IOC_WAIT_ALL, and when objects
are considered simultaneously signaled.

Signed-off-by: Elizabeth Figura <zfigura@codeweavers.com>
---
 .../testing/selftests/drivers/ntsync/ntsync.c | 93 ++++++++++++++++++-
 1 file changed, 91 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/drivers/ntsync/ntsync.c b/tools/testing/selftests/drivers/ntsync/ntsync.c
index 9781a74253ee..aba11eaf9a7c 100644
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
@@ -443,4 +454,82 @@ TEST(test_wait_any)
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
+	objs[0] = ioctl(fd, NTSYNC_IOC_CREATE_SEM, &sem_args);
+	EXPECT_LE(0, objs[0]);
+
+	mutex_args.owner = 0;
+	mutex_args.count = 0;
+	objs[1] = ioctl(fd, NTSYNC_IOC_CREATE_MUTEX, &mutex_args);
+	EXPECT_LE(0, objs[1]);
+
+	ret = wait_all(fd, 2, objs, 123, &index);
+	EXPECT_EQ(0, ret);
+	EXPECT_EQ(0, index);
+	check_sem_state(objs[0], 1, 3);
+	check_mutex_state(objs[1], 1, 123);
+
+	ret = wait_all(fd, 2, objs, 456, &index);
+	EXPECT_EQ(-1, ret);
+	EXPECT_EQ(ETIMEDOUT, errno);
+	check_sem_state(objs[0], 1, 3);
+	check_mutex_state(objs[1], 1, 123);
+
+	ret = wait_all(fd, 2, objs, 123, &index);
+	EXPECT_EQ(0, ret);
+	EXPECT_EQ(0, index);
+	check_sem_state(objs[0], 0, 3);
+	check_mutex_state(objs[1], 2, 123);
+
+	ret = wait_all(fd, 2, objs, 123, &index);
+	EXPECT_EQ(-1, ret);
+	EXPECT_EQ(ETIMEDOUT, errno);
+	check_sem_state(objs[0], 0, 3);
+	check_mutex_state(objs[1], 2, 123);
+
+	count = 3;
+	ret = release_sem(objs[0], &count);
+	EXPECT_EQ(0, ret);
+	EXPECT_EQ(0, count);
+
+	ret = wait_all(fd, 2, objs, 123, &index);
+	EXPECT_EQ(0, ret);
+	EXPECT_EQ(0, index);
+	check_sem_state(objs[0], 2, 3);
+	check_mutex_state(objs[1], 3, 123);
+
+	owner = 123;
+	ret = ioctl(objs[1], NTSYNC_IOC_MUTEX_KILL, &owner);
+	EXPECT_EQ(0, ret);
+
+	ret = wait_all(fd, 2, objs, 123, &index);
+	EXPECT_EQ(-1, ret);
+	EXPECT_EQ(EOWNERDEAD, errno);
+	check_sem_state(objs[0], 1, 3);
+	check_mutex_state(objs[1], 1, 123);
+
+	close(objs[1]);
+
+	/* test waiting on the same object twice */
+	objs[1] = objs[0];
+	ret = wait_all(fd, 2, objs, 123, &index);
+	EXPECT_EQ(-1, ret);
+	EXPECT_EQ(EINVAL, errno);
+
+	close(objs[0]);
+
+	close(fd);
+}
+
 TEST_HARNESS_MAIN
-- 
2.45.2


