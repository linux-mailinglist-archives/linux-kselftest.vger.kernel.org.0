Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1057742B44E
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Oct 2021 06:41:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbhJMEnL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 13 Oct 2021 00:43:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbhJMEnL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 13 Oct 2021 00:43:11 -0400
Received: from mail-ua1-x936.google.com (mail-ua1-x936.google.com [IPv6:2607:f8b0:4864:20::936])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52450C061570;
        Tue, 12 Oct 2021 21:41:08 -0700 (PDT)
Received: by mail-ua1-x936.google.com with SMTP id 64so1976378uab.12;
        Tue, 12 Oct 2021 21:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=T42IolPwtVqjbq57LbYuSkkWhsnoHeDWWwuSqGe+QNY=;
        b=TJtM3vqz+pEKW5jAhA0hYN9FmeHQXoFOMTwnES/LBWmZTFlqhf7wLoBQBjwdHfY9Wg
         bbGVCHNEPqV88ctjss4mdXZc4eZl8rQn7Eg+6GWHirtXo0bbJbdcQYmZHwU0YxghkoP0
         Ja4FN06Di7iamZp6oU2kXiDWhHt9JR8k/UGiv724zcqcWc1RzPctAAbBVFEWBJ/pUYRL
         oFXOU1IwYoYyFoVm0SCVrhRyNbtepdUDsv6lmg3WLv/u3JVtnecnCDirhq+2O0ih8dmF
         AyYmSHB6fXWOwpRW9frA3kSf+RRPvFDCq7I+iISyf1l/NPoLmDh1HKx7CAUemg7Eztb+
         uyQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=T42IolPwtVqjbq57LbYuSkkWhsnoHeDWWwuSqGe+QNY=;
        b=sr2XfCE2fGUNaNknVIPAC2FnPXGpFR4P+qDoPSAF95juhgxebNzyQJyfiot+S6eQPp
         2AN20FYLtDNOQtFUVsZNrp85hVBdCHpT+EUwBUkHBgEB8yO9EDAj1uxnMJbJXeXD6K0S
         ekwpqhBJbnE5ykzcsUidR338xmvWCVDA8Bo4Ebf98pKv0zOBRKGQbSI3D0VuOf6kCwtt
         l7YDaMBzddCINnx16sLkMD6BFf3ZU8AxzvTRhsT/cm6CA6qCasSl0ErfaoJGPzgDk/MA
         kr/+HFj2K3g6wbxi+gb1XN8kPul/ES6u6U8Qj0t2XmscFXmW/twnYEOZB5+hmH71aMw7
         mtlg==
X-Gm-Message-State: AOAM533H0Y1H4ZtsnyCw4PAkABce3t6yCTO80nz/yC2SJ5vm7E72g3+U
        N7p3amG5B4qh7yGfJgi7hqc=
X-Google-Smtp-Source: ABdhPJzK+6IgBiiK3mVfzk4z48rClxKQVu5b9y6XKogTj/4L1JACIHeA61T3NTp9Bo0JcRcgc8Bwdw==
X-Received: by 2002:ab0:14a7:: with SMTP id d36mr27105412uae.96.1634100067401;
        Tue, 12 Oct 2021 21:41:07 -0700 (PDT)
Received: from localhost.localdomain ([179.223.196.141])
        by smtp.gmail.com with ESMTPSA id b3sm1338131vko.20.2021.10.12.21.41.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Oct 2021 21:41:07 -0700 (PDT)
From:   Pedro Demarchi Gomes <pedrodemargomes@gmail.com>
Cc:     pedrodemargomes@gmail.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] selftests: vm: add KSM huge pages merging time test
Date:   Wed, 13 Oct 2021 01:40:45 -0300
Message-Id: <20211013044045.360251-1-pedrodemargomes@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add test case of KSM merging time using mostly huge pages

Signed-off-by: Pedro Demarchi Gomes <pedrodemargomes@gmail.com>
---
 tools/testing/selftests/vm/ksm_tests.c | 125 ++++++++++++++++++++++++-
 1 file changed, 124 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/vm/ksm_tests.c b/tools/testing/selftests/vm/ksm_tests.c
index b61dcdb44c5b..61f3360a19df 100644
--- a/tools/testing/selftests/vm/ksm_tests.c
+++ b/tools/testing/selftests/vm/ksm_tests.c
@@ -5,6 +5,10 @@
 #include <time.h>
 #include <string.h>
 #include <numa.h>
+#include <unistd.h>
+#include <fcntl.h>
+#include <stdint.h>
+#include <err.h>
 
 #include "../kselftest.h"
 #include "../../../../include/vdso/time64.h"
@@ -18,6 +22,15 @@
 #define KSM_MERGE_ACROSS_NODES_DEFAULT true
 #define MB (1ul << 20)
 
+#define PAGE_SHIFT 12
+#define HPAGE_SHIFT 21
+
+#define PAGE_SIZE (1 << PAGE_SHIFT)
+#define HPAGE_SIZE (1 << HPAGE_SHIFT)
+
+#define PAGEMAP_PRESENT(ent)	(((ent) & (1ull << 63)) != 0)
+#define PAGEMAP_PFN(ent)	((ent) & ((1ull << 55) - 1))
+
 struct ksm_sysfs {
 	unsigned long max_page_sharing;
 	unsigned long merge_across_nodes;
@@ -34,6 +47,7 @@ enum ksm_test_name {
 	CHECK_KSM_ZERO_PAGE_MERGE,
 	CHECK_KSM_NUMA_MERGE,
 	KSM_MERGE_TIME,
+	KSM_MERGE_TIME_HUGE_PAGES,
 	KSM_COW_TIME
 };
 
@@ -99,6 +113,9 @@ static void print_help(void)
 	       " -U (page unmerging)\n"
 	       " -P evaluate merging time and speed.\n"
 	       "    For this test, the size of duplicated memory area (in MiB)\n"
+	       "    must be provided using -s option\n"
+				 " -H evaluate merging time and speed of area allocated mostly with huge pages\n"
+	       "    For this test, the size of duplicated memory area (in MiB)\n"
 	       "    must be provided using -s option\n"
 	       " -C evaluate the time required to break COW of merged pages.\n\n");
 
@@ -416,6 +433,101 @@ static int check_ksm_numa_merge(int mapping, int prot, int timeout, bool merge_a
 	return KSFT_FAIL;
 }
 
+int64_t allocate_transhuge(void *ptr, int pagemap_fd)
+{
+	uint64_t ent[2];
+
+	/* drop pmd */
+	if (mmap(ptr, HPAGE_SIZE, PROT_READ | PROT_WRITE,
+				MAP_FIXED | MAP_ANONYMOUS |
+				MAP_NORESERVE | MAP_PRIVATE, -1, 0) != ptr)
+		errx(2, "mmap transhuge");
+
+	if (madvise(ptr, HPAGE_SIZE, MADV_HUGEPAGE))
+		err(2, "MADV_HUGEPAGE");
+
+	/* allocate transparent huge page */
+	*(volatile void **)ptr = ptr;
+
+	if (pread(pagemap_fd, ent, sizeof(ent),
+			(uintptr_t)ptr >> (PAGE_SHIFT - 3)) != sizeof(ent))
+		err(2, "read pagemap");
+
+	if (PAGEMAP_PRESENT(ent[0]) && PAGEMAP_PRESENT(ent[1]) &&
+	    PAGEMAP_PFN(ent[0]) + 1 == PAGEMAP_PFN(ent[1]) &&
+	    !(PAGEMAP_PFN(ent[0]) & ((1 << (HPAGE_SHIFT - PAGE_SHIFT)) - 1)))
+		return PAGEMAP_PFN(ent[0]);
+
+	return -1;
+}
+
+static int ksm_merge_hugepages_time(int mapping, int prot, int timeout, size_t map_size)
+{
+	void *map_ptr, *map_ptr_orig;
+	struct timespec start_time, end_time;
+	unsigned long scan_time_ns;
+	int pagemap_fd, n_normal_pages, n_huge_pages;
+
+	map_size *= MB;
+	size_t len = map_size;
+
+	len -= len % HPAGE_SIZE;
+	map_ptr_orig = mmap(NULL, len + HPAGE_SIZE, PROT_READ | PROT_WRITE,
+			MAP_ANONYMOUS | MAP_NORESERVE | MAP_PRIVATE, -1, 0);
+	map_ptr = map_ptr_orig + HPAGE_SIZE - (uintptr_t)map_ptr_orig % HPAGE_SIZE;
+
+	if (map_ptr_orig == MAP_FAILED)
+		err(2, "initial mmap");
+
+	if (madvise(map_ptr, len + HPAGE_SIZE, MADV_HUGEPAGE))
+		err(2, "MADV_HUGEPAGE");
+
+	pagemap_fd = open("/proc/self/pagemap", O_RDONLY);
+	if (pagemap_fd < 0)
+		err(2, "open pagemap");
+
+	n_normal_pages = 0;
+	n_huge_pages = 0;
+	for (void *p = map_ptr; p < map_ptr + len; p += HPAGE_SIZE) {
+		if (allocate_transhuge(p, pagemap_fd) < 0)
+			n_normal_pages++;
+		else
+			n_huge_pages++;
+	}
+	printf("Number of normal pages:    %d\n", n_normal_pages);
+	printf("Number of huge pages:    %d\n", n_huge_pages);
+
+	memset(map_ptr, '*', len);
+
+	if (clock_gettime(CLOCK_MONOTONIC_RAW, &start_time)) {
+		perror("clock_gettime");
+		goto err_out;
+	}
+	if (ksm_merge_pages(map_ptr, map_size, start_time, timeout))
+		goto err_out;
+	if (clock_gettime(CLOCK_MONOTONIC_RAW, &end_time)) {
+		perror("clock_gettime");
+		goto err_out;
+	}
+
+	scan_time_ns = (end_time.tv_sec - start_time.tv_sec) * NSEC_PER_SEC +
+		       (end_time.tv_nsec - start_time.tv_nsec);
+
+	printf("Total size:    %lu MiB\n", map_size / MB);
+	printf("Total time:    %ld.%09ld s\n", scan_time_ns / NSEC_PER_SEC,
+	       scan_time_ns % NSEC_PER_SEC);
+	printf("Average speed:  %.3f MiB/s\n", (map_size / MB) /
+					       ((double)scan_time_ns / NSEC_PER_SEC));
+
+	munmap(map_ptr_orig, len + HPAGE_SIZE);
+	return KSFT_PASS;
+
+err_out:
+	printf("Not OK\n");
+	munmap(map_ptr_orig, len + HPAGE_SIZE);
+	return KSFT_FAIL;
+}
+
 static int ksm_merge_time(int mapping, int prot, int timeout, size_t map_size)
 {
 	void *map_ptr;
@@ -541,7 +653,7 @@ int main(int argc, char *argv[])
 	bool merge_across_nodes = KSM_MERGE_ACROSS_NODES_DEFAULT;
 	long size_MB = 0;
 
-	while ((opt = getopt(argc, argv, "ha:p:l:z:m:s:MUZNPC")) != -1) {
+	while ((opt = getopt(argc, argv, "ha:p:l:z:m:s:MUZNPCH")) != -1) {
 		switch (opt) {
 		case 'a':
 			prot = str_to_prot(optarg);
@@ -595,6 +707,9 @@ int main(int argc, char *argv[])
 		case 'P':
 			test_name = KSM_MERGE_TIME;
 			break;
+		case 'H':
+			test_name = KSM_MERGE_TIME_HUGE_PAGES;
+			break;
 		case 'C':
 			test_name = KSM_COW_TIME;
 			break;
@@ -647,6 +762,14 @@ int main(int argc, char *argv[])
 		ret = ksm_merge_time(MAP_PRIVATE | MAP_ANONYMOUS, prot, ksm_scan_limit_sec,
 				     size_MB);
 		break;
+	case KSM_MERGE_TIME_HUGE_PAGES:
+		if (size_MB == 0) {
+			printf("Option '-s' is required.\n");
+			return KSFT_FAIL;
+		}
+		ret = ksm_merge_hugepages_time(MAP_PRIVATE | MAP_ANONYMOUS, prot,
+				ksm_scan_limit_sec, size_MB);
+		break;
 	case KSM_COW_TIME:
 		ret = ksm_cow_time(MAP_PRIVATE | MAP_ANONYMOUS, prot, ksm_scan_limit_sec,
 				   page_size);
-- 
2.25.1

