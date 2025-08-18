Return-Path: <linux-kselftest+bounces-39184-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B58CB29709
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Aug 2025 04:29:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E17FC189DA8C
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Aug 2025 02:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC820253358;
	Mon, 18 Aug 2025 02:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XhHkQzah"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F825253932
	for <linux-kselftest@vger.kernel.org>; Mon, 18 Aug 2025 02:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755484167; cv=none; b=iTmxj57WiWbajvEKb2NDMuKVVwCnLqz14+j2SPd1zyne+JdZ7Lxm3cB1q30o31S6GjHkQRm6Tpxq9W2w5bFEjEwNeziWEJKFRd7REKtuWLOxpyH/Zvt3Y5O6K05FPiPPGEs5mrZ7f6djIeMeKviGZ5jvgDzugWmPpdcVVyy20PU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755484167; c=relaxed/simple;
	bh=Ccekln9K9ZIHLRM8rGid7Ib/BFyUT8npSLObGtUJbhc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=AVJRyGwPIzYksjKELnZZGOUfuKwP01Bgwmq07AsXCRg+YgjIn/MRQBizAL7Eb82aMXnzbjP6LAuA0qGAHTxfHQUQX+mtz6bzzHqYHU23DXwra19UwEy0BZZ29ep9iEYH5eAybJKMNLzsC+Tg2xsvoFuB1wVVPr67cUNkSzIeQrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XhHkQzah; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6188b70abdfso5156062a12.2
        for <linux-kselftest@vger.kernel.org>; Sun, 17 Aug 2025 19:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755484164; x=1756088964; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=e3xlfyKJcyV3WSNhwZBAllw4fH3HPPCNY5TOIpc671E=;
        b=XhHkQzahq2bEQ2jm3K00WhMEA3luij+hBsFOuufn+vc3sE4KhbLJECYcI3wbHGLH/s
         3RRja2zG/SRv/rjL9wqQHDPoIYz6kOj03liNXbYJsTebbtbD+oNwi6txTLLDlX4mIGCO
         +so9M4rEtUYhkwEMgXhDDPJx0Fv5tjYfjrE9XNVg8rZHhd1Wog3WR5Yhvy7f1XoJRVnX
         m1gqhqFz/tODDUSBpcl4vXO2q0fByzimerLMGRevU7D4Zl1sLuLwZkm4XKstmtnTJyAn
         nLf8rjjD/xLcp+eteekpeLUDJhbya3bdHlfRCen5fw0NDgGNDtZGbLnSuy0JSxmWxIg9
         Mttw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755484164; x=1756088964;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e3xlfyKJcyV3WSNhwZBAllw4fH3HPPCNY5TOIpc671E=;
        b=jiM2cw/SRvYLS7oYdCH6g+WLl6a+3R/deUWUMVS0meldv9iwOJjTjwjgOo2hGQ6WIZ
         r0XyzApTJYMYqifR4/xIdcPdnRlJSPcViD/LNhOhSwzgJFdh2IE8mM9k7NAsNW5OiOkw
         BN+gGvWeYupWBb9ckyUCxyv6BQ4b2zVCttm7G3uVE3u0RTJZF3KOahEwWOL8PjAQj97g
         oPEK8d2iq/0CsfLyA3fT/N9moxnDae/mvsaH8cp1VtWzH8J46WYq7RzFYlgU0NraX5y4
         rtaDxunIxJ4j7ZxLbME4fjDM76ZMnS0cqlURSwIRFy7Qx0xOCvdCTUNw3EBE8hR1vVgs
         Z6wA==
X-Forwarded-Encrypted: i=1; AJvYcCWZo/sFki+w4HS5h1Ldbwz8vA4aR8eNaDoA69FBJL3+tYDI33Ow8Hv9K/0JbQR59fxkOW7sEobR8T4pN3xcgIk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyR87KkTeaOBEgdyMbw5K7KPrMugPJSWkdIHe5PmP+ez56mvVhD
	axu4ARDYpZlHTgfFwwMgxcnFTvG/OTCnBKHFO/4E34me8g1N4Naru8hG
X-Gm-Gg: ASbGncve7iFsaMGH/404MVSzX1MBxZ688RqK5/mexHa8jE7GZ0Mfe7VwzcfaEHB+qsS
	etDLJvfxftSvG5aj9BwiraB2j7q1ykj8PBY0Ll3kmR4uqQL4QUGR2xmcg+5GyFd4CtEBb7L5xC8
	l+06zicOgSnWPPYeBzZg6aZUSEFwWe95OWia/ABuwlbx1fRvliOkQMghbKKyJLmLo/Z1gK9f9Lx
	UJM23JDHQ+yHoeJGikQ3t57mnxtV/xH/vEso4tqy1HLqlFvkhYDw5conJbet42+tDPSDPjRb2F+
	YCZ/KudiXR9JsZX9mrc3igQkUueluy85KcgmSbYFENOoR2qIfV19yNmRk57CtmnCb+BxMjId6hw
	zjWRQBS3W/I/sfboiPzPksQ==
X-Google-Smtp-Source: AGHT+IHyKwpVMlbsT8+N13YDxkeY56zYwPHjJgQXAA7mQ3KzOeipYWnXqSGupzP6puuOzTSU/7seQg==
X-Received: by 2002:a05:6402:3508:b0:615:5dbd:ccba with SMTP id 4fb4d7f45d1cf-618b051714bmr8374038a12.11.1755484163628;
        Sun, 17 Aug 2025 19:29:23 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-618b01ae5casm6347486a12.36.2025.08.17.19.29.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 17 Aug 2025 19:29:22 -0700 (PDT)
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
Subject: [Patch v3 1/2] selftests/mm: put general ksm operation into vm_util
Date: Mon, 18 Aug 2025 02:29:04 +0000
Message-Id: <20250818022905.15428-2-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20250818022905.15428-1-richard.weiyang@gmail.com>
References: <20250818022905.15428-1-richard.weiyang@gmail.com>
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
v3:
  * rebase on latest mm-unstable
v2:
  * do check on file opening in init_global_file_handlers()
  * factor out ksm_merge() and ksm_unmerge() instead of partial of it
  * align the return value of helpers: 0 on success, -errno on error
v1: open/close fd in function itself instead of pass as parameter
---
 .../selftests/mm/ksm_functional_tests.c       | 134 +++---------------
 tools/testing/selftests/mm/vm_util.c          | 123 ++++++++++++++++
 tools/testing/selftests/mm/vm_util.h          |   7 +
 3 files changed, 153 insertions(+), 111 deletions(-)

diff --git a/tools/testing/selftests/mm/ksm_functional_tests.c b/tools/testing/selftests/mm/ksm_functional_tests.c
index d8bd1911dfc0..c9d72daa3138 100644
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
 
@@ -73,88 +68,6 @@ static bool range_maps_duplicates(char *addr, unsigned long size)
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
@@ -163,12 +76,12 @@ static char *__mmap_and_merge_range(char val, unsigned long size, int prot,
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
@@ -218,7 +131,7 @@ static char *__mmap_and_merge_range(char val, unsigned long size, int prot,
 	}
 
 	/* Run KSM to trigger merging and wait. */
-	if (ksm_merge()) {
+	if (ksm_start() < 0) {
 		ksft_print_msg("Running KSM failed\n");
 		goto unmap;
 	}
@@ -227,7 +140,7 @@ static char *__mmap_and_merge_range(char val, unsigned long size, int prot,
 	 * Check if anything was merged at all. Ignore the zero page that is
 	 * accounted differently (depending on kernel support).
 	 */
-	if (val && !get_my_merging_pages()) {
+	if (val && !ksm_get_self_merging_pages()) {
 		ksft_print_msg("No pages got merged\n");
 		goto unmap;
 	}
@@ -274,6 +187,7 @@ static void test_unmerge(void)
 	ksft_test_result(!range_maps_duplicates(map, size),
 			 "Pages were unmerged\n");
 unmap:
+	ksm_stop();
 	munmap(map, size);
 }
 
@@ -286,15 +200,12 @@ static void test_unmerge_zero_pages(void)
 
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
@@ -306,7 +217,7 @@ static void test_unmerge_zero_pages(void)
 
 	/* Check if ksm_zero_pages is updated correctly after KSM merging */
 	pages_expected = size / pagesize;
-	if (pages_expected != get_my_ksm_zero_pages()) {
+	if (pages_expected != ksm_get_self_zero_pages()) {
 		ksft_test_result_fail("'ksm_zero_pages' updated after merging\n");
 		goto unmap;
 	}
@@ -319,7 +230,7 @@ static void test_unmerge_zero_pages(void)
 
 	/* Check if ksm_zero_pages is updated correctly after unmerging */
 	pages_expected /= 2;
-	if (pages_expected != get_my_ksm_zero_pages()) {
+	if (pages_expected != ksm_get_self_zero_pages()) {
 		ksft_test_result_fail("'ksm_zero_pages' updated after unmerging\n");
 		goto unmap;
 	}
@@ -329,7 +240,7 @@ static void test_unmerge_zero_pages(void)
 		*((unsigned int *)&map[offs]) = offs;
 
 	/* Now we should have no zeropages remaining. */
-	if (get_my_ksm_zero_pages()) {
+	if (ksm_get_self_zero_pages()) {
 		ksft_test_result_fail("'ksm_zero_pages' updated after write fault\n");
 		goto unmap;
 	}
@@ -338,6 +249,7 @@ static void test_unmerge_zero_pages(void)
 	ksft_test_result(!range_maps_duplicates(map, size),
 			"KSM zero pages were unmerged\n");
 unmap:
+	ksm_stop();
 	munmap(map, size);
 }
 
@@ -366,6 +278,7 @@ static void test_unmerge_discarded(void)
 	ksft_test_result(!range_maps_duplicates(map, size),
 			 "Pages were unmerged\n");
 unmap:
+	ksm_stop();
 	munmap(map, size);
 }
 
@@ -452,6 +365,7 @@ static void test_unmerge_uffd_wp(void)
 close_uffd:
 	close(uffd);
 unmap:
+	ksm_stop();
 	munmap(map, size);
 }
 #endif
@@ -515,6 +429,7 @@ static int test_child_ksm(void)
 	else if (map == MAP_MERGE_SKIP)
 		return -3;
 
+	ksm_stop();
 	munmap(map, size);
 	return 0;
 }
@@ -644,6 +559,7 @@ static void test_prctl_unmerge(void)
 	ksft_test_result(!range_maps_duplicates(map, size),
 			 "Pages were unmerged\n");
 unmap:
+	ksm_stop();
 	munmap(map, size);
 }
 
@@ -685,19 +601,15 @@ static void init_global_file_handles(void)
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
index 1843ad48d32b..ba4d9fa44a7d 100644
--- a/tools/testing/selftests/mm/vm_util.h
+++ b/tools/testing/selftests/mm/vm_util.h
@@ -130,6 +130,13 @@ static inline void log_test_result(int result)
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


