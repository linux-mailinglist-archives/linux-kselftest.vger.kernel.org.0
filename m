Return-Path: <linux-kselftest+bounces-19960-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 572359A2425
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 15:40:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D45A1F263CB
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 13:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E2AA1DE2AF;
	Thu, 17 Oct 2024 13:40:29 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7307A1D88AD
	for <linux-kselftest@vger.kernel.org>; Thu, 17 Oct 2024 13:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729172429; cv=none; b=RLe8e/aQuS4HfpNXurVYOKPeh2zQrPblm5u7tLe+lWcgY1frbzIb0aOdEH4sVXFCnUwZ8BYGI9s09mkGXyzdCAHSojPIKg5MPmm9fFIjHiok6FYY1kGihAqBFLvC+Rc6/lSbxgmepHkPweV34EIIU4rpL5FsqrNd+13+zpESMr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729172429; c=relaxed/simple;
	bh=rNWtdajToAoN4vjDculLE+cS1c+v1R5bSiYrspEWwv8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aTGsSVZhh4Miq87HDpxOCR/2imzNoET4AGayzVud3Zl3HoZksJvhUvz7rVfG5Diypjj+3w8xP163WJvskpPS3MSRDE3aWgHgMDlPYrrgqZiVH6NVeEMW+MBa5YQXsxoW+JFGgt/qYIWsZ8Y7MDZuCzN5//4VKJC5hV0K6w02Qxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E80CC1596;
	Thu, 17 Oct 2024 06:40:54 -0700 (PDT)
Received: from e123572-lin.arm.com (e123572-lin.cambridge.arm.com [10.1.194.54])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C9E453F71E;
	Thu, 17 Oct 2024 06:40:22 -0700 (PDT)
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
Subject: [PATCH 5/5] selftests/mm: Enable pkey_sighandler_tests on arm64
Date: Thu, 17 Oct 2024 14:39:09 +0100
Message-ID: <20241017133909.3837547-6-kevin.brodsky@arm.com>
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

pkey_sighandler_tests.c makes raw syscalls using its own helper,
syscall_raw(). One of those syscalls is clone, which is problematic
as every architecture has a different opinion on the order of its
arguments.

To complete arm64 support, we therefore add an appropriate
implementation in syscall_raw(), and introduce a clone_raw() helper
that shuffles arguments as needed for each arch.

Having done this, we enable building pkey_sighandler_tests for arm64
in the Makefile.

Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
---
 tools/testing/selftests/mm/Makefile           |  8 +--
 .../selftests/mm/pkey_sighandler_tests.c      | 62 ++++++++++++++-----
 2 files changed, 50 insertions(+), 20 deletions(-)

diff --git a/tools/testing/selftests/mm/Makefile b/tools/testing/selftests/mm/Makefile
index 02e1204971b0..0f8c110e0805 100644
--- a/tools/testing/selftests/mm/Makefile
+++ b/tools/testing/selftests/mm/Makefile
@@ -105,12 +105,12 @@ endif
 ifeq ($(CAN_BUILD_X86_64),1)
 TEST_GEN_FILES += $(BINARIES_64)
 endif
-else
 
-ifneq (,$(filter $(ARCH),arm64 powerpc))
+else ifeq ($(ARCH),arm64)
+TEST_GEN_FILES += protection_keys
+TEST_GEN_FILES += pkey_sighandler_tests
+else ifeq ($(ARCH),powerpc)
 TEST_GEN_FILES += protection_keys
-endif
-
 endif
 
 ifneq (,$(filter $(ARCH),arm64 mips64 parisc64 powerpc riscv64 s390x sparc64 x86_64 s390))
diff --git a/tools/testing/selftests/mm/pkey_sighandler_tests.c b/tools/testing/selftests/mm/pkey_sighandler_tests.c
index b5e1767ee5d9..97460980811c 100644
--- a/tools/testing/selftests/mm/pkey_sighandler_tests.c
+++ b/tools/testing/selftests/mm/pkey_sighandler_tests.c
@@ -61,12 +61,44 @@ long syscall_raw(long n, long a1, long a2, long a3, long a4, long a5, long a6)
 		      : "=a"(ret)
 		      : "a"(n), "b"(a1), "c"(a2), "d"(a3), "S"(a4), "D"(a5)
 		      : "memory");
+#elif defined __aarch64__
+	register long x0 asm("x0") = a1;
+	register long x1 asm("x1") = a2;
+	register long x2 asm("x2") = a3;
+	register long x3 asm("x3") = a4;
+	register long x4 asm("x4") = a5;
+	register long x5 asm("x5") = a6;
+	register long x8 asm("x8") = n;
+	asm volatile ("svc #0"
+		      : "=r"(x0)
+		      : "r"(x0), "r"(x1), "r"(x2), "r"(x3), "r"(x4), "r"(x5), "r"(x8)
+		      : "memory");
+	ret = x0;
 #else
 # error syscall_raw() not implemented
 #endif
 	return ret;
 }
 
+static inline long clone_raw(unsigned long flags, void *stack,
+			     int *parent_tid, int *child_tid)
+{
+	long a1 = flags;
+	long a2 = (long)stack;
+	long a3 = (long)parent_tid;
+#if defined(__x86_64__) || defined(__i386)
+	long a4 = (long)child_tid;
+	long a5 = 0;
+#elif defined(__aarch64__)
+	long a4 = 0;
+	long a5 = (long)child_tid;
+#else
+# error clone_raw() not implemented
+#endif
+
+	return syscall_raw(SYS_clone, a1, a2, a3, a4, a5, 0);
+}
+
 static void sigsegv_handler(int signo, siginfo_t *info, void *ucontext)
 {
 	pthread_mutex_lock(&mutex);
@@ -279,14 +311,13 @@ static void test_sigsegv_handler_with_different_pkey_for_stack(void)
 	memset(&siginfo, 0, sizeof(siginfo));
 
 	/* Use clone to avoid newer glibcs using rseq on new threads */
-	long ret = syscall_raw(SYS_clone,
-			       CLONE_VM | CLONE_FS | CLONE_FILES |
-			       CLONE_SIGHAND | CLONE_THREAD | CLONE_SYSVSEM |
-			       CLONE_PARENT_SETTID | CLONE_CHILD_CLEARTID |
-			       CLONE_DETACHED,
-			       (long) ((char *)(stack) + STACK_SIZE),
-			       (long) &parent_pid,
-			       (long) &child_pid, 0, 0);
+	long ret = clone_raw(CLONE_VM | CLONE_FS | CLONE_FILES |
+			     CLONE_SIGHAND | CLONE_THREAD | CLONE_SYSVSEM |
+			     CLONE_PARENT_SETTID | CLONE_CHILD_CLEARTID |
+			     CLONE_DETACHED,
+			     stack + STACK_SIZE,
+			     &parent_pid,
+			     &child_pid);
 
 	if (ret < 0) {
 		errno = -ret;
@@ -448,14 +479,13 @@ static void test_pkru_sigreturn(void)
 	sigstack.ss_size = STACK_SIZE;
 
 	/* Use clone to avoid newer glibcs using rseq on new threads */
-	long ret = syscall_raw(SYS_clone,
-			       CLONE_VM | CLONE_FS | CLONE_FILES |
-			       CLONE_SIGHAND | CLONE_THREAD | CLONE_SYSVSEM |
-			       CLONE_PARENT_SETTID | CLONE_CHILD_CLEARTID |
-			       CLONE_DETACHED,
-			       (long) ((char *)(stack) + STACK_SIZE),
-			       (long) &parent_pid,
-			       (long) &child_pid, 0, 0);
+	long ret = clone_raw(CLONE_VM | CLONE_FS | CLONE_FILES |
+			     CLONE_SIGHAND | CLONE_THREAD | CLONE_SYSVSEM |
+			     CLONE_PARENT_SETTID | CLONE_CHILD_CLEARTID |
+			     CLONE_DETACHED,
+			     stack + STACK_SIZE,
+			     &parent_pid,
+			     &child_pid);
 
 	if (ret < 0) {
 		errno = -ret;
-- 
2.43.0


