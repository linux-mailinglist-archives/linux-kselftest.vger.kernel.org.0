Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BAA36DDD86
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Apr 2023 16:17:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230295AbjDKORo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 11 Apr 2023 10:17:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230235AbjDKORY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 11 Apr 2023 10:17:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9A9A49F8
        for <linux-kselftest@vger.kernel.org>; Tue, 11 Apr 2023 07:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681222552;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kiblhRIXN5QVGSvHoajKRlNDk3I/DcpYGGNog0nXOOg=;
        b=a5MRx4eV937JyjQJEmBxuVthvAAsKgXAYHg7BO3wBNS9WvidWfLj/iDl63JGVJkvwwADMZ
        7O7E/ccmWbMIk067gjpNL9NscHU3Yy2w0tqP7jFHyVlUXqU4i96aDTr3FR2oN2S/GXJS9z
        ac+YNA2QAa/1Ip5462obVaSjX+6TTfI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-306-jhitVNstOv2k9zuv4EVEVA-1; Tue, 11 Apr 2023 10:15:47 -0400
X-MC-Unique: jhitVNstOv2k9zuv4EVEVA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4C84B889067;
        Tue, 11 Apr 2023 14:15:39 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.39.194.95])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F1939400F286;
        Tue, 11 Apr 2023 14:15:37 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        sparclinux@vger.kernel.org, David Hildenbrand <david@redhat.com>
Subject: [PATCH v1 2/6] selftests/mm: mkdirty: test behavior of (pte|pmd)_mkdirty on VMAs without write permissions
Date:   Tue, 11 Apr 2023 16:15:25 +0200
Message-Id: <20230411141529.428991-4-david@redhat.com>
In-Reply-To: <20230411141529.428991-1-david@redhat.com>
References: <20230411141529.428991-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Let's add some tests that trigger (pte|pmd)_mkdirty on VMAs without write
permissions. If an architecture implementation is wrong, we might
accidentally set the PTE/PMD writable and allow for write access in a
VMA without write permissions.

The tests include reproducers for the two issues recently discovered
and worked-around in core-MM for now:

(1) commit 624a2c94f5b7 ("Partly revert "mm/thp: carry over dirty
    bit when thp splits on pmd"")
(2) commit 96a9c287e25d ("mm/migrate: fix wrongly apply write bit
    after mkdirty on sparc64")

In addition, some other tests that reveal further issues.

All tests pass under x86_64:
	./mkdirty
	# [INFO] detected THP size: 2048 KiB
	TAP version 13
	1..6
	# [INFO] PTRACE write access
	ok 1 SIGSEGV generated, page not modified
	# [INFO] PTRACE write access to THP
	ok 2 SIGSEGV generated, page not modified
	# [INFO] Page migration
	ok 3 SIGSEGV generated, page not modified
	# [INFO] Page migration of THP
	ok 4 SIGSEGV generated, page not modified
	# [INFO] PTE-mapping a THP
	ok 5 SIGSEGV generated, page not modified
	# [INFO] UFFDIO_COPY
	ok 6 SIGSEGV generated, page not modified
	# Totals: pass:6 fail:0 xfail:0 xpass:0 skip:0 error:0

But some fail on sparc64:
	./mkdirty
	# [INFO] detected THP size: 8192 KiB
	TAP version 13
	1..6
	# [INFO] PTRACE write access
	not ok 1 SIGSEGV generated, page not modified
	# [INFO] PTRACE write access to THP
	not ok 2 SIGSEGV generated, page not modified
	# [INFO] Page migration
	ok 3 SIGSEGV generated, page not modified
	# [INFO] Page migration of THP
	ok 4 SIGSEGV generated, page not modified
	# [INFO] PTE-mapping a THP
	ok 5 SIGSEGV generated, page not modified
	# [INFO] UFFDIO_COPY
	not ok 6 SIGSEGV generated, page not modified
	Bail out! 3 out of 6 tests failed
	# Totals: pass:3 fail:3 xfail:0 xpass:0 skip:0 error:0

Reverting both above commits makes all tests fail on sparc64:
	./mkdirty
	# [INFO] detected THP size: 8192 KiB
	TAP version 13
	1..6
	# [INFO] PTRACE write access
	not ok 1 SIGSEGV generated, page not modified
	# [INFO] PTRACE write access to THP
	not ok 2 SIGSEGV generated, page not modified
	# [INFO] Page migration
	not ok 3 SIGSEGV generated, page not modified
	# [INFO] Page migration of THP
	not ok 4 SIGSEGV generated, page not modified
	# [INFO] PTE-mapping a THP
	not ok 5 SIGSEGV generated, page not modified
	# [INFO] UFFDIO_COPY
	not ok 6 SIGSEGV generated, page not modified
	Bail out! 6 out of 6 tests failed
	# Totals: pass:0 fail:6 xfail:0 xpass:0 skip:0 error:0

The tests are useful to detect other problematic archs, to verify new
arch fixes, and to stop such issues from reappearing in the future.

For now, we don't add any hugetlb tests.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 tools/testing/selftests/mm/Makefile  |   2 +
 tools/testing/selftests/mm/mkdirty.c | 379 +++++++++++++++++++++++++++
 2 files changed, 381 insertions(+)
 create mode 100644 tools/testing/selftests/mm/mkdirty.c

diff --git a/tools/testing/selftests/mm/Makefile b/tools/testing/selftests/mm/Makefile
index c31d952cff68..8235dddbbbc6 100644
--- a/tools/testing/selftests/mm/Makefile
+++ b/tools/testing/selftests/mm/Makefile
@@ -47,6 +47,7 @@ TEST_GEN_FILES += map_hugetlb
 TEST_GEN_FILES += map_populate
 TEST_GEN_FILES += memfd_secret
 TEST_GEN_FILES += migration
+TEST_GEN_PROGS += mkdirty
 TEST_GEN_FILES += mlock-random-test
 TEST_GEN_FILES += mlock2-tests
 TEST_GEN_FILES += mrelease_test
@@ -108,6 +109,7 @@ $(OUTPUT)/cow: vm_util.c
 $(OUTPUT)/khugepaged: vm_util.c
 $(OUTPUT)/ksm_functional_tests: vm_util.c
 $(OUTPUT)/madv_populate: vm_util.c
+$(OUTPUT)/mkdirty: vm_util.c
 $(OUTPUT)/soft-dirty: vm_util.c
 $(OUTPUT)/split_huge_page_test: vm_util.c
 $(OUTPUT)/userfaultfd: vm_util.c
diff --git a/tools/testing/selftests/mm/mkdirty.c b/tools/testing/selftests/mm/mkdirty.c
new file mode 100644
index 000000000000..6d71d972997b
--- /dev/null
+++ b/tools/testing/selftests/mm/mkdirty.c
@@ -0,0 +1,379 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Test handling of code that might set PTE/PMD dirty in read-only VMAs.
+ * Setting a PTE/PMD dirty must not accidentally set the PTE/PMD writable.
+ *
+ * Copyright 2023, Red Hat, Inc.
+ *
+ * Author(s): David Hildenbrand <david@redhat.com>
+ */
+#include <fcntl.h>
+#include <signal.h>
+#include <unistd.h>
+#include <string.h>
+#include <errno.h>
+#include <stdlib.h>
+#include <stdbool.h>
+#include <stdint.h>
+#include <sys/mman.h>
+#include <setjmp.h>
+#include <sys/syscall.h>
+#include <sys/ioctl.h>
+#include <linux/userfaultfd.h>
+#include <linux/mempolicy.h>
+
+#include "../kselftest.h"
+#include "vm_util.h"
+
+static size_t pagesize;
+static size_t thpsize;
+static int mem_fd;
+static int pagemap_fd;
+static sigjmp_buf env;
+
+static void signal_handler(int sig)
+{
+	if (sig == SIGSEGV)
+		siglongjmp(env, 1);
+	siglongjmp(env, 2);
+}
+
+static void do_test_write_sigsegv(char *mem)
+{
+	char orig = *mem;
+	int ret;
+
+	if (signal(SIGSEGV, signal_handler) == SIG_ERR) {
+		ksft_test_result_fail("signal() failed\n");
+		return;
+	}
+
+	ret = sigsetjmp(env, 1);
+	if (!ret)
+		*mem = orig + 1;
+
+	if (signal(SIGSEGV, SIG_DFL) == SIG_ERR)
+		ksft_test_result_fail("signal() failed\n");
+
+	ksft_test_result(ret == 1 && *mem == orig,
+			 "SIGSEGV generated, page not modified\n");
+}
+
+static char *mmap_thp_range(int prot, char **_mmap_mem, size_t *_mmap_size)
+{
+	const size_t mmap_size = 2 * thpsize;
+	char *mem, *mmap_mem;
+
+	mmap_mem = mmap(NULL, mmap_size, prot, MAP_PRIVATE|MAP_ANON,
+			-1, 0);
+	if (mmap_mem == MAP_FAILED) {
+		ksft_test_result_fail("mmap() failed\n");
+		return MAP_FAILED;
+	}
+	mem = (char *)(((uintptr_t)mmap_mem + thpsize) & ~(thpsize - 1));
+
+	if (madvise(mem, thpsize, MADV_HUGEPAGE)) {
+		ksft_test_result_skip("MADV_HUGEPAGE failed\n");
+		munmap(mmap_mem, mmap_size);
+		return MAP_FAILED;
+	}
+
+	*_mmap_mem = mmap_mem;
+	*_mmap_size = mmap_size;
+	return mem;
+}
+
+static void test_ptrace_write(void)
+{
+	char data = 1;
+	char *mem;
+	int ret;
+
+	ksft_print_msg("[INFO] PTRACE write access\n");
+
+	mem = mmap(NULL, pagesize, PROT_READ, MAP_PRIVATE|MAP_ANON, -1, 0);
+	if (mem == MAP_FAILED) {
+		ksft_test_result_fail("mmap() failed\n");
+		return;
+	}
+
+	/* Fault in the shared zeropage. */
+	if (*mem != 0) {
+		ksft_test_result_fail("Memory not zero\n");
+		goto munmap;
+	}
+
+	/*
+	 * Unshare the page (populating a fresh anon page that might be set
+	 * dirty in the PTE) in the read-only VMA using ptrace (FOLL_FORCE).
+	 */
+	lseek(mem_fd, (uintptr_t) mem, SEEK_SET);
+	ret = write(mem_fd, &data, 1);
+	if (ret != 1 || *mem != data) {
+		ksft_test_result_fail("write() failed\n");
+		goto munmap;
+	}
+
+	do_test_write_sigsegv(mem);
+munmap:
+	munmap(mem, pagesize);
+}
+
+static void test_ptrace_write_thp(void)
+{
+	char *mem, *mmap_mem;
+	size_t mmap_size;
+	char data = 1;
+	int ret;
+
+	ksft_print_msg("[INFO] PTRACE write access to THP\n");
+
+	mem = mmap_thp_range(PROT_READ, &mmap_mem, &mmap_size);
+	if (mem == MAP_FAILED)
+		return;
+
+	/*
+	 * Write to the first subpage in the read-only VMA using
+	 * ptrace(FOLL_FORCE), eventually placing a fresh THP that is marked
+	 * dirty in the PMD.
+	 */
+	lseek(mem_fd, (uintptr_t) mem, SEEK_SET);
+	ret = write(mem_fd, &data, 1);
+	if (ret != 1 || *mem != data) {
+		ksft_test_result_fail("write() failed\n");
+		goto munmap;
+	}
+
+	/* MM populated a THP if we got the last subpage populated as well. */
+	if (!pagemap_is_populated(pagemap_fd, mem + thpsize - pagesize)) {
+		ksft_test_result_skip("Did not get a THP populated\n");
+		goto munmap;
+	}
+
+	do_test_write_sigsegv(mem);
+munmap:
+	munmap(mmap_mem, mmap_size);
+}
+
+static void test_page_migration(void)
+{
+	char *mem;
+
+	ksft_print_msg("[INFO] Page migration\n");
+
+	mem = mmap(NULL, pagesize, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANON,
+		   -1, 0);
+	if (mem == MAP_FAILED) {
+		ksft_test_result_fail("mmap() failed\n");
+		return;
+	}
+
+	/* Populate a fresh page and dirty it. */
+	memset(mem, 1, pagesize);
+	if (mprotect(mem, pagesize, PROT_READ)) {
+		ksft_test_result_fail("mprotect() failed\n");
+		goto munmap;
+	}
+
+	/* Trigger page migration. Might not be available or fail. */
+	if (syscall(__NR_mbind, mem, pagesize, MPOL_LOCAL, NULL, 0x7fful,
+		    MPOL_MF_MOVE)) {
+		ksft_test_result_skip("mbind() failed\n");
+		goto munmap;
+	}
+
+	do_test_write_sigsegv(mem);
+munmap:
+	munmap(mem, pagesize);
+}
+
+static void test_page_migration_thp(void)
+{
+	char *mem, *mmap_mem;
+	size_t mmap_size;
+
+	ksft_print_msg("[INFO] Page migration of THP\n");
+
+	mem = mmap_thp_range(PROT_READ|PROT_WRITE, &mmap_mem, &mmap_size);
+	if (mem == MAP_FAILED)
+		return;
+
+	/*
+	 * Write to the first page, which might populate a fresh anon THP
+	 * and dirty it.
+	 */
+	memset(mem, 1, pagesize);
+	if (mprotect(mem, thpsize, PROT_READ)) {
+		ksft_test_result_fail("mprotect() failed\n");
+		goto munmap;
+	}
+
+	/* MM populated a THP if we got the last subpage populated as well. */
+	if (!pagemap_is_populated(pagemap_fd, mem + thpsize - pagesize)) {
+		ksft_test_result_skip("Did not get a THP populated\n");
+		goto munmap;
+	}
+
+	/* Trigger page migration. Might not be available or fail. */
+	if (syscall(__NR_mbind, mem, thpsize, MPOL_LOCAL, NULL, 0x7fful,
+		    MPOL_MF_MOVE)) {
+		ksft_test_result_skip("mbind() failed\n");
+		goto munmap;
+	}
+
+	do_test_write_sigsegv(mem);
+munmap:
+	munmap(mmap_mem, mmap_size);
+}
+
+static void test_pte_mapped_thp(void)
+{
+	char *mem, *mmap_mem;
+	size_t mmap_size;
+
+	ksft_print_msg("[INFO] PTE-mapping a THP\n");
+
+	mem = mmap_thp_range(PROT_READ|PROT_WRITE, &mmap_mem, &mmap_size);
+	if (mem == MAP_FAILED)
+		return;
+
+	/*
+	 * Write to the first page, which might populate a fresh anon THP
+	 * and dirty it.
+	 */
+	memset(mem, 1, pagesize);
+	if (mprotect(mem, thpsize, PROT_READ)) {
+		ksft_test_result_fail("mprotect() failed\n");
+		goto munmap;
+	}
+
+	/* MM populated a THP if we got the last subpage populated as well. */
+	if (!pagemap_is_populated(pagemap_fd, mem + thpsize - pagesize)) {
+		ksft_test_result_skip("Did not get a THP populated\n");
+		goto munmap;
+	}
+
+	/* Trigger PTE-mapping the THP by mprotect'ing the last subpage. */
+	if (mprotect(mem + thpsize - pagesize, pagesize,
+		     PROT_READ|PROT_WRITE)) {
+		ksft_test_result_fail("mprotect() failed\n");
+		goto munmap;
+	}
+
+	do_test_write_sigsegv(mem);
+munmap:
+	munmap(mmap_mem, mmap_size);
+}
+
+#ifdef __NR_userfaultfd
+static void test_uffdio_copy(void)
+{
+	struct uffdio_register uffdio_register;
+	struct uffdio_copy uffdio_copy;
+	struct uffdio_api uffdio_api;
+	char *dst, *src;
+	int uffd;
+
+	ksft_print_msg("[INFO] UFFDIO_COPY\n");
+
+	src = malloc(pagesize);
+	memset(src, 1, pagesize);
+	dst = mmap(NULL, pagesize, PROT_READ, MAP_PRIVATE|MAP_ANON, -1, 0);
+	if (dst == MAP_FAILED) {
+		ksft_test_result_fail("mmap() failed\n");
+		return;
+	}
+
+	uffd = syscall(__NR_userfaultfd, O_CLOEXEC | O_NONBLOCK);
+	if (uffd < 0) {
+		ksft_test_result_skip("__NR_userfaultfd failed\n");
+		goto munmap;
+	}
+
+	uffdio_api.api = UFFD_API;
+	uffdio_api.features = 0;
+	if (ioctl(uffd, UFFDIO_API, &uffdio_api) < 0) {
+		ksft_test_result_fail("UFFDIO_API failed\n");
+		goto close_uffd;
+	}
+
+	uffdio_register.range.start = (unsigned long) dst;
+	uffdio_register.range.len = pagesize;
+	uffdio_register.mode = UFFDIO_REGISTER_MODE_MISSING;
+	if (ioctl(uffd, UFFDIO_REGISTER, &uffdio_register)) {
+		ksft_test_result_fail("UFFDIO_REGISTER failed\n");
+		goto close_uffd;
+	}
+
+	/* Place a page in a read-only VMA, which might set the PTE dirty. */
+	uffdio_copy.dst = (unsigned long) dst;
+	uffdio_copy.src = (unsigned long) src;
+	uffdio_copy.len = pagesize;
+	uffdio_copy.mode = 0;
+	if (ioctl(uffd, UFFDIO_COPY, &uffdio_copy)) {
+		ksft_test_result_fail("UFFDIO_COPY failed\n");
+		goto close_uffd;
+	}
+
+	do_test_write_sigsegv(dst);
+close_uffd:
+	close(uffd);
+munmap:
+	munmap(dst, pagesize);
+	free(src);
+#endif /* __NR_userfaultfd */
+}
+
+int main(void)
+{
+	int err, tests = 2;
+
+	pagesize = getpagesize();
+	thpsize = read_pmd_pagesize();
+	if (thpsize) {
+		ksft_print_msg("[INFO] detected THP size: %zu KiB\n",
+			       thpsize / 1024);
+		tests += 3;
+	}
+#ifdef __NR_userfaultfd
+	tests += 1;
+#endif /* __NR_userfaultfd */
+
+	ksft_print_header();
+	ksft_set_plan(tests);
+
+	mem_fd = open("/proc/self/mem", O_RDWR);
+	if (mem_fd < 0)
+		ksft_exit_fail_msg("opening /proc/self/mem failed\n");
+	pagemap_fd = open("/proc/self/pagemap", O_RDONLY);
+	if (pagemap_fd < 0)
+		ksft_exit_fail_msg("opening /proc/self/pagemap failed\n");
+
+	/*
+	 * On some ptrace(FOLL_FORCE) write access via /proc/self/mem in
+	 * read-only VMAs, the kernel may set the PTE/PMD dirty.
+	 */
+	test_ptrace_write();
+	if (thpsize)
+		test_ptrace_write_thp();
+	/*
+	 * On page migration, the kernel may set the PTE/PMD dirty when
+	 * remapping the page.
+	 */
+	test_page_migration();
+	if (thpsize)
+		test_page_migration_thp();
+	/* PTE-mapping a THP might propagate the dirty PMD bit to the PTEs. */
+	if (thpsize)
+		test_pte_mapped_thp();
+	/* Placing a fresh page via userfaultfd may set the PTE dirty. */
+#ifdef __NR_userfaultfd
+	test_uffdio_copy();
+#endif /* __NR_userfaultfd */
+
+	err = ksft_get_fail_cnt();
+	if (err)
+		ksft_exit_fail_msg("%d out of %d tests failed\n",
+				   err, ksft_test_num());
+	return ksft_exit_pass();
+}
-- 
2.39.2

