Return-Path: <linux-kselftest+bounces-39297-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 162C0B2BB54
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Aug 2025 10:03:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39BB91BA6A2F
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Aug 2025 08:01:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71E6C265296;
	Tue, 19 Aug 2025 08:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PIseBNXV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A313112B2
	for <linux-kselftest@vger.kernel.org>; Tue, 19 Aug 2025 08:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755590486; cv=none; b=X1VSmleRlGd4ILQ6kLLi7JhEH5cOov20Ott5Vomapc/bEQ5mNQK6N34WI2gj2KMIi4WStyRBhRv2QodGeTVzBD2CSdUdQRNrpdP4X6yn4LzoaZH0SqYeauUi6XxlTZhMUqIpW7aLs+oZmrYvZM7L/zfGBYT1G+Zpr3Hfnt2mn8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755590486; c=relaxed/simple;
	bh=z6OSCogjAxDZ9jQbfIznchwrNIhnvv9ZBcL4TRDxGtk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=tAeDMG5/sDgs8Qt+XnwFrn3vTF5GUkHDCaTMyN9f4wTGy0EBtKa+t8kht35yIDQaEOsGiEhjm0KUWu5FJwetnZ8n7QAjltQm8UM+Cu8ASoO7xdtlZ69Ey5LZBN4cTWCylAIZB+qEHQq4XcSzIAjdgt4qjJ7OGnAUSjV6KovDj2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PIseBNXV; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6188b5b1f1cso5924949a12.0
        for <linux-kselftest@vger.kernel.org>; Tue, 19 Aug 2025 01:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755590483; x=1756195283; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dUEjiJUWp4amXqR33SO/yGjIcZw0D6rrcyNI4+UM1tw=;
        b=PIseBNXVBkm0aTsnPEQb+pec8r1uum6vZZw68Zx5HWkxKsQHwPu3kPAONqayacjj5O
         Ih1gN7a1pElGHSN2Jh5UZcyKPGgLfQQJHSGUbC2/TE+KPIVxvEETUBBmrKoyQBmFemzV
         i+7E7+kEDiON/NhmoT4zsT1W++jVcYSiqrD0QaRJ4iLHHzsbWzkTKfyUDZJgGznihYj/
         7dbVx/cVk53vCKYoU/EBZdDaugy0bed3toLrsB7064uoI9GvHGBNI+/j0SiRzCdOE4W+
         wNJAk+huRKYTIpUe1lybvKwO2iPeZAGibft2EoXLWcFvUZS7NaElVQe5oiMIrxKWSK4i
         qS9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755590483; x=1756195283;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dUEjiJUWp4amXqR33SO/yGjIcZw0D6rrcyNI4+UM1tw=;
        b=tjlyvvmADttdEeuFz+it/RVhp5mH3BRaJ7kFjxfBbDZUeA52IDR8FLCGgURD9xtvuS
         /PAGbnpd+Tz5bJ0XV3kenLaeEIS0jjSB2mPv8EWWcj2Pw2a6K1SML9UyIyEH7hZz87Ak
         jLwaWATPZLbprvvt79KbVrm+PTT2hi1GS7OogrsKdn0fEYRxR8QM269X3ei9q9qAllcU
         P9Q8rWPG0Bpris5UUiWJjen422ABXY0JG/fBUOWylIwMT0F6TZLtobEGh25f8csolEUf
         2LEu95JC+C2efqsgEWIOOv/CvZfN84Ei2vEVj16TOiTZGbRF4hq8KDJuhuivD/bBGa/G
         wuHQ==
X-Forwarded-Encrypted: i=1; AJvYcCVVDUIdyRLAbVJBFBmDNB0IxpXsUiC1t5PZb0abVszNEZf94Xj6AaHOk52U+cjyxtLVz5ZtzteXaeoCmDdrFjc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6ADDOK5isjuRJLYq8QfW4xn1Yg4SZbPHesSMCmkX/T4iye1Gt
	1I5XKKMf22Jo81DMA1CwZtu4dqc4D5z3yvo2SHvlGWgwRBth74evStOA
X-Gm-Gg: ASbGncvBC8BZYDVCpK9Eeh9PsvUlUDomWwpdwecuTMUwy9XKVUe6mcgm81ACzgoDDzL
	fQ//GWjUBn+58+9QxQVKAh5Pq/sk3wpjvWKDxHIrhWxy8bIR6d0U2o0fIFg9+11uQzwwleaJbfP
	sF+4vR5rUopatS7rQysHNRaD0Bj7HahMLsdNAim0EYybxNM2GgAiPNCc/fx/+JS+ZRMOrSS+9Rp
	knRX0ypUGSA81oI5YjXIH0ryuXpnfY3RiC5zcu+ormndykOnYf2BhplcGSlqlQhOckWCPNMt8dZ
	Rc0wB0tRLjShx2hr0v5GU9smX+qAIXu78FyMbzrpylSg/H4kl/nLdBKYYMTxL/QADppj+sfV49U
	ZqtyLssjagLvLpko4f+N32Q==
X-Google-Smtp-Source: AGHT+IGYH+GLozlliCz8dnrxRkcTHgLAbXUdWUKiAaB10MSZj3LcUE83TSctDVhucTKREa1Od/TXKg==
X-Received: by 2002:a17:906:c145:b0:ae0:686a:870f with SMTP id a640c23a62f3a-afddcbd9064mr173580066b.15.1755590482159;
        Tue, 19 Aug 2025 01:01:22 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afcdce72dbdsm987263766b.43.2025.08.19.01.01.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Aug 2025 01:01:21 -0700 (PDT)
From: Wei Yang <richard.weiyang@gmail.com>
To: akpm@linux-foundation.org,
	david@redhat.com,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	rppt@kernel.org,
	riel@surriel.com,
	harry.yoo@oracle.com
Cc: linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	Wei Yang <richard.weiyang@gmail.com>
Subject: [Patch v4 1/2] selftests/mm: put general ksm operation into vm_util
Date: Tue, 19 Aug 2025 08:00:46 +0000
Message-Id: <20250819080047.10063-2-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20250819080047.10063-1-richard.weiyang@gmail.com>
References: <20250819080047.10063-1-richard.weiyang@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>

There are some general ksm operations could be used by other related
test cases. Put them into vm_util for common use.

This is a preparation patch for later use.

Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
Suggested-by: David Hildenbrand <david@redhat.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Rik van Riel <riel@surriel.com>
Cc: Liam R. Howlett <Liam.Howlett@oracle.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Harry Yoo <harry.yoo@oracle.com>

---
v4:
  * rebase on mm-new(dd1510cefdfe)
v3:
  * rebase on latest mm-unstable
v2:
  * do check on file opening in init_global_file_handlers()
  * factor out ksm_merge() and ksm_unmerge() instead of partial of it
  * align the return value of helpers: 0 on success, -errno on error
v1: open/close fd in function itself instead of pass as parameter
---
 .../selftests/mm/ksm_functional_tests.c       | 142 +++---------------
 tools/testing/selftests/mm/vm_util.c          | 123 +++++++++++++++
 tools/testing/selftests/mm/vm_util.h          |   7 +
 3 files changed, 154 insertions(+), 118 deletions(-)

diff --git a/tools/testing/selftests/mm/ksm_functional_tests.c b/tools/testing/selftests/mm/ksm_functional_tests.c
index 534aa405cac7..712f43c87736 100644
--- a/tools/testing/selftests/mm/ksm_functional_tests.c
+++ b/tools/testing/selftests/mm/ksm_functional_tests.c
@@ -38,11 +38,6 @@ enum ksm_merge_mode {
 };
 
 static int mem_fd;
-static int ksm_fd;
-static int ksm_full_scans_fd;
-static int proc_self_ksm_stat_fd;
-static int proc_self_ksm_merging_pages_fd;
-static int ksm_use_zero_pages_fd;
 static int pagemap_fd;
 static size_t pagesize;
 
@@ -75,88 +70,6 @@ static bool range_maps_duplicates(char *addr, unsigned long size)
 	return false;
 }
 
-static long get_my_ksm_zero_pages(void)
-{
-	char buf[200];
-	char *substr_ksm_zero;
-	size_t value_pos;
-	ssize_t read_size;
-	unsigned long my_ksm_zero_pages;
-
-	if (!proc_self_ksm_stat_fd)
-		return 0;
-
-	read_size = pread(proc_self_ksm_stat_fd, buf, sizeof(buf) - 1, 0);
-	if (read_size < 0)
-		return -errno;
-
-	buf[read_size] = 0;
-
-	substr_ksm_zero = strstr(buf, "ksm_zero_pages");
-	if (!substr_ksm_zero)
-		return 0;
-
-	value_pos = strcspn(substr_ksm_zero, "0123456789");
-	my_ksm_zero_pages = strtol(substr_ksm_zero + value_pos, NULL, 10);
-
-	return my_ksm_zero_pages;
-}
-
-static long get_my_merging_pages(void)
-{
-	char buf[10];
-	ssize_t ret;
-
-	if (proc_self_ksm_merging_pages_fd < 0)
-		return proc_self_ksm_merging_pages_fd;
-
-	ret = pread(proc_self_ksm_merging_pages_fd, buf, sizeof(buf) - 1, 0);
-	if (ret <= 0)
-		return -errno;
-	buf[ret] = 0;
-
-	return strtol(buf, NULL, 10);
-}
-
-static long ksm_get_full_scans(void)
-{
-	char buf[10];
-	ssize_t ret;
-
-	ret = pread(ksm_full_scans_fd, buf, sizeof(buf) - 1, 0);
-	if (ret <= 0)
-		return -errno;
-	buf[ret] = 0;
-
-	return strtol(buf, NULL, 10);
-}
-
-static int ksm_merge(void)
-{
-	long start_scans, end_scans;
-
-	/* Wait for two full scans such that any possible merging happened. */
-	start_scans = ksm_get_full_scans();
-	if (start_scans < 0)
-		return start_scans;
-	if (write(ksm_fd, "1", 1) != 1)
-		return -errno;
-	do {
-		end_scans = ksm_get_full_scans();
-		if (end_scans < 0)
-			return end_scans;
-	} while (end_scans < start_scans + 2);
-
-	return 0;
-}
-
-static int ksm_unmerge(void)
-{
-	if (write(ksm_fd, "2", 1) != 1)
-		return -errno;
-	return 0;
-}
-
 static char *__mmap_and_merge_range(char val, unsigned long size, int prot,
 				  enum ksm_merge_mode mode)
 {
@@ -165,12 +78,12 @@ static char *__mmap_and_merge_range(char val, unsigned long size, int prot,
 	int ret;
 
 	/* Stabilize accounting by disabling KSM completely. */
-	if (ksm_unmerge()) {
+	if (ksm_stop() < 0) {
 		ksft_print_msg("Disabling (unmerging) KSM failed\n");
 		return err_map;
 	}
 
-	if (get_my_merging_pages() > 0) {
+	if (ksm_get_self_merging_pages() > 0) {
 		ksft_print_msg("Still pages merged\n");
 		return err_map;
 	}
@@ -220,7 +133,7 @@ static char *__mmap_and_merge_range(char val, unsigned long size, int prot,
 	}
 
 	/* Run KSM to trigger merging and wait. */
-	if (ksm_merge()) {
+	if (ksm_start() < 0) {
 		ksft_print_msg("Running KSM failed\n");
 		goto unmap;
 	}
@@ -229,7 +142,7 @@ static char *__mmap_and_merge_range(char val, unsigned long size, int prot,
 	 * Check if anything was merged at all. Ignore the zero page that is
 	 * accounted differently (depending on kernel support).
 	 */
-	if (val && !get_my_merging_pages()) {
+	if (val && !ksm_get_self_merging_pages()) {
 		ksft_print_msg("No pages got merged\n");
 		goto unmap;
 	}
@@ -276,7 +189,7 @@ static void test_unmerge(void)
 	ksft_test_result(!range_maps_duplicates(map, size),
 			 "Pages were unmerged\n");
 unmap:
-	ksm_unmerge();
+	ksm_stop();
 	munmap(map, size);
 }
 
@@ -289,15 +202,12 @@ static void test_unmerge_zero_pages(void)
 
 	ksft_print_msg("[RUN] %s\n", __func__);
 
-	if (proc_self_ksm_stat_fd < 0) {
-		ksft_test_result_skip("open(\"/proc/self/ksm_stat\") failed\n");
-		return;
-	}
-	if (ksm_use_zero_pages_fd < 0) {
-		ksft_test_result_skip("open \"/sys/kernel/mm/ksm/use_zero_pages\" failed\n");
+	if (ksm_get_self_zero_pages() < 0) {
+		ksft_test_result_skip("accessing \"/proc/self/ksm_stat\" failed\n");
 		return;
 	}
-	if (write(ksm_use_zero_pages_fd, "1", 1) != 1) {
+
+	if (ksm_use_zero_pages() < 0) {
 		ksft_test_result_skip("write \"/sys/kernel/mm/ksm/use_zero_pages\" failed\n");
 		return;
 	}
@@ -309,7 +219,7 @@ static void test_unmerge_zero_pages(void)
 
 	/* Check if ksm_zero_pages is updated correctly after KSM merging */
 	pages_expected = size / pagesize;
-	if (pages_expected != get_my_ksm_zero_pages()) {
+	if (pages_expected != ksm_get_self_zero_pages()) {
 		ksft_test_result_fail("'ksm_zero_pages' updated after merging\n");
 		goto unmap;
 	}
@@ -322,7 +232,7 @@ static void test_unmerge_zero_pages(void)
 
 	/* Check if ksm_zero_pages is updated correctly after unmerging */
 	pages_expected /= 2;
-	if (pages_expected != get_my_ksm_zero_pages()) {
+	if (pages_expected != ksm_get_self_zero_pages()) {
 		ksft_test_result_fail("'ksm_zero_pages' updated after unmerging\n");
 		goto unmap;
 	}
@@ -332,7 +242,7 @@ static void test_unmerge_zero_pages(void)
 		*((unsigned int *)&map[offs]) = offs;
 
 	/* Now we should have no zeropages remaining. */
-	if (get_my_ksm_zero_pages()) {
+	if (ksm_get_self_zero_pages()) {
 		ksft_test_result_fail("'ksm_zero_pages' updated after write fault\n");
 		goto unmap;
 	}
@@ -341,7 +251,7 @@ static void test_unmerge_zero_pages(void)
 	ksft_test_result(!range_maps_duplicates(map, size),
 			"KSM zero pages were unmerged\n");
 unmap:
-	ksm_unmerge();
+	ksm_stop();
 	munmap(map, size);
 }
 
@@ -370,7 +280,7 @@ static void test_unmerge_discarded(void)
 	ksft_test_result(!range_maps_duplicates(map, size),
 			 "Pages were unmerged\n");
 unmap:
-	ksm_unmerge();
+	ksm_stop();
 	munmap(map, size);
 }
 
@@ -457,7 +367,7 @@ static void test_unmerge_uffd_wp(void)
 close_uffd:
 	close(uffd);
 unmap:
-	ksm_unmerge();
+	ksm_stop();
 	munmap(map, size);
 }
 #endif
@@ -521,7 +431,7 @@ static int test_child_ksm(void)
 	else if (map == MAP_MERGE_SKIP)
 		return 3;
 
-	ksm_unmerge();
+	ksm_stop();
 	munmap(map, size);
 	return 0;
 }
@@ -654,7 +564,7 @@ static void test_prctl_unmerge(void)
 	ksft_test_result(!range_maps_duplicates(map, size),
 			 "Pages were unmerged\n");
 unmap:
-	ksm_unmerge();
+	ksm_stop();
 	munmap(map, size);
 }
 
@@ -688,7 +598,7 @@ static void test_prot_none(void)
 	ksft_test_result(!range_maps_duplicates(map, size),
 			 "Pages were unmerged\n");
 unmap:
-	ksm_unmerge();
+	ksm_stop();
 	munmap(map, size);
 }
 
@@ -697,19 +607,15 @@ static void init_global_file_handles(void)
 	mem_fd = open("/proc/self/mem", O_RDWR);
 	if (mem_fd < 0)
 		ksft_exit_fail_msg("opening /proc/self/mem failed\n");
-	ksm_fd = open("/sys/kernel/mm/ksm/run", O_RDWR);
-	if (ksm_fd < 0)
-		ksft_exit_skip("open(\"/sys/kernel/mm/ksm/run\") failed\n");
-	ksm_full_scans_fd = open("/sys/kernel/mm/ksm/full_scans", O_RDONLY);
-	if (ksm_full_scans_fd < 0)
-		ksft_exit_skip("open(\"/sys/kernel/mm/ksm/full_scans\") failed\n");
+	if (ksm_stop() < 0)
+		ksft_exit_skip("accessing \"/sys/kernel/mm/ksm/run\") failed\n");
+	if (ksm_get_full_scans() < 0)
+		ksft_exit_skip("accessing \"/sys/kernel/mm/ksm/full_scans\") failed\n");
 	pagemap_fd = open("/proc/self/pagemap", O_RDONLY);
 	if (pagemap_fd < 0)
 		ksft_exit_skip("open(\"/proc/self/pagemap\") failed\n");
-	proc_self_ksm_stat_fd = open("/proc/self/ksm_stat", O_RDONLY);
-	proc_self_ksm_merging_pages_fd = open("/proc/self/ksm_merging_pages",
-						O_RDONLY);
-	ksm_use_zero_pages_fd = open("/sys/kernel/mm/ksm/use_zero_pages", O_RDWR);
+	if (ksm_get_self_merging_pages() < 0)
+		ksft_exit_skip("accessing \"/proc/self/ksm_merging_pages\") failed\n");
 }
 
 int main(int argc, char **argv)
diff --git a/tools/testing/selftests/mm/vm_util.c b/tools/testing/selftests/mm/vm_util.c
index 6a239aa413e2..ab7271ed5ff3 100644
--- a/tools/testing/selftests/mm/vm_util.c
+++ b/tools/testing/selftests/mm/vm_util.c
@@ -565,3 +565,126 @@ bool detect_huge_zeropage(void)
 	close(fd);
 	return enabled;
 }
+
+long ksm_get_self_zero_pages(void)
+{
+	int proc_self_ksm_stat_fd;
+	char buf[200];
+	char *substr_ksm_zero;
+	size_t value_pos;
+	ssize_t read_size;
+
+	proc_self_ksm_stat_fd = open("/proc/self/ksm_stat", O_RDONLY);
+	if (proc_self_ksm_stat_fd < 0)
+		return -errno;
+
+	read_size = pread(proc_self_ksm_stat_fd, buf, sizeof(buf) - 1, 0);
+	close(proc_self_ksm_stat_fd);
+	if (read_size < 0)
+		return -errno;
+
+	buf[read_size] = 0;
+
+	substr_ksm_zero = strstr(buf, "ksm_zero_pages");
+	if (!substr_ksm_zero)
+		return 0;
+
+	value_pos = strcspn(substr_ksm_zero, "0123456789");
+	return strtol(substr_ksm_zero + value_pos, NULL, 10);
+}
+
+long ksm_get_self_merging_pages(void)
+{
+	int proc_self_ksm_merging_pages_fd;
+	char buf[10];
+	ssize_t ret;
+
+	proc_self_ksm_merging_pages_fd = open("/proc/self/ksm_merging_pages",
+						O_RDONLY);
+	if (proc_self_ksm_merging_pages_fd < 0)
+		return -errno;
+
+	ret = pread(proc_self_ksm_merging_pages_fd, buf, sizeof(buf) - 1, 0);
+	close(proc_self_ksm_merging_pages_fd);
+	if (ret <= 0)
+		return -errno;
+	buf[ret] = 0;
+
+	return strtol(buf, NULL, 10);
+}
+
+long ksm_get_full_scans(void)
+{
+	int ksm_full_scans_fd;
+	char buf[10];
+	ssize_t ret;
+
+	ksm_full_scans_fd = open("/sys/kernel/mm/ksm/full_scans", O_RDONLY);
+	if (ksm_full_scans_fd < 0)
+		return -errno;
+
+	ret = pread(ksm_full_scans_fd, buf, sizeof(buf) - 1, 0);
+	close(ksm_full_scans_fd);
+	if (ret <= 0)
+		return -errno;
+	buf[ret] = 0;
+
+	return strtol(buf, NULL, 10);
+}
+
+int ksm_use_zero_pages(void)
+{
+	int ksm_use_zero_pages_fd;
+	ssize_t ret;
+
+	ksm_use_zero_pages_fd = open("/sys/kernel/mm/ksm/use_zero_pages", O_RDWR);
+	if (ksm_use_zero_pages_fd < 0)
+		return -errno;
+
+	ret = write(ksm_use_zero_pages_fd, "1", 1);
+	close(ksm_use_zero_pages_fd);
+	return ret == 1 ? 0 : -errno;
+}
+
+int ksm_start(void)
+{
+	int ksm_fd;
+	ssize_t ret;
+	long start_scans, end_scans;
+
+	ksm_fd = open("/sys/kernel/mm/ksm/run", O_RDWR);
+	if (ksm_fd < 0)
+		return -errno;
+
+	/* Wait for two full scans such that any possible merging happened. */
+	start_scans = ksm_get_full_scans();
+	if (start_scans < 0) {
+		close(ksm_fd);
+		return start_scans;
+	}
+	ret = write(ksm_fd, "1", 1);
+	close(ksm_fd);
+	if (ret != 1)
+		return -errno;
+	do {
+		end_scans = ksm_get_full_scans();
+		if (end_scans < 0)
+			return end_scans;
+	} while (end_scans < start_scans + 2);
+
+	return 0;
+}
+
+int ksm_stop(void)
+{
+	int ksm_fd;
+	ssize_t ret;
+
+	ksm_fd = open("/sys/kernel/mm/ksm/run", O_RDWR);
+	if (ksm_fd < 0)
+		return -errno;
+
+	ret = write(ksm_fd, "2", 1);
+	close(ksm_fd);
+	return ret == 1 ? 0 : -errno;
+}
diff --git a/tools/testing/selftests/mm/vm_util.h b/tools/testing/selftests/mm/vm_util.h
index 3da56feeb944..1f9a90668758 100644
--- a/tools/testing/selftests/mm/vm_util.h
+++ b/tools/testing/selftests/mm/vm_util.h
@@ -135,6 +135,13 @@ static inline int sz2ord(size_t size, size_t pagesize)
 void *sys_mremap(void *old_address, unsigned long old_size,
 		 unsigned long new_size, int flags, void *new_address);
 
+long ksm_get_self_zero_pages(void);
+long ksm_get_self_merging_pages(void);
+long ksm_get_full_scans(void);
+int ksm_use_zero_pages(void);
+int ksm_start(void);
+int ksm_stop(void);
+
 /*
  * On ppc64 this will only work with radix 2M hugepage size
  */
-- 
2.34.1


