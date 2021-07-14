Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4982C3C80C7
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Jul 2021 10:56:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238732AbhGNI7L (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 14 Jul 2021 04:59:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238579AbhGNI7H (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 14 Jul 2021 04:59:07 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2631C061765;
        Wed, 14 Jul 2021 01:56:15 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id u25so2249229ljj.11;
        Wed, 14 Jul 2021 01:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xogZdfZ5fAWhT5MqZVdrJcl3Ex+QNBjotQcofaWqwEY=;
        b=lfOC1wrVjpYFj/rbuCUHDXWX25RLJGDEb5T2CjHdeZdEa7aZ/2fdBxMk0zXRc2AIXo
         ctA1tWKCQUK50jpgLG/uzTdI/T4tNUhAqggCbOjoxN9PzRMX3MiC8Fk1QlW7K4vIrlVI
         /XYEOZeVaPVRtz26/WkE7kFFjQMRMyKHj6VwoQw8DGhKglLGaD/pLWrtvA60kAoB1VB2
         9g/2aSmjb3B5wggDNKPfItVF89VPhVejIUMmbr/V9lTGX3IOFbtrUf0gprNfWEt7CYeY
         MQxcHhw4BwZZ4m3BeRgnCSGATBFouuzHqbMzG3Sz6UvR+CuC1hSQDFe5YyGwaxnDvi3G
         euXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xogZdfZ5fAWhT5MqZVdrJcl3Ex+QNBjotQcofaWqwEY=;
        b=BNzxfn0z2f1rLztuLLanzCaWp+1Y29/o6EkRYuo/unp0F3U31mAqktxKmXQz9OP7hL
         zh3DdbVYCPM0qOq8hnxoPUZboMIyQx+yiSHcyFkunINuFX4+BJe/UsZrlNusEtRkV56u
         d5THJ1TVh0PhpedSSXwUdl+mlcMFdu+pO9TfFVBk6JvFiSRQ91KNgpSbF7Rc3vn7bl/9
         rcXLIIZvi153cG2jjwZeFU4+ejlfH9LqyZh2mMsOTeemDqt7yoAxQfhpFB2RgjS/zlOT
         P5nLrOe+jBoJHqxAIJbt7M5kyJmCCFQqvpNvDgnF6pguwloGFDaDg+qqGchm6r+e+srC
         oc0A==
X-Gm-Message-State: AOAM530NiDOm4usgoZsDaxvSOjhixB39dMyFDz3jlrgAVK5unVAUwnoE
        kncPdgNPzHwj//RHGt3bz9E=
X-Google-Smtp-Source: ABdhPJyEypJaRNtAuT5VzFLvDTkmTw6r8HKZ7KXGVXs+/DUEKANTxp99dVOMxOCNS+6vE5Mq4gbq9Q==
X-Received: by 2002:a2e:82c4:: with SMTP id n4mr8186753ljh.472.1626252974318;
        Wed, 14 Jul 2021 01:56:14 -0700 (PDT)
Received: from asus ([93.95.240.58])
        by smtp.gmail.com with ESMTPSA id x17sm165584ljx.75.2021.07.14.01.56.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 01:56:14 -0700 (PDT)
Date:   Wed, 14 Jul 2021 14:56:09 +0600
From:   Zhansaya Bagdauletkyzy <zhansayabagdaulet@gmail.com>
To:     shuah@kernel.org, akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, tyhicks@linux.microsoft.com,
        pasha.tatashin@soleen.com
Subject: [PATCH v2 2/4] selftests: vm: add KSM unmerge test
Message-ID: <c0f55420440d704d5b094275b4365aa1b2ad46b5.1626252248.git.zhansayabagdaulet@gmail.com>
References: <cover.1626252248.git.zhansayabagdaulet@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1626252248.git.zhansayabagdaulet@gmail.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add check_ksm_unmerge() function to verify that KSM is properly
unmerging shared pages. For this, two duplicate pages are merged first
and then their contents are modified. Since they are not identical
anymore, the pages must be unmerged and the number of merged pages has
to be 0. The test is run as follows: ./ksm_tests -U

Signed-off-by: Zhansaya Bagdauletkyzy <zhansayabagdaulet@gmail.com>
---
 tools/testing/selftests/vm/ksm_tests.c    | 72 +++++++++++++++++++++--
 tools/testing/selftests/vm/run_vmtests.sh | 18 +++++-
 2 files changed, 85 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/vm/ksm_tests.c b/tools/testing/selftests/vm/ksm_tests.c
index d74d5aa34b16..80302bb8f64c 100644
--- a/tools/testing/selftests/vm/ksm_tests.c
+++ b/tools/testing/selftests/vm/ksm_tests.c
@@ -23,6 +23,11 @@ struct ksm_sysfs {
 	unsigned long use_zero_pages;
 };
 
+enum ksm_test_name {
+	CHECK_KSM_MERGE,
+	CHECK_KSM_UNMERGE
+};
+
 static int ksm_write_sysfs(const char *file_path, unsigned long val)
 {
 	FILE *f = fopen(file_path, "w");
@@ -75,7 +80,12 @@ static int str_to_prot(char *prot_str)
 
 static void print_help(void)
 {
-	printf("usage: ksm_tests [-h] [-a prot] [-p page_count] [-l timeout]\n");
+	printf("usage: ksm_tests [-h] <test type> [-a prot] [-p page_count] [-l timeout]\n");
+
+	printf("Supported <test type>:\n"
+	       " -M (page merging)\n"
+	       " -U (page unmerging)\n\n");
+
 	printf(" -a: specify the access protections of pages.\n"
 	       "     <prot> must be of the form [rwx].\n"
 	       "     Default: %s\n", KSM_PROT_STR_DEFAULT);
@@ -239,6 +249,46 @@ static int check_ksm_merge(int mapping, int prot, long page_count, int timeout,
 	return KSFT_FAIL;
 }
 
+static int check_ksm_unmerge(int mapping, int prot, int timeout, size_t page_size)
+{
+	void *map_ptr;
+	struct timespec start_time;
+	int page_count = 2;
+
+	if (clock_gettime(CLOCK_MONOTONIC_RAW, &start_time)) {
+		perror("clock_gettime");
+		return KSFT_FAIL;
+	}
+
+	/* fill pages with the same data and merge them */
+	map_ptr = allocate_memory(NULL, prot, mapping, '*', page_size * page_count);
+	if (!map_ptr)
+		return KSFT_FAIL;
+
+	if (ksm_merge_pages(map_ptr, page_size * page_count, start_time, timeout))
+		goto err_out;
+
+	/* change 1 byte in each of the 2 pages -- KSM must automatically unmerge them */
+	memset(map_ptr, '-', 1);
+	memset(map_ptr + page_size, '+', 1);
+
+	/* get at least 1 scan, so KSM can detect that the pages were modified */
+	if (ksm_do_scan(1, start_time, timeout))
+		goto err_out;
+
+	/* check that unmerging was successful and 0 pages are currently merged */
+	if (assert_ksm_pages_count(0)) {
+		printf("OK\n");
+		munmap(map_ptr, page_size * page_count);
+		return KSFT_PASS;
+	}
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
@@ -247,8 +297,9 @@ int main(int argc, char *argv[])
 	long page_count = KSM_PAGE_COUNT_DEFAULT;
 	size_t page_size = sysconf(_SC_PAGESIZE);
 	struct ksm_sysfs ksm_sysfs_old;
+	int test_name = CHECK_KSM_MERGE;
 
-	while ((opt = getopt(argc, argv, "ha:p:l:")) != -1) {
+	while ((opt = getopt(argc, argv, "ha:p:l:MU")) != -1) {
 		switch (opt) {
 		case 'a':
 			prot = str_to_prot(optarg);
@@ -270,6 +321,11 @@ int main(int argc, char *argv[])
 		case 'h':
 			print_help();
 			break;
+		case 'M':
+			break;
+		case 'U':
+			test_name = CHECK_KSM_UNMERGE;
+			break;
 		default:
 			return KSFT_FAIL;
 		}
@@ -294,8 +350,16 @@ int main(int argc, char *argv[])
 	    ksm_write_sysfs(KSM_FP("pages_to_scan"), page_count))
 		return KSFT_FAIL;
 
-	ret = check_ksm_merge(MAP_PRIVATE | MAP_ANONYMOUS, prot, page_count, ksm_scan_limit_sec,
-			      page_size);
+	switch (test_name) {
+	case CHECK_KSM_MERGE:
+		ret = check_ksm_merge(MAP_PRIVATE | MAP_ANONYMOUS, prot, page_count,
+				      ksm_scan_limit_sec, page_size);
+		break;
+	case CHECK_KSM_UNMERGE:
+		ret = check_ksm_unmerge(MAP_PRIVATE | MAP_ANONYMOUS, prot, ksm_scan_limit_sec,
+					page_size);
+		break;
+	}
 
 	if (ksm_restore(&ksm_sysfs_old)) {
 		printf("Cannot restore default tunables\n");
diff --git a/tools/testing/selftests/vm/run_vmtests.sh b/tools/testing/selftests/vm/run_vmtests.sh
index 97b6f712134d..3a23c6b47da2 100755
--- a/tools/testing/selftests/vm/run_vmtests.sh
+++ b/tools/testing/selftests/vm/run_vmtests.sh
@@ -380,7 +380,23 @@ fi
 echo "-------------------------------------------------------"
 echo "running KSM MADV_MERGEABLE test with 10 identical pages"
 echo "-------------------------------------------------------"
-./ksm_tests -p 10
+./ksm_tests -M -p 10
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
+echo "------------------------"
+echo "running KSM unmerge test"
+echo "------------------------"
+./ksm_tests -U
 ret_val=$?
 
 if [ $ret_val -eq 0 ]; then
-- 
2.25.1

