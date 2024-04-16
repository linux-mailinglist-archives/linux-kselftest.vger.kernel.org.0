Return-Path: <linux-kselftest+bounces-8067-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF8498A5FEA
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 03:12:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 982A52843AE
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 01:12:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC8983A260;
	Tue, 16 Apr 2024 01:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b="Gn629HOn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.codeweavers.com (mail.codeweavers.com [4.36.192.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B23E3125AE;
	Tue, 16 Apr 2024 01:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.36.192.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713229833; cv=none; b=tgbzfN6RO/Y5YChnCaWcNpBllojsBMTQodJgMQEgxMacnv0kxJepwWi+yC3OPG/z7QD74WbmvAq6egpiOfDqtzXD7057CtbVPZZOIUDTFMrigQ1AXOpJL3D1cjGjgwBZAcqpSQj0anQQwq6mLlJnRbZsx0fBdD3QFk5jee6K/2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713229833; c=relaxed/simple;
	bh=5s4cbaXOZdhl8OxqDpewcvkpg1+2LrCYlh67RC1NKLk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=twztdJBC5Jgljmb0kkDe1m7rzt9j2+BVkv+AeXkDxtanl2RThjBT320lb2exEvngEtFrgacqAKScMf19VgImAdbPrapqhnagtpJ/b9upc+ITAsBdRRvh45vL8gmB268bgDlS71q2H7lQJ/4lpfN68vWUveAVFEDgX/YlH89gUiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com; spf=pass smtp.mailfrom=codeweavers.com; dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b=Gn629HOn; arc=none smtp.client-ip=4.36.192.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeweavers.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codeweavers.com; s=s1; h=Message-ID:Date:Subject:Cc:To:From:Sender;
	bh=aNMQ5WQ+qy6vOq9RLq84GZmYMjpbBBXHBNy41a5mB8g=; b=Gn629HOnn0B1qXq/ZyAzInKpQ6
	0/wk6LNwIPxWR8qEyMk1CxOO22Nz/dlYPxx0KOb/Y4J9HUpeMlQ1RFghDV9pIxj5hS94cTQzGwy1z
	zZRfkuZyMchN/4nATMJOGLGhxMvNqEqJf73Uq4/6+ledXfvzfaL5qF8AWx+qKPXeAGKTVZdBb/f12
	fZnOlGLLg46sjK84UmdHrvqsJOFsdhFW1UarNe8jVIZHCWvXsdOCL/PdegLBXWjpl0APJhtH77KOE
	9ya3WzXmH3RFtHeqjE5mB3nD/hLpttgtzL7PfA0tMhzDudVQCNsDZ6blr5B8E42Uja01TfP2fPU4x
	jquh2ktQ==;
Received: from cw137ip160.mn.codeweavers.com ([10.69.137.160] helo=camazotz.mn.codeweavers.com)
	by mail.codeweavers.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <zfigura@codeweavers.com>)
	id 1rwXL5-00FbQv-03;
	Mon, 15 Apr 2024 20:10:23 -0500
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
Subject: [PATCH v4 23/27] selftests: ntsync: Add tests for alertable waits.
Date: Mon, 15 Apr 2024 20:08:33 -0500
Message-ID: <20240416010837.333694-24-zfigura@codeweavers.com>
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


