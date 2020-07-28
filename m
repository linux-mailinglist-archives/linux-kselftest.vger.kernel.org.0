Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95EA3230757
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Jul 2020 12:09:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728305AbgG1KJJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 28 Jul 2020 06:09:09 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:50626 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727973AbgG1KJJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 28 Jul 2020 06:09:09 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: rcn)
        with ESMTPSA id 51753296389
From:   =?UTF-8?q?Ricardo=20Ca=C3=B1uelo?= <ricardo.canuelo@collabora.com>
To:     akpm@linux-foundation.org
Cc:     kernel@collabora.com, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH] selftests: add mincore() tests
Date:   Tue, 28 Jul 2020 12:04:50 +0200
Message-Id: <20200728100450.4065-1-ricardo.canuelo@collabora.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add a test suite for the mincore() syscall. It tests most of its use
cases as well as its interface.

Tests implemented:

  - basic interface test
  - behavior on anonymous mappings
  - behavior on anonymous mappings with huge tlb pages
  - file-backed mapping with a regular file
  - file-backed mapping with a tmpfs file

Signed-off-by: Ricardo Cañuelo <ricardo.canuelo@collabora.com>
---
Tested in next-20200727 with:

    make -C tools/testing/selftests

and

    make -C tools/testing/selftests run_tests

 tools/testing/selftests/Makefile              |   1 +
 tools/testing/selftests/mincore/.gitignore    |   2 +
 tools/testing/selftests/mincore/Makefile      |   6 +
 .../selftests/mincore/mincore_selftest.c      | 361 ++++++++++++++++++
 4 files changed, 370 insertions(+)
 create mode 100644 tools/testing/selftests/mincore/.gitignore
 create mode 100644 tools/testing/selftests/mincore/Makefile
 create mode 100644 tools/testing/selftests/mincore/mincore_selftest.c

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index e03bc15ce731..9018f45d631d 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -32,6 +32,7 @@ TARGETS += lkdtm
 TARGETS += membarrier
 TARGETS += memfd
 TARGETS += memory-hotplug
+TARGETS += mincore
 TARGETS += mount
 TARGETS += mqueue
 TARGETS += net
diff --git a/tools/testing/selftests/mincore/.gitignore b/tools/testing/selftests/mincore/.gitignore
new file mode 100644
index 000000000000..15c4dfc2df00
--- /dev/null
+++ b/tools/testing/selftests/mincore/.gitignore
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0+
+mincore_selftest
diff --git a/tools/testing/selftests/mincore/Makefile b/tools/testing/selftests/mincore/Makefile
new file mode 100644
index 000000000000..38c7db1e8926
--- /dev/null
+++ b/tools/testing/selftests/mincore/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0+
+
+CFLAGS += -Wall
+
+TEST_GEN_PROGS := mincore_selftest
+include ../lib.mk
diff --git a/tools/testing/selftests/mincore/mincore_selftest.c b/tools/testing/selftests/mincore/mincore_selftest.c
new file mode 100644
index 000000000000..5a1e85ff5d32
--- /dev/null
+++ b/tools/testing/selftests/mincore/mincore_selftest.c
@@ -0,0 +1,361 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * kselftest suite for mincore().
+ *
+ * Copyright (C) 2020 Collabora, Ltd.
+ */
+
+#define _GNU_SOURCE
+
+#include <stdio.h>
+#include <errno.h>
+#include <unistd.h>
+#include <stdlib.h>
+#include <sys/mman.h>
+#include <string.h>
+#include <fcntl.h>
+#include <string.h>
+
+#include "../kselftest.h"
+#include "../kselftest_harness.h"
+
+/* Default test file size: 4MB */
+#define MB (1UL << 20)
+#define FILE_SIZE (4 * MB)
+
+
+/*
+ * Tests the user interface. This test triggers most of the documented
+ * error conditions in mincore().
+ */
+TEST(basic_interface)
+{
+	int retval;
+	int page_size;
+	unsigned char vec[1];
+	char *addr;
+
+	page_size = sysconf(_SC_PAGESIZE);
+
+	/* Query a 0 byte sized range */
+	retval = mincore(0, 0, vec);
+	EXPECT_EQ(0, retval);
+
+	/* Addresses in the specified range are invalid or unmapped */
+	errno = 0;
+	retval = mincore(NULL, page_size, vec);
+	EXPECT_EQ(-1, retval);
+	EXPECT_EQ(ENOMEM, errno);
+
+	errno = 0;
+	addr = mmap(NULL, page_size, PROT_READ | PROT_WRITE,
+		MAP_SHARED | MAP_ANONYMOUS, -1, 0);
+	ASSERT_NE(MAP_FAILED, addr) {
+		TH_LOG("mmap error: %s", strerror(errno));
+	}
+
+	/* <addr> argument is not page-aligned */
+	errno = 0;
+	retval = mincore(addr + 1, page_size, vec);
+	EXPECT_EQ(-1, retval);
+	EXPECT_EQ(EINVAL, errno);
+
+	/* <length> argument is too large */
+	errno = 0;
+	retval = mincore(addr, -1, vec);
+	EXPECT_EQ(-1, retval);
+	EXPECT_EQ(ENOMEM, errno);
+
+	/* <vec> argument points to an illegal address */
+	errno = 0;
+	retval = mincore(addr, page_size, NULL);
+	EXPECT_EQ(-1, retval);
+	EXPECT_EQ(EFAULT, errno);
+	munmap(addr, page_size);
+}
+
+
+/*
+ * Test mincore() behavior on a private anonymous page mapping.
+ * Check that the page is not loaded into memory right after the mapping
+ * but after accessing it (on-demand allocation).
+ * Then free the page and check that it's not memory-resident.
+ */
+TEST(check_anonymous_locked_pages)
+{
+	unsigned char vec[1];
+	char *addr;
+	int retval;
+	int page_size;
+
+	page_size = sysconf(_SC_PAGESIZE);
+
+	/* Map one page and check it's not memory-resident */
+	errno = 0;
+	addr = mmap(NULL, page_size, PROT_READ | PROT_WRITE,
+			MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+	ASSERT_NE(MAP_FAILED, addr) {
+		TH_LOG("mmap error: %s", strerror(errno));
+	}
+	retval = mincore(addr, page_size, vec);
+	ASSERT_EQ(0, retval);
+	ASSERT_EQ(0, vec[0]) {
+		TH_LOG("Page found in memory before use");
+	}
+
+	/* Touch the page and check again. It should now be in memory */
+	addr[0] = 1;
+	mlock(addr, page_size);
+	retval = mincore(addr, page_size, vec);
+	ASSERT_EQ(0, retval);
+	ASSERT_EQ(1, vec[0]) {
+		TH_LOG("Page not found in memory after use");
+	}
+
+	/*
+	 * It shouldn't be memory-resident after unlocking it and
+	 * marking it as unneeded.
+	 */
+	munlock(addr, page_size);
+	madvise(addr, page_size, MADV_DONTNEED);
+	retval = mincore(addr, page_size, vec);
+	ASSERT_EQ(0, retval);
+	ASSERT_EQ(0, vec[0]) {
+		TH_LOG("Page in memory after being zapped");
+	}
+	munmap(addr, page_size);
+}
+
+
+/*
+ * Check mincore() behavior on huge pages.
+ * This test will be skipped if the mapping fails (ie. if there are no
+ * huge pages available).
+ *
+ * Make sure the system has at least one free huge page, check
+ * "HugePages_Free" in /proc/meminfo.
+ * Increment /sys/kernel/mm/hugepages/hugepages-2048kB/nr_hugepages if
+ * needed.
+ */
+TEST(check_huge_pages)
+{
+	unsigned char vec[1];
+	char *addr;
+	int retval;
+	int page_size;
+
+	page_size = sysconf(_SC_PAGESIZE);
+
+	errno = 0;
+	addr = mmap(NULL, page_size, PROT_READ | PROT_WRITE,
+		MAP_PRIVATE | MAP_ANONYMOUS | MAP_HUGETLB,
+		-1, 0);
+	if (addr == MAP_FAILED) {
+		if (errno == ENOMEM)
+			SKIP(return, "No huge pages available.");
+		else
+			TH_LOG("mmap error: %s", strerror(errno));
+	}
+	retval = mincore(addr, page_size, vec);
+	ASSERT_EQ(0, retval);
+	ASSERT_EQ(0, vec[0]) {
+		TH_LOG("Page found in memory before use");
+	}
+
+	addr[0] = 1;
+	mlock(addr, page_size);
+	retval = mincore(addr, page_size, vec);
+	ASSERT_EQ(0, retval);
+	ASSERT_EQ(1, vec[0]) {
+		TH_LOG("Page not found in memory after use");
+	}
+
+	munlock(addr, page_size);
+	munmap(addr, page_size);
+}
+
+
+/*
+ * Test mincore() behavior on a file-backed page.
+ * No pages should be loaded into memory right after the mapping. Then,
+ * accessing any address in the mapping range should load the page
+ * containing the address and a number of subsequent pages (readahead).
+ *
+ * The actual readahead settings depend on the test environment, so we
+ * can't make a lot of assumptions about that. This test covers the most
+ * general cases.
+ */
+TEST(check_file_mmap)
+{
+	unsigned char *vec;
+	int vec_size;
+	char *addr;
+	int retval;
+	int page_size;
+	int fd;
+	int i;
+	int ra_pages = 0;
+
+	page_size = sysconf(_SC_PAGESIZE);
+	vec_size = FILE_SIZE / page_size;
+	if (FILE_SIZE % page_size)
+		vec_size++;
+
+	vec = calloc(vec_size, sizeof(unsigned char));
+	ASSERT_NE(NULL, vec) {
+		TH_LOG("Can't allocate array");
+	}
+
+	errno = 0;
+	fd = open(".", O_TMPFILE | O_RDWR, 0600);
+	ASSERT_NE(-1, fd) {
+		TH_LOG("Can't create temporary file: %s",
+			strerror(errno));
+	}
+	errno = 0;
+	retval = fallocate(fd, 0, 0, FILE_SIZE);
+	ASSERT_EQ(0, retval) {
+		TH_LOG("Error allocating space for the temporary file: %s",
+			strerror(errno));
+	}
+
+	/*
+	 * Map the whole file, the pages shouldn't be fetched yet.
+	 */
+	errno = 0;
+	addr = mmap(NULL, FILE_SIZE, PROT_READ | PROT_WRITE,
+			MAP_SHARED, fd, 0);
+	ASSERT_NE(MAP_FAILED, addr) {
+		TH_LOG("mmap error: %s", strerror(errno));
+	}
+	retval = mincore(addr, FILE_SIZE, vec);
+	ASSERT_EQ(0, retval);
+	for (i = 0; i < vec_size; i++) {
+		ASSERT_EQ(0, vec[i]) {
+			TH_LOG("Unexpected page in memory");
+		}
+	}
+
+	/*
+	 * Touch a page in the middle of the mapping. We expect the next
+	 * few pages (the readahead window) to be populated too.
+	 */
+	addr[FILE_SIZE / 2] = 1;
+	retval = mincore(addr, FILE_SIZE, vec);
+	ASSERT_EQ(0, retval);
+	ASSERT_EQ(1, vec[FILE_SIZE / 2 / page_size]) {
+		TH_LOG("Page not found in memory after use");
+	}
+
+	i = FILE_SIZE / 2 / page_size + 1;
+	while (i < vec_size && vec[i]) {
+		ra_pages++;
+		i++;
+	}
+	EXPECT_GT(ra_pages, 0) {
+		TH_LOG("No read-ahead pages found in memory");
+	}
+
+	EXPECT_LT(i, vec_size) {
+		TH_LOG("Read-ahead pages reached the end of the file");
+	}
+	/*
+	 * End of the readahead window. The rest of the pages shouldn't
+	 * be in memory.
+	 */
+	if (i < vec_size) {
+		while (i < vec_size && !vec[i])
+			i++;
+		EXPECT_EQ(vec_size, i) {
+			TH_LOG("Unexpected page in memory beyond readahead window");
+		}
+	}
+
+	munmap(addr, FILE_SIZE);
+	close(fd);
+	free(vec);
+}
+
+
+/*
+ * Test mincore() behavior on a page backed by a tmpfs file.  This test
+ * performs the same steps as the previous one. However, we don't expect
+ * any readahead in this case.
+ */
+TEST(check_tmpfs_mmap)
+{
+	unsigned char *vec;
+	int vec_size;
+	char *addr;
+	int retval;
+	int page_size;
+	int fd;
+	int i;
+	int ra_pages = 0;
+
+	page_size = sysconf(_SC_PAGESIZE);
+	vec_size = FILE_SIZE / page_size;
+	if (FILE_SIZE % page_size)
+		vec_size++;
+
+	vec = calloc(vec_size, sizeof(unsigned char));
+	ASSERT_NE(NULL, vec) {
+		TH_LOG("Can't allocate array");
+	}
+
+	errno = 0;
+	fd = open("/dev/shm", O_TMPFILE | O_RDWR, 0600);
+	ASSERT_NE(-1, fd) {
+		TH_LOG("Can't create temporary file: %s",
+			strerror(errno));
+	}
+	errno = 0;
+	retval = fallocate(fd, 0, 0, FILE_SIZE);
+	ASSERT_EQ(0, retval) {
+		TH_LOG("Error allocating space for the temporary file: %s",
+			strerror(errno));
+	}
+
+	/*
+	 * Map the whole file, the pages shouldn't be fetched yet.
+	 */
+	errno = 0;
+	addr = mmap(NULL, FILE_SIZE, PROT_READ | PROT_WRITE,
+			MAP_SHARED, fd, 0);
+	ASSERT_NE(MAP_FAILED, addr) {
+		TH_LOG("mmap error: %s", strerror(errno));
+	}
+	retval = mincore(addr, FILE_SIZE, vec);
+	ASSERT_EQ(0, retval);
+	for (i = 0; i < vec_size; i++) {
+		ASSERT_EQ(0, vec[i]) {
+			TH_LOG("Unexpected page in memory");
+		}
+	}
+
+	/*
+	 * Touch a page in the middle of the mapping. We expect only
+	 * that page to be fetched into memory.
+	 */
+	addr[FILE_SIZE / 2] = 1;
+	retval = mincore(addr, FILE_SIZE, vec);
+	ASSERT_EQ(0, retval);
+	ASSERT_EQ(1, vec[FILE_SIZE / 2 / page_size]) {
+		TH_LOG("Page not found in memory after use");
+	}
+
+	i = FILE_SIZE / 2 / page_size + 1;
+	while (i < vec_size && vec[i]) {
+		ra_pages++;
+		i++;
+	}
+	ASSERT_EQ(ra_pages, 0) {
+		TH_LOG("Read-ahead pages found in memory");
+	}
+
+	munmap(addr, FILE_SIZE);
+	close(fd);
+	free(vec);
+}
+
+TEST_HARNESS_MAIN
-- 
2.18.0

