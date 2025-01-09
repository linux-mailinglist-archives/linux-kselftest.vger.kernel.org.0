Return-Path: <linux-kselftest+bounces-24142-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AEB2A07EF2
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Jan 2025 18:40:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B68116859E
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Jan 2025 17:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F33D1953BD;
	Thu,  9 Jan 2025 17:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=usama.anjum@collabora.com header.b="jZBwCQLG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C6DB191F83;
	Thu,  9 Jan 2025 17:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736444369; cv=pass; b=QY+kTHALOdMP0WkWOgSj4peL+c2fff3mYdWDtgIxXR80eLvari8uudxjtmQVIHk2iBnc1c+E0Z1rdAL/olcnJRUjMpfO9rDYJRBlG0eyuGB31RQeRobehv3LjicUt9vyiS0HY+kyDPtcscaNOlBz4SPv7yk+8lpPK+Iqeous6kA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736444369; c=relaxed/simple;
	bh=dMj0sy0YSVnlCxQmc/t4dFNEI9VrrWmASdc9jq3wOo8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pIhS0itrDWxTnne68o82CepJZ3sKC9cktzWxtcdeYcjqZfzBse2Ifvr9T5aCRLeoNNGipS/nISZMV0PthDs4fA++H/VF+RZMmrBLitB00tHh24HEMyfp6+7xusKUOdcOPppcPEt0UULbW6V9WSJ6zUiG+e8UlErVPbCO8yuAYv8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=usama.anjum@collabora.com header.b=jZBwCQLG; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1736444349; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=HHkqer9D9jOpYsHxWEyHRpi13jplxxgtYJDH71wMARrdu73i7SG/Bwa2BnWYvhh5j1T1bDGGM81c+M8H/isTROi8mXFAjDjAcTAYH6c4CNY+OTAd62wZ44V26E/4wGjzIsGQmtCvxQuldUR0wUEVcGloHhwKuiD+P0ZstplSFrU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1736444349; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=eJgiI6Vx5zFOc8jFmmCKCG1szUd46kqPcPMGhbEUP04=; 
	b=NEs77iCxdncBgju4MXnwU0ozZeijflfvDge8zUAoe5UCgkq1X3PSJQUpglLYwQD/8l44guCeHnXLzSiJeSg7PBR0VhgPrYur2w+Z4PynY317ysyW/2ytmRnnNNGC+xTmCXeSwGqVwvU2sDh+7tuUqyaTyjk8V8xQLSd5UoQsTnA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=usama.anjum@collabora.com;
	dmarc=pass header.from=<usama.anjum@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1736444349;
	s=zohomail; d=collabora.com; i=usama.anjum@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=eJgiI6Vx5zFOc8jFmmCKCG1szUd46kqPcPMGhbEUP04=;
	b=jZBwCQLGCsVNAzEP5uALr00gMia10ZsyrVMFVizansqMMAt9eckT3AfdkjHHKlWi
	0uFx9Fbnehzcxvk4GpExok1AWpkkYgfEBO+UzhhOjZxdeyZOnmuObiTXT/kP2miLyw4
	eFzMHGY0U8dg8EMFxKnjozg0GX29Kf8d9Yv66s5Y=
Received: by mx.zohomail.com with SMTPS id 1736444346808142.8966002616171;
	Thu, 9 Jan 2025 09:39:06 -0800 (PST)
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
To: Kees Cook <kees@kernel.org>,
	Andy Lutomirski <luto@amacapital.net>,
	Will Drewry <wad@chromium.org>,
	Shuah Khan <shuah@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	=?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
	kernel@collabora.com
Subject: [PATCH 04/16] selftests/mm: Fix type mismatch warnings
Date: Thu,  9 Jan 2025 22:38:30 +0500
Message-Id: <20250109173842.1142376-5-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250109173842.1142376-1-usama.anjum@collabora.com>
References: <20250109173842.1142376-1-usama.anjum@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Fix type mismatch warnings in different tests.

Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
 tools/testing/selftests/mm/compaction_test.c          | 2 +-
 tools/testing/selftests/mm/gup_longterm.c             | 3 ++-
 tools/testing/selftests/mm/hugetlb_dio.c              | 2 +-
 tools/testing/selftests/mm/hugetlb_fault_after_madv.c | 2 +-
 tools/testing/selftests/mm/hugetlb_madv_vs_map.c      | 2 +-
 tools/testing/selftests/mm/ksm_functional_tests.c     | 6 +++---
 tools/testing/selftests/mm/mlock-random-test.c        | 4 ++--
 tools/testing/selftests/mm/pkey_sighandler_tests.c    | 2 +-
 tools/testing/selftests/mm/soft-dirty.c               | 2 +-
 9 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/mm/compaction_test.c b/tools/testing/selftests/mm/compaction_test.c
index 8d23b698ce9db..f6f32a5732e9e 100644
--- a/tools/testing/selftests/mm/compaction_test.c
+++ b/tools/testing/selftests/mm/compaction_test.c
@@ -134,7 +134,7 @@ int check_compaction(unsigned long mem_free, unsigned long hugepage_size,
 	lseek(fd, 0, SEEK_SET);
 
 	if (write(fd, init_nr_hugepages, strlen(init_nr_hugepages))
-	    != strlen(init_nr_hugepages)) {
+	    != (signed long int)strlen(init_nr_hugepages)) {
 		ksft_print_msg("Failed to write value to /proc/sys/vm/nr_hugepages: %s\n",
 			       strerror(errno));
 		goto close_fd;
diff --git a/tools/testing/selftests/mm/gup_longterm.c b/tools/testing/selftests/mm/gup_longterm.c
index 03a31dcb57577..7f1b4ad7fcaec 100644
--- a/tools/testing/selftests/mm/gup_longterm.c
+++ b/tools/testing/selftests/mm/gup_longterm.c
@@ -446,7 +446,8 @@ static int tests_per_test_case(void)
 
 int main(void)
 {
-	int i, err;
+	unsigned int i;
+	int err;
 
 	pagesize = getpagesize();
 	nr_hugetlbsizes = detect_hugetlb_page_sizes(hugetlbsizes,
diff --git a/tools/testing/selftests/mm/hugetlb_dio.c b/tools/testing/selftests/mm/hugetlb_dio.c
index db63abe5ee5e8..62f368d4c8c16 100644
--- a/tools/testing/selftests/mm/hugetlb_dio.c
+++ b/tools/testing/selftests/mm/hugetlb_dio.c
@@ -63,7 +63,7 @@ void run_dio_using_hugetlb(unsigned int start_off, unsigned int end_off)
 	memset(buffer, 'A', writesize);
 
 	/* Write the buffer to the file */
-	if (write(fd, buffer, writesize) != (writesize)) {
+	if (write(fd, buffer, writesize) != (signed int)writesize) {
 		munmap(orig_buffer, h_pagesize);
 		close(fd);
 		ksft_exit_fail_perror("Error writing to file\n");
diff --git a/tools/testing/selftests/mm/hugetlb_fault_after_madv.c b/tools/testing/selftests/mm/hugetlb_fault_after_madv.c
index e62f4e1388f26..2b5acb13ee0be 100644
--- a/tools/testing/selftests/mm/hugetlb_fault_after_madv.c
+++ b/tools/testing/selftests/mm/hugetlb_fault_after_madv.c
@@ -88,7 +88,7 @@ int main(void)
 				MAP_PRIVATE | MAP_ANONYMOUS | MAP_HUGETLB,
 				-1, 0);
 
-		if ((unsigned long)huge_ptr == -1)
+		if (huge_ptr == MAP_FAILED)
 			ksft_exit_skip("Failed to allocated huge page\n");
 
 		pthread_create(&thread1, NULL, madv, NULL);
diff --git a/tools/testing/selftests/mm/hugetlb_madv_vs_map.c b/tools/testing/selftests/mm/hugetlb_madv_vs_map.c
index 6c326cf3dcf6b..eda38b63e9e8d 100644
--- a/tools/testing/selftests/mm/hugetlb_madv_vs_map.c
+++ b/tools/testing/selftests/mm/hugetlb_madv_vs_map.c
@@ -100,7 +100,7 @@ int main(void)
 				MAP_PRIVATE | MAP_ANONYMOUS | MAP_HUGETLB,
 				-1, 0);
 
-		if ((unsigned long)huge_ptr == -1) {
+		if (huge_ptr == MAP_FAILED) {
 			ksft_test_result_fail("Failed to allocate huge page\n");
 			return KSFT_FAIL;
 		}
diff --git a/tools/testing/selftests/mm/ksm_functional_tests.c b/tools/testing/selftests/mm/ksm_functional_tests.c
index 66b4e111b5a27..4f96126e4e1f9 100644
--- a/tools/testing/selftests/mm/ksm_functional_tests.c
+++ b/tools/testing/selftests/mm/ksm_functional_tests.c
@@ -306,7 +306,7 @@ static void test_unmerge_zero_pages(void)
 
 	/* Check if ksm_zero_pages is updated correctly after KSM merging */
 	pages_expected = size / pagesize;
-	if (pages_expected != get_my_ksm_zero_pages()) {
+	if ((signed long)pages_expected != get_my_ksm_zero_pages()) {
 		ksft_test_result_fail("'ksm_zero_pages' updated after merging\n");
 		goto unmap;
 	}
@@ -319,7 +319,7 @@ static void test_unmerge_zero_pages(void)
 
 	/* Check if ksm_zero_pages is updated correctly after unmerging */
 	pages_expected /= 2;
-	if (pages_expected != get_my_ksm_zero_pages()) {
+	if ((signed long)pages_expected != get_my_ksm_zero_pages()) {
 		ksft_test_result_fail("'ksm_zero_pages' updated after unmerging\n");
 		goto unmap;
 	}
@@ -625,7 +625,7 @@ static void test_prot_none(void)
 {
 	const unsigned int size = 2 * MiB;
 	char *map;
-	int i;
+	unsigned int i;
 
 	ksft_print_msg("[RUN] %s\n", __func__);
 
diff --git a/tools/testing/selftests/mm/mlock-random-test.c b/tools/testing/selftests/mm/mlock-random-test.c
index 0d95d630d0450..f410699458f2a 100644
--- a/tools/testing/selftests/mm/mlock-random-test.c
+++ b/tools/testing/selftests/mm/mlock-random-test.c
@@ -138,7 +138,7 @@ static void test_mlock_within_limit(char *p, int alloc_size)
 	int page_size = 0;
 
 	getrlimit(RLIMIT_MEMLOCK, &cur);
-	if (cur.rlim_cur < alloc_size)
+	if (cur.rlim_cur < (unsigned int)alloc_size)
 		ksft_exit_fail_msg("alloc_size[%d] < %u rlimit,lead to mlock failure\n",
 				   alloc_size, (unsigned int)cur.rlim_cur);
 
@@ -204,7 +204,7 @@ static void test_mlock_outof_limit(char *p, int alloc_size)
 	struct rlimit cur;
 
 	getrlimit(RLIMIT_MEMLOCK, &cur);
-	if (cur.rlim_cur >= alloc_size)
+	if (cur.rlim_cur >= (unsigned int)alloc_size)
 		ksft_exit_fail_msg("alloc_size[%d] >%u rlimit, violates test condition\n",
 				   alloc_size, (unsigned int)cur.rlim_cur);
 
diff --git a/tools/testing/selftests/mm/pkey_sighandler_tests.c b/tools/testing/selftests/mm/pkey_sighandler_tests.c
index cd46528d6c215..89c0f4e090374 100644
--- a/tools/testing/selftests/mm/pkey_sighandler_tests.c
+++ b/tools/testing/selftests/mm/pkey_sighandler_tests.c
@@ -535,7 +535,7 @@ static void (*pkey_tests[])(void) = {
 
 int main(void)
 {
-	int i;
+	unsigned int i;
 
 	ksft_print_header();
 	ksft_set_plan(ARRAY_SIZE(pkey_tests));
diff --git a/tools/testing/selftests/mm/soft-dirty.c b/tools/testing/selftests/mm/soft-dirty.c
index b6eb5c4642ce5..68edb2475ccd4 100644
--- a/tools/testing/selftests/mm/soft-dirty.c
+++ b/tools/testing/selftests/mm/soft-dirty.c
@@ -77,7 +77,7 @@ static void test_vma_reuse(int pagemap_fd, int pagesize)
 static void test_hugepage(int pagemap_fd)
 {
 	char *map;
-	int i, ret;
+	unsigned int i, ret;
 	size_t hpage_len = read_pmd_pagesize();
 
 	if (!hpage_len)
-- 
2.39.5


