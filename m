Return-Path: <linux-kselftest+bounces-24561-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ADE9A11F5B
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Jan 2025 11:27:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B0BA3A9ED0
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Jan 2025 10:27:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E8A8236EDC;
	Wed, 15 Jan 2025 10:27:27 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from vmicros1.altlinux.org (vmicros1.altlinux.org [194.107.17.57])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40E551F9F41;
	Wed, 15 Jan 2025 10:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.107.17.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736936847; cv=none; b=gRk69OGtYi6OA84amyPXhDCUfmCc4CTRcwLK+lyF5ThF+4QEFPmbHEuLPKuW80XsQ1FlJmeVMsW54ACNRDNu0IOfHLwmy4lzwE/NFBlUYztkIpP0YWMguAKja6e+DC81TrOJ+ih3W1nh71kVJ3iRoLe3IPr53x3KZkslwqhE7mE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736936847; c=relaxed/simple;
	bh=aizAfGesBPH/eyF5gvKfmPPNzOwtPNeUlgHuO1pcuf8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=sEvJcrmXOKM3G0ahXk008GgTuzTSwSy7Fl9+RrZgd6yUvY/weUpYsfifr9CWzym1Q1HnOl4MOpZl/QHIrP7ahgfa1csbXN0ZS9KemG5BAFhraO2w0rZv9b21LA7wwnz88YHQeZ/eKYtyssS9fRyT3+HgHYtUcXUvHPTONdi0V6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strace.io; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=194.107.17.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strace.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
	by vmicros1.altlinux.org (Postfix) with ESMTP id DE49E72C8CC;
	Wed, 15 Jan 2025 13:27:16 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
	id CC8B47CCB3A; Wed, 15 Jan 2025 12:27:16 +0200 (IST)
Date: Wed, 15 Jan 2025 12:27:16 +0200
From: "Dmitry V. Levin" <ldv@strace.io>
To: Shuah Khan <shuah@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>,
	"Maciej W. Rozycki" <macro@orcam.me.uk>,
	strace-devel@lists.strace.io, linux-kselftest@vger.kernel.org,
	linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] selftests/ptrace/get_syscall_info: fix for MIPS n32
Message-ID: <20250115102716.GA20911@strace.io>
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
architectures.

As a side effect, this also extends the test on all 64-bit architectures
by choosing constants that don't fit into 32-bit integers.

Signed-off-by: Dmitry V. Levin <ldv@strace.io>
---
 .../selftests/ptrace/get_syscall_info.c       | 53 +++++++++++--------
 1 file changed, 32 insertions(+), 21 deletions(-)

diff --git a/tools/testing/selftests/ptrace/get_syscall_info.c b/tools/testing/selftests/ptrace/get_syscall_info.c
index 5bcd1c7b5be6..812f64d15955 100644
--- a/tools/testing/selftests/ptrace/get_syscall_info.c
+++ b/tools/testing/selftests/ptrace/get_syscall_info.c
@@ -11,8 +11,19 @@
 #include <err.h>
 #include <signal.h>
 #include <asm/unistd.h>
+#include <linux/types.h>
 #include "linux/ptrace.h"
 
+#if defined(__mips__) && defined(_ABIN32)
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

