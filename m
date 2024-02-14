Return-Path: <linux-kselftest+bounces-4707-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A45258557F5
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Feb 2024 01:00:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D358E1C2203E
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Feb 2024 00:00:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D55B14E2FA;
	Wed, 14 Feb 2024 23:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b="JLlDhLzs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.codeweavers.com (mail.codeweavers.com [4.36.192.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D8AD14D456;
	Wed, 14 Feb 2024 23:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.36.192.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707954831; cv=none; b=D/DXYXYdePwVQFAKmegaMq7T7sFIjd3LiEf7OS2PwlwYGBFsrBW23cT58GFyFARu5GTDqzVoCIFFWEkbVW63X4Dpdgwa235t2MBm11A4Z8qbU+1uGZ/+6NnEHDHk6oWNjUZst5Xmhu0joETvBfTyCuJZDxZtpnfA314f6FZmd5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707954831; c=relaxed/simple;
	bh=/pKkTBCauQqQ72O32eox8sahDmutQPf7m0HkhTATFWk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mxjqLfu40e54Bnc/fhw5AKuyYQGlmmg73wx97Fah8nOYrQaqb3Z7PYEYXbkHyWMS+oZt3xJRVvSIVMYG1wVVigbKHcBNeHLz5gHp/J3UOso1O0mF6ajpggIyZG0sPO0gcO2+U48j8NWFxsccboaH1GCwqHRt/vMrY+PlLO1eCHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com; spf=pass smtp.mailfrom=codeweavers.com; dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b=JLlDhLzs; arc=none smtp.client-ip=4.36.192.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeweavers.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codeweavers.com; s=s1; h=Message-ID:Date:Subject:Cc:To:From:Sender;
	bh=nreuQ1mkx4GK2wPOFpIbOuQtSeY/XQ+g3hSeDJlq7hA=; b=JLlDhLzsE1Hl+EnS3mh0kTbMa4
	wi5820ZyYUkuxukF6D3lTIyOVQSOaMGemu2lCt8SjRztrXRS+/mF0tererKUciLh3xAxWfSQMM35W
	NwKGuV/msH5EtcOtCzmINzQ9bu5Nk6mg4XzqEyKbKHBE6988kE4MlCD6/X+UvmwB+JqChgpF2wHjl
	GlI/Q4XzmmYBYArvyKmfBtckGCCrBcPLf1Ennlhy9lYJCIKqDpGgbQ/VCzPL5LcHoPLT64y+YnD69
	7tPwJ6UW7Xl3vQ5hkoCFgq4Yy3r4zZ1RHjWuqLZp85w2ydFFUo/QrCA5pdPDmdygTKkGcyCnqyAXO
	zloAbOTA==;
Received: from cw137ip160.mn.codeweavers.com ([10.69.137.160] helo=camazotz.mn.codeweavers.com)
	by mail.codeweavers.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <zfigura@codeweavers.com>)
	id 1raP4V-00GcSK-1A;
	Wed, 14 Feb 2024 17:53:47 -0600
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
Subject: [PATCH 28/31] selftests: ntsync: Add some tests for wakeup signaling via alerts.
Date: Wed, 14 Feb 2024 17:53:03 -0600
Message-ID: <20240214235307.10494-19-zfigura@codeweavers.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240214235307.10494-1-zfigura@codeweavers.com>
References: <20240214233645.9273-1-zfigura@codeweavers.com>
 <20240214235307.10494-1-zfigura@codeweavers.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Expand the alert tests to cover alerting a thread mid-wait, to test that the
relevant scheduling logic works correctly.

Signed-off-by: Elizabeth Figura <zfigura@codeweavers.com>
---
 .../testing/selftests/drivers/ntsync/ntsync.c | 62 +++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/tools/testing/selftests/drivers/ntsync/ntsync.c b/tools/testing/selftests/drivers/ntsync/ntsync.c
index 6c13b1f25d38..40cfdd356ef4 100644
--- a/tools/testing/selftests/drivers/ntsync/ntsync.c
+++ b/tools/testing/selftests/drivers/ntsync/ntsync.c
@@ -1113,9 +1113,12 @@ TEST(wake_all)
 TEST(alert_any)
 {
 	struct ntsync_event_args event_args = {0};
+	struct ntsync_wait_args wait_args = {0};
 	struct ntsync_sem_args sem_args = {0};
 	__u32 index, count, signaled;
+	struct wait_args thread_args;
 	int objs[2], fd, ret;
+	pthread_t thread;
 
 	fd = open("/dev/ntsync", O_CLOEXEC | O_RDONLY);
 	ASSERT_LE(0, fd);
@@ -1163,6 +1166,34 @@ TEST(alert_any)
 	EXPECT_EQ(0, ret);
 	EXPECT_EQ(2, index);
 
+	/* test wakeup via alert */
+
+	ret = ioctl(event_args.event, NTSYNC_IOC_EVENT_RESET, &signaled);
+	EXPECT_EQ(0, ret);
+
+	wait_args.timeout = get_abs_timeout(1000);
+	wait_args.objs = (uintptr_t)objs;
+	wait_args.count = 2;
+	wait_args.owner = 123;
+	wait_args.index = 0xdeadbeef;
+	wait_args.alert = event_args.event;
+	thread_args.fd = fd;
+	thread_args.args = &wait_args;
+	thread_args.request = NTSYNC_IOC_WAIT_ANY;
+	ret = pthread_create(&thread, NULL, wait_thread, &thread_args);
+	EXPECT_EQ(0, ret);
+
+	ret = wait_for_thread(thread, 100);
+	EXPECT_EQ(ETIMEDOUT, ret);
+
+	ret = ioctl(event_args.event, NTSYNC_IOC_EVENT_SET, &signaled);
+	EXPECT_EQ(0, ret);
+
+	ret = wait_for_thread(thread, 100);
+	EXPECT_EQ(0, ret);
+	EXPECT_EQ(0, thread_args.ret);
+	EXPECT_EQ(2, wait_args.index);
+
 	close(event_args.event);
 
 	/* test with an auto-reset event */
@@ -1199,9 +1230,12 @@ TEST(alert_any)
 TEST(alert_all)
 {
 	struct ntsync_event_args event_args = {0};
+	struct ntsync_wait_args wait_args = {0};
 	struct ntsync_sem_args sem_args = {0};
+	struct wait_args thread_args;
 	__u32 index, count, signaled;
 	int objs[2], fd, ret;
+	pthread_t thread;
 
 	fd = open("/dev/ntsync", O_CLOEXEC | O_RDONLY);
 	ASSERT_LE(0, fd);
@@ -1235,6 +1269,34 @@ TEST(alert_all)
 	EXPECT_EQ(0, ret);
 	EXPECT_EQ(2, index);
 
+	/* test wakeup via alert */
+
+	ret = ioctl(event_args.event, NTSYNC_IOC_EVENT_RESET, &signaled);
+	EXPECT_EQ(0, ret);
+
+	wait_args.timeout = get_abs_timeout(1000);
+	wait_args.objs = (uintptr_t)objs;
+	wait_args.count = 2;
+	wait_args.owner = 123;
+	wait_args.index = 0xdeadbeef;
+	wait_args.alert = event_args.event;
+	thread_args.fd = fd;
+	thread_args.args = &wait_args;
+	thread_args.request = NTSYNC_IOC_WAIT_ALL;
+	ret = pthread_create(&thread, NULL, wait_thread, &thread_args);
+	EXPECT_EQ(0, ret);
+
+	ret = wait_for_thread(thread, 100);
+	EXPECT_EQ(ETIMEDOUT, ret);
+
+	ret = ioctl(event_args.event, NTSYNC_IOC_EVENT_SET, &signaled);
+	EXPECT_EQ(0, ret);
+
+	ret = wait_for_thread(thread, 100);
+	EXPECT_EQ(0, ret);
+	EXPECT_EQ(0, thread_args.ret);
+	EXPECT_EQ(2, wait_args.index);
+
 	close(event_args.event);
 
 	/* test with an auto-reset event */
-- 
2.43.0


