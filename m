Return-Path: <linux-kselftest+bounces-34288-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F1F8ACD99F
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Jun 2025 10:23:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06BC21894E88
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Jun 2025 08:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E375F28C015;
	Wed,  4 Jun 2025 08:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FUSFBZCS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA6D215179
	for <linux-kselftest@vger.kernel.org>; Wed,  4 Jun 2025 08:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749025323; cv=none; b=CEGGMFriC5iqwD4aESGofSEoW2x/r8JM2lLh42HJfZHIy4V0s1OwrqZR2mP3oqxkQ6btnpVVGfUvAjcGgnF3meFvioY6vlF3D078eifI/b7o0Bc/YCUMMkGm5HuE++/npgyvRN3zkci8ziF/L6ye88x0Geftm3QwWT2umFTfY6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749025323; c=relaxed/simple;
	bh=pUMYpuGcglg1IttYp/noBt+/U7mJnvozVDLR6FRJq94=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=YpTxqytD090TRDYjhLVZY03YGLFcujVbthO3GH0xJTIs9l6h8MDBpJQh+gkZq+ZkvLlqfANQ20sTYn4aigOuw5NqxfgER4Mhmne2WQBrNpI6m6l1/5HOb2Yy9qC99HP0NjAt4u+FRdt88h1htrxshcEGlDnr6d+jbyruR98+HLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FUSFBZCS; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-acbb85ce788so1233611466b.3
        for <linux-kselftest@vger.kernel.org>; Wed, 04 Jun 2025 01:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749025320; x=1749630120; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=R1PmexcXDzfxPJBhbQk9JPwNkHWm4Mbz7NtLQ78OvBY=;
        b=FUSFBZCSlJlC4m8We8qJbGlN5jMQllNiEBQohvT/PpLMuPpjN0vLZZCgJnWemIT5wC
         Y1JKWO3+NcufG2mSHrVLGR/FUPHLQBnqNSEU+v1A1QatudT92urHbZ2zwFbSjBR862xz
         SYrnbJxDpl3P+YUXjlAYeuR3G4HyNqaMS19YB4gL6oxpD0hQ1bWy74+jX4TyJhLs1OHG
         yGyUqoLq+cTPv4ycZ21P8Nhtuvd5wdN9a+Ec0vwxmA6v1tKvCDWGti5gFOzx4Xbckm05
         s1oHS73rMP8KW7v0PhtvHyjBCU5LjLP/HPs+HJhYmPqWzDQXVdu8YNL1nCYdOSH1qUWX
         /VDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749025320; x=1749630120;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R1PmexcXDzfxPJBhbQk9JPwNkHWm4Mbz7NtLQ78OvBY=;
        b=VPmBvy627V6R3Axs8Gw0pyKiePDw1cnTl8C7601wqNHiAOLsrE758562cYTU7Ixz4F
         8lf61jh8eW48M/hLj3a+a9bV4UYWEKo4rSEY4ArppBQ11bLAROtd2D2xkj2NlMQGXNh2
         y1T8QvTVtLHnalyyoQzjQGNz/hkLHQ0dALrMZRSmCxlG7n+zYsGthaANQ/7CvjZTt4kX
         1zDVNrjsxBbybcGXCS5a76UUsuuxUpJsUruu23mjIP79Qw28P18CaibRp5F50i4BQvcU
         Z1NRyHrXP7JGa5hklfT4ByGIUDsGpjTpCo6Vbc+VESJRGZqnXC7aXdBhNJjXXVwvQAGx
         N9Lg==
X-Forwarded-Encrypted: i=1; AJvYcCWKJtMG2UjelyOiKS4DoAXGKLo96Tp0p3ttgQIc0hdkdGBrunXuAPzVdcCHhjBQB3xdGAYKALJIFjmyjDL/f0Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDYIdoNIFEIEabfCPN8c+IQjO4I0t4iKhAJnldgigLIfDBVJGD
	Q0uMcFrUlvdHsmziF4D4CU0wwBX3sHiJ+ObB9x9Yuhvs5tdMDk81Snyp
X-Gm-Gg: ASbGncsbmwTTaxxTqvjeIDvA23Q8AI/Ex8pwX8X7B1nNqCLQkj/la2eHm2ROMn9GL3s
	uvPPa2Y2Oa3uCvGgKp0NXYrZPzsYf8kzPwJBW7x3gqJsMBtvsiZdnJffN+evYWIuFZd4qFSoJQf
	nj6Z6xgEo88kg6lthbfe4f+AtrwIR+oLauR8x6KFBNsr09js6stshNGYWgwIOZC5JXbT7ICZMfE
	lhHAEG8RRU8R8yXz77yutpx7JC+GgjXqA8Gnfz/ByJvbI9pAUPBFbIWe55o45UdeCzk+pxq4jau
	VNWXsqWmC7nbD4YXvXTlGXRvLIUADSL1wSw+VlaSBukvqVTqITU=
X-Google-Smtp-Source: AGHT+IHSvCuO1Ib+fkwk22wioZn8f1CDtoboyPFI3l6u+xFSp7f8Ju1U9l060wyNsCkc3W+4GkHqgw==
X-Received: by 2002:a17:906:c110:b0:ad8:8478:6eb8 with SMTP id a640c23a62f3a-addf8c99acbmr142337366b.9.1749025319439;
        Wed, 04 Jun 2025 01:21:59 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ada5dd04586sm1075042366b.98.2025.06.04.01.21.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 04 Jun 2025 01:21:59 -0700 (PDT)
From: Wei Yang <richard.weiyang@gmail.com>
To: akpm@linux-foundation.org,
	david@redhat.com,
	lorenzo.stoakes@oracle.com,
	riel@surriel.com,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	harry.yoo@oracle.com
Cc: linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	Wei Yang <richard.weiyang@gmail.com>
Subject: [RFC Patch 1/2] selftests/mm: put general ksm operation into vm_util
Date: Wed,  4 Jun 2025 08:21:44 +0000
Message-Id: <20250604082145.13800-2-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20250604082145.13800-1-richard.weiyang@gmail.com>
References: <20250604082145.13800-1-richard.weiyang@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>

There are some general ksm operations could be used by other related
test case. Put them into vm_util for common use.

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
 .../selftests/mm/ksm_functional_tests.c       | 76 +++----------------
 tools/testing/selftests/mm/vm_util.c          | 71 +++++++++++++++++
 tools/testing/selftests/mm/vm_util.h          |  7 ++
 3 files changed, 88 insertions(+), 66 deletions(-)

diff --git a/tools/testing/selftests/mm/ksm_functional_tests.c b/tools/testing/selftests/mm/ksm_functional_tests.c
index b61803e36d1c..9fb79f6bf86d 100644
--- a/tools/testing/selftests/mm/ksm_functional_tests.c
+++ b/tools/testing/selftests/mm/ksm_functional_tests.c
@@ -73,74 +73,18 @@ static bool range_maps_duplicates(char *addr, unsigned long size)
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
 static int ksm_merge(void)
 {
 	long start_scans, end_scans;
 
 	/* Wait for two full scans such that any possible merging happened. */
-	start_scans = ksm_get_full_scans();
+	start_scans = ksm_get_full_scans(ksm_full_scans_fd);
 	if (start_scans < 0)
 		return start_scans;
-	if (write(ksm_fd, "1", 1) != 1)
+	if (ksm_start_and_merge(ksm_fd) != 1)
 		return -errno;
 	do {
-		end_scans = ksm_get_full_scans();
+		end_scans = ksm_get_full_scans(ksm_full_scans_fd);
 		if (end_scans < 0)
 			return end_scans;
 	} while (end_scans < start_scans + 2);
@@ -150,7 +94,7 @@ static int ksm_merge(void)
 
 static int ksm_unmerge(void)
 {
-	if (write(ksm_fd, "2", 1) != 1)
+	if (ksm_stop_and_unmerge(ksm_fd) != 1)
 		return -errno;
 	return 0;
 }
@@ -168,7 +112,7 @@ static char *__mmap_and_merge_range(char val, unsigned long size, int prot,
 		return err_map;
 	}
 
-	if (get_my_merging_pages() > 0) {
+	if (ksm_get_self_merging_pages(proc_self_ksm_merging_pages_fd) > 0) {
 		ksft_print_msg("Still pages merged\n");
 		return err_map;
 	}
@@ -227,7 +171,7 @@ static char *__mmap_and_merge_range(char val, unsigned long size, int prot,
 	 * Check if anything was merged at all. Ignore the zero page that is
 	 * accounted differently (depending on kernel support).
 	 */
-	if (val && !get_my_merging_pages()) {
+	if (val && !ksm_get_self_merging_pages(proc_self_ksm_merging_pages_fd)) {
 		ksft_print_msg("No pages got merged\n");
 		goto unmap;
 	}
@@ -294,7 +238,7 @@ static void test_unmerge_zero_pages(void)
 		ksft_test_result_skip("open \"/sys/kernel/mm/ksm/use_zero_pages\" failed\n");
 		return;
 	}
-	if (write(ksm_use_zero_pages_fd, "1", 1) != 1) {
+	if (ksm_use_zero_pages(ksm_use_zero_pages_fd) != 1) {
 		ksft_test_result_skip("write \"/sys/kernel/mm/ksm/use_zero_pages\" failed\n");
 		return;
 	}
@@ -306,7 +250,7 @@ static void test_unmerge_zero_pages(void)
 
 	/* Check if ksm_zero_pages is updated correctly after KSM merging */
 	pages_expected = size / pagesize;
-	if (pages_expected != get_my_ksm_zero_pages()) {
+	if (pages_expected != ksm_get_self_zero_pages(proc_self_ksm_stat_fd)) {
 		ksft_test_result_fail("'ksm_zero_pages' updated after merging\n");
 		goto unmap;
 	}
@@ -319,7 +263,7 @@ static void test_unmerge_zero_pages(void)
 
 	/* Check if ksm_zero_pages is updated correctly after unmerging */
 	pages_expected /= 2;
-	if (pages_expected != get_my_ksm_zero_pages()) {
+	if (pages_expected != ksm_get_self_zero_pages(proc_self_ksm_stat_fd)) {
 		ksft_test_result_fail("'ksm_zero_pages' updated after unmerging\n");
 		goto unmap;
 	}
@@ -329,7 +273,7 @@ static void test_unmerge_zero_pages(void)
 		*((unsigned int *)&map[offs]) = offs;
 
 	/* Now we should have no zeropages remaining. */
-	if (get_my_ksm_zero_pages()) {
+	if (ksm_get_self_zero_pages(proc_self_ksm_stat_fd)) {
 		ksft_test_result_fail("'ksm_zero_pages' updated after write fault\n");
 		goto unmap;
 	}
diff --git a/tools/testing/selftests/mm/vm_util.c b/tools/testing/selftests/mm/vm_util.c
index 1357e2d6a7b6..115422e9eb68 100644
--- a/tools/testing/selftests/mm/vm_util.c
+++ b/tools/testing/selftests/mm/vm_util.c
@@ -486,3 +486,74 @@ int close_procmap(struct procmap_fd *procmap)
 {
 	return close(procmap->fd);
 }
+
+int ksm_use_zero_pages(int ksm_use_zero_pages_fd)
+{
+	return write(ksm_use_zero_pages_fd, "1", 1);
+}
+
+int ksm_start_and_merge(int ksm_fd)
+{
+	return write(ksm_fd, "1", 1);
+}
+
+int ksm_stop_and_unmerge(int ksm_fd)
+{
+	return write(ksm_fd, "2", 1);
+}
+
+long ksm_get_full_scans(int ksm_full_scans_fd)
+{
+	char buf[10];
+	ssize_t ret;
+
+	ret = pread(ksm_full_scans_fd, buf, sizeof(buf) - 1, 0);
+	if (ret <= 0)
+		return -errno;
+	buf[ret] = 0;
+
+	return strtol(buf, NULL, 10);
+}
+
+long ksm_get_self_merging_pages(int proc_self_ksm_merging_pages_fd)
+{
+	char buf[10];
+	ssize_t ret;
+
+	if (proc_self_ksm_merging_pages_fd < 0)
+		return proc_self_ksm_merging_pages_fd;
+
+	ret = pread(proc_self_ksm_merging_pages_fd, buf, sizeof(buf) - 1, 0);
+	if (ret <= 0)
+		return -errno;
+	buf[ret] = 0;
+
+	return strtol(buf, NULL, 10);
+}
+
+long ksm_get_self_zero_pages(int proc_self_ksm_stat_fd)
+{
+	char buf[200];
+	char *substr_ksm_zero;
+	size_t value_pos;
+	ssize_t read_size;
+	unsigned long my_ksm_zero_pages;
+
+	if (!proc_self_ksm_stat_fd)
+		return 0;
+
+	read_size = pread(proc_self_ksm_stat_fd, buf, sizeof(buf) - 1, 0);
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
+	my_ksm_zero_pages = strtol(substr_ksm_zero + value_pos, NULL, 10);
+
+	return my_ksm_zero_pages;
+}
diff --git a/tools/testing/selftests/mm/vm_util.h b/tools/testing/selftests/mm/vm_util.h
index 9211ba640d9c..99c1b1aa1813 100644
--- a/tools/testing/selftests/mm/vm_util.h
+++ b/tools/testing/selftests/mm/vm_util.h
@@ -95,6 +95,13 @@ static inline int open_self_procmap(struct procmap_fd *procmap_out)
 	return open_procmap(pid, procmap_out);
 }
 
+int ksm_use_zero_pages(int ksm_use_zero_pages_fd);
+int ksm_start_and_merge(int ksm_fd);
+int ksm_stop_and_unmerge(int ksm_fd);
+long ksm_get_full_scans(int ksm_full_scans_fd);
+long ksm_get_self_merging_pages(int proc_self_ksm_merging_pages_fd);
+long ksm_get_self_zero_pages(int proc_self_ksm_stat_fd);
+
 /*
  * On ppc64 this will only work with radix 2M hugepage size
  */
-- 
2.34.1


