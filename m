Return-Path: <linux-kselftest+bounces-36672-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0B58AFAD49
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Jul 2025 09:35:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF5433B9578
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Jul 2025 07:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F022E220F2C;
	Mon,  7 Jul 2025 07:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=usama.anjum@collabora.com header.b="aJlh81gn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE6C421FF5C;
	Mon,  7 Jul 2025 07:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751873638; cv=pass; b=kIi36ws2BC6cHrhg0FC42UniDIoiUdcZ17Rtp1kpKH7oZbpSTBa9iR/stDG1d2++JM5OTeD7T09UBgRz7z03toXaLiiUtuahluw7/ArdBagw+tZKODb5NVtbwST2s9qiZeObKJ4b7d+iWudC57d2JN8DSMpiJwPNtPfIcEGYsA8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751873638; c=relaxed/simple;
	bh=wXsTWyd4yYlOsiktiqaiTuUm1qucpLijYl3bq49V17w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZILTz21rYqEtwppwi670Th+QQutZuTREtY2wviqtPy82izQ9Z3DbMD5LDDrf0RQVPUBHF7/5vM3YAYFcYXUbXkdiTXAXogdu/4nBzZ27ry3uEIPihJtpeilZyCCIDaS28webEriT22XW0dl54yGuSJfHzOBuOTY0i0DcdttaI50=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=usama.anjum@collabora.com header.b=aJlh81gn; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1751873620; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=HTCku5Z4eE+HXVPl3u6T2Czgb3E8BG0hU0FVn/GpZjxuDiW5YetXJMhHfh95kfzxvgNsyN09pPJe0boWmoD0NxCGIfiJD8sfNEDZ82lARDwuG3n9a9X2wwBIVMXry4hfk4pL2iGKt6LAS99IEujqwYdZBmfAZD1N0o1b7Ipv4m8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1751873620; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=BdU2n3YWpibKbpwCxOh1ePuw+qQOxSR0HU9wfR6gAUw=; 
	b=UUtocAbeWAI9mnkKNCOlVjqWdsytG9HMeedJ9kKrctqq7KJ7JkyEu8zd6+ZCVsVoPRUolbhlLonFfNxnXfgI7JoICALTx6KEjDlQnoH9EgwIgNIKjGQmmfhTziS/wEI0anJWqdrK41eEvGD9ggnABvzLtTLp9fYdBbNPPo8LZhE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=usama.anjum@collabora.com;
	dmarc=pass header.from=<usama.anjum@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1751873620;
	s=zohomail; d=collabora.com; i=usama.anjum@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=BdU2n3YWpibKbpwCxOh1ePuw+qQOxSR0HU9wfR6gAUw=;
	b=aJlh81gnwv0G1WDmGbMUDQMTGB7/sBHhRZLQ/LdDsTfMlJSrQlsII+HOS4H4R+pC
	+3PxtlCvu3Y0bXGRyk3u09OWv3tMp8ZfX2PPh6zmdtFpmGGufya6lLwCL5EgMZV8zCv
	XwCHvyPXvLIpvlBqF73giMgeFOZKnBr6oXA06TlY=
Received: by mx.zohomail.com with SMTPS id 1751873617320882.1477553147479;
	Mon, 7 Jul 2025 00:33:37 -0700 (PDT)
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
	kernel@collabora.com,
	David Hildenbrand <david@redhat.com>,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] selftests/mm: pagemap_scan ioctl: add PFN ZERO test cases
Date: Mon,  7 Jul 2025 12:33:20 +0500
Message-ID: <20250707073321.106431-1-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Add test cases to test the correctness of PFN ZERO flag of pagemap_scan
ioctl. Test with normal pages backed memory and huge pages backed
memory.

Cc: David Hildenbrand <david@redhat.com>
Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
The bug has been fixed [1].

[1] https://lore.kernel.org/all/20250617143532.2375383-1-david@redhat.com
Changes since v1:
- Skip if madvise() fails
- Skip test if use_zero_page isn't set to 1
- Keep on using memalign()+free() to allocate huge pages

Changes sice v2:
- Move zero page detection code out to vm_util and use that
- Use mmap instead of memalign to allocate hugepage
---
 tools/testing/selftests/mm/cow.c           | 27 +-------
 tools/testing/selftests/mm/pagemap_ioctl.c | 72 +++++++++++++++++++++-
 tools/testing/selftests/mm/vm_util.c       | 23 +++++++
 tools/testing/selftests/mm/vm_util.h       |  2 +
 4 files changed, 95 insertions(+), 29 deletions(-)

diff --git a/tools/testing/selftests/mm/cow.c b/tools/testing/selftests/mm/cow.c
index b6cfe0a4b7dfd..b26bbf6ec4617 100644
--- a/tools/testing/selftests/mm/cow.c
+++ b/tools/testing/selftests/mm/cow.c
@@ -72,31 +72,6 @@ static int detect_thp_sizes(size_t sizes[], int max)
 	return count;
 }
 
-static void detect_huge_zeropage(void)
-{
-	int fd = open("/sys/kernel/mm/transparent_hugepage/use_zero_page",
-		      O_RDONLY);
-	size_t enabled = 0;
-	char buf[15];
-	int ret;
-
-	if (fd < 0)
-		return;
-
-	ret = pread(fd, buf, sizeof(buf), 0);
-	if (ret > 0 && ret < sizeof(buf)) {
-		buf[ret] = 0;
-
-		enabled = strtoul(buf, NULL, 10);
-		if (enabled == 1) {
-			has_huge_zeropage = true;
-			ksft_print_msg("[INFO] huge zeropage is enabled\n");
-		}
-	}
-
-	close(fd);
-}
-
 static bool range_is_swapped(void *addr, size_t size)
 {
 	for (; size; addr += pagesize, size -= pagesize)
@@ -1791,7 +1766,7 @@ int main(int argc, char **argv)
 	}
 	nr_hugetlbsizes = detect_hugetlb_page_sizes(hugetlbsizes,
 						    ARRAY_SIZE(hugetlbsizes));
-	detect_huge_zeropage();
+	has_huge_zeropage = detect_huge_zeropage();
 
 	ksft_set_plan(ARRAY_SIZE(anon_test_cases) * tests_per_anon_test_case() +
 		      ARRAY_SIZE(anon_thp_test_cases) * tests_per_anon_thp_test_case() +
diff --git a/tools/testing/selftests/mm/pagemap_ioctl.c b/tools/testing/selftests/mm/pagemap_ioctl.c
index 57b4bba2b45f3..059c6d5f971e7 100644
--- a/tools/testing/selftests/mm/pagemap_ioctl.c
+++ b/tools/testing/selftests/mm/pagemap_ioctl.c
@@ -1,4 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
+
 #define _GNU_SOURCE
 #include <stdio.h>
 #include <fcntl.h>
@@ -34,8 +35,8 @@
 #define PAGEMAP "/proc/self/pagemap"
 int pagemap_fd;
 int uffd;
-unsigned int page_size;
-unsigned int hpage_size;
+size_t page_size;
+size_t hpage_size;
 const char *progname;
 
 #define LEN(region)	((region.end - region.start)/page_size)
@@ -1480,6 +1481,68 @@ static void transact_test(int page_size)
 			      extra_thread_faults);
 }
 
+void zeropfn_tests(void)
+{
+	unsigned long long mem_size;
+	struct page_region vec;
+	int i, ret;
+	char *mmap_mem, *mem;
+
+	/* Test with normal memory */
+	mem_size = 10 * page_size;
+	mem = mmap(NULL, mem_size, PROT_READ, MAP_PRIVATE | MAP_ANON, -1, 0);
+	if (mem == MAP_FAILED)
+		ksft_exit_fail_msg("error nomem\n");
+
+	/* Touch each page to ensure it's mapped */
+	for (i = 0; i < mem_size; i += page_size)
+		(void)((volatile char *)mem)[i];
+
+	ret = pagemap_ioctl(mem, mem_size, &vec, 1, 0,
+			    (mem_size / page_size), PAGE_IS_PFNZERO, 0, 0, PAGE_IS_PFNZERO);
+	if (ret < 0)
+		ksft_exit_fail_msg("error %d %d %s\n", ret, errno, strerror(errno));
+
+	ksft_test_result(ret == 1 && LEN(vec) == (mem_size / page_size),
+			 "%s all pages must have PFNZERO set\n", __func__);
+
+	munmap(mem, mem_size);
+
+	/* Test with huge page if user_zero_page is set to 1 */
+	if (!detect_huge_zeropage()) {
+		ksft_test_result_skip("%s use_zero_page not supported or set to 1\n", __func__);
+		return;
+	}
+
+	mem_size = 2 * hpage_size;
+	mmap_mem = mmap(NULL, mem_size, PROT_READ | PROT_WRITE,
+			MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+	if (mmap_mem == MAP_FAILED)
+		ksft_exit_fail_msg("error nomem\n");
+
+	/* We need a THP-aligned memory area. */
+	mem = (char *)(((uintptr_t)mmap_mem + hpage_size) & ~(hpage_size - 1));
+
+	ret = madvise(mem, hpage_size, MADV_HUGEPAGE);
+	if (!ret) {
+		char tmp = *mem;
+
+		asm volatile("" : "+r" (tmp));
+
+		ret = pagemap_ioctl(mem, hpage_size, &vec, 1, 0,
+				    0, PAGE_IS_PFNZERO, 0, 0, PAGE_IS_PFNZERO);
+		if (ret < 0)
+			ksft_exit_fail_msg("error %d %d %s\n", ret, errno, strerror(errno));
+
+		ksft_test_result(ret == 1 && LEN(vec) == (hpage_size / page_size),
+				 "%s all huge pages must have PFNZERO set\n", __func__);
+	} else {
+		ksft_test_result_skip("%s huge page not supported\n", __func__);
+	}
+
+	munmap(mmap_mem, mem_size);
+}
+
 int main(int __attribute__((unused)) argc, char *argv[])
 {
 	int shmid, buf_size, fd, i, ret;
@@ -1494,7 +1557,7 @@ int main(int __attribute__((unused)) argc, char *argv[])
 	if (init_uffd())
 		ksft_exit_pass();
 
-	ksft_set_plan(115);
+	ksft_set_plan(117);
 
 	page_size = getpagesize();
 	hpage_size = read_pmd_pagesize();
@@ -1669,6 +1732,9 @@ int main(int __attribute__((unused)) argc, char *argv[])
 	/* 16. Userfaultfd tests */
 	userfaultfd_tests();
 
+	/* 17. ZEROPFN tests */
+	zeropfn_tests();
+
 	close(pagemap_fd);
 	ksft_exit_pass();
 }
diff --git a/tools/testing/selftests/mm/vm_util.c b/tools/testing/selftests/mm/vm_util.c
index a36734fb62f38..dde9e8ab4dc46 100644
--- a/tools/testing/selftests/mm/vm_util.c
+++ b/tools/testing/selftests/mm/vm_util.c
@@ -424,3 +424,26 @@ bool check_vmflag_io(void *addr)
 		flags += flaglen;
 	}
 }
+
+bool detect_huge_zeropage(void)
+{
+	int fd = open("/sys/kernel/mm/transparent_hugepage/use_zero_page",
+		      O_RDONLY);
+	bool enabled = 0;
+	char buf[15];
+	int ret;
+
+	if (fd < 0)
+		return 0;
+
+	ret = pread(fd, buf, sizeof(buf), 0);
+	if (ret > 0 && ret < sizeof(buf)) {
+		buf[ret] = 0;
+
+		if (strtoul(buf, NULL, 10) == 1)
+			enabled = 1;
+	}
+
+	close(fd);
+	return enabled;
+}
diff --git a/tools/testing/selftests/mm/vm_util.h b/tools/testing/selftests/mm/vm_util.h
index 6effafdc4d8a2..ca4c1f78ce18c 100644
--- a/tools/testing/selftests/mm/vm_util.h
+++ b/tools/testing/selftests/mm/vm_util.h
@@ -74,6 +74,8 @@ int uffd_register_with_ioctls(int uffd, void *addr, uint64_t len,
 unsigned long get_free_hugepages(void);
 bool check_vmflag_io(void *addr);
 
+bool detect_huge_zeropage(void);
+
 /*
  * On ppc64 this will only work with radix 2M hugepage size
  */
-- 
2.43.0


