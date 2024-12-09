Return-Path: <linux-kselftest+bounces-23060-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A0F69E9EB6
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Dec 2024 20:01:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 598F01885409
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Dec 2024 19:01:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9151C19884C;
	Mon,  9 Dec 2024 18:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=usama.anjum@collabora.com header.b="U9e8g75w"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71FB6197A6C;
	Mon,  9 Dec 2024 18:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733770613; cv=pass; b=qjzeoRqhIPTFaC9ev4YqDQMwbUhRHAVXluPh39n5Krd8pFu2P/UhU/4YwVmeYmsb1thZM2NFevVlKmH3cAuLIWU3RP30Ron7g1wf4YJvayeeA2bl9VbJsn1GabHDNo5L31xqmVOQTKtA+MPo+KJiFC/xlKoUiCBcXtTBjnY7cxY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733770613; c=relaxed/simple;
	bh=siOE05gT8UbPUM8Bt6LrjhMIQKh7T9MFgGIINEDE/bc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=a8C/nUrljl44r2iAU0Kbhx28MNwdYPyJnEONQ3YIAdGSDUQiUnvG8o38nrISAJFAD1789NRv7BoKaSNDT9FTy0OgOmDg/uC4lhu4WHbhwtTeTNdBR6G8QkTdllLXTWcKw9OoXbcAvL+vqDHeUP1pFKKs49hHE8EeLR5acT7+wP8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=usama.anjum@collabora.com header.b=U9e8g75w; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1733770592; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=MwLLJKsuXlpyt6yX0IIG/ksXCghviOr07JiPcVodaCffEbGUPMpOO7XqSYvsa7Th7LgCBCbl46pi7Cg+yK5e8UQid68DlGt8KJgf2tSMZooHbGXHlQ4rhdqB2oRe8PA8ZGeEndSSfS1QrmnmGLlctvqxZzxVQYhWGXc0ffcPo5g=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1733770592; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Aa6Ev6AdlAGuu46ziJ8I8hrGYJJJOdRZ2Ry7xCMJsog=; 
	b=TM9NXJ3sua27JA6aLDs/FZQ4Gw82kWePmchroak8WTABfH0UfDZNv+NkL6XWP3xTtBBpjh+I0HZjK9lsGu4XgFo1g3uKgYXKZsKszKHvJg++aMotp/UsDb+NMwbYp3aPy1zNJCpQYywhHTYWyO3hp5sWBwdnp6y8zjhUzF2+SSA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=usama.anjum@collabora.com;
	dmarc=pass header.from=<usama.anjum@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1733770592;
	s=zohomail; d=collabora.com; i=usama.anjum@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=Aa6Ev6AdlAGuu46ziJ8I8hrGYJJJOdRZ2Ry7xCMJsog=;
	b=U9e8g75w1h6jOjgRb7Ii4MnYLxZP9E0p7TaDAi6JlxJZvK5TCebgI4PfC4lLqRLu
	0MaeUlLOPVKSoXIqYByaCxHV4vSd6tUBZAKwLTgiirKkYDcEYVIJstvPE+sSETC6e/2
	I6Ox6K/ahu9Vhr4B29DTHaPZo9IoToEqpea/ojlw=
Received: by mx.zohomail.com with SMTPS id 1733770591245682.5886911099266;
	Mon, 9 Dec 2024 10:56:31 -0800 (PST)
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	David Hildenbrand <david@redhat.com>,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
	kernel@collabora.com
Subject: [PATCH 2/4] selftests/mm: pagemap_ioctl: Fix types mismatches shown by compiler options
Date: Mon,  9 Dec 2024 23:56:22 +0500
Message-Id: <20241209185624.2245158-3-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241209185624.2245158-1-usama.anjum@collabora.com>
References: <20241209185624.2245158-1-usama.anjum@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Fix following warnings caught by compiler:
- There are several type mismatches among different variables.
- Remove unused variable warnings.

Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
 tools/testing/selftests/mm/pagemap_ioctl.c | 108 +++++++++++----------
 tools/testing/selftests/mm/vm_util.c       |   2 +-
 2 files changed, 59 insertions(+), 51 deletions(-)

diff --git a/tools/testing/selftests/mm/pagemap_ioctl.c b/tools/testing/selftests/mm/pagemap_ioctl.c
index fdafce0654e90..57b4bba2b45f3 100644
--- a/tools/testing/selftests/mm/pagemap_ioctl.c
+++ b/tools/testing/selftests/mm/pagemap_ioctl.c
@@ -34,8 +34,8 @@
 #define PAGEMAP "/proc/self/pagemap"
 int pagemap_fd;
 int uffd;
-int page_size;
-int hpage_size;
+unsigned int page_size;
+unsigned int hpage_size;
 const char *progname;
 
 #define LEN(region)	((region.end - region.start)/page_size)
@@ -235,7 +235,9 @@ int get_reads(struct page_region *vec, int vec_size)
 
 int sanity_tests_sd(void)
 {
-	int mem_size, vec_size, ret, ret2, ret3, i, num_pages = 1000, total_pages = 0;
+	unsigned long long mem_size, vec_size, i, total_pages = 0;
+	long ret, ret2, ret3;
+	int num_pages = 1000;
 	int total_writes, total_reads, reads, count;
 	struct page_region *vec, *vec2;
 	char *mem, *m[2];
@@ -321,9 +323,9 @@ int sanity_tests_sd(void)
 	ret = pagemap_ioctl(mem, mem_size, vec, vec_size, 0, 0, PAGE_IS_WRITTEN, 0,
 			    0, PAGE_IS_WRITTEN);
 	if (ret < 0)
-		ksft_exit_fail_msg("error %d %d %s\n", ret, errno, strerror(errno));
+		ksft_exit_fail_msg("error %ld %d %s\n", ret, errno, strerror(errno));
 
-	ksft_test_result(ret == mem_size/(page_size * 2),
+	ksft_test_result((unsigned long long)ret == mem_size/(page_size * 2),
 			 "%s Repeated pattern of written and non-written pages\n", __func__);
 
 	/* 4. Repeated pattern of written and non-written pages in parts */
@@ -331,21 +333,21 @@ int sanity_tests_sd(void)
 			    PM_SCAN_WP_MATCHING | PM_SCAN_CHECK_WPASYNC,
 			    num_pages/2 - 2, PAGE_IS_WRITTEN, 0, 0, PAGE_IS_WRITTEN);
 	if (ret < 0)
-		ksft_exit_fail_msg("error %d %d %s\n", ret, errno, strerror(errno));
+		ksft_exit_fail_msg("error %ld %d %s\n", ret, errno, strerror(errno));
 
 	ret2 = pagemap_ioctl(mem, mem_size, vec, 2, 0, 0, PAGE_IS_WRITTEN, 0, 0,
 			     PAGE_IS_WRITTEN);
 	if (ret2 < 0)
-		ksft_exit_fail_msg("error %d %d %s\n", ret2, errno, strerror(errno));
+		ksft_exit_fail_msg("error %ld %d %s\n", ret2, errno, strerror(errno));
 
 	ret3 = pagemap_ioctl(mem, mem_size, vec, vec_size,
 			     PM_SCAN_WP_MATCHING | PM_SCAN_CHECK_WPASYNC,
 			     0, PAGE_IS_WRITTEN, 0, 0, PAGE_IS_WRITTEN);
 	if (ret3 < 0)
-		ksft_exit_fail_msg("error %d %d %s\n", ret3, errno, strerror(errno));
+		ksft_exit_fail_msg("error %ld %d %s\n", ret3, errno, strerror(errno));
 
 	ksft_test_result((ret + ret3) == num_pages/2 && ret2 == 2,
-			 "%s Repeated pattern of written and non-written pages in parts %d %d %d\n",
+			 "%s Repeated pattern of written and non-written pages in parts %ld %ld %ld\n",
 			 __func__, ret, ret3, ret2);
 
 	/* 5. Repeated pattern of written and non-written pages max_pages */
@@ -357,13 +359,13 @@ int sanity_tests_sd(void)
 			    PM_SCAN_WP_MATCHING | PM_SCAN_CHECK_WPASYNC,
 			    num_pages/2, PAGE_IS_WRITTEN, 0, 0, PAGE_IS_WRITTEN);
 	if (ret < 0)
-		ksft_exit_fail_msg("error %d %d %s\n", ret, errno, strerror(errno));
+		ksft_exit_fail_msg("error %ld %d %s\n", ret, errno, strerror(errno));
 
 	ret2 = pagemap_ioctl(mem, mem_size, vec, vec_size,
 			     PM_SCAN_WP_MATCHING | PM_SCAN_CHECK_WPASYNC,
 			     0, PAGE_IS_WRITTEN, 0, 0, PAGE_IS_WRITTEN);
 	if (ret2 < 0)
-		ksft_exit_fail_msg("error %d %d %s\n", ret2, errno, strerror(errno));
+		ksft_exit_fail_msg("error %ld %d %s\n", ret2, errno, strerror(errno));
 
 	ksft_test_result(ret == num_pages/2 && ret2 == 1,
 			 "%s Repeated pattern of written and non-written pages max_pages\n",
@@ -378,12 +380,12 @@ int sanity_tests_sd(void)
 			    PM_SCAN_WP_MATCHING | PM_SCAN_CHECK_WPASYNC,
 			    2, PAGE_IS_WRITTEN, 0, 0, PAGE_IS_WRITTEN);
 	if (ret < 0)
-		ksft_exit_fail_msg("error %d %d %s\n", ret, errno, strerror(errno));
+		ksft_exit_fail_msg("error %ld %d %s\n", ret, errno, strerror(errno));
 
 	ret2 = pagemap_ioctl(mem, mem_size, vec2, vec_size, 0, 0,
 			      PAGE_IS_WRITTEN, 0, 0, PAGE_IS_WRITTEN);
 	if (ret2 < 0)
-		ksft_exit_fail_msg("error %d %d %s\n", ret2, errno, strerror(errno));
+		ksft_exit_fail_msg("error %ld %d %s\n", ret2, errno, strerror(errno));
 
 	ksft_test_result(ret == 1 && LEN(vec[0]) == 2 &&
 			 vec[0].start == (uintptr_t)(mem + page_size) &&
@@ -416,7 +418,7 @@ int sanity_tests_sd(void)
 	ret = pagemap_ioctl(m[1], mem_size, vec, 1, 0, 0, PAGE_IS_WRITTEN, 0, 0,
 			    PAGE_IS_WRITTEN);
 	if (ret < 0)
-		ksft_exit_fail_msg("error %d %d %s\n", ret, errno, strerror(errno));
+		ksft_exit_fail_msg("error %ld %d %s\n", ret, errno, strerror(errno));
 
 	ksft_test_result(ret == 1 && LEN(vec[0]) == mem_size/page_size,
 			 "%s Two regions\n", __func__);
@@ -448,7 +450,7 @@ int sanity_tests_sd(void)
 			    PM_SCAN_WP_MATCHING | PM_SCAN_CHECK_WPASYNC, 0,
 			    PAGE_IS_WRITTEN, 0, 0, PAGE_IS_WRITTEN);
 	if (ret < 0)
-		ksft_exit_fail_msg("error %d %d %s\n", ret, errno, strerror(errno));
+		ksft_exit_fail_msg("error %ld %d %s\n", ret, errno, strerror(errno));
 
 	for (i = 0; i < mem_size/page_size; i += 2)
 		mem[i * page_size]++;
@@ -457,7 +459,7 @@ int sanity_tests_sd(void)
 			    PM_SCAN_WP_MATCHING | PM_SCAN_CHECK_WPASYNC,
 			    mem_size/(page_size*5), PAGE_IS_WRITTEN, 0, 0, PAGE_IS_WRITTEN);
 	if (ret < 0)
-		ksft_exit_fail_msg("error %d %d %s\n", ret, errno, strerror(errno));
+		ksft_exit_fail_msg("error %ld %d %s\n", ret, errno, strerror(errno));
 
 	total_pages += ret;
 
@@ -465,7 +467,7 @@ int sanity_tests_sd(void)
 			    PM_SCAN_WP_MATCHING | PM_SCAN_CHECK_WPASYNC,
 			    mem_size/(page_size*5), PAGE_IS_WRITTEN, 0, 0, PAGE_IS_WRITTEN);
 	if (ret < 0)
-		ksft_exit_fail_msg("error %d %d %s\n", ret, errno, strerror(errno));
+		ksft_exit_fail_msg("error %ld %d %s\n", ret, errno, strerror(errno));
 
 	total_pages += ret;
 
@@ -473,7 +475,7 @@ int sanity_tests_sd(void)
 			    PM_SCAN_WP_MATCHING | PM_SCAN_CHECK_WPASYNC,
 			    mem_size/(page_size*5), PAGE_IS_WRITTEN, 0, 0, PAGE_IS_WRITTEN);
 	if (ret < 0)
-		ksft_exit_fail_msg("error %d %d %s\n", ret, errno, strerror(errno));
+		ksft_exit_fail_msg("error %ld %d %s\n", ret, errno, strerror(errno));
 
 	total_pages += ret;
 
@@ -515,9 +517,9 @@ int sanity_tests_sd(void)
 					  vec_size, PM_SCAN_WP_MATCHING | PM_SCAN_CHECK_WPASYNC,
 					  0, PAGE_IS_WRITTEN, 0, 0, PAGE_IS_WRITTEN, &walk_end);
 			if (ret < 0)
-				ksft_exit_fail_msg("error %d %d %s\n", ret, errno, strerror(errno));
+				ksft_exit_fail_msg("error %ld %d %s\n", ret, errno, strerror(errno));
 
-			if (ret > vec_size)
+			if ((unsigned long)ret > vec_size)
 				break;
 
 			reads = get_reads(vec, ret);
@@ -554,63 +556,63 @@ int sanity_tests_sd(void)
 	ret = pagemap_ioc(mem, 0, vec, vec_size, 0,
 			  0, PAGE_IS_WRITTEN, 0, 0, PAGE_IS_WRITTEN, &walk_end);
 	if (ret < 0)
-		ksft_exit_fail_msg("error %d %d %s\n", ret, errno, strerror(errno));
+		ksft_exit_fail_msg("error %ld %d %s\n", ret, errno, strerror(errno));
 	ksft_test_result(ret == 0 && walk_end == (long)mem,
 			 "Walk_end: Same start and end address\n");
 
 	ret = pagemap_ioc(mem, 0, vec, vec_size, PM_SCAN_WP_MATCHING | PM_SCAN_CHECK_WPASYNC,
 			  0, PAGE_IS_WRITTEN, 0, 0, PAGE_IS_WRITTEN, &walk_end);
 	if (ret < 0)
-		ksft_exit_fail_msg("error %d %d %s\n", ret, errno, strerror(errno));
+		ksft_exit_fail_msg("error %ld %d %s\n", ret, errno, strerror(errno));
 	ksft_test_result(ret == 0 && walk_end == (long)mem,
 			 "Walk_end: Same start and end with WP\n");
 
 	ret = pagemap_ioc(mem, 0, vec, 0, PM_SCAN_WP_MATCHING | PM_SCAN_CHECK_WPASYNC,
 			  0, PAGE_IS_WRITTEN, 0, 0, PAGE_IS_WRITTEN, &walk_end);
 	if (ret < 0)
-		ksft_exit_fail_msg("error %d %d %s\n", ret, errno, strerror(errno));
+		ksft_exit_fail_msg("error %ld %d %s\n", ret, errno, strerror(errno));
 	ksft_test_result(ret == 0 && walk_end == (long)mem,
 			 "Walk_end: Same start and end with 0 output buffer\n");
 
 	ret = pagemap_ioc(mem, mem_size, vec, vec_size, 0,
 			  0, PAGE_IS_WRITTEN, 0, 0, PAGE_IS_WRITTEN, &walk_end);
 	if (ret < 0)
-		ksft_exit_fail_msg("error %d %d %s\n", ret, errno, strerror(errno));
+		ksft_exit_fail_msg("error %ld %d %s\n", ret, errno, strerror(errno));
 	ksft_test_result(ret == 1 && walk_end == (long)(mem + mem_size),
 			 "Walk_end: Big vec\n");
 
 	ret = pagemap_ioc(mem, mem_size, vec, 1, 0,
 			  0, PAGE_IS_WRITTEN, 0, 0, PAGE_IS_WRITTEN, &walk_end);
 	if (ret < 0)
-		ksft_exit_fail_msg("error %d %d %s\n", ret, errno, strerror(errno));
+		ksft_exit_fail_msg("error %ld %d %s\n", ret, errno, strerror(errno));
 	ksft_test_result(ret == 1 && walk_end == (long)(mem + mem_size),
 			 "Walk_end: vec of minimum length\n");
 
 	ret = pagemap_ioc(mem, mem_size, vec, 1, 0,
 			  vec_size, PAGE_IS_WRITTEN, 0, 0, PAGE_IS_WRITTEN, &walk_end);
 	if (ret < 0)
-		ksft_exit_fail_msg("error %d %d %s\n", ret, errno, strerror(errno));
+		ksft_exit_fail_msg("error %ld %d %s\n", ret, errno, strerror(errno));
 	ksft_test_result(ret == 1 && walk_end == (long)(mem + mem_size),
 			 "Walk_end: Max pages specified\n");
 
 	ret = pagemap_ioc(mem, mem_size, vec, vec_size, 0,
 			  vec_size/2, PAGE_IS_WRITTEN, 0, 0, PAGE_IS_WRITTEN, &walk_end);
 	if (ret < 0)
-		ksft_exit_fail_msg("error %d %d %s\n", ret, errno, strerror(errno));
+		ksft_exit_fail_msg("error %ld %d %s\n", ret, errno, strerror(errno));
 	ksft_test_result(ret == 1 && walk_end == (long)(mem + mem_size/2),
 			 "Walk_end: Half max pages\n");
 
 	ret = pagemap_ioc(mem, mem_size, vec, vec_size, 0,
 			  1, PAGE_IS_WRITTEN, 0, 0, PAGE_IS_WRITTEN, &walk_end);
 	if (ret < 0)
-		ksft_exit_fail_msg("error %d %d %s\n", ret, errno, strerror(errno));
+		ksft_exit_fail_msg("error %ld %d %s\n", ret, errno, strerror(errno));
 	ksft_test_result(ret == 1 && walk_end == (long)(mem + page_size),
 			 "Walk_end: 1 max page\n");
 
 	ret = pagemap_ioc(mem, mem_size, vec, vec_size, 0,
 			  -1, PAGE_IS_WRITTEN, 0, 0, PAGE_IS_WRITTEN, &walk_end);
 	if (ret < 0)
-		ksft_exit_fail_msg("error %d %d %s\n", ret, errno, strerror(errno));
+		ksft_exit_fail_msg("error %ld %d %s\n", ret, errno, strerror(errno));
 	ksft_test_result(ret == 1 && walk_end == (long)(mem + mem_size),
 			 "Walk_end: max pages\n");
 
@@ -621,49 +623,49 @@ int sanity_tests_sd(void)
 	ret = pagemap_ioc(mem, mem_size, vec, vec_size, 0,
 			  0, PAGE_IS_WRITTEN, 0, 0, PAGE_IS_WRITTEN, &walk_end);
 	if (ret < 0)
-		ksft_exit_fail_msg("error %d %d %s\n", ret, errno, strerror(errno));
-	ksft_test_result(ret == vec_size/2 && walk_end == (long)(mem + mem_size),
+		ksft_exit_fail_msg("error %ld %d %s\n", ret, errno, strerror(errno));
+	ksft_test_result((unsigned long)ret == vec_size/2 && walk_end == (long)(mem + mem_size),
 			 "Walk_end sparse: Big vec\n");
 
 	ret = pagemap_ioc(mem, mem_size, vec, 1, 0,
 			  0, PAGE_IS_WRITTEN, 0, 0, PAGE_IS_WRITTEN, &walk_end);
 	if (ret < 0)
-		ksft_exit_fail_msg("error %d %d %s\n", ret, errno, strerror(errno));
+		ksft_exit_fail_msg("error %ld %d %s\n", ret, errno, strerror(errno));
 	ksft_test_result(ret == 1 && walk_end == (long)(mem + page_size * 2),
 			 "Walk_end sparse: vec of minimum length\n");
 
 	ret = pagemap_ioc(mem, mem_size, vec, 1, 0,
 			  vec_size, PAGE_IS_WRITTEN, 0, 0, PAGE_IS_WRITTEN, &walk_end);
 	if (ret < 0)
-		ksft_exit_fail_msg("error %d %d %s\n", ret, errno, strerror(errno));
+		ksft_exit_fail_msg("error %ld %d %s\n", ret, errno, strerror(errno));
 	ksft_test_result(ret == 1 && walk_end == (long)(mem + page_size * 2),
 			 "Walk_end sparse: Max pages specified\n");
 
 	ret = pagemap_ioc(mem, mem_size, vec, vec_size/2, 0,
 			  vec_size, PAGE_IS_WRITTEN, 0, 0, PAGE_IS_WRITTEN, &walk_end);
 	if (ret < 0)
-		ksft_exit_fail_msg("error %d %d %s\n", ret, errno, strerror(errno));
-	ksft_test_result(ret == vec_size/2 && walk_end == (long)(mem + mem_size),
+		ksft_exit_fail_msg("error %ld %d %s\n", ret, errno, strerror(errno));
+	ksft_test_result((unsigned long)ret == vec_size/2 && walk_end == (long)(mem + mem_size),
 			 "Walk_end sparse: Max pages specified\n");
 
 	ret = pagemap_ioc(mem, mem_size, vec, vec_size, 0,
 			  vec_size, PAGE_IS_WRITTEN, 0, 0, PAGE_IS_WRITTEN, &walk_end);
 	if (ret < 0)
-		ksft_exit_fail_msg("error %d %d %s\n", ret, errno, strerror(errno));
-	ksft_test_result(ret == vec_size/2 && walk_end == (long)(mem + mem_size),
+		ksft_exit_fail_msg("error %ld %d %s\n", ret, errno, strerror(errno));
+	ksft_test_result((unsigned long)ret == vec_size/2 && walk_end == (long)(mem + mem_size),
 			 "Walk_end sparse: Max pages specified\n");
 
 	ret = pagemap_ioc(mem, mem_size, vec, vec_size, 0,
 			  vec_size/2, PAGE_IS_WRITTEN, 0, 0, PAGE_IS_WRITTEN, &walk_end);
 	if (ret < 0)
-		ksft_exit_fail_msg("error %d %d %s\n", ret, errno, strerror(errno));
-	ksft_test_result(ret == vec_size/2 && walk_end == (long)(mem + mem_size),
+		ksft_exit_fail_msg("error %ld %d %s\n", ret, errno, strerror(errno));
+	ksft_test_result((unsigned long)ret == vec_size/2 && walk_end == (long)(mem + mem_size),
 			 "Walk_endsparse : Half max pages\n");
 
 	ret = pagemap_ioc(mem, mem_size, vec, vec_size, 0,
 			  1, PAGE_IS_WRITTEN, 0, 0, PAGE_IS_WRITTEN, &walk_end);
 	if (ret < 0)
-		ksft_exit_fail_msg("error %d %d %s\n", ret, errno, strerror(errno));
+		ksft_exit_fail_msg("error %ld %d %s\n", ret, errno, strerror(errno));
 	ksft_test_result(ret == 1 && walk_end == (long)(mem + page_size * 2),
 			 "Walk_end: 1 max page\n");
 
@@ -674,9 +676,10 @@ int sanity_tests_sd(void)
 	return 0;
 }
 
-int base_tests(char *prefix, char *mem, int mem_size, int skip)
+int base_tests(char *prefix, char *mem, unsigned long long mem_size, int skip)
 {
-	int vec_size, written;
+	unsigned long long vec_size;
+	int written;
 	struct page_region *vec, *vec2;
 
 	if (skip) {
@@ -799,8 +802,8 @@ int hpage_unit_tests(void)
 	char *map;
 	int ret, ret2;
 	size_t num_pages = 10;
-	int map_size = hpage_size * num_pages;
-	int vec_size = map_size/page_size;
+	unsigned long long map_size = hpage_size * num_pages;
+	unsigned long long vec_size = map_size/page_size;
 	struct page_region *vec, *vec2;
 
 	vec = malloc(sizeof(struct page_region) * vec_size);
@@ -1047,7 +1050,8 @@ static void test_simple(void)
 
 int sanity_tests(void)
 {
-	int mem_size, vec_size, ret, fd, i, buf_size;
+	unsigned long long mem_size, vec_size;
+	int ret, fd, i, buf_size;
 	struct page_region *vec;
 	char *mem, *fmem;
 	struct stat sbuf;
@@ -1312,7 +1316,9 @@ static ssize_t get_dirty_pages_reset(char *mem, unsigned int count,
 {
 	struct pm_scan_arg arg = {0};
 	struct page_region rgns[256];
-	int i, j, cnt, ret;
+	unsigned long long i, j;
+	long ret;
+	int cnt;
 
 	arg.size = sizeof(struct pm_scan_arg);
 	arg.start = (uintptr_t)mem;
@@ -1330,7 +1336,7 @@ static ssize_t get_dirty_pages_reset(char *mem, unsigned int count,
 		ksft_exit_fail_msg("ioctl failed\n");
 
 	cnt = 0;
-	for (i = 0; i < ret; ++i) {
+	for (i = 0; i < (unsigned long)ret; ++i) {
 		if (rgns[i].categories != PAGE_IS_WRITTEN)
 			ksft_exit_fail_msg("wrong flags\n");
 
@@ -1384,9 +1390,10 @@ void *thread_proc(void *mem)
 static void transact_test(int page_size)
 {
 	unsigned int i, count, extra_pages;
+	unsigned int c;
 	pthread_t th;
 	char *mem;
-	int ret, c;
+	int ret;
 
 	if (pthread_barrier_init(&start_barrier, NULL, nthreads + 1))
 		ksft_exit_fail_msg("pthread_barrier_init\n");
@@ -1473,9 +1480,10 @@ static void transact_test(int page_size)
 			      extra_thread_faults);
 }
 
-int main(int argc, char *argv[])
+int main(int __attribute__((unused)) argc, char *argv[])
 {
-	int mem_size, shmid, buf_size, fd, i, ret;
+	int shmid, buf_size, fd, i, ret;
+	unsigned long long mem_size;
 	char *mem, *map, *fmem;
 	struct stat sbuf;
 
diff --git a/tools/testing/selftests/mm/vm_util.c b/tools/testing/selftests/mm/vm_util.c
index d8d0cf04bb57f..7519c9a892f0f 100644
--- a/tools/testing/selftests/mm/vm_util.c
+++ b/tools/testing/selftests/mm/vm_util.c
@@ -138,7 +138,7 @@ void clear_softdirty(void)
 		ksft_exit_fail_msg("opening clear_refs failed\n");
 	ret = write(fd, ctrl, strlen(ctrl));
 	close(fd);
-	if (ret != strlen(ctrl))
+	if (ret != (signed int)strlen(ctrl))
 		ksft_exit_fail_msg("writing clear_refs failed\n");
 }
 
-- 
2.39.5


