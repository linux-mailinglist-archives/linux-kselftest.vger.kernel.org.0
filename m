Return-Path: <linux-kselftest+bounces-6813-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 582BC890F7E
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Mar 2024 01:28:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C40E71F24365
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Mar 2024 00:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E9B03DBA1;
	Fri, 29 Mar 2024 00:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b="CqCpSbBL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.codeweavers.com (mail.codeweavers.com [4.36.192.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D66A3FBA8;
	Fri, 29 Mar 2024 00:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.36.192.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711671860; cv=none; b=A9KWVOqjTOZyUU+oHHoc+DbU9UNdIA7I3StURckYWxIp5FOnpWIUoP8tD3Gmb8sXuz/VeIOOVUza/tLZf1+IpmepGZuf58gou3Ix3m0rvVZL6iqS0G+3D630cvrECvmFw8bwiTWSnu8QHMl13En5SUCiD4WWq4DDDxiPDaWwmj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711671860; c=relaxed/simple;
	bh=5s4cbaXOZdhl8OxqDpewcvkpg1+2LrCYlh67RC1NKLk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OgTVha4SzhcJsP/HEhoR+1nurLyAsezoLHe2XFnBVPFmpIY14iOm2enyz2gbm5JqokhkTtI6gkxamSmQh/0GvXetPucH7dlH23yCbA0uh/P3WmbCnToqeLEs8LhG+c8pg1W+rbAWoYYT17ZcvSXT018pzaYNd8XYqMm8kkLItz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com; spf=pass smtp.mailfrom=codeweavers.com; dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b=CqCpSbBL; arc=none smtp.client-ip=4.36.192.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeweavers.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codeweavers.com; s=s1; h=Message-ID:Date:Subject:Cc:To:From:Sender;
	bh=aNMQ5WQ+qy6vOq9RLq84GZmYMjpbBBXHBNy41a5mB8g=; b=CqCpSbBL2Yz79PQENMTqkCkkOi
	AYmAspOYcxTOzZ0OtYRzOz6oyf4zqnR0KmVivRWF0pgCRBRDeWauchZre7OomuoTTf7WCUmmtSM+C
	QQYgPyT5vSINGgZloWX6nwRMALcp60/RYtxvhIKA55vky/KlRcUooiBdFFrx7x48+RkRyeal++Z8i
	pxFz29DYiSbhBDiaZICgYve0YjSEoL7WejUnyD5AyIPGzX8d1TrUa2aMyS4L6e6N7XbWHZqpzoLHv
	iDcmzyGIflGykpI5bEhY8xQmxU+sx0xl4i7bIX/veqpa9dDGEEjmIuXmKVACdAXH2D3lAyLUgGW0A
	+5UBc9iA==;
Received: from cw137ip160.mn.codeweavers.com ([10.69.137.160] helo=camazotz.mn.codeweavers.com)
	by mail.codeweavers.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <zfigura@codeweavers.com>)
	id 1rpzlV-000iik-0O;
	Thu, 28 Mar 2024 19:06:37 -0500
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
Subject: [PATCH v3 26/30] selftests: ntsync: Add tests for alertable waits.
Date: Thu, 28 Mar 2024 19:06:17 -0500
Message-ID: <20240329000621.148791-27-zfigura@codeweavers.com>
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

Test the "alert" functionality of NTSYNC_IOC_WAIT_ALL and NTSYNC_IOC_WAIT_ANY,
when a wait is woken with an alert and when it is woken by an object.

Signed-off-by: Elizabeth Figura <zfigura@codeweavers.com>
---
 .../testing/selftests/drivers/ntsync/ntsync.c | 179 +++++++++++++++++-
 1 file changed, 176 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/drivers/ntsync/ntsync.c b/tools/testing/selftests/drivers/ntsync/ntsync.c
index 5d17eff6a370..5465a16d38b3 100644
--- a/tools/testing/selftests/drivers/ntsync/ntsync.c
+++ b/tools/testing/selftests/drivers/ntsync/ntsync.c
@@ -95,7 +95,7 @@ static int read_event_state(int event, __u32 *signaled, __u32 *manual)
 	})
 
 static int wait_objs(int fd, unsigned long request, __u32 count,
-		     const int *objs, __u32 owner, __u32 *index)
+		     const int *objs, __u32 owner, int alert, __u32 *index)
 {
 	struct ntsync_wait_args args = {0};
 	struct timespec timeout;
@@ -108,6 +108,7 @@ static int wait_objs(int fd, unsigned long request, __u32 count,
 	args.objs = (uintptr_t)objs;
 	args.owner = owner;
 	args.index = 0xdeadbeef;
+	args.alert = alert;
 	ret = ioctl(fd, request, &args);
 	*index = args.index;
 	return ret;
@@ -115,12 +116,26 @@ static int wait_objs(int fd, unsigned long request, __u32 count,
 
 static int wait_any(int fd, __u32 count, const int *objs, __u32 owner, __u32 *index)
 {
-	return wait_objs(fd, NTSYNC_IOC_WAIT_ANY, count, objs, owner, index);
+	return wait_objs(fd, NTSYNC_IOC_WAIT_ANY, count, objs, owner, 0, index);
 }
 
 static int wait_all(int fd, __u32 count, const int *objs, __u32 owner, __u32 *index)
 {
-	return wait_objs(fd, NTSYNC_IOC_WAIT_ALL, count, objs, owner, index);
+	return wait_objs(fd, NTSYNC_IOC_WAIT_ALL, count, objs, owner, 0, index);
+}
+
+static int wait_any_alert(int fd, __u32 count, const int *objs,
+			  __u32 owner, int alert, __u32 *index)
+{
+	return wait_objs(fd, NTSYNC_IOC_WAIT_ANY,
+			 count, objs, owner, alert, index);
+}
+
+static int wait_all_alert(int fd, __u32 count, const int *objs,
+			  __u32 owner, int alert, __u32 *index)
+{
+	return wait_objs(fd, NTSYNC_IOC_WAIT_ALL,
+			 count, objs, owner, alert, index);
 }
 
 TEST(semaphore_state)
@@ -1095,4 +1110,162 @@ TEST(wake_all)
 	close(fd);
 }
 
+TEST(alert_any)
+{
+	struct ntsync_event_args event_args = {0};
+	struct ntsync_sem_args sem_args = {0};
+	__u32 index, count, signaled;
+	int objs[2], fd, ret;
+
+	fd = open("/dev/ntsync", O_CLOEXEC | O_RDONLY);
+	ASSERT_LE(0, fd);
+
+	sem_args.count = 0;
+	sem_args.max = 2;
+	sem_args.sem = 0xdeadbeef;
+	ret = ioctl(fd, NTSYNC_IOC_CREATE_SEM, &sem_args);
+	EXPECT_EQ(0, ret);
+	EXPECT_NE(0xdeadbeef, sem_args.sem);
+	objs[0] = sem_args.sem;
+
+	sem_args.count = 1;
+	sem_args.max = 2;
+	sem_args.sem = 0xdeadbeef;
+	ret = ioctl(fd, NTSYNC_IOC_CREATE_SEM, &sem_args);
+	EXPECT_EQ(0, ret);
+	EXPECT_NE(0xdeadbeef, sem_args.sem);
+	objs[1] = sem_args.sem;
+
+	event_args.manual = true;
+	event_args.signaled = true;
+	ret = ioctl(fd, NTSYNC_IOC_CREATE_EVENT, &event_args);
+	EXPECT_EQ(0, ret);
+
+	ret = wait_any_alert(fd, 0, NULL, 123, event_args.event, &index);
+	EXPECT_EQ(0, ret);
+	EXPECT_EQ(0, index);
+
+	ret = ioctl(event_args.event, NTSYNC_IOC_EVENT_RESET, &signaled);
+	EXPECT_EQ(0, ret);
+
+	ret = wait_any_alert(fd, 0, NULL, 123, event_args.event, &index);
+	EXPECT_EQ(-1, ret);
+	EXPECT_EQ(ETIMEDOUT, errno);
+
+	ret = ioctl(event_args.event, NTSYNC_IOC_EVENT_SET, &signaled);
+	EXPECT_EQ(0, ret);
+
+	ret = wait_any_alert(fd, 2, objs, 123, event_args.event, &index);
+	EXPECT_EQ(0, ret);
+	EXPECT_EQ(1, index);
+
+	ret = wait_any_alert(fd, 2, objs, 123, event_args.event, &index);
+	EXPECT_EQ(0, ret);
+	EXPECT_EQ(2, index);
+
+	close(event_args.event);
+
+	/* test with an auto-reset event */
+
+	event_args.manual = false;
+	event_args.signaled = true;
+	ret = ioctl(fd, NTSYNC_IOC_CREATE_EVENT, &event_args);
+	EXPECT_EQ(0, ret);
+
+	count = 1;
+	ret = post_sem(objs[0], &count);
+	EXPECT_EQ(0, ret);
+
+	ret = wait_any_alert(fd, 2, objs, 123, event_args.event, &index);
+	EXPECT_EQ(0, ret);
+	EXPECT_EQ(0, index);
+
+	ret = wait_any_alert(fd, 2, objs, 123, event_args.event, &index);
+	EXPECT_EQ(0, ret);
+	EXPECT_EQ(2, index);
+
+	ret = wait_any_alert(fd, 2, objs, 123, event_args.event, &index);
+	EXPECT_EQ(-1, ret);
+	EXPECT_EQ(ETIMEDOUT, errno);
+
+	close(event_args.event);
+
+	close(objs[0]);
+	close(objs[1]);
+
+	close(fd);
+}
+
+TEST(alert_all)
+{
+	struct ntsync_event_args event_args = {0};
+	struct ntsync_sem_args sem_args = {0};
+	__u32 index, count, signaled;
+	int objs[2], fd, ret;
+
+	fd = open("/dev/ntsync", O_CLOEXEC | O_RDONLY);
+	ASSERT_LE(0, fd);
+
+	sem_args.count = 2;
+	sem_args.max = 2;
+	sem_args.sem = 0xdeadbeef;
+	ret = ioctl(fd, NTSYNC_IOC_CREATE_SEM, &sem_args);
+	EXPECT_EQ(0, ret);
+	EXPECT_NE(0xdeadbeef, sem_args.sem);
+	objs[0] = sem_args.sem;
+
+	sem_args.count = 1;
+	sem_args.max = 2;
+	sem_args.sem = 0xdeadbeef;
+	ret = ioctl(fd, NTSYNC_IOC_CREATE_SEM, &sem_args);
+	EXPECT_EQ(0, ret);
+	EXPECT_NE(0xdeadbeef, sem_args.sem);
+	objs[1] = sem_args.sem;
+
+	event_args.manual = true;
+	event_args.signaled = true;
+	ret = ioctl(fd, NTSYNC_IOC_CREATE_EVENT, &event_args);
+	EXPECT_EQ(0, ret);
+
+	ret = wait_all_alert(fd, 2, objs, 123, event_args.event, &index);
+	EXPECT_EQ(0, ret);
+	EXPECT_EQ(0, index);
+
+	ret = wait_all_alert(fd, 2, objs, 123, event_args.event, &index);
+	EXPECT_EQ(0, ret);
+	EXPECT_EQ(2, index);
+
+	close(event_args.event);
+
+	/* test with an auto-reset event */
+
+	event_args.manual = false;
+	event_args.signaled = true;
+	ret = ioctl(fd, NTSYNC_IOC_CREATE_EVENT, &event_args);
+	EXPECT_EQ(0, ret);
+
+	count = 2;
+	ret = post_sem(objs[1], &count);
+	EXPECT_EQ(0, ret);
+
+	ret = wait_all_alert(fd, 2, objs, 123, event_args.event, &index);
+	EXPECT_EQ(0, ret);
+	EXPECT_EQ(0, index);
+
+	ret = wait_all_alert(fd, 2, objs, 123, event_args.event, &index);
+	EXPECT_EQ(0, ret);
+	EXPECT_EQ(2, index);
+
+	ret = wait_all_alert(fd, 2, objs, 123, event_args.event, &index);
+	EXPECT_EQ(-1, ret);
+	EXPECT_EQ(ETIMEDOUT, errno);
+
+	close(event_args.event);
+
+	close(objs[0]);
+	close(objs[1]);
+
+	close(fd);
+}
+
 TEST_HARNESS_MAIN
-- 
2.43.0


