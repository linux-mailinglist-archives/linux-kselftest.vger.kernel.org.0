Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 738F53C80C8
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Jul 2021 10:56:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238717AbhGNI7L (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 14 Jul 2021 04:59:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238720AbhGNI7K (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 14 Jul 2021 04:59:10 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7097C061766;
        Wed, 14 Jul 2021 01:56:18 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id r16so2264970ljk.9;
        Wed, 14 Jul 2021 01:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Dlc+fhK0S5ZoY0KI8N6iYNVFp1fJcgq3Bsfweli+I2c=;
        b=FQ66VKEg8om5A96sITouaGRGALw6FckhEf0aiEWEPxdTtlGGS8tapuCMdKoK2zpxyt
         Yf+lOFhgc5WPeXyGPH6oxUbx3ZgPbmN3ZjmixtWedHjq4eg9WCYe8fflR1tXuuYDLwC3
         T/ziy1peGQNzQHh1HBCWuKLiF7leunsuRW4J0L671d+7S5nT/4CW+axQ1I4Qlt8StQKu
         W6AcfDQaC4EnygTJkd2sVdRUS145Rxn3/gQud3vCCtnXnPzVpFUguM1RcSgI2ke54DWv
         wJlCQ0IRvww3L2IM3mwLMDiFA2ARucez1CCuF9TpWqybclbxowNdl6VvcgQxx+cQaJ7d
         TvzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Dlc+fhK0S5ZoY0KI8N6iYNVFp1fJcgq3Bsfweli+I2c=;
        b=f02t0DDDwZO2KzdatkM8BraU9f3MKudz7/4ZL1DNnv1TjkDFsn/pMXLdIeckXbBqu8
         bp/bWBWBgKqddLYN5W7DR7d2tQFkeKJdeRkEaQ+5dyLKAcuIal0O0t7H+M8NmY6p/4YT
         aoBk14Ze9Gqx6RHb/hgGRvsTmkXFFcrxLbX6NKcj+E+zSNN8665aUqTy2c6doU03Drrh
         VMbMSYT3jYTTtwo4cYSociCVO8UP9Uax9rErrvCW0f0j5ZjJsxHGi1tSCwnV4NzDyGYZ
         UUUjBcR6Yqq/E+F8GWeAMV53lEOcEdgzD2J0hZPKtoCimzjEZ1yH/FaSIN7suf62rf5U
         IQlQ==
X-Gm-Message-State: AOAM533AQQT/S/wY0y778U/Nk7Kp7DdTs/EvTe+srBHPV5DFj9BDw4Om
        KFILhiBXG7c7fWLZoOKZp6A=
X-Google-Smtp-Source: ABdhPJya7v51f4/5M0Ss/86YNhCuk40JictEIoevmKM4R3OtbKGBZ88XvSDsWz3xQLss4d9rSgdYSA==
X-Received: by 2002:a2e:9f11:: with SMTP id u17mr8160709ljk.16.1626252977105;
        Wed, 14 Jul 2021 01:56:17 -0700 (PDT)
Received: from asus ([93.95.240.58])
        by smtp.gmail.com with ESMTPSA id t11sm112292lfe.258.2021.07.14.01.56.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 01:56:16 -0700 (PDT)
Date:   Wed, 14 Jul 2021 14:56:14 +0600
From:   Zhansaya Bagdauletkyzy <zhansayabagdaulet@gmail.com>
To:     shuah@kernel.org, akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, tyhicks@linux.microsoft.com,
        pasha.tatashin@soleen.com
Subject: [PATCH v2 3/4] selftests: vm: add KSM zero page merging test
Message-ID: <6d0caab00d4bdccf5e3791cb95cf6dfd5eb85e45.1626252248.git.zhansayabagdaulet@gmail.com>
References: <cover.1626252248.git.zhansayabagdaulet@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1626252248.git.zhansayabagdaulet@gmail.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add check_ksm_zero_page_merge() function to test that empty pages are
being handled properly. For this, several zero pages are allocated and
merged using madvise. If use_zero_pages is enabled, the pages must be
shared with the special kernel zero pages; otherwise, they  are merged
as usual duplicate pages. The test is run as follows: ./ksm_tests -Z

Signed-off-by: Zhansaya Bagdauletkyzy <zhansayabagdaulet@gmail.com>
---
 tools/testing/selftests/vm/ksm_tests.c    | 70 ++++++++++++++++++++++-
 tools/testing/selftests/vm/run_vmtests.sh | 32 +++++++++++
 2 files changed, 99 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/vm/ksm_tests.c b/tools/testing/selftests/vm/ksm_tests.c
index 80302bb8f64c..5843526471e1 100644
--- a/tools/testing/selftests/vm/ksm_tests.c
+++ b/tools/testing/selftests/vm/ksm_tests.c
@@ -12,6 +12,7 @@
 #define KSM_SCAN_LIMIT_SEC_DEFAULT 120
 #define KSM_PAGE_COUNT_DEFAULT 10l
 #define KSM_PROT_STR_DEFAULT "rw"
+#define KSM_USE_ZERO_PAGES_DEFAULT false
 
 struct ksm_sysfs {
 	unsigned long max_page_sharing;
@@ -25,7 +26,8 @@ struct ksm_sysfs {
 
 enum ksm_test_name {
 	CHECK_KSM_MERGE,
-	CHECK_KSM_UNMERGE
+	CHECK_KSM_UNMERGE,
+	CHECK_KSM_ZERO_PAGE_MERGE
 };
 
 static int ksm_write_sysfs(const char *file_path, unsigned long val)
@@ -80,10 +82,12 @@ static int str_to_prot(char *prot_str)
 
 static void print_help(void)
 {
-	printf("usage: ksm_tests [-h] <test type> [-a prot] [-p page_count] [-l timeout]\n");
+	printf("usage: ksm_tests [-h] <test type> [-a prot] [-p page_count] [-l timeout]\n"
+	       "[-z use_zero_pages]\n");
 
 	printf("Supported <test type>:\n"
 	       " -M (page merging)\n"
+	       " -Z (zero pages merging)\n"
 	       " -U (page unmerging)\n\n");
 
 	printf(" -a: specify the access protections of pages.\n"
@@ -93,6 +97,8 @@ static void print_help(void)
 	       "     Default: %ld\n", KSM_PAGE_COUNT_DEFAULT);
 	printf(" -l: limit the maximum running time (in seconds) for a test.\n"
 	       "     Default: %d seconds\n", KSM_SCAN_LIMIT_SEC_DEFAULT);
+	printf(" -z: change use_zero_pages tunable\n"
+	       "     Default: %d\n", KSM_USE_ZERO_PAGES_DEFAULT);
 
 	exit(0);
 }
@@ -289,6 +295,50 @@ static int check_ksm_unmerge(int mapping, int prot, int timeout, size_t page_siz
 	return KSFT_FAIL;
 }
 
+static int check_ksm_zero_page_merge(int mapping, int prot, long page_count, int timeout,
+				     bool use_zero_pages, size_t page_size)
+{
+	void *map_ptr;
+	struct timespec start_time;
+
+	if (clock_gettime(CLOCK_MONOTONIC_RAW, &start_time)) {
+		perror("clock_gettime");
+		return KSFT_FAIL;
+	}
+
+	if (ksm_write_sysfs(KSM_FP("use_zero_pages"), use_zero_pages))
+		return KSFT_FAIL;
+
+	/* fill pages with zero and try to merge them */
+	map_ptr = allocate_memory(NULL, prot, mapping, 0, page_size * page_count);
+	if (!map_ptr)
+		return KSFT_FAIL;
+
+	if (ksm_merge_pages(map_ptr, page_size * page_count, start_time, timeout))
+		goto err_out;
+
+       /*
+	* verify that the right number of pages are merged:
+	* 1) if use_zero_pages is set to 1, empty pages are merged
+	*    with the kernel zero page instead of with each other;
+	* 2) if use_zero_pages is set to 0, empty pages are not treated specially
+	*    and merged as usual.
+	*/
+	if (use_zero_pages && !assert_ksm_pages_count(0))
+		goto err_out;
+	else if (!use_zero_pages && !assert_ksm_pages_count(page_count))
+		goto err_out;
+
+	printf("OK\n");
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
@@ -298,8 +348,9 @@ int main(int argc, char *argv[])
 	size_t page_size = sysconf(_SC_PAGESIZE);
 	struct ksm_sysfs ksm_sysfs_old;
 	int test_name = CHECK_KSM_MERGE;
+	bool use_zero_pages = KSM_USE_ZERO_PAGES_DEFAULT;
 
-	while ((opt = getopt(argc, argv, "ha:p:l:MU")) != -1) {
+	while ((opt = getopt(argc, argv, "ha:p:l:z:MUZ")) != -1) {
 		switch (opt) {
 		case 'a':
 			prot = str_to_prot(optarg);
@@ -321,11 +372,20 @@ int main(int argc, char *argv[])
 		case 'h':
 			print_help();
 			break;
+		case 'z':
+			if (strcmp(optarg, "0") == 0)
+				use_zero_pages = 0;
+			else
+				use_zero_pages = 1;
+			break;
 		case 'M':
 			break;
 		case 'U':
 			test_name = CHECK_KSM_UNMERGE;
 			break;
+		case 'Z':
+			test_name = CHECK_KSM_ZERO_PAGE_MERGE;
+			break;
 		default:
 			return KSFT_FAIL;
 		}
@@ -359,6 +419,10 @@ int main(int argc, char *argv[])
 		ret = check_ksm_unmerge(MAP_PRIVATE | MAP_ANONYMOUS, prot, ksm_scan_limit_sec,
 					page_size);
 		break;
+	case CHECK_KSM_ZERO_PAGE_MERGE:
+		ret = check_ksm_zero_page_merge(MAP_PRIVATE | MAP_ANONYMOUS, prot, page_count,
+						ksm_scan_limit_sec, use_zero_pages, page_size);
+		break;
 	}
 
 	if (ksm_restore(&ksm_sysfs_old)) {
diff --git a/tools/testing/selftests/vm/run_vmtests.sh b/tools/testing/selftests/vm/run_vmtests.sh
index 3a23c6b47da2..9b4e444fc4ed 100755
--- a/tools/testing/selftests/vm/run_vmtests.sh
+++ b/tools/testing/selftests/vm/run_vmtests.sh
@@ -409,6 +409,38 @@ else
 	exitcode=1
 fi
 
+echo "----------------------------------------------------------"
+echo "running KSM test with 10 zero pages and use_zero_pages = 0"
+echo "----------------------------------------------------------"
+./ksm_tests -Z -p 10 -z 0
+ret_val=$?
+
+if [ $ret_val -eq 0 ]; then
+	echo "[PASS]"
+elif [ $ret_val -eq $ksft_skip ]; then
+	 echo "[SKIP]"
+	 exitcode=$ksft_skip
+else
+	echo "[FAIL]"
+	exitcode=1
+fi
+
+echo "----------------------------------------------------------"
+echo "running KSM test with 10 zero pages and use_zero_pages = 1"
+echo "----------------------------------------------------------"
+./ksm_tests -Z -p 10 -z 1
+ret_val=$?
+
+if [ $ret_val -eq 0 ]; then
+	echo "[PASS]"
+elif [ $ret_val -eq $ksft_skip ]; then
+	 echo "[SKIP]"
+	 exitcode=$ksft_skip
+else
+	echo "[FAIL]"
+	exitcode=1
+fi
+
 exit $exitcode
 
 exit $exitcode
-- 
2.25.1

