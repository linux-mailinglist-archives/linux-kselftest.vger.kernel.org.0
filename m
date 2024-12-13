Return-Path: <linux-kselftest+bounces-23352-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D60D79F1650
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Dec 2024 20:39:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 892A8285D64
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Dec 2024 19:39:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 383691EF09E;
	Fri, 13 Dec 2024 19:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b="IQa3KVGa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.codeweavers.com (mail.codeweavers.com [4.36.192.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E216E1F4E4E;
	Fri, 13 Dec 2024 19:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.36.192.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734118554; cv=none; b=ZpFWStddwiof7ZYm06pLgYsqXbcPw8w4eEcu5316I7dB6XJGfSVf7mpCq7PkaP6KkuIdw981U5S4oTbHuPZHQwyq/UANwtDzOnNANjGmk5kABcrQILhGa/UaoUwkU7mololKzg+M+0lyqdnI7aDjzvHO6oseyZLarT3pZw4bGC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734118554; c=relaxed/simple;
	bh=zuj8MB1JrkSDmMF/gLRGiUKWLQ74Dg4HkDYszKYRNOw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T+3UPkhK6XjXSLz637W7ZJ/SwsKXFKCjYKftg0SZAays26s5UUqfQm17bKNejOq8EoKasbEiSoic2mHrYdZyMXjqtk63fkFwKE6qKbHVfxHa/nlUqsxl+QNgVbiaoCtK78pUn2l+ALHwuOS2OuK+1NP/hOoR4DEJN0q7oxdetWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com; spf=pass smtp.mailfrom=codeweavers.com; dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b=IQa3KVGa; arc=none smtp.client-ip=4.36.192.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeweavers.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codeweavers.com; s=s1; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=3gzClxPo0/T9ev9lcSYHivM4eEtKczg4M2RV46CaDxo=; b=IQa3KVGa8BRAEPDqzFqnqSRaPA
	nXMj3Uef8Zu2bXk9elCw7fbwPjUh58A0jE+1Fg7UtswD/3843Z98rCr5H1VlIMUNsiE8P8F5qeCXe
	y3n5/LzyN52IOJyl4j8RvsP6zjGf2CxyqHDz/DshZZb5znCnajuI1pHs5nmRce4hkztl99N869lPb
	PRUiQEZ1I1iq8iQRkpmbohpAj98NhBVx7fUtYVpckqNymMpp0Dy/HGHC7mEdUAfUX+6Si58ig24BT
	xqu/Wr7Q4YsUG/pg7i2UhpntFwGXee66YjAUjfaY9FNZZzikIhD5FdIl9CRgSklIgC8JOcL2JNh+S
	d0X4C6Pw==;
Received: from cw137ip160.mn.codeweavers.com ([10.69.137.160] helo=camazotz.mn.codeweavers.com)
	by mail.codeweavers.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <zfigura@codeweavers.com>)
	id 1tMBRz-00ASsZ-2P;
	Fri, 13 Dec 2024 13:35:47 -0600
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
Subject: [PATCH v7 16/30] selftests: ntsync: Add some tests for semaphore state.
Date: Fri, 13 Dec 2024 13:34:57 -0600
Message-ID: <20241213193511.457338-17-zfigura@codeweavers.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241213193511.457338-1-zfigura@codeweavers.com>
References: <20241213193511.457338-1-zfigura@codeweavers.com>
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
 .../testing/selftests/drivers/ntsync/ntsync.c | 145 ++++++++++++++++++
 5 files changed, 155 insertions(+)
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
index 000000000000..cc72da0a91de
--- /dev/null
+++ b/tools/testing/selftests/drivers/ntsync/ntsync.c
@@ -0,0 +1,145 @@
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
+static int release_sem(int sem, __u32 *count)
+{
+	return ioctl(sem, NTSYNC_IOC_SEM_RELEASE, count);
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
+	sem = ioctl(fd, NTSYNC_IOC_CREATE_SEM, &sem_args);
+	EXPECT_EQ(-1, sem);
+	EXPECT_EQ(EINVAL, errno);
+
+	sem_args.count = 2;
+	sem_args.max = 2;
+	sem = ioctl(fd, NTSYNC_IOC_CREATE_SEM, &sem_args);
+	EXPECT_LE(0, sem);
+	check_sem_state(sem, 2, 2);
+
+	count = 0;
+	ret = release_sem(sem, &count);
+	EXPECT_EQ(0, ret);
+	EXPECT_EQ(2, count);
+	check_sem_state(sem, 2, 2);
+
+	count = 1;
+	ret = release_sem(sem, &count);
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
+	ret = release_sem(sem, &count);
+	EXPECT_EQ(-1, ret);
+	EXPECT_EQ(EOVERFLOW, errno);
+	check_sem_state(sem, 0, 2);
+
+	count = 2;
+	ret = release_sem(sem, &count);
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
+	ret = release_sem(sem, &count);
+	EXPECT_EQ(0, ret);
+	EXPECT_EQ(0, count);
+	check_sem_state(sem, 1, 2);
+
+	count = ~0u;
+	ret = release_sem(sem, &count);
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


