Return-Path: <linux-kselftest+bounces-23069-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12EEC9E9ED8
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Dec 2024 20:03:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 729E316610A
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Dec 2024 19:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97F0A19F131;
	Mon,  9 Dec 2024 18:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b="Y+eA0Z+5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.codeweavers.com (mail.codeweavers.com [4.36.192.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AF8C19AD5C;
	Mon,  9 Dec 2024 18:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.36.192.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733770780; cv=none; b=MG0yGbFRot+lL3f/Il0FAebf+RAMnVbOZLCH91M97kxJjwvAoKoQ2HGEciUzMR5mlmHnwI4c3NE2rSn0yHXI63iQFqTMRwSKsZY7MwcAezXUXXQbZJBRN+3OcUvmWsycReaMfgV2Pnql2C/6/BBZzfpd2ba6FTSdE5BnfKSDaKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733770780; c=relaxed/simple;
	bh=reWkrE9+tNSvts+xEwfERx10CymuFOMyKdMi5FNpBiI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=crNdVFiSNXxfSpX9AHqmqB71wJ1k9vMObsXHQQUSyGRJvhn9h845IVB8vGduzOUtT/6H0rCKu3pXvYvah5oQvAx84pm43dzP6tnS5U+6NgzwAWsi6akkyPodrAKEaopEEuBuXyXKQqYZg6OY3PGejqyCUFP9x1Lq3WEbwREdjac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com; spf=pass smtp.mailfrom=codeweavers.com; dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b=Y+eA0Z+5; arc=none smtp.client-ip=4.36.192.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeweavers.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codeweavers.com; s=s1; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=/I9wdylc6MAvbvqkJ3X2n+g3DiuXUQW068q5UyJeaFc=; b=Y+eA0Z+5sO+j1SX9b+ABlkpv9b
	pATwPBOquN7PQVRNH0Nhq9mNF3Pp6oEOslHAcc3YtoipTE0IOK+jXX5xOQtS6oxkAayRPTX97M+Cm
	Yyxr27lYgwhbdurTiK2J8Zat6pcMPk7SBEhFenlx98WZDnVnIueZicn5mzUTPoPif0o5NPR6Hm+Zn
	lAFKU0PymtcE8XoTJFf0G6qIfrTvOnSIPPKljSHoE4H067mLwU9BZmMQskkDH9eEjZu1OExn1iwZS
	QMCSrg9AWuUTDxs4sFqMoy5zOvEfmWlwyUEwO23hkMgKeyLtQuncYbzkjNMvnfrZ9u4FicSh/1MUh
	m2Fl4kLA==;
Received: from cw137ip160.mn.codeweavers.com ([10.69.137.160] helo=camazotz.mn.codeweavers.com)
	by mail.codeweavers.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <zfigura@codeweavers.com>)
	id 1tKiym-001Gd5-0i;
	Mon, 09 Dec 2024 12:59:36 -0600
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
Subject: [PATCH v6 23/28] selftests: ntsync: Add tests for alertable waits.
Date: Mon,  9 Dec 2024 12:58:59 -0600
Message-ID: <20241209185904.507350-24-zfigura@codeweavers.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241209185904.507350-1-zfigura@codeweavers.com>
References: <20241209185904.507350-1-zfigura@codeweavers.com>
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
2.45.2


