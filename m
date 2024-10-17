Return-Path: <linux-kselftest+bounces-19959-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 323629A2423
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 15:40:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E67ED28E0D0
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 13:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 758FF1DE2B6;
	Thu, 17 Oct 2024 13:40:26 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39C2E1DE2BB
	for <linux-kselftest@vger.kernel.org>; Thu, 17 Oct 2024 13:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729172426; cv=none; b=BZKGxihbUveQ2Q0M/6XuuP47QQvY3zJC6uAjJ87oCM6Zei96oN6+ydOK5T7cIJfgYHdKBMldLaX7m5CTvoLD0tPgu7PpvL6OtL3myThwutM5Q8LglOnKwlLXeooLh6mdYNpRr0wvTYEuf7kg4/9VxMNA4Xg0IlHCxAaXd1mWrBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729172426; c=relaxed/simple;
	bh=0fRX+jBkbH4Vob4e+zZ43AKsIJQiCrtnfhwtPMy1+44=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t+v+LcaEasiNSeM2ma+bDXpNrN/J36juyNB1EdziH5hHwn/Uynxh6xC2BQNBwLcenSuAKxArWW9rYr67uKXjqU8Feo/bW9dfyIA0mxQ0F8tf/VCq6erayVMIV7M93f8APt5LcbICthZtGHKph4HtLgwcFvg7yj8oOz7hANOtLcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 26AF71595;
	Thu, 17 Oct 2024 06:40:52 -0700 (PDT)
Received: from e123572-lin.arm.com (e123572-lin.cambridge.arm.com [10.1.194.54])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 093EA3F71E;
	Thu, 17 Oct 2024 06:40:19 -0700 (PDT)
From: Kevin Brodsky <kevin.brodsky@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: Kevin Brodsky <kevin.brodsky@arm.com>,
	akpm@linux-foundation.org,
	anshuman.khandual@arm.com,
	aruna.ramakrishna@oracle.com,
	broonie@kernel.org,
	catalin.marinas@arm.com,
	dave.hansen@linux.intel.com,
	dave.martin@arm.com,
	jeffxu@chromium.org,
	joey.gouly@arm.com,
	shuah@kernel.org,
	will@kernel.org,
	linux-kselftest@vger.kernel.org,
	x86@kernel.org
Subject: [PATCH 4/5] selftests/mm: Use generic pkey register manipulation
Date: Thu, 17 Oct 2024 14:39:08 +0100
Message-ID: <20241017133909.3837547-5-kevin.brodsky@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241017133909.3837547-1-kevin.brodsky@arm.com>
References: <20241017133909.3837547-1-kevin.brodsky@arm.com>
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
we have each arch define PKEY_ALLOW_NONE, the pkey register value
denying access to all keys. We then use the existing set_pkey_bits()
helper to grant access to specific keys.

Because pkeys may also remove the execute permission on arm64, we
need to be a little careful: all code is mapped with pkey 0, and we
need it to remain executable. pkey_reg_no_access is introduced for
that purpose: this value prevents RW access to all pkeys, but
retains X permission for pkey 0.

test_pkru_preserved_after_sigusr1() only checks that the pkey
register value remains unchanged after a signal is delivered, so the
particular value is irrelevant. We enable pkey 0 and a few more
arbitrary keys in the smallest range available on all architectures
(8 keys on arm64).

Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
---
 tools/testing/selftests/mm/pkey-arm64.h       |  1 +
 tools/testing/selftests/mm/pkey-x86.h         |  2 +
 .../selftests/mm/pkey_sighandler_tests.c      | 39 ++++++++++++++-----
 3 files changed, 33 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/mm/pkey-arm64.h b/tools/testing/selftests/mm/pkey-arm64.h
index 580e1b0bb38e..5ec53d67dfc7 100644
--- a/tools/testing/selftests/mm/pkey-arm64.h
+++ b/tools/testing/selftests/mm/pkey-arm64.h
@@ -31,6 +31,7 @@
 #define NR_RESERVED_PKEYS	1 /* pkey-0 */
 
 #define PKEY_ALLOW_ALL		0x77777777
+#define PKEY_ALLOW_NONE		0
 
 #define PKEY_BITS_PER_PKEY	4
 #define PAGE_SIZE		sysconf(_SC_PAGESIZE)
diff --git a/tools/testing/selftests/mm/pkey-x86.h b/tools/testing/selftests/mm/pkey-x86.h
index 5f28e26a2511..53ed9a336ffe 100644
--- a/tools/testing/selftests/mm/pkey-x86.h
+++ b/tools/testing/selftests/mm/pkey-x86.h
@@ -34,6 +34,8 @@
 #define PAGE_SIZE		4096
 #define MB			(1<<20)
 
+#define PKEY_ALLOW_NONE		0x55555555
+
 static inline void __page_o_noops(void)
 {
 	/* 8-bytes of instruction * 512 bytes = 1 page */
diff --git a/tools/testing/selftests/mm/pkey_sighandler_tests.c b/tools/testing/selftests/mm/pkey_sighandler_tests.c
index a8088b645ad6..b5e1767ee5d9 100644
--- a/tools/testing/selftests/mm/pkey_sighandler_tests.c
+++ b/tools/testing/selftests/mm/pkey_sighandler_tests.c
@@ -37,6 +37,8 @@ pthread_mutex_t mutex = PTHREAD_MUTEX_INITIALIZER;
 pthread_cond_t cond = PTHREAD_COND_INITIALIZER;
 siginfo_t siginfo = {0};
 
+static u64 pkey_reg_no_access;
+
 /*
  * We need to use inline assembly instead of glibc's syscall because glibc's
  * syscall will attempt to access the PLT in order to call a library function
@@ -113,7 +115,7 @@ static void raise_sigusr2(void)
 static void *thread_segv_with_pkey0_disabled(void *ptr)
 {
 	/* Disable MPK 0 (and all others too) */
-	__write_pkey_reg(0x55555555);
+	__write_pkey_reg(pkey_reg_no_access);
 
 	/* Segfault (with SEGV_MAPERR) */
 	*(int *) (0x1) = 1;
@@ -123,7 +125,7 @@ static void *thread_segv_with_pkey0_disabled(void *ptr)
 static void *thread_segv_pkuerr_stack(void *ptr)
 {
 	/* Disable MPK 0 (and all others too) */
-	__write_pkey_reg(0x55555555);
+	__write_pkey_reg(pkey_reg_no_access);
 
 	/* After we disable MPK 0, we can't access the stack to return */
 	return NULL;
@@ -133,6 +135,7 @@ static void *thread_segv_maperr_ptr(void *ptr)
 {
 	stack_t *stack = ptr;
 	int *bad = (int *)1;
+	u64 pkey_reg;
 
 	/*
 	 * Setup alternate signal stack, which should be pkey_mprotect()ed by
@@ -142,7 +145,8 @@ static void *thread_segv_maperr_ptr(void *ptr)
 	syscall_raw(SYS_sigaltstack, (long)stack, 0, 0, 0, 0, 0);
 
 	/* Disable MPK 0.  Only MPK 1 is enabled. */
-	__write_pkey_reg(0x55555551);
+	pkey_reg = set_pkey_bits(pkey_reg_no_access, 1, 0);
+	__write_pkey_reg(pkey_reg);
 
 	/* Segfault */
 	*bad = 1;
@@ -240,6 +244,7 @@ static void test_sigsegv_handler_with_different_pkey_for_stack(void)
 	int pkey;
 	int parent_pid = 0;
 	int child_pid = 0;
+	u64 pkey_reg;
 
 	sa.sa_flags = SA_SIGINFO | SA_ONSTACK;
 
@@ -257,7 +262,9 @@ static void test_sigsegv_handler_with_different_pkey_for_stack(void)
 	assert(stack != MAP_FAILED);
 
 	/* Allow access to MPK 0 and MPK 1 */
-	__write_pkey_reg(0x55555550);
+	pkey_reg = set_pkey_bits(pkey_reg_no_access, 0, 0);
+	pkey_reg = set_pkey_bits(pkey_reg, 1, 0);
+	__write_pkey_reg(pkey_reg);
 
 	/* Protect the new stack with MPK 1 */
 	pkey = pkey_alloc(0, 0);
@@ -307,7 +314,12 @@ static void test_sigsegv_handler_with_different_pkey_for_stack(void)
 static void test_pkru_preserved_after_sigusr1(void)
 {
 	struct sigaction sa;
-	unsigned long pkru = 0x45454544;
+	u64 pkey_reg;
+
+	/* Allow access to MPK 0 and an arbitrary set of keys */
+	pkey_reg = set_pkey_bits(pkey_reg_no_access, 0, 0);
+	pkey_reg = set_pkey_bits(pkey_reg, 3, 0);
+	pkey_reg = set_pkey_bits(pkey_reg, 7, 0);
 
 	sa.sa_flags = SA_SIGINFO;
 
@@ -320,7 +332,7 @@ static void test_pkru_preserved_after_sigusr1(void)
 
 	memset(&siginfo, 0, sizeof(siginfo));
 
-	__write_pkey_reg(pkru);
+	__write_pkey_reg(pkey_reg);
 
 	raise(SIGUSR1);
 
@@ -330,7 +342,7 @@ static void test_pkru_preserved_after_sigusr1(void)
 	pthread_mutex_unlock(&mutex);
 
 	/* Ensure the pkru value is the same after returning from signal. */
-	ksft_test_result(pkru == __read_pkey_reg() &&
+	ksft_test_result(pkey_reg == __read_pkey_reg() &&
 			 siginfo.si_signo == SIGUSR1,
 			 "%s\n", __func__);
 }
@@ -347,6 +359,7 @@ static noinline void *thread_sigusr2_self(void *ptr)
 		'S', 'I', 'G', 'U', 'S', 'R', '2',
 		'.', '.', '.', '\n', '\0'};
 	stack_t *stack = ptr;
+	u64 pkey_reg;
 
 	/*
 	 * Setup alternate signal stack, which should be pkey_mprotect()ed by
@@ -356,7 +369,8 @@ static noinline void *thread_sigusr2_self(void *ptr)
 	syscall(SYS_sigaltstack, (long)stack, 0, 0, 0, 0, 0);
 
 	/* Disable MPK 0.  Only MPK 2 is enabled. */
-	__write_pkey_reg(0x55555545);
+	pkey_reg = set_pkey_bits(pkey_reg_no_access, 2, 0);
+	__write_pkey_reg(pkey_reg);
 
 	raise_sigusr2();
 
@@ -384,6 +398,7 @@ static void test_pkru_sigreturn(void)
 	int pkey;
 	int parent_pid = 0;
 	int child_pid = 0;
+	u64 pkey_reg;
 
 	sa.sa_handler = SIG_DFL;
 	sa.sa_flags = 0;
@@ -418,7 +433,9 @@ static void test_pkru_sigreturn(void)
 	 * the current thread's stack is protected by the default MPK 0. Hence
 	 * both need to be enabled.
 	 */
-	__write_pkey_reg(0x55555544);
+	pkey_reg = set_pkey_bits(pkey_reg_no_access, 0, 0);
+	pkey_reg = set_pkey_bits(pkey_reg, 2, 0);
+	__write_pkey_reg(pkey_reg);
 
 	/* Protect the stack with MPK 2 */
 	pkey = pkey_alloc(0, 0);
@@ -473,6 +490,10 @@ int main(int argc, char *argv[])
 	ksft_print_header();
 	ksft_set_plan(ARRAY_SIZE(pkey_tests));
 
+	/* Only allow X for MPK 0 and nothing for other keys */
+	pkey_reg_no_access = set_pkey_bits(PKEY_ALLOW_NONE, 0,
+					   PKEY_DISABLE_ACCESS);
+
 	for (i = 0; i < ARRAY_SIZE(pkey_tests); i++)
 		(*pkey_tests[i])();
 
-- 
2.43.0


