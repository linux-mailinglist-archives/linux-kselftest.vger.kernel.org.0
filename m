Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 592283F1CE2
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Aug 2021 17:33:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240423AbhHSPe0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 19 Aug 2021 11:34:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239964AbhHSPeY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 19 Aug 2021 11:34:24 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A96ECC061756;
        Thu, 19 Aug 2021 08:33:47 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id y34so13826091lfa.8;
        Thu, 19 Aug 2021 08:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=M9TwSY87XAPhsvv2+xxIfYeMLjCXKXv7wr0r+bI19IM=;
        b=Auj5nFOfwnF84p9IhpQf8B73+bLc3JiaXgIxjEJZW5fxWmo/rTvcApGRzrv3vs4wTD
         TcTBbH+b+cWPao9aAWdTy4bN8usIV34VvtzdUIr5bwQD+CE9BqksH6vq+sLxB+pIo0sB
         LURT5mNVW18p5vX8O2aXysrvxllRFVLlqPMjENJwWlbatLbwsi8BieJ9THdDWtEJA4hy
         pZjbw4x/vpAybpJ1z9hHelA5A1be2UTr46QhraFKcSbGkedx7zW6BfKgdnWqyLLxT4s/
         TMFuXx7UHe1HPfWP5dRdZt885pvbJGUaK8+wNhrnsRD/mBbERR1ggb3Xsp5Jc2THAH8/
         1wRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=M9TwSY87XAPhsvv2+xxIfYeMLjCXKXv7wr0r+bI19IM=;
        b=JvkXJfdMGLMQbO9vJbSP2NP2lFEjSaANOcIcJ/WPJjjYv4omUaR+Sdr19uUPna1Tg7
         fcquzhoIi5n2nEakmAvIoJ0qr/rqzFl3P0zhYZNnEt0BsbvNc8Aw/Ip0PkHb3b7eNQCE
         HiKxGj+hJHCfIFth5xGRrySAxb/FCP46e1VtLcpxiFr17zcsjlbTk28bCDTO9trbt5sC
         j/rhnzsQ/SH8OiE1qm0adLFuXlsbtgIICLzEBsaJVKkj5bnPu/reKqWwgJZvEHnehkGZ
         cbDItHIgStnpcUnAyQ16ZXKoNPq2Ot5nU4WjZHk69GwXUkBIfsvimgBLrBrJe+yJTbh6
         cRZw==
X-Gm-Message-State: AOAM532o9LcwUBCcJwk2XvN4jRKMKL7OTK++I3ZonwMt4WlSH2e08vQQ
        AcdGFbLGZ1ga0J9UbFDPjGc=
X-Google-Smtp-Source: ABdhPJwV83dZgXtO9SqMV+K96TQ39E7SH5UJ/EaqM3sJRcQn6I+4i3Lbsb8UskmduXxAVGb4vS88sw==
X-Received: by 2002:a05:6512:3f9f:: with SMTP id x31mr10682570lfa.245.1629387226058;
        Thu, 19 Aug 2021 08:33:46 -0700 (PDT)
Received: from asus ([147.30.82.254])
        by smtp.gmail.com with ESMTPSA id u3sm281964lju.107.2021.08.19.08.33.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Aug 2021 08:33:45 -0700 (PDT)
Date:   Thu, 19 Aug 2021 21:33:43 +0600
From:   Zhansaya Bagdauletkyzy <zhansayabagdaulet@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, tyhicks@linux.microsoft.com,
        pasha.tatashin@soleen.com
Subject: [PATCH v3 2/2] selftests: vm: add COW time test for KSM pages
Message-ID: <1d03ee0d1b341959d4b61672c6401d498bff5652.1629386192.git.zhansayabagdaulet@gmail.com>
References: <cover.1629386192.git.zhansayabagdaulet@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1629386192.git.zhansayabagdaulet@gmail.com>
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
	Total time:     0.002185489 s
	Average speed:  3202.945 MiB/s

	Merged pages:
	Total time:     0.004386872 s
	Average speed:  1595.670 MiB/s

Signed-off-by: Zhansaya Bagdauletkyzy <zhansayabagdaulet@gmail.com>
---
v2 -> v3:
 - address Tyler's feedback

Tyler's comments: https://lkml.org/lkml/2021/8/16/931

v1 -> v2:
 As suggested by Pavel,
 - add baseline figures with non-shared pages
 - instead of having all pages merged together, create pairs of
   duplicated pages

Pavel's comments: https://lkml.org/lkml/2021/8/3/1363

 tools/testing/selftests/vm/ksm_tests.c | 86 +++++++++++++++++++++++++-
 1 file changed, 83 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/vm/ksm_tests.c b/tools/testing/selftests/vm/ksm_tests.c
index 432dfe615e50..c14927417759 100644
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
@@ -455,6 +457,77 @@ static int ksm_merge_time(int mapping, int prot, int timeout, size_t map_size)
 	return KSFT_FAIL;
 }
 
+static int ksm_cow_time(int mapping, int prot, int timeout, size_t page_size)
+{
+	void *map_ptr;
+	struct timespec start_time, end_time;
+	unsigned long cow_time_ns;
+
+	/* page_count must be less than 2*page_size */
+	size_t page_count = 4000;
+
+	map_ptr = allocate_memory(NULL, prot, mapping, '*', page_size * page_count);
+	if (!map_ptr)
+		return KSFT_FAIL;
+
+	if (clock_gettime(CLOCK_MONOTONIC_RAW, &start_time)) {
+		perror("clock_gettime");
+		return KSFT_FAIL;
+	}
+	for (size_t i = 0; i < page_count - 1; i = i + 2)
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
+	/* Create 2000 pairs of duplicate pages */
+	for (size_t i = 0; i < page_count - 1; i = i + 2) {
+		memset(map_ptr + page_size * i, '+', i / 2 + 1);
+		memset(map_ptr + page_size * (i + 1), '+', i / 2 + 1);
+	}
+	if (ksm_merge_pages(map_ptr, page_size * page_count, start_time, timeout))
+		goto err_out;
+
+	if (clock_gettime(CLOCK_MONOTONIC_RAW, &start_time)) {
+		perror("clock_gettime");
+		goto err_out;
+	}
+	for (size_t i = 0; i < page_count - 1; i = i + 2)
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
@@ -468,7 +541,7 @@ int main(int argc, char *argv[])
 	bool merge_across_nodes = KSM_MERGE_ACROSS_NODES_DEFAULT;
 	long size_MB = 0;
 
-	while ((opt = getopt(argc, argv, "ha:p:l:z:m:s:MUZNP")) != -1) {
+	while ((opt = getopt(argc, argv, "ha:p:l:z:m:s:MUZNPC")) != -1) {
 		switch (opt) {
 		case 'a':
 			prot = str_to_prot(optarg);
@@ -522,6 +595,9 @@ int main(int argc, char *argv[])
 		case 'P':
 			test_name = KSM_MERGE_TIME;
 			break;
+		case 'C':
+			test_name = KSM_COW_TIME;
+			break;
 		default:
 			return KSFT_FAIL;
 		}
@@ -571,6 +647,10 @@ int main(int argc, char *argv[])
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

