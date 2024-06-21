Return-Path: <linux-kselftest+bounces-12466-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4649F912E62
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Jun 2024 22:16:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F09E6287236
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Jun 2024 20:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A921417C232;
	Fri, 21 Jun 2024 20:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="Nm6kfZ/j"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-fw-52005.amazon.com (smtp-fw-52005.amazon.com [52.119.213.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CCCB16D311;
	Fri, 21 Jun 2024 20:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719000922; cv=none; b=lethpbN2NUNAaE6GLW4SDIwRH1WkUc118aNLIQUxCJyCmeEoykXX1TPKJRrXY6KDJD+rhO5pMHw3VLq8fC97M2JJGondM/NGwd9EK6JuQbt+LcjaNruzshpxxTFVGg6lx1KOIkA+Cm+mtKl5Dgzqpa38drUfjNt7kPYbKO6fX18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719000922; c=relaxed/simple;
	bh=c88Ywy58K/KuqHj5NVN3P5Jrqm0HrhAHu/HKkuonWgc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h0OwfpjmYpN0IttqxREOVYyiGv3xOn6s1GLCiZh0tULgkINUarRMEF2P4WUIrHRFnIGp/iaYER6eixLl8Jwkt4GVeP4V2+L1lPqwUOofPslcKJYt4LXh5+Gh7SjpOJ5h2I8Zu89Oo7+SjnYVmgLbr9WvKnDZrddYbue8PPCtG3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b=Nm6kfZ/j; arc=none smtp.client-ip=52.119.213.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1719000921; x=1750536921;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sakrS84DsySzhYnlE0QEvKaSeb66y1GOVt2jX6UWYYE=;
  b=Nm6kfZ/jQfRrIhIKYdA8xo95N2zt3AzXvwPNQRoJhpk1GQz6p7/yY4OE
   67cMSOBOeX9Tb8V5HsjGlrabUCyHmpYMsjdnqPL5tnf1ok89OIWHI/DfK
   IcS0LS4pZb7lKdzo7TFnhag3p0w360lkbHby+1jiKtE2c6uVBC8zsWOj8
   s=;
X-IronPort-AV: E=Sophos;i="6.08,255,1712620800"; 
   d="scan'208";a="662205944"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52005.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2024 20:15:18 +0000
Received: from EX19MTAUEB002.ant.amazon.com [10.0.0.204:44808]
 by smtpin.naws.us-east-1.prod.farcaster.email.amazon.dev [10.0.94.206:2525] with esmtp (Farcaster)
 id 07fadb7d-beb5-4264-a68d-b24ca92dbe93; Fri, 21 Jun 2024 20:15:17 +0000 (UTC)
X-Farcaster-Flow-ID: 07fadb7d-beb5-4264-a68d-b24ca92dbe93
Received: from EX19D008UEA002.ant.amazon.com (10.252.134.125) by
 EX19MTAUEB002.ant.amazon.com (10.252.135.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Fri, 21 Jun 2024 20:15:12 +0000
Received: from EX19MTAUEA001.ant.amazon.com (10.252.134.203) by
 EX19D008UEA002.ant.amazon.com (10.252.134.125) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Fri, 21 Jun 2024 20:15:11 +0000
Received: from u40bc5e070a0153.ant.amazon.com (10.95.134.31) by
 mail-relay.amazon.com (10.252.134.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34 via Frontend Transport; Fri, 21 Jun 2024 20:15:10 +0000
From: Roman Kagan <rkagan@amazon.de>
To: <linux-kernel@vger.kernel.org>
CC: Shuah Khan <shuah@kernel.org>, Dragan Cvetic <dragan.cvetic@amd.com>,
	Fares Mehanna <faresx@amazon.de>, Alexander Graf <graf@amazon.de>, "Derek
 Kiernan" <derek.kiernan@amd.com>, <linux-kselftest@vger.kernel.org>,
	<nh-open-source@amazon.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	<linux-mm@kvack.org>, David Woodhouse <dwmw@amazon.co.uk>, Andrew Morton
	<akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH RFC 3/3] drivers/misc: add test driver and selftest for proclocal allocator
Date: Fri, 21 Jun 2024 22:15:01 +0200
Message-ID: <20240621201501.1059948-4-rkagan@amazon.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240621201501.1059948-1-rkagan@amazon.de>
References: <20240621201501.1059948-1-rkagan@amazon.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Introduce a simple driver for functional and stress testing of proclocal
kernel allocator.  The driver exposes a device node /dev/proclocal-test,
which allows userland programs to request creation of proclocal areas
and to obtain their addresses as seen by the kernel, and in addition to
read and write kernel memory at arbitrary address content (simplified
/dev/kmem good enough to access proclocal allocations under selftest
responsibility).

The driver is not meant for use with production kernels, as it exposes
internal kernel pointers and data.

Also add a basic selftest that uses this driver.

Signed-off-by: Roman Kagan <rkagan@amazon.de>
---
 drivers/misc/Makefile                         |   1 +
 tools/testing/selftests/proclocal/Makefile    |   6 +
 drivers/misc/proclocal-test.c                 | 200 ++++++++++++++++++
 .../selftests/proclocal/proclocal-test.c      | 150 +++++++++++++
 drivers/misc/Kconfig                          |  15 ++
 tools/testing/selftests/proclocal/.gitignore  |   1 +
 6 files changed, 373 insertions(+)
 create mode 100644 tools/testing/selftests/proclocal/Makefile
 create mode 100644 drivers/misc/proclocal-test.c
 create mode 100644 tools/testing/selftests/proclocal/proclocal-test.c
 create mode 100644 tools/testing/selftests/proclocal/.gitignore

diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index 153a3f4837e8..33c244cee92d 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -69,3 +69,4 @@ obj-$(CONFIG_TMR_INJECT)	+= xilinx_tmr_inject.o
 obj-$(CONFIG_TPS6594_ESM)	+= tps6594-esm.o
 obj-$(CONFIG_TPS6594_PFSM)	+= tps6594-pfsm.o
 obj-$(CONFIG_NSM)		+= nsm.o
+obj-$(CONFIG_PROCLOCAL_TEST)	+= proclocal-test.o
diff --git a/tools/testing/selftests/proclocal/Makefile b/tools/testing/selftests/proclocal/Makefile
new file mode 100644
index 000000000000..b93baecee762
--- /dev/null
+++ b/tools/testing/selftests/proclocal/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0
+
+TEST_GEN_PROGS := proclocal-test
+CFLAGS += -O2 -g -Wall $(KHDR_INCLUDES)
+
+include ../lib.mk
diff --git a/drivers/misc/proclocal-test.c b/drivers/misc/proclocal-test.c
new file mode 100644
index 000000000000..9b3d0ed9b2f9
--- /dev/null
+++ b/drivers/misc/proclocal-test.c
@@ -0,0 +1,200 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (C) 2024 Amazon.com, Inc. or its affiliates. All rights reserved.
+ * Author: Roman Kagan <rkagan@amazon.de>
+ *
+ * test driver for proclocal memory allocator
+ */
+
+#include <linux/compat.h>
+#include <linux/miscdevice.h>
+#include <linux/module.h>
+#include <linux/workqueue.h>
+#include <linux/file.h>
+#include <linux/secretmem.h>
+
+struct proclocal_test_alloc {
+	u64 size;
+	u64 ptr;
+};
+
+#define PROCLOCAL_TEST_ALLOC _IOWR('A', 0x10, struct proclocal_test_alloc)
+
+#define BOUNCE_BUF_SIZE PAGE_SIZE
+
+struct proclocal_test {
+	struct secretmem_area *area;
+	size_t size;
+	void *bounce;
+};
+
+static int proclocal_test_open(struct inode *inode, struct file *f)
+{
+	struct proclocal_test *plt;
+
+	plt = kzalloc(sizeof(*plt), GFP_KERNEL);
+	if (!plt)
+		return -ENOMEM;
+
+	plt->bounce = kmalloc(BOUNCE_BUF_SIZE, GFP_KERNEL);
+	if (!plt->bounce) {
+		kfree(plt);
+		return -ENOMEM;
+	}
+
+	f->f_mode |= FMODE_UNSIGNED_OFFSET;
+	f->private_data = plt;
+	return 0;
+}
+
+static int proclocal_test_release(struct inode *inode, struct file *f)
+{
+	struct proclocal_test *plt = f->private_data;
+	if (plt->area)
+		secretmem_release_pages(plt->area);
+	kfree(plt->bounce);
+	kfree(plt);
+	return 0;
+}
+
+static ssize_t proclocal_test_read(struct file *f, char __user *buf,
+				   size_t count, loff_t *ppos)
+{
+	struct proclocal_test *plt = f->private_data;
+	const void *p = (const void *)*ppos;
+	ssize_t ret = -EFAULT;
+
+	if (p + count < p)
+		return -EINVAL;
+
+	while (count) {
+		size_t chunk = min_t(size_t, count, BOUNCE_BUF_SIZE);
+		size_t left;
+
+		/*
+		 * copy_to_user() disables superuser checks, so need to copy to
+		 * bounce buffer first to test the access
+		 */
+		memcpy(plt->bounce, p, chunk);
+
+		left = copy_to_user(buf, plt->bounce, chunk);
+		if (left == chunk)
+			goto out;
+		chunk -= left;
+
+		buf += chunk;
+		p += chunk;
+		count -= chunk;
+	}
+
+	ret = p - (const void *)*ppos;
+	*ppos = (loff_t)p;
+out:
+	return ret;
+}
+
+static ssize_t proclocal_test_write(struct file *f, const char __user *buf,
+				    size_t count, loff_t *ppos)
+{
+	struct proclocal_test *plt = f->private_data;
+	void *p = (void *)*ppos;
+	ssize_t ret = -EFAULT;
+
+	if (p + count < p)
+		return -EINVAL;
+
+	while (count) {
+		size_t chunk = min_t(size_t, count, BOUNCE_BUF_SIZE);
+		size_t left;
+
+		/*
+		 * copy_from_user() disables superuser checks, so need to copy
+		 * to bounce buffer first to test the access
+		 */
+		left = copy_from_user(plt->bounce, buf, chunk);
+		if (left == chunk)
+			goto out;
+		chunk -= left;
+
+		memcpy(p, plt->bounce, chunk);
+
+		buf += chunk;
+		p += chunk;
+		count -= chunk;
+	}
+
+	ret = p - (void *)*ppos;
+	*ppos = (loff_t)p;
+out:
+	return ret;
+}
+
+static long proclocal_test_alloc(struct proclocal_test *plt,
+				 void __user *argp)
+{
+	struct proclocal_test_alloc pta;
+	unsigned long pages_needed;
+
+	if (plt->size)
+		return -EEXIST;
+
+	if (copy_from_user(&pta, argp, sizeof(pta)))
+		return -EFAULT;
+
+	if (!pta.size)
+		return -EINVAL;
+
+	pages_needed = (pta.size + PAGE_SIZE - 1) / PAGE_SIZE;
+	plt->area = secretmem_allocate_pages(fls(pages_needed - 1));
+	if (!plt->area)
+		return -ENOMEM;
+
+	plt->size = pta.size;
+
+	pta.ptr = (u64)plt->area->ptr;
+	if (copy_to_user(argp, &pta, sizeof(pta)))
+		goto err;
+
+	return 0;
+err:
+	secretmem_release_pages(plt->area);
+	plt->area = NULL;
+	plt->size = 0;
+	return -EFAULT;
+}
+
+static long proclocal_test_ioctl(struct file *f, unsigned int ioctl,
+				 unsigned long arg)
+{
+	struct proclocal_test *plt = f->private_data;
+	void __user *argp = (void __user *)arg;
+
+	switch (ioctl) {
+	case PROCLOCAL_TEST_ALLOC:
+		return proclocal_test_alloc(plt, argp);
+	default:
+		return -EINVAL;
+	}
+}
+
+static const struct file_operations proclocal_test_fops = {
+	.owner          = THIS_MODULE,
+	.release        = proclocal_test_release,
+	.unlocked_ioctl = proclocal_test_ioctl,
+	.compat_ioctl   = compat_ptr_ioctl,
+	.open           = proclocal_test_open,
+	.read           = proclocal_test_read,
+	.write          = proclocal_test_write,
+	.llseek		= no_seek_end_llseek,
+};
+
+static struct miscdevice proclocal_test_misc = {
+	.minor = MISC_DYNAMIC_MINOR,
+	.name  = "proclocal-test",
+	.fops  = &proclocal_test_fops,
+};
+module_misc_device(proclocal_test_misc);
+
+MODULE_VERSION("0.0.1");
+MODULE_LICENSE("GPL v2");
+MODULE_AUTHOR("Roman Kagan");
+MODULE_DESCRIPTION("Test driver for proclocal allocator");
diff --git a/tools/testing/selftests/proclocal/proclocal-test.c b/tools/testing/selftests/proclocal/proclocal-test.c
new file mode 100644
index 000000000000..386cc5d9e51a
--- /dev/null
+++ b/tools/testing/selftests/proclocal/proclocal-test.c
@@ -0,0 +1,150 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (C) 2024 Amazon.com, Inc. or its affiliates. All rights reserved.
+ * Author: Roman Kagan <rkagan@amazon.de>
+ *
+ * test for proclocal memory allocator using the corresponding test device
+ */
+
+#include <fcntl.h>
+#include <string.h>
+#include <unistd.h>
+#include <sys/ioctl.h>
+#include <sys/mman.h>
+#include <stdio.h>
+#include <stdint.h>
+#include <stdbool.h>
+#include "../kselftest_harness.h"
+
+struct proclocal_test_alloc {
+	uint64_t size;
+	uint64_t ptr;
+};
+
+#define PROCLOCAL_TEST_ALLOC _IOWR('A', 0x10, struct proclocal_test_alloc)
+
+const char proclocal_content[] = "this is test";
+char buf[256];
+
+FIXTURE(proclocal) {
+	int fd;
+	void *ptr;
+};
+
+FIXTURE_SETUP(proclocal)
+{
+	struct proclocal_test_alloc pta = {
+		.size = sizeof(buf),
+	};
+
+	self->fd = open("/dev/proclocal-test", O_RDWR);
+	ASSERT_LE(0, self->fd);
+
+	ASSERT_LE(0, ioctl(self->fd, PROCLOCAL_TEST_ALLOC, &pta));
+
+	self->ptr = (void *) pta.ptr;
+	TH_LOG("self->ptr = %p\n", self->ptr);
+}
+
+FIXTURE_TEARDOWN(proclocal)
+{
+}
+
+TEST_F(proclocal, kernel_access)
+{
+	ASSERT_EQ((off_t)self->ptr,
+		  lseek(self->fd, (off_t)self->ptr, SEEK_SET));
+	EXPECT_EQ(sizeof(proclocal_content),
+		  write(self->fd,
+			proclocal_content, sizeof(proclocal_content)));
+	ASSERT_EQ((off_t)self->ptr,
+		  lseek(self->fd, (off_t)self->ptr, SEEK_SET));
+	EXPECT_EQ(sizeof(proclocal_content),
+		  read(self->fd, buf, sizeof(proclocal_content)));
+	EXPECT_STREQ(proclocal_content, buf);
+}
+
+sigjmp_buf jmpbuf;
+void segv_handler(int signum, siginfo_t *si, void *uc)
+{
+	if (signum == SIGSEGV)
+		siglongjmp(jmpbuf, 1);
+}
+
+TEST_F(proclocal, direct_access)
+{
+	bool access_succeeded;
+	struct sigaction sa;
+
+	if (sigsetjmp(jmpbuf, 1) == 0) {
+		sa.sa_sigaction = segv_handler;
+		sa.sa_flags = SA_SIGINFO | SA_RESETHAND;
+		sigemptyset(&sa.sa_mask);
+
+		sigaction(SIGSEGV, &sa, NULL);
+
+		(void)((volatile char *)self->ptr)[0];
+
+		access_succeeded = true;
+	} else
+		access_succeeded = false;
+
+	EXPECT_FALSE(access_succeeded);
+}
+
+#define PAGE_SIZE 0x1000
+
+TEST_F(proclocal, map_over)
+{
+	void *ptr_page = (void *)((uintptr_t)self->ptr & ~(PAGE_SIZE - 1));
+	void *map;
+	int errno_save;
+
+	errno = 0;
+	map = mmap(ptr_page, PAGE_SIZE, PROT_NONE,
+		   MAP_PRIVATE | MAP_ANONYMOUS | MAP_FIXED, -1, 0);
+	errno_save = errno;
+
+	EXPECT_EQ(MAP_FAILED, map);
+	TH_LOG("errno = %d", errno_save);
+
+	if (map != MAP_FAILED)
+		munmap(map, PAGE_SIZE);
+}
+
+TEST_F(proclocal, release)
+{
+	EXPECT_EQ(0, close(self->fd));
+}
+
+TEST_F(proclocal, map_over_closed)
+{
+	void *ptr_page = (void *)((uintptr_t)self->ptr & ~(PAGE_SIZE - 1));
+	void *map;
+	int errno_save;
+
+	ASSERT_EQ(0, close(self->fd));
+
+	errno = 0;
+	map = mmap(ptr_page, PAGE_SIZE, PROT_NONE,
+		   MAP_PRIVATE | MAP_ANONYMOUS | MAP_FIXED, -1, 0);
+	errno_save = errno;
+
+	EXPECT_EQ(ptr_page, map);
+	TH_LOG("errno = %d", errno_save);
+
+	if (map != MAP_FAILED)
+		munmap(map, PAGE_SIZE);
+}
+
+TEST_F(proclocal, kernel_access_closed)
+{
+	ASSERT_EQ(0, close(self->fd));
+	self->fd = open("/dev/proclocal-test", O_RDWR);
+	ASSERT_LE(0, self->fd);
+
+	ASSERT_EQ((off_t)self->ptr,
+		  lseek(self->fd, (off_t)self->ptr, SEEK_SET));
+	EXPECT_EQ(-1, read(self->fd, buf, sizeof(proclocal_content)));
+}
+
+TEST_HARNESS_MAIN
diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index faf983680040..29a334de0ca8 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -585,6 +585,21 @@ config NSM
 	  To compile this driver as a module, choose M here.
 	  The module will be called nsm.
 
+config PROCLOCAL_TEST
+	tristate "Proclocal allocator test driver"
+	depends on SECRETMEM
+	help
+	  This driver allows to perform functional and stress tests for
+	  proclocal memory allocator.  It exposes /dev/proclocal-test that
+	  userland test programs can use to create and manipulate proclocal
+	  kernel allocations.
+
+	  To compile this driver as a module, choose M here: the module will be
+	  called proclocal-test.
+
+	  If unsure, say N.
+	  This driver is not meant to be used on production systems.
+
 source "drivers/misc/c2port/Kconfig"
 source "drivers/misc/eeprom/Kconfig"
 source "drivers/misc/cb710/Kconfig"
diff --git a/tools/testing/selftests/proclocal/.gitignore b/tools/testing/selftests/proclocal/.gitignore
new file mode 100644
index 000000000000..47e0fdcd6e3a
--- /dev/null
+++ b/tools/testing/selftests/proclocal/.gitignore
@@ -0,0 +1 @@
+/proclocal-test
-- 
2.34.1




Amazon Web Services Development Center Germany GmbH
Krausenstr. 38
10117 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
Sitz: Berlin
Ust-ID: DE 365 538 597


