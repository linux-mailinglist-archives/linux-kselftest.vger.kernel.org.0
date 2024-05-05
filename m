Return-Path: <linux-kselftest+bounces-9478-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 93E3B8BC17D
	for <lists+linux-kselftest@lfdr.de>; Sun,  5 May 2024 16:47:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00A821F210D3
	for <lists+linux-kselftest@lfdr.de>; Sun,  5 May 2024 14:47:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B2AA2BAF6;
	Sun,  5 May 2024 14:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="iFEnMqQm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1B9328E0F
	for <linux-kselftest@vger.kernel.org>; Sun,  5 May 2024 14:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714920475; cv=none; b=VEFNTX1ksAUvYvAcMHwm1yQ4EWsaEdBSkhNkJLfqWTwo0O0fVlZ0wAPBTSDV/vnUC3ptgcpKr+yjFutJv1Cgk+mezRKp+Kznb3+HISi95sZZ/8j4wlF+MvrT1JO1GhEsKUKcKbrW6Ltj8quD/6eIkw+AId34D2RC98R+vPCZzHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714920475; c=relaxed/simple;
	bh=+DMiNVd2HWVjgTdx5Fs3V5Te9zWFm2HRZEQM0YLCGlA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eSCm3vAVZQVrSAOiXvLgBnmZJyQZlWIl4p7u9MADoeJb/jUgLAMNZbOpt35JATnFq8LYyUSKpzS9Y5K1gy4VMpMQZSqEHKkstq+8J0JwN61D8Td88KvUykMawKtAnDWm1ffiOa3WQMqZsKOn4LVekinUsLh2csDrG5JWZwZOZuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=iFEnMqQm; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1714920470;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Tc3YJvIL7QGAQVhuutxmpEra90eyjyBh3d8zSxBAx9g=;
	b=iFEnMqQmdLFQwks9/CHAVbqQsE3uozNnXX+wc0pTfsp+AbLhkvabZEi2VqdUweAskLrUgg
	XJI2ZsFeSlzVr5U135rs4dwbxcnRBVGlFq2PSK9QZ3cXIa9o9e8D3oXwo6muaKHbthnHMH
	wfplZR91tw1UTxws3hA4hbxEPoomET0=
From: Wen Yang <wen.yang@linux.dev>
To: Shuah Khan <skhan@linuxfoundation.org>,
	Christian Brauner <brauner@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Wen Yang <wen.yang@linux.dev>,
	SShuah Khan <shuah@kernel.org>,
	Andrei Vagin <avagin@google.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Dave Young <dyoung@redhat.com>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] selftests: introduce additional eventfd test coverage
Date: Sun,  5 May 2024 22:46:48 +0800
Message-Id: <20240505144648.18347-1-wen.yang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Add several new test cases which assert corner cases on the eventfd
mechanism, for example, the supplied buffer is less than 8 bytes,
attempting to write a value that is too large, etc.

	./eventfd_test
	# Starting 9 tests from 1 test cases.
	#  RUN           global.eventfd01 ...
	#            OK  global.eventfd01
	ok 1 global.eventfd01
	#  RUN           global.eventfd02 ...
	#            OK  global.eventfd02
	ok 2 global.eventfd02
	#  RUN           global.eventfd03 ...
	#            OK  global.eventfd03
	ok 3 global.eventfd03
	#  RUN           global.eventfd04 ...
	#            OK  global.eventfd04
	ok 4 global.eventfd04
	#  RUN           global.eventfd05 ...
	#            OK  global.eventfd05
	ok 5 global.eventfd05
	#  RUN           global.eventfd06 ...
	#            OK  global.eventfd06
	ok 6 global.eventfd06
	#  RUN           global.eventfd07 ...
	#            OK  global.eventfd07
	ok 7 global.eventfd07
	#  RUN           global.eventfd08 ...
	#            OK  global.eventfd08
	ok 8 global.eventfd08
	#  RUN           global.eventfd09 ...
	#            OK  global.eventfd09
	ok 9 global.eventfd09
	# PASSED: 9 / 9 tests passed.
	# Totals: pass:9 fail:0 xfail:0 xpass:0 skip:0 error:0

Signed-off-by: Wen Yang <wen.yang@linux.dev>
Cc: SShuah Khan <shuah@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Andrei Vagin <avagin@google.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Dave Young <dyoung@redhat.com>
Cc: linux-kselftest@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 .../filesystems/eventfd/eventfd_test.c        | 116 ++++++++++++++++++
 1 file changed, 116 insertions(+)

diff --git a/tools/testing/selftests/filesystems/eventfd/eventfd_test.c b/tools/testing/selftests/filesystems/eventfd/eventfd_test.c
index f142a137526c..eeab8df5b1b5 100644
--- a/tools/testing/selftests/filesystems/eventfd/eventfd_test.c
+++ b/tools/testing/selftests/filesystems/eventfd/eventfd_test.c
@@ -183,4 +183,120 @@ TEST(eventfd05)
 	close(fd);
 }
 
+/*
+ * A write(2) fails with the error EINVAL if the size of the supplied buffer
+ * is less than 8 bytes, or if an attempt is made to write the value
+ * 0xffffffffffffffff.
+ */
+TEST(eventfd06)
+{
+	uint64_t value = 1;
+	ssize_t size;
+	int fd;
+
+	fd = sys_eventfd2(0, 0);
+	ASSERT_GE(fd, 0);
+
+	size = write(fd, &value, sizeof(int));
+	EXPECT_EQ(size, -1);
+	EXPECT_EQ(errno, EINVAL);
+
+	value = (uint64_t)-1;
+	size = write(fd, &value, sizeof(value));
+	EXPECT_EQ(size, -1);
+	EXPECT_EQ(errno, EINVAL);
+
+	close(fd);
+}
+
+/*
+ * A read(2) fails with the error EINVAL if the size of the supplied buffer is
+ * less than 8 bytes.
+ */
+TEST(eventfd07)
+{
+	int value = 0;
+	ssize_t size;
+	int fd;
+
+	fd = sys_eventfd2(0, 0);
+	ASSERT_GE(fd, 0);
+
+	size = write(fd, &value, sizeof(value));
+	EXPECT_EQ(size, -1);
+	EXPECT_EQ(errno, EINVAL);
+
+	close(fd);
+}
+
+/*
+ * If EFD_SEMAPHORE was not specified and the eventfd counter has a nonzero
+ * value, then a read(2) returns 8 bytes containing that value, and the
+ * counter's value is reset to zero.
+ * If the eventfd counter is zero at the time of the call to read(2), then the
+ * call fails with the error EAGAIN if the file descriptor has been made nonblocking.
+ */
+TEST(eventfd08)
+{
+	uint64_t value;
+	ssize_t size;
+	int fd;
+	int i;
+
+	fd = sys_eventfd2(0, EFD_NONBLOCK);
+	ASSERT_GE(fd, 0);
+
+	value = 1;
+	for (i = 0; i < 10000000; i++) {
+		size = write(fd, &value, sizeof(value));
+		EXPECT_EQ(size, sizeof(value));
+	}
+
+	size = read(fd, &value, sizeof(value));
+	EXPECT_EQ(size, sizeof(uint64_t));
+	EXPECT_EQ(value, 10000000);
+
+	size = read(fd, &value, sizeof(value));
+	EXPECT_EQ(size, -1);
+	EXPECT_EQ(errno, EAGAIN);
+
+	close(fd);
+}
+
+/*
+ * If EFD_SEMAPHORE was specified and the eventfd counter has a nonzero value,
+ * then a read(2) returns 8 bytes containing the value 1, and the counter's
+ * value is decremented by 1.
+ * If the eventfd counter is zero at the time of the call to read(2), then the
+ * call fails with the error EAGAIN if the file descriptor has been made nonblocking.
+ */
+TEST(eventfd09)
+{
+	uint64_t value;
+	ssize_t size;
+	int fd;
+	int i;
+
+	fd = sys_eventfd2(0, EFD_SEMAPHORE|EFD_NONBLOCK);
+	ASSERT_GE(fd, 0);
+
+	value = 1;
+	for (i = 0; i < 10000000; i++) {
+		size = write(fd, &value, sizeof(value));
+		EXPECT_EQ(size, sizeof(value));
+	}
+
+	for (i = 0; i < 10000000; i++) {
+		size = read(fd, &value, sizeof(value));
+		EXPECT_EQ(size, sizeof(value));
+		EXPECT_EQ(value, 1);
+	}
+
+	size = read(fd, &value, sizeof(value));
+	EXPECT_EQ(size, -1);
+	EXPECT_EQ(errno, EAGAIN);
+
+	close(fd);
+}
+
 TEST_HARNESS_MAIN
-- 
2.25.1


