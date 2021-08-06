Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 971F63E2843
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Aug 2021 12:10:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244910AbhHFKKt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 6 Aug 2021 06:10:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244835AbhHFKKt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 6 Aug 2021 06:10:49 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61ECFC061799;
        Fri,  6 Aug 2021 03:10:33 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id a7so11139292ljq.11;
        Fri, 06 Aug 2021 03:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=SCxFMnZwMl/hnAw5357TmhkchjWwOjDXP6E7akpeJaU=;
        b=JW+S8jkp90D79ime8BOze364u+TTcK/Bhc573VIfM1CHw4lDGU2KGTwQk0Wx0SnMKa
         QJvbochYB/8haG30KLXLgRmIwOu56iktjoM1CSFhq7cZMYRWE2b07mJnQVWFGRMhOxvX
         T/SMU6kijAkwXfp1KYJUtDozqqMfp92dypgQQUEMUw/EPovitIb1Ii5tVn31pqhsMsmc
         3xXi2DfN47njb6YtuSQeECgUQY1JuddwewMZM/pcvjkTPO9O06nzg9MQI4C80JsbZ/+T
         TsnuZ5r9WUIcw8VglDDNTa3BlGOA0hN5yQtJtke6NwInNeoW308gIYTj+sAXOxwJsL+h
         QgNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SCxFMnZwMl/hnAw5357TmhkchjWwOjDXP6E7akpeJaU=;
        b=EwXOJMqLY7DDnakSuWAzA0apPS9Z7SqalxWql9oGNGJIvtR+8RP2jdygWFdtFeQhFp
         9QmEIEYHvgZeeyw8xBt6CobM6x6w6B+z2cKO1npJuMZ48wChpXb7MdclN3Gqk06IgVFL
         4JrwMWYbbb+1OUNdbaph0LapyI5k43lSN6tv1F+bK992S7vTsWpxkcmoA1IFjs9DkFmi
         LqG4JEi3ER8d+AJmZNreC2QHhD2oCdC2rAAwc04OGaQIp2Q87+f5Q0+V/Rb9fPUFeL1d
         S4nXirXn5J1wJHRNIsN6lMejCWWaK3QzBHH+GpzYWVMApUNg1ITyReku8MtKmT8imp3y
         wKlQ==
X-Gm-Message-State: AOAM530LqWwlDL/xiUh2YQp+VvgnDvCsEFfqVd80KoyP8K8nSk9ZymK+
        v6JDiRwp4T8S6ZhqcQkahHBAmMDJkqNGYz7g
X-Google-Smtp-Source: ABdhPJys68dLSztEM87dvpX8R55RHw2V+QX3cj8FJqGfqQTsryUaW89zScH0ty+Z7CNwcukxfVyNbg==
X-Received: by 2002:a2e:8403:: with SMTP id z3mr6324943ljg.298.1628244631670;
        Fri, 06 Aug 2021 03:10:31 -0700 (PDT)
Received: from asus ([93.95.240.58])
        by smtp.gmail.com with ESMTPSA id x36sm784823lfu.252.2021.08.06.03.10.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Aug 2021 03:10:31 -0700 (PDT)
Date:   Fri, 6 Aug 2021 16:10:27 +0600
From:   Zhansaya Bagdauletkyzy <zhansayabagdaulet@gmail.com>
To:     akpm@linux-foundation.org, shuah@kernel.org
Cc:     linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, tyhicks@linux.microsoft.com,
        pasha.tatashin@soleen.com
Subject: [PATCH v2 1/2] selftests: vm: add KSM merging time test
Message-ID: <318b946ac80cc9205c89d0962048378f7ce0705b.1628199399.git.zhansayabagdaulet@gmail.com>
References: <cover.1628199399.git.zhansayabagdaulet@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1628199399.git.zhansayabagdaulet@gmail.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add ksm_merge_time() function to determine speed and time needed for
merging. The total spent time is shown in seconds while speed is
in MiB/s. User must specify the size of duplicated memory area (in MiB)
before running the test.

The test is run as follows: ./ksm_tests -P -s 100
The output:
	Total size:    100 MiB
	Total time:    0.201106786 s
	Average speed:  497.248 MiB/s

Signed-off-by: Zhansaya Bagdauletkyzy <zhansayabagdaulet@gmail.com>
---
v1 -> v2:
 As suggested by Pavel,
 - replace MB with MiB
 - measure speed more accurately

Pavel's review comments:
https://lore.kernel.org/lkml/CA+CK2bBpzdWMYoJdR2EQNNCrRn+Pg1Gs2oBqLR65JW3UUnWt0w@mail.gmail.com/

 tools/testing/selftests/vm/ksm_tests.c | 74 ++++++++++++++++++++++++--
 1 file changed, 70 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/vm/ksm_tests.c b/tools/testing/selftests/vm/ksm_tests.c
index cdeb4a028538..432dfe615e50 100644
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
+#define MB (1ul << 20)
 
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
+	       "    For this test, the size of duplicated memory area (in MiB)\n"
+	       "    must be provided using -s option\n\n");
 
 	printf(" -a: specify the access protections of pages.\n"
 	       "     <prot> must be of the form [rwx].\n"
@@ -105,6 +111,7 @@ static void print_help(void)
 	       "     Default: %d\n", KSM_USE_ZERO_PAGES_DEFAULT);
 	printf(" -m: change merge_across_nodes tunable\n"
 	       "     Default: %d\n", KSM_MERGE_ACROSS_NODES_DEFAULT);
+	printf(" -s: the size of duplicated memory area (in MiB)\n");
 
 	exit(0);
 }
@@ -407,6 +414,47 @@ static int check_ksm_numa_merge(int mapping, int prot, int timeout, bool merge_a
 	return KSFT_FAIL;
 }
 
+static int ksm_merge_time(int mapping, int prot, int timeout, size_t map_size)
+{
+	void *map_ptr;
+	struct timespec start_time, end_time;
+	unsigned long scan_time_ns;
+
+	map_size *= MB;
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
+
+	printf("Total size:    %lu MiB\n", map_size / MB);
+	printf("Total time:    %ld.%09ld s\n", scan_time_ns / NSEC_PER_SEC,
+	       scan_time_ns % NSEC_PER_SEC);
+	printf("Average speed:  %.3f MiB/s\n", (map_size / MB) /
+					       ((double)scan_time_ns / NSEC_PER_SEC));
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
@@ -418,8 +466,9 @@ int main(int argc, char *argv[])
 	int test_name = CHECK_KSM_MERGE;
 	bool use_zero_pages = KSM_USE_ZERO_PAGES_DEFAULT;
 	bool merge_across_nodes = KSM_MERGE_ACROSS_NODES_DEFAULT;
+	long size_MB = 0;
 
-	while ((opt = getopt(argc, argv, "ha:p:l:z:m:MUZN")) != -1) {
+	while ((opt = getopt(argc, argv, "ha:p:l:z:m:s:MUZNP")) != -1) {
 		switch (opt) {
 		case 'a':
 			prot = str_to_prot(optarg);
@@ -453,6 +502,12 @@ int main(int argc, char *argv[])
 			else
 				merge_across_nodes = 1;
 			break;
+		case 's':
+			size_MB = atol(optarg);
+			if (size_MB <= 0) {
+				printf("Size must be greater than 0\n");
+				return KSFT_FAIL;
+			}
 		case 'M':
 			break;
 		case 'U':
@@ -464,6 +519,9 @@ int main(int argc, char *argv[])
 		case 'N':
 			test_name = CHECK_KSM_NUMA_MERGE;
 			break;
+		case 'P':
+			test_name = KSM_MERGE_TIME;
+			break;
 		default:
 			return KSFT_FAIL;
 		}
@@ -505,6 +563,14 @@ int main(int argc, char *argv[])
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

