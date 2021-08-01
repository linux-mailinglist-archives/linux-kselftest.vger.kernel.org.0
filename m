Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2D013DCC7C
	for <lists+linux-kselftest@lfdr.de>; Sun,  1 Aug 2021 17:44:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232134AbhHAPoI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 1 Aug 2021 11:44:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232084AbhHAPoI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 1 Aug 2021 11:44:08 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97732C0613D3;
        Sun,  1 Aug 2021 08:43:58 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id h11so20555402ljo.12;
        Sun, 01 Aug 2021 08:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JuOyqtRZoM4TE5Y8hFpkb7Y2rcrXHqYKLju1M9KuoRg=;
        b=eqLeD+MJ7dj/PLhdr3KNx8OplVKL0duHWMcWQSs/Bi2K5Qk+xTNUVatCUxe3QCnj4s
         KNwiAwBM/grfI5+O8rZ+ZWrX7/HfKyC9qfIMVTko1fBCuOD2jBn05AMuziwIHc4Rzn7n
         bh/DvhLDmwmKd6Di25HckbP4wcMpt5aI5BqeGIDRo4+dVI+HUXlHHx2euk19c8xgkyHo
         gCBZmzsbQDM2urpk9UiKFkGicCEIOMQUT3ooh8fQUOJ5a9rVMC0lMxJBNSO1jWO6lzWa
         g/GmJj3YrY/aZgDX2yrXvCpN0pZg2SUyXgQEqGfz2xYKZLDaPIYuOXXTBcwjEeHsm6kp
         TUkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JuOyqtRZoM4TE5Y8hFpkb7Y2rcrXHqYKLju1M9KuoRg=;
        b=koG16XAd6x8eZSsNpNk3JRuyUqpM1Xeuy+n/vhbz9UsfyIs0+OBQBXF27N8TDu2Df9
         2buFZNebN6A/qT0eqfDXL3w7N+FOSddPfEOfmcEUI576rFgp7s+ZQT/STiIazmy8R1en
         E+u7J+DbBY8ic0Ybo1h3sTmNV0UacYmLstiVUKzjt4WFA/YAYVA4ziCFGCnZaDOvp88O
         jb9buEBFK7xWmtGzc9Hgd70JZJWLK0AkMj8kzO7rH4o/UhEk86xb0N8xnsEXqp3NkYMc
         KuzM/AoSIfQE8b7e0aR3fDFmkAIVoSgidygNAf2mubYo+FmzoFjBA4Eky9Mxykkzolnn
         GvBA==
X-Gm-Message-State: AOAM533Fz4PsO7CinjrcWWdPCWpVcL1D9BnBzvOcMW+I0eC/1JpUYUdp
        2WwdecfiAfaRJraOItZ3H/o=
X-Google-Smtp-Source: ABdhPJzMF92HX8j6hQ+wIiv6WNx2sUyE7bw4eVLlHRFdJjRsg0VT3Ja6gxKMTnBxqJGvMoXNyOQy2A==
X-Received: by 2002:a2e:3c0d:: with SMTP id j13mr8524246lja.414.1627832637026;
        Sun, 01 Aug 2021 08:43:57 -0700 (PDT)
Received: from asus ([147.30.82.254])
        by smtp.gmail.com with ESMTPSA id bn41sm632023ljb.6.2021.08.01.08.43.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Aug 2021 08:43:56 -0700 (PDT)
Date:   Sun, 1 Aug 2021 21:43:52 +0600
From:   Zhansaya Bagdauletkyzy <zhansayabagdaulet@gmail.com>
To:     akpm@linux-foundation.org, shuah@kernel.org
Cc:     linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, tyhicks@linux.microsoft.com,
        pasha.tatashin@soleen.com
Subject: [PATCH 1/2] selftests: vm: add KSM merging time test
Message-ID: <5de9beffc409b660229695e0ad921825903156d6.1627828548.git.zhansayabagdaulet@gmail.com>
References: <cover.1627828548.git.zhansayabagdaulet@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1627828548.git.zhansayabagdaulet@gmail.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add ksm_merge_time() function to determine speed and time needed for
merging. The total spent time is shown in seconds while speed is
in MB/s. User must specify the size of duplicated memory area (in MB)
before running the test.

The test is run as follows: ./ksm_tests -P -s 100
The output:
        Total size:    100 MB
        Total time:    0.309561 s
        Average speed: 323 MB/s

Signed-off-by: Zhansaya Bagdauletkyzy <zhansayabagdaulet@gmail.com>
---
 tools/testing/selftests/vm/ksm_tests.c | 76 ++++++++++++++++++++++++--
 1 file changed, 72 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/vm/ksm_tests.c b/tools/testing/selftests/vm/ksm_tests.c
index cdeb4a028538..91c6ff496655 100644
--- a/tools/testing/selftests/vm/ksm_tests.c
+++ b/tools/testing/selftests/vm/ksm_tests.c
@@ -7,6 +7,7 @@
 #include <numa.h>
 
 #include "../kselftest.h"
+#include "../../../../include/vdso/time64.h"
 
 #define KSM_SYSFS_PATH "/sys/kernel/mm/ksm/"
 #define KSM_FP(s) (KSM_SYSFS_PATH s)
@@ -15,6 +16,7 @@
 #define KSM_PROT_STR_DEFAULT "rw"
 #define KSM_USE_ZERO_PAGES_DEFAULT false
 #define KSM_MERGE_ACROSS_NODES_DEFAULT true
+#define MB_TO_B 1000000ul
 
 struct ksm_sysfs {
 	unsigned long max_page_sharing;
@@ -30,7 +32,8 @@ enum ksm_test_name {
 	CHECK_KSM_MERGE,
 	CHECK_KSM_UNMERGE,
 	CHECK_KSM_ZERO_PAGE_MERGE,
-	CHECK_KSM_NUMA_MERGE
+	CHECK_KSM_NUMA_MERGE,
+	KSM_MERGE_TIME
 };
 
 static int ksm_write_sysfs(const char *file_path, unsigned long val)
@@ -86,13 +89,16 @@ static int str_to_prot(char *prot_str)
 static void print_help(void)
 {
 	printf("usage: ksm_tests [-h] <test type> [-a prot] [-p page_count] [-l timeout]\n"
-	       "[-z use_zero_pages] [-m merge_across_nodes]\n");
+	       "[-z use_zero_pages] [-m merge_across_nodes] [-s size]\n");
 
 	printf("Supported <test type>:\n"
 	       " -M (page merging)\n"
 	       " -Z (zero pages merging)\n"
 	       " -N (merging of pages in different NUMA nodes)\n"
-	       " -U (page unmerging)\n\n");
+	       " -U (page unmerging)\n"
+	       " -P evaluate merging time and speed.\n"
+	       "    For this test, the size of duplicated memory area (in MB)\n"
+	       "    must be provided using -s option\n\n");
 
 	printf(" -a: specify the access protections of pages.\n"
 	       "     <prot> must be of the form [rwx].\n"
@@ -105,6 +111,7 @@ static void print_help(void)
 	       "     Default: %d\n", KSM_USE_ZERO_PAGES_DEFAULT);
 	printf(" -m: change merge_across_nodes tunable\n"
 	       "     Default: %d\n", KSM_MERGE_ACROSS_NODES_DEFAULT);
+	printf(" -s: the size of duplicated memory area (in MB)\n");
 
 	exit(0);
 }
@@ -407,6 +414,49 @@ static int check_ksm_numa_merge(int mapping, int prot, int timeout, bool merge_a
 	return KSFT_FAIL;
 }
 
+static int ksm_merge_time(int mapping, int prot, int timeout, size_t map_size)
+{
+	void *map_ptr;
+	struct timespec start_time, end_time;
+	long scan_time_s, scan_time_ns;
+	int avg_speed;
+
+	map_size *= MB_TO_B;
+
+	map_ptr = allocate_memory(NULL, prot, mapping, '*', map_size);
+	if (!map_ptr)
+		return KSFT_FAIL;
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
+	scan_time_s = scan_time_ns / NSEC_PER_SEC;
+	scan_time_ns %= NSEC_PER_SEC;
+	avg_speed = map_size / (scan_time_s * USEC_PER_SEC + scan_time_ns / NSEC_PER_USEC);
+
+	printf("Total size:    %lu MB\n", map_size / MB_TO_B);
+	printf("Total time:    %ld.%06ld s\n", scan_time_s, scan_time_ns / NSEC_PER_USEC);
+	printf("Average speed: %d MB/s\n", avg_speed);
+
+	munmap(map_ptr, map_size);
+	return KSFT_PASS;
+
+err_out:
+	printf("Not OK\n");
+	munmap(map_ptr, map_size);
+	return KSFT_FAIL;
+}
+
 int main(int argc, char *argv[])
 {
 	int ret, opt;
@@ -418,8 +468,9 @@ int main(int argc, char *argv[])
 	int test_name = CHECK_KSM_MERGE;
 	bool use_zero_pages = KSM_USE_ZERO_PAGES_DEFAULT;
 	bool merge_across_nodes = KSM_MERGE_ACROSS_NODES_DEFAULT;
+	long size_MB = 0;
 
-	while ((opt = getopt(argc, argv, "ha:p:l:z:m:MUZN")) != -1) {
+	while ((opt = getopt(argc, argv, "ha:p:l:z:m:s:MUZNP")) != -1) {
 		switch (opt) {
 		case 'a':
 			prot = str_to_prot(optarg);
@@ -453,6 +504,12 @@ int main(int argc, char *argv[])
 			else
 				merge_across_nodes = 1;
 			break;
+		case 's':
+			size_MB = atoi(optarg);
+			if (size_MB <= 0) {
+				printf("Size must be greater than 0\n");
+				return KSFT_FAIL;
+			}
 		case 'M':
 			break;
 		case 'U':
@@ -464,6 +521,9 @@ int main(int argc, char *argv[])
 		case 'N':
 			test_name = CHECK_KSM_NUMA_MERGE;
 			break;
+		case 'P':
+			test_name = KSM_MERGE_TIME;
+			break;
 		default:
 			return KSFT_FAIL;
 		}
@@ -505,6 +565,14 @@ int main(int argc, char *argv[])
 		ret = check_ksm_numa_merge(MAP_PRIVATE | MAP_ANONYMOUS, prot, ksm_scan_limit_sec,
 					   merge_across_nodes, page_size);
 		break;
+	case KSM_MERGE_TIME:
+		if (size_MB == 0) {
+			printf("Option '-s' is required.\n");
+			return KSFT_FAIL;
+		}
+		ret = ksm_merge_time(MAP_PRIVATE | MAP_ANONYMOUS, prot, ksm_scan_limit_sec,
+				     size_MB);
+		break;
 	}
 
 	if (ksm_restore(&ksm_sysfs_old)) {
-- 
2.25.1

