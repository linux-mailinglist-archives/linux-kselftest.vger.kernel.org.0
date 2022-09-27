Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE88A5EC056
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Sep 2022 13:03:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231778AbiI0LC4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 27 Sep 2022 07:02:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231706AbiI0LCU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 27 Sep 2022 07:02:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D429F5AC70
        for <linux-kselftest@vger.kernel.org>; Tue, 27 Sep 2022 04:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664276504;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=67MQdpq3rsEztUFgas8DeaT4UznxvUWpJMHF+tOYoio=;
        b=b+ndT44dxfGtgflhi390jcSBEJIgHwcLXOGaYwBSu/zUwwWfeNezfJU/PBUKMS6+lTmrn2
        KUACN211k3R8RvgxX1TAF9zSL8alZ9RjDj+N9GL8Y8pzhY2Ipx3O4kWQpYN0QMhibXzLpg
        iNGvdjpXHJwK2n1NePC2PJ5M5gAY4Wo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-294-1I8snYYfN7S5Cgya_yiFww-1; Tue, 27 Sep 2022 07:01:39 -0400
X-MC-Unique: 1I8snYYfN7S5Cgya_yiFww-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BFB381019C89;
        Tue, 27 Sep 2022 11:01:38 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.39.194.14])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 31B41C15BB2;
        Tue, 27 Sep 2022 11:01:36 +0000 (UTC)
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
Subject: [PATCH v1 4/7] selftests/vm: anon_cow: hugetlb tests
Date:   Tue, 27 Sep 2022 13:01:17 +0200
Message-Id: <20220927110120.106906-5-david@redhat.com>
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

Let's run all existing test cases with all hugetlb sizes we're able to
detect.

Note that some tests cases still fail. This will, for example, be fixed
once vmsplice properly uses FOLL_PIN instead of FOLL_GET for pinning.
With 2 MiB and 1 GiB hugetlb on x86_64, the expected failures are:

 # [RUN] vmsplice() + unmap in child ... with hugetlb (2048 kB)
 not ok 23 No leak from parent into child
 # [RUN] vmsplice() + unmap in child ... with hugetlb (1048576 kB)
 not ok 24 No leak from parent into child
 # [RUN] vmsplice() before fork(), unmap in parent after fork() ... with hugetlb (2048 kB)
 not ok 35 No leak from child into parent
 # [RUN] vmsplice() before fork(), unmap in parent after fork() ... with hugetlb (1048576 kB)
 not ok 36 No leak from child into parent
 # [RUN] vmsplice() + unmap in parent after fork() ... with hugetlb (2048 kB)
 not ok 47 No leak from child into parent
 # [RUN] vmsplice() + unmap in parent after fork() ... with hugetlb (1048576 kB)
 not ok 48 No leak from child into parent

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 tools/testing/selftests/vm/anon_cow.c | 70 ++++++++++++++++++++++++++-
 1 file changed, 69 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/vm/anon_cow.c b/tools/testing/selftests/vm/anon_cow.c
index 9244c8551a95..06fd046bf1f2 100644
--- a/tools/testing/selftests/vm/anon_cow.c
+++ b/tools/testing/selftests/vm/anon_cow.c
@@ -25,6 +25,8 @@
 static size_t pagesize;
 static int pagemap_fd;
 static size_t thpsize;
+static int nr_hugetlbsizes;
+static size_t hugetlbsizes[10];
 
 static void detect_thpsize(void)
 {
@@ -54,6 +56,31 @@ static void detect_thpsize(void)
 	close(fd);
 }
 
+static void detect_hugetlbsizes(void)
+{
+	DIR *dir = opendir("/sys/kernel/mm/hugepages/");
+
+	if (!dir)
+		return;
+
+	while (nr_hugetlbsizes < ARRAY_SIZE(hugetlbsizes)) {
+		struct dirent *entry = readdir(dir);
+		size_t kb;
+
+		if (!entry)
+			break;
+		if (entry->d_type != DT_DIR)
+			continue;
+		if (sscanf(entry->d_name, "hugepages-%zukB", &kb) != 1)
+			continue;
+		hugetlbsizes[nr_hugetlbsizes] = kb * 1024;
+		nr_hugetlbsizes++;
+		ksft_print_msg("[INFO] detected hugetlb size: %zu KiB\n",
+			       kb);
+	}
+	closedir(dir);
+}
+
 static bool range_is_swapped(void *addr, size_t size)
 {
 	for (; size; addr += pagesize, size -= pagesize)
@@ -556,6 +583,41 @@ static void run_with_partial_shared_thp(test_fn fn, const char *desc)
 	do_run_with_thp(fn, THP_RUN_PARTIAL_SHARED);
 }
 
+static void run_with_hugetlb(test_fn fn, const char *desc, size_t hugetlbsize)
+{
+	int flags = MAP_PRIVATE | MAP_ANONYMOUS | MAP_HUGETLB;
+	char *mem, *dummy;
+
+	ksft_print_msg("[RUN] %s ... with hugetlb (%zu kB)\n", desc,
+		       hugetlbsize / 1024);
+
+	flags |= __builtin_ctzll(hugetlbsize) << MAP_HUGE_SHIFT;
+
+	mem = mmap(NULL, hugetlbsize, PROT_READ | PROT_WRITE, flags, -1, 0);
+	if (mem == MAP_FAILED) {
+		ksft_test_result_skip("need more free huge pages\n");
+		return;
+	}
+
+	/* Populate an huge page. */
+	memset(mem, 0, hugetlbsize);
+
+	/*
+	 * We need a total of two hugetlb pages to handle COW/unsharing
+	 * properly, otherwise we might get zapped by a SIGBUS.
+	 */
+	dummy = mmap(NULL, hugetlbsize, PROT_READ | PROT_WRITE, flags, -1, 0);
+	if (dummy == MAP_FAILED) {
+		ksft_test_result_skip("need more free huge pages\n");
+		goto munmap;
+	}
+	munmap(dummy, hugetlbsize);
+
+	fn(mem, hugetlbsize);
+munmap:
+	munmap(mem, hugetlbsize);
+}
+
 struct test_case {
 	const char *desc;
 	test_fn fn;
@@ -602,6 +664,8 @@ static const struct test_case test_cases[] = {
 
 static void run_test_case(struct test_case const *test_case)
 {
+	int i;
+
 	run_with_base_page(test_case->fn, test_case->desc);
 	run_with_base_page_swap(test_case->fn, test_case->desc);
 	if (thpsize) {
@@ -614,6 +678,9 @@ static void run_test_case(struct test_case const *test_case)
 		run_with_partial_mremap_thp(test_case->fn, test_case->desc);
 		run_with_partial_shared_thp(test_case->fn, test_case->desc);
 	}
+	for (i = 0; i < nr_hugetlbsizes; i++)
+		run_with_hugetlb(test_case->fn, test_case->desc,
+				 hugetlbsizes[i]);
 }
 
 static void run_test_cases(void)
@@ -626,7 +693,7 @@ static void run_test_cases(void)
 
 static int tests_per_test_case(void)
 {
-	int tests = 2;
+	int tests = 2 + nr_hugetlbsizes;
 
 	if (thpsize)
 		tests += 8;
@@ -640,6 +707,7 @@ int main(int argc, char **argv)
 
 	pagesize = getpagesize();
 	detect_thpsize();
+	detect_hugetlbsizes();
 
 	ksft_print_header();
 	ksft_set_plan(nr_test_cases * tests_per_test_case());
-- 
2.37.3

