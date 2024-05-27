Return-Path: <linux-kselftest+bounces-10701-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D66108CF6E4
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 May 2024 02:02:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7D891C20C32
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 May 2024 00:02:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CB92EDE;
	Mon, 27 May 2024 00:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="oZFZCESK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9CED2F43
	for <linux-kselftest@vger.kernel.org>; Mon, 27 May 2024 00:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716768172; cv=none; b=Y2CStziZGnBlFzEjW54/BIY9vCSw3ZsvY1LYdrh1NiLl6iz8EEWwQmnhgsAwt2vMXlWu6uaO/ZBOOUxGxLocG0NjJoX6HVU5MTzrXv1GrJ7mx4fELruJbEHLpK2bemuL78jnW8pCrZTdWR8ALAC9Iot8D33ZjUz/ustXWHcPa8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716768172; c=relaxed/simple;
	bh=5Z/IQ1AG0LSghMA4nafETdJADGNE+D470yXbhvbV++8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QfuzmxUMyzB7OPK6SkCwtPEolk2dxrvJ9ThpYzdCLcIkQEFWxkZ+k0bSYcqtqutndHGCbmfdZwB+hYVjts0j/XzcQkBEukxzlGp1u/Ru2/a06JoW09bre12xdtYAC5wVBlj+tzK+T7FSzt7SHR+GTe4qt/l7krxIc7WN68tbcLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=oZFZCESK; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: skhan@linuxfoundation.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1716768167;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=VjOimlkAb10m4KMSg1DOqlHJhsmFxHSlxPO0CJcAMP4=;
	b=oZFZCESKyh4srLsDKsx5WPsLeRrP/XrmvJbpNuyLg7+fLFuBjxhdK+JDw0N6j29Dr+ZBCF
	QGxoL82JDx2HkkQdJifXgoczMxUfnqPhW9YNUFGfkJLNW4w1z4GR4xJ6hPpMeLGOmSUO1l
	KndM+M6bjwFFkAM0ZuJTKax0jVq5f20=
X-Envelope-To: brauner@kernel.org
X-Envelope-To: akpm@linux-foundation.org
X-Envelope-To: wen.yang@linux.dev
X-Envelope-To: shuah@kernel.org
X-Envelope-To: avagin@google.com
X-Envelope-To: mathieu.desnoyers@efficios.com
X-Envelope-To: rostedt@goodmis.org
X-Envelope-To: dyoung@redhat.com
X-Envelope-To: tim.bird@sony.com
X-Envelope-To: linux-kselftest@vger.kernel.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
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
	Tim Bird <tim.bird@sony.com>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RESEDN PATCH v2] selftests: introduce additional eventfd test coverage
Date: Mon, 27 May 2024 08:02:00 +0800
Message-Id: <20240527000200.5615-1-wen.yang@linux.dev>
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
	#  RUN           global.eventfd_check_flag_rdwr ...
	#            OK  global.eventfd_check_flag_rdwr
	ok 1 global.eventfd_check_flag_rdwr
	#  RUN           global.eventfd_check_flag_cloexec ...
	#            OK  global.eventfd_check_flag_cloexec
	ok 2 global.eventfd_check_flag_cloexec
	#  RUN           global.eventfd_check_flag_nonblock ...
	#            OK  global.eventfd_check_flag_nonblock
	ok 3 global.eventfd_check_flag_nonblock
	#  RUN           global.eventfd_chek_flag_cloexec_and_nonblock ...
	#            OK  global.eventfd_chek_flag_cloexec_and_nonblock
	ok 4 global.eventfd_chek_flag_cloexec_and_nonblock
	#  RUN           global.eventfd_check_flag_semaphore ...
	#            OK  global.eventfd_check_flag_semaphore
	ok 5 global.eventfd_check_flag_semaphore
	#  RUN           global.eventfd_check_write ...
	#            OK  global.eventfd_check_write
	ok 6 global.eventfd_check_write
	#  RUN           global.eventfd_check_read ...
	#            OK  global.eventfd_check_read
	ok 7 global.eventfd_check_read
	#  RUN           global.eventfd_check_read_with_nonsemaphore ...
	#            OK  global.eventfd_check_read_with_nonsemaphore
	ok 8 global.eventfd_check_read_with_nonsemaphore
	#  RUN           global.eventfd_check_read_with_semaphore ...
	#            OK  global.eventfd_check_read_with_semaphore
	ok 9 global.eventfd_check_read_with_semaphore
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
Cc: Tim Bird <tim.bird@sony.com>
Cc: linux-kselftest@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
v2: use strings which indicate what is being tested, that are useful to a human

 .../filesystems/eventfd/eventfd_test.c        | 136 +++++++++++++++++-
 1 file changed, 131 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/filesystems/eventfd/eventfd_test.c b/tools/testing/selftests/filesystems/eventfd/eventfd_test.c
index f142a137526c..85acb4e3ef00 100644
--- a/tools/testing/selftests/filesystems/eventfd/eventfd_test.c
+++ b/tools/testing/selftests/filesystems/eventfd/eventfd_test.c
@@ -13,6 +13,8 @@
 #include <sys/eventfd.h>
 #include "../../kselftest_harness.h"
 
+#define EVENTFD_TEST_ITERATIONS 100000UL
+
 struct error {
 	int  code;
 	char msg[512];
@@ -40,7 +42,7 @@ static inline int sys_eventfd2(unsigned int count, int flags)
 	return syscall(__NR_eventfd2, count, flags);
 }
 
-TEST(eventfd01)
+TEST(eventfd_check_flag_rdwr)
 {
 	int fd, flags;
 
@@ -54,7 +56,7 @@ TEST(eventfd01)
 	close(fd);
 }
 
-TEST(eventfd02)
+TEST(eventfd_check_flag_cloexec)
 {
 	int fd, flags;
 
@@ -68,7 +70,7 @@ TEST(eventfd02)
 	close(fd);
 }
 
-TEST(eventfd03)
+TEST(eventfd_check_flag_nonblock)
 {
 	int fd, flags;
 
@@ -83,7 +85,7 @@ TEST(eventfd03)
 	close(fd);
 }
 
-TEST(eventfd04)
+TEST(eventfd_chek_flag_cloexec_and_nonblock)
 {
 	int fd, flags;
 
@@ -161,7 +163,7 @@ static int verify_fdinfo(int fd, struct error *err, const char *prefix,
 	return 0;
 }
 
-TEST(eventfd05)
+TEST(eventfd_check_flag_semaphore)
 {
 	struct error err = {0};
 	int fd, ret;
@@ -183,4 +185,128 @@ TEST(eventfd05)
 	close(fd);
 }
 
+/*
+ * A write(2) fails with the error EINVAL if the size of the supplied buffer
+ * is less than 8 bytes, or if an attempt is made to write the value
+ * 0xffffffffffffffff.
+ */
+TEST(eventfd_check_write)
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
+	size = write(fd, &value, sizeof(value));
+	EXPECT_EQ(size, sizeof(value));
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
+TEST(eventfd_check_read)
+{
+	uint64_t value;
+	ssize_t size;
+	int fd;
+
+	fd = sys_eventfd2(1, 0);
+	ASSERT_GE(fd, 0);
+
+	size = read(fd, &value, sizeof(int));
+	EXPECT_EQ(size, -1);
+	EXPECT_EQ(errno, EINVAL);
+
+	size = read(fd, &value, sizeof(value));
+	EXPECT_EQ(size, sizeof(value));
+	EXPECT_EQ(value, 1);
+
+	close(fd);
+}
+
+
+/*
+ * If EFD_SEMAPHORE was not specified and the eventfd counter has a nonzero
+ * value, then a read(2) returns 8 bytes containing that value, and the
+ * counter's value is reset to zero.
+ * If the eventfd counter is zero at the time of the call to read(2), then the
+ * call fails with the error EAGAIN if the file descriptor has been made nonblocking.
+ */
+TEST(eventfd_check_read_with_nonsemaphore)
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
+	for (i = 0; i < EVENTFD_TEST_ITERATIONS; i++) {
+		size = write(fd, &value, sizeof(value));
+		EXPECT_EQ(size, sizeof(value));
+	}
+
+	size = read(fd, &value, sizeof(value));
+	EXPECT_EQ(size, sizeof(uint64_t));
+	EXPECT_EQ(value, EVENTFD_TEST_ITERATIONS);
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
+TEST(eventfd_check_read_with_semaphore)
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
+	for (i = 0; i < EVENTFD_TEST_ITERATIONS; i++) {
+		size = write(fd, &value, sizeof(value));
+		EXPECT_EQ(size, sizeof(value));
+	}
+
+	for (i = 0; i < EVENTFD_TEST_ITERATIONS; i++) {
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


