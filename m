Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46E5038DCA8
	for <lists+linux-kselftest@lfdr.de>; Sun, 23 May 2021 21:38:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231932AbhEWTkE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 23 May 2021 15:40:04 -0400
Received: from mga11.intel.com ([192.55.52.93]:31996 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232005AbhEWTj6 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 23 May 2021 15:39:58 -0400
IronPort-SDR: tH5vPAcwgCVKUXfYdg7Kv/0+CYfnvUURJ2rL/1VcFyccv2Gn8puPxe2AH/ba1Hu/awSEmOskTT
 Ncb0+3RZgItA==
X-IronPort-AV: E=McAfee;i="6200,9189,9993"; a="198740686"
X-IronPort-AV: E=Sophos;i="5.82,319,1613462400"; 
   d="scan'208";a="198740686"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2021 12:38:29 -0700
IronPort-SDR: IV22SNy5nbeo6vSD3tSlycYi/9ngTb2yIhx1CFoOih2oBGYFZKPTPgF4FU9Zix8Zp+8d8oV6An
 PFiDWcw0+mjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,319,1613462400"; 
   d="scan'208";a="407467134"
Received: from chang-linux-3.sc.intel.com ([172.25.66.175])
  by fmsmga007.fm.intel.com with ESMTP; 23 May 2021 12:38:29 -0700
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     bp@suse.de, luto@kernel.org, tglx@linutronix.de, mingo@kernel.org,
        x86@kernel.org
Cc:     len.brown@intel.com, dave.hansen@intel.com, jing2.liu@intel.com,
        ravi.v.shankar@intel.com, linux-kernel@vger.kernel.org,
        chang.seok.bae@intel.com, linux-kselftest@vger.kernel.org
Subject: [PATCH v5 23/28] selftest/x86/amx: Test cases for the AMX state management
Date:   Sun, 23 May 2021 12:32:54 -0700
Message-Id: <20210523193259.26200-24-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210523193259.26200-1-chang.seok.bae@intel.com>
References: <20210523193259.26200-1-chang.seok.bae@intel.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This selftest verifies that the xstate arch_prctl works for AMX state and
that a forked task has the AMX state in the INIT-state.

In addition, this test verifies that the kernel correctly context switches
unique AMX data, when multiple threads are using AMX.

Finally, the test verifies that ptrace() can insert data into existing
threads.

These test cases do not depend on AMX compiler support, as they employ
userspace-XSAVE directly to access AMX state.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Reviewed-by: Len Brown <len.brown@intel.com>
Cc: linux-kernel@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org
---
Changes from v4:
* Added test for arch_prctl.
* Excluded tile config details to focus on testing the kernel's ability to
  manage dynamic user state.
* Removed tile instructions.
* Simplified the fork() and ptrace() test routine.
* Massaged the changelog.

Changes from v2:
* Updated the test messages and the changelog as tile data is not inherited
  to a child anymore.
* Removed bytecode for the instructions already supported by binutils.
* Changed to check the XSAVE availability in a reliable way.

Changes from v1:
* Removed signal testing code
---
 tools/testing/selftests/x86/Makefile |   2 +-
 tools/testing/selftests/x86/amx.c    | 601 +++++++++++++++++++++++++++
 2 files changed, 602 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/x86/amx.c

diff --git a/tools/testing/selftests/x86/Makefile b/tools/testing/selftests/x86/Makefile
index 333980375bc7..2f7feb03867b 100644
--- a/tools/testing/selftests/x86/Makefile
+++ b/tools/testing/selftests/x86/Makefile
@@ -17,7 +17,7 @@ TARGETS_C_BOTHBITS := single_step_syscall sysret_ss_attrs syscall_nt test_mremap
 TARGETS_C_32BIT_ONLY := entry_from_vm86 test_syscall_vdso unwind_vdso \
 			test_FCMOV test_FCOMI test_FISTTP \
 			vdso_restorer
-TARGETS_C_64BIT_ONLY := fsgsbase sysret_rip syscall_numbering
+TARGETS_C_64BIT_ONLY := fsgsbase sysret_rip syscall_numbering amx
 # Some selftests require 32bit support enabled also on 64bit systems
 TARGETS_C_32BIT_NEEDED := ldt_gdt ptrace_syscall
 
diff --git a/tools/testing/selftests/x86/amx.c b/tools/testing/selftests/x86/amx.c
new file mode 100644
index 000000000000..7d177c03cdcf
--- /dev/null
+++ b/tools/testing/selftests/x86/amx.c
@@ -0,0 +1,601 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#define _GNU_SOURCE
+#include <err.h>
+#include <errno.h>
+#include <elf.h>
+#include <pthread.h>
+#include <setjmp.h>
+#include <stdio.h>
+#include <string.h>
+#include <stdbool.h>
+#include <unistd.h>
+#include <x86intrin.h>
+
+#include <linux/futex.h>
+
+#include <sys/ptrace.h>
+#include <sys/shm.h>
+#include <sys/syscall.h>
+#include <sys/wait.h>
+#include <sys/uio.h>
+
+#ifndef __x86_64__
+# error This test is 64-bit only
+#endif
+
+static inline uint64_t  __xgetbv(uint32_t index)
+{
+	uint32_t eax, edx;
+
+	asm volatile("xgetbv;"
+		     : "=a" (eax), "=d" (edx)
+		     : "c" (index));
+	return eax + ((uint64_t)edx << 32);
+}
+
+static inline void __cpuid(uint32_t *eax, uint32_t *ebx, uint32_t *ecx, uint32_t *edx)
+{
+	asm volatile("cpuid;"
+		     : "=a" (*eax), "=b" (*ebx), "=c" (*ecx), "=d" (*edx)
+		     : "0" (*eax), "2" (*ecx));
+}
+
+static inline void __xsave(void *buffer, uint32_t lo, uint32_t hi)
+{
+	asm volatile("xsave (%%rdi)"
+		     : : "D" (buffer), "a" (lo), "d" (hi)
+		     : "memory");
+}
+
+static inline void __xrstor(void *buffer, uint32_t lo, uint32_t hi)
+{
+	asm volatile("xrstor (%%rdi)"
+		     : : "D" (buffer), "a" (lo), "d" (hi));
+}
+
+static void sethandler(int sig, void (*handler)(int, siginfo_t *, void *),
+		       int flags)
+{
+	struct sigaction sa;
+
+	memset(&sa, 0, sizeof(sa));
+	sa.sa_sigaction = handler;
+	sa.sa_flags = SA_SIGINFO | flags;
+	sigemptyset(&sa.sa_mask);
+	if (sigaction(sig, &sa, 0))
+		err(1, "sigaction");
+}
+
+static void clearhandler(int sig)
+{
+	struct sigaction sa;
+
+	memset(&sa, 0, sizeof(sa));
+	sa.sa_handler = SIG_DFL;
+	sigemptyset(&sa.sa_mask);
+	if (sigaction(sig, &sa, 0))
+		err(1, "sigaction");
+}
+
+static jmp_buf jmpbuf;
+
+/* Hardware info check: */
+
+static bool xsave_disabled;
+
+static void handle_sigill(int sig, siginfo_t *si, void *ctx_void)
+{
+	xsave_disabled = true;
+	siglongjmp(jmpbuf, 1);
+}
+
+#define XFEATURE_XTILECFG	17
+#define XFEATURE_XTILEDATA	18
+#define XFEATURE_MASK_XTILECFG	(1 << XFEATURE_XTILECFG)
+#define XFEATURE_MASK_XTILEDATA	(1 << XFEATURE_XTILEDATA)
+#define XFEATURE_MASK_XTILE	(XFEATURE_MASK_XTILECFG | XFEATURE_MASK_XTILEDATA)
+
+static inline bool check_xsave_capability(void)
+{
+	sethandler(SIGILL, handle_sigill, 0);
+
+	if ((!sigsetjmp(jmpbuf, 1)) && (__xgetbv(0) & XFEATURE_MASK_XTILEDATA)) {
+		clearhandler(SIGILL);
+		return true;
+	}
+
+	clearhandler(SIGILL);
+	return false;
+}
+
+static uint32_t xsave_size;
+
+static uint32_t xsave_xtiledata_offset;
+static uint32_t xsave_xtiledata_size;
+
+static uint32_t xsave_xtilecfg_offset;
+static uint32_t xsave_xtilecfg_size;
+
+#define XSTATE_CPUID			0xd
+#define XSTATE_USER_STATE_SUBLEAVE	0x0
+
+static void check_cpuid(void)
+{
+	uint32_t eax, ebx, ecx, edx;
+
+	eax = XSTATE_CPUID;
+	ecx = XSTATE_USER_STATE_SUBLEAVE;
+
+	__cpuid(&eax, &ebx, &ecx, &edx);
+	if (!ebx)
+		err(1, "xstate cpuid: xsave size");
+
+	xsave_size = ebx;
+
+	eax = XSTATE_CPUID;
+	ecx = XFEATURE_XTILECFG;
+
+	__cpuid(&eax, &ebx, &ecx, &edx);
+	if (!eax || !ebx)
+		err(1, "xstate cpuid: tile config state");
+
+	xsave_xtilecfg_size = eax;
+	xsave_xtilecfg_offset = ebx;
+
+	eax = XSTATE_CPUID;
+	ecx = XFEATURE_XTILEDATA;
+
+	__cpuid(&eax, &ebx, &ecx, &edx);
+	if (!eax || !ebx)
+		err(1, "xstate cpuid: tile data state");
+
+	xsave_xtiledata_size = eax;
+	xsave_xtiledata_offset = ebx;
+}
+
+/* The helpers for managing XSAVE buffer and tile states: */
+
+#define XSAVE_HDR_OFFSET	512
+
+static inline uint64_t get_xstatebv(void *xsave)
+{
+	return *(uint64_t *)(xsave + XSAVE_HDR_OFFSET);
+}
+
+static inline void set_xstatebv(void *xsave, uint64_t bv)
+{
+	*(uint64_t *)(xsave + XSAVE_HDR_OFFSET) = bv;
+}
+
+static void set_tiledata(void *tiledata)
+{
+	int *ptr = tiledata;
+	int data = rand();
+	int i;
+
+	for (i = 0; i < xsave_xtiledata_size / sizeof(int); i++, ptr++)
+		*ptr  = data;
+}
+
+static void *xsave_buffer, *tiledata;
+static int nerrs, errs;
+
+static void handle_sigsegv(int sig, siginfo_t *si, void *ctx_void)
+{
+	siglongjmp(jmpbuf, 1);
+}
+
+static bool xrstor(void *buffer, uint32_t lo, uint32_t hi)
+{
+	if (!sigsetjmp(jmpbuf, 1)) {
+		__xrstor(buffer, lo, hi);
+		return true;
+	} else {
+		return false;
+	}
+}
+
+/* arch_prctl test */
+
+#define ARCH_GET_XSTATE		0x1021
+#define ARCH_PUT_XSTATE		0x1022
+
+#define ARCH_PRCTL_REPEAT	10
+
+static void test_arch_prctl(void)
+{
+	bool xfd_armed;
+	pid_t child;
+	int rc, i;
+
+	child = fork();
+	if (child < 0) {
+		err(1, "fork");
+	} else if (child > 0) {
+		int status;
+
+		wait(&status);
+		if (!WIFEXITED(status) || WEXITSTATUS(status))
+			err(1, "arch_prctl test child");
+		return;
+	}
+
+	set_xstatebv(xsave_buffer, XFEATURE_MASK_XTILE);
+	set_tiledata(xsave_buffer + xsave_xtiledata_offset);
+
+	printf("[RUN]\tCheck ARCH_GET_XSTATE/ARCH_SET_XSTATE.\n");
+
+	printf("\tLoad tile data without GET:\n");
+
+	if (!xrstor(xsave_buffer, -1, -1)) {
+		printf("[OK]\tBlocked.\n");
+	} else {
+		nerrs++;
+		printf("[FAIL]\tSucceeded.\n");
+	}
+
+	printf("\tGET with invalid arg:\n");
+
+	rc = syscall(SYS_arch_prctl, ARCH_GET_XSTATE, -1);
+	if (rc == -EPERM) {
+		printf("[OK]\tEPERM was returned.\n");
+	} else {
+		nerrs++;
+		printf("[FAIL]\tNo EPERM was returned.\n");
+	}
+
+	printf("\tGET with AMX state %d-times:\n", ARCH_PRCTL_REPEAT);
+
+	for (i = 0; i < ARCH_PRCTL_REPEAT; i++) {
+		rc = syscall(SYS_arch_prctl, ARCH_GET_XSTATE, XFEATURE_MASK_XTILE);
+		if (rc != 0)
+			break;
+
+		xfd_armed = !xrstor(xsave_buffer, -1, -1);
+		if (xfd_armed)
+			break;
+	}
+
+	if (i == ARCH_PRCTL_REPEAT) {
+		printf("[OK]\tNo error and correctly disarmed XFD.\n");
+	} else {
+		nerrs++;
+		i++;
+		if (rc)
+			printf("[FAIL]\t%d-th GET returned error (rc=%d).\n", i, rc);
+		else
+			printf("[FAIL]\t%d-th GET failed to disarm XFD.\n", i);
+	}
+
+	printf("\tPUT with AMX state %d-times:\n", ARCH_PRCTL_REPEAT);
+
+	for (i = 0; i < ARCH_PRCTL_REPEAT; i++) {
+		rc = syscall(SYS_arch_prctl, ARCH_PUT_XSTATE, XFEATURE_MASK_XTILE);
+		if (rc != 0)
+			break;
+
+		xfd_armed = !xrstor(xsave_buffer, -1, -1);
+		if (xfd_armed)
+			break;
+	}
+
+	if ((i == (ARCH_PRCTL_REPEAT - 1)) && xfd_armed) {
+		printf("[OK]\tNo error and re-armed XFD at the end.\n");
+	} else {
+		nerrs++;
+		i++;
+		if (rc)
+			printf("[FAIL]\t%d-th PUT returned error (rc=%d).\n", i, rc);
+		else if (i == ARCH_PRCTL_REPEAT)
+			printf("[FAIL]\tthe final PUT failed to arm XFD.\n");
+		else
+			printf("[FAIL]\t%d-th PUT disarm XFD.\n", i);
+	}
+
+	_exit(0);
+}
+
+/* Testing tile data inheritance */
+
+static void test_fork(void)
+{
+	pid_t child, grandchild;
+
+	child = fork();
+	if (child < 0) {
+		err(1, "fork");
+	} else if (child > 0) {
+		int status;
+
+		wait(&status);
+		if (!WIFEXITED(status) || WEXITSTATUS(status))
+			err(1, "fork test child");
+		return;
+	}
+
+	printf("[RUN]\tCheck tile data inheritance.\n\tBefore fork(), load tile data -- yes:\n");
+
+	set_xstatebv(xsave_buffer, XFEATURE_MASK_XTILE);
+	set_tiledata(xsave_buffer + xsave_xtiledata_offset);
+	memset(xsave_buffer + xsave_xtilecfg_offset, 1, xsave_xtilecfg_size);
+	syscall(SYS_arch_prctl, ARCH_GET_XSTATE, XFEATURE_MASK_XTILE);
+	xrstor(xsave_buffer, -1, -1);
+
+	grandchild = fork();
+	if (grandchild < 0) {
+		err(1, "fork");
+	} else if (grandchild > 0) {
+		int status;
+
+		wait(&status);
+		if (!WIFEXITED(status) || WEXITSTATUS(status))
+			err(1, "fork test child");
+		_exit(0);
+	}
+
+	if (__xgetbv(1) & XFEATURE_MASK_XTILE) {
+		nerrs++;
+		printf("[FAIL]\tIn a child, AMX state is not initialized.\n");
+	} else {
+		printf("[OK]\tIn a child, AMX state is initialized.\n");
+	}
+	_exit(0);
+}
+
+/* Context switching test */
+
+#define ITERATIONS			10
+#define NUM_THREADS			5
+
+struct futex_info {
+	int current;
+	int *futex;
+	int next;
+};
+
+static inline void command_wait(struct futex_info *info, int value)
+{
+	do {
+		sched_yield();
+	} while (syscall(SYS_futex, info->futex, FUTEX_WAIT, value, 0, 0, 0));
+}
+
+static inline void command_wake(struct futex_info *info, int value)
+{
+	do {
+		*info->futex = value;
+		while (!syscall(SYS_futex, info->futex, FUTEX_WAKE, 1, 0, 0, 0))
+			sched_yield();
+	} while (0);
+}
+
+static inline int get_iterative_value(int id)
+{
+	return ((id << 1) & ~0x1);
+}
+
+static inline int get_endpoint_value(int id)
+{
+	return ((id << 1) | 0x1);
+}
+
+static void *check_tiledata(void *info)
+{
+	struct futex_info *finfo = (struct futex_info *)info;
+	void *xsave, *tiledata;
+	int i;
+
+	xsave = aligned_alloc(64, xsave_size);
+	if (!xsave)
+		err(1, "aligned_alloc()");
+
+	tiledata = malloc(xsave_xtiledata_size);
+	if (!tiledata)
+		err(1, "malloc()");
+
+	set_xstatebv(xsave, XFEATURE_MASK_XTILEDATA);
+	set_tiledata(xsave + xsave_xtiledata_offset);
+	syscall(SYS_arch_prctl, ARCH_GET_XSTATE, XFEATURE_MASK_XTILE);
+	xrstor(xsave, -1, -1);
+	memcpy(tiledata, xsave + xsave_xtiledata_offset, xsave_xtiledata_size);
+
+	for (i = 0; i < ITERATIONS; i++) {
+		command_wait(finfo, get_iterative_value(finfo->current));
+
+		__xsave(xsave, XFEATURE_MASK_XTILEDATA, 0);
+		if (memcmp(tiledata, xsave + xsave_xtiledata_offset, xsave_xtiledata_size))
+			errs++;
+
+		set_tiledata(xsave + xsave_xtiledata_offset);
+		syscall(SYS_arch_prctl, ARCH_GET_XSTATE, XFEATURE_MASK_XTILE);
+		xrstor(xsave, -1, -1);
+		memcpy(tiledata, xsave + xsave_xtiledata_offset, xsave_xtiledata_size);
+
+		command_wake(finfo, get_iterative_value(finfo->next));
+	}
+
+	command_wait(finfo, get_endpoint_value(finfo->current));
+
+	free(xsave);
+	free(tiledata);
+	return NULL;
+}
+
+static int create_threads(int num, struct futex_info *finfo)
+{
+	const int shm_id = shmget(IPC_PRIVATE, sizeof(int), IPC_CREAT | 0666);
+	int *futex = shmat(shm_id, NULL, 0);
+	pthread_t thread;
+	int i;
+
+	for (i = 0; i < num; i++) {
+		finfo[i].futex = futex;
+		finfo[i].current = i + 1;
+		finfo[i].next = (i + 2) % (num + 1);
+
+		if (pthread_create(&thread, NULL, check_tiledata, &finfo[i]))
+			err(1, "pthread_create()");
+	}
+	return 0;
+}
+
+static void test_context_switch(void)
+{
+	struct futex_info *finfo;
+	cpu_set_t cpuset;
+	int i;
+
+	printf("[RUN]\tCheck tile data context switches.\n");
+	printf("\t# of context switches -- %u, # of threads -- %d:\n",
+	       ITERATIONS * NUM_THREADS, NUM_THREADS);
+
+	errs = 0;
+
+	CPU_ZERO(&cpuset);
+	CPU_SET(0, &cpuset);
+
+	if (sched_setaffinity(0, sizeof(cpuset), &cpuset) != 0)
+		err(1, "sched_setaffinity to CPU 0");
+
+	finfo = malloc(sizeof(*finfo) * NUM_THREADS);
+	if (!finfo)
+		err(1, "malloc()");
+
+	create_threads(NUM_THREADS, finfo);
+
+	for (i = 0; i < ITERATIONS; i++) {
+		command_wake(finfo, get_iterative_value(1));
+		command_wait(finfo, get_iterative_value(0));
+	}
+
+	for (i = 1; i <= NUM_THREADS; i++)
+		command_wake(finfo, get_endpoint_value(i));
+
+	if (errs) {
+		nerrs += errs;
+		printf("[FAIL]\tIncorrect cases were found -- (%d / %u).\n",
+		       errs, ITERATIONS * NUM_THREADS);
+		free(finfo);
+		return;
+	}
+
+	free(finfo);
+	printf("[OK]\tNo incorrect case was found.\n");
+}
+
+/* Ptrace test */
+
+static bool set_tiledata_state;
+
+static int write_tiledata(pid_t child)
+{
+	struct iovec iov;
+
+	iov.iov_base = xsave_buffer;
+	iov.iov_len = xsave_size;
+
+	set_xstatebv(xsave_buffer, set_tiledata_state ? XFEATURE_MASK_XTILEDATA : 0);
+	set_tiledata(xsave_buffer + xsave_xtiledata_offset);
+	if (set_tiledata_state)
+		memcpy(tiledata, xsave_buffer + xsave_xtiledata_offset, xsave_xtiledata_size);
+	else
+		memset(tiledata, 0, xsave_xtiledata_size);
+
+	if (ptrace(PTRACE_SETREGSET, child, (uint32_t)NT_X86_XSTATE, &iov))
+		err(1, "PTRACE_SETREGSET");
+
+	if (ptrace(PTRACE_GETREGSET, child, (uint32_t)NT_X86_XSTATE, &iov))
+		err(1, "PTRACE_GETREGSET");
+
+	return memcmp(tiledata, xsave_buffer + xsave_xtiledata_offset, xsave_xtiledata_size);
+}
+
+static void test_tile_write(void)
+{
+	pid_t child;
+	int status;
+
+	child = fork();
+	if (child < 0)
+		err(1, "fork");
+
+	if (!child) {
+		printf("\tInject tile data -- %s:\n",
+		       set_tiledata_state ? "yes" : "no");
+
+		if (ptrace(PTRACE_TRACEME, 0, NULL, NULL))
+			err(1, "PTRACE_TRACEME");
+
+		raise(SIGTRAP);
+		_exit(0);
+	}
+
+	do {
+		wait(&status);
+	} while (WSTOPSIG(status) != SIGTRAP);
+
+	errs = write_tiledata(child);
+	if (errs) {
+		nerrs++;
+		printf("[FAIL]\tTile data was %swritten on ptracee.\n",
+		       set_tiledata_state ? "not " : "");
+	} else {
+		printf("[OK]\tTile data was %swritten on ptracee.\n",
+		       set_tiledata_state ? "" : "not ");
+	}
+
+	ptrace(PTRACE_DETACH, child, NULL, NULL);
+	wait(&status);
+	if (!WIFEXITED(status) || WEXITSTATUS(status))
+		err(1, "fork test child");
+}
+
+static void test_ptrace(void)
+{
+	printf("[RUN]\tCheck ptrace() to inject tile data.\n");
+
+	set_tiledata_state = true;
+	test_tile_write();
+
+	set_tiledata_state = false;
+	test_tile_write();
+}
+
+int main(void)
+{
+	/* Check hardware availability at first */
+
+	if (!check_xsave_capability()) {
+		if (xsave_disabled)
+			printf("XSAVE disabled.\n");
+		else
+			printf("Tile data not available.\n");
+		return 0;
+	}
+
+	check_cpuid();
+
+	xsave_buffer = aligned_alloc(64, xsave_size);
+	if (!xsave_buffer)
+		err(1, "aligned_alloc()");
+
+	tiledata = malloc(xsave_xtiledata_size);
+	if (!tiledata)
+		err(1, "malloc()");
+
+	nerrs = 0;
+
+	sethandler(SIGSEGV, handle_sigsegv, 0);
+
+	test_arch_prctl();
+	test_fork();
+	test_context_switch();
+	test_ptrace();
+
+	clearhandler(SIGSEGV);
+
+	free(xsave_buffer);
+	free(tiledata);
+	return nerrs ? 1 : 0;
+}
-- 
2.17.1

