Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 671F03DCC7E
	for <lists+linux-kselftest@lfdr.de>; Sun,  1 Aug 2021 17:44:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232152AbhHAPoJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 1 Aug 2021 11:44:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232095AbhHAPoI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 1 Aug 2021 11:44:08 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A247DC06175F;
        Sun,  1 Aug 2021 08:43:59 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id q2so20642244ljq.5;
        Sun, 01 Aug 2021 08:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YEjBF3EFihUm9hC1OBOnczDySCO1R9ENPttMMc1lNxs=;
        b=d/JciGk5DyQlK9x7u8W7Nnmqf1iHCu3fmhSnKn2EbmYiCzJ3T0c/snLSIjaPqvCkfd
         NXHKpRZHA7qSPEZfUT/eFfKMhDWEP+/9lhpIRecfS7mPO5Qm4KM8qDVnMRVMrUNBV6oA
         nluqUkJGRhK+7tV9a0jC8euWvj9bpiQk5Kq0zsoRBTyJ56R2xjJXzCsOSGwZIQ38oCZP
         E+7j92p1b6DXI9Z9PgBGsrZcgwDJPsWl+XCURS535utV/QtThMlG8nZw3mED3BtrTSaI
         g0itDQpu0IGBrwOMzTEjy80JjHhG2EWJsLCvZfxWFexhBrYyjTGxeEisjvyrVFqB4bb3
         eKTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YEjBF3EFihUm9hC1OBOnczDySCO1R9ENPttMMc1lNxs=;
        b=SAjhBx29Wc7vMmZiRj6H7ketD/CWEvJYrSw+0SNoqBRVMa4PDpsszk+iOIBOolavhO
         etUEQn0EBpYpkxfdZfqhqaABOjNdCTET6SgDqLUJe9jf9Qos1F2W7pu71t0bv0UJ/JGC
         g7E9RE0ixAVIifltxGwFt5aCvceP7LRvxrTMSsxutPbPsFvN4qfK4dziHBhXikMSaRsr
         /vm9Od6NPm9YBHkmmp7LBy2x1BrUgBL9TTf7HcGQt0qlzUnR8pS65vOvK4N4RNIuot5o
         UYuSM/6JHJRYqStrmxRwJ5eraHrobkXuTGLSTv6qAI2HbQoHC0YFfq0zIKEBL7foJvhl
         xjew==
X-Gm-Message-State: AOAM5320QqwnLlG7+vvkqapKXkQ4uCIo+9t3d5q9QmpddWTcFvMlclXq
        qtXGmIVnpdUMXuQbBSL1PbM=
X-Google-Smtp-Source: ABdhPJzFc8TqZENCJ7iHVLn/n13u6Yi3JCp+TDaDFBzQ/pTUU0qJmGuNbRXx8tIJ8TrP7L3TNbr0/g==
X-Received: by 2002:a2e:a591:: with SMTP id m17mr8581400ljp.237.1627832638076;
        Sun, 01 Aug 2021 08:43:58 -0700 (PDT)
Received: from asus ([147.30.82.254])
        by smtp.gmail.com with ESMTPSA id a10sm702601lfb.93.2021.08.01.08.43.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Aug 2021 08:43:57 -0700 (PDT)
Date:   Sun, 1 Aug 2021 21:43:54 +0600
From:   Zhansaya Bagdauletkyzy <zhansayabagdaulet@gmail.com>
To:     akpm@linux-foundation.org, shuah@kernel.org
Cc:     linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, tyhicks@linux.microsoft.com,
        pasha.tatashin@soleen.com
Subject: [PATCH 2/2] selftests: vm: add COW time test for KSM pages
Message-ID: <26a3cc3d02dc4fa65cc9b135be76e7d795c44877.1627828548.git.zhansayabagdaulet@gmail.com>
References: <cover.1627828548.git.zhansayabagdaulet@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1627828548.git.zhansayabagdaulet@gmail.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Since merged pages are copied every time they need to be modified,
the write access time is different between shared and non-shared pages.
Add ksm_cow_time() function which evaluates latency of these COW
breaks. First, duplicated pages are merged and then the time required
to write to each of the pages is detected.

The test is run as follows: ./ksm_tests -C -p 5000
The output:
	Total COW time:      0.012612 s
	The number of pages: 5000
	Average speed:	     1623 MB/s

Signed-off-by: Zhansaya Bagdauletkyzy <zhansayabagdaulet@gmail.com>
---
 tools/testing/selftests/vm/ksm_tests.c | 66 ++++++++++++++++++++++++--
 1 file changed, 63 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/vm/ksm_tests.c b/tools/testing/selftests/vm/ksm_tests.c
index 91c6ff496655..3ffd899b2bd9 100644
--- a/tools/testing/selftests/vm/ksm_tests.c
+++ b/tools/testing/selftests/vm/ksm_tests.c
@@ -33,7 +33,8 @@ enum ksm_test_name {
 	CHECK_KSM_UNMERGE,
 	CHECK_KSM_ZERO_PAGE_MERGE,
 	CHECK_KSM_NUMA_MERGE,
-	KSM_MERGE_TIME
+	KSM_MERGE_TIME,
+	KSM_COW_TIME
 };
 
 static int ksm_write_sysfs(const char *file_path, unsigned long val)
@@ -98,7 +99,9 @@ static void print_help(void)
 	       " -U (page unmerging)\n"
 	       " -P evaluate merging time and speed.\n"
 	       "    For this test, the size of duplicated memory area (in MB)\n"
-	       "    must be provided using -s option\n\n");
+	       "    must be provided using -s option\n"
+	       " -C evaluate the time required to break COW of merged pages.\n"
+	       "    The number of pages can be defined using -p option.\n\n");
 
 	printf(" -a: specify the access protections of pages.\n"
 	       "     <prot> must be of the form [rwx].\n"
@@ -457,6 +460,56 @@ static int ksm_merge_time(int mapping, int prot, int timeout, size_t map_size)
 	return KSFT_FAIL;
 }
 
+static int ksm_cow_time(int mapping, int prot, int timeout, size_t page_size, long page_count)
+{
+	void *map_ptr;
+	struct timespec start_time, end_time;
+	long cow_time_s, cow_time_ns;
+	int avg_speed;
+
+	if (clock_gettime(CLOCK_MONOTONIC_RAW, &start_time)) {
+		perror("clock_gettime");
+		return KSFT_FAIL;
+	}
+
+	map_ptr = allocate_memory(NULL, prot, mapping, '*', page_size * page_count);
+	if (!map_ptr)
+		return KSFT_FAIL;
+
+	if (ksm_merge_pages(map_ptr, page_size * page_count, start_time, timeout))
+		goto err_out;
+
+	if (clock_gettime(CLOCK_MONOTONIC_RAW, &start_time)) {
+		perror("clock_gettime");
+		goto err_out;
+	}
+	for (size_t i = 0; i < page_count; i++)
+		memset(map_ptr + page_size * i, '-', 1);
+	if (clock_gettime(CLOCK_MONOTONIC_RAW, &end_time)) {
+		perror("clock_gettime");
+		goto err_out;
+	}
+
+	cow_time_ns = (end_time.tv_sec - start_time.tv_sec) * NSEC_PER_SEC +
+		       (end_time.tv_nsec - start_time.tv_nsec);
+	cow_time_s = cow_time_ns / NSEC_PER_SEC;
+	cow_time_ns %= NSEC_PER_SEC;
+	avg_speed = (page_size * page_count) / (cow_time_s * USEC_PER_SEC +
+						cow_time_ns / NSEC_PER_USEC);
+
+	printf("Total COW time:      %ld.%06ld s\n", cow_time_s, cow_time_ns / NSEC_PER_USEC);
+	printf("The number of pages: %ld\n", page_count);
+	printf("Average speed:	     %d MB/s\n", avg_speed);
+
+	munmap(map_ptr, page_size * page_count);
+	return KSFT_PASS;
+
+err_out:
+	printf("Not OK\n");
+	munmap(map_ptr, page_size * page_count);
+	return KSFT_FAIL;
+}
+
 int main(int argc, char *argv[])
 {
 	int ret, opt;
@@ -470,7 +523,7 @@ int main(int argc, char *argv[])
 	bool merge_across_nodes = KSM_MERGE_ACROSS_NODES_DEFAULT;
 	long size_MB = 0;
 
-	while ((opt = getopt(argc, argv, "ha:p:l:z:m:s:MUZNP")) != -1) {
+	while ((opt = getopt(argc, argv, "ha:p:l:z:m:s:MUZNPC")) != -1) {
 		switch (opt) {
 		case 'a':
 			prot = str_to_prot(optarg);
@@ -524,6 +577,9 @@ int main(int argc, char *argv[])
 		case 'P':
 			test_name = KSM_MERGE_TIME;
 			break;
+		case 'C':
+			test_name = KSM_COW_TIME;
+			break;
 		default:
 			return KSFT_FAIL;
 		}
@@ -573,6 +629,10 @@ int main(int argc, char *argv[])
 		ret = ksm_merge_time(MAP_PRIVATE | MAP_ANONYMOUS, prot, ksm_scan_limit_sec,
 				     size_MB);
 		break;
+	case KSM_COW_TIME:
+		ret = ksm_cow_time(MAP_PRIVATE | MAP_ANONYMOUS, prot, ksm_scan_limit_sec,
+				   page_size, page_count);
+		break;
 	}
 
 	if (ksm_restore(&ksm_sysfs_old)) {
-- 
2.25.1

