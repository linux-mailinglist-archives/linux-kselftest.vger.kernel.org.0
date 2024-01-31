Return-Path: <linux-kselftest+bounces-3804-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7033843379
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jan 2024 03:17:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E4F11C20F75
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jan 2024 02:17:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C104B20B2C;
	Wed, 31 Jan 2024 02:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b="O6rqaQpH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.codeweavers.com (mail.codeweavers.com [4.36.192.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 947E7746E;
	Wed, 31 Jan 2024 02:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.36.192.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706667368; cv=none; b=Pa1mYoBVKQv1xasu4BMIfbxpiGzXHy/6E2W3BnQofubMWojDwbNVSzwbkNyJcqslBvIni7xaK0ZULWowJJUiPxsNRfWar8rWHThl4xKwt1/3WnucRZGG05NpjhupryWFQRrTR+s2xmt7m/YnaINlR2eFgwjwAr1cuLhzPkK77UI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706667368; c=relaxed/simple;
	bh=0/+/hcgGDqBe60bUVEVmocVH9t5svTQdQZc0NkVSSpc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pT3Cao5OFiX1Jer00CwIDCtQCMmDnzuNaReg7khAI9bf8nLQlzUMMAELY+K2Y8AFNJ0DAS7jeWaEnE2YTJeLuuwFSHsVz7ZkRD1POseVKNKz1LZ2r/5vbtQzgSR3Oa8KnKlinZd4wwquvdDO23uN4iFR2FpcWS2gp99EPI+dGS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com; spf=pass smtp.mailfrom=codeweavers.com; dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b=O6rqaQpH; arc=none smtp.client-ip=4.36.192.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeweavers.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codeweavers.com; s=s1; h=Message-ID:Date:Subject:Cc:To:From:Sender;
	bh=In2g/SxOslWdr0ggX/uaBmW3P5Of+22LEm91YJWAe0A=; b=O6rqaQpHDK+OJLCivF6+Qd0XyV
	wJQMzjsrn5//04CHK55yjO4hL0I64rS7vXKWVcZ+OErnP0JU8IIXsBCT5mt0T8eBEOOjbcP0KkJmG
	GDhx2EY9uzYeKaxqiwtKkcDbcb+TsIZFHn4vi5VFmgVpSczH3Y2gDgXbpO9ZivyOBwT2iCJHWG0CX
	UPKaa3a9dfFyY/SOif9ji24x4+aMRpH1niNLV7rYPLfxjsRLeoJzuuwOokNftlDNEiqLP10aODZBP
	sxZInVET5kfrRxgrMRQJaAFhS98kKLljV0SENNvAucxDDFA8/jaWeFO1aixdmHa8fxwG+cefI04+7
	Qu0IqO/w==;
Received: from cw137ip160.mn.codeweavers.com ([10.69.137.160] helo=camazotz.mn.codeweavers.com)
	by mail.codeweavers.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <zfigura@codeweavers.com>)
	id 1rV08s-0038Kv-0d;
	Tue, 30 Jan 2024 20:15:58 -0600
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
Subject: [RFC PATCH v2 27/29] selftests: ntsync: Add some tests for wakeup signaling via alerts.
Date: Tue, 30 Jan 2024 20:13:54 -0600
Message-ID: <20240131021356.10322-28-zfigura@codeweavers.com>
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

Expand the alert tests to cover alerting a thread mid-wait, to test that the
relevant scheduling logic works correctly.

Signed-off-by: Elizabeth Figura <zfigura@codeweavers.com>
---
 .../testing/selftests/drivers/ntsync/ntsync.c | 62 +++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/tools/testing/selftests/drivers/ntsync/ntsync.c b/tools/testing/selftests/drivers/ntsync/ntsync.c
index 6c00a55909aa..09153d0686ac 100644
--- a/tools/testing/selftests/drivers/ntsync/ntsync.c
+++ b/tools/testing/selftests/drivers/ntsync/ntsync.c
@@ -1080,9 +1080,12 @@ TEST(wake_all)
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
@@ -1130,6 +1133,34 @@ TEST(alert_any)
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
@@ -1166,9 +1197,12 @@ TEST(alert_any)
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
@@ -1202,6 +1236,34 @@ TEST(alert_all)
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


