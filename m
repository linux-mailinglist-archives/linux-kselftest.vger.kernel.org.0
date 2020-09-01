Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7300E258B82
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Sep 2020 11:28:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726126AbgIAJ1o (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 1 Sep 2020 05:27:44 -0400
Received: from foss.arm.com ([217.140.110.172]:39146 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726537AbgIAJ1m (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 1 Sep 2020 05:27:42 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D719D1063;
        Tue,  1 Sep 2020 02:27:41 -0700 (PDT)
Received: from a077416.arm.com (unknown [10.57.6.112])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 081273F71F;
        Tue,  1 Sep 2020 02:27:38 -0700 (PDT)
From:   Amit Daniel Kachhap <amit.kachhap@arm.com>
To:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Vincenzo Frascino <Vincenzo.Frascino@arm.com>,
        Amit Daniel Kachhap <amit.kachhap@arm.com>,
        Gabor Kertesz <gabor.kertesz@arm.com>
Subject: [PATCH 2/6] kselftest/arm64: Verify mte tag inclusion via prctl
Date:   Tue,  1 Sep 2020 14:57:15 +0530
Message-Id: <20200901092719.9918-3-amit.kachhap@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200901092719.9918-1-amit.kachhap@arm.com>
References: <20200901092719.9918-1-amit.kachhap@arm.com>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This testcase verifies that the tag generated with "irg" instruction
contains only included tags. This is done via prtcl call.

This test covers 4 scenarios,
* At least one included tag.
* More than one included tags.
* None included.
* All included.

Cc: Shuah Khan <shuah@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Co-developed-by: Gabor Kertesz <gabor.kertesz@arm.com>
Signed-off-by: Gabor Kertesz <gabor.kertesz@arm.com>
Signed-off-by: Amit Daniel Kachhap <amit.kachhap@arm.com>
---
 tools/testing/selftests/arm64/mte/.gitignore  |   1 +
 .../arm64/mte/check_tags_inclusion.c          | 183 ++++++++++++++++++
 2 files changed, 184 insertions(+)
 create mode 100644 tools/testing/selftests/arm64/mte/check_tags_inclusion.c

diff --git a/tools/testing/selftests/arm64/mte/.gitignore b/tools/testing/selftests/arm64/mte/.gitignore
index 3f8c1f6c82b9..c3fca255d3d6 100644
--- a/tools/testing/selftests/arm64/mte/.gitignore
+++ b/tools/testing/selftests/arm64/mte/.gitignore
@@ -1 +1,2 @@
 check_buffer_fill
+check_tags_inclusion
diff --git a/tools/testing/selftests/arm64/mte/check_tags_inclusion.c b/tools/testing/selftests/arm64/mte/check_tags_inclusion.c
new file mode 100644
index 000000000000..9614988e2e75
--- /dev/null
+++ b/tools/testing/selftests/arm64/mte/check_tags_inclusion.c
@@ -0,0 +1,183 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2020 ARM Limited
+
+#define _GNU_SOURCE
+
+#include <errno.h>
+#include <signal.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <ucontext.h>
+#include <sys/wait.h>
+
+#include "kselftest.h"
+#include "mte_common_util.h"
+#include "mte_def.h"
+
+#define BUFFER_SIZE		(5 * MT_GRANULE_SIZE)
+#define RUNS			(MT_TAG_COUNT * 2)
+#define MTE_LAST_TAG_MASK	(0x7FFF)
+
+static int verify_mte_pointer_validity(char *ptr, int mode)
+{
+	mte_initialize_current_context(mode, (uintptr_t)ptr, BUFFER_SIZE);
+	/* Check the validity of the tagged pointer */
+	memset((void *)ptr, '1', BUFFER_SIZE);
+	mte_wait_after_trig();
+	if (cur_mte_cxt.fault_valid)
+		return KSFT_FAIL;
+	/* Proceed further for nonzero tags */
+	if (!MT_FETCH_TAG((uintptr_t)ptr))
+		return KSFT_PASS;
+	mte_initialize_current_context(mode, (uintptr_t)ptr, BUFFER_SIZE + 1);
+	/* Check the validity outside the range */
+	ptr[BUFFER_SIZE] = '2';
+	mte_wait_after_trig();
+	if (!cur_mte_cxt.fault_valid)
+		return KSFT_FAIL;
+	else
+		return KSFT_PASS;
+}
+
+static int check_single_included_tags(int mem_type, int mode)
+{
+	char *ptr;
+	int tag, run, result = KSFT_PASS;
+
+	ptr = (char *)mte_allocate_memory(BUFFER_SIZE + MT_GRANULE_SIZE, mem_type, 0, false);
+	if (check_allocated_memory(ptr, BUFFER_SIZE + MT_GRANULE_SIZE,
+				   mem_type, false) != KSFT_PASS)
+		return KSFT_FAIL;
+
+	for (tag = 0; (tag < MT_TAG_COUNT) && (result == KSFT_PASS); tag++) {
+		mte_switch_mode(mode, MT_INCLUDE_VALID_TAG(tag));
+		/* Try to catch a excluded tag by a number of tries. */
+		for (run = 0; (run < RUNS) && (result == KSFT_PASS); run++) {
+			ptr = (char *)mte_insert_tags(ptr, BUFFER_SIZE);
+			/* Check tag value */
+			if (MT_FETCH_TAG((uintptr_t)ptr) == tag) {
+				ksft_print_msg("FAIL: wrong tag = 0x%x with include mask=0x%x\n",
+					       MT_FETCH_TAG((uintptr_t)ptr),
+					       MT_INCLUDE_VALID_TAG(tag));
+				result = KSFT_FAIL;
+				break;
+			}
+			result = verify_mte_pointer_validity(ptr, mode);
+		}
+	}
+	mte_free_memory_tag_range((void *)ptr, BUFFER_SIZE, mem_type, 0, MT_GRANULE_SIZE);
+	return result;
+}
+
+static int check_multiple_included_tags(int mem_type, int mode)
+{
+	char *ptr;
+	int tag, run, result = KSFT_PASS;
+	unsigned long excl_mask = 0;
+
+	ptr = (char *)mte_allocate_memory(BUFFER_SIZE + MT_GRANULE_SIZE, mem_type, 0, false);
+	if (check_allocated_memory(ptr, BUFFER_SIZE + MT_GRANULE_SIZE,
+				   mem_type, false) != KSFT_PASS)
+		return KSFT_FAIL;
+
+	for (tag = 0; (tag < MT_TAG_COUNT - 1) && (result == KSFT_PASS); tag++) {
+		excl_mask |= 1 << tag;
+		mte_switch_mode(mode, MT_INCLUDE_VALID_TAGS(excl_mask));
+		/* Try to catch a excluded tag by a number of tries. */
+		for (run = 0; (run < RUNS) && (result == KSFT_PASS); run++) {
+			/* If excl_mask is all except last then clear tag for the next loop */
+			if (excl_mask == MTE_LAST_TAG_MASK && run)
+				ptr = (char *)MT_CLEAR_TAG((unsigned long)ptr);
+			ptr = (char *)mte_insert_tags(ptr, BUFFER_SIZE);
+			/* Check tag value */
+			if (MT_FETCH_TAG((uintptr_t)ptr) < tag) {
+				ksft_print_msg("FAIL: wrong tag = 0x%x with include mask=0x%x\n",
+					       MT_FETCH_TAG((uintptr_t)ptr),
+					       MT_INCLUDE_VALID_TAGS(excl_mask));
+				result = KSFT_FAIL;
+				break;
+			}
+			result = verify_mte_pointer_validity(ptr, mode);
+		}
+	}
+	mte_free_memory_tag_range((void *)ptr, BUFFER_SIZE, mem_type, 0, MT_GRANULE_SIZE);
+	return result;
+}
+
+static int check_all_included_tags(int mem_type, int mode)
+{
+	char *ptr;
+	int run, result = KSFT_PASS;
+
+	ptr = (char *)mte_allocate_memory(BUFFER_SIZE + MT_GRANULE_SIZE, mem_type, 0, false);
+	if (check_allocated_memory(ptr, BUFFER_SIZE + MT_GRANULE_SIZE,
+				   mem_type, false) != KSFT_PASS)
+		return KSFT_FAIL;
+
+	mte_switch_mode(mode, MT_INCLUDE_TAG_MASK);
+	/* Try to catch a excluded tag by a number of tries. */
+	for (run = 0; (run < RUNS) && (result == KSFT_PASS); run++) {
+		ptr = (char *)mte_insert_tags(ptr, BUFFER_SIZE);
+		/*
+		 * Here tag byte can be between 0x0 to 0xF so no need to match so
+		 * just verify if it is writable.
+		 */
+		result = verify_mte_pointer_validity(ptr, mode);
+	}
+	mte_free_memory_tag_range((void *)ptr, BUFFER_SIZE, mem_type, 0, MT_GRANULE_SIZE);
+	return result;
+}
+
+static int check_none_included_tags(int mem_type, int mode)
+{
+	char *ptr;
+
+	ptr = (char *)mte_allocate_memory(BUFFER_SIZE, mem_type, 0, false);
+	if (check_allocated_memory(ptr, BUFFER_SIZE, mem_type, false) != KSFT_PASS)
+		return KSFT_FAIL;
+
+	mte_switch_mode(mode, 0);
+	ptr = (char *)mte_insert_tags(ptr, BUFFER_SIZE);
+	/* Check tag value */
+	if (MT_FETCH_TAG((uintptr_t)ptr)) {
+		ksft_print_msg("FAIL: included tag value found\n");
+		return KSFT_FAIL;
+	}
+	mte_initialize_current_context(mode, (uintptr_t)ptr, BUFFER_SIZE);
+	/* Check the write validity of the untagged pointer */
+	memset((void *)ptr, '1', BUFFER_SIZE);
+	mte_wait_after_trig();
+	if (cur_mte_cxt.fault_valid)
+		return KSFT_FAIL;
+	else
+		return KSFT_PASS;
+}
+
+int main(int argc, char *argv[])
+{
+	int err;
+
+	err = mte_default_setup();
+	if (err)
+		return err;
+
+	/* Register SIGSEGV handler */
+	mte_register_signal(SIGSEGV, mte_default_handler);
+
+	evaluate_test(check_single_included_tags(USE_MMAP, MTE_SYNC_ERR),
+		      "Check an included tag value with sync mode\n");
+
+	evaluate_test(check_multiple_included_tags(USE_MMAP, MTE_SYNC_ERR),
+		      "Check different included tags value with sync mode\n");
+
+	evaluate_test(check_none_included_tags(USE_MMAP, MTE_SYNC_ERR),
+		      "Check none included tags value with sync mode\n");
+
+	evaluate_test(check_all_included_tags(USE_MMAP, MTE_SYNC_ERR),
+		      "Check all included tags value with sync mode\n");
+
+	mte_restore_setup();
+	ksft_print_cnts();
+	return ksft_get_fail_cnt() == 0 ? KSFT_PASS : KSFT_FAIL;
+}
-- 
2.17.1

