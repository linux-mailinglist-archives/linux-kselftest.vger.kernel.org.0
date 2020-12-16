Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 927282DC5A6
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Dec 2020 18:48:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727985AbgLPRrT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 16 Dec 2020 12:47:19 -0500
Received: from mga11.intel.com ([192.55.52.93]:21271 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727982AbgLPRrT (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 16 Dec 2020 12:47:19 -0500
IronPort-SDR: RHp2/9W3L3m3RkY0saUzRG1yqdiSth/igyabycXvhClOiGR0yPYCF08WNQQvOHIL6v3D7vW4Cq
 bQVnIUHrBfTw==
X-IronPort-AV: E=McAfee;i="6000,8403,9837"; a="171593438"
X-IronPort-AV: E=Sophos;i="5.78,424,1599548400"; 
   d="scan'208";a="171593438"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2020 09:46:13 -0800
IronPort-SDR: 6s/7eqTL8aFJezfJCuYyl1RK/0Mx09HmkBbcdt/0qcc2GpHptnoGcx4pLV5q8Bz/2LvrqtJ6r0
 gE2r3ziEcnXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,424,1599548400"; 
   d="scan'208";a="391854221"
Received: from chang-linux-3.sc.intel.com ([172.25.66.175])
  by FMSMGA003.fm.intel.com with ESMTP; 16 Dec 2020 09:46:13 -0800
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     tglx@linutronix.de, mingo@kernel.org, bp@suse.de, luto@kernel.org,
        x86@kernel.org, herbert@gondor.apana.org.au
Cc:     dan.j.williams@intel.com, dave.hansen@intel.com,
        ravi.v.shankar@intel.com, ning.sun@intel.com,
        kumar.n.dwarakanath@intel.com, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, chang.seok.bae@intel.com,
        linux-kselftest@vger.kernel.org
Subject: [RFC PATCH 6/8] selftests/x86: Test Key Locker internal key maintenance
Date:   Wed, 16 Dec 2020 09:41:44 -0800
Message-Id: <20201216174146.10446-7-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201216174146.10446-1-chang.seok.bae@intel.com>
References: <20201216174146.10446-1-chang.seok.bae@intel.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The test validates the internal key to be the same in all CPUs.

It performs the validation again with the Suspend-To-RAM (ACPI S3) state.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Cc: linux-kernel@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org
---
 tools/testing/selftests/x86/Makefile    |   2 +-
 tools/testing/selftests/x86/keylocker.c | 177 ++++++++++++++++++++++++
 2 files changed, 178 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/x86/keylocker.c

diff --git a/tools/testing/selftests/x86/Makefile b/tools/testing/selftests/x86/Makefile
index 6703c7906b71..c53e496d77b2 100644
--- a/tools/testing/selftests/x86/Makefile
+++ b/tools/testing/selftests/x86/Makefile
@@ -13,7 +13,7 @@ CAN_BUILD_WITH_NOPIE := $(shell ./check_cc.sh $(CC) trivial_program.c -no-pie)
 TARGETS_C_BOTHBITS := single_step_syscall sysret_ss_attrs syscall_nt test_mremap_vdso \
 			check_initial_reg_state sigreturn iopl ioperm \
 			test_vdso test_vsyscall mov_ss_trap \
-			syscall_arg_fault fsgsbase_restore
+			syscall_arg_fault fsgsbase_restore keylocker
 TARGETS_C_32BIT_ONLY := entry_from_vm86 test_syscall_vdso unwind_vdso \
 			test_FCMOV test_FCOMI test_FISTTP \
 			vdso_restorer
diff --git a/tools/testing/selftests/x86/keylocker.c b/tools/testing/selftests/x86/keylocker.c
new file mode 100644
index 000000000000..3d69c1615bca
--- /dev/null
+++ b/tools/testing/selftests/x86/keylocker.c
@@ -0,0 +1,177 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * keylocker.c, validating the internal key management
+ */
+#undef _GNU_SOURCE
+#define _GNU_SOURCE 1
+
+#include <stdio.h>
+#include <stdbool.h>
+#include <string.h>
+#include <fcntl.h>
+#include <err.h>
+#include <sched.h>
+#include <setjmp.h>
+#include <signal.h>
+#include <unistd.h>
+
+#define HANDLE_SIZE	48
+
+static bool keylocker_disabled;
+
+/* Encode a 128-bit key to a 384-bit handle */
+static inline void __encode_key(char *handle)
+{
+	static const unsigned char aeskey[] = { 0x31, 0x32, 0x33, 0x34, 0x35, 0x36, 0x37, 0x38,
+						0x71, 0x77, 0x74, 0x69, 0x6f, 0x6b, 0x6c, 0x78 };
+
+	asm volatile ("movdqu %0, %%xmm0" : : "m" (*aeskey) :);
+
+	/* Set no restriction to the handle */
+	asm volatile ("mov $0, %%eax" :);
+
+	/* ENCODEKEY128 %EAX */
+	asm volatile (".byte 0xf3, 0xf, 0x38, 0xfa, 0xc0");
+
+	asm volatile ("movdqu %%xmm0, %0; movdqu %%xmm1, %1; movdqu %%xmm2, %2;"
+		      : "=m" (handle[0]), "=m" (handle[0x10]), "=m" (handle[0x20]));
+}
+
+static jmp_buf jmpbuf;
+
+static void handle_sigill(int sig, siginfo_t *si, void *ctx_void)
+{
+	keylocker_disabled = true;
+	siglongjmp(jmpbuf, 1);
+}
+
+static bool encode_key(char *handle)
+{
+	bool success = true;
+	struct sigaction sa;
+	int ret;
+
+	memset(&sa, 0, sizeof(sa));
+
+	/* Set signal handler */
+	sa.sa_flags = SA_SIGINFO;
+	sa.sa_sigaction = handle_sigill;
+	sigemptyset(&sa.sa_mask);
+	ret = sigaction(SIGILL, &sa, 0);
+	if (ret)
+		err(1, "sigaction");
+
+	if (sigsetjmp(jmpbuf, 1))
+		success = false;
+	else
+		__encode_key(handle);
+
+	/* Clear signal handler */
+	sa.sa_flags = 0;
+	sa.sa_sigaction = NULL;
+	sa.sa_handler = SIG_DFL;
+	sigemptyset(&sa.sa_mask);
+	ret = sigaction(SIGILL, &sa, 0);
+	if (ret)
+		err(1, "sigaction");
+
+	return success;
+}
+
+/*
+ * Test if the internal key is the same in all the CPUs:
+ *
+ * Since the value is not readable, compare the encoded output of a AES key
+ * between CPUs.
+ */
+
+static int nerrs;
+
+static unsigned char cpu0_handle[HANDLE_SIZE] = { 0 };
+
+static void test_internal_key(bool slept, long cpus)
+{
+	int cpu, errs;
+
+	printf("Test the internal key consistency between CPUs\n");
+
+	for (cpu = 0, errs = 0; cpu < cpus; cpu++) {
+		char handle[HANDLE_SIZE] = { 0 };
+		cpu_set_t mask;
+		bool success;
+
+		CPU_ZERO(&mask);
+		CPU_SET(cpu, &mask);
+		sched_setaffinity(0, sizeof(cpu_set_t), &mask);
+
+		success = encode_key(handle);
+		if (!success) {
+			/* The encode should success after the S3 sleep */
+			if (slept)
+				errs++;
+			printf("[%s]\tKey Locker disabled at CPU%d\n",
+			       slept ? "FAIL" : "NOTE", cpu);
+			continue;
+		}
+
+		if (cpu == 0 && !slept) {
+			/* Record the first handle value as reference */
+			memcpy(cpu0_handle, handle, HANDLE_SIZE);
+		} else if (memcmp(cpu0_handle, handle, HANDLE_SIZE)) {
+			printf("[FAIL]\tMismatched internal key at CPU%d\n",
+			       cpu);
+			errs++;
+		}
+	}
+
+	if (errs == 0 && !keylocker_disabled)
+		printf("[OK]\tAll the internal keys are the same\n");
+	else
+		nerrs += errs;
+}
+
+static void switch_to_sleep(bool *slept)
+{
+	ssize_t bytes;
+	int fd;
+
+	printf("Transition to Suspend-To-RAM state\n");
+
+	fd = open("/sys/power/mem_sleep", O_RDWR);
+	if (fd < 0)
+		err(1, "Open /sys/power/mem_sleep");
+
+	bytes = write(fd, "deep", strlen("deep"));
+	if (bytes != strlen("deep"))
+		err(1, "Write /sys/power/mem_sleep");
+	close(fd);
+
+	fd = open("/sys/power/state", O_RDWR);
+	if (fd < 0)
+		err(1, "Open /sys/power/state");
+
+	bytes = write(fd, "mem", strlen("mem"));
+	if (bytes != strlen("mem"))
+		err(1, "Write /sys/power/state");
+	close(fd);
+
+	printf("Wake up from Suspend-To-RAM state\n");
+	*slept = true;
+}
+
+int main(void)
+{
+	bool slept = false;
+	long cpus;
+
+	cpus = sysconf(_SC_NPROCESSORS_ONLN);
+	printf("%ld CPUs in the system\n", cpus);
+
+	test_internal_key(slept, cpus);
+	if (keylocker_disabled)
+		return nerrs ? 1 : 0;
+
+	switch_to_sleep(&slept);
+	test_internal_key(slept, cpus);
+	return nerrs ? 1 : 0;
+}
-- 
2.17.1

