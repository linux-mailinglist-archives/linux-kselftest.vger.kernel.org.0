Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECD2C3CC41E
	for <lists+linux-kselftest@lfdr.de>; Sat, 17 Jul 2021 17:35:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235033AbhGQPiR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 17 Jul 2021 11:38:17 -0400
Received: from mga09.intel.com ([134.134.136.24]:24186 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235122AbhGQPiQ (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 17 Jul 2021 11:38:16 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10047"; a="210853890"
X-IronPort-AV: E=Sophos;i="5.84,248,1620716400"; 
   d="scan'208";a="210853890"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2021 08:35:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,248,1620716400"; 
   d="scan'208";a="631387069"
Received: from chang-linux-3.sc.intel.com ([172.25.66.175])
  by orsmga005.jf.intel.com with ESMTP; 17 Jul 2021 08:35:11 -0700
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     bp@suse.de, luto@kernel.org, tglx@linutronix.de, mingo@kernel.org,
        x86@kernel.org
Cc:     len.brown@intel.com, dave.hansen@intel.com,
        thiago.macieira@intel.com, jing2.liu@intel.com,
        ravi.v.shankar@intel.com, linux-kernel@vger.kernel.org,
        chang.seok.bae@intel.com, linux-kselftest@vger.kernel.org
Subject: [PATCH v8 23/26] selftest/x86/amx: Test cases for the AMX state management
Date:   Sat, 17 Jul 2021 08:29:00 -0700
Message-Id: <20210717152903.7651-24-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210717152903.7651-1-chang.seok.bae@intel.com>
References: <20210717152903.7651-1-chang.seok.bae@intel.com>
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
Changes from v7:
* Adjust for SIGILL.
* Test XTILECFG for legacy signal delivery.

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
 tools/testing/selftests/x86/amx.c    | 954 +++++++++++++++++++++++++++
 2 files changed, 955 insertions(+), 1 deletion(-)
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
index 000000000000..05373dbd02b9
--- /dev/null
+++ b/tools/testing/selftests/x86/amx.c
@@ -0,0 +1,954 @@
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
+static inline uint64_t xgetbv(uint32_t index)
+{
+	uint32_t eax, edx;
+
+	asm volatile("xgetbv;"
+		     : "=a" (eax), "=d" (edx)
+		     : "c" (index));
+	return eax + ((uint64_t)edx << 32);
+}
+
+static inline void cpuid(uint32_t *eax, uint32_t *ebx, uint32_t *ecx, uint32_t *edx)
+{
+	asm volatile("cpuid;"
+		     : "=a" (*eax), "=b" (*ebx), "=c" (*ecx), "=d" (*edx)
+		     : "0" (*eax), "2" (*ecx));
+}
+
+static inline void xsave(void *xbuf, uint32_t lo, uint32_t hi)
+{
+	asm volatile("xsave (%%rdi)"
+		     : : "D" (xbuf), "a" (lo), "d" (hi)
+		     : "memory");
+}
+
+static inline void xrstor(void *xbuf, uint32_t lo, uint32_t hi)
+{
+	asm volatile("xrstor (%%rdi)"
+		     : : "D" (xbuf), "a" (lo), "d" (hi));
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
+static bool noxsave;
+
+static void handle_noxsave(int sig, siginfo_t *si, void *ctx_void)
+{
+	noxsave = true;
+	siglongjmp(jmpbuf, 1);
+}
+
+#define XFEATURE_XTILECFG	17
+#define XFEATURE_XTILEDATA	18
+#define XFEATURE_MASK_XTILECFG	(1 << XFEATURE_XTILECFG)
+#define XFEATURE_MASK_XTILEDATA	(1 << XFEATURE_XTILEDATA)
+#define XFEATURE_MASK_XTILE	(XFEATURE_MASK_XTILECFG | XFEATURE_MASK_XTILEDATA)
+
+static inline bool check_xtile(void)
+{
+	bool xtile_enable;
+
+	sethandler(SIGILL, handle_noxsave, 0);
+
+	if ((!sigsetjmp(jmpbuf, 1)) && (xgetbv(0) & XFEATURE_MASK_XTILE)) {
+		xtile_enable = true;
+		goto out;
+	}
+	xtile_enable = false;
+out:
+	clearhandler(SIGILL);
+	return xtile_enable;
+}
+
+static uint32_t xsave_size;
+static uint32_t xsave_xtiledata_offset, xsave_xtilecfg_offset;
+static uint32_t xtiledata_size, xtilecfg_size;
+
+static struct _tile_spec {
+	uint16_t bytes_per_row;
+	uint16_t max_names;
+	uint16_t max_rows;
+} tile_spec;
+
+#define XSTATE_CPUID			0xd
+#define XSTATE_USER_STATE_SUBLEAVE	0x0
+#define TILE_CPUID			0x1d
+#define TILE_PALETTE_ID			0x1
+
+static void check_cpuid(void)
+{
+	uint32_t eax, ebx, ecx, edx;
+
+	eax = XSTATE_CPUID;
+	ecx = XSTATE_USER_STATE_SUBLEAVE;
+
+	cpuid(&eax, &ebx, &ecx, &edx);
+	if (!ebx)
+		err(1, "xstate cpuid: xsave size");
+
+	xsave_size = ebx;
+
+	eax = XSTATE_CPUID;
+	ecx = XFEATURE_XTILECFG;
+
+	cpuid(&eax, &ebx, &ecx, &edx);
+	if (!eax || !ebx)
+		err(1, "xstate cpuid: tile config state");
+
+	xtilecfg_size = eax;
+	xsave_xtilecfg_offset = ebx;
+
+	eax = XSTATE_CPUID;
+	ecx = XFEATURE_XTILEDATA;
+
+	cpuid(&eax, &ebx, &ecx, &edx);
+	if (!eax || !ebx)
+		err(1, "xstate cpuid: tile data state");
+
+	xtiledata_size = eax;
+	xsave_xtiledata_offset = ebx;
+
+	eax = TILE_CPUID;
+	ecx = TILE_PALETTE_ID;
+
+	cpuid(&eax, &ebx, &ecx, &edx);
+	if (!eax || !ebx || !ecx)
+		err(1, "tile cpuid: palette 1");
+
+	tile_spec.max_names = ebx >> 16;
+	tile_spec.bytes_per_row = ebx;
+	tile_spec.max_rows = ecx;
+}
+
+/* The helpers for managing XSAVE buffer and tile states: */
+
+void *alloc_xsave_buffer(void)
+{
+	void *xbuf;
+
+	/* XSAVE buffer should be 64B-aligned. */
+	xbuf = aligned_alloc(64, xsave_size);
+	if (!xbuf)
+		err(1, "aligned_alloc()");
+	return xbuf;
+}
+
+#define XSAVE_HDR_OFFSET	512
+#define XSAVE_HDR_SIZE		64
+
+static inline void clear_xstate_header(void *buffer)
+{
+	memset(buffer + XSAVE_HDR_OFFSET, 0, XSAVE_HDR_SIZE);
+}
+
+static inline uint64_t get_xstatebv(void *buffer)
+{
+	return *(uint64_t *)(buffer + XSAVE_HDR_OFFSET);
+}
+
+static inline void set_xstatebv(void *buffer, uint64_t bv)
+{
+	*(uint64_t *)(buffer + XSAVE_HDR_OFFSET) = bv;
+}
+
+static void set_rand_tiledata(void *tiledata)
+{
+	int *ptr = tiledata;
+	int data = rand();
+	int i;
+
+	for (i = 0; i < xtiledata_size / sizeof(int); i++, ptr++)
+		*ptr = data;
+}
+
+#define	MAX_TILES		16
+#define RESERVED_BYTES		14
+
+struct tile_config {
+	uint8_t  palette_id;
+	uint8_t  start_row;
+	uint8_t  reserved[RESERVED_BYTES];
+	uint16_t colsb[MAX_TILES];
+	uint8_t  rows[MAX_TILES];
+};
+
+static void set_tilecfg(void *tilecfg)
+{
+	struct tile_config *cfg = tilecfg;
+	int i;
+
+	memset(cfg, 0, sizeof(*cfg));
+	cfg->palette_id = TILE_PALETTE_ID;
+	for (i = 0; i < tile_spec.max_names; i++) {
+		cfg->colsb[i] = tile_spec.bytes_per_row;
+		cfg->rows[i] = tile_spec.max_rows;
+	}
+}
+
+static void *xsave_buffer, *tiledata, *tilecfg;
+static int nerrs, errs;
+
+/* See 'struct _fpx_sw_bytes' at sigcontext.h */
+#define SW_BYTES_OFFSET		464
+/* N.B. The struct's field name varies so read from the offset. */
+#define SW_BYTES_BV_OFFSET	(SW_BYTES_OFFSET + 8)
+
+static inline struct _fpx_sw_bytes *get_fpx_sw_bytes(void *buffer)
+{
+	return (struct _fpx_sw_bytes *)(buffer + SW_BYTES_OFFSET);
+}
+
+static inline uint64_t get_fpx_sw_bytes_xstatebv(void *buffer)
+{
+	return *(uint64_t *)(buffer + SW_BYTES_BV_OFFSET);
+}
+
+static volatile bool noperm;
+static bool check_tilecfg;
+
+static void handle_noperm(int sig, siginfo_t *si, void *ctx_void)
+{
+	ucontext_t *ctx = (ucontext_t *)ctx_void;
+	void *xbuf = ctx->uc_mcontext.fpregs;
+	struct _fpx_sw_bytes *sw_bytes;
+
+	printf("\tAt SIGILL handler,\n");
+
+	if (si->si_code != ILL_ILLOPC) {
+		errs++;
+		printf("[FAIL]\tInvalid signal code (%x).\n", si->si_code);
+	} else {
+		printf("[OK]\tValid signal code (ILL_ILLOPC).\n");
+	}
+
+	sw_bytes = get_fpx_sw_bytes(xbuf);
+	if (!(sw_bytes->xstate_size < xsave_xtiledata_offset) &&
+	    !(get_fpx_sw_bytes_xstatebv(xbuf) & XFEATURE_MASK_XTILEDATA)) {
+		printf("[OK]\tValid xstate size and mask in the SW data of xstate buffer.\n");
+	} else {
+		errs++;
+		printf("[FAIL]\tInvalid xstate size and/or mask in the SW data of xstate buf.\n");
+	}
+
+	if (check_tilecfg) {
+		if (memcmp(tilecfg, xbuf + xsave_xtilecfg_offset, xtilecfg_size)) {
+			errs++;
+			printf("[FAIL]\tTILECFG is corrupted.\n");
+		} else {
+			printf("[OK]\tTILECFG is successfully delivered.\n");
+		}
+	}
+
+	noperm = true;
+	ctx->uc_mcontext.gregs[REG_RIP] += 3; /* Skip the faulting XRSTOR */
+}
+
+/* Return true if XRSTOR is successful; otherwise, false.  */
+static inline bool xrstor_safe(void *buffer, uint32_t lo, uint32_t hi)
+{
+	noperm = false;
+	xrstor(buffer, lo, hi);
+	return !noperm;
+}
+
+/* arch_prctl test */
+
+#define ARCH_SET_STATE_ENABLE	0x1021
+#define ARCH_GET_STATE_ENABLE	0x1022
+
+static void enable_tiledata(void)
+{
+	long rc;
+
+	rc = syscall(SYS_arch_prctl, ARCH_SET_STATE_ENABLE, XFEATURE_MASK_XTILEDATA);
+	if (rc)
+		goto fail;
+
+	rc = syscall(SYS_arch_prctl, ARCH_GET_STATE_ENABLE, 0);
+	if (rc & XFEATURE_MASK_XTILEDATA)
+		return;
+
+fail:
+	err(1, "ARCH_SET_STATE_ENABLE");
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
+	printf("[RUN]\tCheck ARCH_SET_STATE_ENABLE around process fork().\n");
+
+	printf("\tFork a child.\n");
+	child = fork();
+	if (child < 0) {
+		err(1, "fork");
+	} else if (child > 0) {
+		int status;
+
+		enable_tiledata();
+		printf("\tDo ARCH_SET_STATE_ENABLE at parent\n");
+
+		wait(&status);
+		if (!WIFEXITED(status) || WEXITSTATUS(status))
+			err(1, "arch_prctl test child exit");
+		_exit(0);
+	}
+
+	clear_xstate_header(xsave_buffer);
+
+	/* By default, XTILECFG is permitted to use. */
+	set_xstatebv(xsave_buffer, XFEATURE_MASK_XTILECFG);
+	set_tilecfg(xsave_buffer + xsave_xtilecfg_offset);
+	xrstor(xsave_buffer, -1, -1);
+
+	set_xstatebv(xsave_buffer, XFEATURE_MASK_XTILEDATA);
+	set_rand_tiledata(xsave_buffer + xsave_xtiledata_offset);
+
+	printf("\tLoad tile data without ARCH_SET_STATE_ENABLE at child.\n");
+	/*
+	 * Test XTILECFG state delivery via signal, when XTILEDATA is not
+	 * permitted.
+	 */
+	check_tilecfg = true;
+	if (xrstor_safe(xsave_buffer, -1, -1)) {
+		nerrs++;
+		printf("[FAIL]\tSucceeded at child.\n");
+	} else {
+		printf("[OK]\tBlocked at child.\n");
+	}
+
+	printf("\tDo ARCH_SET_STATE_ENABLE at child.\n");
+	enable_tiledata();
+
+	printf("\tLoad tile data with ARCH_SET_STATE_ENABLE at child:\n");
+	check_tilecfg = false;
+	if (xrstor_safe(xsave_buffer, -1, -1)) {
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
+		if (xrstor_safe(xsave_buffer, -1, -1)) {
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
+	clear_xstate_header(xsave_buffer);
+	set_xstatebv(xsave_buffer, XFEATURE_MASK_XTILE);
+	set_tilecfg(xsave_buffer + xsave_xtilecfg_offset);
+	set_rand_tiledata(xsave_buffer + xsave_xtiledata_offset);
+	xrstor_safe(xsave_buffer, -1, -1);
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
+	if (xgetbv(1) & XFEATURE_MASK_XTILE) {
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
+	void *xbuf, *tdata;
+	int i;
+
+	xbuf = alloc_xsave_buffer();
+	tdata = malloc(xtiledata_size);
+	if (!tdata)
+		err(1, "malloc()");
+
+	set_xstatebv(xbuf, XFEATURE_MASK_XTILEDATA);
+	set_rand_tiledata(xbuf + xsave_xtiledata_offset);
+	xrstor_safe(xbuf, -1, -1);
+	memcpy(tdata, xbuf + xsave_xtiledata_offset, xtiledata_size);
+
+	for (i = 0; i < ITERATIONS; i++) {
+		command_wait(finfo, get_iterative_value(finfo->current));
+
+		xsave(xbuf, XFEATURE_MASK_XTILEDATA, 0);
+		if (memcmp(tdata, xbuf + xsave_xtiledata_offset, xtiledata_size))
+			errs++;
+
+		set_rand_tiledata(xbuf + xsave_xtiledata_offset);
+		xrstor_safe(xbuf, -1, -1);
+		memcpy(tdata, xbuf + xsave_xtiledata_offset, xtiledata_size);
+
+		command_wake(finfo, get_iterative_value(finfo->next));
+	}
+
+	command_wait(finfo, get_endpoint_value(finfo->current));
+
+	free(xbuf);
+	free(tdata);
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
+}
+
+/* Ptrace test */
+
+static bool ptracee_state_perm;
+
+static int inject_tiledata(pid_t target)
+{
+	struct iovec iov;
+
+	iov.iov_base = xsave_buffer;
+	iov.iov_len = xsave_size;
+
+	clear_xstate_header(xsave_buffer);
+	set_xstatebv(xsave_buffer, XFEATURE_MASK_XTILEDATA);
+	set_rand_tiledata(xsave_buffer + xsave_xtiledata_offset);
+	memcpy(tiledata, xsave_buffer + xsave_xtiledata_offset, xtiledata_size);
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
+	if (!memcmp(tiledata, xsave_buffer + xsave_xtiledata_offset, xtiledata_size))
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
+		if (ptracee_state_perm)
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
+	printf("\tInject tile data %s ARCH_SET_STATE_ENABLE\n",
+	       ptracee_state_perm ? "with" : "without");
+
+	rc = inject_tiledata(child);
+	pass = (rc == EFAULT && !ptracee_state_perm) ||
+	       (!rc && ptracee_state_perm);
+	if (!pass)
+		nerrs++;
+	printf("[%s]\tTile data was %swritten on ptracee.\n",
+	       pass ? "OK" : "FAIL", errs ? "not " : "");
+
+	ptrace(PTRACE_DETACH, child, NULL, NULL);
+	wait(&status);
+	if (!WIFEXITED(status) || WEXITSTATUS(status))
+		err(1, "ptrace test");
+}
+
+static void test_ptrace(void)
+{
+	printf("[RUN]\tCheck ptrace() to inject tile data.\n");
+
+	ptracee_state_perm = false;
+	test_tile_write();
+
+	ptracee_state_perm = true;
+	test_tile_write();
+}
+
+/* Signal handling test */
+
+static bool init_tiledata, load_tiledata;
+static volatile bool signaled, sigstk_prefill;
+
+#define SIGFRAME_TILEDATA_SIGNATURE	0xEE
+
+static void handle_sigstk_prefill(int sig, siginfo_t *info, void *ctx_void)
+{
+	void *xbuf = ((ucontext_t *)ctx_void)->uc_mcontext.fpregs;
+	struct _fpx_sw_bytes *sw_bytes = get_fpx_sw_bytes(xsave);
+
+	if (sw_bytes->xstate_size >= (xsave_xtiledata_offset + xtiledata_size)) {
+		memset(xbuf + xsave_xtiledata_offset, SIGFRAME_TILEDATA_SIGNATURE,
+		       xtiledata_size);
+	}
+
+	sigstk_prefill = true;
+}
+
+static void handle_signal(int sig, siginfo_t *info, void *ctx_void)
+{
+	bool tiledata_area, tiledata_bit, tiledata_inuse;
+	void *xbuf = ((ucontext_t *)ctx_void)->uc_mcontext.fpregs;
+	struct _fpx_sw_bytes *sw_bytes = get_fpx_sw_bytes(xbuf);
+	char d = SIGFRAME_TILEDATA_SIGNATURE;
+	int i;
+
+	printf("\tAt signal delivery,\n");
+
+	/* Check SW reserved data in the buffer: */
+	if ((sw_bytes->xstate_size >= (xsave_xtiledata_offset + xtiledata_size)) &&
+	    (get_fpx_sw_bytes_xstatebv(xbuf) & XFEATURE_MASK_XTILEDATA)) {
+		printf("[OK]\tValid xstate size and mask in the SW data of xstate buffer\n");
+	} else {
+		errs++;
+		printf("[FAIL]\tInvalid xstate size and/or mask in the SW data of xstate buffer\n");
+	}
+
+	/* Check XSAVE buffer header: */
+	tiledata_inuse = (load_tiledata && !init_tiledata);
+	tiledata_bit = get_xstatebv(xbuf) & XFEATURE_MASK_XTILEDATA;
+
+	if (tiledata_bit == tiledata_inuse) {
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
+	tiledata_inuse = (load_tiledata && !init_tiledata);
+	tiledata_area = false;
+	if (sw_bytes->xstate_size >= (xsave_xtiledata_offset + xtiledata_size)) {
+		for (i = 0; i < xtiledata_size; i++) {
+			if (memcmp(xbuf + xsave_xtiledata_offset + i, &d, 1)) {
+				tiledata_area = true;
+				break;
+			}
+		}
+	}
+
+	if (tiledata_area == tiledata_inuse) {
+		printf("[OK]\tTiledata is %ssaved in signal buffer.\n",
+		       tiledata_area ? "" : "not ");
+	} else {
+		errs++;
+		printf("[FAIL]\tTiledata is %ssaved in signal buffer.\n",
+		       tiledata_area ? "" : "not ");
+	}
+
+	/* Load random tiledata to test sigreturn: */
+	clear_xstate_header(xsave_buffer);
+	set_xstatebv(xsave_buffer, XFEATURE_MASK_XTILEDATA);
+	set_rand_tiledata(xsave_buffer + xsave_xtiledata_offset);
+	xrstor_safe(xsave_buffer, -1, -1);
+	signaled = true;
+}
+
+static void test_signal_handling(void)
+{
+	pid_t child;
+
+	signaled = false;
+	sigstk_prefill = false;
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
+	printf("\tBefore signal, load tile data -- %s", load_tiledata ? "yes, " : "no:\n");
+	if (load_tiledata)
+		printf("re-initialized -- %s:\n", init_tiledata ? "yes" : "no");
+
+	/*
+	 * Raise SIGUSR1 to pre-fill sig stack. Also, load tiledata to size the pre-fill.
+	 */
+
+	if (load_tiledata) {
+		clear_xstate_header(xsave_buffer);
+		set_xstatebv(xsave_buffer, XFEATURE_MASK_XTILEDATA);
+		xrstor_safe(xsave_buffer, -1, -1);
+	}
+
+	raise(SIGUSR1);
+	if (!sigstk_prefill)
+		err(1, "SIGUSR1");
+
+	/*
+	 * Raise SIGALRM to test AMX state handling in signal delivery. Set up the state and
+	 * data before the test.
+	 */
+
+	if (load_tiledata) {
+		clear_xstate_header(xsave_buffer);
+		set_xstatebv(xsave_buffer, XFEATURE_MASK_XTILEDATA);
+		set_rand_tiledata(xsave_buffer + xsave_xtiledata_offset);
+		xrstor_safe(xsave_buffer, -1, -1);
+
+		if (init_tiledata) {
+			clear_xstate_header(xsave_buffer);
+			set_xstatebv(xsave_buffer, 0);
+			xrstor_safe(xsave_buffer, -1, -1);
+			memset(tiledata, 0, xtiledata_size);
+		} else {
+			memcpy(tiledata, xsave_buffer + xsave_xtiledata_offset,
+			       xtiledata_size);
+		}
+	} else {
+		memset(tiledata, 0, xtiledata_size);
+	}
+
+	raise(SIGALRM);
+	if (!signaled)
+		err(1, "SIGALRM");
+
+	printf("\tAt signal return,\n");
+	xsave(xsave_buffer, XFEATURE_MASK_XTILEDATA, 0);
+	if (memcmp(tiledata, xsave_buffer + xsave_xtiledata_offset, xtiledata_size)) {
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
+	sethandler(SIGALRM, handle_signal, 0);
+	sethandler(SIGUSR1, handle_sigstk_prefill, 0);
+
+	load_tiledata = false;
+	init_tiledata = false;
+	errs = 0;
+	test_signal_handling();
+
+	load_tiledata = true;
+	init_tiledata = false;
+	errs = 0;
+	test_signal_handling();
+
+	load_tiledata = true;
+	init_tiledata = true;
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
+		xsave_buffer = alloc_xsave_buffer();
+		clear_xstate_header(xsave_buffer);
+
+		set_xstatebv(xsave_buffer, XFEATURE_MASK_XTILE);
+		set_rand_tiledata(xsave_buffer + xsave_xtiledata_offset);
+
+		sethandler(SIGILL, handle_noperm, 0);
+
+		if (xrstor_safe(xsave_buffer, -1, -1)) {
+			printf("[FAIL]\tSucceeded after execv().\n");
+			ret = 1;
+		} else {
+			printf("[OK]\tBlocked after execv().\n");
+			ret = 0;
+		}
+
+		clearhandler(SIGILL);
+		free(xsave_buffer);
+		_exit(ret);
+	}
+
+	/* Check hardware availability at first */
+
+	if (!check_xtile()) {
+		printf("%s is disabled.\n", noxsave ? "XSAVE" : "AMX");
+		return 0;
+	}
+
+	check_cpuid();
+
+	xsave_buffer = alloc_xsave_buffer();
+	clear_xstate_header(xsave_buffer);
+
+	tiledata = malloc(xtiledata_size);
+	if (!tiledata)
+		err(1, "malloc()");
+
+	tilecfg = malloc(xtilecfg_size);
+	if (!tilecfg)
+		err(1, "malloc()");
+	set_tilecfg(tilecfg);
+
+	nerrs = 0;
+
+	sethandler(SIGILL, handle_noperm, 0);
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
+	clearhandler(SIGILL);
+
+	free(tilecfg);
+	free(tiledata);
+	free(xsave_buffer);
+	return nerrs ? 1 : 0;
+}
-- 
2.17.1

