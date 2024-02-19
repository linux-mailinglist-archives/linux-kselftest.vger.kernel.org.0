Return-Path: <linux-kselftest+bounces-4975-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C3A6C85AEF5
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Feb 2024 23:41:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B262B24DC1
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Feb 2024 22:41:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6C9E5B1F1;
	Mon, 19 Feb 2024 22:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b="jUswTr/G"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.codeweavers.com (mail.codeweavers.com [4.36.192.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94CFD57307;
	Mon, 19 Feb 2024 22:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.36.192.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708382382; cv=none; b=Mms8oXUr1aywWyS50n9U9YtgWbuqzvzq/NM39fBXhXle7PV9QZYe0JAtsE/Pq4K8It/okuKKt/iX/gtsItGTxtTE6G/fr97twB6U9SdBp2wK3I2oanEuiiFIm4YE2gVfbglGQv0OOmCR2uZrbje4ZXckAQc8JGW3hQX03HH+NUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708382382; c=relaxed/simple;
	bh=FzJOOSC9UUHrWRcI7UAQtasAek/KIUNP0SrrKFAkeFc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GJzKpwRqqP1YW5P+HV/GRJXrPNY7IQAZFan7JJ+liHWItouC8PysJEvm61rVDALI+j2Pba2dXcp+hAyKNuxHuJfXZWkN+ML2Gt9HYKxHIrTfdQQNKjy6O/ZQ10kg4bn0ISI/AUhLItMaYTNhDp2YbEFfDfSCyg3gchrRbrgyUlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com; spf=pass smtp.mailfrom=codeweavers.com; dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b=jUswTr/G; arc=none smtp.client-ip=4.36.192.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeweavers.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codeweavers.com; s=s1; h=Message-ID:Date:Subject:Cc:To:From:Sender;
	bh=mD7kGOKMw9/SgIhNijECJqDpS2n0gwPnb6QPtQ/fOO8=; b=jUswTr/GiG/c8wOnuzhqbcgsnb
	gd2/yfNt21JrJFYmZomc47T2isYYWmFhJy/e9d+WQyhAykuYUtLvWdzYTkCR05R70cL57w83VDbYE
	djY4gNAA+1tgC0sCMCyYiBNI0e9dTYUFJfNOwOr0EQbL5HZLhE6Ax6VEG0tUtQXdns6iaG/BpyAcB
	Fq1Og8UVECUTECFMvKaQiwVV25hrmjhZXkK4uRKQ0UgZGu0rjc+T5Wzd9hYiDuaEUGipyOC8lZBVa
	kQY6urj4PGGu9sZ2fN828vm894YaPDJL4rK8ksY4wMD4hYP+gNkV5Y//a56adhfFhTVoHwB8La5ng
	cHR+2NSg==;
Received: from cw137ip160.mn.codeweavers.com ([10.69.137.160] helo=camazotz.mn.codeweavers.com)
	by mail.codeweavers.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <zfigura@codeweavers.com>)
	id 1rcCIU-0037Oz-0l;
	Mon, 19 Feb 2024 16:39:38 -0600
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
Subject: [PATCH v2 28/31] selftests: ntsync: Add some tests for wakeup signaling via alerts.
Date: Mon, 19 Feb 2024 16:38:30 -0600
Message-ID: <20240219223833.95710-29-zfigura@codeweavers.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240219223833.95710-1-zfigura@codeweavers.com>
References: <20240219223833.95710-1-zfigura@codeweavers.com>
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
index 5465a16d38b3..968874d7e325 100644
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


