Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6E043B89AC
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Jun 2021 22:22:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234627AbhF3UYp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 30 Jun 2021 16:24:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235141AbhF3UYo (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 30 Jun 2021 16:24:44 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B017C0617A8;
        Wed, 30 Jun 2021 13:22:15 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id n14so7431744lfu.8;
        Wed, 30 Jun 2021 13:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Bafw2Td/NqqAc0fHfkThw0BzlPCmSFgxlKxT67zoUP8=;
        b=de3d/q9MonRWnoi4b8qsmCb1aI6tR2ZDZbQhYxyX3o68Tm/Rb+QOYeQQPskCIulG87
         Md3CZqWowXb5NLzUXsZcjALe6W+to4MDz5RnYYUypt2XPaJIH2ApBb7UQq2XQiQt4sIa
         JyGxtdTxqTyfATbWuMXDNt9VX5gQTtj1QeJjuI1BIetfK5bY6FkUD8dM8xBWQVXood7x
         cZ8aK8AChs+KP6fBd0eYYq/OhB5A14socDNjQWBbnfwGLB7b1Xi+vUUVJhBsF9fyv+7E
         32ZPPUNEYB3jS3R5wKdQMufiyL7NgVULTKDBkaetlQLKgS1cN+5324GnHrc5oEVGOmW3
         T5UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Bafw2Td/NqqAc0fHfkThw0BzlPCmSFgxlKxT67zoUP8=;
        b=Q02KeiYy1gkS0gm6MIOzsFHAqc+MNMm8/2n0TObzGaJvAJzsOAPSLzmhmZDnBPLJtO
         Vr0wDM2OCoZNWibJhoDdLOkXsPAOg7On1oOEmOIB3pe3xv283CA5uIsmiNGYg9QZT8LS
         Dyq3jiqXCmSoU7DwCRF1NXnm+APEW9sk9bwb4zHiz97u6fbnOgXnImSqIqMZaK54w8G8
         X4dZGlZgPzXzK6xGXYf3mHaGPTnwpMcPzs/wdWVxDf0PyvBH/FtTjBK9QnucVlw8yH+v
         1jOHB+a66tQ0615bbp3RKlGzeU5dSJdtsw3eZ3S9CfS4gu3L8L3mjrDj5ietbYFSI12D
         wdfw==
X-Gm-Message-State: AOAM530JrTDDOLznBnNwbHCu3e7mTyBdCyYtn6sGKMWyC3dOj5m3w4pd
        p8sPNmdVVKOhw0ZVlkrMrKnB7PHeeRAYMQ==
X-Google-Smtp-Source: ABdhPJzyqxBcfQ2UANOXmwB6vU7b3w1dayd+KHNBHyCMBsF0SCQo5uBtGyjE1EFtNfkA+MEgvEwRsA==
X-Received: by 2002:a19:ac41:: with SMTP id r1mr2027338lfc.502.1625084533318;
        Wed, 30 Jun 2021 13:22:13 -0700 (PDT)
Received: from asus ([37.151.208.206])
        by smtp.gmail.com with ESMTPSA id m1sm2303312ljb.138.2021.06.30.13.22.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jun 2021 13:22:12 -0700 (PDT)
Date:   Thu, 1 Jul 2021 02:22:10 +0600
From:   Zhansaya Bagdauletkyzy <zhansayabagdaulet@gmail.com>
To:     shuah@kernel.org, akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, tyhicks@linux.microsoft.com,
        pasha.tatashin@soleen.com
Subject: [PATCH 1/1] selftests: vm: add KSM tests
Message-ID: <257653e0e584f6b3c1fefb069792a76fc95a9c29.1625083828.git.zhansayabagdaulet@gmail.com>
References: <cover.1625083828.git.zhansayabagdaulet@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1625083828.git.zhansayabagdaulet@gmail.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Introduce selftests to validate the functionality of KSM. The function
check_ksm_merge() tests the MADV_MERGEABLE advice of madvise syscall.
The test is run on private anonymous pages that have read and write
access. Since some KSM tunables are modified, their starting values are
saved and restored after testing. At the start, run is set to 2 to
ensure that only test pages will be merged (we assume that no
applications make madvise syscalls in the background). If KSM config
not enabled, then the test is skipped.

Signed-off-by: Zhansaya Bagdauletkyzy <zhansayabagdaulet@gmail.com>
---
 tools/testing/selftests/vm/.gitignore     |   1 +
 tools/testing/selftests/vm/Makefile       |   1 +
 tools/testing/selftests/vm/ksm_tests.c    | 289 ++++++++++++++++++++++
 tools/testing/selftests/vm/run_vmtests.sh |  16 ++
 4 files changed, 307 insertions(+)
 create mode 100644 tools/testing/selftests/vm/ksm_tests.c

diff --git a/tools/testing/selftests/vm/.gitignore b/tools/testing/selftests/vm/.gitignore
index 1f651e85ed60..047b27dd7746 100644
--- a/tools/testing/selftests/vm/.gitignore
+++ b/tools/testing/selftests/vm/.gitignore
@@ -23,3 +23,4 @@ write_to_hugetlbfs
 hmm-tests
 local_config.*
 split_huge_page_test
+ksm_tests
diff --git a/tools/testing/selftests/vm/Makefile b/tools/testing/selftests/vm/Makefile
index 73e1cc96d7c2..230d1af82f22 100644
--- a/tools/testing/selftests/vm/Makefile
+++ b/tools/testing/selftests/vm/Makefile
@@ -43,6 +43,7 @@ TEST_GEN_FILES += thuge-gen
 TEST_GEN_FILES += transhuge-stress
 TEST_GEN_FILES += userfaultfd
 TEST_GEN_FILES += split_huge_page_test
+TEST_GEN_FILES += ksm_tests
 
 ifeq ($(MACHINE),x86_64)
 CAN_BUILD_I386 := $(shell ./../x86/check_cc.sh $(CC) ../x86/trivial_32bit_program.c -m32)
diff --git a/tools/testing/selftests/vm/ksm_tests.c b/tools/testing/selftests/vm/ksm_tests.c
new file mode 100644
index 000000000000..f283ba83adf5
--- /dev/null
+++ b/tools/testing/selftests/vm/ksm_tests.c
@@ -0,0 +1,289 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <string.h>
+#include <sys/mman.h>
+#include <stdbool.h>
+#include <time.h>
+
+#include "../kselftest.h"
+
+#define KSM_SYSFS_PATH "/sys/kernel/mm/ksm/"
+#define KSM_SCAN_LIMIT_SEC_DEFAULT 120
+#define KSM_PAGE_COUNT_DEFAULT 10l
+#define KSM_FP(s) (KSM_SYSFS_PATH s)
+#define KSM_PROT_STR_DEFAULT "rw"
+
+struct ksm_sysfs {
+	unsigned long max_page_sharing;
+	unsigned long merge_across_nodes;
+	unsigned long pages_to_scan;
+	unsigned long run;
+	unsigned long sleep_millisecs;
+	unsigned long stable_node_chains_prune_millisecs;
+	unsigned long use_zero_pages;
+};
+
+static int ksm_write_sysfs(const char *file_path, unsigned long val)
+{
+	FILE *f = fopen(file_path, "w");
+
+	if (!f) {
+		fprintf(stderr, "f %s\n", file_path);
+		perror("fopen");
+		return 1;
+	}
+	if (fprintf(f, "%lu", val) < 0) {
+		perror("fprintf");
+		return 1;
+	}
+	fclose(f);
+
+	return 0;
+}
+
+static int ksm_read_sysfs(const char *file_path, unsigned long *val)
+{
+	FILE *f = fopen(file_path, "r");
+
+	if (!f) {
+		fprintf(stderr, "f %s\n", file_path);
+		perror("fopen");
+		return 1;
+	}
+	if (fscanf(f, "%lu", val) != 1) {
+		perror("fscanf");
+		return 1;
+	}
+	fclose(f);
+
+	return 0;
+}
+
+static int str_to_prot(char *prot_str)
+{
+	int prot = 0;
+
+	if ((strchr(prot_str, 'r')) != NULL)
+		prot |= PROT_READ;
+	if ((strchr(prot_str, 'w')) != NULL)
+		prot |= PROT_WRITE;
+	if ((strchr(prot_str, 'x')) != NULL)
+		prot |= PROT_EXEC;
+
+	return prot;
+}
+
+static void print_help(void)
+{
+	printf("usage: ksm_tests [-h] [-a prot] [-p page_count] [-l timeout]\n");
+	printf(" -a: specify the access protections of pages.\n"
+	       "     <prot> must be of the form [rwx].\n"
+	       "     Default: %s\n", KSM_PROT_STR_DEFAULT);
+	printf(" -p: specify the number of pages to test.\n"
+	       "     Default: %ld\n", KSM_PAGE_COUNT_DEFAULT);
+	printf(" -l: limit the maximum running time (in seconds) for a test.\n"
+	       "     Default: %d seconds\n", KSM_SCAN_LIMIT_SEC_DEFAULT);
+
+	exit(0);
+}
+
+static bool assert_ksm_pages_count(long dupl_page_count)
+{
+	unsigned long max_page_sharing, pages_sharing, pages_shared;
+
+	if (ksm_read_sysfs(KSM_FP("pages_shared"), &pages_shared) ||
+	    ksm_read_sysfs(KSM_FP("pages_sharing"), &pages_sharing) ||
+	    ksm_read_sysfs(KSM_FP("max_page_sharing"), &max_page_sharing))
+		return false;
+
+	/*
+	 * Since there must be at least 2 pages for merging and 1 page can be
+	 * shared with the limited amount of pages (max_page_sharing), sometimes
+	 * there are 'leftover' pages that cannot be merged. For example, if there
+	 * are 11 pages with max_page_sharing = 10, then only 10 pages will be
+	 * merged and the 11th page won't be affected. As a result, when the number
+	 * of duplicate pages is divided by max_page_sharing and the remainder is 1,
+	 * pages_shared and pages_sharing values will be equal between dupl_page_count
+	 * and dupl_page_count - 1.
+	 */
+	if (dupl_page_count % max_page_sharing == 1 ||
+	    dupl_page_count % max_page_sharing == 0) {
+		if (pages_shared == dupl_page_count / max_page_sharing &&
+		    pages_sharing == pages_shared * (max_page_sharing - 1))
+			return true;
+		else
+			return false;
+	}
+
+	if (pages_shared == dupl_page_count / max_page_sharing + 1 &&
+	    pages_sharing == dupl_page_count - pages_shared)
+		return true;
+
+	return false;
+}
+
+static int ksm_save_def(struct ksm_sysfs *ksm_sysfs)
+{
+	if (ksm_read_sysfs(KSM_FP("max_page_sharing"), &ksm_sysfs->max_page_sharing) ||
+	    ksm_read_sysfs(KSM_FP("merge_across_nodes"), &ksm_sysfs->merge_across_nodes) ||
+	    ksm_read_sysfs(KSM_FP("sleep_millisecs"), &ksm_sysfs->sleep_millisecs) ||
+	    ksm_read_sysfs(KSM_FP("pages_to_scan"), &ksm_sysfs->pages_to_scan) ||
+	    ksm_read_sysfs(KSM_FP("run"), &ksm_sysfs->run) ||
+	    ksm_read_sysfs(KSM_FP("stable_node_chains_prune_millisecs"),
+			   &ksm_sysfs->stable_node_chains_prune_millisecs) ||
+	    ksm_read_sysfs(KSM_FP("use_zero_pages"), &ksm_sysfs->use_zero_pages))
+		return 1;
+
+	return 0;
+}
+
+static int ksm_restore(struct ksm_sysfs *ksm_sysfs)
+{
+	if (ksm_write_sysfs(KSM_FP("max_page_sharing"), ksm_sysfs->max_page_sharing) ||
+	    ksm_write_sysfs(KSM_FP("merge_across_nodes"), ksm_sysfs->merge_across_nodes) ||
+	    ksm_write_sysfs(KSM_FP("pages_to_scan"), ksm_sysfs->pages_to_scan) ||
+	    ksm_write_sysfs(KSM_FP("run"), ksm_sysfs->run) ||
+	    ksm_write_sysfs(KSM_FP("sleep_millisecs"), ksm_sysfs->sleep_millisecs) ||
+	    ksm_write_sysfs(KSM_FP("stable_node_chains_prune_millisecs"),
+			    ksm_sysfs->stable_node_chains_prune_millisecs) ||
+	    ksm_write_sysfs(KSM_FP("use_zero_pages"), ksm_sysfs->use_zero_pages))
+		return 1;
+
+	return 0;
+}
+
+static int check_ksm_merge(int mapping, int prot, long page_count, int timeout)
+{
+	int ret = KSFT_FAIL;
+	size_t page_size = sysconf(_SC_PAGESIZE);
+	unsigned long cur_scan, init_scan;
+	void *map_area;
+	struct timespec start_time, cur_time;
+
+	printf("Testing KSM MADV_MERGEABLE with %ld identical pages\n", page_count);
+
+	if (ksm_write_sysfs(KSM_FP("sleep_millisecs"), 0) ||
+	    ksm_write_sysfs(KSM_FP("pages_to_scan"), page_count))
+		return ret;
+
+	if (ksm_read_sysfs(KSM_FP("full_scans"), &init_scan))
+		return ret;
+
+	cur_scan = init_scan;
+
+	map_area = mmap(NULL, page_size * page_count, PROT_WRITE, mapping, -1, 0);
+	if (!map_area) {
+		perror("mmap");
+		return ret;
+	}
+
+	memset(map_area, '*', page_size * page_count);
+
+	if (mprotect(map_area, page_size * page_count, prot)) {
+		perror("mprotect");
+		goto err_out;
+	}
+
+	if (madvise(map_area, page_size * page_count, MADV_MERGEABLE)) {
+		perror("madvise");
+		goto err_out;
+	}
+
+	if (ksm_write_sysfs(KSM_FP("run"), 1))
+		goto err_out;
+
+	if (clock_gettime(CLOCK_MONOTONIC_RAW, &start_time)) {
+		perror("clock_gettime");
+		goto err_out;
+	}
+
+	/* Since merging occurs only after 2 scans, make sure to get at least 2 full scans */
+	while (cur_scan < init_scan + 2) {
+		if (ksm_read_sysfs(KSM_FP("full_scans"), &cur_scan))
+			goto err_out;
+
+		if (clock_gettime(CLOCK_MONOTONIC_RAW, &cur_time)) {
+			perror("clock_gettime");
+			goto err_out;
+		}
+
+		if ((cur_time.tv_sec - start_time.tv_sec) > timeout) {
+			printf("Scan time limit exceeded\n");
+			goto err_out;
+		}
+	}
+
+	/* verify that the right number of pages are merged */
+	if (assert_ksm_pages_count(page_count)) {
+		printf("OK\n");
+		munmap(map_area, page_size * page_count);
+		return KSFT_PASS;
+	}
+
+err_out:
+	printf("Not OK\n");
+	munmap(map_area, page_size * page_count);
+	return KSFT_FAIL;
+}
+
+int main(int argc, char *argv[])
+{
+	int ret, opt;
+	struct ksm_sysfs ksm_sysfs_old;
+	long page_count = KSM_PAGE_COUNT_DEFAULT;
+	int ksm_scan_limit_sec = KSM_SCAN_LIMIT_SEC_DEFAULT;
+	int prot = 0;
+
+	if (access(KSM_SYSFS_PATH, F_OK)) {
+		printf("Config KSM not enabled\n");
+		return KSFT_SKIP;
+	}
+
+	while ((opt = getopt(argc, argv, "ha:p:l:")) != -1) {
+		switch (opt) {
+		case 'a':
+			prot = str_to_prot(optarg);
+			break;
+		case 'p':
+			page_count = atol(optarg);
+			if (page_count <= 0) {
+				printf("The number of pages must be greater than 0\n");
+				return KSFT_FAIL;
+			}
+			break;
+		case 'l':
+			ksm_scan_limit_sec = atoi(optarg);
+			if (ksm_scan_limit_sec <= 0) {
+				printf("Timeout value must be greater than 0\n");
+				return KSFT_FAIL;
+			}
+			break;
+		case 'h':
+			print_help();
+			break;
+		default:
+			return KSFT_FAIL;
+		}
+	}
+
+	if (prot == 0)
+		prot = str_to_prot(KSM_PROT_STR_DEFAULT);
+
+	if (ksm_save_def(&ksm_sysfs_old)) {
+		printf("Cannot save default tunables\n");
+		return KSFT_FAIL;
+	}
+
+	/* unmerge all pages if there are any */
+	if (ksm_write_sysfs(KSM_FP("run"), 2))
+		return KSFT_FAIL;
+
+	ret = check_ksm_merge(MAP_PRIVATE | MAP_ANONYMOUS, prot, page_count, ksm_scan_limit_sec);
+
+	if (ksm_restore(&ksm_sysfs_old)) {
+		printf("Cannot restore default tunables\n");
+		return KSFT_FAIL;
+	}
+
+	return ret;
+}
diff --git a/tools/testing/selftests/vm/run_vmtests.sh b/tools/testing/selftests/vm/run_vmtests.sh
index e953f3cd9664..88772d8a6616 100755
--- a/tools/testing/selftests/vm/run_vmtests.sh
+++ b/tools/testing/selftests/vm/run_vmtests.sh
@@ -346,4 +346,20 @@ else
 	exitcode=1
 fi
 
+echo "------------------------------------"
+echo "running KSM tests"
+echo "------------------------------------"
+./ksm_tests
+ret_val=$?
+
+if [ $ret_val -eq 0 ]; then
+	echo "[PASS]"
+elif [ $ret_val -eq $ksft_skip ]; then
+	echo "[SKIP]"
+	exitcode=$ksft_skip
+else
+	echo "[FAIL]"
+	exitcode=1
+fi
+
 exit $exitcode
-- 
2.25.1

