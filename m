Return-Path: <linux-kselftest+bounces-20962-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BB139B4C72
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Oct 2024 15:46:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 57BEDB235D6
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Oct 2024 14:46:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FDB8191F67;
	Tue, 29 Oct 2024 14:46:12 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE3AE10F9
	for <linux-kselftest@vger.kernel.org>; Tue, 29 Oct 2024 14:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730213172; cv=none; b=C+Pac+5mJtzJPOu0Q4vwYh4maOqmvFFsaNjvaW5/kDoaCIwtC5l6LCTAFG7UMPo7zgasyFsp/hqjG1p8KDTW3tROFrCq3x8lSwoFZzxeWEmCuN8sTcJXtg776Yc7XnezjAZZ5oNUjjobm+eqrKiF6dlTclqiQQ1842lqCf/cGA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730213172; c=relaxed/simple;
	bh=pIWHSMtKgLqaVJexPs+F/xrsDmy7874f0ZQymEe8NlU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fXb9DegiW+OIyuJ39hJh4BGfPKjFxrEN0NmRNxGJbeeAFfAzKwMxpQRZ/B+UgsmuDQuNi8SFJ5wzSDMM9qByONBziriPhYmam61eS0zVrop0XnbSchRv56QDWTNGKFb0wfjdkSyIRkR8NCVvgSkieTzLm9Dztd3LxAzbQRHIyxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 07DA116A3;
	Tue, 29 Oct 2024 07:46:39 -0700 (PDT)
Received: from e123572-lin.arm.com (e123572-lin.cambridge.arm.com [10.1.194.54])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6C3123F7A6;
	Tue, 29 Oct 2024 07:46:06 -0700 (PDT)
From: Kevin Brodsky <kevin.brodsky@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: Kevin Brodsky <kevin.brodsky@arm.com>,
	akpm@linux-foundation.org,
	anshuman.khandual@arm.com,
	aruna.ramakrishna@oracle.com,
	broonie@kernel.org,
	catalin.marinas@arm.com,
	dave.hansen@linux.intel.com,
	Dave.Martin@arm.com,
	jeffxu@chromium.org,
	joey.gouly@arm.com,
	keith.lucas@oracle.com,
	pierre.langlois@arm.com,
	shuah@kernel.org,
	sroettger@google.com,
	tglx@linutronix.de,
	will@kernel.org,
	yury.khrustalev@arm.com,
	linux-kselftest@vger.kernel.org,
	x86@kernel.org
Subject: [PATCH v3 4/5] selftests/mm: Use generic pkey register manipulation
Date: Tue, 29 Oct 2024 14:45:38 +0000
Message-ID: <20241029144539.111155-5-kevin.brodsky@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241029144539.111155-1-kevin.brodsky@arm.com>
References: <20241029144539.111155-1-kevin.brodsky@arm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pkey_sighandler_tests.c currently hardcodes x86 PKRU encodings. The
first step towards running those tests on arm64 is to abstract away
the pkey register values.

Since those tests want to deny access to all keys except a few,
we have each arch define PKEY_REG_ALLOW_NONE, the pkey register value
denying access to all keys. We then use the existing set_pkey_bits()
helper to grant access to specific keys.

Because pkeys may also remove the execute permission on arm64, we
need to be a little careful: all code is mapped with pkey 0, and we
need it to remain executable. pkey_reg_restrictive_default() is
introduced for that purpose: the value it returns prevents RW access
to all pkeys, but retains X permission for pkey 0.

test_pkru_preserved_after_sigusr1() only checks that the pkey
register value remains unchanged after a signal is delivered, so the
particular value is irrelevant. We enable pkey 0 and a few more
arbitrary keys in the smallest range available on all architectures
(8 keys on arm64).

Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
---
 tools/testing/selftests/mm/pkey-arm64.h       |  1 +
 tools/testing/selftests/mm/pkey-x86.h         |  2 +
 .../selftests/mm/pkey_sighandler_tests.c      | 53 +++++++++++++++----
 3 files changed, 47 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/mm/pkey-arm64.h b/tools/testing/selftests/mm/pkey-arm64.h
index 580e1b0bb38e..d57fbeace38f 100644
--- a/tools/testing/selftests/mm/pkey-arm64.h
+++ b/tools/testing/selftests/mm/pkey-arm64.h
@@ -31,6 +31,7 @@
 #define NR_RESERVED_PKEYS	1 /* pkey-0 */
 
 #define PKEY_ALLOW_ALL		0x77777777
+#define PKEY_REG_ALLOW_NONE	0x0
 
 #define PKEY_BITS_PER_PKEY	4
 #define PAGE_SIZE		sysconf(_SC_PAGESIZE)
diff --git a/tools/testing/selftests/mm/pkey-x86.h b/tools/testing/selftests/mm/pkey-x86.h
index 5f28e26a2511..ac91777c8917 100644
--- a/tools/testing/selftests/mm/pkey-x86.h
+++ b/tools/testing/selftests/mm/pkey-x86.h
@@ -34,6 +34,8 @@
 #define PAGE_SIZE		4096
 #define MB			(1<<20)
 
+#define PKEY_REG_ALLOW_NONE	0x55555555
+
 static inline void __page_o_noops(void)
 {
 	/* 8-bytes of instruction * 512 bytes = 1 page */
diff --git a/tools/testing/selftests/mm/pkey_sighandler_tests.c b/tools/testing/selftests/mm/pkey_sighandler_tests.c
index a8088b645ad6..501880dbdc37 100644
--- a/tools/testing/selftests/mm/pkey_sighandler_tests.c
+++ b/tools/testing/selftests/mm/pkey_sighandler_tests.c
@@ -11,6 +11,7 @@
  */
 #define _GNU_SOURCE
 #define __SANE_USERSPACE_TYPES__
+#include <linux/mman.h>
 #include <errno.h>
 #include <sys/syscall.h>
 #include <string.h>
@@ -65,6 +66,20 @@ long syscall_raw(long n, long a1, long a2, long a3, long a4, long a5, long a6)
 	return ret;
 }
 
+/*
+ * Returns the most restrictive pkey register value that can be used by the
+ * tests.
+ */
+static inline u64 pkey_reg_restrictive_default(void)
+{
+	/*
+	 * Disallow everything except execution on pkey 0, so that each caller
+	 * doesn't need to enable it explicitly (the selftest code runs with
+	 * its code mapped with pkey 0).
+	 */
+	return set_pkey_bits(PKEY_REG_ALLOW_NONE, 0, PKEY_DISABLE_ACCESS);
+}
+
 static void sigsegv_handler(int signo, siginfo_t *info, void *ucontext)
 {
 	pthread_mutex_lock(&mutex);
@@ -113,7 +128,7 @@ static void raise_sigusr2(void)
 static void *thread_segv_with_pkey0_disabled(void *ptr)
 {
 	/* Disable MPK 0 (and all others too) */
-	__write_pkey_reg(0x55555555);
+	__write_pkey_reg(pkey_reg_restrictive_default());
 
 	/* Segfault (with SEGV_MAPERR) */
 	*(int *) (0x1) = 1;
@@ -123,7 +138,7 @@ static void *thread_segv_with_pkey0_disabled(void *ptr)
 static void *thread_segv_pkuerr_stack(void *ptr)
 {
 	/* Disable MPK 0 (and all others too) */
-	__write_pkey_reg(0x55555555);
+	__write_pkey_reg(pkey_reg_restrictive_default());
 
 	/* After we disable MPK 0, we can't access the stack to return */
 	return NULL;
@@ -133,6 +148,7 @@ static void *thread_segv_maperr_ptr(void *ptr)
 {
 	stack_t *stack = ptr;
 	int *bad = (int *)1;
+	u64 pkey_reg;
 
 	/*
 	 * Setup alternate signal stack, which should be pkey_mprotect()ed by
@@ -142,7 +158,9 @@ static void *thread_segv_maperr_ptr(void *ptr)
 	syscall_raw(SYS_sigaltstack, (long)stack, 0, 0, 0, 0, 0);
 
 	/* Disable MPK 0.  Only MPK 1 is enabled. */
-	__write_pkey_reg(0x55555551);
+	pkey_reg = pkey_reg_restrictive_default();
+	pkey_reg = set_pkey_bits(pkey_reg, 1, PKEY_UNRESTRICTED);
+	__write_pkey_reg(pkey_reg);
 
 	/* Segfault */
 	*bad = 1;
@@ -240,6 +258,7 @@ static void test_sigsegv_handler_with_different_pkey_for_stack(void)
 	int pkey;
 	int parent_pid = 0;
 	int child_pid = 0;
+	u64 pkey_reg;
 
 	sa.sa_flags = SA_SIGINFO | SA_ONSTACK;
 
@@ -257,7 +276,10 @@ static void test_sigsegv_handler_with_different_pkey_for_stack(void)
 	assert(stack != MAP_FAILED);
 
 	/* Allow access to MPK 0 and MPK 1 */
-	__write_pkey_reg(0x55555550);
+	pkey_reg = pkey_reg_restrictive_default();
+	pkey_reg = set_pkey_bits(pkey_reg, 0, PKEY_UNRESTRICTED);
+	pkey_reg = set_pkey_bits(pkey_reg, 1, PKEY_UNRESTRICTED);
+	__write_pkey_reg(pkey_reg);
 
 	/* Protect the new stack with MPK 1 */
 	pkey = pkey_alloc(0, 0);
@@ -307,7 +329,13 @@ static void test_sigsegv_handler_with_different_pkey_for_stack(void)
 static void test_pkru_preserved_after_sigusr1(void)
 {
 	struct sigaction sa;
-	unsigned long pkru = 0x45454544;
+	u64 pkey_reg;
+
+	/* Allow access to MPK 0 and an arbitrary set of keys */
+	pkey_reg = pkey_reg_restrictive_default();
+	pkey_reg = set_pkey_bits(pkey_reg, 0, PKEY_UNRESTRICTED);
+	pkey_reg = set_pkey_bits(pkey_reg, 3, PKEY_UNRESTRICTED);
+	pkey_reg = set_pkey_bits(pkey_reg, 7, PKEY_UNRESTRICTED);
 
 	sa.sa_flags = SA_SIGINFO;
 
@@ -320,7 +348,7 @@ static void test_pkru_preserved_after_sigusr1(void)
 
 	memset(&siginfo, 0, sizeof(siginfo));
 
-	__write_pkey_reg(pkru);
+	__write_pkey_reg(pkey_reg);
 
 	raise(SIGUSR1);
 
@@ -330,7 +358,7 @@ static void test_pkru_preserved_after_sigusr1(void)
 	pthread_mutex_unlock(&mutex);
 
 	/* Ensure the pkru value is the same after returning from signal. */
-	ksft_test_result(pkru == __read_pkey_reg() &&
+	ksft_test_result(pkey_reg == __read_pkey_reg() &&
 			 siginfo.si_signo == SIGUSR1,
 			 "%s\n", __func__);
 }
@@ -347,6 +375,7 @@ static noinline void *thread_sigusr2_self(void *ptr)
 		'S', 'I', 'G', 'U', 'S', 'R', '2',
 		'.', '.', '.', '\n', '\0'};
 	stack_t *stack = ptr;
+	u64 pkey_reg;
 
 	/*
 	 * Setup alternate signal stack, which should be pkey_mprotect()ed by
@@ -356,7 +385,9 @@ static noinline void *thread_sigusr2_self(void *ptr)
 	syscall(SYS_sigaltstack, (long)stack, 0, 0, 0, 0, 0);
 
 	/* Disable MPK 0.  Only MPK 2 is enabled. */
-	__write_pkey_reg(0x55555545);
+	pkey_reg = pkey_reg_restrictive_default();
+	pkey_reg = set_pkey_bits(pkey_reg, 2, PKEY_UNRESTRICTED);
+	__write_pkey_reg(pkey_reg);
 
 	raise_sigusr2();
 
@@ -384,6 +415,7 @@ static void test_pkru_sigreturn(void)
 	int pkey;
 	int parent_pid = 0;
 	int child_pid = 0;
+	u64 pkey_reg;
 
 	sa.sa_handler = SIG_DFL;
 	sa.sa_flags = 0;
@@ -418,7 +450,10 @@ static void test_pkru_sigreturn(void)
 	 * the current thread's stack is protected by the default MPK 0. Hence
 	 * both need to be enabled.
 	 */
-	__write_pkey_reg(0x55555544);
+	pkey_reg = pkey_reg_restrictive_default();
+	pkey_reg = set_pkey_bits(pkey_reg, 0, PKEY_UNRESTRICTED);
+	pkey_reg = set_pkey_bits(pkey_reg, 2, PKEY_UNRESTRICTED);
+	__write_pkey_reg(pkey_reg);
 
 	/* Protect the stack with MPK 2 */
 	pkey = pkey_alloc(0, 0);
-- 
2.43.0


