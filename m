Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 781AF4C379A
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Feb 2022 22:24:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234725AbiBXVZO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 24 Feb 2022 16:25:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234704AbiBXVZN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 24 Feb 2022 16:25:13 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C04828D381;
        Thu, 24 Feb 2022 13:24:39 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: usama.anjum)
        with ESMTPSA id 608EA1F45848
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1645737878;
        bh=pGCQYzOepqBCgJy34qPEw4wPUhux0o8o8yQVZdkzs9A=;
        h=From:To:Cc:Subject:Date:From;
        b=AmXkgtIE1JFlTkb3JWSwnfj+xcTAOxa2K9NPag3D6QJiiUhLTqcjWM+kv6rayqG0z
         GdttM+9yXyu+pJovNY8L+TiJaMYYlSeHOgRLGKj/hQQ0NEJw15fQ40VOFXYTaxRinu
         sTHxEFYCH16XCzBF+tMLte1HhOh66h6wVWzKjij5QE1WnxU+kF0+wHa/1HGa4nNQbj
         hjOdQaCScigpAOair6d0duQPQwJ7pgVggndLg3FyDdA4fDZSn1gnwAZDjAQLuyru8L
         Hcu85Kftgqh+wfF7I51RUTP+rLBCUWG3uBuKoaGZzlFM1yf6hqT8gJN+hxsLus1oPT
         cM/UYVOfBq+1Q==
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        kernel@collabora.com, kernelci@groups.io,
        Will Deacon <will@kernel.org>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH V3] selftests: vm: Add test for Soft-Dirty PTE bit
Date:   Fri, 25 Feb 2022 02:23:35 +0500
Message-Id: <20220224212335.3045905-1-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This introduces three tests:
1) Sanity check soft dirty basic semantics: allocate area, clean, dirty,
check if the SD bit flipped.
2) Check VMA reuse: validate the VM_SOFTDIRTY usage
3) Check soft-dirty on huge pages

This was motivated by Will Deacon's fix commit 912efa17e512 ("mm: proc:
Invalidate TLB after clearing soft-dirty page state"). I was tracking the
same issue that he fixed, and this test would have caught it.

Cc: Will Deacon <will@kernel.org>
Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
Changes in V3:
Move test to selftests/vm
Use kselftest macros
Minor updates to make code more maintainable
Add configurations in config file

Tests of soft dirty bit in this patch and in
selftest/vm/madv_populate.c are non-overlapping.

V2 of this patch:
https://lore.kernel.org/lkml/20210603151518.2437813-1-krisman@collabora.com/
---
 tools/testing/selftests/vm/.gitignore   |   1 +
 tools/testing/selftests/vm/Makefile     |   1 +
 tools/testing/selftests/vm/config       |   2 +
 tools/testing/selftests/vm/soft-dirty.c | 238 ++++++++++++++++++++++++
 4 files changed, 242 insertions(+)
 create mode 100644 tools/testing/selftests/vm/soft-dirty.c

diff --git a/tools/testing/selftests/vm/.gitignore b/tools/testing/selftests/vm/.gitignore
index d7507f3c7c76..3cb4fa771ec2 100644
--- a/tools/testing/selftests/vm/.gitignore
+++ b/tools/testing/selftests/vm/.gitignore
@@ -29,5 +29,6 @@ write_to_hugetlbfs
 hmm-tests
 memfd_secret
 local_config.*
+soft-dirty
 split_huge_page_test
 ksm_tests
diff --git a/tools/testing/selftests/vm/Makefile b/tools/testing/selftests/vm/Makefile
index 5e43f072f5b7..de9b13d018c3 100644
--- a/tools/testing/selftests/vm/Makefile
+++ b/tools/testing/selftests/vm/Makefile
@@ -47,6 +47,7 @@ TEST_GEN_FILES += on-fault-limit
 TEST_GEN_FILES += thuge-gen
 TEST_GEN_FILES += transhuge-stress
 TEST_GEN_FILES += userfaultfd
+TEST_GEN_FILES += soft-dirty
 TEST_GEN_FILES += split_huge_page_test
 TEST_GEN_FILES += ksm_tests
 
diff --git a/tools/testing/selftests/vm/config b/tools/testing/selftests/vm/config
index 60e82da0de85..be087c4bc396 100644
--- a/tools/testing/selftests/vm/config
+++ b/tools/testing/selftests/vm/config
@@ -4,3 +4,5 @@ CONFIG_TEST_VMALLOC=m
 CONFIG_DEVICE_PRIVATE=y
 CONFIG_TEST_HMM=m
 CONFIG_GUP_TEST=y
+CONFIG_TRANSPARENT_HUGEPAGE=y
+CONFIG_MEM_SOFT_DIRTY=y
diff --git a/tools/testing/selftests/vm/soft-dirty.c b/tools/testing/selftests/vm/soft-dirty.c
new file mode 100644
index 000000000000..f56c215e0ece
--- /dev/null
+++ b/tools/testing/selftests/vm/soft-dirty.c
@@ -0,0 +1,238 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <stdio.h>
+#include <string.h>
+#include <stdbool.h>
+#include <fcntl.h>
+#include <stdint.h>
+#include <malloc.h>
+#include <sys/mman.h>
+#include "../kselftest.h"
+
+#define PAGEMAP_PATH		"/proc/self/pagemap"
+#define CLEAR_REFS_PATH		"/proc/self/clear_refs"
+#define SMAP_PATH		"/proc/self/smaps"
+#define PMD_SIZE_PATH		"/sys/kernel/mm/transparent_hugepage/hpage_pmd_size"
+#define MAX_LINE_LENGTH		512
+#define TEST_ITERATIONS		10000
+#define PAGE_NUM_TO_TEST	2
+
+int clear_refs;
+int pagemap;
+
+int pagesize;
+int mmap_size;	/* Size of test region */
+
+static void clear_all_refs(void)
+{
+	const char *ctrl = "4";
+
+	if (write(clear_refs, ctrl, strlen(ctrl)) != strlen(ctrl))
+		ksft_exit_fail_msg("%s: failed to clear references\n", __func__);
+}
+
+static void touch_page(char *map, int n)
+{
+	map[(pagesize * n) + 1]++;
+}
+
+static int check_page(char *start, int page_num, int clear)
+{
+	unsigned long pfn = (unsigned long)start / pagesize;
+	uint64_t entry;
+	int ret;
+
+	ret = pread(pagemap, &entry, sizeof(entry), (pfn + page_num) * sizeof(entry));
+	if (ret != sizeof(entry))
+		ksft_exit_fail_msg("reading pagemap failed\n");
+	if (clear)
+		clear_all_refs();
+
+	return ((entry >> 55) & 1);
+}
+
+static void test_simple(void)
+{
+	int i;
+	char *map;
+
+	map = aligned_alloc(pagesize, mmap_size);
+	if (!map)
+		ksft_exit_fail_msg("mmap failed\n");
+
+	clear_all_refs();
+
+	for (i = 0 ; i < TEST_ITERATIONS; i++) {
+		if (check_page(map, PAGE_NUM_TO_TEST, 1) == 1) {
+			ksft_print_msg("dirty bit was 1, but should be 0 (i=%d)\n", i);
+			break;
+		}
+
+		touch_page(map, 2);
+
+		if (check_page(map, PAGE_NUM_TO_TEST, 1) == 0) {
+			ksft_print_msg("dirty bit was 0, but should be 1 (i=%d)\n", i);
+			break;
+		}
+
+	}
+	free(map);
+
+	ksft_test_result(i == TEST_ITERATIONS, "Test %s\n", __func__);
+}
+
+static void test_vma_reuse(void)
+{
+	char *map, *map2;
+
+	map = (char *) 0x900000000000;
+	map = mmap(map, mmap_size, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANON, -1, 0);
+	if (map == MAP_FAILED)
+		ksft_exit_fail_msg("mmap failed");
+
+	clear_all_refs();
+	touch_page(map, PAGE_NUM_TO_TEST);
+
+	munmap(map, mmap_size);
+	map2 = mmap(map, mmap_size, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANON, -1, 0);
+	if (map2 == MAP_FAILED)
+		ksft_exit_fail_msg("mmap failed");
+
+	ksft_test_result(map == map2, "Test %s reused memory location\n", __func__);
+
+	ksft_test_result(check_page(map, PAGE_NUM_TO_TEST, 1) != 0,
+			 "Test %s dirty bit of previous page\n", __func__);
+
+	munmap(map2, mmap_size);
+}
+
+/*
+ * read_pmd_pagesize(), check_for_pattern() and check_huge() adapted
+ * from 'tools/testing/selftest/vm/split_huge_page_test.c'
+ */
+static uint64_t read_pmd_pagesize(void)
+{
+	int fd;
+	char buf[20];
+	ssize_t num_read;
+
+	fd = open(PMD_SIZE_PATH, O_RDONLY);
+	if (fd == -1)
+		ksft_exit_fail_msg("Open hpage_pmd_size failed\n");
+
+	num_read = read(fd, buf, 19);
+	if (num_read < 1) {
+		close(fd);
+		ksft_exit_fail_msg("Read hpage_pmd_size failed\n");
+	}
+	buf[num_read] = '\0';
+	close(fd);
+
+	return strtoul(buf, NULL, 10);
+}
+
+static bool check_for_pattern(FILE *fp, const char *pattern, char *buf)
+{
+	while (fgets(buf, MAX_LINE_LENGTH, fp) != NULL) {
+		if (!strncmp(buf, pattern, strlen(pattern)))
+			return true;
+	}
+	return false;
+}
+
+static uint64_t check_huge(void *addr)
+{
+	uint64_t thp = 0;
+	int ret;
+	FILE *fp;
+	char buffer[MAX_LINE_LENGTH];
+	char addr_pattern[MAX_LINE_LENGTH];
+
+	ret = snprintf(addr_pattern, MAX_LINE_LENGTH, "%08lx-",
+		       (unsigned long) addr);
+	if (ret >= MAX_LINE_LENGTH)
+		ksft_print_msg("%s: Pattern is too long\n", __func__);
+
+	fp = fopen(SMAP_PATH, "r");
+	if (!fp)
+		ksft_print_msg("%s: Failed to open file %s\n", __func__, SMAP_PATH);
+
+	if (!check_for_pattern(fp, addr_pattern, buffer))
+		goto err_out;
+
+	/*
+	 * Fetch the AnonHugePages: in the same block and check the number of
+	 * hugepages.
+	 */
+	if (!check_for_pattern(fp, "AnonHugePages:", buffer))
+		goto err_out;
+
+	if (sscanf(buffer, "AnonHugePages:%10ld kB", &thp) != 1)
+		ksft_print_msg("Reading smap error\n");
+
+err_out:
+	fclose(fp);
+
+	return thp;
+}
+
+static void test_hugepage(void)
+{
+	char *map;
+	int i, ret;
+	size_t hpage_len = read_pmd_pagesize();
+
+	map = memalign(hpage_len, hpage_len);
+	if (!map)
+		ksft_exit_fail_msg("memalign failed\n");
+
+	ret = madvise(map, hpage_len, MADV_HUGEPAGE);
+	if (ret)
+		ksft_exit_fail_msg("madvise failed %d\n", ret);
+
+	for (i = 0; i < hpage_len; i++)
+		map[i] = (char)i;
+
+	ksft_test_result(check_huge(map), "Test %s huge page allocation\n", __func__);
+
+	clear_all_refs();
+	for (i = 0 ; i < TEST_ITERATIONS ; i++) {
+		if (check_page(map, PAGE_NUM_TO_TEST, 1) == 1) {
+			ksft_print_msg("dirty bit was 1, but should be 0 (i=%d)\n", i);
+			break;
+		}
+
+		touch_page(map, PAGE_NUM_TO_TEST);
+
+		if (check_page(map, PAGE_NUM_TO_TEST, 1) == 0) {
+			ksft_print_msg("dirty bit was 0, but should be 1 (i=%d)\n", i);
+			break;
+		}
+	}
+
+	ksft_test_result(i == TEST_ITERATIONS, "Test %s dirty bit\n", __func__);
+
+	munmap(map, mmap_size);
+}
+
+int main(int argc, char **argv)
+{
+	ksft_print_header();
+	ksft_set_plan(5);
+
+	pagemap = open(PAGEMAP_PATH, O_RDONLY);
+	if (pagemap < 0)
+		ksft_exit_fail_msg("Failed to open %s\n", PAGEMAP_PATH);
+
+	clear_refs = open(CLEAR_REFS_PATH, O_WRONLY);
+	if (clear_refs < 0)
+		ksft_exit_fail_msg("Failed to open %s\n", CLEAR_REFS_PATH);
+
+	pagesize = getpagesize();
+	mmap_size = 10 * pagesize;
+
+	test_simple();
+	test_vma_reuse();
+	test_hugepage();
+
+	return ksft_exit_pass();
+}
-- 
2.30.2

