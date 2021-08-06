Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 149363E2845
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Aug 2021 12:10:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244979AbhHFKKv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 6 Aug 2021 06:10:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244967AbhHFKKv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 6 Aug 2021 06:10:51 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2732EC061798;
        Fri,  6 Aug 2021 03:10:34 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id f42so16856326lfv.7;
        Fri, 06 Aug 2021 03:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HnfS0EFu41KUqb/e35b0BGkPp9x42cHb4tAFROay0sY=;
        b=kvBZrG931kRyPGJtBdbYGsoH2lI8OASP95q+EnsTzdRTF94a9lmuMkfPnaqm36j393
         AUVAtvNd4rXD6qckPCqsjGOm9dMuaiRzTlA4vYAY60WBzLt9Bp1csPakbqPbgxFWlaHa
         GdzHKB8+uY1509opR5wHeHmhFIn1P0G/VNkh69mPX0K1OhX4oHVZMAKwHgmSUscxikpS
         SUmhWi82Je+Y40sAZPdB3qgeACRxBwWbMzXDfAvI4+OJ1HJHpMAeGyNcRJtbLS4Ofrzm
         +VOwjBhQ64xwBphMHvqDp2NNY4pltDUVKrvgGKZfU9+x1KQd3gRykQEvPPBQ/BzAPtO/
         pwVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HnfS0EFu41KUqb/e35b0BGkPp9x42cHb4tAFROay0sY=;
        b=SAw42q9kTYOh/g8PRzogrQAytsFCX4ejidRKA/jiVr8e5+W3+7xk8YTwKAHFCEo3a2
         GhMbvM/rzpsX+97MyowHTzMjew1cniS4VRIaS2AgItbmLY2WljKRLy35TGwBddtWFpZj
         QTAf1vItQF2+CNr7nBTR3t2lLsLsjNvP0BgJkV/fXsI2XPNKyvb4TE2QAZZVZCFYstC7
         EU5JLJC3neLlTQW+Ao1K8bPPhqw0nRUgAKZAvrtxkGcxE2cAbxFbHV3ieAVWUlEX64T3
         6WLCqsqdUraQG+vgMIMaHJUbbc6S29Tni7wVCm3N1kUeq4qTv0rrAtSjTKka/JqD5l1U
         sZyg==
X-Gm-Message-State: AOAM533O8hfBoIkNcwfSYqehDjg4Blee8S4iVQAwXe/LzkgyKkfuAKXx
        7+WRCzySeo1TnmZIRLOs+cg=
X-Google-Smtp-Source: ABdhPJyZrtmh4iYhArR/+97ljQO3eDdU9VrbtxKymqTdtkCVunDeJgvScntoreBPzxTVAH0OnB6WvA==
X-Received: by 2002:a19:6b06:: with SMTP id d6mr7058671lfa.183.1628244632527;
        Fri, 06 Aug 2021 03:10:32 -0700 (PDT)
Received: from asus ([93.95.240.58])
        by smtp.gmail.com with ESMTPSA id y10sm860889lfh.40.2021.08.06.03.10.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Aug 2021 03:10:32 -0700 (PDT)
Date:   Fri, 6 Aug 2021 16:10:29 +0600
From:   Zhansaya Bagdauletkyzy <zhansayabagdaulet@gmail.com>
To:     akpm@linux-foundation.org, shuah@kernel.org
Cc:     linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, tyhicks@linux.microsoft.com,
        pasha.tatashin@soleen.com
Subject: [PATCH v2 2/2] selftests: vm: add COW time test for KSM pages
Message-ID: <eb4d348a90329b20d9659b86a501c9625efe4fab.1628199399.git.zhansayabagdaulet@gmail.com>
References: <cover.1628199399.git.zhansayabagdaulet@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1628199399.git.zhansayabagdaulet@gmail.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Since merged pages are copied every time they need to be modified,
the write access time is different between shared and non-shared pages.
Add ksm_cow_time() function which evaluates latency of these COW
breaks. First, 4000 pages are allocated and the time, required to modify
1 byte in every other page, is measured. After this, the pages are
merged into 2000 pairs and in each pair, 1 page is modified (i.e. they
are decoupled) to detect COW breaks. The time needed to break COW of
merged pages is then compared with performance of non-shared pages.

The test is run as follows: ./ksm_tests -C
The output:
        Total size:    15 MiB

        Not merged pages:
        Total time:     0.001903112 s
        Average speed:  3678.186 MiB/s

        Merged pages:
        Total time:     0.006215680 s
        Average speed:  1126.184 MiB/s

Signed-off-by: Zhansaya Bagdauletkyzy <zhansayabagdaulet@gmail.com>
---
v1 -> v2:
 As suggested by Pavel,
 - add baseline figures with non-shared pages
 - instead of having all pages merged together, create pairs of
   duplicated pages

Pavel's review comments:
https://lore.kernel.org/lkml/CA+CK2bDYZBBaU3pC369o01tCgydaJ6y91GZ0_MWONMMCajZOUw@mail.gmail.com/

 tools/testing/selftests/vm/ksm_tests.c | 84 +++++++++++++++++++++++++-
 1 file changed, 81 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/vm/ksm_tests.c b/tools/testing/selftests/vm/ksm_tests.c
index 432dfe615e50..382ee6ccd13a 100644
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
@@ -98,7 +99,8 @@ static void print_help(void)
 	       " -U (page unmerging)\n"
 	       " -P evaluate merging time and speed.\n"
 	       "    For this test, the size of duplicated memory area (in MiB)\n"
-	       "    must be provided using -s option\n\n");
+	       "    must be provided using -s option\n"
+	       " -C evaluate the time required to break COW of merged pages.\n\n");
 
 	printf(" -a: specify the access protections of pages.\n"
 	       "     <prot> must be of the form [rwx].\n"
@@ -455,6 +457,75 @@ static int ksm_merge_time(int mapping, int prot, int timeout, size_t map_size)
 	return KSFT_FAIL;
 }
 
+static int ksm_cow_time(int mapping, int prot, int timeout, size_t page_size)
+{
+	void *map_ptr;
+	struct timespec start_time, end_time;
+	unsigned long cow_time_ns;
+	int page_count = 4000;
+
+	map_ptr = allocate_memory(NULL, prot, mapping, '*', page_size * page_count);
+	if (!map_ptr)
+		return KSFT_FAIL;
+
+	if (clock_gettime(CLOCK_MONOTONIC_RAW, &start_time)) {
+		perror("clock_gettime");
+		return KSFT_FAIL;
+	}
+	for (size_t i = 0; i < page_count; i = i + 2)
+		memset(map_ptr + page_size * i, '-', 1);
+	if (clock_gettime(CLOCK_MONOTONIC_RAW, &end_time)) {
+		perror("clock_gettime");
+		return KSFT_FAIL;
+	}
+
+	cow_time_ns = (end_time.tv_sec - start_time.tv_sec) * NSEC_PER_SEC +
+		       (end_time.tv_nsec - start_time.tv_nsec);
+
+	printf("Total size:    %lu MiB\n\n", (page_size * page_count) / MB);
+	printf("Not merged pages:\n");
+	printf("Total time:     %ld.%09ld s\n", cow_time_ns / NSEC_PER_SEC,
+	       cow_time_ns % NSEC_PER_SEC);
+	printf("Average speed:  %.3f MiB/s\n\n", ((page_size * (page_count / 2)) / MB) /
+					       ((double)cow_time_ns / NSEC_PER_SEC));
+
+	/* Create 2000 pairs of duplicated pages */
+	for (size_t i = 0; i < page_count; i = i + 2) {
+		memset(map_ptr + page_size * i, '+', i + 1);
+		memset(map_ptr + page_size * (i + 1), '+', i + 1);
+	}
+	if (ksm_merge_pages(map_ptr, page_size * page_count, start_time, timeout))
+		goto err_out;
+
+	if (clock_gettime(CLOCK_MONOTONIC_RAW, &start_time)) {
+		perror("clock_gettime");
+		goto err_out;
+	}
+	for (size_t i = 0; i < page_count; i = i + 2)
+		memset(map_ptr + page_size * i, '-', 1);
+	if (clock_gettime(CLOCK_MONOTONIC_RAW, &end_time)) {
+		perror("clock_gettime");
+		goto err_out;
+	}
+
+	cow_time_ns = (end_time.tv_sec - start_time.tv_sec) * NSEC_PER_SEC +
+		       (end_time.tv_nsec - start_time.tv_nsec);
+
+	printf("Merged pages:\n");
+	printf("Total time:     %ld.%09ld s\n", cow_time_ns / NSEC_PER_SEC,
+	       cow_time_ns % NSEC_PER_SEC);
+	printf("Average speed:  %.3f MiB/s\n", ((page_size * (page_count / 2)) / MB) /
+					       ((double)cow_time_ns / NSEC_PER_SEC));
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
@@ -468,7 +539,7 @@ int main(int argc, char *argv[])
 	bool merge_across_nodes = KSM_MERGE_ACROSS_NODES_DEFAULT;
 	long size_MB = 0;
 
-	while ((opt = getopt(argc, argv, "ha:p:l:z:m:s:MUZNP")) != -1) {
+	while ((opt = getopt(argc, argv, "ha:p:l:z:m:s:MUZNPC")) != -1) {
 		switch (opt) {
 		case 'a':
 			prot = str_to_prot(optarg);
@@ -522,6 +593,9 @@ int main(int argc, char *argv[])
 		case 'P':
 			test_name = KSM_MERGE_TIME;
 			break;
+		case 'C':
+			test_name = KSM_COW_TIME;
+			break;
 		default:
 			return KSFT_FAIL;
 		}
@@ -571,6 +645,10 @@ int main(int argc, char *argv[])
 		ret = ksm_merge_time(MAP_PRIVATE | MAP_ANONYMOUS, prot, ksm_scan_limit_sec,
 				     size_MB);
 		break;
+	case KSM_COW_TIME:
+		ret = ksm_cow_time(MAP_PRIVATE | MAP_ANONYMOUS, prot, ksm_scan_limit_sec,
+				   page_size);
+		break;
 	}
 
 	if (ksm_restore(&ksm_sysfs_old)) {
-- 
2.25.1

