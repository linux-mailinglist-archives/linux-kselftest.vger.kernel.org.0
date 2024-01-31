Return-Path: <linux-kselftest+bounces-3796-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13C1F84335E
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jan 2024 03:16:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3B201F216BE
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jan 2024 02:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAB2C12B81;
	Wed, 31 Jan 2024 02:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b="CwZyaYJZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.codeweavers.com (mail.codeweavers.com [4.36.192.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E809A6122;
	Wed, 31 Jan 2024 02:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.36.192.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706667367; cv=none; b=L5RmoK+jTaDYlFWPBjaDuRgYSbbCPR7cCqLjy2urVF6VbkAYgnx+t+tvIMMKKG3lmP7Ly560lJ65neXSnI+zSZaOA+TXyQ24fENOv6XOSc+j1CJhlS39VX5H09tGL5ywcHDZF5BTMTHAaltWPKqbEW2J4m04slJLfTn0wTCTLek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706667367; c=relaxed/simple;
	bh=Vgourthv6+qc2f6oyg7IShZk7b3h5Z7yXed29bs8vsM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NZnYvSXMSVbdX+/1EdpqgGlY1W1J4p1jiTI7tIl42xftdfDXOBBPB77ShJYiV/kyhh2Qz93BkEQ2NJLlQheur9glWpcZ/PkBCq7UmnpeyAPdOvysS0qt3LvHCWeL9tkHcF6cXBJLmLzk3493VzFOFbgp1KUAm68tjdVN1HsrdDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com; spf=pass smtp.mailfrom=codeweavers.com; dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b=CwZyaYJZ; arc=none smtp.client-ip=4.36.192.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeweavers.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codeweavers.com; s=s1; h=Message-ID:Date:Subject:Cc:To:From:Sender;
	bh=CXWwJG7hNntB0Sd76fqEvUM4syQk+zNXqt/EdvXAsPg=; b=CwZyaYJZwv0NBwH/DzysGJa7rA
	uRt80Zx6X/t7Je1Gxk7iDd1Tp6f4CldiSS8liaCJqDNe7KTGFuk2pyRQBUWx2nAwEpiMCehgs9RRr
	mSqYT20YIiC8TDVKWZVeUGUWHUAqbvkJXeWNSMhmXf/5i9ctb3DYVMfUR+rc8/vhTYUcKmM9S6g56
	W7byiDlWKhekV12BlEg92o/cm6mMVRnbO0hYkOfwg//53ZBpyfEQw7w2Qb3ZIIpe3Fzr16n7cFpzD
	l+l5krjnkgu8FQiQTc2YYVWg0MUdZE/+Dh+atxcJEuRJAPVZZazcGI576NHRK2FwfGKy6gJWUTJvE
	7FbivdWg==;
Received: from cw137ip160.mn.codeweavers.com ([10.69.137.160] helo=camazotz.mn.codeweavers.com)
	by mail.codeweavers.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <zfigura@codeweavers.com>)
	id 1rV08q-0038Kv-1U;
	Tue, 30 Jan 2024 20:15:56 -0600
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
Subject: [RFC PATCH v2 24/29] selftests: ntsync: Add some tests for auto-reset event state.
Date: Tue, 30 Jan 2024 20:13:51 -0600
Message-ID: <20240131021356.10322-25-zfigura@codeweavers.com>
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

Test event-specific ioctls NTSYNC_IOC_EVENT_SET, NTSYNC_IOC_EVENT_RESET,
NTSYNC_IOC_EVENT_PULSE, NTSYNC_IOC_EVENT_READ for auto-reset events, and
waiting on auto-reset events.

Signed-off-by: Elizabeth Figura <zfigura@codeweavers.com>
---
 .../testing/selftests/drivers/ntsync/ntsync.c | 59 +++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/tools/testing/selftests/drivers/ntsync/ntsync.c b/tools/testing/selftests/drivers/ntsync/ntsync.c
index 98fc70a9a58b..f1fb28949367 100644
--- a/tools/testing/selftests/drivers/ntsync/ntsync.c
+++ b/tools/testing/selftests/drivers/ntsync/ntsync.c
@@ -421,6 +421,65 @@ TEST(manual_event_state)
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
 	struct ntsync_mutex_args mutex_args = {0};
-- 
2.43.0


