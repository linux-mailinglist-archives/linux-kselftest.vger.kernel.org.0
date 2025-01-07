Return-Path: <linux-kselftest+bounces-23993-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D547A0431A
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Jan 2025 15:48:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1207C1881934
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Jan 2025 14:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35F541F2C41;
	Tue,  7 Jan 2025 14:48:17 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0341F1F2360;
	Tue,  7 Jan 2025 14:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736261297; cv=none; b=Lt9S/Lm9U+3n/g53rev9/eg6Or6Ma9U2M8g9Ua2UK1A9SpwBwCfb6j/sfq3sN1QN02FNBWCmluQucZJX09oB6YkBuzJG1djJ8523OCsG+ssnGeOravwW+gzhSzWZ8kfhcsswkD5ASrpMb8UDJPuFuv5DSqsoI4pEmmDyJI8R3OY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736261297; c=relaxed/simple;
	bh=z9i9dM3tC84n6BLausBaEiPcmC7avbE0NRpsdx+SO8k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZFygT5C0u0PzZ8kA+Bo7svs9lhxIP0TLTBShmhPbnGkBfbwuDtGOFgS+msy/W7pezUdRBkFNPRHOgJS+t+x+mlGoOCp7Pig8uoQa8KTxVgGCwa/1S5y4luAzPsIVtt7M8JZ6xJtpdYzeQ9BwkwXq8Ccu7z7n3drlaHW5vOHWvDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AD24115A1;
	Tue,  7 Jan 2025 06:48:41 -0800 (PST)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.27])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D4ECF3F59E;
	Tue,  7 Jan 2025 06:48:10 -0800 (PST)
From: Ryan Roberts <ryan.roberts@arm.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Muchun Song <muchun.song@linux.dev>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Jann Horn <jannh@google.com>,
	Shuah Khan <shuah@kernel.org>,
	Peter Xu <peterx@redhat.com>,
	David Hildenbrand <david@redhat.com>,
	=?UTF-8?q?Miko=C5=82aj=20Lenczewski?= <miko.lenczewski@arm.com>,
	Mark Rutland <mark.rutland@arm.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v1 2/2] selftests/mm: Introduce uffd-wp-mremap regression test
Date: Tue,  7 Jan 2025 14:47:53 +0000
Message-ID: <20250107144755.1871363-3-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250107144755.1871363-1-ryan.roberts@arm.com>
References: <20250107144755.1871363-1-ryan.roberts@arm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce a test that registers a range of memory for
UFFDIO_WRITEPROTECT_MODE_WP without UFFD_FEATURE_EVENT_REMAP. First
check that the uffd-wp bit is set for every PTE in the range. Then
mremap() the range to a new location and check that the uffd-wp bit is
clear for every PTE in the range.

Run the test for small folios, all supported THP sizes and all supported
hugetlb sizes, and for swapped out memory, shared and private.

There was previously a bug in the kernel where the uffd-wp bits remained
set in all PTEs for this case, after fixing the kernel, the tests all
pass.

Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---
 tools/testing/selftests/mm/.gitignore       |   1 +
 tools/testing/selftests/mm/Makefile         |   2 +
 tools/testing/selftests/mm/run_vmtests.sh   |   1 +
 tools/testing/selftests/mm/uffd-wp-mremap.c | 380 ++++++++++++++++++++
 4 files changed, 384 insertions(+)
 create mode 100644 tools/testing/selftests/mm/uffd-wp-mremap.c

diff --git a/tools/testing/selftests/mm/.gitignore b/tools/testing/selftests/mm/.gitignore
index a51a947b2d1d..121000c28c10 100644
--- a/tools/testing/selftests/mm/.gitignore
+++ b/tools/testing/selftests/mm/.gitignore
@@ -27,6 +27,7 @@ protection_keys_64
 madv_populate
 uffd-stress
 uffd-unit-tests
+uffd-wp-mremap
 mlock-intersect-test
 mlock-random-test
 virtual_address_range
diff --git a/tools/testing/selftests/mm/Makefile b/tools/testing/selftests/mm/Makefile
index 1c5504e63ebd..a96bff5b4f42 100644
--- a/tools/testing/selftests/mm/Makefile
+++ b/tools/testing/selftests/mm/Makefile
@@ -81,6 +81,7 @@ TEST_GEN_FILES += thuge-gen
 TEST_GEN_FILES += transhuge-stress
 TEST_GEN_FILES += uffd-stress
 TEST_GEN_FILES += uffd-unit-tests
+TEST_GEN_FILES += uffd-wp-mremap
 TEST_GEN_FILES += split_huge_page_test
 TEST_GEN_FILES += ksm_tests
 TEST_GEN_FILES += ksm_functional_tests
@@ -151,6 +152,7 @@ $(TEST_GEN_FILES): vm_util.c thp_settings.c
 
 $(OUTPUT)/uffd-stress: uffd-common.c
 $(OUTPUT)/uffd-unit-tests: uffd-common.c
+$(OUTPUT)/uffd-wp-mremap: uffd-common.c
 $(OUTPUT)/protection_keys: pkey_util.c
 $(OUTPUT)/pkey_sighandler_tests: pkey_util.c
 
diff --git a/tools/testing/selftests/mm/run_vmtests.sh b/tools/testing/selftests/mm/run_vmtests.sh
index 00c3f07ea100..333c468c2699 100755
--- a/tools/testing/selftests/mm/run_vmtests.sh
+++ b/tools/testing/selftests/mm/run_vmtests.sh
@@ -309,6 +309,7 @@ CATEGORY="userfaultfd" run_test ${uffd_stress_bin} hugetlb "$half_ufd_size_MB" 3
 CATEGORY="userfaultfd" run_test ${uffd_stress_bin} hugetlb-private "$half_ufd_size_MB" 32
 CATEGORY="userfaultfd" run_test ${uffd_stress_bin} shmem 20 16
 CATEGORY="userfaultfd" run_test ${uffd_stress_bin} shmem-private 20 16
+CATEGORY="userfaultfd" run_test ./uffd-wp-mremap
 
 #cleanup
 echo "$nr_hugepgs" > /proc/sys/vm/nr_hugepages
diff --git a/tools/testing/selftests/mm/uffd-wp-mremap.c b/tools/testing/selftests/mm/uffd-wp-mremap.c
new file mode 100644
index 000000000000..2c4f984bd73c
--- /dev/null
+++ b/tools/testing/selftests/mm/uffd-wp-mremap.c
@@ -0,0 +1,380 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#define _GNU_SOURCE
+#include <stdbool.h>
+#include <stdint.h>
+#include <fcntl.h>
+#include <assert.h>
+#include <linux/mman.h>
+#include <sys/mman.h>
+#include "../kselftest.h"
+#include "thp_settings.h"
+#include "uffd-common.h"
+
+static int pagemap_fd;
+static size_t pagesize;
+static int nr_pagesizes = 1;
+static int nr_thpsizes;
+static size_t thpsizes[20];
+static int nr_hugetlbsizes;
+static size_t hugetlbsizes[10];
+
+static int sz2ord(size_t size)
+{
+	return __builtin_ctzll(size / pagesize);
+}
+
+static int detect_thp_sizes(size_t sizes[], int max)
+{
+	int count = 0;
+	unsigned long orders;
+	size_t kb;
+	int i;
+
+	/* thp not supported at all. */
+	if (!read_pmd_pagesize())
+		return 0;
+
+	orders = thp_supported_orders();
+
+	for (i = 0; orders && count < max; i++) {
+		if (!(orders & (1UL << i)))
+			continue;
+		orders &= ~(1UL << i);
+		kb = (pagesize >> 10) << i;
+		sizes[count++] = kb * 1024;
+		ksft_print_msg("[INFO] detected THP size: %zu KiB\n", kb);
+	}
+
+	return count;
+}
+
+static void *mmap_aligned(size_t size, int prot, int flags)
+{
+	size_t mmap_size = size * 2;
+	char *mmap_mem, *mem;
+
+	mmap_mem = mmap(NULL, mmap_size, prot, flags, -1, 0);
+	if (mmap_mem == MAP_FAILED)
+		return mmap_mem;
+
+	mem = (char *)(((uintptr_t)mmap_mem + size - 1) & ~(size - 1));
+	munmap(mmap_mem, mem - mmap_mem);
+	munmap(mem + size, mmap_mem + mmap_size - mem - size);
+
+	return mem;
+}
+
+static void *alloc_one_folio(size_t size, bool private, bool hugetlb)
+{
+	bool thp = !hugetlb && size > pagesize;
+	int flags = MAP_ANONYMOUS;
+	int prot = PROT_READ | PROT_WRITE;
+	char *mem, *addr;
+
+	assert((size & (size - 1)) == 0);
+
+	if (private)
+		flags |= MAP_PRIVATE;
+	else
+		flags |= MAP_SHARED;
+
+	/*
+	 * For THP, we must explicitly enable the THP size, allocate twice the
+	 * required space then manually align.
+	 */
+	if (thp) {
+		struct thp_settings settings = *thp_current_settings();
+
+		if (private)
+			settings.hugepages[sz2ord(size)].enabled = THP_ALWAYS;
+		else
+			settings.shmem_hugepages[sz2ord(size)].enabled = SHMEM_ALWAYS;
+
+		thp_push_settings(&settings);
+
+		mem = mmap_aligned(size, prot, flags);
+	} else {
+		if (hugetlb) {
+			flags |= MAP_HUGETLB;
+			flags |= __builtin_ctzll(size) << MAP_HUGE_SHIFT;
+		}
+
+		mem = mmap(NULL, size, prot, flags, -1, 0);
+	}
+
+	if (mem == MAP_FAILED) {
+		mem = NULL;
+		goto out;
+	}
+
+	assert(((uintptr_t)mem & (size - 1)) == 0);
+
+	/*
+	 * Populate the folio by writing the first byte and check that all pages
+	 * are populated. Finally set the whole thing to non-zero data to avoid
+	 * kernel from mapping it back to the zero page.
+	 */
+	mem[0] = 1;
+	for (addr = mem; addr < mem + size; addr += pagesize) {
+		if (!pagemap_is_populated(pagemap_fd, addr)) {
+			munmap(mem, size);
+			mem = NULL;
+			goto out;
+		}
+	}
+	memset(mem, 1, size);
+out:
+	if (thp)
+		thp_pop_settings();
+
+	return mem;
+}
+
+static bool check_uffd_wp_state(void *mem, size_t size, bool expect)
+{
+	uint64_t pte;
+	void *addr;
+
+	for (addr = mem; addr < mem + size; addr += pagesize) {
+		pte = pagemap_get_entry(pagemap_fd, addr);
+		if (!!(pte & PM_UFFD_WP) != expect) {
+			ksft_test_result_fail("uffd-wp not %s for pte %lu!\n",
+					      expect ? "set" : "clear",
+					      (addr - mem) / pagesize);
+			return false;
+		}
+	}
+
+	return true;
+}
+
+static bool range_is_swapped(void *addr, size_t size)
+{
+	for (; size; addr += pagesize, size -= pagesize)
+		if (!pagemap_is_swapped(pagemap_fd, addr))
+			return false;
+	return true;
+}
+
+static void test_one_folio(size_t size, bool private, bool swapout, bool hugetlb)
+{
+	struct uffdio_writeprotect wp_prms;
+	uint64_t features = 0;
+	void *addr = NULL;
+	void *mem = NULL;
+
+	assert(!(hugetlb && swapout));
+
+	ksft_print_msg("[RUN] %s(size=%zu, private=%s, swapout=%s, hugetlb=%s)\n",
+				__func__,
+				size,
+				private ? "true" : "false",
+				swapout ? "true" : "false",
+				hugetlb ? "true" : "false");
+
+	/* Allocate a folio of required size and type. */
+	mem = alloc_one_folio(size, private, hugetlb);
+	if (!mem) {
+		ksft_test_result_fail("alloc_one_folio() failed\n");
+		goto out;
+	}
+
+	/* Register range for uffd-wp. */
+	if (userfaultfd_open(&features)) {
+		ksft_test_result_fail("userfaultfd_open() failed\n");
+		goto out;
+	}
+	if (uffd_register(uffd, mem, size, false, true, false)) {
+		ksft_test_result_fail("uffd_register() failed\n");
+		goto out;
+	}
+	wp_prms.mode = UFFDIO_WRITEPROTECT_MODE_WP;
+	wp_prms.range.start = (uintptr_t)mem;
+	wp_prms.range.len = size;
+	if (ioctl(uffd, UFFDIO_WRITEPROTECT, &wp_prms)) {
+		ksft_test_result_fail("ioctl(UFFDIO_WRITEPROTECT) failed\n");
+		goto out;
+	}
+
+	if (swapout) {
+		madvise(mem, size, MADV_PAGEOUT);
+		if (!range_is_swapped(mem, size)) {
+			ksft_test_result_skip("MADV_PAGEOUT did not work, is swap enabled?\n");
+			goto out;
+		}
+	}
+
+	/* Check that uffd-wp is set for all PTEs in range. */
+	if (!check_uffd_wp_state(mem, size, true))
+		goto out;
+
+	/*
+	 * Move the mapping to a new, aligned location. Since
+	 * UFFD_FEATURE_EVENT_REMAP is not set, we expect the uffd-wp bit for
+	 * each PTE to be cleared in the new mapping.
+	 */
+	addr = mmap_aligned(size, PROT_NONE, MAP_PRIVATE | MAP_ANONYMOUS);
+	if (addr == MAP_FAILED) {
+		ksft_test_result_fail("mmap_aligned() failed\n");
+		goto out;
+	}
+	if (mremap(mem, size, size, MREMAP_FIXED | MREMAP_MAYMOVE, addr) == MAP_FAILED) {
+		ksft_test_result_fail("mremap() failed\n");
+		munmap(addr, size);
+		goto out;
+	}
+	mem = addr;
+
+	/* Check that uffd-wp is cleared for all PTEs in range. */
+	if (!check_uffd_wp_state(mem, size, false))
+		goto out;
+
+	ksft_test_result_pass("%s(size=%zu, private=%s, swapout=%s, hugetlb=%s)\n",
+				__func__,
+				size,
+				private ? "true" : "false",
+				swapout ? "true" : "false",
+				hugetlb ? "true" : "false");
+out:
+	if (mem)
+		munmap(mem, size);
+	if (uffd >= 0) {
+		close(uffd);
+		uffd = -1;
+	}
+}
+
+struct testcase {
+	size_t *sizes;
+	int *nr_sizes;
+	bool private;
+	bool swapout;
+	bool hugetlb;
+};
+
+static const struct testcase testcases[] = {
+	/* base pages. */
+	{
+		.sizes = &pagesize,
+		.nr_sizes = &nr_pagesizes,
+		.private = false,
+		.swapout = false,
+		.hugetlb = false,
+	},
+	{
+		.sizes = &pagesize,
+		.nr_sizes = &nr_pagesizes,
+		.private = true,
+		.swapout = false,
+		.hugetlb = false,
+	},
+	{
+		.sizes = &pagesize,
+		.nr_sizes = &nr_pagesizes,
+		.private = false,
+		.swapout = true,
+		.hugetlb = false,
+	},
+	{
+		.sizes = &pagesize,
+		.nr_sizes = &nr_pagesizes,
+		.private = true,
+		.swapout = true,
+		.hugetlb = false,
+	},
+
+	/* thp. */
+	{
+		.sizes = thpsizes,
+		.nr_sizes = &nr_thpsizes,
+		.private = false,
+		.swapout = false,
+		.hugetlb = false,
+	},
+	{
+		.sizes = thpsizes,
+		.nr_sizes = &nr_thpsizes,
+		.private = true,
+		.swapout = false,
+		.hugetlb = false,
+	},
+	{
+		.sizes = thpsizes,
+		.nr_sizes = &nr_thpsizes,
+		.private = false,
+		.swapout = true,
+		.hugetlb = false,
+	},
+	{
+		.sizes = thpsizes,
+		.nr_sizes = &nr_thpsizes,
+		.private = true,
+		.swapout = true,
+		.hugetlb = false,
+	},
+
+	/* hugetlb. */
+	{
+		.sizes = hugetlbsizes,
+		.nr_sizes = &nr_hugetlbsizes,
+		.private = false,
+		.swapout = false,
+		.hugetlb = true,
+	},
+	{
+		.sizes = hugetlbsizes,
+		.nr_sizes = &nr_hugetlbsizes,
+		.private = true,
+		.swapout = false,
+		.hugetlb = true,
+	},
+};
+
+int main(int argc, char **argv)
+{
+	struct thp_settings settings;
+	int i, j, plan = 0;
+
+	pagesize = getpagesize();
+	nr_thpsizes = detect_thp_sizes(thpsizes, ARRAY_SIZE(thpsizes));
+	nr_hugetlbsizes = detect_hugetlb_page_sizes(hugetlbsizes,
+						    ARRAY_SIZE(hugetlbsizes));
+
+	/* If THP is supported, save THP settings and initially disable THP. */
+	if (nr_thpsizes) {
+		thp_save_settings();
+		thp_read_settings(&settings);
+		for (i = 0; i < NR_ORDERS; i++) {
+			settings.hugepages[i].enabled = THP_NEVER;
+			settings.shmem_hugepages[i].enabled = SHMEM_NEVER;
+		}
+		thp_push_settings(&settings);
+	}
+
+	for (i = 0; i < ARRAY_SIZE(testcases); i++)
+		plan += *testcases[i].nr_sizes;
+	ksft_set_plan(plan);
+
+	pagemap_fd = open("/proc/self/pagemap", O_RDONLY);
+	if (pagemap_fd < 0)
+		ksft_exit_fail_msg("opening pagemap failed\n");
+
+	for (i = 0; i < ARRAY_SIZE(testcases); i++) {
+		const struct testcase *tc = &testcases[i];
+
+		for (j = 0; j < *tc->nr_sizes; j++)
+			test_one_folio(tc->sizes[j], tc->private, tc->swapout,
+				       tc->hugetlb);
+	}
+
+	/* If THP is supported, restore original THP settings. */
+	if (nr_thpsizes)
+		thp_restore_settings();
+
+	i = ksft_get_fail_cnt();
+	if (i)
+		ksft_exit_fail_msg("%d out of %d tests failed\n",
+				   i, ksft_test_num());
+	ksft_exit_pass();
+}
-- 
2.43.0


