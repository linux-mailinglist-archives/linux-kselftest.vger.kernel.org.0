Return-Path: <linux-kselftest+bounces-23066-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 244FF9E9EBD
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Dec 2024 20:02:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED4FA281A76
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Dec 2024 19:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C513819ADBF;
	Mon,  9 Dec 2024 18:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b="IWLyhQ5n"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.codeweavers.com (mail.codeweavers.com [4.36.192.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2492C199E88;
	Mon,  9 Dec 2024 18:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.36.192.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733770778; cv=none; b=ZFR5p7/PiwEekO4keq+lTUC2cbaM/9+NqMNcNx/7kGZcaA1BJ3X/WP4pIOfNIYOqSw5rx6HNRjgeepWsEOe3IUFTw1tqO/uWUbkjK5jeFzhrATzQb/vu5BLLz/eyQ7dWIcv9FGsMX1Ds2h9SrawfFN2wDT2X/98O+TiZusRMqK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733770778; c=relaxed/simple;
	bh=gUeggPXQJGkMh6eRAwgiCm0iDKCVGgZZ6WmAgLMYBT0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kan3NjvkiqAzX4nLHJVq/7zwUeSP21cuHEceTXysetn2rJDj6mgHBG3Ghze8jIfXLggcHz7BgiSR4BW4R7e9CpINMk+JhbDW0UbjixYHKsIPzskcWyRFf8xmn55nOxrEfTfM1AOfw/ShsN9PSr/IbXUDAuKCwIgfbdeJgg7VSuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com; spf=pass smtp.mailfrom=codeweavers.com; dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b=IWLyhQ5n; arc=none smtp.client-ip=4.36.192.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeweavers.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codeweavers.com; s=s1; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=BUq+yFXfQFOO6nGetAGw328oHc106G/AysMITfp64g4=; b=IWLyhQ5n/+buKpKtbPXTWqJs87
	yXSyHwTVL8asCcAUabzsLUm/xXh2neKbANbMjGClu42pIbTzke4ShG2ihg5qvmaLBdy5GjdFlhis9
	3yRF3qbMBefp/LirQaQoHGXIkpEMBf8vb2SnZyC1iSHuocx9kTczw0dJDDZnH8ctKD0Q/H2IBIsIp
	VvURa04O0QlnPCeECyPZ1Du8LaBNefowMuAgm49qD8mpO/a+IZhabcW3vWP2D8hLpVpMZCk0OV+GA
	885jP2TST9XsPiHeSt8Ie8Q7WkUjIuugx6fVNgFHDW5lGvqV9gxVP2PUXd5ZBo/VVdOouXiVTkGTO
	BU0PjlcA==;
Received: from cw137ip160.mn.codeweavers.com ([10.69.137.160] helo=camazotz.mn.codeweavers.com)
	by mail.codeweavers.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <zfigura@codeweavers.com>)
	id 1tKiyj-001Gd5-37;
	Mon, 09 Dec 2024 12:59:34 -0600
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
Subject: [PATCH v6 20/28] selftests: ntsync: Add some tests for manual-reset event state.
Date: Mon,  9 Dec 2024 12:58:56 -0600
Message-ID: <20241209185904.507350-21-zfigura@codeweavers.com>
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
2.45.2


