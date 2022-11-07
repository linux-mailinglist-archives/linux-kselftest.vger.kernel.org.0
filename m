Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDA4461F907
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Nov 2022 17:20:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbiKGQT7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 7 Nov 2022 11:19:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231733AbiKGQT5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 7 Nov 2022 11:19:57 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A037B18E03
        for <linux-kselftest@vger.kernel.org>; Mon,  7 Nov 2022 08:18:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667837883;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Yxk+MosSNjSrYsilz3iddlF9cDyZ14HMLOpctOV1RnY=;
        b=PD10fnfUGOlT+VcFGUPpgd7SQohU7L0QX7wgbNJDfntZrpioMkQbsJI9XW4z7psRzKPqJ+
        O/n/NrsngFX6CObLLMMh3V/xL14BS7xdKbD6BKFUFpZ/tnT8RlQR0t4+GvHrg4YVwb0BMB
        FKHQOdiVn2HlBW4OjPCrEbQWyP0qL/g=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-231-9IrSN2PQPcCPka15Oj1Ofg-1; Mon, 07 Nov 2022 11:18:02 -0500
X-MC-Unique: 9IrSN2PQPcCPka15Oj1Ofg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2DE80811E7A;
        Mon,  7 Nov 2022 16:18:00 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.39.195.106])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D07514B3FCD;
        Mon,  7 Nov 2022 16:17:54 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, etnaviv@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-media@vger.kernel.org, linux-kselftest@vger.kernel.org,
        David Hildenbrand <david@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        John Hubbard <jhubbard@nvidia.com>,
        Peter Xu <peterx@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Hugh Dickins <hughd@google.com>, Nadav Amit <namit@vmware.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        David Airlie <airlied@gmail.com>,
        Oded Gabbay <ogabbay@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH RFC 02/19] selftests/vm: cow: basic COW tests for non-anonymous pages
Date:   Mon,  7 Nov 2022 17:17:23 +0100
Message-Id: <20221107161740.144456-3-david@redhat.com>
In-Reply-To: <20221107161740.144456-1-david@redhat.com>
References: <20221107161740.144456-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Let's add basic tests for COW with non-anonymous pages in private
mappings: write access should properly trigger COW and result in the
private changes not being visible through other page mappings.

Especially, add tests for:
* Zeropage
* Huge zeropage
* Ordinary pagecache pages via memfd and tmpfile()
* Hugetlb pages via memfd

Fortunately, all tests pass.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 tools/testing/selftests/vm/cow.c | 338 ++++++++++++++++++++++++++++++-
 1 file changed, 337 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/vm/cow.c b/tools/testing/selftests/vm/cow.c
index b28143389f60..93c643bcdcf5 100644
--- a/tools/testing/selftests/vm/cow.c
+++ b/tools/testing/selftests/vm/cow.c
@@ -19,6 +19,7 @@
 #include <sys/mman.h>
 #include <sys/ioctl.h>
 #include <sys/wait.h>
+#include <linux/memfd.h>
 
 #include "local_config.h"
 #ifdef LOCAL_CONFIG_HAVE_LIBURING
@@ -35,6 +36,7 @@ static size_t thpsize;
 static int nr_hugetlbsizes;
 static size_t hugetlbsizes[10];
 static int gup_fd;
+static bool has_huge_zeropage;
 
 static void detect_thpsize(void)
 {
@@ -64,6 +66,31 @@ static void detect_thpsize(void)
 	close(fd);
 }
 
+static void detect_huge_zeropage(void)
+{
+	int fd = open("/sys/kernel/mm/transparent_hugepage/use_zero_page",
+		      O_RDONLY);
+	size_t enabled = 0;
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
+		enabled = strtoul(buf, NULL, 10);
+		if (enabled == 1) {
+			has_huge_zeropage = true;
+			ksft_print_msg("[INFO] huge zeropage is enabled\n");
+		}
+	}
+
+	close(fd);
+}
+
 static void detect_hugetlbsizes(void)
 {
 	DIR *dir = opendir("/sys/kernel/mm/hugepages/");
@@ -1105,6 +1132,312 @@ static int tests_per_anon_test_case(void)
 	return tests;
 }
 
+typedef void (*non_anon_test_fn)(char *mem, const char *smem, size_t size);
+
+static void test_cow(char *mem, const char *smem, size_t size)
+{
+	char *old = malloc(size);
+
+	/* Backup the original content. */
+	memcpy(old, smem, size);
+
+	/* Modify the page. */
+	memset(mem, 0xff, size);
+
+	/* See if we still read the old values via the other mapping. */
+	ksft_test_result(!memcmp(smem, old, size),
+			 "Other mapping not modified\n");
+	free(old);
+}
+
+static void run_with_zeropage(non_anon_test_fn fn, const char *desc)
+{
+	char *mem, *smem, tmp;
+
+	ksft_print_msg("[RUN] %s ... with shared zeropage\n", desc);
+
+	mem = mmap(NULL, pagesize, PROT_READ | PROT_WRITE,
+		   MAP_PRIVATE | MAP_ANON, -1, 0);
+	if (mem == MAP_FAILED) {
+		ksft_test_result_fail("mmap() failed\n");
+		return;
+	}
+
+	smem = mmap(NULL, pagesize, PROT_READ, MAP_PRIVATE | MAP_ANON, -1, 0);
+	if (mem == MAP_FAILED) {
+		ksft_test_result_fail("mmap() failed\n");
+		goto munmap;
+	}
+
+	/* Read from the page to populate the shared zeropage. */
+	tmp = *mem + *smem;
+	asm volatile("" : "+r" (tmp));
+
+	fn(mem, smem, pagesize);
+munmap:
+	munmap(mem, pagesize);
+	if (smem != MAP_FAILED)
+		munmap(smem, pagesize);
+}
+
+static void run_with_huge_zeropage(non_anon_test_fn fn, const char *desc)
+{
+	char *mem, *smem, *mmap_mem, *mmap_smem, tmp;
+	size_t mmap_size;
+	int ret;
+
+	ksft_print_msg("[RUN] %s ... with huge zeropage\n", desc);
+
+	if (!has_huge_zeropage) {
+		ksft_test_result_skip("Huge zeropage not enabled\n");
+		return;
+	}
+
+	/* For alignment purposes, we need twice the thp size. */
+	mmap_size = 2 * thpsize;
+	mmap_mem = mmap(NULL, mmap_size, PROT_READ | PROT_WRITE,
+			MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+	if (mmap_mem == MAP_FAILED) {
+		ksft_test_result_fail("mmap() failed\n");
+		return;
+	}
+	mmap_smem = mmap(NULL, mmap_size, PROT_READ,
+			 MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+	if (mmap_smem == MAP_FAILED) {
+		ksft_test_result_fail("mmap() failed\n");
+		goto munmap;
+	}
+
+	/* We need a THP-aligned memory area. */
+	mem = (char *)(((uintptr_t)mmap_mem + thpsize) & ~(thpsize - 1));
+	smem = (char *)(((uintptr_t)mmap_smem + thpsize) & ~(thpsize - 1));
+
+	ret = madvise(mem, thpsize, MADV_HUGEPAGE);
+	ret |= madvise(smem, thpsize, MADV_HUGEPAGE);
+	if (ret) {
+		ksft_test_result_fail("MADV_HUGEPAGE failed\n");
+		goto munmap;
+	}
+
+	/*
+	 * Read from the memory to populate the huge shared zeropage. Read from
+	 * the first sub-page and test if we get another sub-page populated
+	 * automatically.
+	 */
+	tmp = *mem + *smem;
+	asm volatile("" : "+r" (tmp));
+	if (!pagemap_is_populated(pagemap_fd, mem + pagesize) ||
+	    !pagemap_is_populated(pagemap_fd, smem + pagesize)) {
+		ksft_test_result_skip("Did not get THPs populated\n");
+		goto munmap;
+	}
+
+	fn(mem, smem, thpsize);
+munmap:
+	munmap(mmap_mem, mmap_size);
+	if (mmap_smem != MAP_FAILED)
+		munmap(mmap_smem, mmap_size);
+}
+
+static void run_with_memfd(non_anon_test_fn fn, const char *desc)
+{
+	char *mem, *smem, tmp;
+	int fd;
+
+	ksft_print_msg("[RUN] %s ... with memfd\n", desc);
+
+	fd = memfd_create("test", 0);
+	if (fd < 0) {
+		ksft_test_result_fail("memfd_create() failed\n");
+		return;
+	}
+
+	/* File consists of a single page filled with zeroes. */
+	if (fallocate(fd, 0, 0, pagesize)) {
+		ksft_test_result_fail("fallocate() failed\n");
+		goto close;
+	}
+
+	/* Create a private mapping of the memfd. */
+	mem = mmap(NULL, pagesize, PROT_READ | PROT_WRITE, MAP_PRIVATE, fd, 0);
+	if (mem == MAP_FAILED) {
+		ksft_test_result_fail("mmap() failed\n");
+		goto close;
+	}
+	smem = mmap(NULL, pagesize, PROT_READ, MAP_SHARED, fd, 0);
+	if (mem == MAP_FAILED) {
+		ksft_test_result_fail("mmap() failed\n");
+		goto munmap;
+	}
+
+	/* Fault the page in. */
+	tmp = *mem + *smem;
+	asm volatile("" : "+r" (tmp));
+
+	fn(mem, smem, pagesize);
+munmap:
+	munmap(mem, pagesize);
+	if (smem != MAP_FAILED)
+		munmap(smem, pagesize);
+close:
+	close(fd);
+}
+
+static void run_with_tmpfile(non_anon_test_fn fn, const char *desc)
+{
+	char *mem, *smem, tmp;
+	FILE *file;
+	int fd;
+
+	ksft_print_msg("[RUN] %s ... with tmpfile\n", desc);
+
+	file = tmpfile();
+	if (!file) {
+		ksft_test_result_fail("tmpfile() failed\n");
+		return;
+	}
+
+	fd = fileno(file);
+	if (fd < 0) {
+		ksft_test_result_skip("fileno() failed\n");
+		return;
+	}
+
+	/* File consists of a single page filled with zeroes. */
+	if (fallocate(fd, 0, 0, pagesize)) {
+		ksft_test_result_fail("fallocate() failed\n");
+		goto close;
+	}
+
+	/* Create a private mapping of the memfd. */
+	mem = mmap(NULL, pagesize, PROT_READ | PROT_WRITE, MAP_PRIVATE, fd, 0);
+	if (mem == MAP_FAILED) {
+		ksft_test_result_fail("mmap() failed\n");
+		goto close;
+	}
+	smem = mmap(NULL, pagesize, PROT_READ, MAP_SHARED, fd, 0);
+	if (mem == MAP_FAILED) {
+		ksft_test_result_fail("mmap() failed\n");
+		goto munmap;
+	}
+
+	/* Fault the page in. */
+	tmp = *mem + *smem;
+	asm volatile("" : "+r" (tmp));
+
+	fn(mem, smem, pagesize);
+munmap:
+	munmap(mem, pagesize);
+	if (smem != MAP_FAILED)
+		munmap(smem, pagesize);
+close:
+	fclose(file);
+}
+
+static void run_with_memfd_hugetlb(non_anon_test_fn fn, const char *desc,
+				   size_t hugetlbsize)
+{
+	int flags = MFD_HUGETLB;
+	char *mem, *smem, tmp;
+	int fd;
+
+	ksft_print_msg("[RUN] %s ... with memfd hugetlb (%zu kB)\n", desc,
+		       hugetlbsize / 1024);
+
+	flags |= __builtin_ctzll(hugetlbsize) << MFD_HUGE_SHIFT;
+
+	fd = memfd_create("test", flags);
+	if (fd < 0) {
+		ksft_test_result_skip("memfd_create() failed\n");
+		return;
+	}
+
+	/* File consists of a single page filled with zeroes. */
+	if (fallocate(fd, 0, 0, hugetlbsize)) {
+		ksft_test_result_skip("need more free huge pages\n");
+		goto close;
+	}
+
+	/* Create a private mapping of the memfd. */
+	mem = mmap(NULL, hugetlbsize, PROT_READ | PROT_WRITE, MAP_PRIVATE, fd,
+		   0);
+	if (mem == MAP_FAILED) {
+		ksft_test_result_skip("need more free huge pages\n");
+		goto close;
+	}
+	smem = mmap(NULL, hugetlbsize, PROT_READ, MAP_SHARED, fd, 0);
+	if (mem == MAP_FAILED) {
+		ksft_test_result_fail("mmap() failed\n");
+		goto munmap;
+	}
+
+	/* Fault the page in. */
+	tmp = *mem + *smem;
+	asm volatile("" : "+r" (tmp));
+
+	fn(mem, smem, hugetlbsize);
+munmap:
+	munmap(mem, hugetlbsize);
+	if (mem != MAP_FAILED)
+		munmap(smem, hugetlbsize);
+close:
+	close(fd);
+}
+
+struct non_anon_test_case {
+	const char *desc;
+	non_anon_test_fn fn;
+};
+
+/*
+ * Test cases that target any pages in private mappings that are non anonymous:
+ * pages that may get shared via COW ndependent of fork(). This includes
+ * the shared zeropage(s), pagecache pages, ...
+ */
+static const struct non_anon_test_case non_anon_test_cases[] = {
+	/*
+	 * Basic COW test without any GUP. If we miss to break COW, changes are
+	 * visible via other private/shared mappings.
+	 */
+	{
+		"Basic COW",
+		test_cow,
+	},
+};
+
+static void run_non_anon_test_case(struct non_anon_test_case const *test_case)
+{
+	int i;
+
+	run_with_zeropage(test_case->fn, test_case->desc);
+	run_with_memfd(test_case->fn, test_case->desc);
+	run_with_tmpfile(test_case->fn, test_case->desc);
+	if (thpsize)
+		run_with_huge_zeropage(test_case->fn, test_case->desc);
+	for (i = 0; i < nr_hugetlbsizes; i++)
+		run_with_memfd_hugetlb(test_case->fn, test_case->desc,
+				       hugetlbsizes[i]);
+}
+
+static void run_non_anon_test_cases(void)
+{
+	int i;
+
+	ksft_print_msg("[RUN] Non-anonymous memory tests in private mappings\n");
+
+	for (i = 0; i < ARRAY_SIZE(non_anon_test_cases); i++)
+		run_non_anon_test_case(&non_anon_test_cases[i]);
+}
+
+static int tests_per_non_anon_test_case(void)
+{
+	int tests = 3 + nr_hugetlbsizes;
+
+	if (thpsize)
+		tests += 1;
+	return tests;
+}
+
 int main(int argc, char **argv)
 {
 	int err;
@@ -1112,9 +1445,11 @@ int main(int argc, char **argv)
 	pagesize = getpagesize();
 	detect_thpsize();
 	detect_hugetlbsizes();
+	detect_huge_zeropage();
 
 	ksft_print_header();
-	ksft_set_plan(ARRAY_SIZE(anon_test_cases) * tests_per_anon_test_case());
+	ksft_set_plan(ARRAY_SIZE(anon_test_cases) * tests_per_anon_test_case() +
+		      ARRAY_SIZE(non_anon_test_cases) * tests_per_non_anon_test_case());
 
 	gup_fd = open("/sys/kernel/debug/gup_test", O_RDWR);
 	pagemap_fd = open("/proc/self/pagemap", O_RDONLY);
@@ -1122,6 +1457,7 @@ int main(int argc, char **argv)
 		ksft_exit_fail_msg("opening pagemap failed\n");
 
 	run_anon_test_cases();
+	run_non_anon_test_cases();
 
 	err = ksft_get_fail_cnt();
 	if (err)
-- 
2.38.1

