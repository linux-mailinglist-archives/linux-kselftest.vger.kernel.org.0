Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06DF12811D5
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Oct 2020 13:57:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387966AbgJBL5F (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 2 Oct 2020 07:57:05 -0400
Received: from foss.arm.com ([217.140.110.172]:33786 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387813AbgJBL5C (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 2 Oct 2020 07:57:02 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ACC9F1396;
        Fri,  2 Oct 2020 04:57:01 -0700 (PDT)
Received: from a077416.blr.arm.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A99EE3F70D;
        Fri,  2 Oct 2020 04:56:58 -0700 (PDT)
From:   Amit Daniel Kachhap <amit.kachhap@arm.com>
To:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Vincenzo Frascino <Vincenzo.Frascino@arm.com>,
        Gabor Kertesz <gabor.kertesz@arm.com>,
        Amit Daniel Kachhap <amit.kachhap@arm.com>
Subject: [PATCH v2 5/6] kselftest/arm64: Verify KSM page merge for MTE pages
Date:   Fri,  2 Oct 2020 17:26:29 +0530
Message-Id: <20201002115630.24683-6-amit.kachhap@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201002115630.24683-1-amit.kachhap@arm.com>
References: <20201002115630.24683-1-amit.kachhap@arm.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add a testcase to check that KSM should not merge pages containing
same data with same/different MTE tag values.

This testcase has one positive tests and passes if page merging
happens according to the above rule. It also saves and restores
any modified ksm sysfs entries.

Cc: Shuah Khan <shuah@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Signed-off-by: Amit Daniel Kachhap <amit.kachhap@arm.com>
---
Changes in v2:
* Moved read/write sysfs functions from global to local functions.

 tools/testing/selftests/arm64/mte/.gitignore  |   1 +
 .../selftests/arm64/mte/check_ksm_options.c   | 159 ++++++++++++++++++
 2 files changed, 160 insertions(+)
 create mode 100644 tools/testing/selftests/arm64/mte/check_ksm_options.c

diff --git a/tools/testing/selftests/arm64/mte/.gitignore b/tools/testing/selftests/arm64/mte/.gitignore
index 79a215d3bbd0..44e9bfdaeca6 100644
--- a/tools/testing/selftests/arm64/mte/.gitignore
+++ b/tools/testing/selftests/arm64/mte/.gitignore
@@ -2,3 +2,4 @@ check_buffer_fill
 check_tags_inclusion
 check_child_memory
 check_mmap_options
+check_ksm_options
diff --git a/tools/testing/selftests/arm64/mte/check_ksm_options.c b/tools/testing/selftests/arm64/mte/check_ksm_options.c
new file mode 100644
index 000000000000..bc41ae630c86
--- /dev/null
+++ b/tools/testing/selftests/arm64/mte/check_ksm_options.c
@@ -0,0 +1,159 @@
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
+
+#include "kselftest.h"
+#include "mte_common_util.h"
+#include "mte_def.h"
+
+#define TEST_UNIT	10
+#define PATH_KSM	"/sys/kernel/mm/ksm/"
+#define MAX_LOOP	4
+
+static size_t page_sz;
+static unsigned long ksm_sysfs[5];
+
+static unsigned long read_sysfs(char *str)
+{
+	FILE *f;
+	unsigned long val = 0;
+
+	f = fopen(str, "r");
+	if (!f) {
+		ksft_print_msg("ERR: missing %s\n", str);
+		return 0;
+	}
+	fscanf(f, "%lu", &val);
+	fclose(f);
+	return val;
+}
+
+static void write_sysfs(char *str, unsigned long val)
+{
+	FILE *f;
+
+	f = fopen(str, "w");
+	if (!f) {
+		ksft_print_msg("ERR: missing %s\n", str);
+		return;
+	}
+	fprintf(f, "%lu", val);
+	fclose(f);
+}
+
+static void mte_ksm_setup(void)
+{
+	ksm_sysfs[0] = read_sysfs(PATH_KSM "merge_across_nodes");
+	write_sysfs(PATH_KSM "merge_across_nodes", 1);
+	ksm_sysfs[1] = read_sysfs(PATH_KSM "sleep_millisecs");
+	write_sysfs(PATH_KSM "sleep_millisecs", 0);
+	ksm_sysfs[2] = read_sysfs(PATH_KSM "run");
+	write_sysfs(PATH_KSM "run", 1);
+	ksm_sysfs[3] = read_sysfs(PATH_KSM "max_page_sharing");
+	write_sysfs(PATH_KSM "max_page_sharing", ksm_sysfs[3] + TEST_UNIT);
+	ksm_sysfs[4] = read_sysfs(PATH_KSM "pages_to_scan");
+	write_sysfs(PATH_KSM "pages_to_scan", ksm_sysfs[4] + TEST_UNIT);
+}
+
+static void mte_ksm_restore(void)
+{
+	write_sysfs(PATH_KSM "merge_across_nodes", ksm_sysfs[0]);
+	write_sysfs(PATH_KSM "sleep_millisecs", ksm_sysfs[1]);
+	write_sysfs(PATH_KSM "run", ksm_sysfs[2]);
+	write_sysfs(PATH_KSM "max_page_sharing", ksm_sysfs[3]);
+	write_sysfs(PATH_KSM "pages_to_scan", ksm_sysfs[4]);
+}
+
+static void mte_ksm_scan(void)
+{
+	int cur_count = read_sysfs(PATH_KSM "full_scans");
+	int scan_count = cur_count + 1;
+	int max_loop_count = MAX_LOOP;
+
+	while ((cur_count < scan_count) && max_loop_count) {
+		sleep(1);
+		cur_count = read_sysfs(PATH_KSM "full_scans");
+		max_loop_count--;
+	}
+#ifdef DEBUG
+	ksft_print_msg("INFO: pages_shared=%lu pages_sharing=%lu\n",
+			read_sysfs(PATH_KSM "pages_shared"),
+			read_sysfs(PATH_KSM "pages_sharing"));
+#endif
+}
+
+static int check_madvise_options(int mem_type, int mode, int mapping)
+{
+	char *ptr;
+	int err, ret;
+
+	err = KSFT_FAIL;
+	if (access(PATH_KSM, F_OK) == -1) {
+		ksft_print_msg("ERR: Kernel KSM config not enabled\n");
+		return err;
+	}
+
+	mte_switch_mode(mode, MTE_ALLOW_NON_ZERO_TAG);
+	ptr = mte_allocate_memory(TEST_UNIT * page_sz, mem_type, mapping, true);
+	if (check_allocated_memory(ptr, TEST_UNIT * page_sz, mem_type, false) != KSFT_PASS)
+		return KSFT_FAIL;
+
+	/* Insert same data in all the pages */
+	memset(ptr, 'A', TEST_UNIT * page_sz);
+	ret = madvise(ptr, TEST_UNIT * page_sz, MADV_MERGEABLE);
+	if (ret) {
+		ksft_print_msg("ERR: madvise failed to set MADV_UNMERGEABLE\n");
+		goto madvise_err;
+	}
+	mte_ksm_scan();
+	/* Tagged pages should not merge */
+	if ((read_sysfs(PATH_KSM "pages_shared") < 1) ||
+	    (read_sysfs(PATH_KSM "pages_sharing") < (TEST_UNIT - 1)))
+		err = KSFT_PASS;
+madvise_err:
+	mte_free_memory(ptr, TEST_UNIT * page_sz, mem_type, true);
+	return err;
+}
+
+int main(int argc, char *argv[])
+{
+	int err;
+
+	err = mte_default_setup();
+	if (err)
+		return err;
+	page_sz = getpagesize();
+	if (!page_sz) {
+		ksft_print_msg("ERR: Unable to get page size\n");
+		return KSFT_FAIL;
+	}
+	/* Register signal handlers */
+	mte_register_signal(SIGBUS, mte_default_handler);
+	mte_register_signal(SIGSEGV, mte_default_handler);
+	/* Enable KSM */
+	mte_ksm_setup();
+
+	evaluate_test(check_madvise_options(USE_MMAP, MTE_SYNC_ERR, MAP_PRIVATE),
+		"Check KSM mte page merge for private mapping, sync mode and mmap memory\n");
+	evaluate_test(check_madvise_options(USE_MMAP, MTE_ASYNC_ERR, MAP_PRIVATE),
+		"Check KSM mte page merge for private mapping, async mode and mmap memory\n");
+	evaluate_test(check_madvise_options(USE_MMAP, MTE_SYNC_ERR, MAP_SHARED),
+		"Check KSM mte page merge for shared mapping, sync mode and mmap memory\n");
+	evaluate_test(check_madvise_options(USE_MMAP, MTE_ASYNC_ERR, MAP_SHARED),
+		"Check KSM mte page merge for shared mapping, async mode and mmap memory\n");
+
+	mte_ksm_restore();
+	mte_restore_setup();
+	ksft_print_cnts();
+	return ksft_get_fail_cnt() == 0 ? KSFT_PASS : KSFT_FAIL;
+}
-- 
2.17.1

