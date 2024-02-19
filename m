Return-Path: <linux-kselftest+bounces-4969-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25F3785AEE7
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Feb 2024 23:40:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D60E62810A2
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Feb 2024 22:40:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F291159B76;
	Mon, 19 Feb 2024 22:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b="PFjbysXD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.codeweavers.com (mail.codeweavers.com [4.36.192.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A42B56774;
	Mon, 19 Feb 2024 22:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.36.192.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708382381; cv=none; b=c52F/c3Q0M/IGcxoF/sumZ1SjDOZ9s9zefq9QLpNzu4o+47VkStUJR2INA9sIw+o278PYyfkGjdVvaBdiXedXgh57AXB27mniKCA4ZXaN2/3f6faznNaNH86HD9RE5de/XEVdPHhKw6e6m7OAeeveSeDvsEmEg4NyW4n/H5nX6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708382381; c=relaxed/simple;
	bh=L8d9LKUtIlHbbP7cxUNXa7f8ALBrZ7EKpjsLi7r052M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nJidxJYSQag4ZXU1JFaGdeS7j4GiSffGxGfgYID14YVDDUCbT590cn05B82jG2sAHVmgNeEeUP/scd8eQGIXf5laHJ9APBFYtT9zhx4oVz2gWthWcXGcxNCmonUEIgEfK4pB/o0Yh9AyL21fuDZ+7UTMFV1M7XSOoCbfcXc1+9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com; spf=pass smtp.mailfrom=codeweavers.com; dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b=PFjbysXD; arc=none smtp.client-ip=4.36.192.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeweavers.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codeweavers.com; s=s1; h=Message-ID:Date:Subject:Cc:To:From:Sender;
	bh=Y95uioGAPMdZZ0cAwPbXEkD4hHbWG+8pblZmeRY+GjA=; b=PFjbysXDP3Sh5p/o7yi0bgUjsT
	1RPZfHZV7+Qqg/X4YPek7i5/IcapvYKOMHsE3fU6ddZ938DmiVnOCd6hKCeQTdeQjveqJoEwncnRH
	gTv5pdDrCI18aXO+nRlUYBDJZoivDYWAo3gQ3TM3RPZv4/4uot76bIOuqWecdL5C0e1zsb9wWynwS
	G8J/pHmHMcs5pTP+67Wm06KND/Cv9f3ZOM67NGV1ZKfOtiLuaK+0z7jClIhhD4Dj7D3sIjbNGmy+L
	ocN7CVCTxzowEy2QNvccR3QiyHjfMcIBhOy06Qbb4uZmFSe1n3ZkK2UGgz3lhHG6CeisPoEaEJ1ZC
	4IHCZehg==;
Received: from cw137ip160.mn.codeweavers.com ([10.69.137.160] helo=camazotz.mn.codeweavers.com)
	by mail.codeweavers.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <zfigura@codeweavers.com>)
	id 1rcCIR-0037Oz-3B;
	Mon, 19 Feb 2024 16:39:36 -0600
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
Subject: [PATCH v2 24/31] selftests: ntsync: Add some tests for manual-reset event state.
Date: Mon, 19 Feb 2024 16:38:26 -0600
Message-ID: <20240219223833.95710-25-zfigura@codeweavers.com>
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

Test event-specific ioctls NTSYNC_IOC_EVENT_SET, NTSYNC_IOC_EVENT_RESET,
NTSYNC_IOC_EVENT_PULSE, NTSYNC_IOC_EVENT_READ for manual-reset events, and
waiting on manual-reset events.

Signed-off-by: Elizabeth Figura <zfigura@codeweavers.com>
---
 .../testing/selftests/drivers/ntsync/ntsync.c | 89 +++++++++++++++++++
 1 file changed, 89 insertions(+)

diff --git a/tools/testing/selftests/drivers/ntsync/ntsync.c b/tools/testing/selftests/drivers/ntsync/ntsync.c
index b77fb0b2c4b1..b6481c2b85cc 100644
--- a/tools/testing/selftests/drivers/ntsync/ntsync.c
+++ b/tools/testing/selftests/drivers/ntsync/ntsync.c
@@ -73,6 +73,27 @@ static int unlock_mutex(int mutex, __u32 owner, __u32 *count)
 	return ret;
 }
 
+static int read_event_state(int event, __u32 *signaled, __u32 *manual)
+{
+	struct ntsync_event_args args;
+	int ret;
+
+	memset(&args, 0xcc, sizeof(args));
+	ret = ioctl(event, NTSYNC_IOC_EVENT_READ, &args);
+	*signaled = args.signaled;
+	*manual = args.manual;
+	return ret;
+}
+
+#define check_event_state(event, signaled, manual) \
+	({ \
+		__u32 __signaled, __manual; \
+		int ret = read_event_state((event), &__signaled, &__manual); \
+		EXPECT_EQ(0, ret); \
+		EXPECT_EQ((signaled), __signaled); \
+		EXPECT_EQ((manual), __manual); \
+	})
+
 static int wait_objs(int fd, unsigned long request, __u32 count,
 		     const int *objs, __u32 owner, __u32 *index)
 {
@@ -353,6 +374,74 @@ TEST(mutex_state)
 	close(fd);
 }
 
+TEST(manual_event_state)
+{
+	struct ntsync_event_args event_args;
+	__u32 index, signaled;
+	int fd, event, ret;
+
+	fd = open("/dev/ntsync", O_CLOEXEC | O_RDONLY);
+	ASSERT_LE(0, fd);
+
+	event_args.manual = 1;
+	event_args.signaled = 0;
+	event_args.event = 0xdeadbeef;
+	ret = ioctl(fd, NTSYNC_IOC_CREATE_EVENT, &event_args);
+	EXPECT_EQ(0, ret);
+	EXPECT_NE(0xdeadbeef, event_args.event);
+	event = event_args.event;
+	check_event_state(event, 0, 1);
+
+	signaled = 0xdeadbeef;
+	ret = ioctl(event, NTSYNC_IOC_EVENT_SET, &signaled);
+	EXPECT_EQ(0, ret);
+	EXPECT_EQ(0, signaled);
+	check_event_state(event, 1, 1);
+
+	ret = ioctl(event, NTSYNC_IOC_EVENT_SET, &signaled);
+	EXPECT_EQ(0, ret);
+	EXPECT_EQ(1, signaled);
+	check_event_state(event, 1, 1);
+
+	ret = wait_any(fd, 1, &event, 123, &index);
+	EXPECT_EQ(0, ret);
+	EXPECT_EQ(0, index);
+	check_event_state(event, 1, 1);
+
+	signaled = 0xdeadbeef;
+	ret = ioctl(event, NTSYNC_IOC_EVENT_RESET, &signaled);
+	EXPECT_EQ(0, ret);
+	EXPECT_EQ(1, signaled);
+	check_event_state(event, 0, 1);
+
+	ret = ioctl(event, NTSYNC_IOC_EVENT_RESET, &signaled);
+	EXPECT_EQ(0, ret);
+	EXPECT_EQ(0, signaled);
+	check_event_state(event, 0, 1);
+
+	ret = wait_any(fd, 1, &event, 123, &index);
+	EXPECT_EQ(-1, ret);
+	EXPECT_EQ(ETIMEDOUT, errno);
+
+	ret = ioctl(event, NTSYNC_IOC_EVENT_SET, &signaled);
+	EXPECT_EQ(0, ret);
+	EXPECT_EQ(0, signaled);
+
+	ret = ioctl(event, NTSYNC_IOC_EVENT_PULSE, &signaled);
+	EXPECT_EQ(0, ret);
+	EXPECT_EQ(1, signaled);
+	check_event_state(event, 0, 1);
+
+	ret = ioctl(event, NTSYNC_IOC_EVENT_PULSE, &signaled);
+	EXPECT_EQ(0, ret);
+	EXPECT_EQ(0, signaled);
+	check_event_state(event, 0, 1);
+
+	close(event);
+
+	close(fd);
+}
+
 TEST(test_wait_any)
 {
 	int objs[NTSYNC_MAX_WAIT_COUNT + 1], fd, ret;
-- 
2.43.0


