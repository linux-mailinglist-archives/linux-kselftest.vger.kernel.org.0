Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B63C478A10
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Dec 2021 12:34:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233366AbhLQLen (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 17 Dec 2021 06:34:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:34024 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233740AbhLQLem (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 17 Dec 2021 06:34:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639740882;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DoeMhWrfTnNa/IdgPp0GUn3BjAQ1iIVspD+MIaFOgu0=;
        b=a0X4zYiBeyFDFD2aKdckdVQ1bZnFKWaRCZSlAz3y8j+60EgfiQStO65Qj3pBks/3JZD6tR
        WrjHekrFBoMmBaH8ooNX0oBZ6+ZV2QUMxAov+LNS8D3RAZ9VKxQ2svXZrpDGYQ7PHjdE3z
        UMxqL/zSbP2vvsp5OCuNjJRyv9goSYY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-524-Xm9_H4w6OzugWwN2HMQujw-1; Fri, 17 Dec 2021 06:34:39 -0500
X-MC-Unique: Xm9_H4w6OzugWwN2HMQujw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4667036393;
        Fri, 17 Dec 2021 11:34:36 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.39.193.204])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 813D88D5AC;
        Fri, 17 Dec 2021 11:34:25 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Yang Shi <shy828301@gmail.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Nadav Amit <namit@vmware.com>, Rik van Riel <riel@surriel.com>,
        Roman Gushchin <guro@fb.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        Donald Dutile <ddutile@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Oleg Nesterov <oleg@redhat.com>, Jan Kara <jack@suse.cz>,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org, David Hildenbrand <david@redhat.com>,
        Shuah Khan <shuah@kernel.org>
Subject: [PATCH v1 11/11] selftests/vm: add tests for the known COW security issues
Date:   Fri, 17 Dec 2021 12:30:49 +0100
Message-Id: <20211217113049.23850-12-david@redhat.com>
In-Reply-To: <20211217113049.23850-1-david@redhat.com>
References: <20211217113049.23850-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Let's make sure the security issue / MAP_PRIVATE violation of POSIX
semantics doesn't reappear again using variations of the original
vmsplice reproducer. Ideally, we'd also be test some more cases with
R/O long-term pinnings -- but the existing mechanisms like RDMA or VFIO
require rather complicated setups not suitable for simple selftests.

In the future we might be able to add some O_DIRECT test and maybe
extend the gup tests in the kernel accordingly.

Using barrier() is a little clunky, but "volatile" seems to be in
general frowned upon and makes checkpatch angry.

Cc: Shuah Khan <shuah@kernel.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 tools/testing/selftests/vm/Makefile       |   1 +
 tools/testing/selftests/vm/gup_cow.c      | 312 ++++++++++++++++++++++
 tools/testing/selftests/vm/run_vmtests.sh |  16 ++
 3 files changed, 329 insertions(+)
 create mode 100644 tools/testing/selftests/vm/gup_cow.c

diff --git a/tools/testing/selftests/vm/Makefile b/tools/testing/selftests/vm/Makefile
index 1607322a112c..dad6037d735f 100644
--- a/tools/testing/selftests/vm/Makefile
+++ b/tools/testing/selftests/vm/Makefile
@@ -27,6 +27,7 @@ CFLAGS = -Wall -I ../../../../usr/include $(EXTRA_CFLAGS)
 LDLIBS = -lrt -lpthread
 TEST_GEN_FILES = compaction_test
 TEST_GEN_FILES += gup_test
+TEST_GEN_FILES += gup_cow
 TEST_GEN_FILES += hmm-tests
 TEST_GEN_FILES += hugepage-mmap
 TEST_GEN_FILES += hugepage-mremap
diff --git a/tools/testing/selftests/vm/gup_cow.c b/tools/testing/selftests/vm/gup_cow.c
new file mode 100644
index 000000000000..9d44ed2ffdfc
--- /dev/null
+++ b/tools/testing/selftests/vm/gup_cow.c
@@ -0,0 +1,312 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * GUP (Get User Pages) interaction with COW (Copy On Write) tests.
+ *
+ * Copyright 2021, Red Hat, Inc.
+ *
+ * Author(s): David Hildenbrand <david@redhat.com>
+ */
+#define _GNU_SOURCE
+#include <stdlib.h>
+#include <string.h>
+#include <stdbool.h>
+#include <stdint.h>
+#include <unistd.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <sys/mman.h>
+#include <sys/wait.h>
+
+#include "../kselftest.h"
+
+#define barrier() asm volatile("" ::: "memory")
+
+static size_t pagesize;
+static size_t thpsize;
+static size_t hugetlbsize;
+
+struct shared_mem {
+	bool parent_ready;
+	bool child_ready;
+};
+struct shared_mem *shared;
+
+static size_t detect_thpsize(void)
+{
+	int fd = open("/sys/kernel/mm/transparent_hugepage/hpage_pmd_size",
+		      O_RDONLY);
+	size_t size = 0;
+	char buf[15];
+	int ret;
+
+	if (fd < 0)
+		return 0;
+
+	ret = pread(fd, buf, sizeof(buf), 0);
+	if (ret < 0 || ret == sizeof(buf))
+		goto out;
+	buf[ret] = 0;
+
+	size = strtoul(buf, NULL, 10);
+out:
+	close(fd);
+	if (size < pagesize)
+		size = 0;
+	return size;
+}
+
+static uint64_t pagemap_get_entry(int fd, void *addr)
+{
+	const unsigned long pfn = (unsigned long)addr / pagesize;
+	uint64_t entry;
+	int ret;
+
+	ret = pread(fd, &entry, sizeof(entry), pfn * sizeof(entry));
+	if (ret != sizeof(entry))
+		ksft_exit_fail_msg("reading pagemap failed\n");
+	return entry;
+}
+
+static bool page_is_populated(void *addr)
+{
+	int fd = open("/proc/self/pagemap", O_RDONLY);
+	uint64_t entry;
+	bool ret;
+
+	if (fd < 0)
+		ksft_exit_fail_msg("opening pagemap failed\n");
+
+	/* Present or swapped. */
+	entry = pagemap_get_entry(fd, addr);
+	ret = !!(entry & 0xc000000000000000ull);
+	close(fd);
+	return ret;
+}
+
+static int child_vmsplice_fn(unsigned char *mem, size_t size)
+{
+	struct iovec iov = {
+		.iov_base = mem,
+		.iov_len = size,
+	};
+	size_t cur, total, transferred;
+	char *old, *new;
+	int fds[2];
+
+	old = malloc(size);
+	new = malloc(size);
+
+	/* Backup the original content. */
+	memcpy(old, mem, size);
+
+	if (pipe(fds) < 0)
+		return -errno;
+
+	/* Trigger a read-only pin. */
+	transferred = vmsplice(fds[1], &iov, 1, 0);
+	if (transferred < 0)
+		return -errno;
+	if (transferred == 0)
+		return -EINVAL;
+
+	/* Unmap it from our page tables. */
+	if (munmap(mem, size) < 0)
+		return -errno;
+
+	/* Wait until the parent modified it. */
+	barrier();
+	shared->child_ready = true;
+	barrier();
+	while (!shared->parent_ready)
+		barrier();
+	barrier();
+
+	/* See if we still read the old values. */
+	total = 0;
+	while (total < transferred) {
+		cur = read(fds[0], new + total, transferred - total);
+		if (cur < 0)
+			return -errno;
+		total += cur;
+	}
+
+	return memcmp(old, new, transferred);
+}
+
+static void test_child_ro_gup(unsigned char *mem, size_t size)
+{
+	int ret;
+
+	/* Populate the page. */
+	memset(mem, 0, size);
+
+	shared->parent_ready = false;
+	shared->child_ready = false;
+	barrier();
+
+	ret = fork();
+	if (ret < 0) {
+		ksft_exit_fail_msg("fork failed\n");
+	} else if (!ret) {
+		ret = child_vmsplice_fn(mem, size);
+		exit(ret);
+	}
+
+	barrier();
+	while (!shared->child_ready)
+		barrier();
+	/* Modify the page. */
+	barrier();
+	memset(mem, 0xff, size);
+	barrier();
+	shared->parent_ready = true;
+
+	wait(&ret);
+	if (WIFEXITED(ret))
+		ret = WEXITSTATUS(ret);
+	else
+		ret = -EINVAL;
+
+	ksft_test_result(!ret, "child has correct MAP_PRIVATE semantics\n");
+}
+
+static void test_anon_ro_gup_child(void)
+{
+	unsigned char *mem;
+	int ret;
+
+	ksft_print_msg("[RUN] %s\n", __func__);
+
+	mem = mmap(NULL, pagesize, PROT_READ | PROT_WRITE,
+		   MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+	if (mem == MAP_FAILED) {
+		ksft_test_result_fail("mmap failed\n");
+		return;
+	}
+
+	ret = madvise(mem, pagesize, MADV_NOHUGEPAGE);
+	/* Ignore if not around on a kernel. */
+	if (ret && ret != -EINVAL) {
+		ksft_test_result_fail("madvise failed\n");
+		goto out;
+	}
+
+	test_child_ro_gup(mem, pagesize);
+out:
+	munmap(mem, pagesize);
+}
+
+static void test_anon_thp_ro_gup_child(void)
+{
+	unsigned char *mem, *mmap_mem;
+	size_t mmap_size;
+	int ret;
+
+	ksft_print_msg("[RUN] %s\n", __func__);
+
+	if (!thpsize)
+		ksft_test_result_skip("THP size not detected\n");
+
+	mmap_size = 2 * thpsize;
+	mmap_mem = mmap(NULL, mmap_size, PROT_READ | PROT_WRITE,
+			MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+	if (mmap_mem == MAP_FAILED) {
+		ksft_test_result_fail("mmap failed\n");
+		return;
+	}
+
+	mem = (unsigned char *)(((uintptr_t)mmap_mem + thpsize) & ~(thpsize - 1));
+
+	ret = madvise(mem, thpsize, MADV_HUGEPAGE);
+	if (ret) {
+		ksft_test_result_fail("madvise(MADV_HUGEPAGE) failed\n");
+		goto out;
+	}
+
+	/*
+	 * Touch the first sub-page and test of we get another sub-page
+	 * populated.
+	 */
+	mem[0] = 0;
+	if (!page_is_populated(mem + pagesize)) {
+		ksft_test_result_skip("Did not get a THP populated\n");
+		goto out;
+	}
+
+	test_child_ro_gup(mem, thpsize);
+out:
+	munmap(mmap_mem, mmap_size);
+}
+
+static void test_anon_hugetlb_ro_gup_child(void)
+{
+	unsigned char *mem, *dummy;
+
+	ksft_print_msg("[RUN] %s\n", __func__);
+
+	if (!hugetlbsize)
+		ksft_test_result_skip("hugetlb size not detected\n");
+
+	ksft_print_msg("[INFO] Assuming hugetlb size of %zd bytes\n",
+			hugetlbsize);
+
+	mem = mmap(NULL, hugetlbsize, PROT_READ | PROT_WRITE,
+		   MAP_PRIVATE | MAP_ANONYMOUS | MAP_HUGETLB, -1, 0);
+	if (mem == MAP_FAILED) {
+		ksft_test_result_skip("need more free huge pages\n");
+		return;
+	}
+
+	/*
+	 * We need a total of two hugetlb pages to handle COW/unsharing
+	 * properly.
+	 */
+	dummy = mmap(NULL, hugetlbsize, PROT_READ | PROT_WRITE,
+		     MAP_PRIVATE | MAP_ANONYMOUS | MAP_HUGETLB, -1, 0);
+	if (dummy == MAP_FAILED) {
+		ksft_test_result_skip("need more free huge pages\n");
+		goto out;
+	}
+	munmap(dummy, hugetlbsize);
+
+	test_child_ro_gup(mem, hugetlbsize);
+out:
+	munmap(mem, hugetlbsize);
+}
+
+int main(int argc, char **argv)
+{
+	int err;
+
+	pagesize = getpagesize();
+	thpsize = detect_thpsize();
+	/* For simplicity, we'll rely on the thp size. */
+	hugetlbsize = thpsize;
+
+	ksft_print_header();
+	ksft_set_plan(3);
+
+	/* We need an easy way to talk to our child. */
+	shared = mmap(NULL, pagesize, PROT_READ | PROT_WRITE, MAP_SHARED | MAP_ANONYMOUS, -1, 0);
+	if (shared == MAP_FAILED)
+		ksft_exit_fail_msg("mmap(MAP_SHARED)\n");
+
+	/*
+	 * Tests for the security issue reported by Jann Horn that originally
+	 * resulted in CVE-2020-29374. More generally, it's a violation of
+	 * POSIX MAP_PRIVATE semantics, because some other process can modify
+	 * pages that are supposed to be private to one process.
+	 *
+	 * So let's test that process-private pages stay private using the
+	 * known vmsplice reproducer.
+	 */
+	test_anon_ro_gup_child();
+	test_anon_thp_ro_gup_child();
+	test_anon_hugetlb_ro_gup_child();
+
+	err = ksft_get_fail_cnt();
+	if (err)
+		ksft_exit_fail_msg("%d out of %d tests failed\n",
+				   err, ksft_test_num());
+	return ksft_exit_pass();
+}
diff --git a/tools/testing/selftests/vm/run_vmtests.sh b/tools/testing/selftests/vm/run_vmtests.sh
index a24d30af3094..80e441e0ae45 100755
--- a/tools/testing/selftests/vm/run_vmtests.sh
+++ b/tools/testing/selftests/vm/run_vmtests.sh
@@ -168,6 +168,22 @@ else
 	echo "[PASS]"
 fi
 
+echo "--------------------------------------------------------"
+echo "running "GUP interaction with COW tests.
+echo "--------------------------------------------------------"
+./gup_cow
+ret_val=$?
+
+if [ $ret_val -eq 0 ]; then
+	echo "[PASS]"
+elif [ $ret_val -eq $ksft_skip ]; then
+	echo "[SKIP]"
+	exitcode=$ksft_skip
+else
+	echo "[FAIL]"
+	exitcode=1
+fi
+
 echo "-------------------"
 echo "running userfaultfd"
 echo "-------------------"
-- 
2.31.1

