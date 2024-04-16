Return-Path: <linux-kselftest+bounces-8055-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8E878A5FC0
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 03:11:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58C3F1F21977
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 01:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CBEE1BF3F;
	Tue, 16 Apr 2024 01:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b="hySvHblp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.codeweavers.com (mail.codeweavers.com [4.36.192.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B465E79D1;
	Tue, 16 Apr 2024 01:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.36.192.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713229832; cv=none; b=RopWyq5DHYCCp3l0GA4YHYaQS1z//C4dOdUeSPc+mjBImmq8A03W+2lIw1yK5aQGodRXdSMrtmq5J1B9Yg8LqCz2WS85Mx3WPHH9T3xMve9ay/sslE3Jc13FnQre8/A+IZA85XR7U0iotRddWZhSdTf2+gyEupRrcIlDcySNsN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713229832; c=relaxed/simple;
	bh=UtZlrYh+PmJdbzwEPZ8FZ2UGM/54x6+dlq/Hl5BOk+Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C2r4hRU0S0YsUDxOZpUu8cMtQSu8G3OOKCT8/SD9MGkls/MZla4PiXAT5gIi43etFY8auJDB+LcrFcEYhNpS7VSjhTIl3yCoH4lM4+gOnTBgj3QzgHmWow8Q9W2kt+HhV6ie+x0dAJ+g6tdU1waED1tpWIQubcAZr6jBYePi6eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com; spf=pass smtp.mailfrom=codeweavers.com; dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b=hySvHblp; arc=none smtp.client-ip=4.36.192.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeweavers.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codeweavers.com; s=s1; h=Message-ID:Date:Subject:Cc:To:From:Sender;
	bh=LKcmPKdAjQdF3bbQtJTzkXMVlTzxEokxNER4gf+xieY=; b=hySvHblpRMEl9GI9osf7LnYeq3
	nDL0GI2AZ9eYKa182CeUrfDrr9LPKzfvDop4r1jyvKNMu1tJo0WhxVwXLk35FMaSfFNutNhfBrmYk
	wcKHbHgR2A4HSjISSbgzP9ePMA3eqNpwRgxZ2wXHfZo3VXVZjuHvOpmUJPwsHL4OSPNz9YHCrh5Zp
	iG/bp+C+wuLU8PS1/3IsTtrb+9gbUtq2W5+/MPvKnnZAfAZYNJ8+zCB/OwvIWcrGpYuOW5bAwTABe
	rvFNzz1pRtZe9P6ICRGBtQHNOAjgRRLSdejdqNH/bYBKUn9lUxrY3zbxw3+d8g6DxBCSZkaoNTsIK
	E4q+ngVA==;
Received: from cw137ip160.mn.codeweavers.com ([10.69.137.160] helo=camazotz.mn.codeweavers.com)
	by mail.codeweavers.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <zfigura@codeweavers.com>)
	id 1rwXL3-00FbQv-25;
	Mon, 15 Apr 2024 20:10:21 -0500
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
Subject: [PATCH v4 21/27] selftests: ntsync: Add some tests for auto-reset event state.
Date: Mon, 15 Apr 2024 20:08:31 -0500
Message-ID: <20240416010837.333694-22-zfigura@codeweavers.com>
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

Test event-specific ioctls NTSYNC_IOC_EVENT_SET, NTSYNC_IOC_EVENT_RESET,
NTSYNC_IOC_EVENT_PULSE, NTSYNC_IOC_EVENT_READ for auto-reset events, and
waiting on auto-reset events.

Signed-off-by: Elizabeth Figura <zfigura@codeweavers.com>
---
 .../testing/selftests/drivers/ntsync/ntsync.c | 59 +++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/tools/testing/selftests/drivers/ntsync/ntsync.c b/tools/testing/selftests/drivers/ntsync/ntsync.c
index b6481c2b85cc..12ccb4ec28e4 100644
--- a/tools/testing/selftests/drivers/ntsync/ntsync.c
+++ b/tools/testing/selftests/drivers/ntsync/ntsync.c
@@ -442,6 +442,65 @@ TEST(manual_event_state)
 	close(fd);
 }
 
+TEST(auto_event_state)
+{
+	struct ntsync_event_args event_args;
+	__u32 index, signaled;
+	int fd, event, ret;
+
+	fd = open("/dev/ntsync", O_CLOEXEC | O_RDONLY);
+	ASSERT_LE(0, fd);
+
+	event_args.manual = 0;
+	event_args.signaled = 1;
+	event_args.event = 0xdeadbeef;
+	ret = ioctl(fd, NTSYNC_IOC_CREATE_EVENT, &event_args);
+	EXPECT_EQ(0, ret);
+	EXPECT_NE(0xdeadbeef, event_args.event);
+	event = event_args.event;
+
+	check_event_state(event, 1, 0);
+
+	signaled = 0xdeadbeef;
+	ret = ioctl(event, NTSYNC_IOC_EVENT_SET, &signaled);
+	EXPECT_EQ(0, ret);
+	EXPECT_EQ(1, signaled);
+	check_event_state(event, 1, 0);
+
+	ret = wait_any(fd, 1, &event, 123, &index);
+	EXPECT_EQ(0, ret);
+	EXPECT_EQ(0, index);
+	check_event_state(event, 0, 0);
+
+	signaled = 0xdeadbeef;
+	ret = ioctl(event, NTSYNC_IOC_EVENT_RESET, &signaled);
+	EXPECT_EQ(0, ret);
+	EXPECT_EQ(0, signaled);
+	check_event_state(event, 0, 0);
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
+	check_event_state(event, 0, 0);
+
+	ret = ioctl(event, NTSYNC_IOC_EVENT_PULSE, &signaled);
+	EXPECT_EQ(0, ret);
+	EXPECT_EQ(0, signaled);
+	check_event_state(event, 0, 0);
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


