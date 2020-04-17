Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36CD61AE8C6
	for <lists+linux-kselftest@lfdr.de>; Sat, 18 Apr 2020 01:58:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726421AbgDQXzP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 17 Apr 2020 19:55:15 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:15697 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726372AbgDQXzM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 17 Apr 2020 19:55:12 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e9a41a40001>; Fri, 17 Apr 2020 16:54:12 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Fri, 17 Apr 2020 16:55:11 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Fri, 17 Apr 2020 16:55:11 -0700
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 17 Apr
 2020 23:55:10 +0000
Received: from rnnvemgw01.nvidia.com (10.128.109.123) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Fri, 17 Apr 2020 23:55:10 +0000
Received: from rcampbell-dev.nvidia.com (Not Verified[10.110.48.66]) by rnnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5e9a41dd0003>; Fri, 17 Apr 2020 16:55:10 -0700
From:   Ralph Campbell <rcampbell@nvidia.com>
To:     <linux-rdma@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Jerome Glisse <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        Jason Gunthorpe <jgg@mellanox.com>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>,
        "Ralph Campbell" <rcampbell@nvidia.com>
Subject: [PATCH v9 2/3] mm/hmm/test: add selftests for HMM
Date:   Fri, 17 Apr 2020 16:54:57 -0700
Message-ID: <20200417235458.13462-3-rcampbell@nvidia.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200417235458.13462-1-rcampbell@nvidia.com>
References: <20200417235458.13462-1-rcampbell@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1587167652; bh=S2miUgH+844pu0a9hxP8g79sphZYDsaaLRTw8HdAgEs=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
         Content-Type;
        b=df1vjuzINMyc25zm/hL8pB8c5zdW/pkOKYJQcFwgDyy/jbZiqOTGB2kiqpQq5M3vd
         b5ecBqjg65XFvyVaNzSFG/Kr0ahV2Eph7gQkAdmfkR4lkVbVIysCpl3gUHqZnHZrDE
         M5o2j1JQUuJmPzypU2BnRnwKhejP3QyhYzJF1zi8CFnXkFvdqGEJ8Q5egJi2IL4Xom
         Ys09QtKfB76PlU/AdV+fqlqmcq4TcNnQb1FXktTNq4X55ZSa1u8nqQ9HvOf9/5JvhT
         Ob7qfXoH0I2ZIuIgmKhAq46/+66oBSSF/5/GHC1t/OrRkxWo3bCYNqc5qbr3lzXYsq
         xiLatKelOgsAQ==
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add some basic stand alone self tests for HMM.
The test program and shell scripts use the test_hmm.ko driver to exercise
HMM functionality in the kernel.

Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
---
 tools/testing/selftests/vm/.gitignore  |    1 +
 tools/testing/selftests/vm/Makefile    |    3 +
 tools/testing/selftests/vm/config      |    2 +
 tools/testing/selftests/vm/hmm-tests.c | 1359 ++++++++++++++++++++++++
 tools/testing/selftests/vm/run_vmtests |   16 +
 tools/testing/selftests/vm/test_hmm.sh |   97 ++
 6 files changed, 1478 insertions(+)
 create mode 100644 tools/testing/selftests/vm/hmm-tests.c
 create mode 100755 tools/testing/selftests/vm/test_hmm.sh

diff --git a/tools/testing/selftests/vm/.gitignore b/tools/testing/selftest=
s/vm/.gitignore
index 0edb6d900e8d..f25208eca5ff 100644
--- a/tools/testing/selftests/vm/.gitignore
+++ b/tools/testing/selftests/vm/.gitignore
@@ -16,3 +16,4 @@ gup_benchmark
 va_128TBswitch
 map_fixed_noreplace
 write_to_hugetlbfs
+hmm-tests
diff --git a/tools/testing/selftests/vm/Makefile b/tools/testing/selftests/=
vm/Makefile
index d31db052dff6..4dd6689157bc 100644
--- a/tools/testing/selftests/vm/Makefile
+++ b/tools/testing/selftests/vm/Makefile
@@ -7,6 +7,7 @@ CFLAGS =3D -Wall -I ../../../../usr/include $(EXTRA_CFLAGS)
 LDLIBS =3D -lrt
 TEST_GEN_FILES =3D compaction_test
 TEST_GEN_FILES +=3D gup_benchmark
+TEST_GEN_FILES +=3D hmm-tests
 TEST_GEN_FILES +=3D hugepage-mmap
 TEST_GEN_FILES +=3D hugepage-shm
 TEST_GEN_FILES +=3D map_hugetlb
@@ -33,6 +34,8 @@ TEST_FILES :=3D test_vmalloc.sh
 KSFT_KHDR_INSTALL :=3D 1
 include ../lib.mk
=20
+$(OUTPUT)/hmm-tests: LDLIBS +=3D -lhugetlbfs -lpthread
+
 $(OUTPUT)/userfaultfd: LDLIBS +=3D -lpthread
=20
 $(OUTPUT)/mlock-random-test: LDLIBS +=3D -lcap
diff --git a/tools/testing/selftests/vm/config b/tools/testing/selftests/vm=
/config
index 93b90a9b1eeb..3ba674b64fa9 100644
--- a/tools/testing/selftests/vm/config
+++ b/tools/testing/selftests/vm/config
@@ -1,3 +1,5 @@
 CONFIG_SYSVIPC=3Dy
 CONFIG_USERFAULTFD=3Dy
 CONFIG_TEST_VMALLOC=3Dm
+CONFIG_DEVICE_PRIVATE=3Dy
+CONFIG_TEST_HMM=3Dm
diff --git a/tools/testing/selftests/vm/hmm-tests.c b/tools/testing/selftes=
ts/vm/hmm-tests.c
new file mode 100644
index 000000000000..79db22604019
--- /dev/null
+++ b/tools/testing/selftests/vm/hmm-tests.c
@@ -0,0 +1,1359 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * HMM stands for Heterogeneous Memory Management, it is a helper layer in=
side
+ * the linux kernel to help device drivers mirror a process address space =
in
+ * the device. This allows the device to use the same address space which
+ * makes communication and data exchange a lot easier.
+ *
+ * This framework's sole purpose is to exercise various code paths inside
+ * the kernel to make sure that HMM performs as expected and to flush out =
any
+ * bugs.
+ */
+
+#include "../kselftest_harness.h"
+
+#include <errno.h>
+#include <fcntl.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <stdint.h>
+#include <unistd.h>
+#include <strings.h>
+#include <time.h>
+#include <pthread.h>
+#include <hugetlbfs.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <sys/mman.h>
+#include <sys/ioctl.h>
+
+/*
+ * This is a private UAPI to the kernel test module so it isn't exported
+ * in the usual include/uapi/... directory.
+ */
+#include "../../../../lib/test_hmm_uapi.h"
+
+struct hmm_buffer {
+	void		*ptr;
+	void		*mirror;
+	unsigned long	size;
+	int		fd;
+	uint64_t	cpages;
+	uint64_t	faults;
+};
+
+#define TWOMEG		(1 << 21)
+#define HMM_BUFFER_SIZE (1024 << 12)
+#define HMM_PATH_MAX    64
+#define NTIMES		256
+
+#define ALIGN(x, a) (((x) + (a - 1)) & (~((a) - 1)))
+
+FIXTURE(hmm)
+{
+	int		fd;
+	unsigned int	page_size;
+	unsigned int	page_shift;
+};
+
+FIXTURE(hmm2)
+{
+	int		fd0;
+	int		fd1;
+	unsigned int	page_size;
+	unsigned int	page_shift;
+};
+
+static int hmm_open(int unit)
+{
+	char pathname[HMM_PATH_MAX];
+	int fd;
+
+	snprintf(pathname, sizeof(pathname), "/dev/hmm_dmirror%d", unit);
+	fd =3D open(pathname, O_RDWR, 0);
+	if (fd < 0)
+		fprintf(stderr, "could not open hmm dmirror driver (%s)\n",
+			pathname);
+	return fd;
+}
+
+FIXTURE_SETUP(hmm)
+{
+	self->page_size =3D sysconf(_SC_PAGE_SIZE);
+	self->page_shift =3D ffs(self->page_size) - 1;
+
+	self->fd =3D hmm_open(0);
+	ASSERT_GE(self->fd, 0);
+}
+
+FIXTURE_SETUP(hmm2)
+{
+	self->page_size =3D sysconf(_SC_PAGE_SIZE);
+	self->page_shift =3D ffs(self->page_size) - 1;
+
+	self->fd0 =3D hmm_open(0);
+	ASSERT_GE(self->fd0, 0);
+	self->fd1 =3D hmm_open(1);
+	ASSERT_GE(self->fd1, 0);
+}
+
+FIXTURE_TEARDOWN(hmm)
+{
+	int ret =3D close(self->fd);
+
+	ASSERT_EQ(ret, 0);
+	self->fd =3D -1;
+}
+
+FIXTURE_TEARDOWN(hmm2)
+{
+	int ret =3D close(self->fd0);
+
+	ASSERT_EQ(ret, 0);
+	self->fd0 =3D -1;
+
+	ret =3D close(self->fd1);
+	ASSERT_EQ(ret, 0);
+	self->fd1 =3D -1;
+}
+
+static int hmm_dmirror_cmd(int fd,
+			   unsigned long request,
+			   struct hmm_buffer *buffer,
+			   unsigned long npages)
+{
+	struct hmm_dmirror_cmd cmd;
+	int ret;
+
+	/* Simulate a device reading system memory. */
+	cmd.addr =3D (__u64)buffer->ptr;
+	cmd.ptr =3D (__u64)buffer->mirror;
+	cmd.npages =3D npages;
+
+	for (;;) {
+		ret =3D ioctl(fd, request, &cmd);
+		if (ret =3D=3D 0)
+			break;
+		if (errno =3D=3D EINTR)
+			continue;
+		return -errno;
+	}
+	buffer->cpages =3D cmd.cpages;
+	buffer->faults =3D cmd.faults;
+
+	return 0;
+}
+
+static void hmm_buffer_free(struct hmm_buffer *buffer)
+{
+	if (buffer =3D=3D NULL)
+		return;
+
+	if (buffer->ptr)
+		munmap(buffer->ptr, buffer->size);
+	free(buffer->mirror);
+	free(buffer);
+}
+
+/*
+ * Create a temporary file that will be deleted on close.
+ */
+static int hmm_create_file(unsigned long size)
+{
+	char path[HMM_PATH_MAX];
+	int fd;
+
+	strcpy(path, "/tmp");
+	fd =3D open(path, O_TMPFILE | O_EXCL | O_RDWR, 0600);
+	if (fd >=3D 0) {
+		int r;
+
+		do {
+			r =3D ftruncate(fd, size);
+		} while (r =3D=3D -1 && errno =3D=3D EINTR);
+		if (!r)
+			return fd;
+		close(fd);
+	}
+	return -1;
+}
+
+/*
+ * Return a random unsigned number.
+ */
+static unsigned int hmm_random(void)
+{
+	static int fd =3D -1;
+	unsigned int r;
+
+	if (fd < 0) {
+		fd =3D open("/dev/urandom", O_RDONLY);
+		if (fd < 0) {
+			fprintf(stderr, "%s:%d failed to open /dev/urandom\n",
+					__FILE__, __LINE__);
+			return ~0U;
+		}
+	}
+	read(fd, &r, sizeof(r));
+	return r;
+}
+
+static void hmm_nanosleep(unsigned int n)
+{
+	struct timespec t;
+
+	t.tv_sec =3D 0;
+	t.tv_nsec =3D n;
+	nanosleep(&t, NULL);
+}
+
+/*
+ * Simple NULL test of device open/close.
+ */
+TEST_F(hmm, open_close)
+{
+}
+
+/*
+ * Read private anonymous memory.
+ */
+TEST_F(hmm, anon_read)
+{
+	struct hmm_buffer *buffer;
+	unsigned long npages;
+	unsigned long size;
+	unsigned long i;
+	int *ptr;
+	int ret;
+	int val;
+
+	npages =3D ALIGN(HMM_BUFFER_SIZE, self->page_size) >> self->page_shift;
+	ASSERT_NE(npages, 0);
+	size =3D npages << self->page_shift;
+
+	buffer =3D malloc(sizeof(*buffer));
+	ASSERT_NE(buffer, NULL);
+
+	buffer->fd =3D -1;
+	buffer->size =3D size;
+	buffer->mirror =3D malloc(size);
+	ASSERT_NE(buffer->mirror, NULL);
+
+	buffer->ptr =3D mmap(NULL, size,
+			   PROT_READ | PROT_WRITE,
+			   MAP_PRIVATE | MAP_ANONYMOUS,
+			   buffer->fd, 0);
+	ASSERT_NE(buffer->ptr, MAP_FAILED);
+
+	/*
+	 * Initialize buffer in system memory but leave the first two pages
+	 * zero (pte_none and pfn_zero).
+	 */
+	i =3D 2 * self->page_size / sizeof(*ptr);
+	for (ptr =3D buffer->ptr; i < size / sizeof(*ptr); ++i)
+		ptr[i] =3D i;
+
+	/* Set buffer permission to read-only. */
+	ret =3D mprotect(buffer->ptr, size, PROT_READ);
+	ASSERT_EQ(ret, 0);
+
+	/* Populate the CPU page table with a special zero page. */
+	val =3D *(int *)(buffer->ptr + self->page_size);
+	ASSERT_EQ(val, 0);
+
+	/* Simulate a device reading system memory. */
+	ret =3D hmm_dmirror_cmd(self->fd, HMM_DMIRROR_READ, buffer, npages);
+	ASSERT_EQ(ret, 0);
+	ASSERT_EQ(buffer->cpages, npages);
+	ASSERT_EQ(buffer->faults, 1);
+
+	/* Check what the device read. */
+	ptr =3D buffer->mirror;
+	for (i =3D 0; i < 2 * self->page_size / sizeof(*ptr); ++i)
+		ASSERT_EQ(ptr[i], 0);
+	for (; i < size / sizeof(*ptr); ++i)
+		ASSERT_EQ(ptr[i], i);
+
+	hmm_buffer_free(buffer);
+}
+
+/*
+ * Read private anonymous memory which has been protected with
+ * mprotect() PROT_NONE.
+ */
+TEST_F(hmm, anon_read_prot)
+{
+	struct hmm_buffer *buffer;
+	unsigned long npages;
+	unsigned long size;
+	unsigned long i;
+	int *ptr;
+	int ret;
+
+	npages =3D ALIGN(HMM_BUFFER_SIZE, self->page_size) >> self->page_shift;
+	ASSERT_NE(npages, 0);
+	size =3D npages << self->page_shift;
+
+	buffer =3D malloc(sizeof(*buffer));
+	ASSERT_NE(buffer, NULL);
+
+	buffer->fd =3D -1;
+	buffer->size =3D size;
+	buffer->mirror =3D malloc(size);
+	ASSERT_NE(buffer->mirror, NULL);
+
+	buffer->ptr =3D mmap(NULL, size,
+			   PROT_READ | PROT_WRITE,
+			   MAP_PRIVATE | MAP_ANONYMOUS,
+			   buffer->fd, 0);
+	ASSERT_NE(buffer->ptr, MAP_FAILED);
+
+	/* Initialize buffer in system memory. */
+	for (i =3D 0, ptr =3D buffer->ptr; i < size / sizeof(*ptr); ++i)
+		ptr[i] =3D i;
+
+	/* Initialize mirror buffer so we can verify it isn't written. */
+	for (i =3D 0, ptr =3D buffer->mirror; i < size / sizeof(*ptr); ++i)
+		ptr[i] =3D -i;
+
+	/* Protect buffer from reading. */
+	ret =3D mprotect(buffer->ptr, size, PROT_NONE);
+	ASSERT_EQ(ret, 0);
+
+	/* Simulate a device reading system memory. */
+	ret =3D hmm_dmirror_cmd(self->fd, HMM_DMIRROR_READ, buffer, npages);
+	ASSERT_EQ(ret, -EFAULT);
+
+	/* Allow CPU to read the buffer so we can check it. */
+	ret =3D mprotect(buffer->ptr, size, PROT_READ);
+	ASSERT_EQ(ret, 0);
+	for (i =3D 0, ptr =3D buffer->ptr; i < size / sizeof(*ptr); ++i)
+		ASSERT_EQ(ptr[i], i);
+
+	/* Check what the device read. */
+	for (i =3D 0, ptr =3D buffer->mirror; i < size / sizeof(*ptr); ++i)
+		ASSERT_EQ(ptr[i], -i);
+
+	hmm_buffer_free(buffer);
+}
+
+/*
+ * Write private anonymous memory.
+ */
+TEST_F(hmm, anon_write)
+{
+	struct hmm_buffer *buffer;
+	unsigned long npages;
+	unsigned long size;
+	unsigned long i;
+	int *ptr;
+	int ret;
+
+	npages =3D ALIGN(HMM_BUFFER_SIZE, self->page_size) >> self->page_shift;
+	ASSERT_NE(npages, 0);
+	size =3D npages << self->page_shift;
+
+	buffer =3D malloc(sizeof(*buffer));
+	ASSERT_NE(buffer, NULL);
+
+	buffer->fd =3D -1;
+	buffer->size =3D size;
+	buffer->mirror =3D malloc(size);
+	ASSERT_NE(buffer->mirror, NULL);
+
+	buffer->ptr =3D mmap(NULL, size,
+			   PROT_READ | PROT_WRITE,
+			   MAP_PRIVATE | MAP_ANONYMOUS,
+			   buffer->fd, 0);
+	ASSERT_NE(buffer->ptr, MAP_FAILED);
+
+	/* Initialize data that the device will write to buffer->ptr. */
+	for (i =3D 0, ptr =3D buffer->mirror; i < size / sizeof(*ptr); ++i)
+		ptr[i] =3D i;
+
+	/* Simulate a device writing system memory. */
+	ret =3D hmm_dmirror_cmd(self->fd, HMM_DMIRROR_WRITE, buffer, npages);
+	ASSERT_EQ(ret, 0);
+	ASSERT_EQ(buffer->cpages, npages);
+	ASSERT_EQ(buffer->faults, 1);
+
+	/* Check what the device wrote. */
+	for (i =3D 0, ptr =3D buffer->ptr; i < size / sizeof(*ptr); ++i)
+		ASSERT_EQ(ptr[i], i);
+
+	hmm_buffer_free(buffer);
+}
+
+/*
+ * Write private anonymous memory which has been protected with
+ * mprotect() PROT_READ.
+ */
+TEST_F(hmm, anon_write_prot)
+{
+	struct hmm_buffer *buffer;
+	unsigned long npages;
+	unsigned long size;
+	unsigned long i;
+	int *ptr;
+	int ret;
+
+	npages =3D ALIGN(HMM_BUFFER_SIZE, self->page_size) >> self->page_shift;
+	ASSERT_NE(npages, 0);
+	size =3D npages << self->page_shift;
+
+	buffer =3D malloc(sizeof(*buffer));
+	ASSERT_NE(buffer, NULL);
+
+	buffer->fd =3D -1;
+	buffer->size =3D size;
+	buffer->mirror =3D malloc(size);
+	ASSERT_NE(buffer->mirror, NULL);
+
+	buffer->ptr =3D mmap(NULL, size,
+			   PROT_READ,
+			   MAP_PRIVATE | MAP_ANONYMOUS,
+			   buffer->fd, 0);
+	ASSERT_NE(buffer->ptr, MAP_FAILED);
+
+	/* Simulate a device reading a zero page of memory. */
+	ret =3D hmm_dmirror_cmd(self->fd, HMM_DMIRROR_READ, buffer, 1);
+	ASSERT_EQ(ret, 0);
+	ASSERT_EQ(buffer->cpages, 1);
+	ASSERT_EQ(buffer->faults, 1);
+
+	/* Initialize data that the device will write to buffer->ptr. */
+	for (i =3D 0, ptr =3D buffer->mirror; i < size / sizeof(*ptr); ++i)
+		ptr[i] =3D i;
+
+	/* Simulate a device writing system memory. */
+	ret =3D hmm_dmirror_cmd(self->fd, HMM_DMIRROR_WRITE, buffer, npages);
+	ASSERT_EQ(ret, -EPERM);
+
+	/* Check what the device wrote. */
+	for (i =3D 0, ptr =3D buffer->ptr; i < size / sizeof(*ptr); ++i)
+		ASSERT_EQ(ptr[i], 0);
+
+	/* Now allow writing and see that the zero page is replaced. */
+	ret =3D mprotect(buffer->ptr, size, PROT_WRITE | PROT_READ);
+	ASSERT_EQ(ret, 0);
+
+	/* Simulate a device writing system memory. */
+	ret =3D hmm_dmirror_cmd(self->fd, HMM_DMIRROR_WRITE, buffer, npages);
+	ASSERT_EQ(ret, 0);
+	ASSERT_EQ(buffer->cpages, npages);
+	ASSERT_EQ(buffer->faults, 1);
+
+	/* Check what the device wrote. */
+	for (i =3D 0, ptr =3D buffer->ptr; i < size / sizeof(*ptr); ++i)
+		ASSERT_EQ(ptr[i], i);
+
+	hmm_buffer_free(buffer);
+}
+
+/*
+ * Check that a device writing an anonymous private mapping
+ * will copy-on-write if a child process inherits the mapping.
+ */
+TEST_F(hmm, anon_write_child)
+{
+	struct hmm_buffer *buffer;
+	unsigned long npages;
+	unsigned long size;
+	unsigned long i;
+	int *ptr;
+	pid_t pid;
+	int child_fd;
+	int ret;
+
+	npages =3D ALIGN(HMM_BUFFER_SIZE, self->page_size) >> self->page_shift;
+	ASSERT_NE(npages, 0);
+	size =3D npages << self->page_shift;
+
+	buffer =3D malloc(sizeof(*buffer));
+	ASSERT_NE(buffer, NULL);
+
+	buffer->fd =3D -1;
+	buffer->size =3D size;
+	buffer->mirror =3D malloc(size);
+	ASSERT_NE(buffer->mirror, NULL);
+
+	buffer->ptr =3D mmap(NULL, size,
+			   PROT_READ | PROT_WRITE,
+			   MAP_PRIVATE | MAP_ANONYMOUS,
+			   buffer->fd, 0);
+	ASSERT_NE(buffer->ptr, MAP_FAILED);
+
+	/* Initialize buffer->ptr so we can tell if it is written. */
+	for (i =3D 0, ptr =3D buffer->ptr; i < size / sizeof(*ptr); ++i)
+		ptr[i] =3D i;
+
+	/* Initialize data that the device will write to buffer->ptr. */
+	for (i =3D 0, ptr =3D buffer->mirror; i < size / sizeof(*ptr); ++i)
+		ptr[i] =3D -i;
+
+	pid =3D fork();
+	if (pid =3D=3D -1)
+		ASSERT_EQ(pid, 0);
+	if (pid !=3D 0) {
+		waitpid(pid, &ret, 0);
+		ASSERT_EQ(WIFEXITED(ret), 1);
+
+		/* Check that the parent's buffer did not change. */
+		for (i =3D 0, ptr =3D buffer->ptr; i < size / sizeof(*ptr); ++i)
+			ASSERT_EQ(ptr[i], i);
+		return;
+	}
+
+	/* Check that we see the parent's values. */
+	for (i =3D 0, ptr =3D buffer->ptr; i < size / sizeof(*ptr); ++i)
+		ASSERT_EQ(ptr[i], i);
+	for (i =3D 0, ptr =3D buffer->mirror; i < size / sizeof(*ptr); ++i)
+		ASSERT_EQ(ptr[i], -i);
+
+	/* The child process needs its own mirror to its own mm. */
+	child_fd =3D hmm_open(0);
+	ASSERT_GE(child_fd, 0);
+
+	/* Simulate a device writing system memory. */
+	ret =3D hmm_dmirror_cmd(child_fd, HMM_DMIRROR_WRITE, buffer, npages);
+	ASSERT_EQ(ret, 0);
+	ASSERT_EQ(buffer->cpages, npages);
+	ASSERT_EQ(buffer->faults, 1);
+
+	/* Check what the device wrote. */
+	for (i =3D 0, ptr =3D buffer->ptr; i < size / sizeof(*ptr); ++i)
+		ASSERT_EQ(ptr[i], -i);
+
+	close(child_fd);
+	exit(0);
+}
+
+/*
+ * Check that a device writing an anonymous shared mapping
+ * will not copy-on-write if a child process inherits the mapping.
+ */
+TEST_F(hmm, anon_write_child_shared)
+{
+	struct hmm_buffer *buffer;
+	unsigned long npages;
+	unsigned long size;
+	unsigned long i;
+	int *ptr;
+	pid_t pid;
+	int child_fd;
+	int ret;
+
+	npages =3D ALIGN(HMM_BUFFER_SIZE, self->page_size) >> self->page_shift;
+	ASSERT_NE(npages, 0);
+	size =3D npages << self->page_shift;
+
+	buffer =3D malloc(sizeof(*buffer));
+	ASSERT_NE(buffer, NULL);
+
+	buffer->fd =3D -1;
+	buffer->size =3D size;
+	buffer->mirror =3D malloc(size);
+	ASSERT_NE(buffer->mirror, NULL);
+
+	buffer->ptr =3D mmap(NULL, size,
+			   PROT_READ | PROT_WRITE,
+			   MAP_SHARED | MAP_ANONYMOUS,
+			   buffer->fd, 0);
+	ASSERT_NE(buffer->ptr, MAP_FAILED);
+
+	/* Initialize buffer->ptr so we can tell if it is written. */
+	for (i =3D 0, ptr =3D buffer->ptr; i < size / sizeof(*ptr); ++i)
+		ptr[i] =3D i;
+
+	/* Initialize data that the device will write to buffer->ptr. */
+	for (i =3D 0, ptr =3D buffer->mirror; i < size / sizeof(*ptr); ++i)
+		ptr[i] =3D -i;
+
+	pid =3D fork();
+	if (pid =3D=3D -1)
+		ASSERT_EQ(pid, 0);
+	if (pid !=3D 0) {
+		waitpid(pid, &ret, 0);
+		ASSERT_EQ(WIFEXITED(ret), 1);
+
+		/* Check that the parent's buffer did change. */
+		for (i =3D 0, ptr =3D buffer->ptr; i < size / sizeof(*ptr); ++i)
+			ASSERT_EQ(ptr[i], -i);
+		return;
+	}
+
+	/* Check that we see the parent's values. */
+	for (i =3D 0, ptr =3D buffer->ptr; i < size / sizeof(*ptr); ++i)
+		ASSERT_EQ(ptr[i], i);
+	for (i =3D 0, ptr =3D buffer->mirror; i < size / sizeof(*ptr); ++i)
+		ASSERT_EQ(ptr[i], -i);
+
+	/* The child process needs its own mirror to its own mm. */
+	child_fd =3D hmm_open(0);
+	ASSERT_GE(child_fd, 0);
+
+	/* Simulate a device writing system memory. */
+	ret =3D hmm_dmirror_cmd(child_fd, HMM_DMIRROR_WRITE, buffer, npages);
+	ASSERT_EQ(ret, 0);
+	ASSERT_EQ(buffer->cpages, npages);
+	ASSERT_EQ(buffer->faults, 1);
+
+	/* Check what the device wrote. */
+	for (i =3D 0, ptr =3D buffer->ptr; i < size / sizeof(*ptr); ++i)
+		ASSERT_EQ(ptr[i], -i);
+
+	close(child_fd);
+	exit(0);
+}
+
+/*
+ * Write private anonymous huge page.
+ */
+TEST_F(hmm, anon_write_huge)
+{
+	struct hmm_buffer *buffer;
+	unsigned long npages;
+	unsigned long size;
+	unsigned long i;
+	void *old_ptr;
+	void *map;
+	int *ptr;
+	int ret;
+
+	size =3D 2 * TWOMEG;
+
+	buffer =3D malloc(sizeof(*buffer));
+	ASSERT_NE(buffer, NULL);
+
+	buffer->fd =3D -1;
+	buffer->size =3D size;
+	buffer->mirror =3D malloc(size);
+	ASSERT_NE(buffer->mirror, NULL);
+
+	buffer->ptr =3D mmap(NULL, size,
+			   PROT_READ | PROT_WRITE,
+			   MAP_PRIVATE | MAP_ANONYMOUS,
+			   buffer->fd, 0);
+	ASSERT_NE(buffer->ptr, MAP_FAILED);
+
+	size =3D TWOMEG;
+	npages =3D size >> self->page_shift;
+	map =3D (void *)ALIGN((uintptr_t)buffer->ptr, size);
+	ret =3D madvise(map, size, MADV_HUGEPAGE);
+	ASSERT_EQ(ret, 0);
+	old_ptr =3D buffer->ptr;
+	buffer->ptr =3D map;
+
+	/* Initialize data that the device will write to buffer->ptr. */
+	for (i =3D 0, ptr =3D buffer->mirror; i < size / sizeof(*ptr); ++i)
+		ptr[i] =3D i;
+
+	/* Simulate a device writing system memory. */
+	ret =3D hmm_dmirror_cmd(self->fd, HMM_DMIRROR_WRITE, buffer, npages);
+	ASSERT_EQ(ret, 0);
+	ASSERT_EQ(buffer->cpages, npages);
+	ASSERT_EQ(buffer->faults, 1);
+
+	/* Check what the device wrote. */
+	for (i =3D 0, ptr =3D buffer->ptr; i < size / sizeof(*ptr); ++i)
+		ASSERT_EQ(ptr[i], i);
+
+	buffer->ptr =3D old_ptr;
+	hmm_buffer_free(buffer);
+}
+
+/*
+ * Write huge TLBFS page.
+ */
+TEST_F(hmm, anon_write_hugetlbfs)
+{
+	struct hmm_buffer *buffer;
+	unsigned long npages;
+	unsigned long size;
+	unsigned long i;
+	int *ptr;
+	int ret;
+	long pagesizes[4];
+	int n, idx;
+
+	/* Skip test if we can't allocate a hugetlbfs page. */
+
+	n =3D gethugepagesizes(pagesizes, 4);
+	if (n <=3D 0)
+		return;
+	for (idx =3D 0; --n > 0; ) {
+		if (pagesizes[n] < pagesizes[idx])
+			idx =3D n;
+	}
+	size =3D ALIGN(TWOMEG, pagesizes[idx]);
+	npages =3D size >> self->page_shift;
+
+	buffer =3D malloc(sizeof(*buffer));
+	ASSERT_NE(buffer, NULL);
+
+	buffer->ptr =3D get_hugepage_region(size, GHR_STRICT);
+	if (buffer->ptr =3D=3D NULL) {
+		free(buffer);
+		return;
+	}
+
+	buffer->fd =3D -1;
+	buffer->size =3D size;
+	buffer->mirror =3D malloc(size);
+	ASSERT_NE(buffer->mirror, NULL);
+
+	/* Initialize data that the device will write to buffer->ptr. */
+	for (i =3D 0, ptr =3D buffer->mirror; i < size / sizeof(*ptr); ++i)
+		ptr[i] =3D i;
+
+	/* Simulate a device writing system memory. */
+	ret =3D hmm_dmirror_cmd(self->fd, HMM_DMIRROR_WRITE, buffer, npages);
+	ASSERT_EQ(ret, 0);
+	ASSERT_EQ(buffer->cpages, npages);
+	ASSERT_EQ(buffer->faults, 1);
+
+	/* Check what the device wrote. */
+	for (i =3D 0, ptr =3D buffer->ptr; i < size / sizeof(*ptr); ++i)
+		ASSERT_EQ(ptr[i], i);
+
+	free_hugepage_region(buffer->ptr);
+	buffer->ptr =3D NULL;
+	hmm_buffer_free(buffer);
+}
+
+/*
+ * Read mmap'ed file memory.
+ */
+TEST_F(hmm, file_read)
+{
+	struct hmm_buffer *buffer;
+	unsigned long npages;
+	unsigned long size;
+	unsigned long i;
+	int *ptr;
+	int ret;
+	int fd;
+	ssize_t len;
+
+	npages =3D ALIGN(HMM_BUFFER_SIZE, self->page_size) >> self->page_shift;
+	ASSERT_NE(npages, 0);
+	size =3D npages << self->page_shift;
+
+	fd =3D hmm_create_file(size);
+	ASSERT_GE(fd, 0);
+
+	buffer =3D malloc(sizeof(*buffer));
+	ASSERT_NE(buffer, NULL);
+
+	buffer->fd =3D fd;
+	buffer->size =3D size;
+	buffer->mirror =3D malloc(size);
+	ASSERT_NE(buffer->mirror, NULL);
+
+	/* Write initial contents of the file. */
+	for (i =3D 0, ptr =3D buffer->mirror; i < size / sizeof(*ptr); ++i)
+		ptr[i] =3D i;
+	len =3D pwrite(fd, buffer->mirror, size, 0);
+	ASSERT_EQ(len, size);
+	memset(buffer->mirror, 0, size);
+
+	buffer->ptr =3D mmap(NULL, size,
+			   PROT_READ,
+			   MAP_SHARED,
+			   buffer->fd, 0);
+	ASSERT_NE(buffer->ptr, MAP_FAILED);
+
+	/* Simulate a device reading system memory. */
+	ret =3D hmm_dmirror_cmd(self->fd, HMM_DMIRROR_READ, buffer, npages);
+	ASSERT_EQ(ret, 0);
+	ASSERT_EQ(buffer->cpages, npages);
+	ASSERT_EQ(buffer->faults, 1);
+
+	/* Check what the device read. */
+	for (i =3D 0, ptr =3D buffer->mirror; i < size / sizeof(*ptr); ++i)
+		ASSERT_EQ(ptr[i], i);
+
+	hmm_buffer_free(buffer);
+}
+
+/*
+ * Write mmap'ed file memory.
+ */
+TEST_F(hmm, file_write)
+{
+	struct hmm_buffer *buffer;
+	unsigned long npages;
+	unsigned long size;
+	unsigned long i;
+	int *ptr;
+	int ret;
+	int fd;
+	ssize_t len;
+
+	npages =3D ALIGN(HMM_BUFFER_SIZE, self->page_size) >> self->page_shift;
+	ASSERT_NE(npages, 0);
+	size =3D npages << self->page_shift;
+
+	fd =3D hmm_create_file(size);
+	ASSERT_GE(fd, 0);
+
+	buffer =3D malloc(sizeof(*buffer));
+	ASSERT_NE(buffer, NULL);
+
+	buffer->fd =3D fd;
+	buffer->size =3D size;
+	buffer->mirror =3D malloc(size);
+	ASSERT_NE(buffer->mirror, NULL);
+
+	buffer->ptr =3D mmap(NULL, size,
+			   PROT_READ | PROT_WRITE,
+			   MAP_SHARED,
+			   buffer->fd, 0);
+	ASSERT_NE(buffer->ptr, MAP_FAILED);
+
+	/* Initialize data that the device will write to buffer->ptr. */
+	for (i =3D 0, ptr =3D buffer->mirror; i < size / sizeof(*ptr); ++i)
+		ptr[i] =3D i;
+
+	/* Simulate a device writing system memory. */
+	ret =3D hmm_dmirror_cmd(self->fd, HMM_DMIRROR_WRITE, buffer, npages);
+	ASSERT_EQ(ret, 0);
+	ASSERT_EQ(buffer->cpages, npages);
+	ASSERT_EQ(buffer->faults, 1);
+
+	/* Check what the device wrote. */
+	for (i =3D 0, ptr =3D buffer->ptr; i < size / sizeof(*ptr); ++i)
+		ASSERT_EQ(ptr[i], i);
+
+	/* Check that the device also wrote the file. */
+	len =3D pread(fd, buffer->mirror, size, 0);
+	ASSERT_EQ(len, size);
+	for (i =3D 0, ptr =3D buffer->mirror; i < size / sizeof(*ptr); ++i)
+		ASSERT_EQ(ptr[i], i);
+
+	hmm_buffer_free(buffer);
+}
+
+/*
+ * Migrate anonymous memory to device private memory.
+ */
+TEST_F(hmm, migrate)
+{
+	struct hmm_buffer *buffer;
+	unsigned long npages;
+	unsigned long size;
+	unsigned long i;
+	int *ptr;
+	int ret;
+
+	npages =3D ALIGN(HMM_BUFFER_SIZE, self->page_size) >> self->page_shift;
+	ASSERT_NE(npages, 0);
+	size =3D npages << self->page_shift;
+
+	buffer =3D malloc(sizeof(*buffer));
+	ASSERT_NE(buffer, NULL);
+
+	buffer->fd =3D -1;
+	buffer->size =3D size;
+	buffer->mirror =3D malloc(size);
+	ASSERT_NE(buffer->mirror, NULL);
+
+	buffer->ptr =3D mmap(NULL, size,
+			   PROT_READ | PROT_WRITE,
+			   MAP_PRIVATE | MAP_ANONYMOUS,
+			   buffer->fd, 0);
+	ASSERT_NE(buffer->ptr, MAP_FAILED);
+
+	/* Initialize buffer in system memory. */
+	for (i =3D 0, ptr =3D buffer->ptr; i < size / sizeof(*ptr); ++i)
+		ptr[i] =3D i;
+
+	/* Migrate memory to device. */
+	ret =3D hmm_dmirror_cmd(self->fd, HMM_DMIRROR_MIGRATE, buffer, npages);
+	ASSERT_EQ(ret, 0);
+	ASSERT_EQ(buffer->cpages, npages);
+
+	/* Check what the device read. */
+	for (i =3D 0, ptr =3D buffer->mirror; i < size / sizeof(*ptr); ++i)
+		ASSERT_EQ(ptr[i], i);
+
+	hmm_buffer_free(buffer);
+}
+
+/*
+ * Migrate anonymous memory to device private memory and fault it back to =
system
+ * memory.
+ */
+TEST_F(hmm, migrate_fault)
+{
+	struct hmm_buffer *buffer;
+	unsigned long npages;
+	unsigned long size;
+	unsigned long i;
+	int *ptr;
+	int ret;
+
+	npages =3D ALIGN(HMM_BUFFER_SIZE, self->page_size) >> self->page_shift;
+	ASSERT_NE(npages, 0);
+	size =3D npages << self->page_shift;
+
+	buffer =3D malloc(sizeof(*buffer));
+	ASSERT_NE(buffer, NULL);
+
+	buffer->fd =3D -1;
+	buffer->size =3D size;
+	buffer->mirror =3D malloc(size);
+	ASSERT_NE(buffer->mirror, NULL);
+
+	buffer->ptr =3D mmap(NULL, size,
+			   PROT_READ | PROT_WRITE,
+			   MAP_PRIVATE | MAP_ANONYMOUS,
+			   buffer->fd, 0);
+	ASSERT_NE(buffer->ptr, MAP_FAILED);
+
+	/* Initialize buffer in system memory. */
+	for (i =3D 0, ptr =3D buffer->ptr; i < size / sizeof(*ptr); ++i)
+		ptr[i] =3D i;
+
+	/* Migrate memory to device. */
+	ret =3D hmm_dmirror_cmd(self->fd, HMM_DMIRROR_MIGRATE, buffer, npages);
+	ASSERT_EQ(ret, 0);
+	ASSERT_EQ(buffer->cpages, npages);
+
+	/* Check what the device read. */
+	for (i =3D 0, ptr =3D buffer->mirror; i < size / sizeof(*ptr); ++i)
+		ASSERT_EQ(ptr[i], i);
+
+	/* Fault pages back to system memory and check them. */
+	for (i =3D 0, ptr =3D buffer->ptr; i < size / sizeof(*ptr); ++i)
+		ASSERT_EQ(ptr[i], i);
+
+	hmm_buffer_free(buffer);
+}
+
+/*
+ * Try to migrate various memory types to device private memory.
+ */
+TEST_F(hmm2, migrate_mixed)
+{
+	struct hmm_buffer *buffer;
+	unsigned long npages;
+	unsigned long size;
+	int *ptr;
+	unsigned char *p;
+	int ret;
+	int val;
+
+	npages =3D 6;
+	size =3D npages << self->page_shift;
+
+	buffer =3D malloc(sizeof(*buffer));
+	ASSERT_NE(buffer, NULL);
+
+	buffer->fd =3D -1;
+	buffer->size =3D size;
+	buffer->mirror =3D malloc(size);
+	ASSERT_NE(buffer->mirror, NULL);
+
+	/* Reserve a range of addresses. */
+	buffer->ptr =3D mmap(NULL, size,
+			   PROT_NONE,
+			   MAP_PRIVATE | MAP_ANONYMOUS,
+			   buffer->fd, 0);
+	ASSERT_NE(buffer->ptr, MAP_FAILED);
+	p =3D buffer->ptr;
+
+	/* Migrating a protected area should be an error. */
+	ret =3D hmm_dmirror_cmd(self->fd1, HMM_DMIRROR_MIGRATE, buffer, npages);
+	ASSERT_EQ(ret, -EINVAL);
+
+	/* Punch a hole after the first page address. */
+	ret =3D munmap(buffer->ptr + self->page_size, self->page_size);
+	ASSERT_EQ(ret, 0);
+
+	/* We expect an error if the vma doesn't cover the range. */
+	ret =3D hmm_dmirror_cmd(self->fd1, HMM_DMIRROR_MIGRATE, buffer, 3);
+	ASSERT_EQ(ret, -EINVAL);
+
+	/* Page 2 will be a read-only zero page. */
+	ret =3D mprotect(buffer->ptr + 2 * self->page_size, self->page_size,
+				PROT_READ);
+	ASSERT_EQ(ret, 0);
+	ptr =3D (int *)(buffer->ptr + 2 * self->page_size);
+	val =3D *ptr + 3;
+	ASSERT_EQ(val, 3);
+
+	/* Page 3 will be read-only. */
+	ret =3D mprotect(buffer->ptr + 3 * self->page_size, self->page_size,
+				PROT_READ | PROT_WRITE);
+	ASSERT_EQ(ret, 0);
+	ptr =3D (int *)(buffer->ptr + 3 * self->page_size);
+	*ptr =3D val;
+	ret =3D mprotect(buffer->ptr + 3 * self->page_size, self->page_size,
+				PROT_READ);
+	ASSERT_EQ(ret, 0);
+
+	/* Page 4-5 will be read-write. */
+	ret =3D mprotect(buffer->ptr + 4 * self->page_size, 2 * self->page_size,
+				PROT_READ | PROT_WRITE);
+	ASSERT_EQ(ret, 0);
+	ptr =3D (int *)(buffer->ptr + 4 * self->page_size);
+	*ptr =3D val;
+	ptr =3D (int *)(buffer->ptr + 5 * self->page_size);
+	*ptr =3D val;
+
+	/* Now try to migrate pages 2-5 to device 1. */
+	buffer->ptr =3D p + 2 * self->page_size;
+	ret =3D hmm_dmirror_cmd(self->fd1, HMM_DMIRROR_MIGRATE, buffer, 4);
+	ASSERT_EQ(ret, 0);
+	ASSERT_EQ(buffer->cpages, 4);
+
+	/* Page 5 won't be migrated to device 0 because it's on device 1. */
+	buffer->ptr =3D p + 5 * self->page_size;
+	ret =3D hmm_dmirror_cmd(self->fd0, HMM_DMIRROR_MIGRATE, buffer, 1);
+	ASSERT_EQ(ret, -ENOENT);
+	buffer->ptr =3D p;
+
+	buffer->ptr =3D p;
+	hmm_buffer_free(buffer);
+}
+
+/*
+ * Migrate anonymous memory to device private memory and fault it back to =
system
+ * memory multiple times.
+ */
+TEST_F(hmm, migrate_multiple)
+{
+	struct hmm_buffer *buffer;
+	unsigned long npages;
+	unsigned long size;
+	unsigned long i;
+	unsigned long c;
+	int *ptr;
+	int ret;
+
+	npages =3D ALIGN(HMM_BUFFER_SIZE, self->page_size) >> self->page_shift;
+	ASSERT_NE(npages, 0);
+	size =3D npages << self->page_shift;
+
+	for (c =3D 0; c < NTIMES; c++) {
+		buffer =3D malloc(sizeof(*buffer));
+		ASSERT_NE(buffer, NULL);
+
+		buffer->fd =3D -1;
+		buffer->size =3D size;
+		buffer->mirror =3D malloc(size);
+		ASSERT_NE(buffer->mirror, NULL);
+
+		buffer->ptr =3D mmap(NULL, size,
+				   PROT_READ | PROT_WRITE,
+				   MAP_PRIVATE | MAP_ANONYMOUS,
+				   buffer->fd, 0);
+		ASSERT_NE(buffer->ptr, MAP_FAILED);
+
+		/* Initialize buffer in system memory. */
+		for (i =3D 0, ptr =3D buffer->ptr; i < size / sizeof(*ptr); ++i)
+			ptr[i] =3D i;
+
+		/* Migrate memory to device. */
+		ret =3D hmm_dmirror_cmd(self->fd, HMM_DMIRROR_MIGRATE, buffer,
+				      npages);
+		ASSERT_EQ(ret, 0);
+		ASSERT_EQ(buffer->cpages, npages);
+
+		/* Check what the device read. */
+		for (i =3D 0, ptr =3D buffer->mirror; i < size / sizeof(*ptr); ++i)
+			ASSERT_EQ(ptr[i], i);
+
+		/* Fault pages back to system memory and check them. */
+		for (i =3D 0, ptr =3D buffer->ptr; i < size / sizeof(*ptr); ++i)
+			ASSERT_EQ(ptr[i], i);
+
+		hmm_buffer_free(buffer);
+	}
+}
+
+/*
+ * Read anonymous memory multiple times.
+ */
+TEST_F(hmm, anon_read_multiple)
+{
+	struct hmm_buffer *buffer;
+	unsigned long npages;
+	unsigned long size;
+	unsigned long i;
+	unsigned long c;
+	int *ptr;
+	int ret;
+
+	npages =3D ALIGN(HMM_BUFFER_SIZE, self->page_size) >> self->page_shift;
+	ASSERT_NE(npages, 0);
+	size =3D npages << self->page_shift;
+
+	for (c =3D 0; c < NTIMES; c++) {
+		buffer =3D malloc(sizeof(*buffer));
+		ASSERT_NE(buffer, NULL);
+
+		buffer->fd =3D -1;
+		buffer->size =3D size;
+		buffer->mirror =3D malloc(size);
+		ASSERT_NE(buffer->mirror, NULL);
+
+		buffer->ptr =3D mmap(NULL, size,
+				   PROT_READ | PROT_WRITE,
+				   MAP_PRIVATE | MAP_ANONYMOUS,
+				   buffer->fd, 0);
+		ASSERT_NE(buffer->ptr, MAP_FAILED);
+
+		/* Initialize buffer in system memory. */
+		for (i =3D 0, ptr =3D buffer->ptr; i < size / sizeof(*ptr); ++i)
+			ptr[i] =3D i + c;
+
+		/* Simulate a device reading system memory. */
+		ret =3D hmm_dmirror_cmd(self->fd, HMM_DMIRROR_READ, buffer,
+				      npages);
+		ASSERT_EQ(ret, 0);
+		ASSERT_EQ(buffer->cpages, npages);
+		ASSERT_EQ(buffer->faults, 1);
+
+		/* Check what the device read. */
+		for (i =3D 0, ptr =3D buffer->mirror; i < size / sizeof(*ptr); ++i)
+			ASSERT_EQ(ptr[i], i + c);
+
+		hmm_buffer_free(buffer);
+	}
+}
+
+void *unmap_buffer(void *p)
+{
+	struct hmm_buffer *buffer =3D p;
+
+	/* Delay for a bit and then unmap buffer while it is being read. */
+	hmm_nanosleep(hmm_random() % 32000);
+	munmap(buffer->ptr + buffer->size / 2, buffer->size / 2);
+	buffer->ptr =3D NULL;
+
+	return NULL;
+}
+
+/*
+ * Try reading anonymous memory while it is being unmapped.
+ */
+TEST_F(hmm, anon_teardown)
+{
+	unsigned long npages;
+	unsigned long size;
+	unsigned long c;
+	void *ret;
+
+	npages =3D ALIGN(HMM_BUFFER_SIZE, self->page_size) >> self->page_shift;
+	ASSERT_NE(npages, 0);
+	size =3D npages << self->page_shift;
+
+	for (c =3D 0; c < NTIMES; ++c) {
+		pthread_t thread;
+		struct hmm_buffer *buffer;
+		unsigned long i;
+		int *ptr;
+		int rc;
+
+		buffer =3D malloc(sizeof(*buffer));
+		ASSERT_NE(buffer, NULL);
+
+		buffer->fd =3D -1;
+		buffer->size =3D size;
+		buffer->mirror =3D malloc(size);
+		ASSERT_NE(buffer->mirror, NULL);
+
+		buffer->ptr =3D mmap(NULL, size,
+				   PROT_READ | PROT_WRITE,
+				   MAP_PRIVATE | MAP_ANONYMOUS,
+				   buffer->fd, 0);
+		ASSERT_NE(buffer->ptr, MAP_FAILED);
+
+		/* Initialize buffer in system memory. */
+		for (i =3D 0, ptr =3D buffer->ptr; i < size / sizeof(*ptr); ++i)
+			ptr[i] =3D i + c;
+
+		rc =3D pthread_create(&thread, NULL, unmap_buffer, buffer);
+		ASSERT_EQ(rc, 0);
+
+		/* Simulate a device reading system memory. */
+		rc =3D hmm_dmirror_cmd(self->fd, HMM_DMIRROR_READ, buffer,
+				     npages);
+		if (rc =3D=3D 0) {
+			ASSERT_EQ(buffer->cpages, npages);
+			ASSERT_EQ(buffer->faults, 1);
+
+			/* Check what the device read. */
+			for (i =3D 0, ptr =3D buffer->mirror;
+			     i < size / sizeof(*ptr);
+			     ++i)
+				ASSERT_EQ(ptr[i], i + c);
+		}
+
+		pthread_join(thread, &ret);
+		hmm_buffer_free(buffer);
+	}
+}
+
+/*
+ * Test memory snapshot without faulting in pages accessed by the device.
+ */
+TEST_F(hmm2, snapshot)
+{
+	struct hmm_buffer *buffer;
+	unsigned long npages;
+	unsigned long size;
+	int *ptr;
+	unsigned char *p;
+	unsigned char *m;
+	int ret;
+	int val;
+
+	npages =3D 7;
+	size =3D npages << self->page_shift;
+
+	buffer =3D malloc(sizeof(*buffer));
+	ASSERT_NE(buffer, NULL);
+
+	buffer->fd =3D -1;
+	buffer->size =3D size;
+	buffer->mirror =3D malloc(npages);
+	ASSERT_NE(buffer->mirror, NULL);
+
+	/* Reserve a range of addresses. */
+	buffer->ptr =3D mmap(NULL, size,
+			   PROT_NONE,
+			   MAP_PRIVATE | MAP_ANONYMOUS,
+			   buffer->fd, 0);
+	ASSERT_NE(buffer->ptr, MAP_FAILED);
+	p =3D buffer->ptr;
+
+	/* Punch a hole after the first page address. */
+	ret =3D munmap(buffer->ptr + self->page_size, self->page_size);
+	ASSERT_EQ(ret, 0);
+
+	/* Page 2 will be read-only zero page. */
+	ret =3D mprotect(buffer->ptr + 2 * self->page_size, self->page_size,
+				PROT_READ);
+	ASSERT_EQ(ret, 0);
+	ptr =3D (int *)(buffer->ptr + 2 * self->page_size);
+	val =3D *ptr + 3;
+	ASSERT_EQ(val, 3);
+
+	/* Page 3 will be read-only. */
+	ret =3D mprotect(buffer->ptr + 3 * self->page_size, self->page_size,
+				PROT_READ | PROT_WRITE);
+	ASSERT_EQ(ret, 0);
+	ptr =3D (int *)(buffer->ptr + 3 * self->page_size);
+	*ptr =3D val;
+	ret =3D mprotect(buffer->ptr + 3 * self->page_size, self->page_size,
+				PROT_READ);
+	ASSERT_EQ(ret, 0);
+
+	/* Page 4-6 will be read-write. */
+	ret =3D mprotect(buffer->ptr + 4 * self->page_size, 3 * self->page_size,
+				PROT_READ | PROT_WRITE);
+	ASSERT_EQ(ret, 0);
+	ptr =3D (int *)(buffer->ptr + 4 * self->page_size);
+	*ptr =3D val;
+
+	/* Page 5 will be migrated to device 0. */
+	buffer->ptr =3D p + 5 * self->page_size;
+	ret =3D hmm_dmirror_cmd(self->fd0, HMM_DMIRROR_MIGRATE, buffer, 1);
+	ASSERT_EQ(ret, 0);
+	ASSERT_EQ(buffer->cpages, 1);
+
+	/* Page 6 will be migrated to device 1. */
+	buffer->ptr =3D p + 6 * self->page_size;
+	ret =3D hmm_dmirror_cmd(self->fd1, HMM_DMIRROR_MIGRATE, buffer, 1);
+	ASSERT_EQ(ret, 0);
+	ASSERT_EQ(buffer->cpages, 1);
+
+	/* Simulate a device snapshotting CPU pagetables. */
+	buffer->ptr =3D p;
+	ret =3D hmm_dmirror_cmd(self->fd0, HMM_DMIRROR_SNAPSHOT, buffer, npages);
+	ASSERT_EQ(ret, 0);
+	ASSERT_EQ(buffer->cpages, npages);
+
+	/* Check what the device saw. */
+	m =3D buffer->mirror;
+	ASSERT_EQ(m[0], HMM_DMIRROR_PROT_ERROR);
+	ASSERT_EQ(m[1], HMM_DMIRROR_PROT_ERROR);
+	ASSERT_EQ(m[2], HMM_DMIRROR_PROT_ZERO | HMM_DMIRROR_PROT_READ);
+	ASSERT_EQ(m[3], HMM_DMIRROR_PROT_READ);
+	ASSERT_EQ(m[4], HMM_DMIRROR_PROT_WRITE);
+	ASSERT_EQ(m[5], HMM_DMIRROR_PROT_DEV_PRIVATE_LOCAL |
+			HMM_DMIRROR_PROT_WRITE);
+	ASSERT_EQ(m[6], HMM_DMIRROR_PROT_NONE);
+
+	hmm_buffer_free(buffer);
+}
+
+/*
+ * Test two devices reading the same memory (double mapped).
+ */
+TEST_F(hmm2, double_map)
+{
+	struct hmm_buffer *buffer;
+	unsigned long npages;
+	unsigned long size;
+	unsigned long i;
+	int *ptr;
+	int ret;
+
+	npages =3D 6;
+	size =3D npages << self->page_shift;
+
+	buffer =3D malloc(sizeof(*buffer));
+	ASSERT_NE(buffer, NULL);
+
+	buffer->fd =3D -1;
+	buffer->size =3D size;
+	buffer->mirror =3D malloc(npages);
+	ASSERT_NE(buffer->mirror, NULL);
+
+	/* Reserve a range of addresses. */
+	buffer->ptr =3D mmap(NULL, size,
+			   PROT_READ | PROT_WRITE,
+			   MAP_PRIVATE | MAP_ANONYMOUS,
+			   buffer->fd, 0);
+	ASSERT_NE(buffer->ptr, MAP_FAILED);
+
+	/* Initialize buffer in system memory. */
+	for (i =3D 0, ptr =3D buffer->ptr; i < size / sizeof(*ptr); ++i)
+		ptr[i] =3D i;
+
+	/* Make region read-only. */
+	ret =3D mprotect(buffer->ptr, size, PROT_READ);
+	ASSERT_EQ(ret, 0);
+
+	/* Simulate device 0 reading system memory. */
+	ret =3D hmm_dmirror_cmd(self->fd0, HMM_DMIRROR_READ, buffer, npages);
+	ASSERT_EQ(ret, 0);
+	ASSERT_EQ(buffer->cpages, npages);
+	ASSERT_EQ(buffer->faults, 1);
+
+	/* Check what the device read. */
+	for (i =3D 0, ptr =3D buffer->mirror; i < size / sizeof(*ptr); ++i)
+		ASSERT_EQ(ptr[i], i);
+
+	/* Simulate device 1 reading system memory. */
+	ret =3D hmm_dmirror_cmd(self->fd1, HMM_DMIRROR_READ, buffer, npages);
+	ASSERT_EQ(ret, 0);
+	ASSERT_EQ(buffer->cpages, npages);
+	ASSERT_EQ(buffer->faults, 1);
+
+	/* Check what the device read. */
+	for (i =3D 0, ptr =3D buffer->mirror; i < size / sizeof(*ptr); ++i)
+		ASSERT_EQ(ptr[i], i);
+
+	/* Punch a hole after the first page address. */
+	ret =3D munmap(buffer->ptr + self->page_size, self->page_size);
+	ASSERT_EQ(ret, 0);
+
+	hmm_buffer_free(buffer);
+}
+
+TEST_HARNESS_MAIN
diff --git a/tools/testing/selftests/vm/run_vmtests b/tools/testing/selftes=
ts/vm/run_vmtests
index 665009ebfba4..4f0e272285d9 100755
--- a/tools/testing/selftests/vm/run_vmtests
+++ b/tools/testing/selftests/vm/run_vmtests
@@ -307,4 +307,20 @@ else
 	echo "[FAIL]"
 	exitcode=3D1
 fi
+
+echo "running HMM smoke test"
+echo "------------------------------------"
+./test_hmm.sh smoke
+ret_val=3D$?
+
+if [ $ret_val -eq 0 ]; then
+	echo "[PASS]"
+elif [ $ret_val -eq $ksft_skip ]; then
+	echo "[SKIP]"
+	exitcode=3D$ksft_skip
+else
+	echo "[FAIL]"
+	exitcode=3D1
+fi
+
 exit $exitcode
diff --git a/tools/testing/selftests/vm/test_hmm.sh b/tools/testing/selftes=
ts/vm/test_hmm.sh
new file mode 100755
index 000000000000..0647b525a625
--- /dev/null
+++ b/tools/testing/selftests/vm/test_hmm.sh
@@ -0,0 +1,97 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# Copyright (C) 2018 Uladzislau Rezki (Sony) <urezki@gmail.com>
+#
+# This is a test script for the kernel test driver to analyse vmalloc
+# allocator. Therefore it is just a kernel module loader. You can specify
+# and pass different parameters in order to:
+#     a) analyse performance of vmalloc allocations;
+#     b) stressing and stability check of vmalloc subsystem.
+
+TEST_NAME=3D"test_hmm"
+DRIVER=3D"test_hmm"
+
+# 1 if fails
+exitcode=3D1
+
+# Kselftest framework requirement - SKIP code is 4.
+ksft_skip=3D4
+
+check_test_requirements()
+{
+	uid=3D$(id -u)
+	if [ $uid -ne 0 ]; then
+		echo "$0: Must be run as root"
+		exit $ksft_skip
+	fi
+
+	if ! which modprobe > /dev/null 2>&1; then
+		echo "$0: You need modprobe installed"
+		exit $ksft_skip
+	fi
+
+	if ! modinfo $DRIVER > /dev/null 2>&1; then
+		echo "$0: You must have the following enabled in your kernel:"
+		echo "CONFIG_TEST_HMM=3Dm"
+		exit $ksft_skip
+	fi
+}
+
+load_driver()
+{
+	modprobe $DRIVER > /dev/null 2>&1
+	if [ $? =3D=3D 0 ]; then
+		major=3D$(awk "\$2=3D=3D\"HMM_DMIRROR\" {print \$1}" /proc/devices)
+		mknod /dev/hmm_dmirror0 c $major 0
+		mknod /dev/hmm_dmirror1 c $major 1
+	fi
+}
+
+unload_driver()
+{
+	modprobe -r $DRIVER > /dev/null 2>&1
+	rm -f /dev/hmm_dmirror?
+}
+
+run_smoke()
+{
+	echo "Running smoke test. Note, this test provides basic coverage."
+
+	load_driver
+	$(dirname "${BASH_SOURCE[0]}")/hmm-tests
+	unload_driver
+}
+
+usage()
+{
+	echo -n "Usage: $0"
+	echo
+	echo "Example usage:"
+	echo
+	echo "# Shows help message"
+	echo "./${TEST_NAME}.sh"
+	echo
+	echo "# Smoke testing"
+	echo "./${TEST_NAME}.sh smoke"
+	echo
+	exit 0
+}
+
+function run_test()
+{
+	if [ $# -eq 0 ]; then
+		usage
+	else
+		if [ "$1" =3D "smoke" ]; then
+			run_smoke
+		else
+			usage
+		fi
+	fi
+}
+
+check_test_requirements
+run_test $@
+
+exit 0
--=20
2.25.2

