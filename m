Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 061B6258B80
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Sep 2020 11:27:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726755AbgIAJ1x (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 1 Sep 2020 05:27:53 -0400
Received: from foss.arm.com ([217.140.110.172]:39162 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726714AbgIAJ1t (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 1 Sep 2020 05:27:49 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9415A1045;
        Tue,  1 Sep 2020 02:27:48 -0700 (PDT)
Received: from a077416.arm.com (unknown [10.57.6.112])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B65BE3F71F;
        Tue,  1 Sep 2020 02:27:45 -0700 (PDT)
From:   Amit Daniel Kachhap <amit.kachhap@arm.com>
To:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Vincenzo Frascino <Vincenzo.Frascino@arm.com>,
        Amit Daniel Kachhap <amit.kachhap@arm.com>,
        Gabor Kertesz <gabor.kertesz@arm.com>
Subject: [PATCH 4/6] kselftest/arm64: Verify all different mmap MTE options
Date:   Tue,  1 Sep 2020 14:57:17 +0530
Message-Id: <20200901092719.9918-5-amit.kachhap@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200901092719.9918-1-amit.kachhap@arm.com>
References: <20200901092719.9918-1-amit.kachhap@arm.com>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This testcase checks the different unsupported/supported options for mmap
if used with PROT_MTE memory protection flag. These checks are,

* Either pstate.tco enable or prctl PR_MTE_TCF_NONE option should not cause
  any tag mismatch faults.
* Different combinations of anonymous/file memory mmap, mprotect,
  sync/async error mode and private/shared mappings should work.
* mprotect should not be able to clear the PROT_MTE page property.

Cc: Shuah Khan <shuah@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Co-developed-by: Gabor Kertesz <gabor.kertesz@arm.com>
Signed-off-by: Gabor Kertesz <gabor.kertesz@arm.com>
Signed-off-by: Amit Daniel Kachhap <amit.kachhap@arm.com>
---
 tools/testing/selftests/arm64/mte/.gitignore  |   1 +
 .../selftests/arm64/mte/check_mmap_options.c  | 262 ++++++++++++++++++
 2 files changed, 263 insertions(+)
 create mode 100644 tools/testing/selftests/arm64/mte/check_mmap_options.c

diff --git a/tools/testing/selftests/arm64/mte/.gitignore b/tools/testing/selftests/arm64/mte/.gitignore
index b5fcc0fb4d97..79a215d3bbd0 100644
--- a/tools/testing/selftests/arm64/mte/.gitignore
+++ b/tools/testing/selftests/arm64/mte/.gitignore
@@ -1,3 +1,4 @@
 check_buffer_fill
 check_tags_inclusion
 check_child_memory
+check_mmap_options
diff --git a/tools/testing/selftests/arm64/mte/check_mmap_options.c b/tools/testing/selftests/arm64/mte/check_mmap_options.c
new file mode 100644
index 000000000000..33b13b86199b
--- /dev/null
+++ b/tools/testing/selftests/arm64/mte/check_mmap_options.c
@@ -0,0 +1,262 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2020 ARM Limited
+
+#define _GNU_SOURCE
+
+#include <errno.h>
+#include <fcntl.h>
+#include <signal.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <ucontext.h>
+#include <sys/mman.h>
+#include <sys/stat.h>
+#include <sys/types.h>
+
+#include "kselftest.h"
+#include "mte_common_util.h"
+#include "mte_def.h"
+
+#define RUNS			(MT_TAG_COUNT)
+#define UNDERFLOW		MT_GRANULE_SIZE
+#define OVERFLOW		MT_GRANULE_SIZE
+#define TAG_CHECK_ON		0
+#define TAG_CHECK_OFF		1
+
+static size_t page_size;
+static int sizes[] = {
+	1, 537, 989, 1269, MT_GRANULE_SIZE - 1, MT_GRANULE_SIZE,
+	/* page size - 1*/ 0, /* page_size */ 0, /* page size + 1 */ 0
+};
+
+static int check_mte_memory(char *ptr, int size, int mode, int tag_check)
+{
+	mte_initialize_current_context(mode, (uintptr_t)ptr, size);
+	memset(ptr, '1', size);
+	mte_wait_after_trig();
+	if (cur_mte_cxt.fault_valid == true)
+		return KSFT_FAIL;
+
+	mte_initialize_current_context(mode, (uintptr_t)ptr, -UNDERFLOW);
+	memset(ptr - UNDERFLOW, '2', UNDERFLOW);
+	mte_wait_after_trig();
+	if (cur_mte_cxt.fault_valid == false && tag_check == TAG_CHECK_ON)
+		return KSFT_FAIL;
+	if (cur_mte_cxt.fault_valid == true && tag_check == TAG_CHECK_OFF)
+		return KSFT_FAIL;
+
+	mte_initialize_current_context(mode, (uintptr_t)ptr, size + OVERFLOW);
+	memset(ptr + size, '3', OVERFLOW);
+	mte_wait_after_trig();
+	if (cur_mte_cxt.fault_valid == false && tag_check == TAG_CHECK_ON)
+		return KSFT_FAIL;
+	if (cur_mte_cxt.fault_valid == true && tag_check == TAG_CHECK_OFF)
+		return KSFT_FAIL;
+
+	return KSFT_PASS;
+}
+
+static int check_anonymous_memory_mapping(int mem_type, int mode, int mapping, int tag_check)
+{
+	char *ptr, *map_ptr;
+	int run, result, map_size;
+	int item = sizeof(sizes)/sizeof(int);
+
+	item = sizeof(sizes)/sizeof(int);
+	mte_switch_mode(mode, MTE_ALLOW_NON_ZERO_TAG);
+	for (run = 0; run < item; run++) {
+		map_size = sizes[run] + OVERFLOW + UNDERFLOW;
+		map_ptr = (char *)mte_allocate_memory(map_size, mem_type, mapping, false);
+		if (check_allocated_memory(map_ptr, map_size, mem_type, false) != KSFT_PASS)
+			return KSFT_FAIL;
+
+		ptr = map_ptr + UNDERFLOW;
+		mte_initialize_current_context(mode, (uintptr_t)ptr, sizes[run]);
+		/* Only mte enabled memory will allow tag insertion */
+		ptr = mte_insert_tags((void *)ptr, sizes[run]);
+		if (!ptr || cur_mte_cxt.fault_valid == true) {
+			ksft_print_msg("FAIL: Insert tags on anonymous mmap memory\n");
+			munmap((void *)map_ptr, map_size);
+			return KSFT_FAIL;
+		}
+		result = check_mte_memory(ptr, sizes[run], mode, tag_check);
+		mte_clear_tags((void *)ptr, sizes[run]);
+		mte_free_memory((void *)map_ptr, map_size, mem_type, false);
+		if (result == KSFT_FAIL)
+			return KSFT_FAIL;
+	}
+	return KSFT_PASS;
+}
+
+static int check_file_memory_mapping(int mem_type, int mode, int mapping, int tag_check)
+{
+	char *ptr, *map_ptr;
+	int run, fd, map_size;
+	int total = sizeof(sizes)/sizeof(int);
+	int result = KSFT_PASS;
+
+	mte_switch_mode(mode, MTE_ALLOW_NON_ZERO_TAG);
+	for (run = 0; run < total; run++) {
+		fd = create_temp_file();
+		if (fd == -1)
+			return KSFT_FAIL;
+
+		map_size = sizes[run] + UNDERFLOW + OVERFLOW;
+		map_ptr = (char *)mte_allocate_file_memory(map_size, mem_type, mapping, false, fd);
+		if (check_allocated_memory(map_ptr, map_size, mem_type, false) != KSFT_PASS) {
+			close(fd);
+			return KSFT_FAIL;
+		}
+		ptr = map_ptr + UNDERFLOW;
+		mte_initialize_current_context(mode, (uintptr_t)ptr, sizes[run]);
+		/* Only mte enabled memory will allow tag insertion */
+		ptr = mte_insert_tags((void *)ptr, sizes[run]);
+		if (!ptr || cur_mte_cxt.fault_valid == true) {
+			ksft_print_msg("FAIL: Insert tags on file based memory\n");
+			munmap((void *)map_ptr, map_size);
+			close(fd);
+			return KSFT_FAIL;
+		}
+		result = check_mte_memory(ptr, sizes[run], mode, tag_check);
+		mte_clear_tags((void *)ptr, sizes[run]);
+		munmap((void *)map_ptr, map_size);
+		close(fd);
+		if (result == KSFT_FAIL)
+			break;
+	}
+	return result;
+}
+
+static int check_clear_prot_mte_flag(int mem_type, int mode, int mapping)
+{
+	char *ptr, *map_ptr;
+	int run, prot_flag, result, fd, map_size;
+	int total = sizeof(sizes)/sizeof(int);
+
+	prot_flag = PROT_READ | PROT_WRITE;
+	mte_switch_mode(mode, MTE_ALLOW_NON_ZERO_TAG);
+	for (run = 0; run < total; run++) {
+		map_size = sizes[run] + OVERFLOW + UNDERFLOW;
+		ptr = (char *)mte_allocate_memory_tag_range(sizes[run], mem_type, mapping,
+							    UNDERFLOW, OVERFLOW);
+		if (check_allocated_memory_range(ptr, sizes[run], mem_type,
+						 UNDERFLOW, OVERFLOW) != KSFT_PASS)
+			return KSFT_FAIL;
+		map_ptr = ptr - UNDERFLOW;
+		/* Try to clear PROT_MTE property and verify it by tag checking */
+		if (mprotect(map_ptr, map_size, prot_flag)) {
+			mte_free_memory_tag_range((void *)ptr, sizes[run], mem_type,
+						  UNDERFLOW, OVERFLOW);
+			ksft_print_msg("FAIL: mprotect not ignoring clear PROT_MTE property\n");
+			return KSFT_FAIL;
+		}
+		result = check_mte_memory(ptr, sizes[run], mode, TAG_CHECK_ON);
+		mte_free_memory_tag_range((void *)ptr, sizes[run], mem_type, UNDERFLOW, OVERFLOW);
+		if (result != KSFT_PASS)
+			return KSFT_FAIL;
+
+		fd = create_temp_file();
+		if (fd == -1)
+			return KSFT_FAIL;
+		ptr = (char *)mte_allocate_file_memory_tag_range(sizes[run], mem_type, mapping,
+								 UNDERFLOW, OVERFLOW, fd);
+		if (check_allocated_memory_range(ptr, sizes[run], mem_type,
+						 UNDERFLOW, OVERFLOW) != KSFT_PASS) {
+			close(fd);
+			return KSFT_FAIL;
+		}
+		map_ptr = ptr - UNDERFLOW;
+		/* Try to clear PROT_MTE property and verify it by tag checking */
+		if (mprotect(map_ptr, map_size, prot_flag)) {
+			ksft_print_msg("FAIL: mprotect not ignoring clear PROT_MTE property\n");
+			mte_free_memory_tag_range((void *)ptr, sizes[run], mem_type,
+						  UNDERFLOW, OVERFLOW);
+			close(fd);
+			return KSFT_FAIL;
+		}
+		result = check_mte_memory(ptr, sizes[run], mode, TAG_CHECK_ON);
+		mte_free_memory_tag_range((void *)ptr, sizes[run], mem_type, UNDERFLOW, OVERFLOW);
+		close(fd);
+		if (result != KSFT_PASS)
+			return KSFT_FAIL;
+	}
+	return KSFT_PASS;
+}
+
+int main(int argc, char *argv[])
+{
+	int err;
+	int item = sizeof(sizes)/sizeof(int);
+
+	err = mte_default_setup();
+	if (err)
+		return err;
+	page_size = getpagesize();
+	if (!page_size) {
+		ksft_print_msg("ERR: Unable to get page size\n");
+		return KSFT_FAIL;
+	}
+	sizes[item - 3] = page_size - 1;
+	sizes[item - 2] = page_size;
+	sizes[item - 1] = page_size + 1;
+
+	/* Register signal handlers */
+	mte_register_signal(SIGBUS, mte_default_handler);
+	mte_register_signal(SIGSEGV, mte_default_handler);
+
+	mte_enable_pstate_tco();
+	evaluate_test(check_anonymous_memory_mapping(USE_MMAP, MTE_SYNC_ERR, MAP_PRIVATE, TAG_CHECK_OFF),
+	"Check anonymous memory with private mapping, sync error mode, mmap memory and tag check off\n");
+	evaluate_test(check_file_memory_mapping(USE_MPROTECT, MTE_SYNC_ERR, MAP_PRIVATE, TAG_CHECK_OFF),
+	"Check file memory with private mapping, sync error mode, mmap/mprotect memory and tag check off\n");
+
+	mte_disable_pstate_tco();
+	evaluate_test(check_anonymous_memory_mapping(USE_MMAP, MTE_NONE_ERR, MAP_PRIVATE, TAG_CHECK_OFF),
+	"Check anonymous memory with private mapping, no error mode, mmap memory and tag check off\n");
+	evaluate_test(check_file_memory_mapping(USE_MPROTECT, MTE_NONE_ERR, MAP_PRIVATE, TAG_CHECK_OFF),
+	"Check file memory with private mapping, no error mode, mmap/mprotect memory and tag check off\n");
+
+	evaluate_test(check_anonymous_memory_mapping(USE_MMAP, MTE_SYNC_ERR, MAP_PRIVATE, TAG_CHECK_ON),
+	"Check anonymous memory with private mapping, sync error mode, mmap memory and tag check on\n");
+	evaluate_test(check_anonymous_memory_mapping(USE_MPROTECT, MTE_SYNC_ERR, MAP_PRIVATE, TAG_CHECK_ON),
+	"Check anonymous memory with private mapping, sync error mode, mmap/mprotect memory and tag check on\n");
+	evaluate_test(check_anonymous_memory_mapping(USE_MMAP, MTE_SYNC_ERR, MAP_SHARED, TAG_CHECK_ON),
+	"Check anonymous memory with shared mapping, sync error mode, mmap memory and tag check on\n");
+	evaluate_test(check_anonymous_memory_mapping(USE_MPROTECT, MTE_SYNC_ERR, MAP_SHARED, TAG_CHECK_ON),
+	"Check anonymous memory with shared mapping, sync error mode, mmap/mprotect memory and tag check on\n");
+	evaluate_test(check_anonymous_memory_mapping(USE_MMAP, MTE_ASYNC_ERR, MAP_PRIVATE, TAG_CHECK_ON),
+	"Check anonymous memory with private mapping, async error mode, mmap memory and tag check on\n");
+	evaluate_test(check_anonymous_memory_mapping(USE_MPROTECT, MTE_ASYNC_ERR, MAP_PRIVATE, TAG_CHECK_ON),
+	"Check anonymous memory with private mapping, async error mode, mmap/mprotect memory and tag check on\n");
+	evaluate_test(check_anonymous_memory_mapping(USE_MMAP, MTE_ASYNC_ERR, MAP_SHARED, TAG_CHECK_ON),
+	"Check anonymous memory with shared mapping, async error mode, mmap memory and tag check on\n");
+	evaluate_test(check_anonymous_memory_mapping(USE_MPROTECT, MTE_ASYNC_ERR, MAP_SHARED, TAG_CHECK_ON),
+	"Check anonymous memory with shared mapping, async error mode, mmap/mprotect memory and tag check on\n");
+
+	evaluate_test(check_file_memory_mapping(USE_MMAP, MTE_SYNC_ERR, MAP_PRIVATE, TAG_CHECK_ON),
+	"Check file memory with private mapping, sync error mode, mmap memory and tag check on\n");
+	evaluate_test(check_file_memory_mapping(USE_MPROTECT, MTE_SYNC_ERR, MAP_PRIVATE, TAG_CHECK_ON),
+	"Check file memory with private mapping, sync error mode, mmap/mprotect memory and tag check on\n");
+	evaluate_test(check_file_memory_mapping(USE_MMAP, MTE_SYNC_ERR, MAP_SHARED, TAG_CHECK_ON),
+	"Check file memory with shared mapping, sync error mode, mmap memory and tag check on\n");
+	evaluate_test(check_file_memory_mapping(USE_MPROTECT, MTE_SYNC_ERR, MAP_SHARED, TAG_CHECK_ON),
+	"Check file memory with shared mapping, sync error mode, mmap/mprotect memory and tag check on\n");
+	evaluate_test(check_file_memory_mapping(USE_MMAP, MTE_ASYNC_ERR, MAP_PRIVATE, TAG_CHECK_ON),
+	"Check file memory with private mapping, async error mode, mmap memory and tag check on\n");
+	evaluate_test(check_file_memory_mapping(USE_MPROTECT, MTE_ASYNC_ERR, MAP_PRIVATE, TAG_CHECK_ON),
+	"Check file memory with private mapping, async error mode, mmap/mprotect memory and tag check on\n");
+	evaluate_test(check_file_memory_mapping(USE_MMAP, MTE_ASYNC_ERR, MAP_SHARED, TAG_CHECK_ON),
+	"Check file memory with shared mapping, async error mode, mmap memory and tag check on\n");
+	evaluate_test(check_file_memory_mapping(USE_MPROTECT, MTE_ASYNC_ERR, MAP_SHARED, TAG_CHECK_ON),
+	"Check file memory with shared mapping, async error mode, mmap/mprotect memory and tag check on\n");
+
+	evaluate_test(check_clear_prot_mte_flag(USE_MMAP, MTE_SYNC_ERR, MAP_PRIVATE),
+	"Check clear PROT_MTE flags with private mapping, sync error mode and mmap memory\n");
+	evaluate_test(check_clear_prot_mte_flag(USE_MPROTECT, MTE_SYNC_ERR, MAP_PRIVATE),
+	"Check clear PROT_MTE flags with private mapping and sync error mode and mmap/mprotect memory\n");
+
+	mte_restore_setup();
+	ksft_print_cnts();
+	return ksft_get_fail_cnt() == 0 ? KSFT_PASS : KSFT_FAIL;
+}
-- 
2.17.1

