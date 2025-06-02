Return-Path: <linux-kselftest+bounces-34182-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F640ACBD82
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Jun 2025 00:56:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E5A616B384
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Jun 2025 22:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F19C25291D;
	Mon,  2 Jun 2025 22:56:15 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from vmicros1.altlinux.org (vmicros1.altlinux.org [194.107.17.57])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03CA6224240;
	Mon,  2 Jun 2025 22:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.107.17.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748904975; cv=none; b=fEUAI/bgplfPhc8aSSUQjowqkW5DpPMVYgMfVPSuNVcO5obWyv9dRBXZTB3HEnz3K2No+n9dgIvAtAlNqIqYxPEUrMWLI8JALkrn1WahwnpOPczZNw0pO7YoZEmhAW6WSzNPsbdfUe/X11SOOjZcBDZVekwe/FztrtawcdEsvC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748904975; c=relaxed/simple;
	bh=bs0uQbFC8a3+B+UVBUz/7Mj+FMPhbCeM9qCsUm37p5U=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=oZdiHr8qwzyPvuq1t6zMy1D22Zk/qm8H2zr4yyaNUG+WCh5XR0vr1gz1zqBBqRo15n4v6VeRfiytcIrGS0kwEwPXGiuf2xk/Mvks9N3AhPGeElx+C8ABjxLmYqqL94Pf0m+cYNasP7W6yb+sOkLaS8Q2g3f+4AUIQR0D06geIQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strace.io; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=194.107.17.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strace.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
	by vmicros1.altlinux.org (Postfix) with ESMTP id 3764772C8CC;
	Tue,  3 Jun 2025 01:56:11 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
	id 224917CCB3A; Tue,  3 Jun 2025 01:56:11 +0300 (IDT)
Date: Tue, 3 Jun 2025 01:56:11 +0300
From: "Dmitry V. Levin" <ldv@strace.io>
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: Shuah Khan <shuah@kernel.org>, Oleg Nesterov <oleg@redhat.com>,
	"Maciej W. Rozycki" <macro@orcam.me.uk>,
	strace-devel@lists.strace.io, linux-kselftest@vger.kernel.org,
	linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3] selftests/ptrace/get_syscall_info: fix for MIPS n32
Message-ID: <20250602225610.GA6005@strace.io>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

MIPS n32 is one of two ILP32 architectures supported by the kernel
that have 64-bit syscall arguments (another one is x32).

When this test passed 32-bit arguments to syscall(), they were
sign-extended in libc, PTRACE_GET_SYSCALL_INFO reported these
sign-extended 64-bit values, and the test complained about the mismatch.

Fix this by passing arguments of the appropriate type to syscall(),
which is "unsigned long long" on MIPS n32, and __kernel_ulong_t on other
architectures, the same way as selftests/ptrace/set_syscall_info already
does.

As a side effect, this also extends the test on all 64-bit architectures
by choosing constants that don't fit into 32-bit integers.

Signed-off-by: Dmitry V. Levin <ldv@strace.io>
Acked-by: Shuah Khan <skhan@linuxfoundation.org>
---

v3: Added Acked-by:
    https://lore.kernel.org/all/b2e62143-fa68-4cd1-bf6c-67f0ad49c670@linuxfoundation.org/

v2: Fixed MIPS #ifdef:
    https://lore.kernel.org/all/20250115233747.GA28541@strace.io/

 .../selftests/ptrace/get_syscall_info.c       | 53 +++++++++++--------
 1 file changed, 32 insertions(+), 21 deletions(-)

diff --git a/tools/testing/selftests/ptrace/get_syscall_info.c b/tools/testing/selftests/ptrace/get_syscall_info.c
index 5bcd1c7b5be6..2970f72d66d3 100644
--- a/tools/testing/selftests/ptrace/get_syscall_info.c
+++ b/tools/testing/selftests/ptrace/get_syscall_info.c
@@ -11,8 +11,19 @@
 #include <err.h>
 #include <signal.h>
 #include <asm/unistd.h>
+#include <linux/types.h>
 #include "linux/ptrace.h"
 
+#if defined(_MIPS_SIM) && _MIPS_SIM == _MIPS_SIM_NABI32
+/*
+ * MIPS N32 is the only architecture where __kernel_ulong_t
+ * does not match the bitness of syscall arguments.
+ */
+typedef unsigned long long kernel_ulong_t;
+#else
+typedef __kernel_ulong_t kernel_ulong_t;
+#endif
+
 static int
 kill_tracee(pid_t pid)
 {
@@ -42,37 +53,37 @@ sys_ptrace(int request, pid_t pid, unsigned long addr, unsigned long data)
 
 TEST(get_syscall_info)
 {
-	static const unsigned long args[][7] = {
+	const kernel_ulong_t args[][7] = {
 		/* a sequence of architecture-agnostic syscalls */
 		{
 			__NR_chdir,
-			(unsigned long) "",
-			0xbad1fed1,
-			0xbad2fed2,
-			0xbad3fed3,
-			0xbad4fed4,
-			0xbad5fed5
+			(uintptr_t) "",
+			(kernel_ulong_t) 0xdad1bef1bad1fed1ULL,
+			(kernel_ulong_t) 0xdad2bef2bad2fed2ULL,
+			(kernel_ulong_t) 0xdad3bef3bad3fed3ULL,
+			(kernel_ulong_t) 0xdad4bef4bad4fed4ULL,
+			(kernel_ulong_t) 0xdad5bef5bad5fed5ULL
 		},
 		{
 			__NR_gettid,
-			0xcaf0bea0,
-			0xcaf1bea1,
-			0xcaf2bea2,
-			0xcaf3bea3,
-			0xcaf4bea4,
-			0xcaf5bea5
+			(kernel_ulong_t) 0xdad0bef0caf0bea0ULL,
+			(kernel_ulong_t) 0xdad1bef1caf1bea1ULL,
+			(kernel_ulong_t) 0xdad2bef2caf2bea2ULL,
+			(kernel_ulong_t) 0xdad3bef3caf3bea3ULL,
+			(kernel_ulong_t) 0xdad4bef4caf4bea4ULL,
+			(kernel_ulong_t) 0xdad5bef5caf5bea5ULL
 		},
 		{
 			__NR_exit_group,
 			0,
-			0xfac1c0d1,
-			0xfac2c0d2,
-			0xfac3c0d3,
-			0xfac4c0d4,
-			0xfac5c0d5
+			(kernel_ulong_t) 0xdad1bef1fac1c0d1ULL,
+			(kernel_ulong_t) 0xdad2bef2fac2c0d2ULL,
+			(kernel_ulong_t) 0xdad3bef3fac3c0d3ULL,
+			(kernel_ulong_t) 0xdad4bef4fac4c0d4ULL,
+			(kernel_ulong_t) 0xdad5bef5fac5c0d5ULL
 		}
 	};
-	const unsigned long *exp_args;
+	const kernel_ulong_t *exp_args;
 
 	pid_t pid = fork();
 
@@ -154,7 +165,7 @@ TEST(get_syscall_info)
 			}
 			ASSERT_LT(0, (rc = sys_ptrace(PTRACE_GET_SYSCALL_INFO,
 						      pid, size,
-						      (unsigned long) &info))) {
+						      (uintptr_t) &info))) {
 				LOG_KILL_TRACEE("PTRACE_GET_SYSCALL_INFO: %m");
 			}
 			ASSERT_EQ(expected_none_size, rc) {
@@ -177,7 +188,7 @@ TEST(get_syscall_info)
 		case SIGTRAP | 0x80:
 			ASSERT_LT(0, (rc = sys_ptrace(PTRACE_GET_SYSCALL_INFO,
 						      pid, size,
-						      (unsigned long) &info))) {
+						      (uintptr_t) &info))) {
 				LOG_KILL_TRACEE("PTRACE_GET_SYSCALL_INFO: %m");
 			}
 			switch (ptrace_stop) {
-- 
ldv

