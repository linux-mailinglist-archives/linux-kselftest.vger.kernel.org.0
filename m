Return-Path: <linux-kselftest+bounces-23361-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D6219F1677
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Dec 2024 20:42:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6174018903AB
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Dec 2024 19:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 930B81F8AC9;
	Fri, 13 Dec 2024 19:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b="oNrK8lve"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.codeweavers.com (mail.codeweavers.com [4.36.192.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAC011F03C6;
	Fri, 13 Dec 2024 19:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.36.192.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734118568; cv=none; b=f43oTrI5i1itnQYWoqGZWSiSpeZVTjh101X8b5vLmL8T0iJhXPYUah7mL2VqAUnzCG/ZeSrpT1l98d6h9XabK59bdl6FHcd8xYUwzPALzx91sYs4atpIjLfXF6C90OcHTplTeCtqdPSjhuWIIf9yoFk7Gov4rOJUIWktqS2pA24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734118568; c=relaxed/simple;
	bh=OW5b6S1u+81Tfp03uS4IKrVdaGNn0tyKQEFcN631qMY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MrwCuteuXi+BkfMTeiQ1dhoQj9MJ6qVJDJkTHyvkeIiLcix7wMgQxSmT1Q42WiEnqh4eoppE62lnrzLo6u5vB6vBm5ohqX0G+/n/la6ei4gdHtYhN20vQR1FbdYnfBXPNCNXU0A2bDYe23EcVSYNZmqFqCyRhjlhD5Rg9OZdVZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com; spf=pass smtp.mailfrom=codeweavers.com; dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b=oNrK8lve; arc=none smtp.client-ip=4.36.192.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeweavers.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codeweavers.com; s=s1; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=SUthWSmzKqccohRlBz7EaEe/GcYwxaSEedSNAiHbsB4=; b=oNrK8lveVGxijz6fi0z3K1EEXH
	EHPmrihHRLAhsnzizUCZp3gsri5IY4BhP9ibc84SwvmWH2iGHGcEU8G8obcWQZ2f7zNxb+YPo+dXX
	v9N+pOgzrV/ERddAD8osPWzlCFnqllvnb/2ZpHyuw/t5z0Rv2uyi7H2JqgV1TTj7aAhwMZCrpVKpE
	kGPJDEQOx6et88NviO5i6SNp98dTRnrgLbuuDQ4lauJ/ioLiv2Pn/eDxq2rg+NsG9UmcMZ+34OvYj
	qa7nL+oZa4HbSqssPvRcCrn4utCAw/LPcaoSnugJaA08kOx4jrRmrdxEt2pRFRsX3zC0ZoI7hXDXM
	sYfDuAuw==;
Received: from cw137ip160.mn.codeweavers.com ([10.69.137.160] helo=camazotz.mn.codeweavers.com)
	by mail.codeweavers.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <zfigura@codeweavers.com>)
	id 1tMBS8-00ASsZ-2o;
	Fri, 13 Dec 2024 13:35:57 -0600
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
Subject: [PATCH v7 25/30] selftests: ntsync: Add tests for alertable waits.
Date: Fri, 13 Dec 2024 13:35:06 -0600
Message-ID: <20241213193511.457338-26-zfigura@codeweavers.com>
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

Test the "alert" functionality of NTSYNC_IOC_WAIT_ALL and NTSYNC_IOC_WAIT_ANY,
when a wait is woken with an alert and when it is woken by an object.

Signed-off-by: Elizabeth Figura <zfigura@codeweavers.com>
---
 .../testing/selftests/drivers/ntsync/ntsync.c | 167 +++++++++++++++++-
 1 file changed, 164 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/drivers/ntsync/ntsync.c b/tools/testing/selftests/drivers/ntsync/ntsync.c
index 33348f0b621f..72f078dde444 100644
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
@@ -1045,4 +1060,150 @@ TEST(wake_all)
 	close(fd);
 }
 
+TEST(alert_any)
+{
+	struct ntsync_event_args event_args = {0};
+	struct ntsync_sem_args sem_args = {0};
+	__u32 index, count, signaled;
+	int objs[2], event, fd, ret;
+
+	fd = open("/dev/ntsync", O_CLOEXEC | O_RDONLY);
+	ASSERT_LE(0, fd);
+
+	sem_args.count = 0;
+	sem_args.max = 2;
+	objs[0] = ioctl(fd, NTSYNC_IOC_CREATE_SEM, &sem_args);
+	EXPECT_LE(0, objs[0]);
+
+	sem_args.count = 1;
+	sem_args.max = 2;
+	objs[1] = ioctl(fd, NTSYNC_IOC_CREATE_SEM, &sem_args);
+	EXPECT_LE(0, objs[1]);
+
+	event_args.manual = true;
+	event_args.signaled = true;
+	event = ioctl(fd, NTSYNC_IOC_CREATE_EVENT, &event_args);
+	EXPECT_LE(0, event);
+
+	ret = wait_any_alert(fd, 0, NULL, 123, event, &index);
+	EXPECT_EQ(0, ret);
+	EXPECT_EQ(0, index);
+
+	ret = ioctl(event, NTSYNC_IOC_EVENT_RESET, &signaled);
+	EXPECT_EQ(0, ret);
+
+	ret = wait_any_alert(fd, 0, NULL, 123, event, &index);
+	EXPECT_EQ(-1, ret);
+	EXPECT_EQ(ETIMEDOUT, errno);
+
+	ret = ioctl(event, NTSYNC_IOC_EVENT_SET, &signaled);
+	EXPECT_EQ(0, ret);
+
+	ret = wait_any_alert(fd, 2, objs, 123, event, &index);
+	EXPECT_EQ(0, ret);
+	EXPECT_EQ(1, index);
+
+	ret = wait_any_alert(fd, 2, objs, 123, event, &index);
+	EXPECT_EQ(0, ret);
+	EXPECT_EQ(2, index);
+
+	close(event);
+
+	/* test with an auto-reset event */
+
+	event_args.manual = false;
+	event_args.signaled = true;
+	event = ioctl(fd, NTSYNC_IOC_CREATE_EVENT, &event_args);
+	EXPECT_LE(0, event);
+
+	count = 1;
+	ret = release_sem(objs[0], &count);
+	EXPECT_EQ(0, ret);
+
+	ret = wait_any_alert(fd, 2, objs, 123, event, &index);
+	EXPECT_EQ(0, ret);
+	EXPECT_EQ(0, index);
+
+	ret = wait_any_alert(fd, 2, objs, 123, event, &index);
+	EXPECT_EQ(0, ret);
+	EXPECT_EQ(2, index);
+
+	ret = wait_any_alert(fd, 2, objs, 123, event, &index);
+	EXPECT_EQ(-1, ret);
+	EXPECT_EQ(ETIMEDOUT, errno);
+
+	close(event);
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
+	int objs[2], event, fd, ret;
+
+	fd = open("/dev/ntsync", O_CLOEXEC | O_RDONLY);
+	ASSERT_LE(0, fd);
+
+	sem_args.count = 2;
+	sem_args.max = 2;
+	objs[0] = ioctl(fd, NTSYNC_IOC_CREATE_SEM, &sem_args);
+	EXPECT_LE(0, objs[0]);
+
+	sem_args.count = 1;
+	sem_args.max = 2;
+	objs[1] = ioctl(fd, NTSYNC_IOC_CREATE_SEM, &sem_args);
+	EXPECT_LE(0, objs[1]);
+
+	event_args.manual = true;
+	event_args.signaled = true;
+	event = ioctl(fd, NTSYNC_IOC_CREATE_EVENT, &event_args);
+	EXPECT_LE(0, event);
+
+	ret = wait_all_alert(fd, 2, objs, 123, event, &index);
+	EXPECT_EQ(0, ret);
+	EXPECT_EQ(0, index);
+
+	ret = wait_all_alert(fd, 2, objs, 123, event, &index);
+	EXPECT_EQ(0, ret);
+	EXPECT_EQ(2, index);
+
+	close(event);
+
+	/* test with an auto-reset event */
+
+	event_args.manual = false;
+	event_args.signaled = true;
+	event = ioctl(fd, NTSYNC_IOC_CREATE_EVENT, &event_args);
+	EXPECT_LE(0, event);
+
+	count = 2;
+	ret = release_sem(objs[1], &count);
+	EXPECT_EQ(0, ret);
+
+	ret = wait_all_alert(fd, 2, objs, 123, event, &index);
+	EXPECT_EQ(0, ret);
+	EXPECT_EQ(0, index);
+
+	ret = wait_all_alert(fd, 2, objs, 123, event, &index);
+	EXPECT_EQ(0, ret);
+	EXPECT_EQ(2, index);
+
+	ret = wait_all_alert(fd, 2, objs, 123, event, &index);
+	EXPECT_EQ(-1, ret);
+	EXPECT_EQ(ETIMEDOUT, errno);
+
+	close(event);
+
+	close(objs[0]);
+	close(objs[1]);
+
+	close(fd);
+}
+
 TEST_HARNESS_MAIN
-- 
2.45.2


