Return-Path: <linux-kselftest+bounces-23008-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 742E79E8F4B
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Dec 2024 10:52:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 478EF165459
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Dec 2024 09:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF3F421882F;
	Mon,  9 Dec 2024 09:51:04 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7BB721660D;
	Mon,  9 Dec 2024 09:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733737864; cv=none; b=fQmoKfSwZU1Co7vc4MjmLA4UACoV7QMBT2zmgz02d/Q7ZX53WhDNdHFQYxPmyh82UvEk0aFenKYqQ5SHlSGYBE6oy5537k/E5aCTnQdPpQnXE9iNzzBellhvlsVXReIP8794zRhhzMBabc6vFc+iqlTgEZILcQW4O74Syy7/6cY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733737864; c=relaxed/simple;
	bh=kloGf7dWb3dSk8C59L8QZnkHYIVl3/9vv5Ep1YXXC7s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ShZ7TyM+u9xieotvzwMftBto9DhjK3YXFVVYWc/PRe4o4bw/pImrzZZCxDe2zH4+Z3E3QiWUa6ZuUb64QtP8dakf7Q0SHd/rZBIrxef8Tr0+GZZgDmA6tSoQzB79473KEeAVCWB5EjxW/wY1RYkNAEiLp1uOxesSkx+RqvgDT5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 623EB113E;
	Mon,  9 Dec 2024 01:51:30 -0800 (PST)
Received: from e123572-lin.arm.com (e123572-lin.cambridge.arm.com [10.1.194.54])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3A0FD3F720;
	Mon,  9 Dec 2024 01:51:00 -0800 (PST)
From: Kevin Brodsky <kevin.brodsky@arm.com>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	Kevin Brodsky <kevin.brodsky@arm.com>,
	akpm@linux-foundation.org,
	aruna.ramakrishna@oracle.com,
	catalin.marinas@arm.com,
	dave.hansen@linux.intel.com,
	joey.gouly@arm.com,
	keith.lucas@oracle.com,
	ryan.roberts@arm.com,
	shuah@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org,
	x86@kernel.org
Subject: [PATCH 10/14] selftests/mm: Ensure non-global pkey symbols are marked static
Date: Mon,  9 Dec 2024 09:50:15 +0000
Message-ID: <20241209095019.1732120-11-kevin.brodsky@arm.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241209095019.1732120-1-kevin.brodsky@arm.com>
References: <20241209095019.1732120-1-kevin.brodsky@arm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The pkey tests define a whole lot of functions and some global
variables. A few are truly global (declared in pkey-helpers.h), but
the majority are file-scoped. Make sure those are labelled static.

Some of the pkey_{access,write}_{allow,deny} helpers are not called,
or only called when building for some architectures. Mark them
__maybe_unused to suppress compiler warnings.

Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
---
 tools/testing/selftests/mm/pkey-helpers.h     |   3 +
 .../selftests/mm/pkey_sighandler_tests.c      |   6 +-
 tools/testing/selftests/mm/protection_keys.c  | 132 +++++++++---------
 3 files changed, 72 insertions(+), 69 deletions(-)

diff --git a/tools/testing/selftests/mm/pkey-helpers.h b/tools/testing/selftests/mm/pkey-helpers.h
index 7604cc66ef0e..6f0ab7b42738 100644
--- a/tools/testing/selftests/mm/pkey-helpers.h
+++ b/tools/testing/selftests/mm/pkey-helpers.h
@@ -83,6 +83,9 @@ extern void abort_hooks(void);
 #ifndef noinline
 # define noinline __attribute__((noinline))
 #endif
+#ifndef __maybe_unused
+# define __maybe_unused __attribute__((__unused__))
+#endif
 
 int sys_pkey_alloc(unsigned long flags, unsigned long init_val);
 int sys_pkey_free(unsigned long pkey);
diff --git a/tools/testing/selftests/mm/pkey_sighandler_tests.c b/tools/testing/selftests/mm/pkey_sighandler_tests.c
index d18e38b19792..e1aaeb65cfae 100644
--- a/tools/testing/selftests/mm/pkey_sighandler_tests.c
+++ b/tools/testing/selftests/mm/pkey_sighandler_tests.c
@@ -32,9 +32,9 @@
 
 #define STACK_SIZE PTHREAD_STACK_MIN
 
-pthread_mutex_t mutex = PTHREAD_MUTEX_INITIALIZER;
-pthread_cond_t cond = PTHREAD_COND_INITIALIZER;
-siginfo_t siginfo = {0};
+static pthread_mutex_t mutex = PTHREAD_MUTEX_INITIALIZER;
+static pthread_cond_t cond = PTHREAD_COND_INITIALIZER;
+static siginfo_t siginfo = {0};
 
 /*
  * We need to use inline assembly instead of glibc's syscall because glibc's
diff --git a/tools/testing/selftests/mm/protection_keys.c b/tools/testing/selftests/mm/protection_keys.c
index 82ece325b70c..f43cf3b75d8e 100644
--- a/tools/testing/selftests/mm/protection_keys.c
+++ b/tools/testing/selftests/mm/protection_keys.c
@@ -61,7 +61,7 @@ noinline int read_ptr(int *ptr)
 	return *ptr;
 }
 
-void cat_into_file(char *str, char *file)
+static void cat_into_file(char *str, char *file)
 {
 	int fd = open(file, O_RDWR);
 	int ret;
@@ -88,7 +88,7 @@ void cat_into_file(char *str, char *file)
 
 #if CONTROL_TRACING > 0
 static int warned_tracing;
-int tracing_root_ok(void)
+static int tracing_root_ok(void)
 {
 	if (geteuid() != 0) {
 		if (!warned_tracing)
@@ -101,7 +101,7 @@ int tracing_root_ok(void)
 }
 #endif
 
-void tracing_on(void)
+static void tracing_on(void)
 {
 #if CONTROL_TRACING > 0
 #define TRACEDIR "/sys/kernel/tracing"
@@ -125,7 +125,7 @@ void tracing_on(void)
 #endif
 }
 
-void tracing_off(void)
+static void tracing_off(void)
 {
 #if CONTROL_TRACING > 0
 	if (!tracing_root_ok())
@@ -159,7 +159,7 @@ __attribute__((__aligned__(65536)))
 #else
 __attribute__((__aligned__(PAGE_SIZE)))
 #endif
-void lots_o_noops_around_write(int *write_to_me)
+static void lots_o_noops_around_write(int *write_to_me)
 {
 	dprintf3("running %s()\n", __func__);
 	__page_o_noops();
@@ -170,7 +170,7 @@ void lots_o_noops_around_write(int *write_to_me)
 	dprintf3("%s() done\n", __func__);
 }
 
-void dump_mem(void *dumpme, int len_bytes)
+static void dump_mem(void *dumpme, int len_bytes)
 {
 	char *c = (void *)dumpme;
 	int i;
@@ -213,7 +213,7 @@ static int hw_pkey_set(int pkey, unsigned long rights, unsigned long flags)
 	return 0;
 }
 
-void pkey_disable_set(int pkey, int flags)
+static void pkey_disable_set(int pkey, int flags)
 {
 	unsigned long syscall_flags = 0;
 	int ret;
@@ -251,7 +251,7 @@ void pkey_disable_set(int pkey, int flags)
 		pkey, flags);
 }
 
-void pkey_disable_clear(int pkey, int flags)
+static void pkey_disable_clear(int pkey, int flags)
 {
 	unsigned long syscall_flags = 0;
 	int ret;
@@ -277,19 +277,19 @@ void pkey_disable_clear(int pkey, int flags)
 			pkey, read_pkey_reg());
 }
 
-void pkey_write_allow(int pkey)
+__maybe_unused static void pkey_write_allow(int pkey)
 {
 	pkey_disable_clear(pkey, PKEY_DISABLE_WRITE);
 }
-void pkey_write_deny(int pkey)
+__maybe_unused static void pkey_write_deny(int pkey)
 {
 	pkey_disable_set(pkey, PKEY_DISABLE_WRITE);
 }
-void pkey_access_allow(int pkey)
+__maybe_unused static void pkey_access_allow(int pkey)
 {
 	pkey_disable_clear(pkey, PKEY_DISABLE_ACCESS);
 }
-void pkey_access_deny(int pkey)
+__maybe_unused static void pkey_access_deny(int pkey)
 {
 	pkey_disable_set(pkey, PKEY_DISABLE_ACCESS);
 }
@@ -307,9 +307,9 @@ static char *si_code_str(int si_code)
 	return "UNKNOWN";
 }
 
-int pkey_faults;
-int last_si_pkey = -1;
-void signal_handler(int signum, siginfo_t *si, void *vucontext)
+static int pkey_faults;
+static int last_si_pkey = -1;
+static void signal_handler(int signum, siginfo_t *si, void *vucontext)
 {
 	ucontext_t *uctxt = vucontext;
 	int trapno;
@@ -403,14 +403,14 @@ void signal_handler(int signum, siginfo_t *si, void *vucontext)
 	dprint_in_signal = 0;
 }
 
-void sig_chld(int x)
+static void sig_chld(int x)
 {
 	dprint_in_signal = 1;
 	dprintf2("[%d] SIGCHLD: %d\n", getpid(), x);
 	dprint_in_signal = 0;
 }
 
-void setup_sigsegv_handler(void)
+static void setup_sigsegv_handler(void)
 {
 	int r, rs;
 	struct sigaction newact;
@@ -436,13 +436,13 @@ void setup_sigsegv_handler(void)
 	pkey_assert(r == 0);
 }
 
-void setup_handlers(void)
+static void setup_handlers(void)
 {
 	signal(SIGCHLD, &sig_chld);
 	setup_sigsegv_handler();
 }
 
-pid_t fork_lazy_child(void)
+static pid_t fork_lazy_child(void)
 {
 	pid_t forkret;
 
@@ -488,7 +488,7 @@ int sys_pkey_alloc(unsigned long flags, unsigned long init_val)
 	return ret;
 }
 
-int alloc_pkey(void)
+static int alloc_pkey(void)
 {
 	int ret;
 	unsigned long init_val = 0x0;
@@ -546,7 +546,7 @@ int sys_pkey_free(unsigned long pkey)
  * not cleared.  This ensures we get lots of random bit sets
  * and clears on the vma and pte pkey bits.
  */
-int alloc_random_pkey(void)
+static int alloc_random_pkey(void)
 {
 	int max_nr_pkey_allocs;
 	int ret;
@@ -629,7 +629,7 @@ struct pkey_malloc_record {
 };
 struct pkey_malloc_record *pkey_malloc_records;
 struct pkey_malloc_record *pkey_last_malloc_record;
-long nr_pkey_malloc_records;
+static long nr_pkey_malloc_records;
 void record_pkey_malloc(void *ptr, long size, int prot)
 {
 	long i;
@@ -667,7 +667,7 @@ void record_pkey_malloc(void *ptr, long size, int prot)
 	nr_pkey_malloc_records++;
 }
 
-void free_pkey_malloc(void *ptr)
+static void free_pkey_malloc(void *ptr)
 {
 	long i;
 	int ret;
@@ -694,8 +694,7 @@ void free_pkey_malloc(void *ptr)
 	pkey_assert(false);
 }
 
-
-void *malloc_pkey_with_mprotect(long size, int prot, u16 pkey)
+static void *malloc_pkey_with_mprotect(long size, int prot, u16 pkey)
 {
 	void *ptr;
 	int ret;
@@ -715,7 +714,7 @@ void *malloc_pkey_with_mprotect(long size, int prot, u16 pkey)
 	return ptr;
 }
 
-void *malloc_pkey_anon_huge(long size, int prot, u16 pkey)
+static void *malloc_pkey_anon_huge(long size, int prot, u16 pkey)
 {
 	int ret;
 	void *ptr;
@@ -745,10 +744,10 @@ void *malloc_pkey_anon_huge(long size, int prot, u16 pkey)
 	return ptr;
 }
 
-int hugetlb_setup_ok;
+static int hugetlb_setup_ok;
 #define SYSFS_FMT_NR_HUGE_PAGES "/sys/kernel/mm/hugepages/hugepages-%ldkB/nr_hugepages"
 #define GET_NR_HUGE_PAGES 10
-void setup_hugetlbfs(void)
+static void setup_hugetlbfs(void)
 {
 	int err;
 	int fd;
@@ -796,7 +795,7 @@ void setup_hugetlbfs(void)
 	hugetlb_setup_ok = 1;
 }
 
-void *malloc_pkey_hugetlb(long size, int prot, u16 pkey)
+static void *malloc_pkey_hugetlb(long size, int prot, u16 pkey)
 {
 	void *ptr;
 	int flags = MAP_ANONYMOUS|MAP_PRIVATE|MAP_HUGETLB;
@@ -817,7 +816,7 @@ void *malloc_pkey_hugetlb(long size, int prot, u16 pkey)
 	return ptr;
 }
 
-void *(*pkey_malloc[])(long size, int prot, u16 pkey) = {
+static void *(*pkey_malloc[])(long size, int prot, u16 pkey) = {
 
 	malloc_pkey_with_mprotect,
 	malloc_pkey_with_mprotect_subpage,
@@ -825,7 +824,7 @@ void *(*pkey_malloc[])(long size, int prot, u16 pkey) = {
 	malloc_pkey_hugetlb
 };
 
-void *malloc_pkey(long size, int prot, u16 pkey)
+static void *malloc_pkey(long size, int prot, u16 pkey)
 {
 	void *ret;
 	static int malloc_type;
@@ -855,7 +854,7 @@ void *malloc_pkey(long size, int prot, u16 pkey)
 	return ret;
 }
 
-int last_pkey_faults;
+static int last_pkey_faults;
 #define UNKNOWN_PKEY -2
 void expected_pkey_fault(int pkey)
 {
@@ -897,9 +896,9 @@ void expected_pkey_fault(int pkey)
 	pkey_assert(last_pkey_faults == pkey_faults);		\
 } while (0)
 
-int test_fds[10] = { -1 };
-int nr_test_fds;
-void __save_test_fd(int fd)
+static int test_fds[10] = { -1 };
+static int nr_test_fds;
+static void __save_test_fd(int fd)
 {
 	pkey_assert(fd >= 0);
 	pkey_assert(nr_test_fds < ARRAY_SIZE(test_fds));
@@ -907,14 +906,14 @@ void __save_test_fd(int fd)
 	nr_test_fds++;
 }
 
-int get_test_read_fd(void)
+static int get_test_read_fd(void)
 {
 	int test_fd = open("/etc/passwd", O_RDONLY);
 	__save_test_fd(test_fd);
 	return test_fd;
 }
 
-void close_test_fds(void)
+static void close_test_fds(void)
 {
 	int i;
 
@@ -927,7 +926,7 @@ void close_test_fds(void)
 	nr_test_fds = 0;
 }
 
-void test_pkey_alloc_free_attach_pkey0(int *ptr, u16 pkey)
+static void test_pkey_alloc_free_attach_pkey0(int *ptr, u16 pkey)
 {
 	int i, err;
 	int max_nr_pkey_allocs;
@@ -979,7 +978,7 @@ void test_pkey_alloc_free_attach_pkey0(int *ptr, u16 pkey)
 	pkey_assert(!err);
 }
 
-void test_read_of_write_disabled_region(int *ptr, u16 pkey)
+static void test_read_of_write_disabled_region(int *ptr, u16 pkey)
 {
 	int ptr_contents;
 
@@ -989,7 +988,7 @@ void test_read_of_write_disabled_region(int *ptr, u16 pkey)
 	dprintf1("*ptr: %d\n", ptr_contents);
 	dprintf1("\n");
 }
-void test_read_of_access_disabled_region(int *ptr, u16 pkey)
+static void test_read_of_access_disabled_region(int *ptr, u16 pkey)
 {
 	int ptr_contents;
 
@@ -1001,7 +1000,7 @@ void test_read_of_access_disabled_region(int *ptr, u16 pkey)
 	expected_pkey_fault(pkey);
 }
 
-void test_read_of_access_disabled_region_with_page_already_mapped(int *ptr,
+static void test_read_of_access_disabled_region_with_page_already_mapped(int *ptr,
 		u16 pkey)
 {
 	int ptr_contents;
@@ -1018,7 +1017,7 @@ void test_read_of_access_disabled_region_with_page_already_mapped(int *ptr,
 	expected_pkey_fault(pkey);
 }
 
-void test_write_of_write_disabled_region_with_page_already_mapped(int *ptr,
+static void test_write_of_write_disabled_region_with_page_already_mapped(int *ptr,
 		u16 pkey)
 {
 	*ptr = __LINE__;
@@ -1029,14 +1028,14 @@ void test_write_of_write_disabled_region_with_page_already_mapped(int *ptr,
 	expected_pkey_fault(pkey);
 }
 
-void test_write_of_write_disabled_region(int *ptr, u16 pkey)
+static void test_write_of_write_disabled_region(int *ptr, u16 pkey)
 {
 	dprintf1("disabling write access to PKEY[%02d], doing write\n", pkey);
 	pkey_write_deny(pkey);
 	*ptr = __LINE__;
 	expected_pkey_fault(pkey);
 }
-void test_write_of_access_disabled_region(int *ptr, u16 pkey)
+static void test_write_of_access_disabled_region(int *ptr, u16 pkey)
 {
 	dprintf1("disabling access to PKEY[%02d], doing write\n", pkey);
 	pkey_access_deny(pkey);
@@ -1044,7 +1043,7 @@ void test_write_of_access_disabled_region(int *ptr, u16 pkey)
 	expected_pkey_fault(pkey);
 }
 
-void test_write_of_access_disabled_region_with_page_already_mapped(int *ptr,
+static void test_write_of_access_disabled_region_with_page_already_mapped(int *ptr,
 			u16 pkey)
 {
 	*ptr = __LINE__;
@@ -1055,7 +1054,7 @@ void test_write_of_access_disabled_region_with_page_already_mapped(int *ptr,
 	expected_pkey_fault(pkey);
 }
 
-void test_kernel_write_of_access_disabled_region(int *ptr, u16 pkey)
+static void test_kernel_write_of_access_disabled_region(int *ptr, u16 pkey)
 {
 	int ret;
 	int test_fd = get_test_read_fd();
@@ -1067,7 +1066,8 @@ void test_kernel_write_of_access_disabled_region(int *ptr, u16 pkey)
 	dprintf1("read ret: %d\n", ret);
 	pkey_assert(ret);
 }
-void test_kernel_write_of_write_disabled_region(int *ptr, u16 pkey)
+
+static void test_kernel_write_of_write_disabled_region(int *ptr, u16 pkey)
 {
 	int ret;
 	int test_fd = get_test_read_fd();
@@ -1080,7 +1080,7 @@ void test_kernel_write_of_write_disabled_region(int *ptr, u16 pkey)
 	pkey_assert(ret);
 }
 
-void test_kernel_gup_of_access_disabled_region(int *ptr, u16 pkey)
+static void test_kernel_gup_of_access_disabled_region(int *ptr, u16 pkey)
 {
 	int pipe_ret, vmsplice_ret;
 	struct iovec iov;
@@ -1102,7 +1102,7 @@ void test_kernel_gup_of_access_disabled_region(int *ptr, u16 pkey)
 	close(pipe_fds[1]);
 }
 
-void test_kernel_gup_write_to_write_disabled_region(int *ptr, u16 pkey)
+static void test_kernel_gup_write_to_write_disabled_region(int *ptr, u16 pkey)
 {
 	int ignored = 0xdada;
 	int futex_ret;
@@ -1120,7 +1120,7 @@ void test_kernel_gup_write_to_write_disabled_region(int *ptr, u16 pkey)
 }
 
 /* Assumes that all pkeys other than 'pkey' are unallocated */
-void test_pkey_syscalls_on_non_allocated_pkey(int *ptr, u16 pkey)
+static void test_pkey_syscalls_on_non_allocated_pkey(int *ptr, u16 pkey)
 {
 	int err;
 	int i;
@@ -1143,7 +1143,7 @@ void test_pkey_syscalls_on_non_allocated_pkey(int *ptr, u16 pkey)
 }
 
 /* Assumes that all pkeys other than 'pkey' are unallocated */
-void test_pkey_syscalls_bad_args(int *ptr, u16 pkey)
+static void test_pkey_syscalls_bad_args(int *ptr, u16 pkey)
 {
 	int err;
 	int bad_pkey = NR_PKEYS+99;
@@ -1153,7 +1153,7 @@ void test_pkey_syscalls_bad_args(int *ptr, u16 pkey)
 	pkey_assert(err);
 }
 
-void become_child(void)
+static void become_child(void)
 {
 	pid_t forkret;
 
@@ -1169,7 +1169,7 @@ void become_child(void)
 }
 
 /* Assumes that all pkeys other than 'pkey' are unallocated */
-void test_pkey_alloc_exhaust(int *ptr, u16 pkey)
+static void test_pkey_alloc_exhaust(int *ptr, u16 pkey)
 {
 	int err;
 	int allocated_pkeys[NR_PKEYS] = {0};
@@ -1236,7 +1236,7 @@ void test_pkey_alloc_exhaust(int *ptr, u16 pkey)
 	}
 }
 
-void arch_force_pkey_reg_init(void)
+static void arch_force_pkey_reg_init(void)
 {
 #if defined(__i386__) || defined(__x86_64__) /* arch */
 	u64 *buf;
@@ -1275,7 +1275,7 @@ void arch_force_pkey_reg_init(void)
  * a long-running test that continually checks the pkey
  * register.
  */
-void test_pkey_init_state(int *ptr, u16 pkey)
+static void test_pkey_init_state(int *ptr, u16 pkey)
 {
 	int err;
 	int allocated_pkeys[NR_PKEYS] = {0};
@@ -1313,7 +1313,7 @@ void test_pkey_init_state(int *ptr, u16 pkey)
  * have to call pkey_alloc() to use it first.  Make sure that it
  * is usable.
  */
-void test_mprotect_with_pkey_0(int *ptr, u16 pkey)
+static void test_mprotect_with_pkey_0(int *ptr, u16 pkey)
 {
 	long size;
 	int prot;
@@ -1337,7 +1337,7 @@ void test_mprotect_with_pkey_0(int *ptr, u16 pkey)
 	mprotect_pkey(ptr, size, prot, pkey);
 }
 
-void test_ptrace_of_child(int *ptr, u16 pkey)
+static void test_ptrace_of_child(int *ptr, u16 pkey)
 {
 	__attribute__((__unused__)) int peek_result;
 	pid_t child_pid;
@@ -1413,7 +1413,7 @@ void test_ptrace_of_child(int *ptr, u16 pkey)
 	free(plain_ptr_unaligned);
 }
 
-void *get_pointer_to_instructions(void)
+static void *get_pointer_to_instructions(void)
 {
 	void *p1;
 
@@ -1434,7 +1434,7 @@ void *get_pointer_to_instructions(void)
 	return p1;
 }
 
-void test_executing_on_unreadable_memory(int *ptr, u16 pkey)
+static void test_executing_on_unreadable_memory(int *ptr, u16 pkey)
 {
 	void *p1;
 	int scratch;
@@ -1466,7 +1466,7 @@ void test_executing_on_unreadable_memory(int *ptr, u16 pkey)
 	pkey_assert(!ret);
 }
 
-void test_implicit_mprotect_exec_only_memory(int *ptr, u16 pkey)
+static void test_implicit_mprotect_exec_only_memory(int *ptr, u16 pkey)
 {
 	void *p1;
 	int scratch;
@@ -1515,7 +1515,7 @@ void test_implicit_mprotect_exec_only_memory(int *ptr, u16 pkey)
 }
 
 #if defined(__i386__) || defined(__x86_64__)
-void test_ptrace_modifies_pkru(int *ptr, u16 pkey)
+static void test_ptrace_modifies_pkru(int *ptr, u16 pkey)
 {
 	u32 new_pkru;
 	pid_t child;
@@ -1638,7 +1638,7 @@ void test_ptrace_modifies_pkru(int *ptr, u16 pkey)
 #endif
 
 #if defined(__aarch64__)
-void test_ptrace_modifies_pkru(int *ptr, u16 pkey)
+static void test_ptrace_modifies_pkru(int *ptr, u16 pkey)
 {
 	pid_t child;
 	int status, ret;
@@ -1715,7 +1715,7 @@ void test_ptrace_modifies_pkru(int *ptr, u16 pkey)
 }
 #endif
 
-void test_mprotect_pkey_on_unsupported_cpu(int *ptr, u16 pkey)
+static void test_mprotect_pkey_on_unsupported_cpu(int *ptr, u16 pkey)
 {
 	int size = PAGE_SIZE;
 	int sret;
@@ -1729,7 +1729,7 @@ void test_mprotect_pkey_on_unsupported_cpu(int *ptr, u16 pkey)
 	pkey_assert(sret < 0);
 }
 
-void (*pkey_tests[])(int *ptr, u16 pkey) = {
+static void (*pkey_tests[])(int *ptr, u16 pkey) = {
 	test_read_of_write_disabled_region,
 	test_read_of_access_disabled_region,
 	test_read_of_access_disabled_region_with_page_already_mapped,
@@ -1755,7 +1755,7 @@ void (*pkey_tests[])(int *ptr, u16 pkey) = {
 #endif
 };
 
-void run_tests_once(void)
+static void run_tests_once(void)
 {
 	int *ptr;
 	int prot = PROT_READ|PROT_WRITE;
@@ -1789,7 +1789,7 @@ void run_tests_once(void)
 	iteration_nr++;
 }
 
-void pkey_setup_shadow(void)
+static void pkey_setup_shadow(void)
 {
 	shadow_pkey_reg = __read_pkey_reg();
 }
-- 
2.47.0


