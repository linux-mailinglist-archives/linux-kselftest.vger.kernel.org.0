Return-Path: <linux-kselftest+bounces-20467-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DA299ACE57
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Oct 2024 17:13:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 444A4B2AB88
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Oct 2024 15:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B643E1DB344;
	Wed, 23 Oct 2024 15:05:40 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA34C1DC19E
	for <linux-kselftest@vger.kernel.org>; Wed, 23 Oct 2024 15:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729695940; cv=none; b=aAboGMgozRX3m2sNyZpLbP1JEERIITfHC2P4sB6ehmZ5Sig5mO8PdbismmorQRg2zNkhpbooAAhyxIkmCcfjh+wggaaweqgvRzy4JgPMwGiqRLg/Mzinv/EvDY+e2ulvbgF1gXWz34Ks/fp8bto293VHVxdaKMccRiECJVoe33U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729695940; c=relaxed/simple;
	bh=rNWtdajToAoN4vjDculLE+cS1c+v1R5bSiYrspEWwv8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AkJqp/kmSRu3HIJ8GKqeolQYcuY9rdojFxNEloXkSYMrcEeerGiPiE6mkK+pu1zZDrDuZdz0O1nmMlksWMoT9xHPpoa8cOD+/fJ+NugR0QKmMnzqr/QsSU+dtqrs1+wh/HXckvapF4YTZdOpTM+T/jS/Mxv2O0/MHt4Vl/x90lM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DCE65339;
	Wed, 23 Oct 2024 08:06:07 -0700 (PDT)
Received: from e123572-lin.arm.com (e123572-lin.cambridge.arm.com [10.1.194.54])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2EA713F528;
	Wed, 23 Oct 2024 08:05:36 -0700 (PDT)
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
	pierre.langlois@arm.com,
	shuah@kernel.org,
	sroettger@google.com,
	will@kernel.org,
	linux-kselftest@vger.kernel.org,
	x86@kernel.org
Subject: [PATCH v2 5/5] selftests/mm: Enable pkey_sighandler_tests on arm64
Date: Wed, 23 Oct 2024 16:05:11 +0100
Message-ID: <20241023150511.3923558-6-kevin.brodsky@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241023150511.3923558-1-kevin.brodsky@arm.com>
References: <20241023150511.3923558-1-kevin.brodsky@arm.com>
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


