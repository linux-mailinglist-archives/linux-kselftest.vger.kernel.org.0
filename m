Return-Path: <linux-kselftest+bounces-10410-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A86D18C9675
	for <lists+linux-kselftest@lfdr.de>; Sun, 19 May 2024 22:27:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46A32B20B5F
	for <lists+linux-kselftest@lfdr.de>; Sun, 19 May 2024 20:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7345478C62;
	Sun, 19 May 2024 20:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b="Am5lCtnq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.codeweavers.com (mail.codeweavers.com [4.36.192.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9870F74C08;
	Sun, 19 May 2024 20:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.36.192.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716150320; cv=none; b=QS0IaCj+D8EignYaUdlFgcLHK8Hw0/BppiQm4uddY9BpSth9F6P64Jedy526ojrq1CAti+2wbrFZDdUKJ4GlIV5mFiyIy9S+8JTTjYZZ+GvC/MF9ob/W2DEf/7T8i55It/4E5YCHLJDH3rAfrKpE3sDJykEdMovt2IQUT86tyec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716150320; c=relaxed/simple;
	bh=RxzO+9cowicVFB0C8g1tfr/5wcAsZKu2OdxghkIxD54=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ss6xWPYx/r8cQx2vENq0aiDb20Ni0ZrfV7I3RoI2a2ogEMMcEnRuEGFzpMHZ+PLstI3KBsHl//m7hLYN7gFg7uaigzhMF5dgLYpB9zrf3dUZVY4kB0Em85FddlbAmAfiIPexDAAF+GlhJBom99TBP4WV8VFmLtMLjnAWPBgge80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com; spf=pass smtp.mailfrom=codeweavers.com; dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b=Am5lCtnq; arc=none smtp.client-ip=4.36.192.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeweavers.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codeweavers.com; s=s1; h=Message-ID:Date:Subject:Cc:To:From:Sender;
	bh=oYv/7gpkTd7m3dOtwqdlHd+jUV1xxytJ6Ebv/6cbmco=; b=Am5lCtnqztGBM28U4zpjs03U+s
	jaw2gc0+azG93hztW+pTRaS3V9N766l8LpYdgKcYoyIapxJ+Pd5edMvcbQmFwEDzs8gnTMfCXeQTB
	CV3kMqQJhYqSw9rkxb4onIkWtFB1FxbU3sz3SPjljhiEAnVtJekyNgadmLdTOH+DWLvD6yfDtdroJ
	zf+aBr23Q/xn7fovimaY79ZMIIKcHsQzWC1OBywtk09gzgDZCPPp6zexaRrEFsRpeJ1BhATLxyvvO
	rRIUCce818lHkNu0POOX4B/37d4AprBoc6ypEQV8Wn1suAx2sJ20cdtjwNs6A/7ho/u1Od0X2csx2
	L5xwUnFg==;
Received: from cw137ip160.mn.codeweavers.com ([10.69.137.160] helo=camazotz.mn.codeweavers.com)
	by mail.codeweavers.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <zfigura@codeweavers.com>)
	id 1s8n5i-008wIn-1d;
	Sun, 19 May 2024 15:25:10 -0500
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
Subject: [PATCH v5 25/28] selftests: ntsync: Add a stress test for contended waits.
Date: Sun, 19 May 2024 15:24:51 -0500
Message-ID: <20240519202454.1192826-26-zfigura@codeweavers.com>
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


