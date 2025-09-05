Return-Path: <linux-kselftest+bounces-40808-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3960B44C3B
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Sep 2025 05:24:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BA395866EE
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Sep 2025 03:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D66B0221265;
	Fri,  5 Sep 2025 03:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ja8z72Di"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F796EEBD
	for <linux-kselftest@vger.kernel.org>; Fri,  5 Sep 2025 03:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757042681; cv=none; b=KVZ9ZBAGH53zfjTIkH30nyU8duG7066LSgCTbQeLo3RbSXQ0tL7GGgL75zjpJSUuAiMcJClkprGwi/d7tKVzqMuXkwhGQ+ZlsrXtKUIrg5Y0Hc3J2KyD2mWRoirfTHHHm93/Weu8tDiZM4DQFMf0z/uD3bhDzG6vtrMl8H6mpqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757042681; c=relaxed/simple;
	bh=7tL0Th7H27K/T+dAo38L9OosJ2gXhWJi/ET9nRqb2KU=;
	h=From:To:Cc:Subject:Date:Message-Id; b=WANdyjbkCd9lMB0oig2DqKfaUcYSdKOvdayDDXcQjHvFdkSPTsjAFsCemyoUWgzI73epi6A2YNjDHR3apj5rXg072QnCjTnLyPonjLJoQvhK3yYC/MXOxt4J+C77QKlHo/Q2flVsYEftYJ8Ke2HaK4IXwURUcLitxnoJUIvWLsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ja8z72Di; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b0472bd218bso300216966b.1
        for <linux-kselftest@vger.kernel.org>; Thu, 04 Sep 2025 20:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757042678; x=1757647478; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y5hzaTMrp5ml0eZFuOPJb0IFdSE0eJU5kUu/t1q/83g=;
        b=Ja8z72Di0PXkZlbGQpr2QGD7maGtN1oLSd8HBfeCyeN9qfWNHRTcsCh7YPU28UaFC6
         y/ndgNxaTCsVDjSXcxRSSia8rQwDyG6UiO+lr/QW5GlfUe3JopqnWEsZkFllhoWnmvBW
         lWuPUWsNptuksQcPqb7NFRcCQXVjIcxfB/ZA9NmLqjhWGoXXaAMjHZe6Fk6q5Z5A44Kc
         GEpaqHra9qGHzVhI9QoO8jy8Hh6PaJjo74BcDM8TjCRsnIG6MCHmo5Ba2hL/vm+ag7S9
         oPdZqAmOt3GvfeKxG2yWtI3b3yZr5D9PFB2M1tiK+pZzXFDc/m6HiNz31aw7uKdAxwEj
         NCew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757042678; x=1757647478;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y5hzaTMrp5ml0eZFuOPJb0IFdSE0eJU5kUu/t1q/83g=;
        b=pq9t5PGWo+dklATcAtvnZkUvbXYjVukiRxwfdwMJaW1CwNAKuJ0evxSa9ax2b/332m
         0hXqlxURRGpbvykGjGd6ENtQRD9BMbdl7f0rtU+jIEJrr+iAnEVrD6841cN1jxmMUiQs
         KvsEVSieSCf+ADCI0jcyHdNrSMbbzOLhL9Mo7cs13zovUcLGjg0piJ/OrGKUHXOL/LSf
         BjN4fBKcfJI5HVqiazN97IGtUkzaHneI0K4JaFG04yKCBk0TEfQg5FcdJ9xa17y8gpMx
         WtzaATqNuC+kHOe7wf3W2wOyjGCac+BGFaZfnjEXUzhaRM6MlHuSP7QFHUvgJ//I9Icr
         gWZg==
X-Forwarded-Encrypted: i=1; AJvYcCVieCuHEeVo9kuQGrjhJwHd8SU+EBdJTu0OkdoAAPArfmCYwBzcKRKYt6C9aZrIDdSHT4xjP3V2fDGsSYsO5RE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDcCbfxD9IyeODudnNoOg2Qb2zYmugq7TMjJcXs/S7Qjyj0Ckr
	jgvzSFe6k/zr/OKqaTxtygQTV+hUHZ++h5I8ceih+LTrdig0LYBtz0pC
X-Gm-Gg: ASbGnctdOL1BQ+s6zJ6kVRyxtsOLay8W8Tttip5Je17F0BLNzakFDgGqCmZEGuD+So3
	Pu8GGbFScQtbkw8FrMoJz8RiZNWnx4rWbgNlvVhv9t/kmfZUlGI1vwr2tSyseay9UBlBq5gc8Bb
	MgjkCN6ARkdfLqBUehbpnocLgCPgiPZU0qYjbO4M0j6D4wbhVooW1tv8NT9xWR9X3zLokOKHrMh
	YYODNV2O8BTikyEktbgRmSz8nQirus7o4AOWwRO/2D/e2Agb8tD94v8cmrZp3U/c5y2a81hYVBG
	nQH2kiU7g3IBXDfGDlTT37Yyv/qGSE9xXNKCIB/NAuFB65FKyD90daAUL1NtPYpOD1OBs2S+ZjY
	7jNfq+pvIbkZfMoK7vdO9ooMmIo7OmPzsglTj
X-Google-Smtp-Source: AGHT+IGUZLDiw33/JusWKJMjCB0GaShc0TUfUDE9gcjWDTEOHG0oVAPEGOSLIPAriDt/zwEe39ntOg==
X-Received: by 2002:a17:907:7250:b0:b04:35c3:40b3 with SMTP id a640c23a62f3a-b0435c3438amr1567507866b.15.1757042677580;
        Thu, 04 Sep 2025 20:24:37 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b0423ed35e4sm1176915466b.25.2025.09.04.20.24.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Sep 2025 20:24:37 -0700 (PDT)
From: Wei Yang <richard.weiyang@gmail.com>
To: akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	Wei Yang <richard.weiyang@gmail.com>,
	David Hildenbrand <david@redhat.com>,
	Zi Yan <ziy@nvidia.com>,
	Donet Tom <donettom@linux.ibm.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>
Subject: [PATCH] selftests/mm: refactore split_huge_page_test with kselftest_harness
Date: Fri,  5 Sep 2025 03:24:31 +0000
Message-Id: <20250905032431.22179-1-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.11.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>

Refactor split_huge_page_test with kselftest_harness, since there is a
magic counting about valid tests.

The idea is simple:

For standalone test, put it into TEST().

For tests iterating order/offset, define fixture and variant with
order and offset. And skip it if order/offset is not valid.

No functional change is expected.

Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Zi Yan <ziy@nvidia.com>
Cc: Donet Tom <donettom@linux.ibm.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 .../selftests/mm/split_huge_page_test.c       | 308 ++++++++++++++----
 1 file changed, 238 insertions(+), 70 deletions(-)

diff --git a/tools/testing/selftests/mm/split_huge_page_test.c b/tools/testing/selftests/mm/split_huge_page_test.c
index 7731191cc8e9..2376c3530b26 100644
--- a/tools/testing/selftests/mm/split_huge_page_test.c
+++ b/tools/testing/selftests/mm/split_huge_page_test.c
@@ -20,14 +20,16 @@
 #include <stdbool.h>
 #include <time.h>
 #include "vm_util.h"
-#include "../kselftest.h"
+#include "../kselftest_harness.h"
 
 uint64_t pagesize;
-unsigned int pageshift;
 uint64_t pmd_pagesize;
 unsigned int pmd_order;
 int *expected_orders;
 
+char *optional_xfs_path;
+char fs_loc_template[] = "/tmp/thp_fs_XXXXXX";
+
 #define SPLIT_DEBUGFS "/sys/kernel/debug/split_huge_pages"
 #define SMAP_PATH "/proc/self/smaps"
 #define INPUT_MAX 80
@@ -41,6 +43,20 @@ const char *kpageflags_proc = "/proc/kpageflags";
 int pagemap_fd;
 int kpageflags_fd;
 
+#define ADD_VARIANT_ORDER(fixture_name, ord)			\
+	FIXTURE_VARIANT_ADD(fixture_name, order_##ord)		\
+	{							\
+		.order = ord,					\
+	}
+
+#define ADD_VARIANT_ORDER_OFFSET(fixture_name, ord, stp)		\
+	FIXTURE_VARIANT_ADD(fixture_name, order_##ord##_stp_##stp)	\
+	{								\
+		.order = ord,						\
+		.step = stp,						\
+	}
+
+
 static bool is_backed_by_folio(char *vaddr, int order, int pagemap_fd,
 		int kpageflags_fd)
 {
@@ -255,6 +271,26 @@ static int check_after_split_folio_orders(char *vaddr_start, size_t len,
 	return status;
 }
 
+void prepare_proc_fd(void)
+{
+	pagemap_fd = open(pagemap_proc, O_RDONLY);
+	if (pagemap_fd == -1)
+		ksft_exit_fail_msg("read pagemap: %s\n", strerror(errno));
+
+	kpageflags_fd = open(kpageflags_proc, O_RDONLY);
+	if (kpageflags_fd == -1)
+		ksft_exit_fail_msg("read kpageflags: %s\n", strerror(errno));
+}
+
+void cleanup_proc_fd(void)
+{
+	if (pagemap_fd != -1)
+		close(pagemap_fd);
+
+	if (kpageflags_fd != -1)
+		close(kpageflags_fd);
+}
+
 static void write_file(const char *path, const char *buf, size_t buflen)
 {
 	int fd;
@@ -292,10 +328,8 @@ static char *allocate_zero_filled_hugepage(size_t len)
 	size_t i;
 
 	result = memalign(pmd_pagesize, len);
-	if (!result) {
-		printf("Fail to allocate memory\n");
-		exit(EXIT_FAILURE);
-	}
+	if (!result)
+		ksft_exit_fail_msg("Fail to allocate memory: %s\n", strerror(errno));
 
 	madvise(result, len, MADV_HUGEPAGE);
 
@@ -334,16 +368,19 @@ static void verify_rss_anon_split_huge_page_all_zeroes(char *one_page, int nr_hp
 		       rss_anon_before, rss_anon_after);
 }
 
-static void split_pmd_zero_pages(void)
+TEST(split_pmd_zero_pages)
 {
 	char *one_page;
 	int nr_hpages = 4;
 	size_t len = nr_hpages * pmd_pagesize;
 
+	prepare_proc_fd();
+
 	one_page = allocate_zero_filled_hugepage(len);
 	verify_rss_anon_split_huge_page_all_zeroes(one_page, nr_hpages, len);
-	ksft_test_result_pass("Split zero filled huge pages successful\n");
 	free(one_page);
+
+	cleanup_proc_fd();
 }
 
 static void split_pmd_thp_to_order(int order)
@@ -383,11 +420,10 @@ static void split_pmd_thp_to_order(int order)
 	if (!check_huge_anon(one_page, 0, pmd_pagesize))
 		ksft_exit_fail_msg("Still AnonHugePages not split\n");
 
-	ksft_test_result_pass("Split huge pages to order %d successful\n", order);
 	free(one_page);
 }
 
-static void split_pte_mapped_thp(void)
+TEST(split_pte_mapped_thp)
 {
 	const size_t nr_thps = 4;
 	const size_t thp_area_size = nr_thps * pmd_pagesize;
@@ -395,6 +431,8 @@ static void split_pte_mapped_thp(void)
 	char *thp_area, *tmp, *page_area = MAP_FAILED;
 	size_t i;
 
+	prepare_proc_fd();
+
 	thp_area = mmap((void *)(1UL << 30), thp_area_size, PROT_READ | PROT_WRITE,
 			MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
 	if (thp_area == MAP_FAILED) {
@@ -470,14 +508,43 @@ static void split_pte_mapped_thp(void)
 		ksft_test_result_fail("THP %zu not split\n", i);
 	}
 
-	ksft_test_result_pass("Split PTE-mapped huge pages successful\n");
 out:
 	munmap(thp_area, thp_area_size);
 	if (page_area != MAP_FAILED)
 		munmap(page_area, page_area_size);
+	cleanup_proc_fd();
+}
+
+FIXTURE(split_file_backed_thp) {
+};
+
+FIXTURE_VARIANT(split_file_backed_thp) {
+	int order;
+};
+
+FIXTURE_SETUP(split_file_backed_thp)
+{
+	if (variant->order >= pmd_order)
+		SKIP(return, "order %d is not supported", variant->order);
+	prepare_proc_fd();
+}
+
+FIXTURE_TEARDOWN(split_file_backed_thp)
+{
+	cleanup_proc_fd();
 }
 
-static void split_file_backed_thp(int order)
+ADD_VARIANT_ORDER(split_file_backed_thp, 0);
+ADD_VARIANT_ORDER(split_file_backed_thp, 1);
+ADD_VARIANT_ORDER(split_file_backed_thp, 2);
+ADD_VARIANT_ORDER(split_file_backed_thp, 3);
+ADD_VARIANT_ORDER(split_file_backed_thp, 4);
+ADD_VARIANT_ORDER(split_file_backed_thp, 5);
+ADD_VARIANT_ORDER(split_file_backed_thp, 6);
+ADD_VARIANT_ORDER(split_file_backed_thp, 7);
+ADD_VARIANT_ORDER(split_file_backed_thp, 8);
+
+TEST_F(split_file_backed_thp, orders)
 {
 	int status;
 	int fd;
@@ -487,7 +554,7 @@ static void split_file_backed_thp(int order)
 	ssize_t num_written, num_read;
 	char *file_buf1, *file_buf2;
 	uint64_t pgoff_start = 0, pgoff_end = 1024;
-	int i;
+	int i, order = variant->order;
 
 	ksft_print_msg("Please enable pr_debug in split_huge_pages_in_file() for more info.\n");
 
@@ -567,7 +634,6 @@ static void split_file_backed_thp(int order)
 		ksft_exit_fail_msg("cannot remove tmp dir: %s\n", strerror(errno));
 
 	ksft_print_msg("Please check dmesg for more information\n");
-	ksft_test_result_pass("File-backed THP split to order %d test done\n", order);
 	return;
 
 close_file:
@@ -579,6 +645,45 @@ static void split_file_backed_thp(int order)
 	ksft_exit_fail_msg("Error occurred\n");
 }
 
+FIXTURE(split_pmd_thp_to_order) {
+};
+
+FIXTURE_VARIANT(split_pmd_thp_to_order) {
+	int order;
+};
+
+FIXTURE_SETUP(split_pmd_thp_to_order)
+{
+	if (variant->order >= pmd_order)
+		SKIP(return, "order %d is not supported", variant->order);
+
+	expected_orders = (int *)malloc(sizeof(int) * (pmd_order + 1));
+	if (!expected_orders)
+		ksft_exit_fail_msg("Fail to allocate memory: %s\n", strerror(errno));
+
+	prepare_proc_fd();
+}
+
+FIXTURE_TEARDOWN(split_pmd_thp_to_order)
+{
+	free(expected_orders);
+	cleanup_proc_fd();
+}
+
+ADD_VARIANT_ORDER(split_pmd_thp_to_order, 0);
+ADD_VARIANT_ORDER(split_pmd_thp_to_order, 2);
+ADD_VARIANT_ORDER(split_pmd_thp_to_order, 3);
+ADD_VARIANT_ORDER(split_pmd_thp_to_order, 4);
+ADD_VARIANT_ORDER(split_pmd_thp_to_order, 5);
+ADD_VARIANT_ORDER(split_pmd_thp_to_order, 6);
+ADD_VARIANT_ORDER(split_pmd_thp_to_order, 7);
+ADD_VARIANT_ORDER(split_pmd_thp_to_order, 8);
+
+TEST_F(split_pmd_thp_to_order, order)
+{
+	split_pmd_thp_to_order(variant->order);
+}
+
 static bool prepare_thp_fs(const char *xfs_path, char *thp_fs_template,
 		const char **thp_fs_loc)
 {
@@ -757,81 +862,144 @@ static void split_thp_in_pagecache_to_order_at(size_t fd_size,
 	}
 }
 
-int main(int argc, char **argv)
-{
-	int i;
-	size_t fd_size;
-	char *optional_xfs_path = NULL;
-	char fs_loc_template[] = "/tmp/thp_fs_XXXXXX";
+FIXTURE(split_thp_in_pagecache_to_order) {
+	bool created_tmp;
 	const char *fs_loc;
+};
+
+FIXTURE_VARIANT(split_thp_in_pagecache_to_order) {
+	int order;
+};
+
+FIXTURE_SETUP(split_thp_in_pagecache_to_order)
+{
+	/* limit order to less than pmd_order */
+	if (variant->order >= pmd_order)
+		SKIP(return, "order %d is not supported", variant->order);
+	expected_orders = (int *)malloc(sizeof(int) * (pmd_order + 1));
+	if (!expected_orders)
+		ksft_exit_fail_msg("Fail to allocate memory: %s\n", strerror(errno));
+
+	self->created_tmp = prepare_thp_fs(optional_xfs_path, fs_loc_template,
+					&self->fs_loc);
+	prepare_proc_fd();
+}
+
+FIXTURE_TEARDOWN(split_thp_in_pagecache_to_order)
+{
+	cleanup_proc_fd();
+	cleanup_thp_fs(self->fs_loc, self->created_tmp);
+	free(expected_orders);
+}
+
+ADD_VARIANT_ORDER(split_thp_in_pagecache_to_order, 8);
+ADD_VARIANT_ORDER(split_thp_in_pagecache_to_order, 7);
+ADD_VARIANT_ORDER(split_thp_in_pagecache_to_order, 6);
+ADD_VARIANT_ORDER(split_thp_in_pagecache_to_order, 5);
+ADD_VARIANT_ORDER(split_thp_in_pagecache_to_order, 4);
+ADD_VARIANT_ORDER(split_thp_in_pagecache_to_order, 3);
+ADD_VARIANT_ORDER(split_thp_in_pagecache_to_order, 2);
+ADD_VARIANT_ORDER(split_thp_in_pagecache_to_order, 1);
+ADD_VARIANT_ORDER(split_thp_in_pagecache_to_order, 0);
+
+TEST_F(split_thp_in_pagecache_to_order, order)
+{
+	size_t fd_size = 2 * pmd_pagesize;
+
+	split_thp_in_pagecache_to_order_at(fd_size, self->fs_loc, variant->order, -1);
+}
+
+FIXTURE(split_thp_in_pagecache_to_order_offset) {
 	bool created_tmp;
+	const char *fs_loc;
 	int offset;
-	unsigned int nr_pages;
-	unsigned int tests;
+};
 
-	ksft_print_header();
+FIXTURE_VARIANT(split_thp_in_pagecache_to_order_offset) {
+	int order;
+	int step;
+};
 
-	if (geteuid() != 0) {
-		ksft_print_msg("Please run the benchmark as root\n");
-		ksft_finished();
-	}
-
-	if (argc > 1)
-		optional_xfs_path = argv[1];
+FIXTURE_SETUP(split_thp_in_pagecache_to_order_offset)
+{
+	int nr_pages = pmd_pagesize / pagesize;
+	int offset = variant->step * MAX(nr_pages / 4, 1 << variant->order);
 
-	pagesize = getpagesize();
-	pageshift = ffs(pagesize) - 1;
-	pmd_pagesize = read_pmd_pagesize();
-	if (!pmd_pagesize)
-		ksft_exit_fail_msg("Reading PMD pagesize failed\n");
+	/* limit order to less than pmd_order */
+	if (variant->order >= pmd_order)
+		SKIP(return, "order %d is not supported", variant->order);
 
-	nr_pages = pmd_pagesize / pagesize;
-	pmd_order = sz2ord(pmd_pagesize, pagesize);
+	if (offset < nr_pages)
+		self->offset = offset;
+	else
+		SKIP(return, "offset out of thp range");
 
 	expected_orders = (int *)malloc(sizeof(int) * (pmd_order + 1));
 	if (!expected_orders)
 		ksft_exit_fail_msg("Fail to allocate memory: %s\n", strerror(errno));
 
-	tests = 2 + (pmd_order - 1) + (2 * pmd_order) + (pmd_order - 1) * 4 + 2;
-	ksft_set_plan(tests);
-
-	pagemap_fd = open(pagemap_proc, O_RDONLY);
-	if (pagemap_fd == -1)
-		ksft_exit_fail_msg("read pagemap: %s\n", strerror(errno));
-
-	kpageflags_fd = open(kpageflags_proc, O_RDONLY);
-	if (kpageflags_fd == -1)
-		ksft_exit_fail_msg("read kpageflags: %s\n", strerror(errno));
+	self->created_tmp = prepare_thp_fs(optional_xfs_path, fs_loc_template,
+					&self->fs_loc);
+	prepare_proc_fd();
+}
 
-	fd_size = 2 * pmd_pagesize;
+FIXTURE_TEARDOWN(split_thp_in_pagecache_to_order_offset)
+{
+	cleanup_proc_fd();
+	cleanup_thp_fs(self->fs_loc, self->created_tmp);
+	free(expected_orders);
+}
 
-	split_pmd_zero_pages();
+#define SPLIT_IN_PAGECACHE_ORDER_OFFSETS(ord)					 \
+	ADD_VARIANT_ORDER_OFFSET(split_thp_in_pagecache_to_order_offset, ord, 0);\
+	ADD_VARIANT_ORDER_OFFSET(split_thp_in_pagecache_to_order_offset, ord, 1);\
+	ADD_VARIANT_ORDER_OFFSET(split_thp_in_pagecache_to_order_offset, ord, 2);\
+	ADD_VARIANT_ORDER_OFFSET(split_thp_in_pagecache_to_order_offset, ord, 3)\
+
+SPLIT_IN_PAGECACHE_ORDER_OFFSETS(0);
+SPLIT_IN_PAGECACHE_ORDER_OFFSETS(1);
+SPLIT_IN_PAGECACHE_ORDER_OFFSETS(2);
+SPLIT_IN_PAGECACHE_ORDER_OFFSETS(3);
+SPLIT_IN_PAGECACHE_ORDER_OFFSETS(4);
+SPLIT_IN_PAGECACHE_ORDER_OFFSETS(5);
+SPLIT_IN_PAGECACHE_ORDER_OFFSETS(6);
+SPLIT_IN_PAGECACHE_ORDER_OFFSETS(7);
+SPLIT_IN_PAGECACHE_ORDER_OFFSETS(8);
+
+TEST_F(split_thp_in_pagecache_to_order_offset, order_offset)
+{
+	size_t fd_size = 2 * pmd_pagesize;
 
-	for (i = 0; i < pmd_order; i++)
-		if (i != 1)
-			split_pmd_thp_to_order(i);
+	split_thp_in_pagecache_to_order_at(fd_size, self->fs_loc,
+			variant->order, self->offset);
+}
 
-	split_pte_mapped_thp();
-	for (i = 0; i < pmd_order; i++)
-		split_file_backed_thp(i);
+int main(int argc, char **argv)
+{
+	int i;
 
-	created_tmp = prepare_thp_fs(optional_xfs_path, fs_loc_template,
-			&fs_loc);
-	for (i = pmd_order - 1; i >= 0; i--)
-		split_thp_in_pagecache_to_order_at(fd_size, fs_loc, i, -1);
+	if (geteuid() != 0) {
+		ksft_print_msg("Please run the benchmark as root\n");
+		ksft_finished();
+	}
 
-	for (i = 0; i < pmd_order; i++)
-		for (offset = 0;
-		     offset < nr_pages;
-		     offset += MAX(nr_pages / 4, 1 << i))
-			split_thp_in_pagecache_to_order_at(fd_size, fs_loc, i, offset);
-	cleanup_thp_fs(fs_loc, created_tmp);
+	for (i = 1; i < argc; i++) {
+		/* only one parameter supported */
+		if (*argv[i] != '-') {
+			optional_xfs_path = argv[i];
+			break;
+		}
 
-	close(pagemap_fd);
-	close(kpageflags_fd);
-	free(expected_orders);
+		/* option -l/-h has no parameter */
+		if (*(argv[i] + 1) != 'l' && *(argv[i] + 1) != 'h')
+			i++;
+	}
 
-	ksft_finished();
+	pagesize = getpagesize();
+	pmd_pagesize = read_pmd_pagesize();
+	if (!pmd_pagesize)
+		ksft_exit_fail_msg("Reading PMD pagesize failed\n");
+	pmd_order = sz2ord(pmd_pagesize, pagesize);
 
-	return 0;
+	return test_harness_run(argc, argv);
 }
-- 
2.34.1


