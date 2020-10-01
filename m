Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEFB52808A1
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Oct 2020 22:43:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733183AbgJAUnf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 1 Oct 2020 16:43:35 -0400
Received: from mga11.intel.com ([192.55.52.93]:58718 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733107AbgJAUnT (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 1 Oct 2020 16:43:19 -0400
IronPort-SDR: 6vHiTAg9anul1sAHZNTJM1rK0kBzAb99SRZnvMkDzhgcfWvWjvK+xH1SCbDPMFQuW28rWk4k+U
 NnJFCm5MdEwQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9761"; a="160170746"
X-IronPort-AV: E=Sophos;i="5.77,325,1596524400"; 
   d="scan'208";a="160170746"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2020 13:42:53 -0700
IronPort-SDR: tMkmAGXN4Cf0UcMim3K8ms0M3LS0BY02kOZ1QnNVEhONnJPON26R9NIC8WlqRUGbE+CiHS0ioH
 WXL9oattsxgg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,325,1596524400"; 
   d="scan'208";a="351297091"
Received: from chang-linux-3.sc.intel.com ([172.25.66.175])
  by FMSMGA003.fm.intel.com with ESMTP; 01 Oct 2020 13:42:53 -0700
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     tglx@linutronix.de, mingo@kernel.org, bp@suse.de, luto@kernel.org,
        x86@kernel.org
Cc:     len.brown@intel.com, dave.hansen@intel.com, jing2.liu@intel.com,
        ravi.v.shankar@intel.com, linux-kernel@vger.kernel.org,
        chang.seok.bae@intel.com, linux-kselftest@vger.kernel.org
Subject: [RFC PATCH 21/22] selftest/x86/amx: Include test cases for the AMX state management
Date:   Thu,  1 Oct 2020 13:39:12 -0700
Message-Id: <20201001203913.9125-22-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201001203913.9125-1-chang.seok.bae@intel.com>
References: <20201001203913.9125-1-chang.seok.bae@intel.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This selftest exercises the kernel's ability to inherit and context switch
AMX state, by verifying that they retain unique data when creating a child
process and between multiple threads.

Also, ptrace() is used to insert AMX state into existing threads -- both
before and after the existing thread has initialized its AMX state.

For the signal handling path, verify in the signal handler that the signal
frame either include or exclude AMX data -- depending on if the signaled
thread has initialized AMX state.

Collect the test cases of validating those operations together, as they
share some common setup for the AMX state.

These test cases do not depend on AMX compiler support, as they employ
user-space-XSAVE directly to access AMX state.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Reviewed-by: Len Brown <len.brown@intel.com>
Cc: x86@kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org
---
 tools/testing/selftests/x86/Makefile |   2 +-
 tools/testing/selftests/x86/amx.c    | 736 +++++++++++++++++++++++++++
 2 files changed, 737 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/x86/amx.c

diff --git a/tools/testing/selftests/x86/Makefile b/tools/testing/selftests/x86/Makefile
index e0c52e5ab49e..6f6e6cabca69 100644
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
index 000000000000..bf766b22cf77
--- /dev/null
+++ b/tools/testing/selftests/x86/amx.c
@@ -0,0 +1,736 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#define _GNU_SOURCE
+#include <err.h>
+#include <elf.h>
+#include <pthread.h>
+#include <sched.h>
+#include <signal.h>
+#include <stdio.h>
+#include <string.h>
+#include <stdbool.h>
+#include <stdint.h>
+#include <stdlib.h>
+#include <time.h>
+#include <malloc.h>
+#include <unistd.h>
+#include <ucontext.h>
+
+#include <linux/futex.h>
+
+#include <sys/ipc.h>
+#include <sys/mman.h>
+#include <sys/ptrace.h>
+#include <sys/shm.h>
+#include <sys/signal.h>
+#include <sys/syscall.h>
+#include <sys/time.h>
+#include <sys/types.h>
+#include <sys/wait.h>
+#include <sys/uio.h>
+#include <sys/ucontext.h>
+
+#include <x86intrin.h>
+
+#ifndef __x86_64__
+# error This test is 64-bit only
+#endif
+
+typedef uint8_t u8;
+typedef uint16_t u16;
+typedef uint32_t u32;
+typedef uint64_t u64;
+
+#define PAGE_SIZE			(1 << 12)
+
+#define NUM_TILES			8
+#define TILE_SIZE			1024
+#define XSAVE_SIZE			((NUM_TILES * TILE_SIZE) + PAGE_SIZE)
+
+struct xsave_data {
+	u8 area[XSAVE_SIZE];
+} __attribute__((aligned(64)));
+
+/* Tile configuration associated: */
+#define MAX_TILES			16
+#define RESERVED_BYTES			14
+
+struct tile_config {
+	u8  palette_id;
+	u8  start_row;
+	u8  reserved[RESERVED_BYTES];
+	u16 colsb[MAX_TILES];
+	u8  rows[MAX_TILES];
+};
+
+struct tile_data {
+	u8 data[NUM_TILES * TILE_SIZE];
+};
+
+static inline u64 __xgetbv(u32 index)
+{
+	u32 eax, edx;
+
+	asm volatile(".byte 0x0f,0x01,0xd0"
+		     : "=a" (eax), "=d" (edx)
+		     : "c" (index));
+	return eax + ((u64)edx << 32);
+}
+
+static inline void __cpuid(u32 *eax, u32 *ebx, u32 *ecx, u32 *edx)
+{
+	asm volatile("cpuid;"
+		     : "=a" (*eax), "=b" (*ebx), "=c" (*ecx), "=d" (*edx)
+		     : "0" (*eax), "2" (*ecx));
+}
+
+/* Load tile configuration */
+static inline void __ldtilecfg(void *cfg)
+{
+	asm volatile(".byte 0xc4,0xe2,0x78,0x49,0x00"
+		     : : "a"(cfg));
+}
+
+/* Load tile data to %tmm0 register only */
+static inline void __tileloadd(void *tile)
+{
+	asm volatile(".byte 0xc4,0xe2,0x7b,0x4b,0x04,0x10"
+		     : : "a"(tile), "d"(0));
+}
+
+/* Save extended states */
+static inline void __xsave(void *area, u32 lo, u32 hi)
+{
+	asm volatile(".byte 0x48,0x0f,0xae,0x27"
+		     : : "D" (area), "a" (lo), "d" (hi)
+		     : "memory");
+}
+
+/* Restore extended states */
+static inline void __xrstor(void *area, u32 lo, u32 hi)
+{
+	asm volatile(".byte 0x48,0x0f,0xae,0x2f"
+		     : : "D" (area), "a" (lo), "d" (hi));
+}
+
+/* Release tile states to init values */
+static inline void __tilerelease(void)
+{
+	asm volatile(".byte 0xc4, 0xe2, 0x78, 0x49, 0xc0" ::);
+}
+
+/* Hardware info check: */
+
+static inline bool check_xsave_supports_xtile(void)
+{
+	u32 eax, ebx, ecx, edx;
+	bool available = false;
+
+#define XSAVE_CPUID		0x1
+#define XSAVE_ECX_BIT		26
+#define XFEATURE_XTILE_CFG	17
+#define XFEATURE_XTILE_DATA	18
+#define XFEATURE_MASK_XTILE	((1 << XFEATURE_XTILE_DATA) | \
+				(1 << XFEATURE_XTILE_CFG))
+
+	eax = XSAVE_CPUID;
+	ecx = 0;
+
+	__cpuid(&eax, &ebx, &ecx, &edx);
+	if (!(ecx & (1 << XSAVE_ECX_BIT)))
+		return available;
+
+	if (__xgetbv(0) & XFEATURE_MASK_XTILE)
+		available = true;
+
+	return available;
+}
+
+struct xtile_hwinfo {
+	struct {
+		u16 bytes_per_tile;
+		u16 bytes_per_row;
+		u16 max_names;
+		u16 max_rows;
+	} spec;
+
+	struct {
+		u32 offset;
+		u32 size;
+	} xsave;
+};
+
+static struct xtile_hwinfo xtile;
+
+static bool __enum_xtile_config(void)
+{
+	u32 eax, ebx, ecx, edx;
+	u16 bytes_per_tile;
+	bool valid = false;
+
+#define TILE_CPUID			0x1d
+#define TILE_PALETTE_CPUID_SUBLEAVE	0x1
+
+	eax = TILE_CPUID;
+	ecx = TILE_PALETTE_CPUID_SUBLEAVE;
+
+	__cpuid(&eax, &ebx, &ecx, &edx);
+	if (!eax || !ebx || !ecx)
+		return valid;
+
+	xtile.spec.max_names = ebx >> 16;
+	if (xtile.spec.max_names < NUM_TILES)
+		return valid;
+
+	bytes_per_tile = eax >> 16;
+	if (bytes_per_tile < TILE_SIZE)
+		return valid;
+
+	xtile.spec.bytes_per_row = ebx;
+	xtile.spec.max_rows = ecx;
+	valid = true;
+
+	return valid;
+}
+
+static bool __enum_xsave_tile(void)
+{
+	u32 eax, ebx, ecx, edx;
+	bool valid = false;
+
+#define XSTATE_CPUID			0xd
+#define XSTATE_USER_STATE_SUBLEAVE	0x0
+
+	eax = XSTATE_CPUID;
+	ecx = XFEATURE_XTILE_DATA;
+
+	__cpuid(&eax, &ebx, &ecx, &edx);
+	if (!eax || !ebx)
+		return valid;
+
+	xtile.xsave.offset = ebx;
+	xtile.xsave.size = eax;
+	valid = true;
+
+	return valid;
+}
+
+static bool __check_xsave_size(void)
+{
+	u32 eax, ebx, ecx, edx;
+	bool valid = false;
+
+	eax = XSTATE_CPUID;
+	ecx = XSTATE_USER_STATE_SUBLEAVE;
+
+	__cpuid(&eax, &ebx, &ecx, &edx);
+	if (ebx && ebx <= XSAVE_SIZE)
+		valid = true;
+
+	return valid;
+}
+
+/*
+ * Check the hardware-provided tile state info and cross-check it with the
+ * hard-coded values: XSAVE_SIZE, NUM_TILES, and TILE_SIZE.
+ */
+static int check_xtile_hwinfo(void)
+{
+	bool success = false;
+
+	if (!__check_xsave_size())
+		return success;
+
+	if (!__enum_xsave_tile())
+		return success;
+
+	if (!__enum_xtile_config())
+		return success;
+
+	if (sizeof(struct tile_data) >= xtile.xsave.size)
+		success = true;
+
+	return success;
+}
+
+/* The helpers for managing XSAVE area and tile states: */
+
+/* Use the uncompacted format without 'init optimization' */
+static void save_xdata(void *data)
+{
+	__xsave(data, -1, -1);
+}
+
+static void restore_xdata(void *data)
+{
+	__xrstor(data, -1, -1);
+}
+
+static inline u64 __get_xsave_xstate_bv(void *data)
+{
+#define XSAVE_HDR_OFFSET	512
+	return *(u64 *)(data + XSAVE_HDR_OFFSET);
+}
+
+static void set_tilecfg(struct tile_config *cfg)
+{
+	int i;
+
+	memset(cfg, 0, sizeof(*cfg));
+	/* The first implementation has one significant palette with id 1 */
+	cfg->palette_id = 1;
+	for (i = 0; i < xtile.spec.max_names; i++) {
+		cfg->colsb[i] = xtile.spec.bytes_per_row;
+		cfg->rows[i] = xtile.spec.max_rows;
+	}
+}
+
+static void load_tilecfg(struct tile_config *cfg)
+{
+	__ldtilecfg(cfg);
+}
+
+static void make_tiles(void *tiles)
+{
+	u32 iterations = xtile.xsave.size / sizeof(u32);
+	static u32 value = 1;
+	u32 *ptr = tiles;
+	int i;
+
+	for (i = 0, ptr = tiles; i < iterations; i++, ptr++)
+		*ptr  = value;
+	value++;
+}
+
+/*
+ * Initialize the XSAVE area:
+ *
+ * Make sure tile configuration loaded already. Load limited tile data (%tmm0 only)
+ * and save all the states. XSAVE area is ready to complete tile data.
+ */
+static void init_xdata(void *data)
+{
+	struct tile_data tiles;
+
+	make_tiles(&tiles);
+	__tileloadd(&tiles);
+	__xsave(data, -1, -1);
+}
+
+static inline void *__get_xsave_tile_data_addr(void *data)
+{
+	return data + xtile.xsave.offset;
+}
+
+static void copy_tiles_to_xdata(void *xdata, void *tiles)
+{
+	void *dst = __get_xsave_tile_data_addr(xdata);
+
+	memcpy(dst, tiles, xtile.xsave.size);
+}
+
+static int compare_xdata_tiles(void *xdata, void *tiles)
+{
+	void *tile_data = __get_xsave_tile_data_addr(xdata);
+
+	if (memcmp(tile_data, tiles, xtile.xsave.size))
+		return 1;
+
+	return 0;
+}
+
+static int nerrs, errs;
+
+/* Testing tile data inheritance */
+
+static void test_tile_data_inheritance(void)
+{
+	struct xsave_data xdata;
+	struct tile_data tiles;
+	struct tile_config cfg;
+	pid_t child;
+	int status;
+
+	set_tilecfg(&cfg);
+	load_tilecfg(&cfg);
+	init_xdata(&xdata);
+
+	make_tiles(&tiles);
+	copy_tiles_to_xdata(&xdata, &tiles);
+	restore_xdata(&xdata);
+
+	errs = 0;
+
+	child = fork();
+	if (child < 0)
+		err(1, "fork");
+
+	if (child == 0) {
+		memset(&xdata, 0, sizeof(xdata));
+		save_xdata(&xdata);
+		if (compare_xdata_tiles(&xdata, &tiles)) {
+			printf("[FAIL]\tchild failed to inherit tile data during fork()\n");
+			nerrs++;
+		} else {
+			printf("[OK]\tchild inherited tile data during fork()\n");
+		}
+		_exit(0);
+	}
+	wait(&status);
+}
+
+static void test_fork(void)
+{
+	pid_t child;
+	int status;
+
+	child = fork();
+	if (child < 0)
+		err(1, "fork");
+
+	if (child == 0) {
+		test_tile_data_inheritance();
+		_exit(0);
+	}
+
+	wait(&status);
+}
+
+/* Context switching test */
+
+#define ITERATIONS			10
+#define NUM_THREADS			5
+
+struct futex_info {
+	int current;
+	int next;
+	int *futex;
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
+static void *check_tiles(void *info)
+{
+	struct futex_info *finfo = (struct futex_info *)info;
+	struct xsave_data xdata;
+	struct tile_data tiles;
+	struct tile_config cfg;
+	int i;
+
+	set_tilecfg(&cfg);
+	load_tilecfg(&cfg);
+	init_xdata(&xdata);
+
+	make_tiles(&tiles);
+	copy_tiles_to_xdata(&xdata, &tiles);
+	restore_xdata(&xdata);
+
+	for (i = 0; i < ITERATIONS; i++) {
+		command_wait(finfo, get_iterative_value(finfo->current));
+
+		memset(&xdata, 0, sizeof(xdata));
+		save_xdata(&xdata);
+		errs += compare_xdata_tiles(&xdata, &tiles);
+
+		make_tiles(&tiles);
+		copy_tiles_to_xdata(&xdata, &tiles);
+		restore_xdata(&xdata);
+
+		command_wake(finfo, get_iterative_value(finfo->next));
+	}
+
+	command_wait(finfo, get_endpoint_value(finfo->current));
+	__tilerelease();
+	return NULL;
+}
+
+static int create_children(int num, struct futex_info *finfo)
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
+		if (pthread_create(&thread, NULL, check_tiles, &finfo[i])) {
+			err(1, "pthread_create");
+			return 1;
+		}
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
+	printf("[RUN]\t%u context switches of tile states in %d threads\n",
+	       ITERATIONS * NUM_THREADS, NUM_THREADS);
+
+	errs = 0;
+
+	CPU_ZERO(&cpuset);
+	CPU_SET(0, &cpuset);
+	if (sched_setaffinity(0, sizeof(cpuset), &cpuset) != 0)
+		err(1, "sched_setaffinity to CPU 0");
+
+	finfo = malloc(sizeof(*finfo) * NUM_THREADS);
+
+	if (create_children(NUM_THREADS, finfo))
+		return;
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
+		printf("[FAIL]\t%u incorrect tile states\n", errs);
+		nerrs += errs;
+		return;
+	}
+
+	printf("[OK]\tall tile states are correct\n");
+}
+
+/* Ptrace test */
+
+static inline long get_tile_state(pid_t child, struct iovec *iov)
+{
+	return ptrace(PTRACE_GETREGSET, child, (u32)NT_X86_XSTATE, iov);
+}
+
+static inline long set_tile_state(pid_t child, struct iovec *iov)
+{
+	return ptrace(PTRACE_SETREGSET, child, (u32)NT_X86_XSTATE, iov);
+}
+
+static int write_tile_state(bool load_tile, pid_t child)
+{
+	struct xsave_data xdata;
+	struct tile_data tiles;
+	struct iovec iov;
+
+	iov.iov_base = &xdata;
+	iov.iov_len = sizeof(xdata);
+
+	if (get_tile_state(child, &iov))
+		err(1, "PTRACE_GETREGSET");
+
+	make_tiles(&tiles);
+	copy_tiles_to_xdata(&xdata, &tiles);
+	if (set_tile_state(child, &iov))
+		err(1, "PTRACE_SETREGSET");
+
+	memset(&xdata, 0, sizeof(xdata));
+	if (get_tile_state(child, &iov))
+		err(1, "PTRACE_GETREGSET");
+
+	if (!load_tile)
+		memset(&tiles, 0, sizeof(tiles));
+
+	return compare_xdata_tiles(&xdata, &tiles);
+}
+
+static void test_tile_state_write(bool load_tile)
+{
+	pid_t child;
+	int status;
+
+	child = fork();
+	if (child < 0)
+		err(1, "fork");
+
+	if (child == 0) {
+		printf("[RUN]\tPtrace-induced tile state write, ");
+		printf("%s tile data loaded\n", load_tile ? "with" : "without");
+
+		if (ptrace(PTRACE_TRACEME, 0, NULL, NULL))
+			err(1, "PTRACE_TRACEME");
+
+		if (load_tile) {
+			struct tile_config cfg;
+			struct tile_data tiles;
+
+			set_tilecfg(&cfg);
+			load_tilecfg(&cfg);
+			make_tiles(&tiles);
+			/* Load only %tmm0 but inducing the #NM */
+			__tileloadd(&tiles);
+		}
+
+		raise(SIGTRAP);
+		_exit(0);
+	}
+
+	do {
+		wait(&status);
+	} while (WSTOPSIG(status) != SIGTRAP);
+
+	errs = write_tile_state(load_tile, child);
+	if (errs) {
+		nerrs++;
+		printf("[FAIL]\t%s write\n", load_tile ? "incorrect" : "unexpected");
+	} else {
+		printf("[OK]\t%s write\n", load_tile ? "correct" : "no");
+	}
+
+	ptrace(PTRACE_DETACH, child, NULL, NULL);
+	wait(&status);
+}
+
+static void test_ptrace(void)
+{
+	bool ptracee_loads_tiles;
+
+	ptracee_loads_tiles = true;
+	test_tile_state_write(ptracee_loads_tiles);
+
+	ptracee_loads_tiles = false;
+	test_tile_state_write(ptracee_loads_tiles);
+}
+
+/* Signal handling test */
+
+static int sigtrapped;
+struct tile_data sig_tiles, sighdl_tiles;
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
+static void sighandler(int sig, siginfo_t *info, void *ctx_void)
+{
+	ucontext_t *uctxt = (ucontext_t *)ctx_void;
+	struct xsave_data xdata;
+	struct tile_config cfg;
+	struct tile_data tiles;
+	u64 header;
+
+	header = __get_xsave_xstate_bv((void *)uctxt->uc_mcontext.fpregs);
+
+	if (header & (1 << XFEATURE_XTILE_DATA))
+		printf("[FAIL]\ttile data was written in sigframe\n");
+	else
+		printf("[OK]\ttile data was skipped in sigframe\n");
+
+	set_tilecfg(&cfg);
+	load_tilecfg(&cfg);
+	init_xdata(&xdata);
+
+	make_tiles(&tiles);
+	copy_tiles_to_xdata(&xdata, &tiles);
+	restore_xdata(&xdata);
+
+	save_xdata(&xdata);
+	if (compare_xdata_tiles(&xdata, &tiles))
+		err(1, "tile load file");
+
+	printf("\tsignal handler: load tile data\n");
+
+	sigtrapped = sig;
+}
+
+static void test_signal_handling(void)
+{
+	struct xsave_data xdata = { 0 };
+	struct tile_data tiles = { 0 };
+
+	clearhandler(SIGTRAP);
+	sethandler(SIGTRAP, sighandler, 1);
+	sigtrapped = 0;
+
+	printf("[RUN]\tCheck tile state management in handling signal\n");
+
+	printf("\tbefore signal: initial tile data state\n");
+
+	raise(SIGTRAP);
+
+	if (sigtrapped == 0)
+		err(1, "sigtrap");
+
+	save_xdata(&xdata);
+	if (compare_xdata_tiles(&xdata, &tiles)) {
+		printf("[FAIL]\ttile data was not loaded at sigreturn\n");
+		nerrs++;
+	} else {
+		printf("[OK]\ttile data was re-initialized at sigreturn\n");
+	}
+}
+
+int main(void)
+{
+	/* Check hardware availability at first */
+
+	if (!check_xsave_supports_xtile()) {
+		printf("\tTile state is not supported in the XSAVE.\n");
+		return 0;
+	}
+
+	if (!check_xtile_hwinfo()) {
+		printf("\tAvailable tile state size is insufficient to test.\n");
+		return 0;
+	}
+
+	nerrs = 0;
+
+	test_fork();
+	test_context_switch();
+	test_ptrace();
+	test_signal_handling();
+
+	return nerrs ? 1 : 0;
+}
-- 
2.17.1

