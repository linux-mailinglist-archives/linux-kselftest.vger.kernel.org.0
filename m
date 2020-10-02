Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF3622811D7
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Oct 2020 13:57:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387813AbgJBL5G (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 2 Oct 2020 07:57:06 -0400
Received: from foss.arm.com ([217.140.110.172]:33796 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387970AbgJBL5G (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 2 Oct 2020 07:57:06 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3EB161063;
        Fri,  2 Oct 2020 04:57:05 -0700 (PDT)
Received: from a077416.blr.arm.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 3C4203F70D;
        Fri,  2 Oct 2020 04:57:01 -0700 (PDT)
From:   Amit Daniel Kachhap <amit.kachhap@arm.com>
To:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Vincenzo Frascino <Vincenzo.Frascino@arm.com>,
        Gabor Kertesz <gabor.kertesz@arm.com>,
        Amit Daniel Kachhap <amit.kachhap@arm.com>
Subject: [PATCH v2 6/6] kselftest/arm64: Check mte tagged user address in kernel
Date:   Fri,  2 Oct 2020 17:26:30 +0530
Message-Id: <20201002115630.24683-7-amit.kachhap@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201002115630.24683-1-amit.kachhap@arm.com>
References: <20201002115630.24683-1-amit.kachhap@arm.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add a testcase to check that user address with valid/invalid
mte tag works in kernel mode. This test verifies that the kernel
API's __arch_copy_from_user/__arch_copy_to_user works by considering
if the user pointer has valid/invalid allocation tags.

In MTE sync mode, file memory read/write and other similar interfaces
fails if a user memory with invalid tag is accessed in kernel. In async
mode no such failure occurs.

Cc: Shuah Khan <shuah@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Signed-off-by: Amit Daniel Kachhap <amit.kachhap@arm.com>
---
Changes in v2:
* Updated the test to handle the error properly in case of failure
  in accessing memory with invalid tag in kernel. errno check is not
  done now and read length checks are sufficient.

 tools/testing/selftests/arm64/mte/.gitignore  |   1 +
 .../selftests/arm64/mte/check_user_mem.c      | 111 ++++++++++++++++++
 .../selftests/arm64/mte/mte_common_util.h     |   1 +
 .../testing/selftests/arm64/mte/mte_helper.S  |  14 +++
 4 files changed, 127 insertions(+)
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
index 000000000000..594e98e76880
--- /dev/null
+++ b/tools/testing/selftests/arm64/mte/check_user_mem.c
@@ -0,0 +1,111 @@
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
+	int fd, i, err;
+	char val = 'A';
+	size_t len, read_len;
+	void *ptr, *ptr_next;
+
+	err = KSFT_FAIL;
+	len = 2 * page_sz;
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
+	mte_wait_after_trig();
+	if (cur_mte_cxt.fault_valid || read_len < len)
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
+	ptr_next = mte_insert_new_tag(ptr_next);
+	mte_set_tag_address_range(ptr_next, page_sz);
+
+	lseek(fd, 0, 0);
+	/* Copy from file into buffer with invalid tag */
+	read_len = read(fd, ptr, len);
+	mte_wait_after_trig();
+	/*
+	 * Accessing user memory in kernel with invalid tag should fail in sync
+	 * mode without fault but may not fail in async mode as per the
+	 * implemented MTE userspace support in Arm64 kernel.
+	 */
+	if (mode == MTE_SYNC_ERR &&
+	    !cur_mte_cxt.fault_valid && read_len < len) {
+		err = KSFT_PASS;
+	} else if (mode == MTE_ASYNC_ERR &&
+		   !cur_mte_cxt.fault_valid && read_len == len) {
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
diff --git a/tools/testing/selftests/arm64/mte/mte_common_util.h b/tools/testing/selftests/arm64/mte/mte_common_util.h
index 45160e061a0e..195a7d1879e6 100644
--- a/tools/testing/selftests/arm64/mte/mte_common_util.h
+++ b/tools/testing/selftests/arm64/mte/mte_common_util.h
@@ -64,6 +64,7 @@ int create_temp_file(void);
 
 /* Assembly MTE utility functions */
 void *mte_insert_random_tag(void *ptr);
+void *mte_insert_new_tag(void *ptr);
 void *mte_get_tag_address(void *ptr);
 void mte_set_tag_address_range(void *ptr, int range);
 void mte_clear_tag_address_range(void *ptr, int range);
diff --git a/tools/testing/selftests/arm64/mte/mte_helper.S b/tools/testing/selftests/arm64/mte/mte_helper.S
index 48e049fbad9a..a02c04cd0aac 100644
--- a/tools/testing/selftests/arm64/mte/mte_helper.S
+++ b/tools/testing/selftests/arm64/mte/mte_helper.S
@@ -26,6 +26,20 @@ ENTRY(mte_insert_random_tag)
 	ret
 ENDPROC(mte_insert_random_tag)
 
+/*
+ * mte_insert_new_tag: Insert new tag and different from the source tag if
+ *		       source pointer has it.
+ * Input:
+ *		x0 - source pointer with a tag/no-tag
+ * Return:
+ *		x0 - pointer with random tag
+ */
+ENTRY(mte_insert_new_tag)
+	gmi	x1, x0, xzr
+	irg	x0, x0, x1
+	ret
+ENDPROC(mte_insert_new_tag)
+
 /*
  * mte_get_tag_address: Get the tag from given address.
  * Input:
-- 
2.17.1

