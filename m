Return-Path: <linux-kselftest+bounces-2851-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A10D082AE10
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Jan 2024 12:58:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF9531F24142
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Jan 2024 11:58:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94592156E8;
	Thu, 11 Jan 2024 11:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="CeNOj0Ou"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4D2615E89;
	Thu, 11 Jan 2024 11:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1704974272;
	bh=TMVRXrb1tG3+I18SJgfvyHfjDUNm4khJlToJ4CS96e8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CeNOj0Ou83o8PjgWUj5t1B4zOUJFH4e4+MsO3TjXL+hGObn6Pe2AIqM8XU2/UN1nb
	 VCZywtb4RmMmHveApixvo7BaanL36vdpwP1dnkN7hVLviBzjF5W+Iv0elZpGxjE30B
	 hyB/F7GdUI8qo/9uQSNDfL+jYRZwYVTlhd17jzoaO2sm1iWmGPH8F1w8J/WjkQ6hpa
	 ihV9b6YkkZTuD5jWU6YW77odEFElc+wyeVdf/nXd8g1L/zmlrDteFYEkicsQuTkVmA
	 tDJj/2IGXEo1r9JFZyfLLcUEOU+4NDCLpCei7PvCyAtiYLfNIxnI2AXGDQVqqAQQFg
	 5cO7B82yW+drw==
Received: from localhost.localdomain (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 141B63781182;
	Thu, 11 Jan 2024 11:57:49 +0000 (UTC)
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
	kernel@collabora.com,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 6/7] selftests/mm: ksm_tests: conform test to TAP format output
Date: Thu, 11 Jan 2024 16:56:35 +0500
Message-ID: <20240111115639.3981970-6-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240111115639.3981970-1-usama.anjum@collabora.com>
References: <20240111115639.3981970-1-usama.anjum@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Conform the layout, informational and status messages to TAP. No
functional change is intended other than the layout of output messages.

Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
 tools/testing/selftests/mm/ksm_tests.c | 682 ++++++++++---------------
 1 file changed, 276 insertions(+), 406 deletions(-)

diff --git a/tools/testing/selftests/mm/ksm_tests.c b/tools/testing/selftests/mm/ksm_tests.c
index 380b691d3eb9..c5c5e909cc5e 100644
--- a/tools/testing/selftests/mm/ksm_tests.c
+++ b/tools/testing/selftests/mm/ksm_tests.c
@@ -56,42 +56,34 @@ enum ksm_test_name {
 
 int debug;
 
-static int ksm_write_sysfs(const char *file_path, unsigned long val)
+static void ksm_write_sysfs(const char *file_path, unsigned long val)
 {
 	FILE *f = fopen(file_path, "w");
 
-	if (!f) {
-		fprintf(stderr, "f %s\n", file_path);
-		perror("fopen");
-		return 1;
-	}
+	if (!f)
+		ksft_exit_fail_msg("fopen %s: %s\n", file_path, strerror(errno));
+
 	if (fprintf(f, "%lu", val) < 0) {
-		perror("fprintf");
 		fclose(f);
-		return 1;
+		ksft_exit_fail_msg("fprintf: %s\n", strerror(errno));
 	}
-	fclose(f);
 
-	return 0;
+	fclose(f);
 }
 
-static int ksm_read_sysfs(const char *file_path, unsigned long *val)
+static void ksm_read_sysfs(const char *file_path, unsigned long *val)
 {
 	FILE *f = fopen(file_path, "r");
 
-	if (!f) {
-		fprintf(stderr, "f %s\n", file_path);
-		perror("fopen");
-		return 1;
-	}
+	if (!f)
+		ksft_exit_fail_msg("fopen %s: %s\n", file_path, strerror(errno));
+
 	if (fscanf(f, "%lu", val) != 1) {
-		perror("fscanf");
 		fclose(f);
-		return 1;
+		ksft_exit_fail_msg("fscanf: %s\n", strerror(errno));
 	}
-	fclose(f);
 
-	return 0;
+	fclose(f);
 }
 
 static void ksm_print_sysfs(void)
@@ -101,26 +93,25 @@ static void ksm_print_sysfs(void)
 	unsigned long stable_node_chains, stable_node_dups;
 	long general_profit;
 
-	if (ksm_read_sysfs(KSM_FP("pages_shared"), &pages_shared) ||
-	    ksm_read_sysfs(KSM_FP("pages_sharing"), &pages_sharing) ||
-	    ksm_read_sysfs(KSM_FP("max_page_sharing"), &max_page_sharing) ||
-	    ksm_read_sysfs(KSM_FP("full_scans"), &full_scans) ||
-	    ksm_read_sysfs(KSM_FP("pages_unshared"), &pages_unshared) ||
-	    ksm_read_sysfs(KSM_FP("pages_volatile"), &pages_volatile) ||
-	    ksm_read_sysfs(KSM_FP("stable_node_chains"), &stable_node_chains) ||
-	    ksm_read_sysfs(KSM_FP("stable_node_dups"), &stable_node_dups) ||
-	    ksm_read_sysfs(KSM_FP("general_profit"), (unsigned long *)&general_profit))
-		return;
-
-	printf("pages_shared      : %lu\n", pages_shared);
-	printf("pages_sharing     : %lu\n", pages_sharing);
-	printf("max_page_sharing  : %lu\n", max_page_sharing);
-	printf("full_scans        : %lu\n", full_scans);
-	printf("pages_unshared    : %lu\n", pages_unshared);
-	printf("pages_volatile    : %lu\n", pages_volatile);
-	printf("stable_node_chains: %lu\n", stable_node_chains);
-	printf("stable_node_dups  : %lu\n", stable_node_dups);
-	printf("general_profit    : %ld\n", general_profit);
+	ksm_read_sysfs(KSM_FP("pages_shared"), &pages_shared);
+	ksm_read_sysfs(KSM_FP("pages_sharing"), &pages_sharing);
+	ksm_read_sysfs(KSM_FP("max_page_sharing"), &max_page_sharing);
+	ksm_read_sysfs(KSM_FP("full_scans"), &full_scans);
+	ksm_read_sysfs(KSM_FP("pages_unshared"), &pages_unshared);
+	ksm_read_sysfs(KSM_FP("pages_volatile"), &pages_volatile);
+	ksm_read_sysfs(KSM_FP("stable_node_chains"), &stable_node_chains);
+	ksm_read_sysfs(KSM_FP("stable_node_dups"), &stable_node_dups);
+	ksm_read_sysfs(KSM_FP("general_profit"), (unsigned long *)&general_profit);
+
+	ksft_print_msg("pages_shared      : %lu\n", pages_shared);
+	ksft_print_msg("pages_sharing     : %lu\n", pages_sharing);
+	ksft_print_msg("max_page_sharing  : %lu\n", max_page_sharing);
+	ksft_print_msg("full_scans        : %lu\n", full_scans);
+	ksft_print_msg("pages_unshared    : %lu\n", pages_unshared);
+	ksft_print_msg("pages_volatile    : %lu\n", pages_volatile);
+	ksft_print_msg("stable_node_chains: %lu\n", stable_node_chains);
+	ksft_print_msg("stable_node_dups  : %lu\n", stable_node_dups);
+	ksft_print_msg("general_profit    : %ld\n", general_profit);
 }
 
 static void ksm_print_procfs(void)
@@ -129,14 +120,11 @@ static void ksm_print_procfs(void)
 	char buffer[512];
 	FILE *f = fopen(file_name, "r");
 
-	if (!f) {
-		fprintf(stderr, "f %s\n", file_name);
-		perror("fopen");
-		return;
-	}
+	if (!f)
+		ksft_exit_fail_msg("fopen %s: %s\n", file_name, strerror(errno));
 
 	while (fgets(buffer, sizeof(buffer), f))
-		printf("%s", buffer);
+		ksft_exit_fail_msg("%s", buffer);
 
 	fclose(f);
 }
@@ -157,132 +145,111 @@ static int str_to_prot(char *prot_str)
 
 static void print_help(void)
 {
-	printf("usage: ksm_tests [-h] <test type> [-a prot] [-p page_count] [-l timeout]\n"
-	       "[-z use_zero_pages] [-m merge_across_nodes] [-s size]\n");
-
-	printf("Supported <test type>:\n"
-	       " -M (page merging)\n"
-	       " -Z (zero pages merging)\n"
-	       " -N (merging of pages in different NUMA nodes)\n"
-	       " -U (page unmerging)\n"
-	       " -P evaluate merging time and speed.\n"
-	       "    For this test, the size of duplicated memory area (in MiB)\n"
-	       "    must be provided using -s option\n"
-	       " -H evaluate merging time and speed of area allocated mostly with huge pages\n"
-	       "    For this test, the size of duplicated memory area (in MiB)\n"
-	       "    must be provided using -s option\n"
-	       " -D evaluate unmerging time and speed when disabling KSM.\n"
-	       "    For this test, the size of duplicated memory area (in MiB)\n"
-	       "    must be provided using -s option\n"
-	       " -C evaluate the time required to break COW of merged pages.\n\n");
-
-	printf(" -a: specify the access protections of pages.\n"
-	       "     <prot> must be of the form [rwx].\n"
-	       "     Default: %s\n", KSM_PROT_STR_DEFAULT);
-	printf(" -p: specify the number of pages to test.\n"
-	       "     Default: %ld\n", KSM_PAGE_COUNT_DEFAULT);
-	printf(" -l: limit the maximum running time (in seconds) for a test.\n"
-	       "     Default: %d seconds\n", KSM_SCAN_LIMIT_SEC_DEFAULT);
-	printf(" -z: change use_zero_pages tunable\n"
-	       "     Default: %d\n", KSM_USE_ZERO_PAGES_DEFAULT);
-	printf(" -m: change merge_across_nodes tunable\n"
-	       "     Default: %d\n", KSM_MERGE_ACROSS_NODES_DEFAULT);
-	printf(" -d: turn debugging output on\n");
-	printf(" -s: the size of duplicated memory area (in MiB)\n");
-	printf(" -t: KSM merge type\n"
-	       "     Default: 0\n"
-	       "     0: madvise merging\n"
-	       "     1: prctl merging\n");
-
-	exit(0);
+	ksft_print_msg("usage: ksm_tests [-h] <test type> [-a prot] [-p page_count] [-l timeout]\n"
+		       "[-z use_zero_pages] [-m merge_across_nodes] [-s size]\n");
+
+	ksft_print_msg("Supported <test type>:\n"
+		       " -M (page merging)\n"
+		       " -Z (zero pages merging)\n"
+		       " -N (merging of pages in different NUMA nodes)\n"
+		       " -U (page unmerging)\n"
+		       " -P evaluate merging time and speed.\n"
+		       "    For this test, the size of duplicated memory area (in MiB)\n"
+		       "    must be provided using -s option\n"
+		       " -H evaluate merging time and speed of area allocated mostly with huge pages\n"
+		       "    For this test, the size of duplicated memory area (in MiB)\n"
+		       "    must be provided using -s option\n"
+		       " -D evaluate unmerging time and speed when disabling KSM.\n"
+		       "    For this test, the size of duplicated memory area (in MiB)\n"
+		       "    must be provided using -s option\n"
+		       " -C evaluate the time required to break COW of merged pages.\n\n");
+
+	ksft_print_msg(" -a: specify the access protections of pages.\n"
+		       "     <prot> must be of the form [rwx].\n"
+		       "     Default: %s\n", KSM_PROT_STR_DEFAULT);
+	ksft_print_msg(" -p: specify the number of pages to test.\n"
+		       "     Default: %ld\n", KSM_PAGE_COUNT_DEFAULT);
+	ksft_print_msg(" -l: limit the maximum running time (in seconds) for a test.\n"
+		       "     Default: %d seconds\n", KSM_SCAN_LIMIT_SEC_DEFAULT);
+	ksft_print_msg(" -z: change use_zero_pages tunable\n"
+		       "     Default: %d\n", KSM_USE_ZERO_PAGES_DEFAULT);
+	ksft_print_msg(" -m: change merge_across_nodes tunable\n"
+		       "     Default: %d\n", KSM_MERGE_ACROSS_NODES_DEFAULT);
+	ksft_print_msg(" -d: turn debugging output on\n");
+	ksft_print_msg(" -s: the size of duplicated memory area (in MiB)\n");
+	ksft_exit_fail_msg(" -t: KSM merge type\n"
+			   "     Default: 0\n"
+			   "     0: madvise merging\n"
+			   "     1: prctl merging\n");
 }
 
-static void  *allocate_memory(void *ptr, int prot, int mapping, char data, size_t map_size)
+static void *allocate_memory(void *ptr, int prot, int mapping, char data, size_t map_size)
 {
 	void *map_ptr = mmap(ptr, map_size, PROT_WRITE, mapping, -1, 0);
 
-	if (!map_ptr) {
-		perror("mmap");
-		return NULL;
-	}
+	if (!map_ptr)
+		ksft_exit_fail_msg("mmap: %s\n", strerror(errno));
+
 	memset(map_ptr, data, map_size);
 	if (mprotect(map_ptr, map_size, prot)) {
-		perror("mprotect");
 		munmap(map_ptr, map_size);
-		return NULL;
+		ksft_exit_fail_msg("mprotect: %s\n", strerror(errno));
 	}
 
 	return map_ptr;
 }
 
-static int ksm_do_scan(int scan_count, struct timespec start_time, int timeout)
+static void ksm_do_scan(int scan_count, struct timespec start_time, int timeout)
 {
 	struct timespec cur_time;
 	unsigned long cur_scan, init_scan;
 
-	if (ksm_read_sysfs(KSM_FP("full_scans"), &init_scan))
-		return 1;
+	ksm_read_sysfs(KSM_FP("full_scans"), &init_scan);
+
 	cur_scan = init_scan;
 
 	while (cur_scan < init_scan + scan_count) {
-		if (ksm_read_sysfs(KSM_FP("full_scans"), &cur_scan))
-			return 1;
-		if (clock_gettime(CLOCK_MONOTONIC_RAW, &cur_time)) {
-			perror("clock_gettime");
-			return 1;
-		}
-		if ((cur_time.tv_sec - start_time.tv_sec) > timeout) {
-			printf("Scan time limit exceeded\n");
-			return 1;
-		}
-	}
+		ksm_read_sysfs(KSM_FP("full_scans"), &cur_scan);
+
+		if (clock_gettime(CLOCK_MONOTONIC_RAW, &cur_time))
+			ksft_exit_fail_msg("clock_gettime: %s\n", strerror(errno));
 
-	return 0;
+		if ((cur_time.tv_sec - start_time.tv_sec) > timeout)
+			ksft_exit_fail_msg("Scan time limit exceeded\n");
+	}
 }
 
-static int ksm_merge_pages(int merge_type, void *addr, size_t size,
-			struct timespec start_time, int timeout)
+static void ksm_merge_pages(int merge_type, void *addr, size_t size,
+			    struct timespec start_time, int timeout)
 {
 	if (merge_type == KSM_MERGE_MADVISE) {
-		if (madvise(addr, size, MADV_MERGEABLE)) {
-			perror("madvise");
-			return 1;
-		}
+		if (madvise(addr, size, MADV_MERGEABLE))
+			ksft_exit_fail_msg("madvise: %s", strerror(errno));
 	} else if (merge_type == KSM_MERGE_PRCTL) {
-		if (prctl(PR_SET_MEMORY_MERGE, 1, 0, 0, 0)) {
-			perror("prctl");
-			return 1;
-		}
+		if (prctl(PR_SET_MEMORY_MERGE, 1, 0, 0, 0))
+			ksft_exit_fail_msg("prctl: %s\n", strerror(errno));
 	}
 
-	if (ksm_write_sysfs(KSM_FP("run"), 1))
-		return 1;
+	ksm_write_sysfs(KSM_FP("run"), 1);
 
 	/* Since merging occurs only after 2 scans, make sure to get at least 2 full scans */
-	if (ksm_do_scan(2, start_time, timeout))
-		return 1;
-
-	return 0;
+	ksm_do_scan(2, start_time, timeout);
 }
 
-static int ksm_unmerge_pages(void *addr, size_t size,
-			     struct timespec start_time, int timeout)
+static void ksm_unmerge_pages(void *addr, size_t size,
+			      struct timespec start_time, int timeout)
 {
-	if (madvise(addr, size, MADV_UNMERGEABLE)) {
-		perror("madvise");
-		return 1;
-	}
-	return 0;
+	if (madvise(addr, size, MADV_UNMERGEABLE))
+		ksft_exit_fail_msg("madvise: %s\n", strerror(errno));
 }
 
 static bool assert_ksm_pages_count(long dupl_page_count)
 {
 	unsigned long max_page_sharing, pages_sharing, pages_shared;
 
-	if (ksm_read_sysfs(KSM_FP("pages_shared"), &pages_shared) ||
-	    ksm_read_sysfs(KSM_FP("pages_sharing"), &pages_sharing) ||
-	    ksm_read_sysfs(KSM_FP("max_page_sharing"), &max_page_sharing))
-		return false;
+	ksm_read_sysfs(KSM_FP("pages_shared"), &pages_shared);
+	ksm_read_sysfs(KSM_FP("pages_sharing"), &pages_sharing);
+	ksm_read_sysfs(KSM_FP("max_page_sharing"), &max_page_sharing);
 
 	if (debug) {
 		ksm_print_sysfs();
@@ -312,133 +279,96 @@ static bool assert_ksm_pages_count(long dupl_page_count)
 	return false;
 }
 
-static int ksm_save_def(struct ksm_sysfs *ksm_sysfs)
+static void ksm_save_def(struct ksm_sysfs *ksm_sysfs)
 {
-	if (ksm_read_sysfs(KSM_FP("max_page_sharing"), &ksm_sysfs->max_page_sharing) ||
-	    numa_available() ? 0 :
-		ksm_read_sysfs(KSM_FP("merge_across_nodes"), &ksm_sysfs->merge_across_nodes) ||
-	    ksm_read_sysfs(KSM_FP("sleep_millisecs"), &ksm_sysfs->sleep_millisecs) ||
-	    ksm_read_sysfs(KSM_FP("pages_to_scan"), &ksm_sysfs->pages_to_scan) ||
-	    ksm_read_sysfs(KSM_FP("run"), &ksm_sysfs->run) ||
-	    ksm_read_sysfs(KSM_FP("stable_node_chains_prune_millisecs"),
-			   &ksm_sysfs->stable_node_chains_prune_millisecs) ||
-	    ksm_read_sysfs(KSM_FP("use_zero_pages"), &ksm_sysfs->use_zero_pages))
-		return 1;
-
-	return 0;
+	ksm_read_sysfs(KSM_FP("max_page_sharing"), &ksm_sysfs->max_page_sharing);
+	if (numa_available())
+		ksm_read_sysfs(KSM_FP("merge_across_nodes"), &ksm_sysfs->merge_across_nodes);
+	ksm_read_sysfs(KSM_FP("sleep_millisecs"), &ksm_sysfs->sleep_millisecs);
+	ksm_read_sysfs(KSM_FP("pages_to_scan"), &ksm_sysfs->pages_to_scan);
+	ksm_read_sysfs(KSM_FP("run"), &ksm_sysfs->run);
+	ksm_read_sysfs(KSM_FP("stable_node_chains_prune_millisecs"),
+			   &ksm_sysfs->stable_node_chains_prune_millisecs);
+	ksm_read_sysfs(KSM_FP("use_zero_pages"), &ksm_sysfs->use_zero_pages);
 }
 
-static int ksm_restore(struct ksm_sysfs *ksm_sysfs)
+static void ksm_restore(struct ksm_sysfs *ksm_sysfs)
 {
-	if (ksm_write_sysfs(KSM_FP("max_page_sharing"), ksm_sysfs->max_page_sharing) ||
-	    numa_available() ? 0 :
-		ksm_write_sysfs(KSM_FP("merge_across_nodes"), ksm_sysfs->merge_across_nodes) ||
-	    ksm_write_sysfs(KSM_FP("pages_to_scan"), ksm_sysfs->pages_to_scan) ||
-	    ksm_write_sysfs(KSM_FP("run"), ksm_sysfs->run) ||
-	    ksm_write_sysfs(KSM_FP("sleep_millisecs"), ksm_sysfs->sleep_millisecs) ||
-	    ksm_write_sysfs(KSM_FP("stable_node_chains_prune_millisecs"),
-			    ksm_sysfs->stable_node_chains_prune_millisecs) ||
-	    ksm_write_sysfs(KSM_FP("use_zero_pages"), ksm_sysfs->use_zero_pages))
-		return 1;
-
-	return 0;
+	ksm_write_sysfs(KSM_FP("max_page_sharing"), ksm_sysfs->max_page_sharing);
+	if (numa_available())
+		ksm_write_sysfs(KSM_FP("merge_across_nodes"), ksm_sysfs->merge_across_nodes);
+
+	ksm_write_sysfs(KSM_FP("pages_to_scan"), ksm_sysfs->pages_to_scan);
+	ksm_write_sysfs(KSM_FP("run"), ksm_sysfs->run);
+	ksm_write_sysfs(KSM_FP("sleep_millisecs"), ksm_sysfs->sleep_millisecs);
+	ksm_write_sysfs(KSM_FP("stable_node_chains_prune_millisecs"),
+			ksm_sysfs->stable_node_chains_prune_millisecs);
+	ksm_write_sysfs(KSM_FP("use_zero_pages"), ksm_sysfs->use_zero_pages);
 }
 
-static int check_ksm_merge(int merge_type, int mapping, int prot,
-			long page_count, int timeout, size_t page_size)
+static void check_ksm_merge(int merge_type, int mapping, int prot,
+			    long page_count, int timeout, size_t page_size)
 {
 	void *map_ptr;
 	struct timespec start_time;
 
-	if (clock_gettime(CLOCK_MONOTONIC_RAW, &start_time)) {
-		perror("clock_gettime");
-		return KSFT_FAIL;
-	}
+	if (clock_gettime(CLOCK_MONOTONIC_RAW, &start_time))
+		ksft_exit_fail_msg("clock_gettime: %s\n", strerror(errno));
 
 	/* fill pages with the same data and merge them */
 	map_ptr = allocate_memory(NULL, prot, mapping, '*', page_size * page_count);
-	if (!map_ptr)
-		return KSFT_FAIL;
 
-	if (ksm_merge_pages(merge_type, map_ptr, page_size * page_count, start_time, timeout))
-		goto err_out;
+	ksm_merge_pages(merge_type, map_ptr, page_size * page_count, start_time, timeout);
 
 	/* verify that the right number of pages are merged */
-	if (assert_ksm_pages_count(page_count)) {
-		printf("OK\n");
-		munmap(map_ptr, page_size * page_count);
-		if (merge_type == KSM_MERGE_PRCTL)
-			prctl(PR_SET_MEMORY_MERGE, 0, 0, 0, 0);
-		return KSFT_PASS;
-	}
-
-err_out:
-	printf("Not OK\n");
+	ksft_test_result(assert_ksm_pages_count(page_count), "%s\n", __func__);
 	munmap(map_ptr, page_size * page_count);
-	return KSFT_FAIL;
+	if (merge_type == KSM_MERGE_PRCTL)
+		prctl(PR_SET_MEMORY_MERGE, 0, 0, 0, 0);
 }
 
-static int check_ksm_unmerge(int merge_type, int mapping, int prot, int timeout, size_t page_size)
+static void check_ksm_unmerge(int merge_type, int mapping, int prot, int timeout, size_t page_size)
 {
 	void *map_ptr;
 	struct timespec start_time;
 	int page_count = 2;
 
-	if (clock_gettime(CLOCK_MONOTONIC_RAW, &start_time)) {
-		perror("clock_gettime");
-		return KSFT_FAIL;
-	}
+	if (clock_gettime(CLOCK_MONOTONIC_RAW, &start_time))
+		ksft_exit_fail_msg("clock_gettime: %s\n", strerror(errno));
 
 	/* fill pages with the same data and merge them */
 	map_ptr = allocate_memory(NULL, prot, mapping, '*', page_size * page_count);
-	if (!map_ptr)
-		return KSFT_FAIL;
 
-	if (ksm_merge_pages(merge_type, map_ptr, page_size * page_count, start_time, timeout))
-		goto err_out;
+	ksm_merge_pages(merge_type, map_ptr, page_size * page_count, start_time, timeout);
 
 	/* change 1 byte in each of the 2 pages -- KSM must automatically unmerge them */
 	memset(map_ptr, '-', 1);
 	memset(map_ptr + page_size, '+', 1);
 
 	/* get at least 1 scan, so KSM can detect that the pages were modified */
-	if (ksm_do_scan(1, start_time, timeout))
-		goto err_out;
+	ksm_do_scan(1, start_time, timeout);
 
 	/* check that unmerging was successful and 0 pages are currently merged */
-	if (assert_ksm_pages_count(0)) {
-		printf("OK\n");
-		munmap(map_ptr, page_size * page_count);
-		return KSFT_PASS;
-	}
-
-err_out:
-	printf("Not OK\n");
+	ksft_test_result(assert_ksm_pages_count(0), "%s\n", __func__);
 	munmap(map_ptr, page_size * page_count);
-	return KSFT_FAIL;
 }
 
-static int check_ksm_zero_page_merge(int merge_type, int mapping, int prot, long page_count,
-				int timeout, bool use_zero_pages, size_t page_size)
+static void check_ksm_zero_page_merge(int merge_type, int mapping, int prot, long page_count,
+				      int timeout, bool use_zero_pages, size_t page_size)
 {
 	void *map_ptr;
 	struct timespec start_time;
+	bool passed = true;
 
-	if (clock_gettime(CLOCK_MONOTONIC_RAW, &start_time)) {
-		perror("clock_gettime");
-		return KSFT_FAIL;
-	}
+	if (clock_gettime(CLOCK_MONOTONIC_RAW, &start_time))
+		ksft_exit_fail_msg("clock_gettime: %s\n", strerror(errno));
 
-	if (ksm_write_sysfs(KSM_FP("use_zero_pages"), use_zero_pages))
-		return KSFT_FAIL;
+	ksm_write_sysfs(KSM_FP("use_zero_pages"), use_zero_pages);
 
 	/* fill pages with zero and try to merge them */
 	map_ptr = allocate_memory(NULL, prot, mapping, 0, page_size * page_count);
-	if (!map_ptr)
-		return KSFT_FAIL;
 
-	if (ksm_merge_pages(merge_type, map_ptr, page_size * page_count, start_time, timeout))
-		goto err_out;
+	ksm_merge_pages(merge_type, map_ptr, page_size * page_count, start_time, timeout);
 
        /*
 	* verify that the right number of pages are merged:
@@ -448,18 +378,12 @@ static int check_ksm_zero_page_merge(int merge_type, int mapping, int prot, long
 	*    and merged as usual.
 	*/
 	if (use_zero_pages && !assert_ksm_pages_count(0))
-		goto err_out;
+		passed = false;
 	else if (!use_zero_pages && !assert_ksm_pages_count(page_count))
-		goto err_out;
-
-	printf("OK\n");
-	munmap(map_ptr, page_size * page_count);
-	return KSFT_PASS;
+		passed = false;
 
-err_out:
-	printf("Not OK\n");
+	ksft_test_result(passed, "%s\n", __func__);
 	munmap(map_ptr, page_size * page_count);
-	return KSFT_FAIL;
 }
 
 static int get_next_mem_node(int node)
@@ -483,46 +407,44 @@ static int get_first_mem_node(void)
 	return get_next_mem_node(numa_max_node());
 }
 
-static int check_ksm_numa_merge(int merge_type, int mapping, int prot, int timeout,
-				bool merge_across_nodes, size_t page_size)
+static void check_ksm_numa_merge(int merge_type, int mapping, int prot, int timeout,
+				 bool merge_across_nodes, size_t page_size)
 {
 	void *numa1_map_ptr, *numa2_map_ptr;
 	struct timespec start_time;
 	int page_count = 2;
+	bool passed = true;
 	int first_node;
 
-	if (clock_gettime(CLOCK_MONOTONIC_RAW, &start_time)) {
-		perror("clock_gettime");
-		return KSFT_FAIL;
-	}
+	if (clock_gettime(CLOCK_MONOTONIC_RAW, &start_time))
+		ksft_exit_fail_msg("clock_gettime: %s\n", strerror(errno));
 
 	if (numa_available() < 0) {
-		perror("NUMA support not enabled");
-		return KSFT_SKIP;
+		ksft_test_result_skip("NUMA support not enabled: %s\n", strerror(errno));
+		return;
 	}
+
 	if (numa_num_configured_nodes() <= 1) {
-		printf("At least 2 NUMA nodes must be available\n");
-		return KSFT_SKIP;
+		ksft_test_result_skip("At least 2 NUMA nodes must be available\n");
+		return;
 	}
-	if (ksm_write_sysfs(KSM_FP("merge_across_nodes"), merge_across_nodes))
-		return KSFT_FAIL;
+	ksm_write_sysfs(KSM_FP("merge_across_nodes"), merge_across_nodes);
 
 	/* allocate 2 pages in 2 different NUMA nodes and fill them with the same data */
 	first_node = get_first_mem_node();
 	numa1_map_ptr = numa_alloc_onnode(page_size, first_node);
 	numa2_map_ptr = numa_alloc_onnode(page_size, get_next_mem_node(first_node));
 	if (!numa1_map_ptr || !numa2_map_ptr) {
-		perror("numa_alloc_onnode");
-		return KSFT_FAIL;
+		ksft_test_result_fail("numa_alloc_onnode: %s\n", strerror(errno));
+		return;
 	}
 
 	memset(numa1_map_ptr, '*', page_size);
 	memset(numa2_map_ptr, '*', page_size);
 
 	/* try to merge the pages */
-	if (ksm_merge_pages(merge_type, numa1_map_ptr, page_size, start_time, timeout) ||
-	    ksm_merge_pages(merge_type, numa2_map_ptr, page_size, start_time, timeout))
-		goto err_out;
+	ksm_merge_pages(merge_type, numa1_map_ptr, page_size, start_time, timeout);
+	ksm_merge_pages(merge_type, numa2_map_ptr, page_size, start_time, timeout);
 
        /*
 	* verify that the right number of pages are merged:
@@ -531,24 +453,18 @@ static int check_ksm_numa_merge(int merge_type, int mapping, int prot, int timeo
 	*    only 1 unique page in each node and they can't be shared.
 	*/
 	if (merge_across_nodes && !assert_ksm_pages_count(page_count))
-		goto err_out;
+		passed = false;
 	else if (!merge_across_nodes && !assert_ksm_pages_count(0))
-		goto err_out;
+		passed = false;
 
 	numa_free(numa1_map_ptr, page_size);
 	numa_free(numa2_map_ptr, page_size);
-	printf("OK\n");
-	return KSFT_PASS;
 
-err_out:
-	numa_free(numa1_map_ptr, page_size);
-	numa_free(numa2_map_ptr, page_size);
-	printf("Not OK\n");
-	return KSFT_FAIL;
+	ksft_test_result(passed, "%s\n", __func__);
 }
 
-static int ksm_merge_hugepages_time(int merge_type, int mapping, int prot,
-				int timeout, size_t map_size)
+static void ksm_merge_hugepages_time(int merge_type, int mapping, int prot,
+				     int timeout, size_t map_size)
 {
 	void *map_ptr, *map_ptr_orig;
 	struct timespec start_time, end_time;
@@ -564,14 +480,14 @@ static int ksm_merge_hugepages_time(int merge_type, int mapping, int prot,
 	map_ptr = map_ptr_orig + HPAGE_SIZE - (uintptr_t)map_ptr_orig % HPAGE_SIZE;
 
 	if (map_ptr_orig == MAP_FAILED)
-		err(2, "initial mmap");
+		ksft_exit_fail_msg("initial mmap: %s\n", strerror(errno));
 
 	if (madvise(map_ptr, len + HPAGE_SIZE, MADV_HUGEPAGE))
-		err(2, "MADV_HUGEPAGE");
+		ksft_exit_fail_msg("MADV_HUGEPAGE: %s\n", strerror(errno));
 
 	pagemap_fd = open("/proc/self/pagemap", O_RDONLY);
 	if (pagemap_fd < 0)
-		err(2, "open pagemap");
+		ksft_exit_fail_msg("open pagemap: %s\n", strerror(errno));
 
 	n_normal_pages = 0;
 	n_huge_pages = 0;
@@ -581,41 +497,33 @@ static int ksm_merge_hugepages_time(int merge_type, int mapping, int prot,
 		else
 			n_huge_pages++;
 	}
-	printf("Number of normal pages:    %d\n", n_normal_pages);
-	printf("Number of huge pages:    %d\n", n_huge_pages);
+	ksft_print_msg("Number of normal pages:    %d\n", n_normal_pages);
+	ksft_print_msg("Number of huge pages:    %d\n", n_huge_pages);
 
 	memset(map_ptr, '*', len);
 
-	if (clock_gettime(CLOCK_MONOTONIC_RAW, &start_time)) {
-		perror("clock_gettime");
-		goto err_out;
-	}
-	if (ksm_merge_pages(merge_type, map_ptr, map_size, start_time, timeout))
-		goto err_out;
-	if (clock_gettime(CLOCK_MONOTONIC_RAW, &end_time)) {
-		perror("clock_gettime");
-		goto err_out;
-	}
+	if (clock_gettime(CLOCK_MONOTONIC_RAW, &start_time))
+		ksft_exit_fail_msg("clock_gettime: %s\n", strerror(errno));
+
+	ksm_merge_pages(merge_type, map_ptr, map_size, start_time, timeout);
+
+	if (clock_gettime(CLOCK_MONOTONIC_RAW, &end_time))
+		ksft_exit_fail_msg("clock_gettime: %s\n", strerror(errno));
 
 	scan_time_ns = (end_time.tv_sec - start_time.tv_sec) * NSEC_PER_SEC +
 		       (end_time.tv_nsec - start_time.tv_nsec);
 
-	printf("Total size:    %lu MiB\n", map_size / MB);
-	printf("Total time:    %ld.%09ld s\n", scan_time_ns / NSEC_PER_SEC,
-	       scan_time_ns % NSEC_PER_SEC);
-	printf("Average speed:  %.3f MiB/s\n", (map_size / MB) /
-					       ((double)scan_time_ns / NSEC_PER_SEC));
-
-	munmap(map_ptr_orig, len + HPAGE_SIZE);
-	return KSFT_PASS;
+	ksft_print_msg("Total size:    %lu MiB\n", map_size / MB);
+	ksft_print_msg("Total time:    %ld.%09ld s\n", scan_time_ns / NSEC_PER_SEC,
+		       scan_time_ns % NSEC_PER_SEC);
+	ksft_print_msg("Average speed:  %.3f MiB/s\n", (map_size / MB) /
+						       ((double)scan_time_ns / NSEC_PER_SEC));
 
-err_out:
-	printf("Not OK\n");
+	ksft_test_result_pass("%s\n", __func__);
 	munmap(map_ptr_orig, len + HPAGE_SIZE);
-	return KSFT_FAIL;
 }
 
-static int ksm_merge_time(int merge_type, int mapping, int prot, int timeout, size_t map_size)
+static void ksm_merge_time(int merge_type, int mapping, int prot, int timeout, size_t map_size)
 {
 	void *map_ptr;
 	struct timespec start_time, end_time;
@@ -624,39 +532,29 @@ static int ksm_merge_time(int merge_type, int mapping, int prot, int timeout, si
 	map_size *= MB;
 
 	map_ptr = allocate_memory(NULL, prot, mapping, '*', map_size);
-	if (!map_ptr)
-		return KSFT_FAIL;
 
-	if (clock_gettime(CLOCK_MONOTONIC_RAW, &start_time)) {
-		perror("clock_gettime");
-		goto err_out;
-	}
-	if (ksm_merge_pages(merge_type, map_ptr, map_size, start_time, timeout))
-		goto err_out;
-	if (clock_gettime(CLOCK_MONOTONIC_RAW, &end_time)) {
-		perror("clock_gettime");
-		goto err_out;
-	}
+	if (clock_gettime(CLOCK_MONOTONIC_RAW, &start_time))
+		ksft_exit_fail_msg("clock_gettime: %s\n", strerror(errno));
+
+	ksm_merge_pages(merge_type, map_ptr, map_size, start_time, timeout);
+
+	if (clock_gettime(CLOCK_MONOTONIC_RAW, &end_time))
+		ksft_exit_fail_msg("clock_gettime: %s\n", strerror(errno));
 
 	scan_time_ns = (end_time.tv_sec - start_time.tv_sec) * NSEC_PER_SEC +
 		       (end_time.tv_nsec - start_time.tv_nsec);
 
-	printf("Total size:    %lu MiB\n", map_size / MB);
-	printf("Total time:    %ld.%09ld s\n", scan_time_ns / NSEC_PER_SEC,
-	       scan_time_ns % NSEC_PER_SEC);
-	printf("Average speed:  %.3f MiB/s\n", (map_size / MB) /
-					       ((double)scan_time_ns / NSEC_PER_SEC));
+	ksft_print_msg("Total size:    %lu MiB\n", map_size / MB);
+	ksft_print_msg("Total time:    %ld.%09ld s\n", scan_time_ns / NSEC_PER_SEC,
+		       scan_time_ns % NSEC_PER_SEC);
+	ksft_print_msg("Average speed:  %.3f MiB/s\n", (map_size / MB) /
+						       ((double)scan_time_ns / NSEC_PER_SEC));
 
+	ksft_test_result_pass("%s\n", __func__);
 	munmap(map_ptr, map_size);
-	return KSFT_PASS;
-
-err_out:
-	printf("Not OK\n");
-	munmap(map_ptr, map_size);
-	return KSFT_FAIL;
 }
 
-static int ksm_unmerge_time(int merge_type, int mapping, int prot, int timeout, size_t map_size)
+static void ksm_unmerge_time(int merge_type, int mapping, int prot, int timeout, size_t map_size)
 {
 	void *map_ptr;
 	struct timespec start_time, end_time;
@@ -665,45 +563,34 @@ static int ksm_unmerge_time(int merge_type, int mapping, int prot, int timeout,
 	map_size *= MB;
 
 	map_ptr = allocate_memory(NULL, prot, mapping, '*', map_size);
-	if (!map_ptr)
-		return KSFT_FAIL;
-	if (clock_gettime(CLOCK_MONOTONIC_RAW, &start_time)) {
-		perror("clock_gettime");
-		goto err_out;
-	}
-	if (ksm_merge_pages(merge_type, map_ptr, map_size, start_time, timeout))
-		goto err_out;
 
-	if (clock_gettime(CLOCK_MONOTONIC_RAW, &start_time)) {
-		perror("clock_gettime");
-		goto err_out;
-	}
-	if (ksm_unmerge_pages(map_ptr, map_size, start_time, timeout))
-		goto err_out;
-	if (clock_gettime(CLOCK_MONOTONIC_RAW, &end_time)) {
-		perror("clock_gettime");
-		goto err_out;
-	}
+	if (clock_gettime(CLOCK_MONOTONIC_RAW, &start_time))
+		ksft_exit_fail_msg("clock_gettime: %s\n", strerror(errno));
+
+	ksm_merge_pages(merge_type, map_ptr, map_size, start_time, timeout);
+
+	if (clock_gettime(CLOCK_MONOTONIC_RAW, &start_time))
+		ksft_exit_fail_msg("clock_gettime: %s\n", strerror(errno));
+
+	ksm_unmerge_pages(map_ptr, map_size, start_time, timeout);
+
+	if (clock_gettime(CLOCK_MONOTONIC_RAW, &end_time))
+		ksft_exit_fail_msg("clock_gettime: %s\n", strerror(errno));
 
 	scan_time_ns = (end_time.tv_sec - start_time.tv_sec) * NSEC_PER_SEC +
 		       (end_time.tv_nsec - start_time.tv_nsec);
 
-	printf("Total size:    %lu MiB\n", map_size / MB);
-	printf("Total time:    %ld.%09ld s\n", scan_time_ns / NSEC_PER_SEC,
-	       scan_time_ns % NSEC_PER_SEC);
-	printf("Average speed:  %.3f MiB/s\n", (map_size / MB) /
-					       ((double)scan_time_ns / NSEC_PER_SEC));
+	ksft_print_msg("Total size:    %lu MiB\n", map_size / MB);
+	ksft_print_msg("Total time:    %ld.%09ld s\n", scan_time_ns / NSEC_PER_SEC,
+		       scan_time_ns % NSEC_PER_SEC);
+	ksft_print_msg("Average speed:  %.3f MiB/s\n", (map_size / MB) /
+						       ((double)scan_time_ns / NSEC_PER_SEC));
 
+	ksft_test_result_pass("%s\n", __func__);
 	munmap(map_ptr, map_size);
-	return KSFT_PASS;
-
-err_out:
-	printf("Not OK\n");
-	munmap(map_ptr, map_size);
-	return KSFT_FAIL;
 }
 
-static int ksm_cow_time(int merge_type, int mapping, int prot, int timeout, size_t page_size)
+static void ksm_cow_time(int merge_type, int mapping, int prot, int timeout, size_t page_size)
 {
 	void *map_ptr;
 	struct timespec start_time, end_time;
@@ -713,70 +600,57 @@ static int ksm_cow_time(int merge_type, int mapping, int prot, int timeout, size
 	size_t page_count = 4000;
 
 	map_ptr = allocate_memory(NULL, prot, mapping, '*', page_size * page_count);
-	if (!map_ptr)
-		return KSFT_FAIL;
 
-	if (clock_gettime(CLOCK_MONOTONIC_RAW, &start_time)) {
-		perror("clock_gettime");
-		return KSFT_FAIL;
-	}
+	if (clock_gettime(CLOCK_MONOTONIC_RAW, &start_time))
+		ksft_exit_fail_msg("clock_gettime: %s\n", strerror(errno));
+
 	for (size_t i = 0; i < page_count - 1; i = i + 2)
 		memset(map_ptr + page_size * i, '-', 1);
-	if (clock_gettime(CLOCK_MONOTONIC_RAW, &end_time)) {
-		perror("clock_gettime");
-		return KSFT_FAIL;
-	}
+	if (clock_gettime(CLOCK_MONOTONIC_RAW, &end_time))
+		ksft_exit_fail_msg("clock_gettime: %s\n", strerror(errno));
 
 	cow_time_ns = (end_time.tv_sec - start_time.tv_sec) * NSEC_PER_SEC +
 		       (end_time.tv_nsec - start_time.tv_nsec);
 
-	printf("Total size:    %lu MiB\n\n", (page_size * page_count) / MB);
-	printf("Not merged pages:\n");
-	printf("Total time:     %ld.%09ld s\n", cow_time_ns / NSEC_PER_SEC,
-	       cow_time_ns % NSEC_PER_SEC);
-	printf("Average speed:  %.3f MiB/s\n\n", ((page_size * (page_count / 2)) / MB) /
-					       ((double)cow_time_ns / NSEC_PER_SEC));
+	ksft_print_msg("Total size:    %lu MiB\n\n", (page_size * page_count) / MB);
+	ksft_print_msg("Not merged pages:\n");
+	ksft_print_msg("Total time:     %ld.%09ld s\n", cow_time_ns / NSEC_PER_SEC,
+		       cow_time_ns % NSEC_PER_SEC);
+	ksft_print_msg("Average speed:  %.3f MiB/s\n\n", ((page_size * (page_count / 2)) / MB) /
+							 ((double)cow_time_ns / NSEC_PER_SEC));
 
 	/* Create 2000 pairs of duplicate pages */
 	for (size_t i = 0; i < page_count - 1; i = i + 2) {
 		memset(map_ptr + page_size * i, '+', i / 2 + 1);
 		memset(map_ptr + page_size * (i + 1), '+', i / 2 + 1);
 	}
-	if (ksm_merge_pages(merge_type, map_ptr, page_size * page_count, start_time, timeout))
-		goto err_out;
+	ksm_merge_pages(merge_type, map_ptr, page_size * page_count, start_time, timeout);
+
+	if (clock_gettime(CLOCK_MONOTONIC_RAW, &start_time))
+		ksft_exit_fail_msg("clock_gettime: %s\n", strerror(errno));
 
-	if (clock_gettime(CLOCK_MONOTONIC_RAW, &start_time)) {
-		perror("clock_gettime");
-		goto err_out;
-	}
 	for (size_t i = 0; i < page_count - 1; i = i + 2)
 		memset(map_ptr + page_size * i, '-', 1);
-	if (clock_gettime(CLOCK_MONOTONIC_RAW, &end_time)) {
-		perror("clock_gettime");
-		goto err_out;
-	}
+
+	if (clock_gettime(CLOCK_MONOTONIC_RAW, &end_time))
+		ksft_exit_fail_msg("clock_gettime: %s\n", strerror(errno));
 
 	cow_time_ns = (end_time.tv_sec - start_time.tv_sec) * NSEC_PER_SEC +
 		       (end_time.tv_nsec - start_time.tv_nsec);
 
-	printf("Merged pages:\n");
-	printf("Total time:     %ld.%09ld s\n", cow_time_ns / NSEC_PER_SEC,
-	       cow_time_ns % NSEC_PER_SEC);
-	printf("Average speed:  %.3f MiB/s\n", ((page_size * (page_count / 2)) / MB) /
-					       ((double)cow_time_ns / NSEC_PER_SEC));
-
-	munmap(map_ptr, page_size * page_count);
-	return KSFT_PASS;
+	ksft_print_msg("Merged pages:\n");
+	ksft_print_msg("Total time:     %ld.%09ld s\n", cow_time_ns / NSEC_PER_SEC,
+		       cow_time_ns % NSEC_PER_SEC);
+	ksft_print_msg("Average speed:  %.3f MiB/s\n", ((page_size * (page_count / 2)) / MB) /
+						       ((double)cow_time_ns / NSEC_PER_SEC));
 
-err_out:
-	printf("Not OK\n");
+	ksft_test_result_pass("%s\n", __func__);
 	munmap(map_ptr, page_size * page_count);
-	return KSFT_FAIL;
 }
 
 int main(int argc, char *argv[])
 {
-	int ret, opt;
+	int opt;
 	int prot = 0;
 	int ksm_scan_limit_sec = KSM_SCAN_LIMIT_SEC_DEFAULT;
 	int merge_type = KSM_MERGE_TYPE_DEFAULT;
@@ -788,6 +662,9 @@ int main(int argc, char *argv[])
 	bool merge_across_nodes = KSM_MERGE_ACROSS_NODES_DEFAULT;
 	long size_MB = 0;
 
+	ksft_print_header();
+	ksft_set_plan(1);
+
 	while ((opt = getopt(argc, argv, "dha:p:l:z:m:s:t:MUZNPCHD")) != -1) {
 		switch (opt) {
 		case 'a':
@@ -879,70 +756,63 @@ int main(int argc, char *argv[])
 		return KSFT_SKIP;
 	}
 
-	if (ksm_save_def(&ksm_sysfs_old)) {
-		printf("Cannot save default tunables\n");
-		return KSFT_FAIL;
-	}
+	ksm_save_def(&ksm_sysfs_old);
 
-	if (ksm_write_sysfs(KSM_FP("run"), 2) ||
-	    ksm_write_sysfs(KSM_FP("sleep_millisecs"), 0) ||
-	    numa_available() ? 0 :
-		ksm_write_sysfs(KSM_FP("merge_across_nodes"), 1) ||
-	    ksm_write_sysfs(KSM_FP("pages_to_scan"), page_count))
-		return KSFT_FAIL;
+	ksm_write_sysfs(KSM_FP("run"), 2);
+	ksm_write_sysfs(KSM_FP("sleep_millisecs"), 0);
+	if (numa_available())
+		ksm_write_sysfs(KSM_FP("merge_across_nodes"), 1);
+	ksm_write_sysfs(KSM_FP("pages_to_scan"), page_count);
 
 	switch (test_name) {
 	case CHECK_KSM_MERGE:
-		ret = check_ksm_merge(merge_type, MAP_PRIVATE | MAP_ANONYMOUS, prot, page_count,
-				      ksm_scan_limit_sec, page_size);
+		check_ksm_merge(merge_type, MAP_PRIVATE | MAP_ANONYMOUS, prot, page_count,
+				ksm_scan_limit_sec, page_size);
 		break;
 	case CHECK_KSM_UNMERGE:
-		ret = check_ksm_unmerge(merge_type, MAP_PRIVATE | MAP_ANONYMOUS, prot,
-					ksm_scan_limit_sec, page_size);
+		check_ksm_unmerge(merge_type, MAP_PRIVATE | MAP_ANONYMOUS, prot,
+				  ksm_scan_limit_sec, page_size);
 		break;
 	case CHECK_KSM_ZERO_PAGE_MERGE:
-		ret = check_ksm_zero_page_merge(merge_type, MAP_PRIVATE | MAP_ANONYMOUS, prot,
-						page_count, ksm_scan_limit_sec, use_zero_pages,
-						page_size);
+		check_ksm_zero_page_merge(merge_type, MAP_PRIVATE | MAP_ANONYMOUS, prot,
+					  page_count, ksm_scan_limit_sec, use_zero_pages,
+					  page_size);
 		break;
 	case CHECK_KSM_NUMA_MERGE:
-		ret = check_ksm_numa_merge(merge_type, MAP_PRIVATE | MAP_ANONYMOUS, prot,
-					ksm_scan_limit_sec, merge_across_nodes, page_size);
+		check_ksm_numa_merge(merge_type, MAP_PRIVATE | MAP_ANONYMOUS, prot,
+				     ksm_scan_limit_sec, merge_across_nodes, page_size);
 		break;
 	case KSM_MERGE_TIME:
 		if (size_MB == 0) {
-			printf("Option '-s' is required.\n");
-			return KSFT_FAIL;
+			ksft_test_result_skip("Option '-s' is required.\n");
+			break;
 		}
-		ret = ksm_merge_time(merge_type, MAP_PRIVATE | MAP_ANONYMOUS, prot,
-				ksm_scan_limit_sec, size_MB);
+		ksm_merge_time(merge_type, MAP_PRIVATE | MAP_ANONYMOUS, prot,
+			       ksm_scan_limit_sec, size_MB);
 		break;
 	case KSM_MERGE_TIME_HUGE_PAGES:
 		if (size_MB == 0) {
-			printf("Option '-s' is required.\n");
-			return KSFT_FAIL;
+			ksft_test_result_skip("Option '-s' is required.\n");
+			break;
 		}
-		ret = ksm_merge_hugepages_time(merge_type, MAP_PRIVATE | MAP_ANONYMOUS, prot,
-				ksm_scan_limit_sec, size_MB);
+		ksm_merge_hugepages_time(merge_type, MAP_PRIVATE | MAP_ANONYMOUS, prot,
+					 ksm_scan_limit_sec, size_MB);
 		break;
 	case KSM_UNMERGE_TIME:
 		if (size_MB == 0) {
-			printf("Option '-s' is required.\n");
-			return KSFT_FAIL;
+			ksft_test_result_skip("Option '-s' is required.\n");
+			break;
 		}
-		ret = ksm_unmerge_time(merge_type, MAP_PRIVATE | MAP_ANONYMOUS, prot,
-				       ksm_scan_limit_sec, size_MB);
+		ksm_unmerge_time(merge_type, MAP_PRIVATE | MAP_ANONYMOUS, prot,
+				 ksm_scan_limit_sec, size_MB);
 		break;
 	case KSM_COW_TIME:
-		ret = ksm_cow_time(merge_type, MAP_PRIVATE | MAP_ANONYMOUS, prot,
-				ksm_scan_limit_sec, page_size);
+		ksm_cow_time(merge_type, MAP_PRIVATE | MAP_ANONYMOUS, prot,
+			     ksm_scan_limit_sec, page_size);
 		break;
 	}
 
-	if (ksm_restore(&ksm_sysfs_old)) {
-		printf("Cannot restore default tunables\n");
-		return KSFT_FAIL;
-	}
+	ksm_restore(&ksm_sysfs_old);
 
-	return ret;
+	ksft_finished();
 }
-- 
2.42.0


