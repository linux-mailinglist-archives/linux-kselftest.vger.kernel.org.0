Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF7D5258B7F
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Sep 2020 11:27:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726858AbgIAJ14 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 1 Sep 2020 05:27:56 -0400
Received: from foss.arm.com ([217.140.110.172]:39178 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726789AbgIAJ1z (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 1 Sep 2020 05:27:55 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CF1361045;
        Tue,  1 Sep 2020 02:27:54 -0700 (PDT)
Received: from a077416.arm.com (unknown [10.57.6.112])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 3CD573F71F;
        Tue,  1 Sep 2020 02:27:51 -0700 (PDT)
From:   Amit Daniel Kachhap <amit.kachhap@arm.com>
To:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Vincenzo Frascino <Vincenzo.Frascino@arm.com>,
        Amit Daniel Kachhap <amit.kachhap@arm.com>
Subject: [PATCH 6/6] kselftest/arm64: Check mte tagged user address in kernel
Date:   Tue,  1 Sep 2020 14:57:19 +0530
Message-Id: <20200901092719.9918-7-amit.kachhap@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200901092719.9918-1-amit.kachhap@arm.com>
References: <20200901092719.9918-1-amit.kachhap@arm.com>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add a testcase to check that user address with valid/invalid
mte tag works in kernel mode. This test verifies the kernel API's
__arch_copy_from_user/__arch_copy_to_user works by considering
if the user pointer has valid/invalid allocation tags.

In MTE sync mode a SIGSEV fault is generated if a user memory
with invalid tag is accessed in kernel. In async mode no such
fault occurs.

Cc: Shuah Khan <shuah@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Signed-off-by: Amit Daniel Kachhap <amit.kachhap@arm.com>
---
 tools/testing/selftests/arm64/mte/.gitignore  |   1 +
 .../selftests/arm64/mte/check_user_mem.c      | 118 ++++++++++++++++++
 2 files changed, 119 insertions(+)
 create mode 100644 tools/testing/selftests/arm64/mte/check_user_mem.c

diff --git a/tools/testing/selftests/arm64/mte/.gitignore b/tools/testing/selftests/arm64/mte/.gitignore
index 44e9bfdaeca6..bc3ac63f3314 100644
--- a/tools/testing/selftests/arm64/mte/.gitignore
+++ b/tools/testing/selftests/arm64/mte/.gitignore
@@ -3,3 +3,4 @@ check_tags_inclusion
 check_child_memory
 check_mmap_options
 check_ksm_options
+check_user_mem
diff --git a/tools/testing/selftests/arm64/mte/check_user_mem.c b/tools/testing/selftests/arm64/mte/check_user_mem.c
new file mode 100644
index 000000000000..9df0681af5bd
--- /dev/null
+++ b/tools/testing/selftests/arm64/mte/check_user_mem.c
@@ -0,0 +1,118 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2020 ARM Limited
+
+#define _GNU_SOURCE
+
+#include <errno.h>
+#include <fcntl.h>
+#include <signal.h>
+#include <stdlib.h>
+#include <stdio.h>
+#include <string.h>
+#include <ucontext.h>
+#include <unistd.h>
+#include <sys/mman.h>
+
+#include "kselftest.h"
+#include "mte_common_util.h"
+#include "mte_def.h"
+
+static size_t page_sz;
+
+static int check_usermem_access_fault(int mem_type, int mode, int mapping)
+{
+	int fd, ret, i, err;
+	char val = 'A';
+	size_t len, read_len;
+	void *ptr, *ptr_next;
+	bool fault;
+
+	len = 2 * page_sz;
+	err = KSFT_FAIL;
+	/*
+	 * Accessing user memory in kernel with invalid tag should fault in sync
+	 * mode but may not fault in async mode as per the implemented MTE
+	 * support in Arm64 kernel.
+	 */
+	if (mode == MTE_ASYNC_ERR)
+		fault = false;
+	else
+		fault = true;
+	mte_switch_mode(mode, MTE_ALLOW_NON_ZERO_TAG);
+	fd = create_temp_file();
+	if (fd == -1)
+		return KSFT_FAIL;
+	for (i = 0; i < len; i++)
+		write(fd, &val, sizeof(val));
+	lseek(fd, 0, 0);
+	ptr = mte_allocate_memory(len, mem_type, mapping, true);
+	if (check_allocated_memory(ptr, len, mem_type, true) != KSFT_PASS) {
+		close(fd);
+		return KSFT_FAIL;
+	}
+	mte_initialize_current_context(mode, (uintptr_t)ptr, len);
+	/* Copy from file into buffer with valid tag */
+	read_len = read(fd, ptr, len);
+	ret = errno;
+	mte_wait_after_trig();
+	if ((cur_mte_cxt.fault_valid == true) || ret == EFAULT || read_len < len)
+		goto usermem_acc_err;
+	/* Verify same pattern is read */
+	for (i = 0; i < len; i++)
+		if (*(char *)(ptr + i) != val)
+			break;
+	if (i < len)
+		goto usermem_acc_err;
+
+	/* Tag the next half of memory with different value */
+	ptr_next = (void *)((unsigned long)ptr + page_sz);
+	ptr_next = mte_insert_tags(ptr_next, page_sz);
+	if (!ptr_next)
+		goto usermem_acc_err;
+	lseek(fd, 0, 0);
+	/* Copy from file into buffer with invalid tag */
+	read_len = read(fd, ptr, len);
+	ret = errno;
+	mte_wait_after_trig();
+	if ((fault == true) &&
+	    (cur_mte_cxt.fault_valid == true || ret == EFAULT || read_len < len)) {
+		err = KSFT_PASS;
+	} else if ((fault == false) &&
+		   (cur_mte_cxt.fault_valid == false && read_len == len)) {
+		err = KSFT_PASS;
+	}
+usermem_acc_err:
+	mte_free_memory((void *)ptr, len, mem_type, true);
+	close(fd);
+	return err;
+}
+
+int main(int argc, char *argv[])
+{
+	int err;
+
+	page_sz = getpagesize();
+	if (!page_sz) {
+		ksft_print_msg("ERR: Unable to get page size\n");
+		return KSFT_FAIL;
+	}
+	err = mte_default_setup();
+	if (err)
+		return err;
+	/* Register signal handlers */
+	mte_register_signal(SIGSEGV, mte_default_handler);
+
+	evaluate_test(check_usermem_access_fault(USE_MMAP, MTE_SYNC_ERR, MAP_PRIVATE),
+		"Check memory access from kernel in sync mode, private mapping and mmap memory\n");
+	evaluate_test(check_usermem_access_fault(USE_MMAP, MTE_SYNC_ERR, MAP_SHARED),
+		"Check memory access from kernel in sync mode, shared mapping and mmap memory\n");
+
+	evaluate_test(check_usermem_access_fault(USE_MMAP, MTE_ASYNC_ERR, MAP_PRIVATE),
+		"Check memory access from kernel in async mode, private mapping and mmap memory\n");
+	evaluate_test(check_usermem_access_fault(USE_MMAP, MTE_ASYNC_ERR, MAP_SHARED),
+		"Check memory access from kernel in async mode, shared mapping and mmap memory\n");
+
+	mte_restore_setup();
+	ksft_print_cnts();
+	return ksft_get_fail_cnt() == 0 ? KSFT_PASS : KSFT_FAIL;
+}
-- 
2.17.1

