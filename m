Return-Path: <linux-kselftest+bounces-3624-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E6A883D940
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Jan 2024 12:22:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54ED1287BEE
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Jan 2024 11:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AED831427F;
	Fri, 26 Jan 2024 11:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="AfJsqg//"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1565C18EA8;
	Fri, 26 Jan 2024 11:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706268107; cv=none; b=YSpgu2Ahbxt/S40+y9pUYtiuuE9GhaigvKFiL4/MSBgw2sXneh6yEmFGuvZhDRxfE93DF9Jk9jIj/V8+anQ6re8dPeQTE7n5pndU9d9akC3dRbgWL0fr07Kfk07pi2RyiSUtlLtZno91uecf3w6rfO1S0dgQh3OBszBijpKaBVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706268107; c=relaxed/simple;
	bh=ZgeR49CN4VkFb6rnnGh7sik2kywTrpj+vq5bFUpHG1A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mNEk8nY99kbdXWX4dBLdgWpQpmUw7CmxOqeM522GplNqXicjpHprIlAhESy7nEEVdR7vJ5jgoE/uzL3NitdM14Z2gz+OlyxLTKSjS93SgHvAX0+JPCnJR0JNve0KaXi6egjm5R7TCXzKTLKlzwO5BRkFjMJzYpt5f6iIP5iGwn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=AfJsqg//; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1706268103;
	bh=ZgeR49CN4VkFb6rnnGh7sik2kywTrpj+vq5bFUpHG1A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AfJsqg//s350onVGMbUOhRwt0vhz0cosJrhtMTwIqFIlhF6+ydIhtuexikNUFiSri
	 FlEhRgmRbyVy9ZXfIQW12nO856hFx7n8RaNP+NCby7whWqufX46aOj63/z4B2oUgJc
	 eEkhywu1V2VDvxBAc65QV1DkDlhgHiEHj/uqHU24bsj3O7IkeSYUoB6WUM0RtCY23j
	 p//Q3MQ6A73A1TGU2aOiRPugglKdGMNdtIS0OYqc/ULa3QG4K7gXnD6qkhB4hq0mP4
	 cOgIT8BngmTmDXDbG6Dvm5Yenl7SDEjGRWLVL8PM1kWHoVHZRRk1NoQ2o2ewlTcn1m
	 s4szofxt3tZsQ==
Received: from localhost.localdomain (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id D18813782075;
	Fri, 26 Jan 2024 11:21:40 +0000 (UTC)
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
	kernel@collabora.com,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 4/7] selftests/mm: khugepaged: conform test to TAP format output
Date: Fri, 26 Jan 2024 16:21:23 +0500
Message-ID: <20240126112129.1480265-4-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240126112129.1480265-1-usama.anjum@collabora.com>
References: <20240126112129.1480265-1-usama.anjum@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Conform the layout, informational and status messages to TAP. No
functional change is intended other than the layout of output messages.

Skip test if root privileges aren't provided.

Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
Changes since v3:
- Rebased on top of next-20240125
- Skip test if root privileges aren't present

Changes since v1:
- Remove commented out lines of code
---
 tools/testing/selftests/mm/khugepaged.c | 385 ++++++++++--------------
 1 file changed, 163 insertions(+), 222 deletions(-)

diff --git a/tools/testing/selftests/mm/khugepaged.c b/tools/testing/selftests/mm/khugepaged.c
index 829320a519e72..d51fdaee7dc6a 100644
--- a/tools/testing/selftests/mm/khugepaged.c
+++ b/tools/testing/selftests/mm/khugepaged.c
@@ -23,6 +23,7 @@
 
 #include "vm_util.h"
 #include "thp_settings.h"
+#include "../kselftest.h"
 
 #define BASE_ADDR ((void *)(1UL << 30))
 static unsigned long hpage_pmd_size;
@@ -73,22 +74,20 @@ struct file_info {
 
 static struct file_info finfo;
 static bool skip_settings_restore;
-static int exit_status;
 
 static void success(const char *msg)
 {
-	printf(" \e[32m%s\e[0m\n", msg);
+	ksft_test_result_pass("%s\n", msg);
 }
 
 static void fail(const char *msg)
 {
-	printf(" \e[31m%s\e[0m\n", msg);
-	exit_status++;
+	ksft_test_result_fail("%s\n", msg);
 }
 
 static void skip(const char *msg)
 {
-	printf(" \e[33m%s\e[0m\n", msg);
+	ksft_test_result_skip("\e%s\n", msg);
 }
 
 static void restore_settings_atexit(void)
@@ -96,9 +95,8 @@ static void restore_settings_atexit(void)
 	if (skip_settings_restore)
 		return;
 
-	printf("Restore THP and khugepaged settings...");
 	thp_restore_settings();
-	success("OK");
+	ksft_print_msg("Restored THP and khugepaged settings...\n");
 
 	skip_settings_restore = true;
 }
@@ -106,12 +104,12 @@ static void restore_settings_atexit(void)
 static void restore_settings(int sig)
 {
 	/* exit() will invoke the restore_settings_atexit handler. */
-	exit(sig ? EXIT_FAILURE : exit_status);
+	ksft_finished();
 }
 
 static void save_settings(void)
 {
-	printf("Save THP and khugepaged settings...");
+	ksft_print_msg("Save THP and khugepaged settings...\n");
 	if (file_ops && finfo.type == VMA_FILE)
 		thp_set_read_ahead_path(finfo.dev_queue_read_ahead_path);
 	thp_save_settings();
@@ -135,60 +133,50 @@ static void get_finfo(const char *dir)
 
 	finfo.dir = dir;
 	stat(finfo.dir, &path_stat);
-	if (!S_ISDIR(path_stat.st_mode)) {
-		printf("%s: Not a directory (%s)\n", __func__, finfo.dir);
-		exit(EXIT_FAILURE);
-	}
+	if (!S_ISDIR(path_stat.st_mode))
+		ksft_exit_fail_msg("%s: Not a directory (%s)\n", __func__, finfo.dir);
+
 	if (snprintf(finfo.path, sizeof(finfo.path), "%s/" TEST_FILE,
-		     finfo.dir) >= sizeof(finfo.path)) {
-		printf("%s: Pathname is too long\n", __func__);
-		exit(EXIT_FAILURE);
-	}
-	if (statfs(finfo.dir, &fs)) {
-		perror("statfs()");
-		exit(EXIT_FAILURE);
-	}
+		     finfo.dir) >= sizeof(finfo.path))
+		ksft_exit_fail_msg("%s: Pathname is too long\n", __func__);
+
+	if (statfs(finfo.dir, &fs))
+		ksft_exit_fail_msg("statfs(): %s\n", strerror(errno));
+
 	finfo.type = fs.f_type == TMPFS_MAGIC ? VMA_SHMEM : VMA_FILE;
 	if (finfo.type == VMA_SHMEM)
 		return;
 
 	/* Find owning device's queue/read_ahead_kb control */
 	if (snprintf(path, sizeof(path), "/sys/dev/block/%d:%d/uevent",
-		     major(path_stat.st_dev), minor(path_stat.st_dev))
-	    >= sizeof(path)) {
-		printf("%s: Pathname is too long\n", __func__);
-		exit(EXIT_FAILURE);
-	}
-	if (read_file(path, buf, sizeof(buf)) < 0) {
-		perror("read_file(read_num)");
-		exit(EXIT_FAILURE);
-	}
+		     major(path_stat.st_dev), minor(path_stat.st_dev)) >= sizeof(path))
+		ksft_exit_fail_msg("%s: Pathname is too long\n", __func__);
+
+	if (read_file(path, buf, sizeof(buf)) < 0)
+		ksft_exit_fail_msg("read_file(read_num): %s\n", strerror(errno));
+
 	if (strstr(buf, "DEVTYPE=disk")) {
 		/* Found it */
 		if (snprintf(finfo.dev_queue_read_ahead_path,
 			     sizeof(finfo.dev_queue_read_ahead_path),
 			     "/sys/dev/block/%d:%d/queue/read_ahead_kb",
 			     major(path_stat.st_dev), minor(path_stat.st_dev))
-		    >= sizeof(finfo.dev_queue_read_ahead_path)) {
-			printf("%s: Pathname is too long\n", __func__);
-			exit(EXIT_FAILURE);
-		}
+		    >= sizeof(finfo.dev_queue_read_ahead_path))
+			ksft_exit_fail_msg("%s: Pathname is too long: %s\n", __func__,
+					   strerror(errno));
 		return;
 	}
-	if (!strstr(buf, "DEVTYPE=partition")) {
-		printf("%s: Unknown device type: %s\n", __func__, path);
-		exit(EXIT_FAILURE);
-	}
+	if (!strstr(buf, "DEVTYPE=partition"))
+		ksft_exit_fail_msg("%s: Unknown device type: %s\n", __func__, path);
 	/*
 	 * Partition of block device - need to find actual device.
 	 * Using naming convention that devnameN is partition of
 	 * device devname.
 	 */
 	str = strstr(buf, "DEVNAME=");
-	if (!str) {
-		printf("%s: Could not read: %s", __func__, path);
-		exit(EXIT_FAILURE);
-	}
+	if (!str)
+		ksft_exit_fail_msg("%s: Could not read: %s", __func__, path);
+
 	str += 8;
 	end = str;
 	while (*end) {
@@ -197,16 +185,14 @@ static void get_finfo(const char *dir)
 			if (snprintf(finfo.dev_queue_read_ahead_path,
 				     sizeof(finfo.dev_queue_read_ahead_path),
 				     "/sys/block/%s/queue/read_ahead_kb",
-				     str) >= sizeof(finfo.dev_queue_read_ahead_path)) {
-				printf("%s: Pathname is too long\n", __func__);
-				exit(EXIT_FAILURE);
-			}
+				     str) >= sizeof(finfo.dev_queue_read_ahead_path))
+				ksft_exit_fail_msg("%s: Pathname is too long\n", __func__);
+
 			return;
 		}
 		++end;
 	}
-	printf("%s: Could not read: %s\n", __func__, path);
-	exit(EXIT_FAILURE);
+	ksft_exit_fail_msg("%s: Could not read: %s\n", __func__, path);
 }
 
 static bool check_swap(void *addr, unsigned long size)
@@ -219,26 +205,21 @@ static bool check_swap(void *addr, unsigned long size)
 
 	ret = snprintf(addr_pattern, MAX_LINE_LENGTH, "%08lx-",
 		       (unsigned long) addr);
-	if (ret >= MAX_LINE_LENGTH) {
-		printf("%s: Pattern is too long\n", __func__);
-		exit(EXIT_FAILURE);
-	}
-
+	if (ret >= MAX_LINE_LENGTH)
+		ksft_exit_fail_msg("%s: Pattern is too long\n", __func__);
 
 	fp = fopen(PID_SMAPS, "r");
-	if (!fp) {
-		printf("%s: Failed to open file %s\n", __func__, PID_SMAPS);
-		exit(EXIT_FAILURE);
-	}
+	if (!fp)
+		ksft_exit_fail_msg("%s: Failed to open file %s\n", __func__, PID_SMAPS);
+
 	if (!check_for_pattern(fp, addr_pattern, buffer, sizeof(buffer)))
 		goto err_out;
 
 	ret = snprintf(addr_pattern, MAX_LINE_LENGTH, "Swap:%19ld kB",
 		       size >> 10);
-	if (ret >= MAX_LINE_LENGTH) {
-		printf("%s: Pattern is too long\n", __func__);
-		exit(EXIT_FAILURE);
-	}
+	if (ret >= MAX_LINE_LENGTH)
+		ksft_exit_fail_msg("%s: Pattern is too long\n", __func__);
+
 	/*
 	 * Fetch the Swap: in the same block and check whether it got
 	 * the expected number of hugeepages next.
@@ -261,10 +242,8 @@ static void *alloc_mapping(int nr)
 
 	p = mmap(BASE_ADDR, nr * hpage_pmd_size, PROT_READ | PROT_WRITE,
 		 MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
-	if (p != BASE_ADDR) {
-		printf("Failed to allocate VMA at %p\n", BASE_ADDR);
-		exit(EXIT_FAILURE);
-	}
+	if (p != BASE_ADDR)
+		ksft_exit_fail_msg("Failed to allocate VMA at %p\n", BASE_ADDR);
 
 	return p;
 }
@@ -314,19 +293,16 @@ static void *alloc_hpage(struct mem_ops *ops)
 	 * khugepaged on low-load system (like a test machine), which
 	 * would cause MADV_COLLAPSE to fail with EAGAIN.
 	 */
-	printf("Allocate huge page...");
-	if (madvise_collapse_retry(p, hpage_pmd_size)) {
-		perror("madvise(MADV_COLLAPSE)");
-		exit(EXIT_FAILURE);
-	}
-	if (!ops->check_huge(p, 1)) {
-		perror("madvise(MADV_COLLAPSE)");
-		exit(EXIT_FAILURE);
-	}
-	if (madvise(p, hpage_pmd_size, MADV_HUGEPAGE)) {
-		perror("madvise(MADV_HUGEPAGE)");
-		exit(EXIT_FAILURE);
-	}
+	ksft_print_msg("Allocate huge page...\n");
+	if (madvise_collapse_retry(p, hpage_pmd_size))
+		ksft_exit_fail_msg("madvise(MADV_COLLAPSE): %s\n", strerror(errno));
+
+	if (!ops->check_huge(p, 1))
+		ksft_exit_fail_msg("madvise(MADV_COLLAPSE): %s\n", strerror(errno));
+
+	if (madvise(p, hpage_pmd_size, MADV_HUGEPAGE))
+		ksft_exit_fail_msg("madvise(MADV_HUGEPAGE): %s\n", strerror(errno));
+
 	success("OK");
 	return p;
 }
@@ -335,13 +311,12 @@ static void validate_memory(int *p, unsigned long start, unsigned long end)
 {
 	int i;
 
-	for (i = start / page_size; i < end / page_size; i++) {
-		if (p[i * page_size / sizeof(*p)] != i + 0xdead0000) {
-			printf("Page %d is corrupted: %#x\n",
-					i, p[i * page_size / sizeof(*p)]);
-			exit(EXIT_FAILURE);
-		}
-	}
+	for (i = start / page_size; i < end / page_size; i++)
+		if (p[i * page_size / sizeof(*p)] != i + 0xdead0000)
+			ksft_print_msg("Page %d is corrupted: %#x\n",
+				       i, p[i * page_size / sizeof(*p)]);
+
+	ksft_test_result(i == end/page_size, "Validated memory\n");
 }
 
 static void *anon_setup_area(int nr_hpages)
@@ -371,14 +346,12 @@ static void *file_setup_area(int nr_hpages)
 	unsigned long size;
 
 	unlink(finfo.path);  /* Cleanup from previous failed tests */
-	printf("Creating %s for collapse%s...", finfo.path,
-	       finfo.type == VMA_SHMEM ? " (tmpfs)" : "");
+	ksft_print_msg("Creating %s for collapse%s...\n", finfo.path,
+		       finfo.type == VMA_SHMEM ? " (tmpfs)" : "");
 	fd = open(finfo.path, O_DSYNC | O_CREAT | O_RDWR | O_TRUNC | O_EXCL,
 		  777);
-	if (fd < 0) {
-		perror("open()");
-		exit(EXIT_FAILURE);
-	}
+	if (fd < 0)
+		ksft_exit_fail_msg("open(): %s\n", strerror(errno));
 
 	size = nr_hpages * hpage_pmd_size;
 	p = alloc_mapping(nr_hpages);
@@ -388,18 +361,15 @@ static void *file_setup_area(int nr_hpages)
 	munmap(p, size);
 	success("OK");
 
-	printf("Opening %s read only for collapse...", finfo.path);
+	ksft_print_msg("Opening %s read only for collapse...\n", finfo.path);
 	finfo.fd = open(finfo.path, O_RDONLY, 777);
-	if (finfo.fd < 0) {
-		perror("open()");
-		exit(EXIT_FAILURE);
-	}
+	if (finfo.fd < 0)
+		ksft_exit_fail_msg("open(): %s\n", strerror(errno));
+
 	p = mmap(BASE_ADDR, size, PROT_READ | PROT_EXEC,
 		 MAP_PRIVATE, finfo.fd, 0);
-	if (p == MAP_FAILED || p != BASE_ADDR) {
-		perror("mmap()");
-		exit(EXIT_FAILURE);
-	}
+	if (p == MAP_FAILED || p != BASE_ADDR)
+		ksft_exit_fail_msg("mmap(): %s\n", strerror(errno));
 
 	/* Drop page cache */
 	write_file("/proc/sys/vm/drop_caches", "3", 2);
@@ -416,10 +386,8 @@ static void file_cleanup_area(void *p, unsigned long size)
 
 static void file_fault(void *p, unsigned long start, unsigned long end)
 {
-	if (madvise(((char *)p) + start, end - start, MADV_POPULATE_READ)) {
-		perror("madvise(MADV_POPULATE_READ");
-		exit(EXIT_FAILURE);
-	}
+	if (madvise(((char *)p) + start, end - start, MADV_POPULATE_READ))
+		ksft_exit_fail_msg("madvise(MADV_POPULATE_READ: %s\n", strerror(errno));
 }
 
 static bool file_check_huge(void *addr, int nr_hpages)
@@ -430,7 +398,7 @@ static bool file_check_huge(void *addr, int nr_hpages)
 	case VMA_SHMEM:
 		return check_huge_shmem(addr, nr_hpages, hpage_pmd_size);
 	default:
-		exit(EXIT_FAILURE);
+		ksft_exit_fail_msg("Wrong type\n");
 		return false;
 	}
 }
@@ -441,20 +409,16 @@ static void *shmem_setup_area(int nr_hpages)
 	unsigned long size = nr_hpages * hpage_pmd_size;
 
 	finfo.fd = memfd_create("khugepaged-selftest-collapse-shmem", 0);
-	if (finfo.fd < 0)  {
-		perror("memfd_create()");
-		exit(EXIT_FAILURE);
-	}
-	if (ftruncate(finfo.fd, size)) {
-		perror("ftruncate()");
-		exit(EXIT_FAILURE);
-	}
-	p = mmap(BASE_ADDR, size, PROT_READ | PROT_WRITE, MAP_SHARED, finfo.fd,
-		 0);
-	if (p != BASE_ADDR) {
-		perror("mmap()");
-		exit(EXIT_FAILURE);
-	}
+	if (finfo.fd < 0)
+		ksft_exit_fail_msg("memfd_create(): %s\n", strerror(errno));
+
+	if (ftruncate(finfo.fd, size))
+		ksft_exit_fail_msg("ftruncate(): %s\n", strerror(errno));
+
+	p = mmap(BASE_ADDR, size, PROT_READ | PROT_WRITE, MAP_SHARED, finfo.fd, 0);
+	if (p != BASE_ADDR)
+		ksft_exit_fail_msg("mmap(): %s\n", strerror(errno));
+
 	return p;
 }
 
@@ -499,7 +463,7 @@ static void __madvise_collapse(const char *msg, char *p, int nr_hpages,
 	int ret;
 	struct thp_settings settings = *thp_current_settings();
 
-	printf("%s...", msg);
+	ksft_print_msg("%s...\n", msg);
 
 	/*
 	 * Prevent khugepaged interference and tests that MADV_COLLAPSE
@@ -526,10 +490,9 @@ static void madvise_collapse(const char *msg, char *p, int nr_hpages,
 			     struct mem_ops *ops, bool expect)
 {
 	/* Sanity check */
-	if (!ops->check_huge(p, 0)) {
-		printf("Unexpected huge page\n");
-		exit(EXIT_FAILURE);
-	}
+	if (!ops->check_huge(p, 0))
+		ksft_exit_fail_msg("Unexpected huge page\n");
+
 	__madvise_collapse(msg, p, nr_hpages, ops, expect);
 }
 
@@ -541,23 +504,20 @@ static bool wait_for_scan(const char *msg, char *p, int nr_hpages,
 	int timeout = 6; /* 3 seconds */
 
 	/* Sanity check */
-	if (!ops->check_huge(p, 0)) {
-		printf("Unexpected huge page\n");
-		exit(EXIT_FAILURE);
-	}
+	if (!ops->check_huge(p, 0))
+		ksft_exit_fail_msg("Unexpected huge page\n");
 
 	madvise(p, nr_hpages * hpage_pmd_size, MADV_HUGEPAGE);
 
 	/* Wait until the second full_scan completed */
 	full_scans = thp_read_num("khugepaged/full_scans") + 2;
 
-	printf("%s...", msg);
+	ksft_print_msg("%s...\n", msg);
 	while (timeout--) {
 		if (ops->check_huge(p, nr_hpages))
 			break;
 		if (thp_read_num("khugepaged/full_scans") >= full_scans)
 			break;
-		printf(".");
 		usleep(TICK);
 	}
 
@@ -623,7 +583,7 @@ static void alloc_at_fault(void)
 
 	p = alloc_mapping(1);
 	*p = 1;
-	printf("Allocate huge page on fault...");
+	ksft_print_msg("Allocate huge page on fault...\n");
 	if (check_huge_anon(p, 1, hpage_pmd_size))
 		success("OK");
 	else
@@ -632,7 +592,7 @@ static void alloc_at_fault(void)
 	thp_pop_settings();
 
 	madvise(p, page_size, MADV_DONTNEED);
-	printf("Split huge PMD on MADV_DONTNEED...");
+	ksft_print_msg("Split huge PMD on MADV_DONTNEED...\n");
 	if (check_huge_anon(p, 0, hpage_pmd_size))
 		success("OK");
 	else
@@ -688,7 +648,7 @@ static void collapse_max_ptes_none(struct collapse_context *c, struct mem_ops *o
 
 	if (is_tmpfs(ops)) {
 		/* shmem pages always in the page cache */
-		printf("tmpfs...");
+		ksft_print_msg("tmpfs...\n");
 		skip("Skip");
 		goto skip;
 	}
@@ -717,11 +677,10 @@ static void collapse_swapin_single_pte(struct collapse_context *c, struct mem_op
 	p = ops->setup_area(1);
 	ops->fault(p, 0, hpage_pmd_size);
 
-	printf("Swapout one page...");
-	if (madvise(p, page_size, MADV_PAGEOUT)) {
-		perror("madvise(MADV_PAGEOUT)");
-		exit(EXIT_FAILURE);
-	}
+	ksft_print_msg("Swapout one page...\n");
+	if (madvise(p, page_size, MADV_PAGEOUT))
+		ksft_exit_fail_msg("madvise(MADV_PAGEOUT): %s\n", strerror(errno));
+
 	if (check_swap(p, page_size)) {
 		success("OK");
 	} else {
@@ -744,11 +703,10 @@ static void collapse_max_ptes_swap(struct collapse_context *c, struct mem_ops *o
 	p = ops->setup_area(1);
 	ops->fault(p, 0, hpage_pmd_size);
 
-	printf("Swapout %d of %d pages...", max_ptes_swap + 1, hpage_pmd_nr);
-	if (madvise(p, (max_ptes_swap + 1) * page_size, MADV_PAGEOUT)) {
-		perror("madvise(MADV_PAGEOUT)");
-		exit(EXIT_FAILURE);
-	}
+	ksft_print_msg("Swapout %d of %d pages...\n", max_ptes_swap + 1, hpage_pmd_nr);
+	if (madvise(p, (max_ptes_swap + 1) * page_size, MADV_PAGEOUT))
+		ksft_exit_fail_msg("madvise(MADV_PAGEOUT): %s\n", strerror(errno));
+
 	if (check_swap(p, (max_ptes_swap + 1) * page_size)) {
 		success("OK");
 	} else {
@@ -762,12 +720,11 @@ static void collapse_max_ptes_swap(struct collapse_context *c, struct mem_ops *o
 
 	if (c->enforce_pte_scan_limits) {
 		ops->fault(p, 0, hpage_pmd_size);
-		printf("Swapout %d of %d pages...", max_ptes_swap,
+		ksft_print_msg("Swapout %d of %d pages...\n", max_ptes_swap,
 		       hpage_pmd_nr);
-		if (madvise(p, max_ptes_swap * page_size, MADV_PAGEOUT)) {
-			perror("madvise(MADV_PAGEOUT)");
-			exit(EXIT_FAILURE);
-		}
+		if (madvise(p, max_ptes_swap * page_size, MADV_PAGEOUT))
+			ksft_exit_fail_msg("madvise(MADV_PAGEOUT): %s\n", strerror(errno));
+
 		if (check_swap(p, max_ptes_swap * page_size)) {
 			success("OK");
 		} else {
@@ -791,13 +748,13 @@ static void collapse_single_pte_entry_compound(struct collapse_context *c, struc
 
 	if (is_tmpfs(ops)) {
 		/* MADV_DONTNEED won't evict tmpfs pages */
-		printf("tmpfs...");
+		ksft_print_msg("tmpfs...\n");
 		skip("Skip");
 		goto skip;
 	}
 
 	madvise(p, hpage_pmd_size, MADV_NOHUGEPAGE);
-	printf("Split huge page leaving single PTE mapping compound page...");
+	ksft_print_msg("Split huge page leaving single PTE mapping compound page...\n");
 	madvise(p + page_size, hpage_pmd_size - page_size, MADV_DONTNEED);
 	if (ops->check_huge(p, 0))
 		success("OK");
@@ -816,7 +773,7 @@ static void collapse_full_of_compound(struct collapse_context *c, struct mem_ops
 	void *p;
 
 	p = alloc_hpage(ops);
-	printf("Split huge page leaving single PTE page table full of compound pages...");
+	ksft_print_msg("Split huge page leaving single PTE page table full of compound pages...\n");
 	madvise(p, page_size, MADV_NOHUGEPAGE);
 	madvise(p, hpage_pmd_size, MADV_NOHUGEPAGE);
 	if (ops->check_huge(p, 0))
@@ -837,15 +794,14 @@ static void collapse_compound_extreme(struct collapse_context *c, struct mem_ops
 
 	p = ops->setup_area(1);
 	for (i = 0; i < hpage_pmd_nr; i++) {
-		printf("\rConstruct PTE page table full of different PTE-mapped compound pages %3d/%d...",
-				i + 1, hpage_pmd_nr);
+		ksft_print_msg("\rConstruct PTE page table full of different PTE-mapped "
+			       "compound pages %3d/%d...", i + 1, hpage_pmd_nr);
 
 		madvise(BASE_ADDR, hpage_pmd_size, MADV_HUGEPAGE);
 		ops->fault(BASE_ADDR, 0, hpage_pmd_size);
-		if (!ops->check_huge(BASE_ADDR, 1)) {
-			printf("Failed to allocate huge page\n");
-			exit(EXIT_FAILURE);
-		}
+		if (!ops->check_huge(BASE_ADDR, 1))
+			ksft_exit_fail_msg("Failed to allocate huge page\n");
+
 		madvise(BASE_ADDR, hpage_pmd_size, MADV_NOHUGEPAGE);
 
 		p = mremap(BASE_ADDR - i * page_size,
@@ -853,22 +809,20 @@ static void collapse_compound_extreme(struct collapse_context *c, struct mem_ops
 				(i + 1) * page_size,
 				MREMAP_MAYMOVE | MREMAP_FIXED,
 				BASE_ADDR + 2 * hpage_pmd_size);
-		if (p == MAP_FAILED) {
-			perror("mremap+unmap");
-			exit(EXIT_FAILURE);
-		}
+		if (p == MAP_FAILED)
+			ksft_exit_fail_msg("mremap+unmap: %s\n", strerror(errno));
 
 		p = mremap(BASE_ADDR + 2 * hpage_pmd_size,
 				(i + 1) * page_size,
 				(i + 1) * page_size + hpage_pmd_size,
 				MREMAP_MAYMOVE | MREMAP_FIXED,
 				BASE_ADDR - (i + 1) * page_size);
-		if (p == MAP_FAILED) {
-			perror("mremap+alloc");
-			exit(EXIT_FAILURE);
-		}
+		if (p == MAP_FAILED)
+			ksft_exit_fail_msg("mremap+alloc: %s\n", strerror(errno));
 	}
 
+	ksft_print_msg("\n");
+
 	ops->cleanup_area(BASE_ADDR, hpage_pmd_size);
 	ops->fault(p, 0, hpage_pmd_size);
 	if (!ops->check_huge(p, 1))
@@ -890,23 +844,19 @@ static void collapse_fork(struct collapse_context *c, struct mem_ops *ops)
 
 	p = ops->setup_area(1);
 
-	printf("Allocate small page...");
+	ksft_print_msg("Allocate small page...\n");
 	ops->fault(p, 0, page_size);
 	if (ops->check_huge(p, 0))
 		success("OK");
 	else
 		fail("Fail");
 
-	printf("Share small page over fork()...");
+	ksft_print_msg("Share small page over fork()...\n");
 	if (!fork()) {
 		/* Do not touch settings on child exit */
 		skip_settings_restore = true;
-		exit_status = 0;
 
-		if (ops->check_huge(p, 0))
-			success("OK");
-		else
-			fail("Fail");
+		ksft_test_result(ops->check_huge(p, 0), "%s: child\n", __func__);
 
 		ops->fault(p, page_size, 2 * page_size);
 		c->collapse("Collapse PTE table with single page shared with parent process",
@@ -914,13 +864,12 @@ static void collapse_fork(struct collapse_context *c, struct mem_ops *ops)
 
 		validate_memory(p, 0, page_size);
 		ops->cleanup_area(p, hpage_pmd_size);
-		exit(exit_status);
+		exit(0);
 	}
 
 	wait(&wstatus);
-	exit_status += WEXITSTATUS(wstatus);
 
-	printf("Check if parent still has small page...");
+	ksft_print_msg("Check if parent still has small page...\n");
 	if (ops->check_huge(p, 0))
 		success("OK");
 	else
@@ -931,22 +880,17 @@ static void collapse_fork(struct collapse_context *c, struct mem_ops *ops)
 
 static void collapse_fork_compound(struct collapse_context *c, struct mem_ops *ops)
 {
-	int wstatus;
 	void *p;
 
 	p = alloc_hpage(ops);
-	printf("Share huge page over fork()...");
+	ksft_print_msg("Share huge page over fork()...\n");
 	if (!fork()) {
 		/* Do not touch settings on child exit */
 		skip_settings_restore = true;
-		exit_status = 0;
 
-		if (ops->check_huge(p, 1))
-			success("OK");
-		else
-			fail("Fail");
+		ksft_test_result(ops->check_huge(p, 1), "%s: child\n", __func__);
 
-		printf("Split huge page PMD in child process...");
+		ksft_print_msg("Split huge page PMD in child process...\n");
 		madvise(p, page_size, MADV_NOHUGEPAGE);
 		madvise(p, hpage_pmd_size, MADV_NOHUGEPAGE);
 		if (ops->check_huge(p, 0))
@@ -963,13 +907,12 @@ static void collapse_fork_compound(struct collapse_context *c, struct mem_ops *o
 
 		validate_memory(p, 0, hpage_pmd_size);
 		ops->cleanup_area(p, hpage_pmd_size);
-		exit(exit_status);
+		exit(0);
 	}
 
-	wait(&wstatus);
-	exit_status += WEXITSTATUS(wstatus);
+	wait(NULL);
 
-	printf("Check if parent still has huge page...");
+	ksft_print_msg("Check if parent still has huge page...\n");
 	if (ops->check_huge(p, 1))
 		success("OK");
 	else
@@ -981,23 +924,18 @@ static void collapse_fork_compound(struct collapse_context *c, struct mem_ops *o
 static void collapse_max_ptes_shared(struct collapse_context *c, struct mem_ops *ops)
 {
 	int max_ptes_shared = thp_read_num("khugepaged/max_ptes_shared");
-	int wstatus;
 	void *p;
 
 	p = alloc_hpage(ops);
-	printf("Share huge page over fork()...");
+	ksft_print_msg("Share huge page over fork()...\n");
 	if (!fork()) {
 		/* Do not touch settings on child exit */
 		skip_settings_restore = true;
-		exit_status = 0;
 
-		if (ops->check_huge(p, 1))
-			success("OK");
-		else
-			fail("Fail");
+		ksft_test_result(ops->check_huge(p, 1), "%s: child\n", __func__);
 
-		printf("Trigger CoW on page %d of %d...",
-				hpage_pmd_nr - max_ptes_shared - 1, hpage_pmd_nr);
+		ksft_print_msg("Trigger CoW on page %d of %d...\n",
+			       hpage_pmd_nr - max_ptes_shared - 1, hpage_pmd_nr);
 		ops->fault(p, 0, (hpage_pmd_nr - max_ptes_shared - 1) * page_size);
 		if (ops->check_huge(p, 0))
 			success("OK");
@@ -1008,8 +946,8 @@ static void collapse_max_ptes_shared(struct collapse_context *c, struct mem_ops
 			    1, ops, !c->enforce_pte_scan_limits);
 
 		if (c->enforce_pte_scan_limits) {
-			printf("Trigger CoW on page %d of %d...",
-			       hpage_pmd_nr - max_ptes_shared, hpage_pmd_nr);
+			ksft_print_msg("Trigger CoW on page %d of %d...\n",
+				       hpage_pmd_nr - max_ptes_shared, hpage_pmd_nr);
 			ops->fault(p, 0, (hpage_pmd_nr - max_ptes_shared) *
 				    page_size);
 			if (ops->check_huge(p, 0))
@@ -1023,13 +961,12 @@ static void collapse_max_ptes_shared(struct collapse_context *c, struct mem_ops
 
 		validate_memory(p, 0, hpage_pmd_size);
 		ops->cleanup_area(p, hpage_pmd_size);
-		exit(exit_status);
+		exit(0);
 	}
 
-	wait(&wstatus);
-	exit_status += WEXITSTATUS(wstatus);
+	wait(NULL);
 
-	printf("Check if parent still has huge page...");
+	ksft_print_msg("Check if parent still has huge page...\n");
 	if (ops->check_huge(p, 1))
 		success("OK");
 	else
@@ -1083,20 +1020,19 @@ static void madvise_retracted_page_tables(struct collapse_context *c,
 
 static void usage(void)
 {
-	fprintf(stderr, "\nUsage: ./khugepaged [OPTIONS] <test type> [dir]\n\n");
-	fprintf(stderr, "\t<test type>\t: <context>:<mem_type>\n");
-	fprintf(stderr, "\t<context>\t: [all|khugepaged|madvise]\n");
-	fprintf(stderr, "\t<mem_type>\t: [all|anon|file|shmem]\n");
-	fprintf(stderr, "\n\t\"file,all\" mem_type requires [dir] argument\n");
-	fprintf(stderr, "\n\t\"file,all\" mem_type requires kernel built with\n");
-	fprintf(stderr,	"\tCONFIG_READ_ONLY_THP_FOR_FS=y\n");
-	fprintf(stderr, "\n\tif [dir] is a (sub)directory of a tmpfs mount, tmpfs must be\n");
-	fprintf(stderr,	"\tmounted with huge=madvise option for khugepaged tests to work\n");
-	fprintf(stderr,	"\n\tSupported Options:\n");
-	fprintf(stderr,	"\t\t-h: This help message.\n");
-	fprintf(stderr,	"\t\t-s: mTHP size, expressed as page order.\n");
-	fprintf(stderr,	"\t\t    Defaults to 0. Use this size for anon allocations.\n");
-	exit(1);
+	ksft_print_msg("\nUsage: ./khugepaged [OPTIONS] <test type> [dir]\n\n");
+	ksft_print_msg("\t<test type>\t: <context>:<mem_type>\n");
+	ksft_print_msg("\t<context>\t: [all|khugepaged|madvise]\n");
+	ksft_print_msg("\t<mem_type>\t: [all|anon|file|shmem]\n");
+	ksft_print_msg("\n\t\"file,all\" mem_type requires [dir] argument\n");
+	ksft_print_msg("\n\t\"file,all\" mem_type requires kernel built with\n");
+	ksft_print_msg("\tCONFIG_READ_ONLY_THP_FOR_FS=y\n");
+	ksft_print_msg("\n\tif [dir] is a (sub)directory of a tmpfs mount, tmpfs must be\n");
+	ksft_print_msg("\tmounted with huge=madvise option for khugepaged tests to work\n");
+	ksft_print_msg("\n\tSupported Options:\n");
+	ksft_print_msg("\t\t-h: This help message.\n");
+	ksft_print_msg("\t\t-s: mTHP size, expressed as page order.\n");
+	ksft_exit_fail_msg("\t\t    Defaults to 0. Use this size for anon allocations.\n");
 }
 
 static void parse_test_type(int argc, char **argv)
@@ -1190,16 +1126,21 @@ int main(int argc, char **argv)
 		.read_ahead_kb = 0,
 	};
 
+	ksft_print_header();
+
+	if (getuid())
+		ksft_finished();
+
+	ksft_set_plan(65);
+
 	parse_test_type(argc, argv);
 
 	setbuf(stdout, NULL);
 
 	page_size = getpagesize();
 	hpage_pmd_size = read_pmd_pagesize();
-	if (!hpage_pmd_size) {
-		printf("Reading PMD pagesize failed");
-		exit(EXIT_FAILURE);
-	}
+	if (!hpage_pmd_size)
+		ksft_exit_fail_msg("Reading PMD pagesize failed\n");
 	hpage_pmd_nr = hpage_pmd_size / page_size;
 	hpage_pmd_order = __builtin_ctz(hpage_pmd_nr);
 
@@ -1217,7 +1158,7 @@ int main(int argc, char **argv)
 
 #define TEST(t, c, o) do { \
 	if (c && o) { \
-		printf("\nRun test: " #t " (%s:%s)\n", c->name, o->name); \
+		ksft_print_msg("Run test: " #t " (%s:%s)\n", c->name, o->name); \
 		t(c, o); \
 	} \
 	} while (0)
@@ -1281,5 +1222,5 @@ int main(int argc, char **argv)
 	TEST(madvise_retracted_page_tables, madvise_context, file_ops);
 	TEST(madvise_retracted_page_tables, madvise_context, shmem_ops);
 
-	restore_settings(0);
+	ksft_finished();
 }
-- 
2.42.0


