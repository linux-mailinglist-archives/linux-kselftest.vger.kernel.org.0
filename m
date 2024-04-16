Return-Path: <linux-kselftest+bounces-8063-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AECA8A5FDF
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 03:11:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3481F1F21110
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 01:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C16D38384;
	Tue, 16 Apr 2024 01:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b="qD/chXd8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.codeweavers.com (mail.codeweavers.com [4.36.192.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 766E310A22;
	Tue, 16 Apr 2024 01:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.36.192.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713229833; cv=none; b=UG7MLFbLLcNdDMRFsuRR37Bry5SrqZfPvx+MoL4EJKCV7Cn7Emd6NF50aSXxfsIBTZ/rUYOOSPqLSQdYPrNUyhHhHxDerYe9NcMAH57YNg+ZwEJ79V0Ws9IKIZUaQ2UMN1P1++wj81BzhEUWt3f+9OjDNjTPd4kHr8o8SwQF9c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713229833; c=relaxed/simple;
	bh=RxzO+9cowicVFB0C8g1tfr/5wcAsZKu2OdxghkIxD54=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jkK3kap3L1jq1tplncf0/zIKLmdwZHtDnLFskWgQgU741ENDJ9VgUehmhFG1uZQHEwro/SDOH6uLNRZsrx1CxWLqT1MxHxfc25jviBZvQFXCy7DCohIpSKM7XUOKmvMXUILfmn94EJTzPmz/OCrD1j8rrqlHoiJTpZ+meCV3tlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com; spf=pass smtp.mailfrom=codeweavers.com; dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b=qD/chXd8; arc=none smtp.client-ip=4.36.192.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeweavers.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codeweavers.com; s=s1; h=Message-ID:Date:Subject:Cc:To:From:Sender;
	bh=oYv/7gpkTd7m3dOtwqdlHd+jUV1xxytJ6Ebv/6cbmco=; b=qD/chXd8GqOIrUevoPCz9DzI5H
	c/I3ME9OJCm6XQxTp3fsJBY5wqnhLqdFR3t3kTGBSglPXDiTZ9ZA2eONHFpkDKB9GvUAxiWX4bXwg
	gmaKc7tpIiwNzVQ55vMMgAF5C5p1TZuXLiwqLDcDYWTRv4E6t5W1VZEkDumOIJ1v7/cRHrbfeJEpu
	W3r3Y9VGMnpngG7P4YDp4QGgV9wTZAyDRhq87puYc8EtHWVEYegEAE3FO+Y7BxCdrRWiLpLD9QoQh
	qkiPCrC+kBD0QEBn2Xx5ciblJ3mbk5hd0yNIMuB+LDFtv79gRupQjpM68cFeOTHOjmjLl/F1EIScO
	ckOKiKCA==;
Received: from cw137ip160.mn.codeweavers.com ([10.69.137.160] helo=camazotz.mn.codeweavers.com)
	by mail.codeweavers.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <zfigura@codeweavers.com>)
	id 1rwXL5-00FbQv-34;
	Mon, 15 Apr 2024 20:10:24 -0500
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
Subject: [PATCH v4 25/27] selftests: ntsync: Add a stress test for contended waits.
Date: Mon, 15 Apr 2024 20:08:35 -0500
Message-ID: <20240416010837.333694-26-zfigura@codeweavers.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240416010837.333694-1-zfigura@codeweavers.com>
References: <20240416010837.333694-1-zfigura@codeweavers.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Test a more realistic usage pattern, and one with heavy contention, in order to
actually exercise ntsync's internal synchronization.

This test has several threads in a tight loop acquiring a mutex, modifying some
shared data, and then releasing the mutex. At the end we check if the data is
consistent.

Signed-off-by: Elizabeth Figura <zfigura@codeweavers.com>
---
 .../testing/selftests/drivers/ntsync/ntsync.c | 74 +++++++++++++++++++
 1 file changed, 74 insertions(+)

diff --git a/tools/testing/selftests/drivers/ntsync/ntsync.c b/tools/testing/selftests/drivers/ntsync/ntsync.c
index 968874d7e325..5fa2c9a0768c 100644
--- a/tools/testing/selftests/drivers/ntsync/ntsync.c
+++ b/tools/testing/selftests/drivers/ntsync/ntsync.c
@@ -1330,4 +1330,78 @@ TEST(alert_all)
 	close(fd);
 }
 
+#define STRESS_LOOPS 10000
+#define STRESS_THREADS 4
+
+static unsigned int stress_counter;
+static int stress_device, stress_start_event, stress_mutex;
+
+static void *stress_thread(void *arg)
+{
+	struct ntsync_wait_args wait_args = {0};
+	__u32 index, count, i;
+	int ret;
+
+	wait_args.timeout = UINT64_MAX;
+	wait_args.count = 1;
+	wait_args.objs = (uintptr_t)&stress_start_event;
+	wait_args.owner = gettid();
+	wait_args.index = 0xdeadbeef;
+
+	ioctl(stress_device, NTSYNC_IOC_WAIT_ANY, &wait_args);
+
+	wait_args.objs = (uintptr_t)&stress_mutex;
+
+	for (i = 0; i < STRESS_LOOPS; ++i) {
+		ioctl(stress_device, NTSYNC_IOC_WAIT_ANY, &wait_args);
+
+		++stress_counter;
+
+		unlock_mutex(stress_mutex, wait_args.owner, &count);
+	}
+
+	return NULL;
+}
+
+TEST(stress_wait)
+{
+	struct ntsync_event_args event_args;
+	struct ntsync_mutex_args mutex_args;
+	pthread_t threads[STRESS_THREADS];
+	__u32 signaled, i;
+	int ret;
+
+	stress_device = open("/dev/ntsync", O_CLOEXEC | O_RDONLY);
+	ASSERT_LE(0, stress_device);
+
+	mutex_args.owner = 0;
+	mutex_args.count = 0;
+	ret = ioctl(stress_device, NTSYNC_IOC_CREATE_MUTEX, &mutex_args);
+	EXPECT_EQ(0, ret);
+	stress_mutex = mutex_args.mutex;
+
+	event_args.manual = 1;
+	event_args.signaled = 0;
+	ret = ioctl(stress_device, NTSYNC_IOC_CREATE_EVENT, &event_args);
+	EXPECT_EQ(0, ret);
+	stress_start_event = event_args.event;
+
+	for (i = 0; i < STRESS_THREADS; ++i)
+		pthread_create(&threads[i], NULL, stress_thread, NULL);
+
+	ret = ioctl(stress_start_event, NTSYNC_IOC_EVENT_SET, &signaled);
+	EXPECT_EQ(0, ret);
+
+	for (i = 0; i < STRESS_THREADS; ++i) {
+		ret = pthread_join(threads[i], NULL);
+		EXPECT_EQ(0, ret);
+	}
+
+	EXPECT_EQ(STRESS_LOOPS * STRESS_THREADS, stress_counter);
+
+	close(stress_start_event);
+	close(stress_mutex);
+	close(stress_device);
+}
+
 TEST_HARNESS_MAIN
-- 
2.43.0


