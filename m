Return-Path: <linux-kselftest+bounces-23075-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B10409E9EF8
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Dec 2024 20:06:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96A04188A031
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Dec 2024 19:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E25C2187844;
	Mon,  9 Dec 2024 19:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b="l8BhUBw2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.codeweavers.com (mail.codeweavers.com [4.36.192.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D9E171E7C;
	Mon,  9 Dec 2024 19:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.36.192.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733770964; cv=none; b=phPf1p8dG3E1F1T6DRBZHtgRDnBkwLdMUibDsgIHbr+ez3emGbY1G111/zVcyVNmoB33bVojPwjejPkl5rhoF7j1p6OYe9dYXzBRc601EEs0aR096ObPvmU+PBziXXvcIuklYOS5erR9ER0h+qTJnp7yJa+2k244N9uTYlVwrWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733770964; c=relaxed/simple;
	bh=bCPu1ycb6CaEqcRe9eBfUowEMdbfE+OisPigVavxhC8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nVMVCr96zDhKyqHf8oXIP0NOaHTOfqI90i4NIG+W9vMi8GCQmifRSFYppdPb+HQh3DPTgKO/FdooCHVK2f+Mga5orDK6lcxIuC829KTy1YPqt3suUZcGCQ/hQCLv7Lty5tfhj4gJt0rggaQ+gJBp5YQZNBnJ2rYv89FdUzirVww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com; spf=pass smtp.mailfrom=codeweavers.com; dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b=l8BhUBw2; arc=none smtp.client-ip=4.36.192.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeweavers.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codeweavers.com; s=s1; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=x1ZwlxPQqB3lIRG8mseHmBWNLATzIEV5th7ltmFSSvM=; b=l8BhUBw295VHpPc80K3UUw4nHy
	5U+2+Yh+Cqff9cZyl9AqdrvJ+f6xggchVFYOTih6rbpSzAX/qWMfaLrPCVuz860mepIm9ijwUDkjS
	e6m5Gj9jz7siSY4rKyc5YuPPSje1ZIfvpysFwWdrj2Vkqrg8YN2z/kuZf6rTwc83b4k1oUldetDpk
	kdgUhMEWu2nZEZK99B8E0zRA/vYouL3u4rsBbwqflnGh2/4WEeKVJ1Cde98u12PJNpfhhhV+/UlTp
	DsKCGLIjH+OLDbwbHeZZ69t3lDVn5LDmHr7hPEVcrHnjwFPls5jdgJf5SRfde1wi1NWb+2Pho9KVz
	z7fPd4Ug==;
Received: from cw137ip160.mn.codeweavers.com ([10.69.137.160] helo=camazotz.mn.codeweavers.com)
	by mail.codeweavers.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <zfigura@codeweavers.com>)
	id 1tKiyb-001Gd5-1f;
	Mon, 09 Dec 2024 12:59:25 -0600
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
Subject: [PATCH v6 14/28] selftests: ntsync: Add some tests for semaphore state.
Date: Mon,  9 Dec 2024 12:58:50 -0600
Message-ID: <20241209185904.507350-15-zfigura@codeweavers.com>
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

Wine has tests for its synchronization primitives, but these are more accessible
to kernel developers, and also allow us to test some edge cases that Wine does
not care about.

This patch adds tests for semaphore-specific ioctls NTSYNC_IOC_SEM_POST and
NTSYNC_IOC_SEM_READ, and waiting on semaphores.

Signed-off-by: Elizabeth Figura <zfigura@codeweavers.com>
---
 tools/testing/selftests/Makefile              |   1 +
 .../selftests/drivers/ntsync/.gitignore       |   1 +
 .../testing/selftests/drivers/ntsync/Makefile |   7 +
 tools/testing/selftests/drivers/ntsync/config |   1 +
 .../testing/selftests/drivers/ntsync/ntsync.c | 149 ++++++++++++++++++
 5 files changed, 159 insertions(+)
 create mode 100644 tools/testing/selftests/drivers/ntsync/.gitignore
 create mode 100644 tools/testing/selftests/drivers/ntsync/Makefile
 create mode 100644 tools/testing/selftests/drivers/ntsync/config
 create mode 100644 tools/testing/selftests/drivers/ntsync/ntsync.c

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 2401e973c359..a8c9648e5adc 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -18,6 +18,7 @@ TARGETS += devices/error_logs
 TARGETS += devices/probe
 TARGETS += dmabuf-heaps
 TARGETS += drivers/dma-buf
+TARGETS += drivers/ntsync
 TARGETS += drivers/s390x/uvdevice
 TARGETS += drivers/net
 TARGETS += drivers/net/bonding
diff --git a/tools/testing/selftests/drivers/ntsync/.gitignore b/tools/testing/selftests/drivers/ntsync/.gitignore
new file mode 100644
index 000000000000..848573a3d3ea
--- /dev/null
+++ b/tools/testing/selftests/drivers/ntsync/.gitignore
@@ -0,0 +1 @@
+ntsync
diff --git a/tools/testing/selftests/drivers/ntsync/Makefile b/tools/testing/selftests/drivers/ntsync/Makefile
new file mode 100644
index 000000000000..dbf2b055c0b2
--- /dev/null
+++ b/tools/testing/selftests/drivers/ntsync/Makefile
@@ -0,0 +1,7 @@
+# SPDX-LICENSE-IDENTIFIER: GPL-2.0-only
+TEST_GEN_PROGS := ntsync
+
+CFLAGS += $(KHDR_INCLUDES)
+LDLIBS += -lpthread
+
+include ../../lib.mk
diff --git a/tools/testing/selftests/drivers/ntsync/config b/tools/testing/selftests/drivers/ntsync/config
new file mode 100644
index 000000000000..60539c826d06
--- /dev/null
+++ b/tools/testing/selftests/drivers/ntsync/config
@@ -0,0 +1 @@
+CONFIG_WINESYNC=y
diff --git a/tools/testing/selftests/drivers/ntsync/ntsync.c b/tools/testing/selftests/drivers/ntsync/ntsync.c
new file mode 100644
index 000000000000..1e145c6dfded
--- /dev/null
+++ b/tools/testing/selftests/drivers/ntsync/ntsync.c
@@ -0,0 +1,149 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Various unit tests for the "ntsync" synchronization primitive driver.
+ *
+ * Copyright (C) 2021-2022 Elizabeth Figura <zfigura@codeweavers.com>
+ */
+
+#define _GNU_SOURCE
+#include <sys/ioctl.h>
+#include <sys/stat.h>
+#include <fcntl.h>
+#include <time.h>
+#include <pthread.h>
+#include <linux/ntsync.h>
+#include "../../kselftest_harness.h"
+
+static int read_sem_state(int sem, __u32 *count, __u32 *max)
+{
+	struct ntsync_sem_args args;
+	int ret;
+
+	memset(&args, 0xcc, sizeof(args));
+	ret = ioctl(sem, NTSYNC_IOC_SEM_READ, &args);
+	*count = args.count;
+	*max = args.max;
+	return ret;
+}
+
+#define check_sem_state(sem, count, max) \
+	({ \
+		__u32 __count, __max; \
+		int ret = read_sem_state((sem), &__count, &__max); \
+		EXPECT_EQ(0, ret); \
+		EXPECT_EQ((count), __count); \
+		EXPECT_EQ((max), __max); \
+	})
+
+static int post_sem(int sem, __u32 *count)
+{
+	return ioctl(sem, NTSYNC_IOC_SEM_POST, count);
+}
+
+static int wait_any(int fd, __u32 count, const int *objs, __u32 owner, __u32 *index)
+{
+	struct ntsync_wait_args args = {0};
+	struct timespec timeout;
+	int ret;
+
+	clock_gettime(CLOCK_MONOTONIC, &timeout);
+
+	args.timeout = timeout.tv_sec * 1000000000 + timeout.tv_nsec;
+	args.count = count;
+	args.objs = (uintptr_t)objs;
+	args.owner = owner;
+	args.index = 0xdeadbeef;
+	ret = ioctl(fd, NTSYNC_IOC_WAIT_ANY, &args);
+	*index = args.index;
+	return ret;
+}
+
+TEST(semaphore_state)
+{
+	struct ntsync_sem_args sem_args;
+	struct timespec timeout;
+	__u32 count, index;
+	int fd, ret, sem;
+
+	clock_gettime(CLOCK_MONOTONIC, &timeout);
+
+	fd = open("/dev/ntsync", O_CLOEXEC | O_RDONLY);
+	ASSERT_LE(0, fd);
+
+	sem_args.count = 3;
+	sem_args.max = 2;
+	sem_args.sem = 0xdeadbeef;
+	ret = ioctl(fd, NTSYNC_IOC_CREATE_SEM, &sem_args);
+	EXPECT_EQ(-1, ret);
+	EXPECT_EQ(EINVAL, errno);
+
+	sem_args.count = 2;
+	sem_args.max = 2;
+	sem_args.sem = 0xdeadbeef;
+	ret = ioctl(fd, NTSYNC_IOC_CREATE_SEM, &sem_args);
+	EXPECT_EQ(0, ret);
+	EXPECT_NE(0xdeadbeef, sem_args.sem);
+	sem = sem_args.sem;
+	check_sem_state(sem, 2, 2);
+
+	count = 0;
+	ret = post_sem(sem, &count);
+	EXPECT_EQ(0, ret);
+	EXPECT_EQ(2, count);
+	check_sem_state(sem, 2, 2);
+
+	count = 1;
+	ret = post_sem(sem, &count);
+	EXPECT_EQ(-1, ret);
+	EXPECT_EQ(EOVERFLOW, errno);
+	check_sem_state(sem, 2, 2);
+
+	ret = wait_any(fd, 1, &sem, 123, &index);
+	EXPECT_EQ(0, ret);
+	EXPECT_EQ(0, index);
+	check_sem_state(sem, 1, 2);
+
+	ret = wait_any(fd, 1, &sem, 123, &index);
+	EXPECT_EQ(0, ret);
+	EXPECT_EQ(0, index);
+	check_sem_state(sem, 0, 2);
+
+	ret = wait_any(fd, 1, &sem, 123, &index);
+	EXPECT_EQ(-1, ret);
+	EXPECT_EQ(ETIMEDOUT, errno);
+
+	count = 3;
+	ret = post_sem(sem, &count);
+	EXPECT_EQ(-1, ret);
+	EXPECT_EQ(EOVERFLOW, errno);
+	check_sem_state(sem, 0, 2);
+
+	count = 2;
+	ret = post_sem(sem, &count);
+	EXPECT_EQ(0, ret);
+	EXPECT_EQ(0, count);
+	check_sem_state(sem, 2, 2);
+
+	ret = wait_any(fd, 1, &sem, 123, &index);
+	EXPECT_EQ(0, ret);
+	ret = wait_any(fd, 1, &sem, 123, &index);
+	EXPECT_EQ(0, ret);
+
+	count = 1;
+	ret = post_sem(sem, &count);
+	EXPECT_EQ(0, ret);
+	EXPECT_EQ(0, count);
+	check_sem_state(sem, 1, 2);
+
+	count = ~0u;
+	ret = post_sem(sem, &count);
+	EXPECT_EQ(-1, ret);
+	EXPECT_EQ(EOVERFLOW, errno);
+	check_sem_state(sem, 1, 2);
+
+	close(sem);
+
+	close(fd);
+}
+
+TEST_HARNESS_MAIN
-- 
2.45.2


