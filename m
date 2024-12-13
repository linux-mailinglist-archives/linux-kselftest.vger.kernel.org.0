Return-Path: <linux-kselftest+bounces-23363-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 255699F1681
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Dec 2024 20:42:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88A091890A81
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Dec 2024 19:42:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA02D1F8EF7;
	Fri, 13 Dec 2024 19:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b="HcnF31rl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.codeweavers.com (mail.codeweavers.com [4.36.192.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58B001F8EE8;
	Fri, 13 Dec 2024 19:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.36.192.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734118574; cv=none; b=MxYnTlIPfgIiswAwYRjV7E36mKFvD5hleFMXcLhed0yqCJ1PEeNaKq631Kw0qnRINcmWmA6xnbDiycxLg/55nIi6/125pa8bdZT7n2CErpv7BHoa8OZmT1aqa9djrSZaErmGmhwaM5/sWh8ofxlG2B/OFuAOvhTV7jXY73WadpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734118574; c=relaxed/simple;
	bh=pYR2WBHL24pwrxFGjgzaFAoux3/nbKSlqsjqcd8RF9s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z8cLRd45Gad1Gt6Fd5EkVqQFMPdltANr2yro4Y08g5EXTDyItg7hy+8iTelWYF5Y9vQym2P/bIJX0++V9xU0LZZFuGCd9MdX/buQ+ULB+BYCVKiVTjrIDJfbYC8lPJJvEBjl1EHmUxT+mKSrCH8oMRn4ou1vVo8Ypb+Wv6pzcVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com; spf=pass smtp.mailfrom=codeweavers.com; dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b=HcnF31rl; arc=none smtp.client-ip=4.36.192.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeweavers.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codeweavers.com; s=s1; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Q6j4VHkLmfUyGJlrK4NPmt5pESyjzFoHLl8foXzRRpU=; b=HcnF31rlw46SCd+NH+iqEGbDEp
	QSRfcKkj9CDYMwgsMAycKZn3mscrVMVzeycg3Nw8KQqd46NFf5VA3sSOE10ZQaGlISTzKdCJO0Gth
	Z28qE7VcFlvCu0MKq0oGiS6sVgqVZqF5VVieZjZt5vlM8X/iSLnuvVdCkGdvE5FzgRaa4MK2YqNjK
	LRmk0cK+AtU0WlBXPBmjwq/fMuawROQlWQ9/3fcS5J+9xxEKBbR39fu6DtQdzM0Ahk/Q/8RysNtA5
	+taW9J6cfJhRLpE5+b+/Vi8gWV+5j0HLDbAVnXVNyHvIv6PNgVDZ+ERdhunO3/6o8ObGeit26qmhj
	QfB+HCIw==;
Received: from cw137ip160.mn.codeweavers.com ([10.69.137.160] helo=camazotz.mn.codeweavers.com)
	by mail.codeweavers.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <zfigura@codeweavers.com>)
	id 1tMBSG-00ASsZ-1h;
	Fri, 13 Dec 2024 13:36:05 -0600
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
Subject: [PATCH v7 27/30] selftests: ntsync: Add a stress test for contended waits.
Date: Fri, 13 Dec 2024 13:35:08 -0600
Message-ID: <20241213193511.457338-28-zfigura@codeweavers.com>
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

Test a more realistic usage pattern, and one with heavy contention, in order to
actually exercise ntsync's internal synchronization.

This test has several threads in a tight loop acquiring a mutex, modifying some
shared data, and then releasing the mutex. At the end we check if the data is
consistent.

Signed-off-by: Elizabeth Figura <zfigura@codeweavers.com>
---
 .../testing/selftests/drivers/ntsync/ntsync.c | 72 +++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/tools/testing/selftests/drivers/ntsync/ntsync.c b/tools/testing/selftests/drivers/ntsync/ntsync.c
index 298b279729aa..3aad311574c4 100644
--- a/tools/testing/selftests/drivers/ntsync/ntsync.c
+++ b/tools/testing/selftests/drivers/ntsync/ntsync.c
@@ -1268,4 +1268,76 @@ TEST(alert_all)
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
+	stress_mutex = ioctl(stress_device, NTSYNC_IOC_CREATE_MUTEX, &mutex_args);
+	EXPECT_LE(0, stress_mutex);
+
+	event_args.manual = 1;
+	event_args.signaled = 0;
+	stress_start_event = ioctl(stress_device, NTSYNC_IOC_CREATE_EVENT, &event_args);
+	EXPECT_LE(0, stress_start_event);
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
2.45.2


