Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F30E55083A4
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Apr 2022 10:41:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376803AbiDTIn5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 20 Apr 2022 04:43:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376792AbiDTInz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 20 Apr 2022 04:43:55 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CC7333A14;
        Wed, 20 Apr 2022 01:41:07 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: usama.anjum)
        with ESMTPSA id 6E99F1F43125
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1650444063;
        bh=im8qykLjAzYpEBohglRiXlxjTUS5oRxPNoJmH5S8HiE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ks/SjqCz9+U7MsH22wqPJOnvN3ahvOsS3Ugzsgi4vT1We5AbHuA0+KeIL+7ldvDpd
         5NNC8xRDBnvG7IDSR6tGUdA6/IAoQr5Ivdxn6XTkMHByjaOhPoquSh718ccx/Yzd16
         pIKs5y8bRc9mdRV2D3ZeoOYah5T4c+buBWNADxcN6j32V0DgNE3sjynuP7vqgtHOpp
         VmKIFR9pCnuU4kAHNvSfE+CjDRjoctuOlX9pi2PipKyn7sUhK8u9dnEB1obGQuNhSV
         9KPj3quSW7KoUdTGSfxF694ppg9uyuPTis8bv1wFSBYL8cC0UssgrvWFBGU3xUhBdk
         fnFLCnQ69je8w==
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     Gabriel Krisman Bertazi <krisman@collabora.com>,
        usama.anjum@collabora.com, kernel@collabora.com,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Subject: [PATCH v6 2/2] selftests: vm: Add test for Soft-Dirty PTE bit
Date:   Wed, 20 Apr 2022 13:40:35 +0500
Message-Id: <20220420084036.4101604-2-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220420084036.4101604-1-usama.anjum@collabora.com>
References: <20220420084036.4101604-1-usama.anjum@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Gabriel Krisman Bertazi <krisman@collabora.com>

This introduces three tests:
1) Sanity check soft dirty basic semantics: allocate area, clean, dirty,
check if the SD bit is flipped.
2) Check VMA reuse: validate the VM_SOFTDIRTY usage
3) Check soft-dirty on huge pages

This was motivated by Will Deacon's fix commit 912efa17e512 ("mm: proc:
Invalidate TLB after clearing soft-dirty page state"). I was tracking the
same issue that he fixed, and this test would have caught it.

Cc: Will Deacon <will@kernel.org>
Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
Co-developed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
Changes in V6:
- Update VMA reuse sub test to make it more elaborative
- Minor changes in writing to the pages

Output:
TAP version 13
1..5
ok 1 Test test_simple
ok 2 Test test_vma_reuse dirty bit of allocated page
ok 3 Test test_vma_reuse dirty bit of reused address page
ok 4 Test test_hugepage huge page allocation
ok 5 Test test_hugepage huge page dirty bit
 # Totals: pass:5 fail:0 xfail:0 xpass:0 skip:0 error:0

Changes in V5:
- Correct indentation of macros
- Tested by reverting 912efa17e512 and one sub test failed
- Updated the writing values to the memory and added a comment

Changes in V4:
Cosmetic changes
Removed global variables
Replaced ksft_print_msg with ksft_exit_fail_msg to exit the program at
once
Some other minor changes
Correct the authorship of the patch

Changes in V3:
Move test to selftests/vm
Use kselftest macros
Minor updates to make code more maintainable
Add configurations in config file

V2 of this patch:
https://lore.kernel.org/lkml/20210603151518.2437813-1-krisman@collabora.com/
---
 tools/testing/selftests/vm/.gitignore   |   1 +
 tools/testing/selftests/vm/Makefile     |   2 +
 tools/testing/selftests/vm/config       |   2 +
 tools/testing/selftests/vm/soft-dirty.c | 145 ++++++++++++++++++++++++
 4 files changed, 150 insertions(+)
 create mode 100644 tools/testing/selftests/vm/soft-dirty.c

diff --git a/tools/testing/selftests/vm/.gitignore b/tools/testing/selftests/vm/.gitignore
index d7507f3c7c76a..3cb4fa771ec2a 100644
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
index 4e68edb26d6b6..f25eb30b5f0cb 100644
--- a/tools/testing/selftests/vm/Makefile
+++ b/tools/testing/selftests/vm/Makefile
@@ -47,6 +47,7 @@ TEST_GEN_FILES += on-fault-limit
 TEST_GEN_FILES += thuge-gen
 TEST_GEN_FILES += transhuge-stress
 TEST_GEN_FILES += userfaultfd
+TEST_GEN_PROGS += soft-dirty
 TEST_GEN_PROGS += split_huge_page_test
 TEST_GEN_FILES += ksm_tests
 
@@ -92,6 +93,7 @@ KSFT_KHDR_INSTALL := 1
 include ../lib.mk
 
 $(OUTPUT)/madv_populate: vm_util.c
+$(OUTPUT)/soft-dirty: vm_util.c
 $(OUTPUT)/split_huge_page_test: vm_util.c
 
 ifeq ($(MACHINE),x86_64)
diff --git a/tools/testing/selftests/vm/config b/tools/testing/selftests/vm/config
index 60e82da0de850..be087c4bc3961 100644
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
index 0000000000000..08ab62a4a9d07
--- /dev/null
+++ b/tools/testing/selftests/vm/soft-dirty.c
@@ -0,0 +1,145 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <stdio.h>
+#include <string.h>
+#include <stdbool.h>
+#include <fcntl.h>
+#include <stdint.h>
+#include <malloc.h>
+#include <sys/mman.h>
+#include "../kselftest.h"
+#include "vm_util.h"
+
+#define PAGEMAP_FILE_PATH "/proc/self/pagemap"
+#define TEST_ITERATIONS 10000
+
+static void test_simple(int pagemap_fd, int pagesize)
+{
+	int i;
+	char *map;
+
+	map = aligned_alloc(pagesize, pagesize);
+	if (!map)
+		ksft_exit_fail_msg("mmap failed\n");
+
+	clear_softdirty();
+
+	for (i = 0 ; i < TEST_ITERATIONS; i++) {
+		if (pagemap_is_softdirty(pagemap_fd, map) == 1) {
+			ksft_print_msg("dirty bit was 1, but should be 0 (i=%d)\n", i);
+			break;
+		}
+
+		clear_softdirty();
+		// Write something to the page to get the dirty bit enabled on the page
+		map[0]++;
+
+		if (pagemap_is_softdirty(pagemap_fd, map) == 0) {
+			ksft_print_msg("dirty bit was 0, but should be 1 (i=%d)\n", i);
+			break;
+		}
+
+		clear_softdirty();
+	}
+	free(map);
+
+	ksft_test_result(i == TEST_ITERATIONS, "Test %s\n", __func__);
+}
+
+static void test_vma_reuse(int pagemap_fd, int pagesize)
+{
+	char *map, *map2;
+
+	map = mmap(NULL, pagesize, (PROT_READ | PROT_WRITE), (MAP_PRIVATE | MAP_ANON), -1, 0);
+	if (map == MAP_FAILED)
+		ksft_exit_fail_msg("mmap failed");
+
+	// The kernel always marks new regions as soft dirty
+	ksft_test_result(pagemap_is_softdirty(pagemap_fd, map) == 1,
+			 "Test %s dirty bit of allocated page\n", __func__);
+
+	clear_softdirty();
+	munmap(map, pagesize);
+
+	map2 = mmap(NULL, pagesize, (PROT_READ | PROT_WRITE), (MAP_PRIVATE | MAP_ANON), -1, 0);
+	if (map2 == MAP_FAILED)
+		ksft_exit_fail_msg("mmap failed");
+
+	// Dirty bit is set for new regions even if they are reused
+	if (map == map2)
+		ksft_test_result(pagemap_is_softdirty(pagemap_fd, map2) == 1,
+				 "Test %s dirty bit of reused address page\n", __func__);
+	else
+		ksft_test_result_skip("Test %s dirty bit of reused address page\n", __func__);
+
+	munmap(map2, pagesize);
+}
+
+static void test_hugepage(int pagemap_fd, int pagesize)
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
+	if (check_huge(map)) {
+		ksft_test_result_pass("Test %s huge page allocation\n", __func__);
+
+		clear_softdirty();
+		for (i = 0 ; i < TEST_ITERATIONS ; i++) {
+			if (pagemap_is_softdirty(pagemap_fd, map) == 1) {
+				ksft_print_msg("dirty bit was 1, but should be 0 (i=%d)\n", i);
+				break;
+			}
+
+			clear_softdirty();
+			// Write something to the page to get the dirty bit enabled on the page
+			map[0]++;
+
+			if (pagemap_is_softdirty(pagemap_fd, map) == 0) {
+				ksft_print_msg("dirty bit was 0, but should be 1 (i=%d)\n", i);
+				break;
+			}
+			clear_softdirty();
+		}
+
+		ksft_test_result(i == TEST_ITERATIONS, "Test %s huge page dirty bit\n", __func__);
+	} else {
+		// hugepage allocation failed. skip these tests
+		ksft_test_result_skip("Test %s huge page allocation\n", __func__);
+		ksft_test_result_skip("Test %s huge page dirty bit\n", __func__);
+	}
+	free(map);
+}
+
+int main(int argc, char **argv)
+{
+	int pagemap_fd;
+	int pagesize;
+
+	ksft_print_header();
+	ksft_set_plan(5);
+
+	pagemap_fd = open(PAGEMAP_FILE_PATH, O_RDONLY);
+	if (pagemap_fd < 0)
+		ksft_exit_fail_msg("Failed to open %s\n", PAGEMAP_FILE_PATH);
+
+	pagesize = getpagesize();
+
+	test_simple(pagemap_fd, pagesize);
+	test_vma_reuse(pagemap_fd, pagesize);
+	test_hugepage(pagemap_fd, pagesize);
+
+	close(pagemap_fd);
+
+	return ksft_exit_pass();
+}
-- 
2.30.2

