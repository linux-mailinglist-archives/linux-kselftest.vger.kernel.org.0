Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D0E35EC055
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Sep 2022 13:02:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230209AbiI0LCy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 27 Sep 2022 07:02:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiI0LCS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 27 Sep 2022 07:02:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0623D33C3
        for <linux-kselftest@vger.kernel.org>; Tue, 27 Sep 2022 04:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664276500;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0aObg1zA2tb9BhCwr2yGDyj+WxajEwN0M9mk8JjI4HE=;
        b=eR0heaWQp8cm1kdAOGapqTgiiA8ufCqOYGFi2VywTUg17XvMrG6i7YJWpgulD4OZmf5b/g
        TseCxiediqvsJsgyBsWdWiZU8vEr6t7mKB1Ya/+WL6LGJzPt/vYonztnSU5wreGPaREeHg
        dACYafOHSOFE6z0g8pfV8UKdRRRgbls=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-534-L4O3TUPMO_iiHRLejeR_HQ-1; Tue, 27 Sep 2022 07:01:29 -0400
X-MC-Unique: L4O3TUPMO_iiHRLejeR_HQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CF551101E148;
        Tue, 27 Sep 2022 11:01:28 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.39.194.14])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B8A03C158CF;
        Tue, 27 Sep 2022 11:01:25 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Nadav Amit <namit@vmware.com>, Peter Xu <peterx@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mike Rapoport <rppt@kernel.org>,
        Christoph von Recklinghausen <crecklin@redhat.com>,
        Don Dutile <ddutile@redhat.com>
Subject: [PATCH v1 1/7] selftests/vm: anon_cow: test COW handling of anonymous memory
Date:   Tue, 27 Sep 2022 13:01:14 +0200
Message-Id: <20220927110120.106906-2-david@redhat.com>
In-Reply-To: <20220927110120.106906-1-david@redhat.com>
References: <20220927110120.106906-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Let's start adding tests for our COW handling of anonymous memory. We'll
focus on basic tests that we can achieve without additional libraries or
gup_test extensions.

We'll add THP and hugetlb tests separately.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 tools/testing/selftests/vm/.gitignore     |   1 +
 tools/testing/selftests/vm/Makefile       |   4 +-
 tools/testing/selftests/vm/anon_cow.c     | 401 ++++++++++++++++++++++
 tools/testing/selftests/vm/run_vmtests.sh |   3 +
 tools/testing/selftests/vm/vm_util.c      |   7 +
 tools/testing/selftests/vm/vm_util.h      |   1 +
 6 files changed, 416 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/vm/anon_cow.c

diff --git a/tools/testing/selftests/vm/.gitignore b/tools/testing/selftests/vm/.gitignore
index 7b9dc2426f18..8a536c731e3c 100644
--- a/tools/testing/selftests/vm/.gitignore
+++ b/tools/testing/selftests/vm/.gitignore
@@ -1,4 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0-only
+anon_cow
 hugepage-mmap
 hugepage-mremap
 hugepage-shm
diff --git a/tools/testing/selftests/vm/Makefile b/tools/testing/selftests/vm/Makefile
index 4ae879f70f4c..bc759534ec28 100644
--- a/tools/testing/selftests/vm/Makefile
+++ b/tools/testing/selftests/vm/Makefile
@@ -25,7 +25,8 @@ MAKEFLAGS += --no-builtin-rules
 
 CFLAGS = -Wall -I ../../../../usr/include $(EXTRA_CFLAGS) $(KHDR_INCLUDES)
 LDLIBS = -lrt -lpthread
-TEST_GEN_FILES = compaction_test
+TEST_GEN_FILES = anon_cow
+TEST_GEN_FILES += compaction_test
 TEST_GEN_FILES += gup_test
 TEST_GEN_FILES += hmm-tests
 TEST_GEN_FILES += hugetlb-madvise
@@ -95,6 +96,7 @@ TEST_FILES += va_128TBswitch.sh
 
 include ../lib.mk
 
+$(OUTPUT)/anon_cow: vm_util.c
 $(OUTPUT)/madv_populate: vm_util.c
 $(OUTPUT)/soft-dirty: vm_util.c
 $(OUTPUT)/split_huge_page_test: vm_util.c
diff --git a/tools/testing/selftests/vm/anon_cow.c b/tools/testing/selftests/vm/anon_cow.c
new file mode 100644
index 000000000000..9d2b15c829e6
--- /dev/null
+++ b/tools/testing/selftests/vm/anon_cow.c
@@ -0,0 +1,401 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * COW (Copy On Write) tests for anonymous memory.
+ *
+ * Copyright 2022, Red Hat, Inc.
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
+#include <dirent.h>
+#include <assert.h>
+#include <sys/mman.h>
+#include <sys/wait.h>
+
+#include "../kselftest.h"
+#include "vm_util.h"
+
+static size_t pagesize;
+static int pagemap_fd;
+
+struct comm_pipes {
+	int child_ready[2];
+	int parent_ready[2];
+};
+
+static int setup_comm_pipes(struct comm_pipes *comm_pipes)
+{
+	if (pipe(comm_pipes->child_ready) < 0)
+		return -errno;
+	if (pipe(comm_pipes->parent_ready) < 0) {
+		close(comm_pipes->child_ready[0]);
+		close(comm_pipes->child_ready[1]);
+		return -errno;
+	}
+
+	return 0;
+}
+
+static void close_comm_pipes(struct comm_pipes *comm_pipes)
+{
+	close(comm_pipes->child_ready[0]);
+	close(comm_pipes->child_ready[1]);
+	close(comm_pipes->parent_ready[0]);
+	close(comm_pipes->parent_ready[1]);
+}
+
+static int child_memcmp_fn(char *mem, size_t size,
+			   struct comm_pipes *comm_pipes)
+{
+	char *old = malloc(size);
+	char buf;
+
+	/* Backup the original content. */
+	memcpy(old, mem, size);
+
+	/* Wait until the parent modified the page. */
+	write(comm_pipes->child_ready[1], "0", 1);
+	while (read(comm_pipes->parent_ready[0], &buf, 1) != 1)
+		;
+
+	/* See if we still read the old values. */
+	return memcmp(old, mem, size);
+}
+
+static int child_vmsplice_memcmp_fn(char *mem, size_t size,
+				    struct comm_pipes *comm_pipes)
+{
+	struct iovec iov = {
+		.iov_base = mem,
+		.iov_len = size,
+	};
+	size_t cur, total, transferred;
+	char *old, *new;
+	int fds[2];
+	char buf;
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
+	write(comm_pipes->child_ready[1], "0", 1);
+	while (read(comm_pipes->parent_ready[0], &buf, 1) != 1)
+		;
+
+	/* See if we still read the old values via the pipe. */
+	for (total = 0; total < transferred; total += cur) {
+		cur = read(fds[0], new + total, transferred - total);
+		if (cur < 0)
+			return -errno;
+	}
+
+	return memcmp(old, new, transferred);
+}
+
+typedef int (*child_fn)(char *mem, size_t size, struct comm_pipes *comm_pipes);
+
+static void do_test_cow_in_parent(char *mem, size_t size, child_fn fn)
+{
+	struct comm_pipes comm_pipes;
+	char buf;
+	int ret;
+
+	ret = setup_comm_pipes(&comm_pipes);
+	if (ret) {
+		ksft_test_result_fail("pipe() failed\n");
+		return;
+	}
+
+	ret = fork();
+	if (ret < 0) {
+		ksft_test_result_fail("fork() failed\n");
+		goto close_comm_pipes;
+	} else if (!ret) {
+		exit(fn(mem, size, &comm_pipes));
+	}
+
+	while (read(comm_pipes.child_ready[0], &buf, 1) != 1)
+		;
+	/* Modify the page. */
+	memset(mem, 0xff, size);
+	write(comm_pipes.parent_ready[1], "0", 1);
+
+	wait(&ret);
+	if (WIFEXITED(ret))
+		ret = WEXITSTATUS(ret);
+	else
+		ret = -EINVAL;
+
+	ksft_test_result(!ret, "No leak from parent into child\n");
+close_comm_pipes:
+	close_comm_pipes(&comm_pipes);
+}
+
+static void test_cow_in_parent(char *mem, size_t size)
+{
+	do_test_cow_in_parent(mem, size, child_memcmp_fn);
+}
+
+static void test_vmsplice_in_child(char *mem, size_t size)
+{
+	do_test_cow_in_parent(mem, size, child_vmsplice_memcmp_fn);
+}
+
+static void do_test_vmsplice_in_parent(char *mem, size_t size,
+				       bool before_fork)
+{
+	struct iovec iov = {
+		.iov_base = mem,
+		.iov_len = size,
+	};
+	size_t cur, total, transferred;
+	struct comm_pipes comm_pipes;
+	char *old, *new;
+	int ret, fds[2];
+	char buf;
+
+	old = malloc(size);
+	new = malloc(size);
+
+	memcpy(old, mem, size);
+
+	ret = setup_comm_pipes(&comm_pipes);
+	if (ret) {
+		ksft_test_result_fail("pipe() failed\n");
+		goto free;
+	}
+
+	if (pipe(fds) < 0) {
+		ksft_test_result_fail("pipe() failed\n");
+		goto close_comm_pipes;
+	}
+
+	if (before_fork) {
+		transferred = vmsplice(fds[1], &iov, 1, 0);
+		if (transferred <= 0) {
+			ksft_test_result_fail("vmsplice() failed\n");
+			goto close_pipe;
+		}
+	}
+
+	ret = fork();
+	if (ret < 0) {
+		ksft_test_result_fail("fork() failed\n");
+		goto close_pipe;
+	} else if (!ret) {
+		write(comm_pipes.child_ready[1], "0", 1);
+		while (read(comm_pipes.parent_ready[0], &buf, 1) != 1)
+			;
+		/* Modify page content in the child. */
+		memset(mem, 0xff, size);
+		exit(0);
+	}
+
+	if (!before_fork) {
+		transferred = vmsplice(fds[1], &iov, 1, 0);
+		if (transferred <= 0) {
+			ksft_test_result_fail("vmsplice() failed\n");
+			wait(&ret);
+			goto close_pipe;
+		}
+	}
+
+	while (read(comm_pipes.child_ready[0], &buf, 1) != 1)
+		;
+	if (munmap(mem, size) < 0) {
+		ksft_test_result_fail("munmap() failed\n");
+		goto close_pipe;
+	}
+	write(comm_pipes.parent_ready[1], "0", 1);
+
+	/* Wait until the child is done writing. */
+	wait(&ret);
+	if (!WIFEXITED(ret)) {
+		ksft_test_result_fail("wait() failed\n");
+		goto close_pipe;
+	}
+
+	/* See if we still read the old values. */
+	for (total = 0; total < transferred; total += cur) {
+		cur = read(fds[0], new + total, transferred - total);
+		if (cur < 0) {
+			ksft_test_result_fail("read() failed\n");
+			goto close_pipe;
+		}
+	}
+
+	ksft_test_result(!memcmp(old, new, transferred),
+			 "No leak from child into parent\n");
+close_pipe:
+	close(fds[0]);
+	close(fds[1]);
+close_comm_pipes:
+	close_comm_pipes(&comm_pipes);
+free:
+	free(old);
+	free(new);
+}
+
+static void test_vmsplice_before_fork(char *mem, size_t size)
+{
+	do_test_vmsplice_in_parent(mem, size, true);
+}
+
+static void test_vmsplice_after_fork(char *mem, size_t size)
+{
+	do_test_vmsplice_in_parent(mem, size, false);
+}
+
+typedef void (*test_fn)(char *mem, size_t size);
+
+static void do_run_with_base_page(test_fn fn, bool swapout)
+{
+	char *mem;
+	int ret;
+
+	mem = mmap(NULL, pagesize, PROT_READ | PROT_WRITE,
+		   MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+	if (mem == MAP_FAILED) {
+		ksft_test_result_fail("mmap() failed\n");
+		return;
+	}
+
+	ret = madvise(mem, pagesize, MADV_NOHUGEPAGE);
+	/* Ignore if not around on a kernel. */
+	if (ret && errno != EINVAL) {
+		ksft_test_result_fail("MADV_NOHUGEPAGE failed\n");
+		goto munmap;
+	}
+
+	/* Populate a base page. */
+	memset(mem, 0, pagesize);
+
+	if (swapout) {
+		madvise(mem, pagesize, MADV_PAGEOUT);
+		if (!pagemap_is_swapped(pagemap_fd, mem)) {
+			ksft_test_result_skip("MADV_PAGEOUT did not work, is swap enabled?\n");
+			goto munmap;
+		}
+	}
+
+	fn(mem, pagesize);
+munmap:
+	munmap(mem, pagesize);
+}
+
+static void run_with_base_page(test_fn fn, const char *desc)
+{
+	ksft_print_msg("[RUN] %s ... with base page\n", desc);
+	do_run_with_base_page(fn, false);
+}
+
+static void run_with_base_page_swap(test_fn fn, const char *desc)
+{
+	ksft_print_msg("[RUN] %s ... with swapped out base page\n", desc);
+	do_run_with_base_page(fn, true);
+}
+
+struct test_case {
+	const char *desc;
+	test_fn fn;
+};
+
+static const struct test_case test_cases[] = {
+	/*
+	 * Basic COW tests for fork() without any GUP. If we miss to break COW,
+	 * either the child can observe modifications by the parent or the
+	 * other way around.
+	 */
+	{
+		"Basic COW after fork()",
+		test_cow_in_parent,
+	},
+	/*
+	 * vmsplice() [R/O GUP] + unmap in the child; modify in the parent. If
+	 * we miss to break COW, the child observes modifications by the parent.
+	 * This is CVE-2020-29374 reported by Jann Horn.
+	 */
+	{
+		"vmsplice() + unmap in child",
+		test_vmsplice_in_child
+	},
+	/*
+	 * vmsplice() [R/O GUP] in parent before fork(), unmap in parent after
+	 * fork(); modify in the child. If we miss to break COW, the parent
+	 * observes modifications by the child.
+	 */
+	{
+		"vmsplice() before fork(), unmap in parent after fork()",
+		test_vmsplice_before_fork,
+	},
+	/*
+	 * vmsplice() [R/O GUP] + unmap in parent after fork(); modify in the
+	 * child. If we miss to break COW, the parent observes modifications by
+	 * the child.
+	 */
+	{
+		"vmsplice() + unmap in parent after fork()",
+		test_vmsplice_after_fork,
+	},
+};
+
+static void run_test_case(struct test_case const *test_case)
+{
+	run_with_base_page(test_case->fn, test_case->desc);
+	run_with_base_page_swap(test_case->fn, test_case->desc);
+}
+
+static void run_test_cases(void)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(test_cases); i++)
+		run_test_case(&test_cases[i]);
+}
+
+int main(int argc, char **argv)
+{
+	int nr_test_cases = ARRAY_SIZE(test_cases);
+	int err;
+
+	pagesize = getpagesize();
+
+	ksft_print_header();
+	ksft_set_plan(nr_test_cases * 2);
+
+	pagemap_fd = open("/proc/self/pagemap", O_RDONLY);
+	if (pagemap_fd < 0)
+		ksft_exit_fail_msg("opening pagemap failed\n");
+
+	run_test_cases();
+
+	err = ksft_get_fail_cnt();
+	if (err)
+		ksft_exit_fail_msg("%d out of %d tests failed\n",
+				   err, ksft_test_num());
+	return ksft_exit_pass();
+}
diff --git a/tools/testing/selftests/vm/run_vmtests.sh b/tools/testing/selftests/vm/run_vmtests.sh
index e780e76c26b8..af59380bc254 100755
--- a/tools/testing/selftests/vm/run_vmtests.sh
+++ b/tools/testing/selftests/vm/run_vmtests.sh
@@ -197,4 +197,7 @@ fi
 
 run_test ./soft-dirty
 
+# COW tests for anonymous memory
+run_test ./anon_cow
+
 exit $exitcode
diff --git a/tools/testing/selftests/vm/vm_util.c b/tools/testing/selftests/vm/vm_util.c
index b58ab11a7a30..6456027e1985 100644
--- a/tools/testing/selftests/vm/vm_util.c
+++ b/tools/testing/selftests/vm/vm_util.c
@@ -28,6 +28,13 @@ bool pagemap_is_softdirty(int fd, char *start)
 	return entry & 0x0080000000000000ull;
 }
 
+bool pagemap_is_swapped(int fd, char *start)
+{
+	uint64_t entry = pagemap_get_entry(fd, start);
+
+	return entry & 0x4000000000000000ull;
+}
+
 void clear_softdirty(void)
 {
 	int ret;
diff --git a/tools/testing/selftests/vm/vm_util.h b/tools/testing/selftests/vm/vm_util.h
index 2e512bd57ae1..bb8ec8d69623 100644
--- a/tools/testing/selftests/vm/vm_util.h
+++ b/tools/testing/selftests/vm/vm_util.h
@@ -4,6 +4,7 @@
 
 uint64_t pagemap_get_entry(int fd, char *start);
 bool pagemap_is_softdirty(int fd, char *start);
+bool pagemap_is_swapped(int fd, char *start);
 void clear_softdirty(void);
 uint64_t read_pmd_pagesize(void);
 uint64_t check_huge(void *addr);
-- 
2.37.3

