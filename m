Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F5935EC053
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Sep 2022 13:02:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231757AbiI0LCx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 27 Sep 2022 07:02:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231139AbiI0LCS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 27 Sep 2022 07:02:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60FD7D4300
        for <linux-kselftest@vger.kernel.org>; Tue, 27 Sep 2022 04:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664276501;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qCkMLugRYEBXXrFbCSOQYs7SVp0LQbTQHuIKgCNYGNE=;
        b=QGw+udV9tyP21FmbuGb4YAZClWEIFWA5dSwgDPvQMcT363EpSF4gZgr51g6Tv0CFOvEySD
        5bcZHZPjl1fjEDZGK0yxENk2japoaLiZBAJldV2HDC13r3XtRtNBGyfOU4j5f2mqI740Kb
        kcqD7UA+VpA34i4cqhnAmpW1t+o53ro=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-450-CBTZl0wDObm0zKMkk-ci9Q-1; Tue, 27 Sep 2022 07:01:36 -0400
X-MC-Unique: CBTZl0wDObm0zKMkk-ci9Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C6EA03C01D83;
        Tue, 27 Sep 2022 11:01:35 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.39.194.14])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7DEB3C15BBC;
        Tue, 27 Sep 2022 11:01:32 +0000 (UTC)
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
Subject: [PATCH v1 3/7] selftests/vm: anon_cow: THP tests
Date:   Tue, 27 Sep 2022 13:01:16 +0200
Message-Id: <20220927110120.106906-4-david@redhat.com>
In-Reply-To: <20220927110120.106906-1-david@redhat.com>
References: <20220927110120.106906-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Let's add various THP variants that we'll run with our existing test
cases.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 tools/testing/selftests/vm/anon_cow.c | 259 +++++++++++++++++++++++++-
 1 file changed, 258 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/vm/anon_cow.c b/tools/testing/selftests/vm/anon_cow.c
index 9d2b15c829e6..9244c8551a95 100644
--- a/tools/testing/selftests/vm/anon_cow.c
+++ b/tools/testing/selftests/vm/anon_cow.c
@@ -24,6 +24,43 @@
 
 static size_t pagesize;
 static int pagemap_fd;
+static size_t thpsize;
+
+static void detect_thpsize(void)
+{
+	int fd = open("/sys/kernel/mm/transparent_hugepage/hpage_pmd_size",
+		      O_RDONLY);
+	size_t size = 0;
+	char buf[15];
+	int ret;
+
+	if (fd < 0)
+		return;
+
+	ret = pread(fd, buf, sizeof(buf), 0);
+	if (ret > 0 && ret < sizeof(buf)) {
+		buf[ret] = 0;
+
+		size = strtoul(buf, NULL, 10);
+		if (size < pagesize)
+			size = 0;
+		if (size > 0) {
+			thpsize = size;
+			ksft_print_msg("[INFO] detected THP size: %zu KiB\n",
+				       thpsize / 1024);
+		}
+	}
+
+	close(fd);
+}
+
+static bool range_is_swapped(void *addr, size_t size)
+{
+	for (; size; addr += pagesize, size -= pagesize)
+		if (!pagemap_is_swapped(pagemap_fd, addr))
+			return false;
+	return true;
+}
 
 struct comm_pipes {
 	int child_ready[2];
@@ -319,6 +356,206 @@ static void run_with_base_page_swap(test_fn fn, const char *desc)
 	do_run_with_base_page(fn, true);
 }
 
+enum thp_run {
+	THP_RUN_PMD,
+	THP_RUN_PMD_SWAPOUT,
+	THP_RUN_PTE,
+	THP_RUN_PTE_SWAPOUT,
+	THP_RUN_SINGLE_PTE,
+	THP_RUN_SINGLE_PTE_SWAPOUT,
+	THP_RUN_PARTIAL_MREMAP,
+	THP_RUN_PARTIAL_SHARED,
+};
+
+static void do_run_with_thp(test_fn fn, enum thp_run thp_run)
+{
+	char *mem, *mmap_mem, *tmp, *mremap_mem = MAP_FAILED;
+	size_t size, mmap_size, mremap_size;
+	int ret;
+
+	/* For alignment purposes, we need twice the thp size. */
+	mmap_size = 2 * thpsize;
+	mmap_mem = mmap(NULL, mmap_size, PROT_READ | PROT_WRITE,
+			MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+	if (mmap_mem == MAP_FAILED) {
+		ksft_test_result_fail("mmap() failed\n");
+		return;
+	}
+
+	/* We need a THP-aligned memory area. */
+	mem = (char *)(((uintptr_t)mmap_mem + thpsize) & ~(thpsize - 1));
+
+	ret = madvise(mem, thpsize, MADV_HUGEPAGE);
+	if (ret) {
+		ksft_test_result_fail("MADV_HUGEPAGE failed\n");
+		goto munmap;
+	}
+
+	/*
+	 * Try to populate a THP. Touch the first sub-page and test if we get
+	 * another sub-page populated automatically.
+	 */
+	mem[0] = 0;
+	if (!pagemap_is_populated(pagemap_fd, mem + pagesize)) {
+		ksft_test_result_skip("Did not get a THP populated\n");
+		goto munmap;
+	}
+	memset(mem, 0, thpsize);
+
+	size = thpsize;
+	switch (thp_run) {
+	case THP_RUN_PMD:
+	case THP_RUN_PMD_SWAPOUT:
+		break;
+	case THP_RUN_PTE:
+	case THP_RUN_PTE_SWAPOUT:
+		/*
+		 * Trigger PTE-mapping the THP by temporarily mapping a single
+		 * subpage R/O.
+		 */
+		ret = mprotect(mem + pagesize, pagesize, PROT_READ);
+		if (ret) {
+			ksft_test_result_fail("mprotect() failed\n");
+			goto munmap;
+		}
+		ret = mprotect(mem + pagesize, pagesize, PROT_READ | PROT_WRITE);
+		if (ret) {
+			ksft_test_result_fail("mprotect() failed\n");
+			goto munmap;
+		}
+		break;
+	case THP_RUN_SINGLE_PTE:
+	case THP_RUN_SINGLE_PTE_SWAPOUT:
+		/*
+		 * Discard all but a single subpage of that PTE-mapped THP. What
+		 * remains is a single PTE mapping a single subpage.
+		 */
+		ret = madvise(mem + pagesize, thpsize - pagesize, MADV_DONTNEED);
+		if (ret) {
+			ksft_test_result_fail("MADV_DONTNEED failed\n");
+			goto munmap;
+		}
+		size = pagesize;
+		break;
+	case THP_RUN_PARTIAL_MREMAP:
+		/*
+		 * Remap half of the THP. We need some new memory location
+		 * for that.
+		 */
+		mremap_size = thpsize / 2;
+		mremap_mem = mmap(NULL, mremap_size, PROT_NONE,
+				  MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+		if (mem == MAP_FAILED) {
+			ksft_test_result_fail("mmap() failed\n");
+			goto munmap;
+		}
+		tmp = mremap(mem + mremap_size, mremap_size, mremap_size,
+			     MREMAP_MAYMOVE | MREMAP_FIXED, mremap_mem);
+		if (tmp != mremap_mem) {
+			ksft_test_result_fail("mremap() failed\n");
+			goto munmap;
+		}
+		size = mremap_size;
+		break;
+	case THP_RUN_PARTIAL_SHARED:
+		/*
+		 * Share the first page of the THP with a child and quit the
+		 * child. This will result in some parts of the THP never
+		 * have been shared.
+		 */
+		ret = madvise(mem + pagesize, thpsize - pagesize, MADV_DONTFORK);
+		if (ret) {
+			ksft_test_result_fail("MADV_DONTFORK failed\n");
+			goto munmap;
+		}
+		ret = fork();
+		if (ret < 0) {
+			ksft_test_result_fail("fork() failed\n");
+			goto munmap;
+		} else if (!ret) {
+			exit(0);
+		}
+		wait(&ret);
+		/* Allow for sharing all pages again. */
+		ret = madvise(mem + pagesize, thpsize - pagesize, MADV_DOFORK);
+		if (ret) {
+			ksft_test_result_fail("MADV_DOFORK failed\n");
+			goto munmap;
+		}
+		break;
+	default:
+		assert(false);
+	}
+
+	switch (thp_run) {
+	case THP_RUN_PMD_SWAPOUT:
+	case THP_RUN_PTE_SWAPOUT:
+	case THP_RUN_SINGLE_PTE_SWAPOUT:
+		madvise(mem, size, MADV_PAGEOUT);
+		if (!range_is_swapped(mem, size)) {
+			ksft_test_result_skip("MADV_PAGEOUT did not work, is swap enabled?\n");
+			goto munmap;
+		}
+		break;
+	default:
+		break;
+	}
+
+	fn(mem, size);
+munmap:
+	munmap(mmap_mem, mmap_size);
+	if (mremap_mem != MAP_FAILED)
+		munmap(mremap_mem, mremap_size);
+}
+
+static void run_with_thp(test_fn fn, const char *desc)
+{
+	ksft_print_msg("[RUN] %s ... with THP\n", desc);
+	do_run_with_thp(fn, THP_RUN_PMD);
+}
+
+static void run_with_thp_swap(test_fn fn, const char *desc)
+{
+	ksft_print_msg("[RUN] %s ... with swapped-out THP\n", desc);
+	do_run_with_thp(fn, THP_RUN_PMD_SWAPOUT);
+}
+
+static void run_with_pte_mapped_thp(test_fn fn, const char *desc)
+{
+	ksft_print_msg("[RUN] %s ... with PTE-mapped THP\n", desc);
+	do_run_with_thp(fn, THP_RUN_PTE);
+}
+
+static void run_with_pte_mapped_thp_swap(test_fn fn, const char *desc)
+{
+	ksft_print_msg("[RUN] %s ... with swapped-out, PTE-mapped THP\n", desc);
+	do_run_with_thp(fn, THP_RUN_PTE_SWAPOUT);
+}
+
+static void run_with_single_pte_of_thp(test_fn fn, const char *desc)
+{
+	ksft_print_msg("[RUN] %s ... with single PTE of THP\n", desc);
+	do_run_with_thp(fn, THP_RUN_SINGLE_PTE);
+}
+
+static void run_with_single_pte_of_thp_swap(test_fn fn, const char *desc)
+{
+	ksft_print_msg("[RUN] %s ... with single PTE of swapped-out THP\n", desc);
+	do_run_with_thp(fn, THP_RUN_SINGLE_PTE_SWAPOUT);
+}
+
+static void run_with_partial_mremap_thp(test_fn fn, const char *desc)
+{
+	ksft_print_msg("[RUN] %s ... with partially mremap()'ed THP\n", desc);
+	do_run_with_thp(fn, THP_RUN_PARTIAL_MREMAP);
+}
+
+static void run_with_partial_shared_thp(test_fn fn, const char *desc)
+{
+	ksft_print_msg("[RUN] %s ... with partially shared THP\n", desc);
+	do_run_with_thp(fn, THP_RUN_PARTIAL_SHARED);
+}
+
 struct test_case {
 	const char *desc;
 	test_fn fn;
@@ -367,6 +604,16 @@ static void run_test_case(struct test_case const *test_case)
 {
 	run_with_base_page(test_case->fn, test_case->desc);
 	run_with_base_page_swap(test_case->fn, test_case->desc);
+	if (thpsize) {
+		run_with_thp(test_case->fn, test_case->desc);
+		run_with_thp_swap(test_case->fn, test_case->desc);
+		run_with_pte_mapped_thp(test_case->fn, test_case->desc);
+		run_with_pte_mapped_thp_swap(test_case->fn, test_case->desc);
+		run_with_single_pte_of_thp(test_case->fn, test_case->desc);
+		run_with_single_pte_of_thp_swap(test_case->fn, test_case->desc);
+		run_with_partial_mremap_thp(test_case->fn, test_case->desc);
+		run_with_partial_shared_thp(test_case->fn, test_case->desc);
+	}
 }
 
 static void run_test_cases(void)
@@ -377,15 +624,25 @@ static void run_test_cases(void)
 		run_test_case(&test_cases[i]);
 }
 
+static int tests_per_test_case(void)
+{
+	int tests = 2;
+
+	if (thpsize)
+		tests += 8;
+	return tests;
+}
+
 int main(int argc, char **argv)
 {
 	int nr_test_cases = ARRAY_SIZE(test_cases);
 	int err;
 
 	pagesize = getpagesize();
+	detect_thpsize();
 
 	ksft_print_header();
-	ksft_set_plan(nr_test_cases * 2);
+	ksft_set_plan(nr_test_cases * tests_per_test_case());
 
 	pagemap_fd = open("/proc/self/pagemap", O_RDONLY);
 	if (pagemap_fd < 0)
-- 
2.37.3

