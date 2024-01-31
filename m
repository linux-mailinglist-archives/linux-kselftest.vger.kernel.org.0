Return-Path: <linux-kselftest+bounces-3842-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17426844152
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jan 2024 15:07:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0C162855AC
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jan 2024 14:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2788128386;
	Wed, 31 Jan 2024 14:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="0cZEqd/x"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCDA886AE7;
	Wed, 31 Jan 2024 14:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706709941; cv=none; b=QBUX6zN9AHtfUNMooEjG3U1YTDz8Vme/jz2vCQK451dYruwKuelpTM0hqQjgOBrgCzp9tDU0FGjgUhlHEGDjby0XfKuKi4AJAVdQ5AtTVcla1eBycbQcXmM70K/AtAhKzTqh1E6Ax2fl3c3ffZNE2VVKAVx+JcSGd+ObVPfQEYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706709941; c=relaxed/simple;
	bh=phT1qh4JSwaGJfIJ4Mc7ECbFwdGcURcGclR3lGXRi70=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mFgDtYK+sa+kIAkSxy6bpZdvGudfeR1pVw/IYUqntPhgpombKBLEUqocDix4flNMqAjvWVJshvi44s/MmhnbqlY3MkY1akGXg2XjW8vCYvrx0tcjDO1urY1VhQYLyBmqnN4Gyg82suhoe+L7e6KudRplETAhXX+qn5FALOG1f2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=0cZEqd/x; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1706709938;
	bh=phT1qh4JSwaGJfIJ4Mc7ECbFwdGcURcGclR3lGXRi70=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=0cZEqd/xtcCbUc8Te+lSugu4cqQorSPM5s57Kx4aC2yXDEPK7y1mnDLe6ZeB6yQcS
	 QzgKd5h4qIlh+00kHu2u20ttHXZFx6O72qpjUQkEhA+z33Xt7vET4loEazi2e7t716
	 sNZsrqU1snBFAEI4AfmTfYhdCGXWC6t8T2oQTNOEr8zT2O4neQ/xL26BtxIiDRSHlH
	 upnu6Ac3NYgZi3di2sKb36uNmkqAEhL5j28gsKXKk1f8r0qpZSRI1mcaJCGGtq6TyW
	 j+rLhGsDmAZHGGk6Arr1KPZfexaw0O1LTEhnFne/zDwLwLycNUa7fiPJokN7NnyebT
	 cgnw2jh75RRfQ==
Received: from localhost.localdomain (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id D1F0D378206B;
	Wed, 31 Jan 2024 14:05:36 +0000 (UTC)
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
	kernel@collabora.com,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 10/12] selftests/mm: thuge-gen: conform to TAP format output
Date: Wed, 31 Jan 2024 19:05:20 +0500
Message-ID: <20240131140528.320252-10-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240131140528.320252-1-usama.anjum@collabora.com>
References: <20240131140528.320252-1-usama.anjum@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Conform the layout, informational and status messages to TAP. No
functional change is intended other than the layout of output messages.

Also remove un-needed logging which isn't enabled. Skip a hugepage size
if it has less free pages to avoid unnecessary failures. For examples,
some systems may not have 1GB hugepage free. So skip 1GB for testing in
this test instead of failing the entire test.

Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
 tools/testing/selftests/mm/thuge-gen.c | 147 +++++++++++++------------
 1 file changed, 75 insertions(+), 72 deletions(-)

diff --git a/tools/testing/selftests/mm/thuge-gen.c b/tools/testing/selftests/mm/thuge-gen.c
index 622987f12c89a..ea7fd8fe28763 100644
--- a/tools/testing/selftests/mm/thuge-gen.c
+++ b/tools/testing/selftests/mm/thuge-gen.c
@@ -4,7 +4,7 @@
    Before running this huge pages for each huge page size must have been
    reserved.
    For large pages beyond MAX_PAGE_ORDER (like 1GB on x86) boot options must
-   be used.
+   be used. 1GB wouldn't be tested if it isn't available.
    Also shmmax must be increased.
    And you need to run as root to work around some weird permissions in shm.
    And nothing using huge pages should run in parallel.
@@ -26,8 +26,7 @@
 #include <stdarg.h>
 #include <string.h>
 #include "vm_util.h"
-
-#define err(x) perror(x), exit(1)
+#include "../kselftest.h"
 
 #define MAP_HUGE_2MB    (21 << MAP_HUGE_SHIFT)
 #define MAP_HUGE_1GB    (30 << MAP_HUGE_SHIFT)
@@ -44,11 +43,8 @@
 #define SHM_HUGE_1GB    (30 << SHM_HUGE_SHIFT)
 
 #define NUM_PAGESIZES   5
-
 #define NUM_PAGES 4
 
-#define Dprintf(fmt...) // printf(fmt)
-
 unsigned long page_sizes[NUM_PAGESIZES];
 int num_page_sizes;
 
@@ -60,28 +56,15 @@ int ilog2(unsigned long v)
 	return l;
 }
 
-void find_pagesizes(void)
-{
-	glob_t g;
-	int i;
-	glob("/sys/kernel/mm/hugepages/hugepages-*kB", 0, NULL, &g);
-	assert(g.gl_pathc <= NUM_PAGESIZES);
-	for (i = 0; i < g.gl_pathc; i++) {
-		sscanf(g.gl_pathv[i], "/sys/kernel/mm/hugepages/hugepages-%lukB",
-				&page_sizes[i]);
-		page_sizes[i] <<= 10;
-		printf("Found %luMB\n", page_sizes[i] >> 20);
-	}
-	num_page_sizes = g.gl_pathc;
-	globfree(&g);
-}
-
 void show(unsigned long ps)
 {
 	char buf[100];
+
 	if (ps == getpagesize())
 		return;
-	printf("%luMB: ", ps >> 20);
+
+	ksft_print_msg("%luMB: ", ps >> 20);
+
 	fflush(stdout);
 	snprintf(buf, sizeof buf,
 		"cat /sys/kernel/mm/hugepages/hugepages-%lukB/free_hugepages",
@@ -105,7 +88,7 @@ unsigned long read_sysfs(int warn, char *fmt, ...)
 	f = fopen(buf, "r");
 	if (!f) {
 		if (warn)
-			printf("missing %s\n", buf);
+			ksft_print_msg("missing %s\n", buf);
 		return 0;
 	}
 	if (getline(&line, &linelen, f) > 0) {
@@ -119,123 +102,143 @@ unsigned long read_sysfs(int warn, char *fmt, ...)
 unsigned long read_free(unsigned long ps)
 {
 	return read_sysfs(ps != getpagesize(),
-			"/sys/kernel/mm/hugepages/hugepages-%lukB/free_hugepages",
-			ps >> 10);
+			  "/sys/kernel/mm/hugepages/hugepages-%lukB/free_hugepages",
+			  ps >> 10);
 }
 
 void test_mmap(unsigned long size, unsigned flags)
 {
 	char *map;
 	unsigned long before, after;
-	int err;
 
 	before = read_free(size);
 	map = mmap(NULL, size*NUM_PAGES, PROT_READ|PROT_WRITE,
 			MAP_PRIVATE|MAP_ANONYMOUS|MAP_HUGETLB|flags, -1, 0);
+	if (map == MAP_FAILED)
+		ksft_exit_fail_msg("mmap: %s\n", strerror(errno));
 
-	if (map == (char *)-1) err("mmap");
 	memset(map, 0xff, size*NUM_PAGES);
 	after = read_free(size);
-	Dprintf("before %lu after %lu diff %ld size %lu\n",
-		before, after, before - after, size);
-	assert(size == getpagesize() || (before - after) == NUM_PAGES);
+
 	show(size);
-	err = munmap(map, size * NUM_PAGES);
-	assert(!err);
+	ksft_test_result(size == getpagesize() || (before - after) == NUM_PAGES,
+			 "%s mmap\n", __func__);
+
+	if (munmap(map, size * NUM_PAGES))
+		ksft_exit_fail_msg("%s: unmap %s\n", __func__, strerror(errno));
 }
 
 void test_shmget(unsigned long size, unsigned flags)
 {
 	int id;
 	unsigned long before, after;
-	int err;
+	struct shm_info i;
+	char *map;
 
 	before = read_free(size);
 	id = shmget(IPC_PRIVATE, size * NUM_PAGES, IPC_CREAT|0600|flags);
-	if (id < 0) err("shmget");
-
-	struct shm_info i;
-	if (shmctl(id, SHM_INFO, (void *)&i) < 0) err("shmctl");
-	Dprintf("alloc %lu res %lu\n", i.shm_tot, i.shm_rss);
+	if (id < 0) {
+		if (errno == EPERM) {
+			ksft_test_result_skip("shmget requires root privileges: %s\n",
+					      strerror(errno));
+			return;
+		}
+		ksft_exit_fail_msg("shmget: %s\n", strerror(errno));
+	}
 
+	if (shmctl(id, SHM_INFO, (void *)&i) < 0)
+		ksft_exit_fail_msg("shmctl: %s\n", strerror(errno));
 
-	Dprintf("id %d\n", id);
-	char *map = shmat(id, NULL, 0600);
-	if (map == (char*)-1) err("shmat");
+	map = shmat(id, NULL, 0600);
+	if (map == MAP_FAILED)
+		ksft_exit_fail_msg("shmat: %s\n", strerror(errno));
 
 	shmctl(id, IPC_RMID, NULL);
 
 	memset(map, 0xff, size*NUM_PAGES);
 	after = read_free(size);
 
-	Dprintf("before %lu after %lu diff %ld size %lu\n",
-		before, after, before - after, size);
-	assert(size == getpagesize() || (before - after) == NUM_PAGES);
 	show(size);
-	err = shmdt(map);
-	assert(!err);
+	ksft_test_result(size == getpagesize() || (before - after) == NUM_PAGES,
+			 "%s: mmap\n", __func__);
+	if (shmdt(map))
+		ksft_exit_fail_msg("%s: shmdt: %s\n", __func__, strerror(errno));
 }
 
-void sanity_checks(void)
+void find_pagesizes(void)
 {
-	int i;
 	unsigned long largest = getpagesize();
+	int i;
+	glob_t g;
 
-	for (i = 0; i < num_page_sizes; i++) {
-		if (page_sizes[i] > largest)
+	glob("/sys/kernel/mm/hugepages/hugepages-*kB", 0, NULL, &g);
+	assert(g.gl_pathc <= NUM_PAGESIZES);
+	for (i = 0; (i < g.gl_pathc) && (num_page_sizes < NUM_PAGESIZES); i++) {
+		sscanf(g.gl_pathv[i], "/sys/kernel/mm/hugepages/hugepages-%lukB",
+				&page_sizes[num_page_sizes]);
+		page_sizes[num_page_sizes] <<= 10;
+		ksft_print_msg("Found %luMB\n", page_sizes[i] >> 20);
+
+		if (page_sizes[num_page_sizes] > largest)
 			largest = page_sizes[i];
 
-		if (read_free(page_sizes[i]) < NUM_PAGES) {
-			printf("Not enough huge pages for page size %lu MB, need %u\n",
-				page_sizes[i] >> 20,
-				NUM_PAGES);
-			exit(0);
-		}
+		if (read_free(page_sizes[num_page_sizes]) >= NUM_PAGES)
+			num_page_sizes++;
+		else
+			ksft_print_msg("SKIP for size %lu MB as not enough huge pages, need %u\n",
+				       page_sizes[num_page_sizes] >> 20, NUM_PAGES);
 	}
+	globfree(&g);
 
-	if (read_sysfs(0, "/proc/sys/kernel/shmmax") < NUM_PAGES * largest) {
-		printf("Please do echo %lu > /proc/sys/kernel/shmmax", largest * NUM_PAGES);
-		exit(0);
-	}
+	if (read_sysfs(0, "/proc/sys/kernel/shmmax") < NUM_PAGES * largest)
+		ksft_exit_fail_msg("Please do echo %lu > /proc/sys/kernel/shmmax",
+				   largest * NUM_PAGES);
 
 #if defined(__x86_64__)
 	if (largest != 1U<<30) {
-		printf("No GB pages available on x86-64\n"
-		       "Please boot with hugepagesz=1G hugepages=%d\n", NUM_PAGES);
-		exit(0);
+		ksft_exit_fail_msg("No GB pages available on x86-64\n"
+				   "Please boot with hugepagesz=1G hugepages=%d\n", NUM_PAGES);
 	}
 #endif
 }
 
 int main(void)
 {
-	int i;
 	unsigned default_hps = default_huge_page_size();
+	int i;
+
+	ksft_print_header();
 
 	find_pagesizes();
 
-	sanity_checks();
+	if (!num_page_sizes)
+		ksft_finished();
+
+	ksft_set_plan(2 * num_page_sizes + 3);
 
 	for (i = 0; i < num_page_sizes; i++) {
 		unsigned long ps = page_sizes[i];
 		int arg = ilog2(ps) << MAP_HUGE_SHIFT;
-		printf("Testing %luMB mmap with shift %x\n", ps >> 20, arg);
+
+		ksft_print_msg("Testing %luMB mmap with shift %x\n", ps >> 20, arg);
 		test_mmap(ps, MAP_HUGETLB | arg);
 	}
-	printf("Testing default huge mmap\n");
+
+	ksft_print_msg("Testing default huge mmap\n");
 	test_mmap(default_hps, MAP_HUGETLB);
 
-	puts("Testing non-huge shmget");
+	ksft_print_msg("Testing non-huge shmget\n");
 	test_shmget(getpagesize(), 0);
 
 	for (i = 0; i < num_page_sizes; i++) {
 		unsigned long ps = page_sizes[i];
 		int arg = ilog2(ps) << SHM_HUGE_SHIFT;
-		printf("Testing %luMB shmget with shift %x\n", ps >> 20, arg);
+		ksft_print_msg("Testing %luMB shmget with shift %x\n", ps >> 20, arg);
 		test_shmget(ps, SHM_HUGETLB | arg);
 	}
-	puts("default huge shmget");
+
+	ksft_print_msg("default huge shmget\n");
 	test_shmget(default_hps, SHM_HUGETLB);
 
-	return 0;
+	ksft_finished();
 }
-- 
2.42.0


