Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9F7E2811CD
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Oct 2020 13:57:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387809AbgJBL4u (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 2 Oct 2020 07:56:50 -0400
Received: from foss.arm.com ([217.140.110.172]:33744 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726090AbgJBL4u (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 2 Oct 2020 07:56:50 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 79E90106F;
        Fri,  2 Oct 2020 04:56:47 -0700 (PDT)
Received: from a077416.blr.arm.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 733AE3F70D;
        Fri,  2 Oct 2020 04:56:44 -0700 (PDT)
From:   Amit Daniel Kachhap <amit.kachhap@arm.com>
To:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Vincenzo Frascino <Vincenzo.Frascino@arm.com>,
        Gabor Kertesz <gabor.kertesz@arm.com>,
        Amit Daniel Kachhap <amit.kachhap@arm.com>
Subject: [PATCH v2 1/6] kselftest/arm64: Add utilities and a test to validate mte memory
Date:   Fri,  2 Oct 2020 17:26:25 +0530
Message-Id: <20201002115630.24683-2-amit.kachhap@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201002115630.24683-1-amit.kachhap@arm.com>
References: <20201002115630.24683-1-amit.kachhap@arm.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This test checks that the memory tag is present after mte allocation and
the memory is accessible with those tags. This testcase verifies all
sync, async and none mte error reporting mode. The allocated mte buffers
are verified for Allocated range (no error expected while accessing
buffer), Underflow range, and Overflow range.

Different test scenarios covered here are,
* Verify that mte memory are accessible at byte/block level.
* Force underflow and overflow to occur and check the data consistency.
* Check to/from between tagged and untagged memory.
* Check that initial allocated memory to have 0 tag.

This change also creates the necessary infrastructure to add mte test
cases. MTE kselftests can use the several utility functions provided here
to add wide variety of mte test scenarios.

GCC compiler need flag '-march=armv8.5-a+memtag' so those flags are
verified before compilation.

The mte testcases can be launched with kselftest framework as,

make TARGETS=arm64 ARM64_SUBTARGETS=mte kselftest

or compiled as,

make -C tools/testing/selftests TARGETS=arm64 ARM64_SUBTARGETS=mte CC='compiler'

Cc: Shuah Khan <shuah@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Co-developed-by: Gabor Kertesz <gabor.kertesz@arm.com>
Signed-off-by: Gabor Kertesz <gabor.kertesz@arm.com>
Signed-off-by: Amit Daniel Kachhap <amit.kachhap@arm.com>
---
Changes in v2:
* Redefined MTE kernel header definitions to decouple kselftest compilations.
* Removed gmi masking instructions in mte_insert_random_tag assembly
  function. This simplifies the tag inclusion mask test with only GCR
  mask register used.
* Now use /dev/shm/* to hold temporary tmpfs files.
* Few Code and comment clean-ups.

 tools/testing/selftests/arm64/Makefile        |   2 +-
 tools/testing/selftests/arm64/mte/.gitignore  |   1 +
 tools/testing/selftests/arm64/mte/Makefile    |  29 ++
 .../selftests/arm64/mte/check_buffer_fill.c   | 475 ++++++++++++++++++
 .../selftests/arm64/mte/mte_common_util.c     | 341 +++++++++++++
 .../selftests/arm64/mte/mte_common_util.h     | 117 +++++
 tools/testing/selftests/arm64/mte/mte_def.h   |  60 +++
 .../testing/selftests/arm64/mte/mte_helper.S  | 114 +++++
 8 files changed, 1138 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/arm64/mte/.gitignore
 create mode 100644 tools/testing/selftests/arm64/mte/Makefile
 create mode 100644 tools/testing/selftests/arm64/mte/check_buffer_fill.c
 create mode 100644 tools/testing/selftests/arm64/mte/mte_common_util.c
 create mode 100644 tools/testing/selftests/arm64/mte/mte_common_util.h
 create mode 100644 tools/testing/selftests/arm64/mte/mte_def.h
 create mode 100644 tools/testing/selftests/arm64/mte/mte_helper.S

diff --git a/tools/testing/selftests/arm64/Makefile b/tools/testing/selftests/arm64/Makefile
index 93b567d23c8b..3723d9dea11a 100644
--- a/tools/testing/selftests/arm64/Makefile
+++ b/tools/testing/selftests/arm64/Makefile
@@ -4,7 +4,7 @@
 ARCH ?= $(shell uname -m 2>/dev/null || echo not)
 
 ifneq (,$(filter $(ARCH),aarch64 arm64))
-ARM64_SUBTARGETS ?= tags signal
+ARM64_SUBTARGETS ?= tags signal mte
 else
 ARM64_SUBTARGETS :=
 endif
diff --git a/tools/testing/selftests/arm64/mte/.gitignore b/tools/testing/selftests/arm64/mte/.gitignore
new file mode 100644
index 000000000000..3f8c1f6c82b9
--- /dev/null
+++ b/tools/testing/selftests/arm64/mte/.gitignore
@@ -0,0 +1 @@
+check_buffer_fill
diff --git a/tools/testing/selftests/arm64/mte/Makefile b/tools/testing/selftests/arm64/mte/Makefile
new file mode 100644
index 000000000000..2480226dfe57
--- /dev/null
+++ b/tools/testing/selftests/arm64/mte/Makefile
@@ -0,0 +1,29 @@
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2020 ARM Limited
+
+CFLAGS += -std=gnu99 -I.
+SRCS := $(filter-out mte_common_util.c,$(wildcard *.c))
+PROGS := $(patsubst %.c,%,$(SRCS))
+
+#Add mte compiler option
+ifneq ($(shell $(CC) --version 2>&1 | head -n 1 | grep gcc),)
+CFLAGS += -march=armv8.5-a+memtag
+endif
+
+#check if the compiler works well
+mte_cc_support := $(shell if ($(CC) $(CFLAGS) -E -x c /dev/null -o /dev/null 2>&1) then echo "1"; fi)
+
+ifeq ($(mte_cc_support),1)
+# Generated binaries to be installed by top KSFT script
+TEST_GEN_PROGS := $(PROGS)
+
+# Get Kernel headers installed and use them.
+KSFT_KHDR_INSTALL := 1
+endif
+
+# Include KSFT lib.mk.
+include ../../lib.mk
+
+ifeq ($(mte_cc_support),1)
+$(TEST_GEN_PROGS): mte_common_util.c mte_common_util.h mte_helper.S
+endif
diff --git a/tools/testing/selftests/arm64/mte/check_buffer_fill.c b/tools/testing/selftests/arm64/mte/check_buffer_fill.c
new file mode 100644
index 000000000000..242635d79035
--- /dev/null
+++ b/tools/testing/selftests/arm64/mte/check_buffer_fill.c
@@ -0,0 +1,475 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2020 ARM Limited
+
+#define _GNU_SOURCE
+
+#include <stddef.h>
+#include <stdio.h>
+#include <string.h>
+
+#include "kselftest.h"
+#include "mte_common_util.h"
+#include "mte_def.h"
+
+#define OVERFLOW_RANGE MT_GRANULE_SIZE
+
+static int sizes[] = {
+	1, 555, 1033, MT_GRANULE_SIZE - 1, MT_GRANULE_SIZE,
+	/* page size - 1*/ 0, /* page_size */ 0, /* page size + 1 */ 0
+};
+
+enum mte_block_test_alloc {
+	UNTAGGED_TAGGED,
+	TAGGED_UNTAGGED,
+	TAGGED_TAGGED,
+	BLOCK_ALLOC_MAX,
+};
+
+static int check_buffer_by_byte(int mem_type, int mode)
+{
+	char *ptr;
+	int i, j, item;
+	bool err;
+
+	mte_switch_mode(mode, MTE_ALLOW_NON_ZERO_TAG);
+	item = sizeof(sizes)/sizeof(int);
+
+	for (i = 0; i < item; i++) {
+		ptr = (char *)mte_allocate_memory(sizes[i], mem_type, 0, true);
+		if (check_allocated_memory(ptr, sizes[i], mem_type, true) != KSFT_PASS)
+			return KSFT_FAIL;
+		mte_initialize_current_context(mode, (uintptr_t)ptr, sizes[i]);
+		/* Set some value in tagged memory */
+		for (j = 0; j < sizes[i]; j++)
+			ptr[j] = '1';
+		mte_wait_after_trig();
+		err = cur_mte_cxt.fault_valid;
+		/* Check the buffer whether it is filled. */
+		for (j = 0; j < sizes[i] && !err; j++) {
+			if (ptr[j] != '1')
+				err = true;
+		}
+		mte_free_memory((void *)ptr, sizes[i], mem_type, true);
+
+		if (err)
+			break;
+	}
+	if (!err)
+		return KSFT_PASS;
+	else
+		return KSFT_FAIL;
+}
+
+static int check_buffer_underflow_by_byte(int mem_type, int mode,
+					  int underflow_range)
+{
+	char *ptr;
+	int i, j, item, last_index;
+	bool err;
+	char *und_ptr = NULL;
+
+	mte_switch_mode(mode, MTE_ALLOW_NON_ZERO_TAG);
+	item = sizeof(sizes)/sizeof(int);
+	for (i = 0; i < item; i++) {
+		ptr = (char *)mte_allocate_memory_tag_range(sizes[i], mem_type, 0,
+							    underflow_range, 0);
+		if (check_allocated_memory_range(ptr, sizes[i], mem_type,
+					       underflow_range, 0) != KSFT_PASS)
+			return KSFT_FAIL;
+
+		mte_initialize_current_context(mode, (uintptr_t)ptr, -underflow_range);
+		last_index = 0;
+		/* Set some value in tagged memory and make the buffer underflow */
+		for (j = sizes[i] - 1; (j >= -underflow_range) &&
+				       (cur_mte_cxt.fault_valid == false); j--) {
+			ptr[j] = '1';
+			last_index = j;
+		}
+		mte_wait_after_trig();
+		err = false;
+		/* Check whether the buffer is filled */
+		for (j = 0; j < sizes[i]; j++) {
+			if (ptr[j] != '1') {
+				err = true;
+				ksft_print_msg("Buffer is not filled at index:%d of ptr:0x%lx\n",
+						j, ptr);
+				break;
+			}
+		}
+		if (err)
+			goto check_buffer_underflow_by_byte_err;
+
+		switch (mode) {
+		case MTE_NONE_ERR:
+			if (cur_mte_cxt.fault_valid == true || last_index != -underflow_range) {
+				err = true;
+				break;
+			}
+			/* There were no fault so the underflow area should be filled */
+			und_ptr = (char *) MT_CLEAR_TAG((size_t) ptr - underflow_range);
+			for (j = 0 ; j < underflow_range; j++) {
+				if (und_ptr[j] != '1') {
+					err = true;
+					break;
+				}
+			}
+			break;
+		case MTE_ASYNC_ERR:
+			/* Imprecise fault should occur otherwise return error */
+			if (cur_mte_cxt.fault_valid == false) {
+				err = true;
+				break;
+			}
+			/*
+			 * The imprecise fault is checked after the write to the buffer,
+			 * so the underflow area before the fault should be filled.
+			 */
+			und_ptr = (char *) MT_CLEAR_TAG((size_t) ptr);
+			for (j = last_index ; j < 0 ; j++) {
+				if (und_ptr[j] != '1') {
+					err = true;
+					break;
+				}
+			}
+			break;
+		case MTE_SYNC_ERR:
+			/* Precise fault should occur otherwise return error */
+			if (!cur_mte_cxt.fault_valid || (last_index != (-1))) {
+				err = true;
+				break;
+			}
+			/* Underflow area should not be filled */
+			und_ptr = (char *) MT_CLEAR_TAG((size_t) ptr);
+			if (und_ptr[-1] == '1')
+				err = true;
+			break;
+		default:
+			err = true;
+		break;
+		}
+check_buffer_underflow_by_byte_err:
+		mte_free_memory_tag_range((void *)ptr, sizes[i], mem_type, underflow_range, 0);
+		if (err)
+			break;
+	}
+	return (err ? KSFT_FAIL : KSFT_PASS);
+}
+
+static int check_buffer_overflow_by_byte(int mem_type, int mode,
+					  int overflow_range)
+{
+	char *ptr;
+	int i, j, item, last_index;
+	bool err;
+	size_t tagged_size, overflow_size;
+	char *over_ptr = NULL;
+
+	mte_switch_mode(mode, MTE_ALLOW_NON_ZERO_TAG);
+	item = sizeof(sizes)/sizeof(int);
+	for (i = 0; i < item; i++) {
+		ptr = (char *)mte_allocate_memory_tag_range(sizes[i], mem_type, 0,
+							    0, overflow_range);
+		if (check_allocated_memory_range(ptr, sizes[i], mem_type,
+						 0, overflow_range) != KSFT_PASS)
+			return KSFT_FAIL;
+
+		tagged_size = MT_ALIGN_UP(sizes[i]);
+
+		mte_initialize_current_context(mode, (uintptr_t)ptr, sizes[i] + overflow_range);
+
+		/* Set some value in tagged memory and make the buffer underflow */
+		for (j = 0, last_index = 0 ; (j < (sizes[i] + overflow_range)) &&
+					     (cur_mte_cxt.fault_valid == false); j++) {
+			ptr[j] = '1';
+			last_index = j;
+		}
+		mte_wait_after_trig();
+		err = false;
+		/* Check whether the buffer is filled */
+		for (j = 0; j < sizes[i]; j++) {
+			if (ptr[j] != '1') {
+				err = true;
+				ksft_print_msg("Buffer is not filled at index:%d of ptr:0x%lx\n",
+						j, ptr);
+				break;
+			}
+		}
+		if (err)
+			goto check_buffer_overflow_by_byte_err;
+
+		overflow_size = overflow_range - (tagged_size - sizes[i]);
+
+		switch (mode) {
+		case MTE_NONE_ERR:
+			if ((cur_mte_cxt.fault_valid == true) ||
+			    (last_index != (sizes[i] + overflow_range - 1))) {
+				err = true;
+				break;
+			}
+			/* There were no fault so the overflow area should be filled */
+			over_ptr = (char *) MT_CLEAR_TAG((size_t) ptr + tagged_size);
+			for (j = 0 ; j < overflow_size; j++) {
+				if (over_ptr[j] != '1') {
+					err = true;
+					break;
+				}
+			}
+			break;
+		case MTE_ASYNC_ERR:
+			/* Imprecise fault should occur otherwise return error */
+			if (cur_mte_cxt.fault_valid == false) {
+				err = true;
+				break;
+			}
+			/*
+			 * The imprecise fault is checked after the write to the buffer,
+			 * so the overflow area should be filled before the fault.
+			 */
+			over_ptr = (char *) MT_CLEAR_TAG((size_t) ptr);
+			for (j = tagged_size ; j < last_index; j++) {
+				if (over_ptr[j] != '1') {
+					err = true;
+					break;
+				}
+			}
+			break;
+		case MTE_SYNC_ERR:
+			/* Precise fault should occur otherwise return error */
+			if (!cur_mte_cxt.fault_valid || (last_index != tagged_size)) {
+				err = true;
+				break;
+			}
+			/* Underflow area should not be filled */
+			over_ptr = (char *) MT_CLEAR_TAG((size_t) ptr + tagged_size);
+			for (j = 0 ; j < overflow_size; j++) {
+				if (over_ptr[j] == '1')
+					err = true;
+			}
+			break;
+		default:
+			err = true;
+		break;
+		}
+check_buffer_overflow_by_byte_err:
+		mte_free_memory_tag_range((void *)ptr, sizes[i], mem_type, 0, overflow_range);
+		if (err)
+			break;
+	}
+	return (err ? KSFT_FAIL : KSFT_PASS);
+}
+
+static int check_buffer_by_block_iterate(int mem_type, int mode, size_t size)
+{
+	char *src, *dst;
+	int j, result = KSFT_PASS;
+	enum mte_block_test_alloc alloc_type = UNTAGGED_TAGGED;
+
+	for (alloc_type = UNTAGGED_TAGGED; alloc_type < (int) BLOCK_ALLOC_MAX; alloc_type++) {
+		switch (alloc_type) {
+		case UNTAGGED_TAGGED:
+			src = (char *)mte_allocate_memory(size, mem_type, 0, false);
+			if (check_allocated_memory(src, size, mem_type, false) != KSFT_PASS)
+				return KSFT_FAIL;
+
+			dst = (char *)mte_allocate_memory(size, mem_type, 0, true);
+			if (check_allocated_memory(dst, size, mem_type, true) != KSFT_PASS) {
+				mte_free_memory((void *)src, size, mem_type, false);
+				return KSFT_FAIL;
+			}
+
+			break;
+		case TAGGED_UNTAGGED:
+			dst = (char *)mte_allocate_memory(size, mem_type, 0, false);
+			if (check_allocated_memory(dst, size, mem_type, false) != KSFT_PASS)
+				return KSFT_FAIL;
+
+			src = (char *)mte_allocate_memory(size, mem_type, 0, true);
+			if (check_allocated_memory(src, size, mem_type, true) != KSFT_PASS) {
+				mte_free_memory((void *)dst, size, mem_type, false);
+				return KSFT_FAIL;
+			}
+			break;
+		case TAGGED_TAGGED:
+			src = (char *)mte_allocate_memory(size, mem_type, 0, true);
+			if (check_allocated_memory(src, size, mem_type, true) != KSFT_PASS)
+				return KSFT_FAIL;
+
+			dst = (char *)mte_allocate_memory(size, mem_type, 0, true);
+			if (check_allocated_memory(dst, size, mem_type, true) != KSFT_PASS) {
+				mte_free_memory((void *)src, size, mem_type, true);
+				return KSFT_FAIL;
+			}
+			break;
+		default:
+			return KSFT_FAIL;
+		}
+
+		cur_mte_cxt.fault_valid = false;
+		result = KSFT_PASS;
+		mte_initialize_current_context(mode, (uintptr_t)dst, size);
+		/* Set some value in memory and copy*/
+		memset((void *)src, (int)'1', size);
+		memcpy((void *)dst, (void *)src, size);
+		mte_wait_after_trig();
+		if (cur_mte_cxt.fault_valid) {
+			result = KSFT_FAIL;
+			goto check_buffer_by_block_err;
+		}
+		/* Check the buffer whether it is filled. */
+		for (j = 0; j < size; j++) {
+			if (src[j] != dst[j] || src[j] != '1') {
+				result = KSFT_FAIL;
+				break;
+			}
+		}
+check_buffer_by_block_err:
+		mte_free_memory((void *)src, size, mem_type,
+				MT_FETCH_TAG((uintptr_t)src) ? true : false);
+		mte_free_memory((void *)dst, size, mem_type,
+				MT_FETCH_TAG((uintptr_t)dst) ? true : false);
+		if (result != KSFT_PASS)
+			return result;
+	}
+	return result;
+}
+
+static int check_buffer_by_block(int mem_type, int mode)
+{
+	int i, item, result = KSFT_PASS;
+
+	mte_switch_mode(mode, MTE_ALLOW_NON_ZERO_TAG);
+	item = sizeof(sizes)/sizeof(int);
+	cur_mte_cxt.fault_valid = false;
+	for (i = 0; i < item; i++) {
+		result = check_buffer_by_block_iterate(mem_type, mode, sizes[i]);
+		if (result != KSFT_PASS)
+			break;
+	}
+	return result;
+}
+
+static int compare_memory_tags(char *ptr, size_t size, int tag)
+{
+	int i, new_tag;
+
+	for (i = 0 ; i < size ; i += MT_GRANULE_SIZE) {
+		new_tag = MT_FETCH_TAG((uintptr_t)(mte_get_tag_address(ptr + i)));
+		if (tag != new_tag) {
+			ksft_print_msg("FAIL: child mte tag mismatch\n");
+			return KSFT_FAIL;
+		}
+	}
+	return KSFT_PASS;
+}
+
+static int check_memory_initial_tags(int mem_type, int mode, int mapping)
+{
+	char *ptr;
+	int run, fd;
+	int total = sizeof(sizes)/sizeof(int);
+
+	mte_switch_mode(mode, MTE_ALLOW_NON_ZERO_TAG);
+	for (run = 0; run < total; run++) {
+		/* check initial tags for anonymous mmap */
+		ptr = (char *)mte_allocate_memory(sizes[run], mem_type, mapping, false);
+		if (check_allocated_memory(ptr, sizes[run], mem_type, false) != KSFT_PASS)
+			return KSFT_FAIL;
+		if (compare_memory_tags(ptr, sizes[run], 0) != KSFT_PASS) {
+			mte_free_memory((void *)ptr, sizes[run], mem_type, false);
+			return KSFT_FAIL;
+		}
+		mte_free_memory((void *)ptr, sizes[run], mem_type, false);
+
+		/* check initial tags for file mmap */
+		fd = create_temp_file();
+		if (fd == -1)
+			return KSFT_FAIL;
+		ptr = (char *)mte_allocate_file_memory(sizes[run], mem_type, mapping, false, fd);
+		if (check_allocated_memory(ptr, sizes[run], mem_type, false) != KSFT_PASS) {
+			close(fd);
+			return KSFT_FAIL;
+		}
+		if (compare_memory_tags(ptr, sizes[run], 0) != KSFT_PASS) {
+			mte_free_memory((void *)ptr, sizes[run], mem_type, false);
+			close(fd);
+			return KSFT_FAIL;
+		}
+		mte_free_memory((void *)ptr, sizes[run], mem_type, false);
+		close(fd);
+	}
+	return KSFT_PASS;
+}
+
+int main(int argc, char *argv[])
+{
+	int err;
+	size_t page_size = getpagesize();
+	int item = sizeof(sizes)/sizeof(int);
+
+	sizes[item - 3] = page_size - 1;
+	sizes[item - 2] = page_size;
+	sizes[item - 1] = page_size + 1;
+
+	err = mte_default_setup();
+	if (err)
+		return err;
+
+	/* Register SIGSEGV handler */
+	mte_register_signal(SIGSEGV, mte_default_handler);
+
+	/* Buffer by byte tests */
+	evaluate_test(check_buffer_by_byte(USE_MMAP, MTE_SYNC_ERR),
+	"Check buffer correctness by byte with sync err mode and mmap memory\n");
+	evaluate_test(check_buffer_by_byte(USE_MMAP, MTE_ASYNC_ERR),
+	"Check buffer correctness by byte with async err mode and mmap memory\n");
+	evaluate_test(check_buffer_by_byte(USE_MPROTECT, MTE_SYNC_ERR),
+	"Check buffer correctness by byte with sync err mode and mmap/mprotect memory\n");
+	evaluate_test(check_buffer_by_byte(USE_MPROTECT, MTE_ASYNC_ERR),
+	"Check buffer correctness by byte with async err mode and mmap/mprotect memory\n");
+
+	/* Check buffer underflow with underflow size as 16 */
+	evaluate_test(check_buffer_underflow_by_byte(USE_MMAP, MTE_SYNC_ERR, MT_GRANULE_SIZE),
+	"Check buffer write underflow by byte with sync mode and mmap memory\n");
+	evaluate_test(check_buffer_underflow_by_byte(USE_MMAP, MTE_ASYNC_ERR, MT_GRANULE_SIZE),
+	"Check buffer write underflow by byte with async mode and mmap memory\n");
+	evaluate_test(check_buffer_underflow_by_byte(USE_MMAP, MTE_NONE_ERR, MT_GRANULE_SIZE),
+	"Check buffer write underflow by byte with tag check fault ignore and mmap memory\n");
+
+	/* Check buffer underflow with underflow size as page size */
+	evaluate_test(check_buffer_underflow_by_byte(USE_MMAP, MTE_SYNC_ERR, page_size),
+	"Check buffer write underflow by byte with sync mode and mmap memory\n");
+	evaluate_test(check_buffer_underflow_by_byte(USE_MMAP, MTE_ASYNC_ERR, page_size),
+	"Check buffer write underflow by byte with async mode and mmap memory\n");
+	evaluate_test(check_buffer_underflow_by_byte(USE_MMAP, MTE_NONE_ERR, page_size),
+	"Check buffer write underflow by byte with tag check fault ignore and mmap memory\n");
+
+	/* Check buffer overflow with overflow size as 16 */
+	evaluate_test(check_buffer_overflow_by_byte(USE_MMAP, MTE_SYNC_ERR, MT_GRANULE_SIZE),
+	"Check buffer write overflow by byte with sync mode and mmap memory\n");
+	evaluate_test(check_buffer_overflow_by_byte(USE_MMAP, MTE_ASYNC_ERR, MT_GRANULE_SIZE),
+	"Check buffer write overflow by byte with async mode and mmap memory\n");
+	evaluate_test(check_buffer_overflow_by_byte(USE_MMAP, MTE_NONE_ERR, MT_GRANULE_SIZE),
+	"Check buffer write overflow by byte with tag fault ignore mode and mmap memory\n");
+
+	/* Buffer by block tests */
+	evaluate_test(check_buffer_by_block(USE_MMAP, MTE_SYNC_ERR),
+	"Check buffer write correctness by block with sync mode and mmap memory\n");
+	evaluate_test(check_buffer_by_block(USE_MMAP, MTE_ASYNC_ERR),
+	"Check buffer write correctness by block with async mode and mmap memory\n");
+	evaluate_test(check_buffer_by_block(USE_MMAP, MTE_NONE_ERR),
+	"Check buffer write correctness by block with tag fault ignore and mmap memory\n");
+
+	/* Initial tags are supposed to be 0 */
+	evaluate_test(check_memory_initial_tags(USE_MMAP, MTE_SYNC_ERR, MAP_PRIVATE),
+	"Check initial tags with private mapping, sync error mode and mmap memory\n");
+	evaluate_test(check_memory_initial_tags(USE_MPROTECT, MTE_SYNC_ERR, MAP_PRIVATE),
+	"Check initial tags with private mapping, sync error mode and mmap/mprotect memory\n");
+	evaluate_test(check_memory_initial_tags(USE_MMAP, MTE_SYNC_ERR, MAP_SHARED),
+	"Check initial tags with shared mapping, sync error mode and mmap memory\n");
+	evaluate_test(check_memory_initial_tags(USE_MPROTECT, MTE_SYNC_ERR, MAP_SHARED),
+	"Check initial tags with shared mapping, sync error mode and mmap/mprotect memory\n");
+
+	mte_restore_setup();
+	ksft_print_cnts();
+	return ksft_get_fail_cnt() == 0 ? KSFT_PASS : KSFT_FAIL;
+}
diff --git a/tools/testing/selftests/arm64/mte/mte_common_util.c b/tools/testing/selftests/arm64/mte/mte_common_util.c
new file mode 100644
index 000000000000..39f8908988ea
--- /dev/null
+++ b/tools/testing/selftests/arm64/mte/mte_common_util.c
@@ -0,0 +1,341 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2020 ARM Limited
+
+#include <fcntl.h>
+#include <sched.h>
+#include <signal.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+
+#include <linux/auxvec.h>
+#include <sys/auxv.h>
+#include <sys/mman.h>
+#include <sys/prctl.h>
+
+#include <asm/hwcap.h>
+
+#include "kselftest.h"
+#include "mte_common_util.h"
+#include "mte_def.h"
+
+#define INIT_BUFFER_SIZE       256
+
+struct mte_fault_cxt cur_mte_cxt;
+static unsigned int mte_cur_mode;
+static unsigned int mte_cur_pstate_tco;
+
+void mte_default_handler(int signum, siginfo_t *si, void *uc)
+{
+	unsigned long addr = (unsigned long)si->si_addr;
+
+	if (signum == SIGSEGV) {
+#ifdef DEBUG
+		ksft_print_msg("INFO: SIGSEGV signal at pc=%lx, fault addr=%lx, si_code=%lx\n",
+				((ucontext_t *)uc)->uc_mcontext.pc, addr, si->si_code);
+#endif
+		if (si->si_code == SEGV_MTEAERR) {
+			if (cur_mte_cxt.trig_si_code == si->si_code)
+				cur_mte_cxt.fault_valid = true;
+			return;
+		}
+		/* Compare the context for precise error */
+		else if (si->si_code == SEGV_MTESERR) {
+			if (cur_mte_cxt.trig_si_code == si->si_code &&
+			    ((cur_mte_cxt.trig_range >= 0 &&
+			      addr >= MT_CLEAR_TAG(cur_mte_cxt.trig_addr) &&
+			      addr <= (MT_CLEAR_TAG(cur_mte_cxt.trig_addr) + cur_mte_cxt.trig_range)) ||
+			     (cur_mte_cxt.trig_range < 0 &&
+			      addr <= MT_CLEAR_TAG(cur_mte_cxt.trig_addr) &&
+			      addr >= (MT_CLEAR_TAG(cur_mte_cxt.trig_addr) + cur_mte_cxt.trig_range)))) {
+				cur_mte_cxt.fault_valid = true;
+				/* Adjust the pc by 4 */
+				((ucontext_t *)uc)->uc_mcontext.pc += 4;
+			} else {
+				ksft_print_msg("Invalid MTE synchronous exception caught!\n");
+				exit(1);
+			}
+		} else {
+			ksft_print_msg("Unknown SIGSEGV exception caught!\n");
+			exit(1);
+		}
+	} else if (signum == SIGBUS) {
+		ksft_print_msg("INFO: SIGBUS signal at pc=%lx, fault addr=%lx, si_code=%lx\n",
+				((ucontext_t *)uc)->uc_mcontext.pc, addr, si->si_code);
+		if ((cur_mte_cxt.trig_range >= 0 &&
+		     addr >= MT_CLEAR_TAG(cur_mte_cxt.trig_addr) &&
+		     addr <= (MT_CLEAR_TAG(cur_mte_cxt.trig_addr) + cur_mte_cxt.trig_range)) ||
+		    (cur_mte_cxt.trig_range < 0 &&
+		     addr <= MT_CLEAR_TAG(cur_mte_cxt.trig_addr) &&
+		     addr >= (MT_CLEAR_TAG(cur_mte_cxt.trig_addr) + cur_mte_cxt.trig_range))) {
+			cur_mte_cxt.fault_valid = true;
+			/* Adjust the pc by 4 */
+			((ucontext_t *)uc)->uc_mcontext.pc += 4;
+		}
+	}
+}
+
+void mte_register_signal(int signal, void (*handler)(int, siginfo_t *, void *))
+{
+	struct sigaction sa;
+
+	sa.sa_sigaction = handler;
+	sa.sa_flags = SA_SIGINFO;
+	sigemptyset(&sa.sa_mask);
+	sigaction(signal, &sa, NULL);
+}
+
+void mte_wait_after_trig(void)
+{
+	sched_yield();
+}
+
+void *mte_insert_tags(void *ptr, size_t size)
+{
+	void *tag_ptr;
+	int align_size;
+
+	if (!ptr || (unsigned long)(ptr) & MT_ALIGN_GRANULE) {
+		ksft_print_msg("FAIL: Addr=%lx: invalid\n", ptr);
+		return NULL;
+	}
+	align_size = MT_ALIGN_UP(size);
+	tag_ptr = mte_insert_random_tag(ptr);
+	mte_set_tag_address_range(tag_ptr, align_size);
+	return tag_ptr;
+}
+
+void mte_clear_tags(void *ptr, size_t size)
+{
+	if (!ptr || (unsigned long)(ptr) & MT_ALIGN_GRANULE) {
+		ksft_print_msg("FAIL: Addr=%lx: invalid\n", ptr);
+		return;
+	}
+	size = MT_ALIGN_UP(size);
+	ptr = (void *)MT_CLEAR_TAG((unsigned long)ptr);
+	mte_clear_tag_address_range(ptr, size);
+}
+
+static void *__mte_allocate_memory_range(size_t size, int mem_type, int mapping,
+					 size_t range_before, size_t range_after,
+					 bool tags, int fd)
+{
+	void *ptr;
+	int prot_flag, map_flag;
+	size_t entire_size = size + range_before + range_after;
+
+	if (mem_type != USE_MALLOC && mem_type != USE_MMAP &&
+	    mem_type != USE_MPROTECT) {
+		ksft_print_msg("FAIL: Invalid allocate request\n");
+		return NULL;
+	}
+	if (mem_type == USE_MALLOC)
+		return malloc(entire_size) + range_before;
+
+	prot_flag = PROT_READ | PROT_WRITE;
+	if (mem_type == USE_MMAP)
+		prot_flag |= PROT_MTE;
+
+	map_flag = mapping;
+	if (fd == -1)
+		map_flag = MAP_ANONYMOUS | map_flag;
+	if (!(mapping & MAP_SHARED))
+		map_flag |= MAP_PRIVATE;
+	ptr = mmap(NULL, entire_size, prot_flag, map_flag, fd, 0);
+	if (ptr == MAP_FAILED) {
+		ksft_print_msg("FAIL: mmap allocation\n");
+		return NULL;
+	}
+	if (mem_type == USE_MPROTECT) {
+		if (mprotect(ptr, entire_size, prot_flag | PROT_MTE)) {
+			munmap(ptr, size);
+			ksft_print_msg("FAIL: mprotect PROT_MTE property\n");
+			return NULL;
+		}
+	}
+	if (tags)
+		ptr = mte_insert_tags(ptr + range_before, size);
+	return ptr;
+}
+
+void *mte_allocate_memory_tag_range(size_t size, int mem_type, int mapping,
+				    size_t range_before, size_t range_after)
+{
+	return __mte_allocate_memory_range(size, mem_type, mapping, range_before,
+					   range_after, true, -1);
+}
+
+void *mte_allocate_memory(size_t size, int mem_type, int mapping, bool tags)
+{
+	return __mte_allocate_memory_range(size, mem_type, mapping, 0, 0, tags, -1);
+}
+
+void *mte_allocate_file_memory(size_t size, int mem_type, int mapping, bool tags, int fd)
+{
+	int index;
+	char buffer[INIT_BUFFER_SIZE];
+
+	if (mem_type != USE_MPROTECT && mem_type != USE_MMAP) {
+		ksft_print_msg("FAIL: Invalid mmap file request\n");
+		return NULL;
+	}
+	/* Initialize the file for mappable size */
+	lseek(fd, 0, SEEK_SET);
+	for (index = INIT_BUFFER_SIZE; index < size; index += INIT_BUFFER_SIZE)
+		write(fd, buffer, INIT_BUFFER_SIZE);
+	index -= INIT_BUFFER_SIZE;
+	write(fd, buffer, size - index);
+	return __mte_allocate_memory_range(size, mem_type, mapping, 0, 0, tags, fd);
+}
+
+void *mte_allocate_file_memory_tag_range(size_t size, int mem_type, int mapping,
+					 size_t range_before, size_t range_after, int fd)
+{
+	int index;
+	char buffer[INIT_BUFFER_SIZE];
+	int map_size = size + range_before + range_after;
+
+	if (mem_type != USE_MPROTECT && mem_type != USE_MMAP) {
+		ksft_print_msg("FAIL: Invalid mmap file request\n");
+		return NULL;
+	}
+	/* Initialize the file for mappable size */
+	lseek(fd, 0, SEEK_SET);
+	for (index = INIT_BUFFER_SIZE; index < map_size; index += INIT_BUFFER_SIZE)
+		write(fd, buffer, INIT_BUFFER_SIZE);
+	index -= INIT_BUFFER_SIZE;
+	write(fd, buffer, map_size - index);
+	return __mte_allocate_memory_range(size, mem_type, mapping, range_before,
+					   range_after, true, fd);
+}
+
+static void __mte_free_memory_range(void *ptr, size_t size, int mem_type,
+				    size_t range_before, size_t range_after, bool tags)
+{
+	switch (mem_type) {
+	case USE_MALLOC:
+		free(ptr - range_before);
+		break;
+	case USE_MMAP:
+	case USE_MPROTECT:
+		if (tags)
+			mte_clear_tags(ptr, size);
+		munmap(ptr - range_before, size + range_before + range_after);
+		break;
+	default:
+		ksft_print_msg("FAIL: Invalid free request\n");
+		break;
+	}
+}
+
+void mte_free_memory_tag_range(void *ptr, size_t size, int mem_type,
+			       size_t range_before, size_t range_after)
+{
+	__mte_free_memory_range(ptr, size, mem_type, range_before, range_after, true);
+}
+
+void mte_free_memory(void *ptr, size_t size, int mem_type, bool tags)
+{
+	__mte_free_memory_range(ptr, size, mem_type, 0, 0, tags);
+}
+
+void mte_initialize_current_context(int mode, uintptr_t ptr, ssize_t range)
+{
+	cur_mte_cxt.fault_valid = false;
+	cur_mte_cxt.trig_addr = ptr;
+	cur_mte_cxt.trig_range = range;
+	if (mode == MTE_SYNC_ERR)
+		cur_mte_cxt.trig_si_code = SEGV_MTESERR;
+	else if (mode == MTE_ASYNC_ERR)
+		cur_mte_cxt.trig_si_code = SEGV_MTEAERR;
+	else
+		cur_mte_cxt.trig_si_code = 0;
+}
+
+int mte_switch_mode(int mte_option, unsigned long incl_mask)
+{
+	unsigned long en = 0;
+
+	if (!(mte_option == MTE_SYNC_ERR || mte_option == MTE_ASYNC_ERR ||
+	      mte_option == MTE_NONE_ERR || incl_mask <= MTE_ALLOW_NON_ZERO_TAG)) {
+		ksft_print_msg("FAIL: Invalid mte config option\n");
+		return -EINVAL;
+	}
+	en = PR_TAGGED_ADDR_ENABLE;
+	if (mte_option == MTE_SYNC_ERR)
+		en |= PR_MTE_TCF_SYNC;
+	else if (mte_option == MTE_ASYNC_ERR)
+		en |= PR_MTE_TCF_ASYNC;
+	else if (mte_option == MTE_NONE_ERR)
+		en |= PR_MTE_TCF_NONE;
+
+	en |= (incl_mask << PR_MTE_TAG_SHIFT);
+	/* Enable address tagging ABI, mte error reporting mode and tag inclusion mask. */
+	if (!prctl(PR_SET_TAGGED_ADDR_CTRL, en, 0, 0, 0) == 0) {
+		ksft_print_msg("FAIL:prctl PR_SET_TAGGED_ADDR_CTRL for mte mode\n");
+		return -EINVAL;
+	}
+	return 0;
+}
+
+#define ID_AA64PFR1_MTE_SHIFT		8
+#define ID_AA64PFR1_MTE			2
+
+int mte_default_setup(void)
+{
+	unsigned long hwcaps = getauxval(AT_HWCAP);
+	unsigned long en = 0;
+	int ret;
+
+	if (!(hwcaps & HWCAP_CPUID)) {
+		ksft_print_msg("FAIL: CPUID registers unavailable\n");
+		return KSFT_FAIL;
+	}
+	/* Read ID_AA64PFR1_EL1 register */
+	asm volatile("mrs %0, id_aa64pfr1_el1" : "=r"(hwcaps) : : "memory");
+	if (((hwcaps >> ID_AA64PFR1_MTE_SHIFT) & MT_TAG_MASK) != ID_AA64PFR1_MTE) {
+		ksft_print_msg("FAIL: MTE features unavailable\n");
+		return KSFT_SKIP;
+	}
+	/* Get current mte mode */
+	ret = prctl(PR_GET_TAGGED_ADDR_CTRL, en, 0, 0, 0);
+	if (ret < 0) {
+		ksft_print_msg("FAIL:prctl PR_GET_TAGGED_ADDR_CTRL with error =%d\n", ret);
+		return KSFT_FAIL;
+	}
+	if (ret & PR_MTE_TCF_SYNC)
+		mte_cur_mode = MTE_SYNC_ERR;
+	else if (ret & PR_MTE_TCF_ASYNC)
+		mte_cur_mode = MTE_ASYNC_ERR;
+	else if (ret & PR_MTE_TCF_NONE)
+		mte_cur_mode = MTE_NONE_ERR;
+
+	mte_cur_pstate_tco = mte_get_pstate_tco();
+	/* Disable PSTATE.TCO */
+	mte_disable_pstate_tco();
+	return 0;
+}
+
+void mte_restore_setup(void)
+{
+	mte_switch_mode(mte_cur_mode, MTE_ALLOW_NON_ZERO_TAG);
+	if (mte_cur_pstate_tco == MT_PSTATE_TCO_EN)
+		mte_enable_pstate_tco();
+	else if (mte_cur_pstate_tco == MT_PSTATE_TCO_DIS)
+		mte_disable_pstate_tco();
+}
+
+int create_temp_file(void)
+{
+	int fd;
+	char filename[] = "/dev/shm/tmp_XXXXXX";
+
+	/* Create a file in the tmpfs filesystem */
+	fd = mkstemp(&filename[0]);
+	if (fd == -1) {
+		ksft_print_msg("FAIL: Unable to open temporary file\n");
+		return 0;
+	}
+	unlink(&filename[0]);
+	return fd;
+}
diff --git a/tools/testing/selftests/arm64/mte/mte_common_util.h b/tools/testing/selftests/arm64/mte/mte_common_util.h
new file mode 100644
index 000000000000..45160e061a0e
--- /dev/null
+++ b/tools/testing/selftests/arm64/mte/mte_common_util.h
@@ -0,0 +1,117 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2020 ARM Limited */
+
+#ifndef _MTE_COMMON_UTIL_H
+#define _MTE_COMMON_UTIL_H
+
+#include <signal.h>
+#include <stdbool.h>
+#include <stdlib.h>
+#include <sys/auxv.h>
+#include <sys/mman.h>
+#include <sys/prctl.h>
+#include "mte_def.h"
+#include "kselftest.h"
+
+enum mte_mem_type {
+	USE_MALLOC,
+	USE_MMAP,
+	USE_MPROTECT,
+};
+
+enum mte_mode {
+	MTE_NONE_ERR,
+	MTE_SYNC_ERR,
+	MTE_ASYNC_ERR,
+};
+
+struct mte_fault_cxt {
+	/* Address start which triggers mte tag fault */
+	unsigned long trig_addr;
+	/* Address range for mte tag fault and negative value means underflow */
+	ssize_t trig_range;
+	/* siginfo si code */
+	unsigned long trig_si_code;
+	/* Flag to denote if correct fault caught */
+	bool fault_valid;
+};
+
+extern struct mte_fault_cxt cur_mte_cxt;
+
+/* MTE utility functions */
+void mte_default_handler(int signum, siginfo_t *si, void *uc);
+void mte_register_signal(int signal, void (*handler)(int, siginfo_t *, void *));
+void mte_wait_after_trig(void);
+void *mte_allocate_memory(size_t size, int mem_type, int mapping, bool tags);
+void *mte_allocate_memory_tag_range(size_t size, int mem_type, int mapping,
+				    size_t range_before, size_t range_after);
+void *mte_allocate_file_memory(size_t size, int mem_type, int mapping,
+			       bool tags, int fd);
+void *mte_allocate_file_memory_tag_range(size_t size, int mem_type, int mapping,
+					 size_t range_before, size_t range_after, int fd);
+void mte_free_memory(void *ptr, size_t size, int mem_type, bool tags);
+void mte_free_memory_tag_range(void *ptr, size_t size, int mem_type,
+			       size_t range_before, size_t range_after);
+void *mte_insert_tags(void *ptr, size_t size);
+void mte_clear_tags(void *ptr, size_t size);
+int mte_default_setup(void);
+void mte_restore_setup(void);
+int mte_switch_mode(int mte_option, unsigned long incl_mask);
+void mte_initialize_current_context(int mode, uintptr_t ptr, ssize_t range);
+
+/* Common utility functions */
+int create_temp_file(void);
+
+/* Assembly MTE utility functions */
+void *mte_insert_random_tag(void *ptr);
+void *mte_get_tag_address(void *ptr);
+void mte_set_tag_address_range(void *ptr, int range);
+void mte_clear_tag_address_range(void *ptr, int range);
+void mte_disable_pstate_tco(void);
+void mte_enable_pstate_tco(void);
+unsigned int mte_get_pstate_tco(void);
+
+/* Test framework static inline functions/macros */
+static inline void evaluate_test(int err, const char *msg)
+{
+	if (err == KSFT_PASS)
+		ksft_test_result_pass(msg);
+	else if (err == KSFT_FAIL)
+		ksft_test_result_fail(msg);
+}
+
+static inline int check_allocated_memory(void *ptr, size_t size,
+					 int mem_type, bool tags)
+{
+	if (ptr == NULL) {
+		ksft_print_msg("FAIL: memory allocation\n");
+		return KSFT_FAIL;
+	}
+
+	if (tags && !MT_FETCH_TAG((uintptr_t)ptr)) {
+		ksft_print_msg("FAIL: tag not found at addr(%p)\n", ptr);
+		mte_free_memory((void *)ptr, size, mem_type, false);
+		return KSFT_FAIL;
+	}
+
+	return KSFT_PASS;
+}
+
+static inline int check_allocated_memory_range(void *ptr, size_t size, int mem_type,
+					       size_t range_before, size_t range_after)
+{
+	if (ptr == NULL) {
+		ksft_print_msg("FAIL: memory allocation\n");
+		return KSFT_FAIL;
+	}
+
+	if (!MT_FETCH_TAG((uintptr_t)ptr)) {
+		ksft_print_msg("FAIL: tag not found at addr(%p)\n", ptr);
+		mte_free_memory_tag_range((void *)ptr, size, mem_type, range_before,
+					  range_after);
+		return KSFT_FAIL;
+	}
+	return KSFT_PASS;
+}
+
+#endif /* _MTE_COMMON_UTIL_H */
diff --git a/tools/testing/selftests/arm64/mte/mte_def.h b/tools/testing/selftests/arm64/mte/mte_def.h
new file mode 100644
index 000000000000..9b188254b61a
--- /dev/null
+++ b/tools/testing/selftests/arm64/mte/mte_def.h
@@ -0,0 +1,60 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2020 ARM Limited */
+
+/*
+ * Below definitions may be found in kernel headers, However, they are
+ * redefined here to decouple the MTE selftests compilations from them.
+ */
+#ifndef SEGV_MTEAERR
+#define	SEGV_MTEAERR	8
+#endif
+#ifndef SEGV_MTESERR
+#define	SEGV_MTESERR	9
+#endif
+#ifndef PROT_MTE
+#define PROT_MTE	 0x20
+#endif
+#ifndef HWCAP2_MTE
+#define HWCAP2_MTE	(1 << 18)
+#endif
+
+#ifndef PR_MTE_TCF_SHIFT
+#define PR_MTE_TCF_SHIFT	1
+#endif
+#ifndef PR_MTE_TCF_NONE
+#define PR_MTE_TCF_NONE		(0UL << PR_MTE_TCF_SHIFT)
+#endif
+#ifndef PR_MTE_TCF_SYNC
+#define	PR_MTE_TCF_SYNC		(1UL << PR_MTE_TCF_SHIFT)
+#endif
+#ifndef PR_MTE_TCF_ASYNC
+#define PR_MTE_TCF_ASYNC	(2UL << PR_MTE_TCF_SHIFT)
+#endif
+#ifndef PR_MTE_TAG_SHIFT
+#define	PR_MTE_TAG_SHIFT	3
+#endif
+
+/* MTE Hardware feature definitions below. */
+#define MT_TAG_SHIFT		56
+#define MT_TAG_MASK		0xFUL
+#define MT_FREE_TAG		0x0UL
+#define MT_GRANULE_SIZE         16
+#define MT_TAG_COUNT		16
+#define MT_INCLUDE_TAG_MASK	0xFFFF
+#define MT_EXCLUDE_TAG_MASK	0x0
+
+#define MT_ALIGN_GRANULE	(MT_GRANULE_SIZE - 1)
+#define MT_CLEAR_TAG(x)		((x) & ~(MT_TAG_MASK << MT_TAG_SHIFT))
+#define MT_SET_TAG(x, y)	((x) | (y << MT_TAG_SHIFT))
+#define MT_FETCH_TAG(x)		((x >> MT_TAG_SHIFT) & (MT_TAG_MASK))
+#define MT_ALIGN_UP(x)		((x + MT_ALIGN_GRANULE) & ~(MT_ALIGN_GRANULE))
+
+#define MT_PSTATE_TCO_SHIFT	25
+#define MT_PSTATE_TCO_MASK	~(0x1 << MT_PSTATE_TCO_SHIFT)
+#define MT_PSTATE_TCO_EN	1
+#define MT_PSTATE_TCO_DIS	0
+
+#define MT_EXCLUDE_TAG(x)		(1 << (x))
+#define MT_INCLUDE_VALID_TAG(x)		(MT_INCLUDE_TAG_MASK ^ MT_EXCLUDE_TAG(x))
+#define MT_INCLUDE_VALID_TAGS(x)	(MT_INCLUDE_TAG_MASK ^ (x))
+#define MTE_ALLOW_NON_ZERO_TAG		MT_INCLUDE_VALID_TAG(0)
diff --git a/tools/testing/selftests/arm64/mte/mte_helper.S b/tools/testing/selftests/arm64/mte/mte_helper.S
new file mode 100644
index 000000000000..48e049fbad9a
--- /dev/null
+++ b/tools/testing/selftests/arm64/mte/mte_helper.S
@@ -0,0 +1,114 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2020 ARM Limited */
+
+#include "mte_def.h"
+
+#define ENTRY(name) \
+	.globl name ;\
+	.p2align 2;\
+	.type name, @function ;\
+name:
+
+#define ENDPROC(name) \
+	.size name, .-name ;
+
+	.text
+/*
+ * mte_insert_random_tag: Insert random tag and might be same as the source tag if
+ *			  the source pointer has it.
+ * Input:
+ *		x0 - source pointer with a tag/no-tag
+ * Return:
+ *		x0 - pointer with random tag
+ */
+ENTRY(mte_insert_random_tag)
+	irg	x0, x0, xzr
+	ret
+ENDPROC(mte_insert_random_tag)
+
+/*
+ * mte_get_tag_address: Get the tag from given address.
+ * Input:
+ *		x0 - source pointer
+ * Return:
+ *		x0 - pointer with appended tag
+ */
+ENTRY(mte_get_tag_address)
+	ldg	x0, [x0]
+	ret
+ENDPROC(mte_get_tag_address)
+
+/*
+ * mte_set_tag_address_range: Set the tag range from the given address
+ * Input:
+ *		x0 - source pointer with tag data
+ *		x1 - range
+ * Return:
+ *		none
+ */
+ENTRY(mte_set_tag_address_range)
+	cbz	x1, 2f
+1:
+	stg	x0, [x0, #0x0]
+	add	x0, x0, #MT_GRANULE_SIZE
+	sub	x1, x1, #MT_GRANULE_SIZE
+	cbnz	x1, 1b
+2:
+	ret
+ENDPROC(mte_set_tag_address_range)
+
+/*
+ * mt_clear_tag_address_range: Clear the tag range from the given address
+ * Input:
+ *		x0 - source pointer with tag data
+ *		x1 - range
+ * Return:
+ *		none
+ */
+ENTRY(mte_clear_tag_address_range)
+	cbz	x1, 2f
+1:
+	stzg	x0, [x0, #0x0]
+	add	x0, x0, #MT_GRANULE_SIZE
+	sub	x1, x1, #MT_GRANULE_SIZE
+	cbnz	x1, 1b
+2:
+	ret
+ENDPROC(mte_clear_tag_address_range)
+
+/*
+ * mte_enable_pstate_tco: Enable PSTATE.TCO (tag check override) field
+ * Input:
+ *		none
+ * Return:
+ *		none
+ */
+ENTRY(mte_enable_pstate_tco)
+	msr	tco, #MT_PSTATE_TCO_EN
+	ret
+ENDPROC(mte_enable_pstate_tco)
+
+/*
+ * mte_disable_pstate_tco: Disable PSTATE.TCO (tag check override) field
+ * Input:
+ *		none
+ * Return:
+ *		none
+ */
+ENTRY(mte_disable_pstate_tco)
+	msr	tco, #MT_PSTATE_TCO_DIS
+	ret
+ENDPROC(mte_disable_pstate_tco)
+
+/*
+ * mte_get_pstate_tco: Get PSTATE.TCO (tag check override) field
+ * Input:
+ *		none
+ * Return:
+ *		x0
+ */
+ENTRY(mte_get_pstate_tco)
+	mrs	x0, tco
+	ubfx	x0, x0, #MT_PSTATE_TCO_SHIFT, #1
+	ret
+ENDPROC(mte_get_pstate_tco)
-- 
2.17.1

