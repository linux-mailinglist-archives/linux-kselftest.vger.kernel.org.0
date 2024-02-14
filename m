Return-Path: <linux-kselftest+bounces-4697-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F09248557CD
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Feb 2024 00:57:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 659CB1F21C1D
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Feb 2024 23:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1507114A0AC;
	Wed, 14 Feb 2024 23:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b="DDp5FE3o"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.codeweavers.com (mail.codeweavers.com [4.36.192.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 480E6149002;
	Wed, 14 Feb 2024 23:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.36.192.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707954821; cv=none; b=ocEg8Uo8aFYXsxeNfxsrPMkZRxSooRXZ8xKrvBIUF4z2aaMgroRCqPWFd6PpHPKuI+dQ3W8nT0ZDZgpuCPaTow1uD4nzDSZL0ecHZd7uVVRtAM6ajgvZDqWUHGGH7HjZ4GruNjI90Xib22DOPNJy6aUuoJuCqep/hU4dGk73tJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707954821; c=relaxed/simple;
	bh=IfixxKNJpM8gkNQfWVNaov+nAOCyAZDzOSFlHY+kX5o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=igIuinKHAXi66W6z/jTCHCx+RzV3bC8FcWVlrppGCjt/olLlLp+Ow1hJZ05N7vGqvc23hhinuMHrbAePEkQgNb711+sZCCjzzhk7ccaVVqVpa62aY7jrUehg+wpfg/2W5dnGAL8InkwIb/P+H9qffSHhos5IVWep4UvDfIY7LZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com; spf=pass smtp.mailfrom=codeweavers.com; dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b=DDp5FE3o; arc=none smtp.client-ip=4.36.192.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeweavers.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codeweavers.com; s=s1; h=Message-ID:Date:Subject:Cc:To:From:Sender;
	bh=4od/v8Sb5ySlWmB6E/7HZUJ+/S4RiseN4NnQ8umsq34=; b=DDp5FE3o7p3y6JV4DNpxXbXhIM
	IbrLkgEN/ha293LYaOEMs5avpSQ+ZRLspXG85YREiP2LeCPHWeuiwWfzc4b9r0Sm9MdY4YxLDbf3Q
	dLIO/+ffuT2Kwp7WvDmPcO6/wlVv4d9kj3pmGA42x1NKoL+1h69QCPSbDKvS8uW6zOEvmudTSb3UM
	OWy2LrUNMmdKkLn29H7Y9KLfL0TldNIz5wt7nQ7rGslP1b2xOorL6OtjXNicD8sI7i3mr2nyOOLCG
	RWNar0lUf7u1JRM8ksWhpXtd7MwAHd9PnFBe+0fw+RTz73ftkI0UARDJkC5Y54hTjV17LUeIL8s18
	FMFfq/3g==;
Received: from cw137ip160.mn.codeweavers.com ([10.69.137.160] helo=camazotz.mn.codeweavers.com)
	by mail.codeweavers.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <zfigura@codeweavers.com>)
	id 1raP4I-00GcSK-2k;
	Wed, 14 Feb 2024 17:53:35 -0600
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
Subject: [PATCH 18/31] selftests: ntsync: Add some tests for semaphore state.
Date: Wed, 14 Feb 2024 17:52:53 -0600
Message-ID: <20240214235307.10494-9-zfigura@codeweavers.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240214235307.10494-1-zfigura@codeweavers.com>
References: <20240214233645.9273-1-zfigura@codeweavers.com>
 <20240214235307.10494-1-zfigura@codeweavers.com>
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
 .../testing/selftests/drivers/ntsync/Makefile |   8 +
 tools/testing/selftests/drivers/ntsync/config |   1 +
 .../testing/selftests/drivers/ntsync/ntsync.c | 149 ++++++++++++++++++
 4 files changed, 159 insertions(+)
 create mode 100644 tools/testing/selftests/drivers/ntsync/Makefile
 create mode 100644 tools/testing/selftests/drivers/ntsync/config
 create mode 100644 tools/testing/selftests/drivers/ntsync/ntsync.c

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 15b6a111c3be..6c714a4e6478 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -15,6 +15,7 @@ TARGETS += cpu-hotplug
 TARGETS += damon
 TARGETS += dmabuf-heaps
 TARGETS += drivers/dma-buf
+TARGETS += drivers/ntsync
 TARGETS += drivers/s390x/uvdevice
 TARGETS += drivers/net/bonding
 TARGETS += drivers/net/team
diff --git a/tools/testing/selftests/drivers/ntsync/Makefile b/tools/testing/selftests/drivers/ntsync/Makefile
new file mode 100644
index 000000000000..a34da5ccacf0
--- /dev/null
+++ b/tools/testing/selftests/drivers/ntsync/Makefile
@@ -0,0 +1,8 @@
+# SPDX-LICENSE-IDENTIFIER: GPL-2.0-only
+TEST_GEN_PROGS := ntsync
+
+top_srcdir =../../../../..
+CFLAGS += -I$(top_srcdir)/usr/include
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
index 000000000000..bda88233b427
--- /dev/null
+++ b/tools/testing/selftests/drivers/ntsync/ntsync.c
@@ -0,0 +1,149 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Various unit tests for the "ntsync" synchronization primitive driver.
+ *
+ * Copyright (C) 2021-2022 Elizabeth Figura
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
2.43.0


