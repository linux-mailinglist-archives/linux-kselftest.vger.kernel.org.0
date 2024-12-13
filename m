Return-Path: <linux-kselftest+bounces-23354-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC82C9F1656
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Dec 2024 20:39:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77A11286321
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Dec 2024 19:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B675F1F709C;
	Fri, 13 Dec 2024 19:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b="EBaJtz9a"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.codeweavers.com (mail.codeweavers.com [4.36.192.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D22B1F63D6;
	Fri, 13 Dec 2024 19:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.36.192.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734118555; cv=none; b=qzDzWiSrRBmGzuhz1XjhchP2JLhMcp7j4CxDwHd4A8fmZ+xcwhM8UlqNhJiFQb2Btp74gsioFGEo1RgGwWVTwNydLhDgGKroXomR7wKSdjTr8iAd4GYE0gKjZw+dXLjKilmEHflO8nhZLAoUc73LRQrvRl0UzHpSCmTPVJYxAok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734118555; c=relaxed/simple;
	bh=YOh3pK7aDZy4dMSXu4A6GaEiR9v/kVuGrzsWz8QURgo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DD6ZyWMjoy7yWjlY6mUE0fbIHTNMhBOUQtLLjDC5dSzaR2+j0ise74OPwnuh1GBhehaygAt3laRCynFTUheVLja33lZULfo2rKk5Djoz5cCESXQOid9iCLxppwakAa2T6yQ7FByAXw4YVAUOTiCU2MaS75W0nP4L5V8HBjilfvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com; spf=pass smtp.mailfrom=codeweavers.com; dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b=EBaJtz9a; arc=none smtp.client-ip=4.36.192.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeweavers.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codeweavers.com; s=s1; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=zcWUOARv4G9kSasDBJAhu4hJnbXq2u4+Jz0BS9kPs0g=; b=EBaJtz9ayp4sJgk4jQ93wHljeX
	Os5x7IVkN9fss2ntYpdwjqyAKp5FvYOlfbJduNuaiKHRjvG8v+DvWUTfyIHRwAMllFVX31TGmBLRN
	CuxyFDNxd7TFfnj3F30oDLgHF6EDeb1m9UR0K3vX5QSflFkgbn+ETjSkgHjdk6PmMIXjlOg5gUHL+
	SCn73C5CXtNCoP2ZtmYTJBj0hrKinwLjXge93y1AtjWjyBD8WFOiyDg8/gMV7NtoE5F30T3dGASnC
	W9071xpwVPSJz77YRbHldstn6WX/RZAQlWQ2AAMiZkP8IQVixqET57wdJDbVrWas1itWwA/84fLVb
	ZeRdZ0yA==;
Received: from cw137ip160.mn.codeweavers.com ([10.69.137.160] helo=camazotz.mn.codeweavers.com)
	by mail.codeweavers.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <zfigura@codeweavers.com>)
	id 1tMBS1-00ASsZ-2s;
	Fri, 13 Dec 2024 13:35:50 -0600
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
Subject: [PATCH v7 18/30] selftests: ntsync: Add some tests for NTSYNC_IOC_WAIT_ANY.
Date: Fri, 13 Dec 2024 13:34:59 -0600
Message-ID: <20241213193511.457338-19-zfigura@codeweavers.com>
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

Test basic synchronous functionality of NTSYNC_IOC_WAIT_ANY, when objects are
considered signaled or not signaled, and how they are affected by a successful
wait.

Signed-off-by: Elizabeth Figura <zfigura@codeweavers.com>
---
 .../testing/selftests/drivers/ntsync/ntsync.c | 114 ++++++++++++++++++
 1 file changed, 114 insertions(+)

diff --git a/tools/testing/selftests/drivers/ntsync/ntsync.c b/tools/testing/selftests/drivers/ntsync/ntsync.c
index 4db65490b6a1..9781a74253ee 100644
--- a/tools/testing/selftests/drivers/ntsync/ntsync.c
+++ b/tools/testing/selftests/drivers/ntsync/ntsync.c
@@ -329,4 +329,118 @@ TEST(mutex_state)
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
+	objs[0] = ioctl(fd, NTSYNC_IOC_CREATE_SEM, &sem_args);
+	EXPECT_LE(0, objs[0]);
+
+	mutex_args.owner = 0;
+	mutex_args.count = 0;
+	objs[1] = ioctl(fd, NTSYNC_IOC_CREATE_MUTEX, &mutex_args);
+	EXPECT_LE(0, objs[1]);
+
+	ret = wait_any(fd, 2, objs, 123, &index);
+	EXPECT_EQ(0, ret);
+	EXPECT_EQ(0, index);
+	check_sem_state(objs[0], 1, 3);
+	check_mutex_state(objs[1], 0, 0);
+
+	ret = wait_any(fd, 2, objs, 123, &index);
+	EXPECT_EQ(0, ret);
+	EXPECT_EQ(0, index);
+	check_sem_state(objs[0], 0, 3);
+	check_mutex_state(objs[1], 0, 0);
+
+	ret = wait_any(fd, 2, objs, 123, &index);
+	EXPECT_EQ(0, ret);
+	EXPECT_EQ(1, index);
+	check_sem_state(objs[0], 0, 3);
+	check_mutex_state(objs[1], 1, 123);
+
+	count = 1;
+	ret = release_sem(objs[0], &count);
+	EXPECT_EQ(0, ret);
+	EXPECT_EQ(0, count);
+
+	ret = wait_any(fd, 2, objs, 123, &index);
+	EXPECT_EQ(0, ret);
+	EXPECT_EQ(0, index);
+	check_sem_state(objs[0], 0, 3);
+	check_mutex_state(objs[1], 1, 123);
+
+	ret = wait_any(fd, 2, objs, 123, &index);
+	EXPECT_EQ(0, ret);
+	EXPECT_EQ(1, index);
+	check_sem_state(objs[0], 0, 3);
+	check_mutex_state(objs[1], 2, 123);
+
+	ret = wait_any(fd, 2, objs, 456, &index);
+	EXPECT_EQ(-1, ret);
+	EXPECT_EQ(ETIMEDOUT, errno);
+
+	owner = 123;
+	ret = ioctl(objs[1], NTSYNC_IOC_MUTEX_KILL, &owner);
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
+	close(objs[1]);
+
+	/* test waiting on the same object twice */
+
+	count = 2;
+	ret = release_sem(objs[0], &count);
+	EXPECT_EQ(0, ret);
+	EXPECT_EQ(0, count);
+
+	objs[1] = objs[0];
+	ret = wait_any(fd, 2, objs, 456, &index);
+	EXPECT_EQ(0, ret);
+	EXPECT_EQ(0, index);
+	check_sem_state(objs[0], 1, 3);
+
+	ret = wait_any(fd, 0, NULL, 456, &index);
+	EXPECT_EQ(-1, ret);
+	EXPECT_EQ(ETIMEDOUT, errno);
+
+	for (i = 1; i < NTSYNC_MAX_WAIT_COUNT + 1; ++i)
+		objs[i] = objs[0];
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
+	close(objs[0]);
+
+	close(fd);
+}
+
 TEST_HARNESS_MAIN
-- 
2.45.2


