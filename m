Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAF143C3492
	for <lists+linux-kselftest@lfdr.de>; Sat, 10 Jul 2021 15:09:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231920AbhGJNMB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 10 Jul 2021 09:12:01 -0400
Received: from mga03.intel.com ([134.134.136.65]:52363 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231696AbhGJNL5 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 10 Jul 2021 09:11:57 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10040"; a="209867331"
X-IronPort-AV: E=Sophos;i="5.84,229,1620716400"; 
   d="scan'208";a="209867331"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2021 06:09:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,229,1620716400"; 
   d="scan'208";a="488742419"
Received: from chang-linux-3.sc.intel.com ([172.25.66.175])
  by FMSMGA003.fm.intel.com with ESMTP; 10 Jul 2021 06:09:10 -0700
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     bp@suse.de, luto@kernel.org, tglx@linutronix.de, mingo@kernel.org,
        x86@kernel.org
Cc:     len.brown@intel.com, dave.hansen@intel.com,
        thiago.macieira@intel.com, jing2.liu@intel.com,
        ravi.v.shankar@intel.com, linux-kernel@vger.kernel.org,
        chang.seok.bae@intel.com, linux-kselftest@vger.kernel.org
Subject: [PATCH v7 23/26] selftest/x86/amx: Test cases for the AMX state management
Date:   Sat, 10 Jul 2021 06:03:10 -0700
Message-Id: <20210710130313.5072-24-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210710130313.5072-1-chang.seok.bae@intel.com>
References: <20210710130313.5072-1-chang.seok.bae@intel.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This selftest verifies that the XSTATE arch_prctl works for AMX state and
that a forked task has the AMX state in the INIT-state.

In addition, this test verifies that the kernel correctly context switches
unique AMX data, when multiple threads are using AMX. The test also
verifies that ptrace() can insert data into existing threads.

Finally, add a test case to verify that unused states are excluded, by
leaving a known pattern on the signal stack and verifying that it is still
intact after taking a subsequent signal.

These test cases do not depend on AMX compiler support, as they employ
userspace-XSAVE directly to access AMX state.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Reviewed-by: Len Brown <len.brown@intel.com>
Cc: linux-kernel@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org
---
Changes from v6:
* Adjust for the syscall and ptrace path changes.

Changes from v5:
* Adjusted arch_prctl for the updated ABI.
* Added test for the dynamic signal xstate buffer.
* Fixed XSAVE buffer's header data.

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
 tools/testing/selftests/x86/amx.c    | 883 +++++++++++++++++++++++++++
 2 files changed, 884 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/x86/amx.c

diff --git a/tools/testing/selftests/x86/Makefile b/tools/testing/selftests/x86/Makefile
index b4142cd1c5c2..8a1f62ab3c8e 100644
--- a/tools/testing/selftests/x86/Makefile
+++ b/tools/testing/selftests/x86/Makefile
@@ -18,7 +18,7 @@ TARGETS_C_32BIT_ONLY := entry_from_vm86 test_syscall_vdso unwind_vdso \
 			test_FCMOV test_FCOMI test_FISTTP \
 			vdso_restorer
 TARGETS_C_64BIT_ONLY := fsgsbase sysret_rip syscall_numbering \
-			corrupt_xstate_header
+			corrupt_xstate_header amx
 # Some selftests require 32bit support enabled also on 64bit systems
 TARGETS_C_32BIT_NEEDED := ldt_gdt ptrace_syscall
 
diff --git a/tools/testing/selftests/x86/amx.c b/tools/testing/selftests/x86/amx.c
new file mode 100644
index 000000000000..154dc750dae3
--- /dev/null
+++ b/tools/testing/selftests/x86/amx.c
@@ -0,0 +1,883 @@
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
+#define XSAVE_HDR_SIZE		64
+
+static inline void clr_xstatehdr(void *xsave)
+{
+	memset(xsave + XSAVE_HDR_OFFSET, 0, XSAVE_HDR_SIZE);
+}
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
+static void set_rand_tiledata(void *tiledata)
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
+/* See 'struct _fpx_sw_bytes' at sigcontext.h */
+#define SW_BYTES_OFFSET		464
+/* N.B. The struct's field name varies so read from the offset. */
+#define SW_BYTES_BV_OFFSET	SW_BYTES_OFFSET + 8
+
+static inline struct _fpx_sw_bytes *get_fpx_sw_bytes(void *xsave)
+{
+	return (struct _fpx_sw_bytes *)(xsave + SW_BYTES_OFFSET);
+}
+
+static inline uint64_t get_fpx_sw_bytes_xstatebv(void *xsave)
+{
+	return *(uint64_t *)(xsave + SW_BYTES_BV_OFFSET);
+}
+
+static volatile bool sigsegved;
+
+static void handle_sigsegv(int sig, siginfo_t *si, void *ctx_void)
+{
+	ucontext_t *ctx = (ucontext_t*)ctx_void;
+	void *xsave = ctx->uc_mcontext.fpregs;
+	struct _fpx_sw_bytes *sw_bytes;
+
+	printf("\tAt SIGSEGV handler,\n");
+
+	sw_bytes = get_fpx_sw_bytes(xsave);
+	if (!(sw_bytes->xstate_size < xsave_xtiledata_offset) &&
+	    !(get_fpx_sw_bytes_xstatebv(xsave) & XFEATURE_MASK_XTILEDATA)) {
+		printf("[OK]\tValid xstate size and mask in the SW data of xstate buffer.\n");
+	} else {
+		errs++;
+		printf("[FAIL]\tInvalid xstate size and/or mask in the SW data of xstate buf.\n");
+	}
+
+	sigsegved = true;
+	ctx->uc_mcontext.gregs[REG_RIP] += 3; /* Skip the faulting XRSTOR */
+}
+
+/* Return true if XRSTOR is successful; otherwise, false.  */
+static bool inline xrstor(void *buffer, uint32_t lo, uint32_t hi)
+{
+	sigsegved = false;
+	__xrstor(buffer, lo, hi);
+	return !sigsegved;
+}
+
+/* arch_prctl test */
+
+#define ARCH_SET_XSTATE_ENABLE	0x1021
+#define ARCH_GET_XSTATE_ENABLE	0x1022
+
+static void enable_tiledata(void)
+{
+	long rc;
+
+	rc = syscall(SYS_arch_prctl, ARCH_SET_XSTATE_ENABLE, XFEATURE_MASK_XTILEDATA);
+	if (rc)
+		goto fail;
+
+	rc = syscall(SYS_arch_prctl, ARCH_GET_XSTATE_ENABLE, 0);
+	if (rc & XFEATURE_MASK_XTILEDATA)
+		return;
+
+fail:
+	err(1, "ARCH_SET_XSTATE_ENABLE");
+}
+
+#define TEST_EXECV_ARG		"nested"
+
+static void test_arch_prctl(int argc, char **argv)
+{
+	pid_t parent, child, grandchild;
+
+	parent = fork();
+	if (parent < 0) {
+		err(1, "fork");
+	} else if (parent > 0) {
+		int status;
+
+		wait(&status);
+		if (!WIFEXITED(status) || WEXITSTATUS(status))
+			err(1, "arch_prctl test parent exit");
+		return;
+	}
+
+	printf("[RUN]\tCheck ARCH_SET_XSTATE_ENABLE around process fork().\n");
+
+	printf("\tFork a child.\n");
+	child = fork();
+	if (child < 0) {
+		err(1, "fork");
+	} else if (child > 0) {
+		int status;
+
+		enable_tiledata();
+		printf("\tDo ARCH_SET_XSTATE_ENABLE at parent\n");
+
+		wait(&status);
+		if (!WIFEXITED(status) || WEXITSTATUS(status))
+			err(1, "arch_prctl test child exit");
+		_exit(0);
+	}
+
+	clr_xstatehdr(xsave_buffer);
+	set_xstatebv(xsave_buffer, XFEATURE_MASK_XTILEDATA);
+	set_rand_tiledata(xsave_buffer + xsave_xtiledata_offset);
+
+	printf("\tLoad tile data without ARCH_SET_XSTATE_ENABLE at child.\n");
+	if (xrstor(xsave_buffer, -1, -1)) {
+		nerrs++;
+		printf("[FAIL]\tSucceeded at child.\n");
+	} else {
+		printf("[OK]\tBlocked at child.\n");
+	}
+
+	printf("\tDo ARCH_SET_XSTATE_ENABLE at child.\n");
+	enable_tiledata();
+
+	printf("\tLoad tile data with ARCH_SET_XSTATE_ENABLE at child:\n");
+	sigsegved = false;
+	if (xrstor(xsave_buffer, -1, -1)) {
+		printf("[OK]\tSucceeded at child.\n");
+	} else {
+		nerrs++;
+		printf("[FAIL]\tBlocked at child.\n");
+	}
+
+	printf("\tFork a grandchild.\n");
+	grandchild = fork();
+	if (grandchild < 0) {
+		err(1, "fork");
+	} else if (!grandchild) {
+		char *args[] = {argv[0], TEST_EXECV_ARG, NULL};
+
+		if (xrstor(xsave_buffer, -1, -1)) {
+			printf("[OK]\tSucceeded at grandchild.\n");
+		} else {
+			nerrs++;
+			printf("[FAIL]\tBlocked at grandchild.\n");
+		}
+		nerrs += execv(args[0], args);
+	} else {
+		int status;
+
+		wait(&status);
+		if (!WIFEXITED(status) || WEXITSTATUS(status))
+			err(1, "fork test grandchild");
+	}
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
+	clr_xstatehdr(xsave_buffer);
+	set_xstatebv(xsave_buffer, XFEATURE_MASK_XTILE);
+	set_rand_tiledata(xsave_buffer + xsave_xtiledata_offset);
+	memset(xsave_buffer + xsave_xtilecfg_offset, 1, xsave_xtilecfg_size);
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
+			err(1, "fork test grand child");
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
+#define ITERATIONS	10
+#define NUM_THREADS	5
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
+	set_rand_tiledata(xsave + xsave_xtiledata_offset);
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
+		set_rand_tiledata(xsave + xsave_xtiledata_offset);
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
+	int i;
+
+	printf("[RUN]\tCheck tile data context switches.\n");
+	printf("\t# of context switches -- %u, # of threads -- %d:\n",
+	       ITERATIONS * NUM_THREADS, NUM_THREADS);
+
+	errs = 0;
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
+	} else {
+		printf("[OK]\tNo incorrect case was found.\n");
+	}
+
+	free(finfo);
+	return;
+}
+
+/* Ptrace test */
+
+static bool allow_ptracee_dynstate;
+
+static int inject_tiledata(pid_t target)
+{
+	struct iovec iov;
+
+	iov.iov_base = xsave_buffer;
+	iov.iov_len = xsave_size;
+
+	clr_xstatehdr(xsave_buffer);
+	set_xstatebv(xsave_buffer, XFEATURE_MASK_XTILEDATA);
+	set_rand_tiledata(xsave_buffer + xsave_xtiledata_offset);
+	memcpy(tiledata, xsave_buffer + xsave_xtiledata_offset, xsave_xtiledata_size);
+
+	if (ptrace(PTRACE_SETREGSET, target, (uint32_t)NT_X86_XSTATE, &iov)) {
+		if (errno != EFAULT)
+			err(1, "PTRACE_SETREGSET");
+		else
+			return errno;
+	}
+
+	if (ptrace(PTRACE_GETREGSET, target, (uint32_t)NT_X86_XSTATE, &iov))
+		err(1, "PTRACE_GETREGSET");
+
+	if (!memcmp(tiledata, xsave_buffer + xsave_xtiledata_offset, xsave_xtiledata_size))
+		return 0;
+	else
+		return -1;
+}
+
+static void test_tile_write(void)
+{
+	int status, rc;
+	pid_t child;
+	bool pass;
+
+	child = fork();
+	if (child < 0) {
+		err(1, "fork");
+	} else if (!child) {
+		if (allow_ptracee_dynstate)
+			enable_tiledata();
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
+	printf("\tInject tile data %s ARCH_SET_XSTATE_ENABLE\n",
+	       allow_ptracee_dynstate ? "with" : "without");
+
+	rc = inject_tiledata(child);
+	pass = (rc == EFAULT && !allow_ptracee_dynstate) ||
+	       (!rc && allow_ptracee_dynstate);
+	if (!pass)
+		nerrs++;
+	printf("[%s]\tTile data was %swritten on ptracee.\n",
+	       pass ? "OK" : "FAIL", errs ? "not " : "");
+
+	ptrace(PTRACE_DETACH, child, NULL, NULL);
+	wait(&status);
+	if (!WIFEXITED(status) || WEXITSTATUS(status))
+		err(1, "ptrace test");
+
+	return;
+}
+
+static void test_ptrace(void)
+{
+	printf("[RUN]\tCheck ptrace() to inject tile data.\n");
+
+	allow_ptracee_dynstate = false;
+	test_tile_write();
+
+	allow_ptracee_dynstate = true;
+	test_tile_write();
+}
+
+/* Signal handling test */
+
+static bool init_tiledata_state_before_signal;
+static bool load_tiledata_at_first;
+static volatile bool sigalarmed, sigused;
+
+#define SIGFRAME_TILEDATA_SIGNATURE	0xFF
+
+static void handle_sigusr1(int sig, siginfo_t *info, void *ctx_void)
+{
+	void *xsave = ((ucontext_t *)ctx_void)->uc_mcontext.fpregs;
+	struct _fpx_sw_bytes *sw_bytes = get_fpx_sw_bytes(xsave);
+
+	if (sw_bytes->xstate_size >= (xsave_xtiledata_offset + xsave_xtiledata_size)) {
+		memset(xsave + xsave_xtiledata_offset, SIGFRAME_TILEDATA_SIGNATURE,
+		       xsave_xtiledata_size);
+	}
+
+	sigused = true;
+}
+
+static void handle_sigalrm(int sig, siginfo_t *info, void *ctx_void)
+{
+	bool tiledata_written = false, tiledata_bit, tiledata_expected;
+	void *xsave = ((ucontext_t *)ctx_void)->uc_mcontext.fpregs;
+	struct _fpx_sw_bytes *sw_bytes = get_fpx_sw_bytes(xsave);
+	char d = SIGFRAME_TILEDATA_SIGNATURE;
+	int i;
+
+	printf("\tAt signal delivery,\n");
+
+	/* Check SW reserved data in the buffer: */
+	if ((sw_bytes->xstate_size >= (xsave_xtiledata_offset + xsave_xtiledata_size)) &&
+	    (get_fpx_sw_bytes_xstatebv(xsave) & XFEATURE_MASK_XTILEDATA)) {
+		printf("[OK]\tValid xstate size and mask in the SW data of xstate buffer\n");
+	} else {
+		errs++;
+		printf("[FAIL]\tInvalid xstate size and/or mask in the SW data of xstate buffer\n");
+	}
+
+	/* Check XSAVE buffer header: */
+	tiledata_expected = (load_tiledata_at_first && !init_tiledata_state_before_signal);
+	tiledata_bit = get_xstatebv(xsave) & XFEATURE_MASK_XTILEDATA;
+
+	if (tiledata_bit == tiledata_expected) {
+		printf("[OK]\tTiledata bit is %sset in XSTATE_BV of xstate buffer.\n",
+		       tiledata_bit ? "" : "not ");
+	} else {
+		errs++;
+		printf("[FAIL]\tTiledata bit is %sset in XSTATE_BV of xstate buffer.\n",
+		       tiledata_bit ? "" : "not ");
+	}
+
+	/*
+	 * Check the sigframe data:
+	 */
+
+	tiledata_expected = (load_tiledata_at_first && !init_tiledata_state_before_signal);
+
+	if (sw_bytes->xstate_size >= (xsave_xtiledata_offset + xsave_xtiledata_size)) {
+		for (i = 0; i < xsave_xtiledata_size; i++) {
+			tiledata_written = memcmp(xsave + xsave_xtiledata_offset + i, &d, 1);
+			if (tiledata_written)
+				break;
+		}
+	}
+
+	if (tiledata_written == tiledata_expected) {
+		printf("[OK]\tTiledata is %ssaved in signal buffer.\n",
+		       tiledata_written ? "" : "not ");
+	} else {
+		errs++;
+		printf("[FAIL]\tTiledata is %ssaved in signal buffer.\n",
+		       tiledata_written ? "" : "not ");
+	}
+
+	/* Load random tiledata to test sigreturn: */
+	clr_xstatehdr(xsave_buffer);
+	set_xstatebv(xsave_buffer, XFEATURE_MASK_XTILEDATA);
+	set_rand_tiledata(xsave_buffer + xsave_xtiledata_offset);
+	xrstor(xsave_buffer, -1, -1);
+	sigalarmed = true;
+}
+
+static void test_signal_handling(void)
+{
+	pid_t child;
+
+	sigalarmed = false;
+	sigused = false;
+
+	child = fork();
+	if (child < 0) {
+		err(1, "fork");
+	} else if (child > 0) {
+		do {
+			int status;
+
+			wait(&status);
+			if (WIFSTOPPED(status))
+				kill(child, SIGCONT);
+			else if (WIFEXITED(status) && !WEXITSTATUS(status))
+				break;
+			else
+				err(1, "signal test child");
+		} while (1);
+		return;
+	}
+
+	printf("\tBefore signal, load tile data -- %s",
+	       load_tiledata_at_first ? "yes, " : "no:\n");
+	if (load_tiledata_at_first)
+		printf("re-initialized -- %s:\n",
+		       init_tiledata_state_before_signal ? "yes" : "no");
+
+	/*
+	 * Raise SIGUSR1 to pre-fill sig stack. Also, load tiledata to size the pre-fill.
+	 */
+
+	if (load_tiledata_at_first) {
+		clr_xstatehdr(xsave_buffer);
+		set_xstatebv(xsave_buffer, XFEATURE_MASK_XTILEDATA);
+		xrstor(xsave_buffer, -1, -1);
+	}
+
+	raise(SIGUSR1);
+	if (!sigused)
+		err(1, "SIGUSR1");
+
+	/*
+	 * Raise SIGALRM to test AMX state handling in signal delivery. Set up the state and
+	 * data before the test.
+	 */
+
+	if (load_tiledata_at_first) {
+		clr_xstatehdr(xsave_buffer);
+		set_xstatebv(xsave_buffer, XFEATURE_MASK_XTILEDATA);
+		set_rand_tiledata(xsave_buffer + xsave_xtiledata_offset);
+		xrstor(xsave_buffer, -1, -1);
+
+		if (init_tiledata_state_before_signal) {
+			clr_xstatehdr(xsave_buffer);
+			set_xstatebv(xsave_buffer, 0);
+			xrstor(xsave_buffer, -1, -1);
+			memset(tiledata, 0, xsave_xtiledata_size);
+		} else {
+			memcpy(tiledata, xsave_buffer + xsave_xtiledata_offset,
+			       xsave_xtiledata_size);
+		}
+	} else {
+		memset(tiledata, 0, xsave_xtiledata_size);
+	}
+
+	raise(SIGALRM);
+	if (!sigalarmed)
+		err(1, "SIGALRM");
+
+	printf("\tAt signal return,\n");
+	__xsave(xsave_buffer, XFEATURE_MASK_XTILEDATA, 0);
+	if (memcmp(tiledata, xsave_buffer + xsave_xtiledata_offset, xsave_xtiledata_size)) {
+		errs++;
+		printf("[FAIL]\tTiledata is not restored.\n");
+	} else {
+		printf("[OK]\tTiledata is restored.\n");
+	}
+
+	if (errs)
+		nerrs++;
+	_exit(0);
+}
+
+static void test_signal(void)
+{
+	printf("[RUN]\tCheck tile data state in signal path:\n");
+
+	sethandler(SIGALRM, handle_sigalrm, 0);
+	sethandler(SIGUSR1, handle_sigusr1, 0);
+
+	load_tiledata_at_first = false;
+	init_tiledata_state_before_signal = false;
+	errs = 0;
+	test_signal_handling();
+
+	load_tiledata_at_first = true;
+	init_tiledata_state_before_signal = false;
+	errs = 0;
+	test_signal_handling();
+
+	load_tiledata_at_first = true;
+	init_tiledata_state_before_signal = true;
+	errs = 0;
+	test_signal_handling();
+
+	clearhandler(SIGALRM);
+	clearhandler(SIGUSR1);
+}
+
+int main(int argc, char **argv)
+{
+	cpu_set_t cpuset;
+
+	if (argc == 2) {
+		int ret;
+
+		if (strcmp(argv[1], TEST_EXECV_ARG))
+			return 0;
+
+		printf("\tRun after execv().\n");
+
+		xsave_buffer = aligned_alloc(64, xsave_size);
+		if (!xsave_buffer)
+			err(1, "aligned_alloc()");
+		clr_xstatehdr(xsave_buffer);
+
+		set_xstatebv(xsave_buffer, XFEATURE_MASK_XTILE);
+		set_rand_tiledata(xsave_buffer + xsave_xtiledata_offset);
+
+		sethandler(SIGSEGV, handle_sigsegv, 0);
+
+		if (xrstor(xsave_buffer, -1, -1)) {
+			printf("[FAIL]\tSucceeded after execv().\n");
+			ret = 1;
+		} else {
+			printf("[OK]\tBlocked after execv().\n");
+			ret = 0;
+		}
+
+		clearhandler(SIGSEGV);
+		free(xsave_buffer);
+		_exit(ret);
+	}
+
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
+	clr_xstatehdr(xsave_buffer);
+
+	tiledata = malloc(xsave_xtiledata_size);
+	if (!tiledata)
+		err(1, "malloc()");
+
+	nerrs = 0;
+
+	sethandler(SIGSEGV, handle_sigsegv, 0);
+
+	CPU_ZERO(&cpuset);
+	CPU_SET(0, &cpuset);
+
+	if (sched_setaffinity(0, sizeof(cpuset), &cpuset) != 0)
+		err(1, "sched_setaffinity to CPU 0");
+
+	test_arch_prctl(argc, argv);
+	test_ptrace();
+
+	enable_tiledata();
+	test_context_switch();
+	test_fork();
+	test_signal();
+
+	clearhandler(SIGSEGV);
+
+	free(xsave_buffer);
+	free(tiledata);
+	return nerrs ? 1 : 0;
+}
-- 
2.17.1

