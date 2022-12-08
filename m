Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EF98647A40
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Dec 2022 00:42:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229781AbiLHXm5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 8 Dec 2022 18:42:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231182AbiLHXmV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 8 Dec 2022 18:42:21 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67EC640454;
        Thu,  8 Dec 2022 15:41:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670542885; x=1702078885;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Hu1HTZTafXcdvrkhbeBjON7D3PRjnUtIiEYUaFBoYlg=;
  b=k4A1dhQq5t8/evUA+QAsITLktGRrkYhmLCZz6V8UqrqEB1TSAkkip/9n
   3VBF0CcJaBvSs8gFm3RzzMkPS5uHUcxPSg8x14oziZdgEyJdCOJuWh5MG
   pvrwMUrCbu/xxnxEGwSuJmxkd+2RBlA30iLKNkcHOpRTEg5z2bSa9hO3m
   xP6xiAqpZujge2I7iHp1mX1KJ/8YX/uPQLn0qglypIr9KuvbOpZ2TX1Hh
   VefxVJ8DoZ1i7BADPoR/HeQBSiT4W42qc9X9e6k6gehT1WBJKAIQQTKMY
   H8+661HxsUh2zh3WXTNhF96rOKrK/V6n4q7IauVsYnm2k+qbFlt9TdsTA
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10555"; a="300754205"
X-IronPort-AV: E=Sophos;i="5.96,228,1665471600"; 
   d="scan'208";a="300754205"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2022 15:41:24 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10555"; a="710685564"
X-IronPort-AV: E=Sophos;i="5.96,228,1665471600"; 
   d="scan'208";a="710685564"
Received: from bbaylav-mobl1.amr.corp.intel.com (HELO guptapa-desk.lan) ([10.212.230.254])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2022 15:41:23 -0800
From:   Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To:     Shuah Khan <shuah@kernel.org>,
        Guillaume Tucker <guillaume.tucker@collabora.com>,
        Guenter Roeck <groeck@google.com>,
        Geliang Tang <geliang.tang@suse.com>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        dave.hansen@linux.intel.com, daniel.sneddon@linux.intel.com,
        antonio.gomez.iglesias@linux.intel.com, bp@alien8.de
Subject: [PATCH] selftests/x86/msr: Add MSR restore test for suspend cycle
Date:   Thu,  8 Dec 2022 15:40:51 -0800
Message-Id: <b3a9cf7ede696df823c7ea016974c5c1078a1667.1670542734.git.pawan.kumar.gupta@linux.intel.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.0 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

There are certain security related MSRs that must be restored after a
suspend cycle. There have been quite a few fixes done to restore these
MSRs:

commit e2a1256b17b1 ("x86/speculation: Restore speculation related MSRs during S3 resume")
commit 50bcceb7724e ("x86/pm: Add enumeration check before spec MSRs save/restore setup")
commit 66065157420c ("x86/bugs: Make sure MSR_SPEC_CTRL is updated properly upon resume from S3")
commit 2632daebafd0 ("x86/cpu: Restore AMD's DE_CFG MSR after resume")
commit 73924ec4d560 ("x86/pm: Save the MSR validity status at context setup")
commit f9e14dbbd454 ("x86/cpu: Load microcode during restore_processor_state()")

In order to catch regressions early add a selftest that keeps a copy of
below MSRs for all CPUs:

  MSR_IA32_SPEC_CTRL
  MSR_IA32_TSX_CTRL
  MSR_TSX_FORCE_ABORT
  MSR_IA32_MCU_OPT_CTRL
  MSR_AMD64_LS_CFG
  MSR_AMD64_DE_CFG

The test does a suspend/resume and reports failure if the MSRs are not
restored to the value before suspend.

Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
---
 tools/testing/selftests/x86/Makefile          |   2 +-
 .../selftests/x86/suspend_msr_restore.c       | 193 ++++++++++++++++++
 2 files changed, 194 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/x86/suspend_msr_restore.c

diff --git a/tools/testing/selftests/x86/Makefile b/tools/testing/selftests/x86/Makefile
index 0388c4d60af0..ef8c6cf7d72e 100644
--- a/tools/testing/selftests/x86/Makefile
+++ b/tools/testing/selftests/x86/Makefile
@@ -13,7 +13,7 @@ CAN_BUILD_WITH_NOPIE := $(shell ./check_cc.sh "$(CC)" trivial_program.c -no-pie)
 TARGETS_C_BOTHBITS := single_step_syscall sysret_ss_attrs syscall_nt test_mremap_vdso \
 			check_initial_reg_state sigreturn iopl ioperm \
 			test_vsyscall mov_ss_trap \
-			syscall_arg_fault fsgsbase_restore sigaltstack
+			syscall_arg_fault fsgsbase_restore sigaltstack suspend_msr_restore
 TARGETS_C_32BIT_ONLY := entry_from_vm86 test_syscall_vdso unwind_vdso \
 			test_FCMOV test_FCOMI test_FISTTP \
 			vdso_restorer
diff --git a/tools/testing/selftests/x86/suspend_msr_restore.c b/tools/testing/selftests/x86/suspend_msr_restore.c
new file mode 100644
index 000000000000..30285c565597
--- /dev/null
+++ b/tools/testing/selftests/x86/suspend_msr_restore.c
@@ -0,0 +1,193 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2022 Intel Corporation
+ *
+ * This test caches some chosen MSRs, does a suspend cycle and reports failure
+ * if the MSRs are not restored to the values before suspend.
+ */
+
+#define _GNU_SOURCE
+
+#include <fcntl.h>
+#include <sched.h>
+#include <stdbool.h>
+#include <stdint.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include <errno.h>
+#include <sys/stat.h>
+#include <sys/timerfd.h>
+#include <sys/sysinfo.h>
+
+#include "../kselftest.h"
+
+#define MSR_IA32_SPEC_CTRL		0x00000048
+#define MSR_IA32_TSX_CTRL		0x00000122
+#define MSR_TSX_FORCE_ABORT		0x0000010F
+#define MSR_IA32_MCU_OPT_CTRL		0x00000123
+#define MSR_AMD64_LS_CFG		0xc0011020
+#define MSR_AMD64_DE_CFG		0xc0011029
+
+struct msr_cache {
+	unsigned int msr_id;
+	unsigned long long msr_val;
+	bool valid;
+};
+
+int suspend(void)
+{
+	struct itimerspec spec = {};
+	int power_state_fd;
+	int timerfd;
+	int ret = -1;
+
+	power_state_fd = open("/sys/power/state", O_RDWR);
+	if (power_state_fd < 0) {
+		ksft_test_result_error("open(\"/sys/power/state\") failed %s)\n", strerror(errno));
+		goto exit;
+	}
+
+	timerfd = timerfd_create(CLOCK_BOOTTIME_ALARM, 0);
+	if (timerfd < 0) {
+		ksft_test_result_error("timerfd_create() failed\n");
+		goto cleanup_power_state;
+	}
+
+	spec.it_value.tv_sec = 15;
+	ret = timerfd_settime(timerfd, 0, &spec, NULL);
+	if (ret < 0) {
+		ksft_test_result_error("timerfd_settime() failed\n");
+		goto cleanup_timer;
+	}
+
+	if (write(power_state_fd, "mem", strlen("mem")) != strlen("mem")) {
+		ksft_test_result_error("Failed to enter Suspend state\n");
+		ret = -1;
+		goto cleanup_timer;
+	}
+
+	ret = 0;
+
+cleanup_timer:
+	close(timerfd);
+cleanup_power_state:
+	close(power_state_fd);
+exit:
+	return ret;
+}
+
+int msr_read(int cpu, unsigned int msr_id, unsigned long long *msr_val)
+{
+	char msr_file_name[32];
+	int fd, ret;
+
+	snprintf(msr_file_name, 32, "/dev/cpu/%d/msr", cpu);
+	fd = open(msr_file_name, O_RDONLY);
+
+	if (fd == -1) {
+		perror("Failed to open");
+		return -ENODEV;
+	}
+
+	ret = pread(fd, msr_val, sizeof(long long), msr_id);
+	close(fd);
+
+	return ret != sizeof(long long);
+}
+
+int main(void)
+{
+	/* List of MSRs to tests */
+	unsigned int msr_id[] = {
+		MSR_IA32_SPEC_CTRL,
+		MSR_IA32_TSX_CTRL,
+		MSR_TSX_FORCE_ABORT,
+		MSR_IA32_MCU_OPT_CTRL,
+		MSR_AMD64_LS_CFG,
+		MSR_AMD64_DE_CFG,
+	};
+	int i, cpu, err, max_cpus, msr_idx, total_tests = 0;
+	int num_msrs = ARRAY_SIZE(msr_id);
+	unsigned long long msr_val;
+	cpu_set_t available_cpus;
+	struct msr_cache *msrs;
+	bool succeeded = true;
+
+	if (getuid() != 0)
+		ksft_exit_skip("Please re-run the test as root\n");
+
+	if (access("/dev/cpu/0/msr", R_OK))
+		ksft_exit_skip("Can't read MSRs\n");
+
+	if (access("/sys/power/state", W_OK))
+		ksft_exit_skip("/sys/power/state not writable\n");
+
+	ksft_print_header();
+
+	err = sched_getaffinity(0, sizeof(available_cpus), &available_cpus);
+	if (err < 0)
+		ksft_exit_fail_msg("sched_getaffinity() failed\n");
+
+	max_cpus = get_nprocs_conf();
+
+	msrs = calloc(sizeof(struct msr_cache), max_cpus * num_msrs);
+	if (!msrs)
+		ksft_exit_fail_msg("Memory allocation failed\n");
+
+	for (cpu = 0; cpu < max_cpus; cpu++) {
+		if (!CPU_ISSET(cpu, &available_cpus))
+			continue;
+		msr_idx = cpu * num_msrs;
+		for (i = 0; i < num_msrs; i++, msr_idx++) {
+			if (!msr_read(cpu, msr_id[i], &msr_val)) {
+				msrs[msr_idx].valid = true;
+				msrs[msr_idx].msr_id = msr_id[i];
+				msrs[msr_idx].msr_val = msr_val;
+				total_tests++;
+			}
+		}
+	}
+
+	ksft_set_plan(total_tests);
+
+	if (suspend()) {
+		succeeded = false;
+		goto cleanup;
+	}
+
+	for (cpu = 0; cpu < max_cpus; cpu++) {
+		if (!CPU_ISSET(cpu, &available_cpus))
+			continue;
+
+		msr_idx = cpu * num_msrs;
+		for (i = 0; i < num_msrs; i++, msr_idx++) {
+			if (!msrs[msr_idx].valid)
+				continue;
+			if (msr_read(cpu, msr_id[i], &msr_val)) {
+				ksft_test_result_fail("Not able to read msr=0x%x on CPU=%d\n",
+						      msr_id[i], cpu);
+				succeeded = false;
+				continue;
+			}
+			if (msrs[msr_idx].msr_val != msr_val) {
+				ksft_test_result_fail("CPU%d: msr=0x%x value after resume=[0x%llx] != suspend=[0x%llx]\n",
+						      cpu, msr_id[i], msr_val, msrs[msr_idx].msr_val);
+				succeeded = false;
+				continue;
+			}
+
+			ksft_test_result_pass("CPU%d: MSR[0x%x] restored to 0x%llx\n",
+					      cpu, msr_id[i], msr_val);
+		}
+	}
+
+cleanup:
+	free(msrs);
+
+	if (succeeded)
+		ksft_exit_pass();
+	else
+		ksft_exit_fail();
+}
-- 
2.37.3

