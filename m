Return-Path: <linux-kselftest+bounces-6793-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 31136890F28
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Mar 2024 01:23:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4FA81F21CDE
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Mar 2024 00:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89DC3EA4;
	Fri, 29 Mar 2024 00:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b="iDMNpsHr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.codeweavers.com (mail.codeweavers.com [4.36.192.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F41FEA3D;
	Fri, 29 Mar 2024 00:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.36.192.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711671806; cv=none; b=a/c2Y3iujVj5g7S79BpK+2dNo2+VophbWI0fX0Yid7Xr1xBnGMCZCgOIponYFhMYDyXneKJ7Ju1U0pcK5aev2JEJqiF2TV9/CPdbNL0XHbnMtCRdu6ZXKU8uxb6wbHwOm61+IoLFQSwfvl1p4QiXgU9KtPljtV3CgNH+Oq7Kw9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711671806; c=relaxed/simple;
	bh=8mBpNrep45/WQcWJkfana5grpHviuBbZ8c3NZYi9TZk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P19MWjZt0CjK8tp2w+9XBR8D6SAF8X/54Yr9ig+gT7983AlaIyWlm6XyDAJLtGxaL0Cql9LKcBb7VNx1DEMfVEZMYWhKZOjCJZOktt2wLzHo7lIrzVAzPVCcwWsbvZaRIfZ4hItB09zt7EBh5t6ppYtXhr3kvQvRuHLPGkR6ens=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com; spf=pass smtp.mailfrom=codeweavers.com; dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b=iDMNpsHr; arc=none smtp.client-ip=4.36.192.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeweavers.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codeweavers.com; s=s1; h=Message-ID:Date:Subject:Cc:To:From:Sender;
	bh=1lbo0bNxrPdMIVRoJ6+tExY5TotubsDpMSLovzCGBGc=; b=iDMNpsHrTae503SY22V807kzmT
	IInV8XfZKYRR1iidtoHEq70KS9YT0YQQrbhaRp++Bfm6QBhzo/pXz+hS/IdCgE8aehmIm//1oHbpO
	qzrxP1Jh+mSwjdWb5+1J1EilLpuKgqzx+qPwbWZrWflDNUr3zscwMtuPLhrvXiw5J8a6FUe+Xmzpj
	r95KzfjCMGDIV8xwBxmSM2DHha6xWZYdE4+ugAdvrL15uzOWHnAMODszgmnUGQ5Fd8R/wht/fymsq
	8qHg1gJEm6/IeB8hyTnbUExphdh/QQHFm6pE1EL1DM7wig/EsRGX1XSD4qubeBrTFqZaRplGt7IeK
	Us1MrLVA==;
Received: from cw137ip160.mn.codeweavers.com ([10.69.137.160] helo=camazotz.mn.codeweavers.com)
	by mail.codeweavers.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <zfigura@codeweavers.com>)
	id 1rpzlR-000iik-1p;
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
Subject: [PATCH v3 19/30] selftests: ntsync: Add some tests for NTSYNC_IOC_WAIT_ANY.
Date: Thu, 28 Mar 2024 19:06:10 -0500
Message-ID: <20240329000621.148791-20-zfigura@codeweavers.com>
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

Test basic synchronous functionality of NTSYNC_IOC_WAIT_ANY, when objects are
considered signaled or not signaled, and how they are affected by a successful
wait.

Signed-off-by: Elizabeth Figura <zfigura@codeweavers.com>
---
 .../testing/selftests/drivers/ntsync/ntsync.c | 119 ++++++++++++++++++
 1 file changed, 119 insertions(+)

diff --git a/tools/testing/selftests/drivers/ntsync/ntsync.c b/tools/testing/selftests/drivers/ntsync/ntsync.c
index 7cd0f40594fd..40ad8cbd3138 100644
--- a/tools/testing/selftests/drivers/ntsync/ntsync.c
+++ b/tools/testing/selftests/drivers/ntsync/ntsync.c
@@ -342,4 +342,123 @@ TEST(mutex_state)
 	close(fd);
 }
 
+TEST(test_wait_any)
+{
+	int objs[NTSYNC_MAX_WAIT_COUNT + 1], fd, ret;
+	struct ntsync_mutex_args mutex_args = {0};
+	struct ntsync_sem_args sem_args = {0};
+	__u32 owner, index, count, i;
+	struct timespec timeout;
+
+	clock_gettime(CLOCK_MONOTONIC, &timeout);
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
+	ret = wait_any(fd, 2, objs, 123, &index);
+	EXPECT_EQ(0, ret);
+	EXPECT_EQ(0, index);
+	check_sem_state(sem_args.sem, 1, 3);
+	check_mutex_state(mutex_args.mutex, 0, 0);
+
+	ret = wait_any(fd, 2, objs, 123, &index);
+	EXPECT_EQ(0, ret);
+	EXPECT_EQ(0, index);
+	check_sem_state(sem_args.sem, 0, 3);
+	check_mutex_state(mutex_args.mutex, 0, 0);
+
+	ret = wait_any(fd, 2, objs, 123, &index);
+	EXPECT_EQ(0, ret);
+	EXPECT_EQ(1, index);
+	check_sem_state(sem_args.sem, 0, 3);
+	check_mutex_state(mutex_args.mutex, 1, 123);
+
+	count = 1;
+	ret = post_sem(sem_args.sem, &count);
+	EXPECT_EQ(0, ret);
+	EXPECT_EQ(0, count);
+
+	ret = wait_any(fd, 2, objs, 123, &index);
+	EXPECT_EQ(0, ret);
+	EXPECT_EQ(0, index);
+	check_sem_state(sem_args.sem, 0, 3);
+	check_mutex_state(mutex_args.mutex, 1, 123);
+
+	ret = wait_any(fd, 2, objs, 123, &index);
+	EXPECT_EQ(0, ret);
+	EXPECT_EQ(1, index);
+	check_sem_state(sem_args.sem, 0, 3);
+	check_mutex_state(mutex_args.mutex, 2, 123);
+
+	ret = wait_any(fd, 2, objs, 456, &index);
+	EXPECT_EQ(-1, ret);
+	EXPECT_EQ(ETIMEDOUT, errno);
+
+	owner = 123;
+	ret = ioctl(mutex_args.mutex, NTSYNC_IOC_MUTEX_KILL, &owner);
+	EXPECT_EQ(0, ret);
+
+	ret = wait_any(fd, 2, objs, 456, &index);
+	EXPECT_EQ(-1, ret);
+	EXPECT_EQ(EOWNERDEAD, errno);
+	EXPECT_EQ(1, index);
+
+	ret = wait_any(fd, 2, objs, 456, &index);
+	EXPECT_EQ(0, ret);
+	EXPECT_EQ(1, index);
+
+	/* test waiting on the same object twice */
+	count = 2;
+	ret = post_sem(sem_args.sem, &count);
+	EXPECT_EQ(0, ret);
+	EXPECT_EQ(0, count);
+
+	objs[0] = objs[1] = sem_args.sem;
+	ret = wait_any(fd, 2, objs, 456, &index);
+	EXPECT_EQ(0, ret);
+	EXPECT_EQ(0, index);
+	check_sem_state(sem_args.sem, 1, 3);
+
+	ret = wait_any(fd, 0, NULL, 456, &index);
+	EXPECT_EQ(-1, ret);
+	EXPECT_EQ(ETIMEDOUT, errno);
+
+	for (i = 0; i < NTSYNC_MAX_WAIT_COUNT + 1; ++i)
+		objs[i] = sem_args.sem;
+
+	ret = wait_any(fd, NTSYNC_MAX_WAIT_COUNT, objs, 123, &index);
+	EXPECT_EQ(0, ret);
+	EXPECT_EQ(0, index);
+
+	ret = wait_any(fd, NTSYNC_MAX_WAIT_COUNT + 1, objs, 123, &index);
+	EXPECT_EQ(-1, ret);
+	EXPECT_EQ(EINVAL, errno);
+
+	ret = wait_any(fd, -1, objs, 123, &index);
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


