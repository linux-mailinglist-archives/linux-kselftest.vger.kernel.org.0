Return-Path: <linux-kselftest+bounces-6807-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36ABB890F63
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Mar 2024 01:27:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9499328BE4C
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Mar 2024 00:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37DBA11721;
	Fri, 29 Mar 2024 00:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b="TV/T9p8V"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.codeweavers.com (mail.codeweavers.com [4.36.192.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8EAE3A1CC;
	Fri, 29 Mar 2024 00:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.36.192.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711671843; cv=none; b=SavOtmVQ4RnrAcQU5vS85QB3BTVtKsPCrUdyskljy8XF4BrmzwwaaraIIN43Gzx7OaKE5En6NAttgu4vDasQL4xQvETtSA3/6xQn7FPRrrgNn5ytN9fIIfUwCuce2uFUITp7sJdtcgsgcoMVAYHrpxulJk0sckFSB+ZA2dr9z+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711671843; c=relaxed/simple;
	bh=BZw7zShBTT5PfD4hawcGoNVQjDPKfhLnloDinunlfUc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O7/sKL7+dE9zKJY/orWAZhxmWQ1Ep/b5f1aWO/NimKRK2f4Z4A7EKhDzsLpYKdMnmhoBnnD00kDzL/xw/t5N6qMYh1mhrtyrxHVg14kcK6ykBnX2gR9GZs3a8oW3nUIXtbpqsyMPhrCu4xKeXshWZ/1iOsEJAVWnzU3lyDpNPbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com; spf=pass smtp.mailfrom=codeweavers.com; dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b=TV/T9p8V; arc=none smtp.client-ip=4.36.192.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeweavers.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codeweavers.com; s=s1; h=Message-ID:Date:Subject:Cc:To:From:Sender;
	bh=sRVvK3PXYm0eOCy4h040E2JuAl2v9xoXVKyVT6JY+Rw=; b=TV/T9p8VKRwA52kOLE9gV+xzE4
	ymYu/JQxE89YJwLrJT0YhJUxlW+Ck7x6DYFg2w1sR+xLjYq2/w1l/EK9gn3qdAN42CSuG12Za/VRt
	zmUkyGgijoEUUT2Ij4dbGgGi3AekxsYxBjXL3K9e1oQfs1FwKKt3kudoe2anoG7gWUQyp7jhdy0jq
	daMQf2MOFHIAfL/qK/EYWexnYBmJGwXfI01sRbzLNby0kNERrAmZWDn1Cx49WI75fGldUcwyPFfnG
	h3u/46Yxp3bwKo9CR5hdIuDPs1/BMKDICPCs6xil1oMUwX4natMmG/BoGU66jDcRpIy430IftkzHg
	4c2indhg==;
Received: from cw137ip160.mn.codeweavers.com ([10.69.137.160] helo=camazotz.mn.codeweavers.com)
	by mail.codeweavers.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <zfigura@codeweavers.com>)
	id 1rpzlT-000iik-1B;
	Thu, 28 Mar 2024 19:06:35 -0500
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
Subject: [PATCH v3 22/30] selftests: ntsync: Add some tests for wakeup signaling with WINESYNC_IOC_WAIT_ALL.
Date: Thu, 28 Mar 2024 19:06:13 -0500
Message-ID: <20240329000621.148791-23-zfigura@codeweavers.com>
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

Test contended "wait-for-all" waits, to make sure that scheduling and wakeup
logic works correctly, and that the wait only exits once objects are all
simultaneously signaled.

Signed-off-by: Elizabeth Figura <zfigura@codeweavers.com>
---
 .../testing/selftests/drivers/ntsync/ntsync.c | 98 +++++++++++++++++++
 1 file changed, 98 insertions(+)

diff --git a/tools/testing/selftests/drivers/ntsync/ntsync.c b/tools/testing/selftests/drivers/ntsync/ntsync.c
index 993f5db23768..b77fb0b2c4b1 100644
--- a/tools/testing/selftests/drivers/ntsync/ntsync.c
+++ b/tools/testing/selftests/drivers/ntsync/ntsync.c
@@ -706,4 +706,102 @@ TEST(wake_any)
 	close(fd);
 }
 
+TEST(wake_all)
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
+	wait_args.timeout = get_abs_timeout(1000);
+	wait_args.objs = (uintptr_t)objs;
+	wait_args.count = 2;
+	wait_args.owner = 456;
+	thread_args.fd = fd;
+	thread_args.args = &wait_args;
+	thread_args.request = NTSYNC_IOC_WAIT_ALL;
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
+
+	ret = pthread_tryjoin_np(thread, NULL);
+	EXPECT_EQ(EBUSY, ret);
+
+	check_sem_state(sem_args.sem, 1, 3);
+
+	ret = wait_any(fd, 1, &sem_args.sem, 123, &index);
+	EXPECT_EQ(0, ret);
+	EXPECT_EQ(0, index);
+
+	ret = unlock_mutex(mutex_args.mutex, 123, &count);
+	EXPECT_EQ(0, ret);
+	EXPECT_EQ(1, count);
+
+	ret = pthread_tryjoin_np(thread, NULL);
+	EXPECT_EQ(EBUSY, ret);
+
+	check_mutex_state(mutex_args.mutex, 0, 0);
+
+	count = 2;
+	ret = post_sem(sem_args.sem, &count);
+	EXPECT_EQ(0, ret);
+	EXPECT_EQ(0, count);
+	check_sem_state(sem_args.sem, 1, 3);
+	check_mutex_state(mutex_args.mutex, 1, 456);
+
+	ret = wait_for_thread(thread, 100);
+	EXPECT_EQ(0, ret);
+	EXPECT_EQ(0, thread_args.ret);
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


