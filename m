Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 313F342868E
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Oct 2021 08:00:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232721AbhJKGCE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 11 Oct 2021 02:02:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230331AbhJKGCE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 11 Oct 2021 02:02:04 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFA49C061570;
        Sun, 10 Oct 2021 23:00:04 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id z24so10746143qtv.9;
        Sun, 10 Oct 2021 23:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WoA8bZFOoi5k0ksDOVTydnodVp4tRnovR57bU3Fctow=;
        b=ny0irP5Job3x3J3dTem+vxlidF9XApi6fGc3D9UiqD4GapubfhWJwMpAWdapr+cJzd
         3TkuF+DbeeMUl/ASD0GrS0XkO+GAPFT+evHaucySUYuRuCRRVf4CTeepqR8bNmRO9q/m
         +kt/c5AU0+AFKhfctlIWJcH5TNBDurJrKkwLj4Ac5tfyKaK3aQqlxctB4CeFjx8194xZ
         xqeN7fHm1F9B3o0Ft43oc+PioR+h0VHJRXGjvHWltyYIIU1YdSm53NF7i/SsdoSwf7iu
         lZ/ynrYcA9BcpUU/hfqnNLkEa1epgPpFsSXWqcyzh8p5UQrNRWJd9LyufnnQWvplWYpT
         jerA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WoA8bZFOoi5k0ksDOVTydnodVp4tRnovR57bU3Fctow=;
        b=rFUUTex+RLiO/dzeIwF1kVChIir+ZQujmHzpJGvlZk7S9GU+sMFWuDKpLKtUTcerDv
         /FJCles8qI0Wz286olZR40nTKKvZmNmhd4jnQY2WcacMH5/iGBkY4kEE97c8J1rQYCs5
         VqNaZm4yhOzAGBy3UoOZsAugWdjmxcGn9FaKabbLj3ONjHsFws+WwT5Fx5VcTMAFpzQ7
         0W1OWjU866xZM6dtmWwrjaQpvp22K3cL7X+Ey0zaAEG+ShBmxmGvsgre3gytZSNjScIC
         EmuKHJA+bbGaO5OwzXGfBWF/lIG2ZoyMI9ADcnoTjhRCai3ljchlasW/eTM+9asJtzX6
         qNig==
X-Gm-Message-State: AOAM530uVT1QqRszEBpsI2eJqzvqZ37Y7O5eTGXr+/0XKRGrwZujomeq
        V3zmuwvMs9LVlVnYMrc2hp4=
X-Google-Smtp-Source: ABdhPJwrbFpAKDejQajrgzW1vXybkghMf9Qw/qum5gxje2JX1KT6rZXx4y8RcyF+pJhrVXbFzq/LTg==
X-Received: by 2002:ac8:12:: with SMTP id a18mr12673644qtg.157.1633932003742;
        Sun, 10 Oct 2021 23:00:03 -0700 (PDT)
Received: from localhost.localdomain ([179.223.196.141])
        by smtp.gmail.com with ESMTPSA id z30sm4151653qtm.55.2021.10.10.23.00.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Oct 2021 23:00:03 -0700 (PDT)
From:   Pedro Demarchi Gomes <pedrodemargomes@gmail.com>
Cc:     pedrodemargomes@gmail.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] selftests: vm: add KSM huge pages merging time test
Date:   Mon, 11 Oct 2021 02:59:07 -0300
Message-Id: <20211011055908.87140-1-pedrodemargomes@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Signed-off-by: Pedro Demarchi Gomes <pedrodemargomes@gmail.com>
---
 tools/testing/selftests/vm/ksm_tests.c | 40 +++++++++++++++++++-------
 1 file changed, 30 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/vm/ksm_tests.c b/tools/testing/selftests/vm/ksm_tests.c
index b61dcdb44c5b..92b716565d9c 100644
--- a/tools/testing/selftests/vm/ksm_tests.c
+++ b/tools/testing/selftests/vm/ksm_tests.c
@@ -5,6 +5,7 @@
 #include <time.h>
 #include <string.h>
 #include <numa.h>
+#include <err.h>
 
 #include "../kselftest.h"
 #include "../../../../include/vdso/time64.h"
@@ -34,7 +35,8 @@ enum ksm_test_name {
 	CHECK_KSM_ZERO_PAGE_MERGE,
 	CHECK_KSM_NUMA_MERGE,
 	KSM_MERGE_TIME,
-	KSM_COW_TIME
+	KSM_COW_TIME,
+	KSM_MERGE_TIME_HUGE_PAGES
 };
 
 static int ksm_write_sysfs(const char *file_path, unsigned long val)
@@ -99,6 +101,9 @@ static void print_help(void)
 	       " -U (page unmerging)\n"
 	       " -P evaluate merging time and speed.\n"
 	       "    For this test, the size of duplicated memory area (in MiB)\n"
+	       "    must be provided using -s option\n"
+		   " -H evaluate merging time and speed of huge pages.\n"
+	       "    For this test, the size of duplicated memory area (in MiB)\n"
 	       "    must be provided using -s option\n"
 	       " -C evaluate the time required to break COW of merged pages.\n\n");
 
@@ -118,10 +123,14 @@ static void print_help(void)
 	exit(0);
 }
 
-static void  *allocate_memory(void *ptr, int prot, int mapping, char data, size_t map_size)
+static void  *allocate_memory(void *ptr, int prot, int mapping, char data, size_t map_size,
+				 bool huge_page)
 {
 	void *map_ptr = mmap(ptr, map_size, PROT_WRITE, mapping, -1, 0);
 
+	if (huge_page && madvise(map_ptr, map_size, MADV_HUGEPAGE))
+		err(2, "MADV_HUGEPAGE");
+
 	if (!map_ptr) {
 		perror("mmap");
 		return NULL;
@@ -250,7 +259,7 @@ static int check_ksm_merge(int mapping, int prot, long page_count, int timeout,
 	}
 
 	/* fill pages with the same data and merge them */
-	map_ptr = allocate_memory(NULL, prot, mapping, '*', page_size * page_count);
+	map_ptr = allocate_memory(NULL, prot, mapping, '*', page_size * page_count, false);
 	if (!map_ptr)
 		return KSFT_FAIL;
 
@@ -282,7 +291,7 @@ static int check_ksm_unmerge(int mapping, int prot, int timeout, size_t page_siz
 	}
 
 	/* fill pages with the same data and merge them */
-	map_ptr = allocate_memory(NULL, prot, mapping, '*', page_size * page_count);
+	map_ptr = allocate_memory(NULL, prot, mapping, '*', page_size * page_count, false);
 	if (!map_ptr)
 		return KSFT_FAIL;
 
@@ -325,7 +334,7 @@ static int check_ksm_zero_page_merge(int mapping, int prot, long page_count, int
 		return KSFT_FAIL;
 
 	/* fill pages with zero and try to merge them */
-	map_ptr = allocate_memory(NULL, prot, mapping, 0, page_size * page_count);
+	map_ptr = allocate_memory(NULL, prot, mapping, 0, page_size * page_count, false);
 	if (!map_ptr)
 		return KSFT_FAIL;
 
@@ -416,7 +425,7 @@ static int check_ksm_numa_merge(int mapping, int prot, int timeout, bool merge_a
 	return KSFT_FAIL;
 }
 
-static int ksm_merge_time(int mapping, int prot, int timeout, size_t map_size)
+static int ksm_merge_time(int mapping, int prot, int timeout, size_t map_size, bool huge_page)
 {
 	void *map_ptr;
 	struct timespec start_time, end_time;
@@ -424,7 +433,7 @@ static int ksm_merge_time(int mapping, int prot, int timeout, size_t map_size)
 
 	map_size *= MB;
 
-	map_ptr = allocate_memory(NULL, prot, mapping, '*', map_size);
+	map_ptr = allocate_memory(NULL, prot, mapping, '*', map_size, huge_page);
 	if (!map_ptr)
 		return KSFT_FAIL;
 
@@ -466,7 +475,7 @@ static int ksm_cow_time(int mapping, int prot, int timeout, size_t page_size)
 	/* page_count must be less than 2*page_size */
 	size_t page_count = 4000;
 
-	map_ptr = allocate_memory(NULL, prot, mapping, '*', page_size * page_count);
+	map_ptr = allocate_memory(NULL, prot, mapping, '*', page_size * page_count, false);
 	if (!map_ptr)
 		return KSFT_FAIL;
 
@@ -541,7 +550,7 @@ int main(int argc, char *argv[])
 	bool merge_across_nodes = KSM_MERGE_ACROSS_NODES_DEFAULT;
 	long size_MB = 0;
 
-	while ((opt = getopt(argc, argv, "ha:p:l:z:m:s:MUZNPC")) != -1) {
+	while ((opt = getopt(argc, argv, "ha:p:l:z:m:s:MUZNPCH")) != -1) {
 		switch (opt) {
 		case 'a':
 			prot = str_to_prot(optarg);
@@ -598,6 +607,9 @@ int main(int argc, char *argv[])
 		case 'C':
 			test_name = KSM_COW_TIME;
 			break;
+		case 'H':
+			test_name = KSM_MERGE_TIME_HUGE_PAGES;
+			break;
 		default:
 			return KSFT_FAIL;
 		}
@@ -645,12 +657,20 @@ int main(int argc, char *argv[])
 			return KSFT_FAIL;
 		}
 		ret = ksm_merge_time(MAP_PRIVATE | MAP_ANONYMOUS, prot, ksm_scan_limit_sec,
-				     size_MB);
+				     size_MB, false);
 		break;
 	case KSM_COW_TIME:
 		ret = ksm_cow_time(MAP_PRIVATE | MAP_ANONYMOUS, prot, ksm_scan_limit_sec,
 				   page_size);
 		break;
+	case KSM_MERGE_TIME_HUGE_PAGES:
+		if (size_MB == 0) {
+			printf("Option '-s' is required.\n");
+			return KSFT_FAIL;
+		}
+		ret = ksm_merge_time(MAP_PRIVATE | MAP_ANONYMOUS, prot, ksm_scan_limit_sec,
+				     size_MB, true);
+		break;
 	}
 
 	if (ksm_restore(&ksm_sysfs_old)) {
-- 
2.25.1

