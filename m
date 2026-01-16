Return-Path: <linux-kselftest+bounces-49164-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id ABF38D3338F
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Jan 2026 16:36:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 45CAB306F66D
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Jan 2026 15:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E38933A6EB;
	Fri, 16 Jan 2026 15:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="L/t8fIRh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-out3.simply.com (smtp-out3.simply.com [94.231.106.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DAE733A6E7;
	Fri, 16 Jan 2026 15:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.231.106.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768577461; cv=none; b=MaxauZ9uql6A7obtGdTrbQ3S0+0eXNTIchwC5hwWZVFQwC9kUca67228Ug0dUXGwx3vkLXIVB73RVsbaWOp0UrLJKvtEuTkGam7q4sejhimW+xh7V+i4+BF/rxIs4l0L8lNpzc+Jdj5uG4/PFkYn+fKJ8xUbxLmN9FVFWS5sizs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768577461; c=relaxed/simple;
	bh=IcFthlrYeG+gbqvQankeIfNvmjsw7u81x1q7iHNerrI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZqbQhpM0TrX3nph+eB9PxkzYurVCagxUcDb42mFNma80kYN6wHR6UTix/YhX0iDsf4+52BybcFVPZtXnEuwdb9BcixSGnD8+BJT39tS2vUvc34pUNVhMJYcfpNyjNt2gNd2YbejoC+c9EH+zeWwKmoWIYQi84monsaIwStIiUZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=fail (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=L/t8fIRh reason="key not found in DNS"; arc=none smtp.client-ip=94.231.106.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Received: from localhost (localhost [127.0.0.1])
	by smtp.simply.com (Simply.com) with ESMTP id 4dt3hr2rmyz1Ffyx;
	Fri, 16 Jan 2026 16:30:52 +0100 (CET)
Received: from ludwig.got.gaisler.com (h-98-128-223-123.NA.cust.bahnhof.se [98.128.223.123])
	by smtp.simply.com (Simply.com) with ESMTPA id 4dt3hr0bSDz1DDTf;
	Fri, 16 Jan 2026 16:30:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
	s=simplycom2; t=1768577452;
	bh=UnM2tQCR8mePF9ZCNVMq6/NyT3NCkF9jVAMSCvcGixI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=L/t8fIRhdcXjLpV8y7LaSBkgpV+Xc0SJS8l7sihF7E+E/qaI1RHdG1uHNKdyrCMgq
	 4r9XZ1eejyiYajX60hapaqrbP/1B7u3Wpfeu6IvJG+1R9m58P0nD2hpd563+MMLcEI
	 06xCEGLCGNpsPApLy2oDATkdTbLdr7t0Exo023pLXesXjurRIEnU6idrXwJiCfR5LM
	 IQ+HTLsCrHAJW3BXfuXjs3o/VnCWDFawvcTWtQZH487rFHBF/jkN6q3vUL4ImKlgNK
	 MhCq5SOIX0d+H8cFJOFOeRGqN5VvbuQR+txGl093CBsBtU+yaHOXfjNYjHxHicflRy
	 71DDSvhMG1oFA==
From: Ludwig Rydberg <ludwig.rydberg@gaisler.com>
To: davem@davemloft.net,
	andreas@gaisler.com,
	brauner@kernel.org,
	shuah@kernel.org
Cc: sparclinux@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	arnd@arndb.de,
	glaubitz@physik.fu-berlin.de,
	geert@linux-m68k.org,
	schuster.simon@siemens-energy.com
Subject: [PATCH 3/3] selftests/clone3: Add sys_clone3 wrapper for SPARC
Date: Fri, 16 Jan 2026 16:30:51 +0100
Message-Id: <20260116153051.21678-4-ludwig.rydberg@gaisler.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20260116153051.21678-1-ludwig.rydberg@gaisler.com>
References: <20260116153051.21678-1-ludwig.rydberg@gaisler.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a sys_clone3 wrapper (based on the INLINE_CLONE_SYSCALL macro
in glibc) for SPARC to handle its unique return call convention.

The needed handling is described in arch/sparc/kernel/process_{32|64}.c:

Parent -->  %o0 == child's  pid, %o1 == 0
Child  -->  %o0 == parent's pid, %o1 == 1

Signed-off-by: Ludwig Rydberg <ludwig.rydberg@gaisler.com>
---
 .../selftests/clone3/clone3_selftests.h       | 75 +++++++++++++++++++
 1 file changed, 75 insertions(+)

diff --git a/tools/testing/selftests/clone3/clone3_selftests.h b/tools/testing/selftests/clone3/clone3_selftests.h
index a0593e8950f0..5fa33294227d 100644
--- a/tools/testing/selftests/clone3/clone3_selftests.h
+++ b/tools/testing/selftests/clone3/clone3_selftests.h
@@ -33,12 +33,87 @@ struct __clone_args {
 	__aligned_u64 cgroup;
 };
 
+#if defined(__sparc__)
+#include <errno.h>
+
+#if	defined(__arch64__)
+#define __SYSCALL_STRING						\
+	"mov	%[scn], %%g1;"						\
+	"ta	0x6d;"							\
+	"bcc,pt	%%xcc, 1f;"						\
+	" nop;"								\
+	"sub	%%g0, %%o0, %%o0;"					\
+	"1:"
+
+#define __SYSCALL_CLOBBERS						\
+	"g1", "f0", "f1", "f2", "f3", "f4", "f5", "f6", "f7",		\
+	"f8", "f9", "f10", "f11", "f12", "f13", "f14", "f15",		\
+	"f16", "f17", "f18", "f19", "f20", "f21", "f22", "f23",		\
+	"f24", "f25", "f26", "f27", "f28", "f29", "f30", "f31",		\
+	"f32", "f34", "f36", "f38", "f40", "f42", "f44", "f46",		\
+	"f48", "f50", "f52", "f54", "f56", "f58", "f60", "f62",		\
+	"cc", "memory"
+#else
+#define __SYSCALL_STRING						\
+	"mov	%[scn], %%g1;"						\
+	"ta	0x10;"							\
+	"bcc	1f;"							\
+	" nop;"								\
+	"sub	%%g0, %%o0, %%o0;"					\
+	"1:"
+
+#define __SYSCALL_CLOBBERS						\
+	"g1", "f0", "f1", "f2", "f3", "f4", "f5", "f6", "f7",		\
+	"f8", "f9", "f10", "f11", "f12", "f13", "f14", "f15",		\
+	"f16", "f17", "f18", "f19", "f20", "f21", "f22", "f23",		\
+	"f24", "f25", "f26", "f27", "f28", "f29", "f30", "f31",		\
+	"cc", "memory"
+#endif
+
+/* A special wrapper is required to handle the return call convention
+ * on SPARC and is based on the INLINE_CLONE_SYSCALL macro in glibc.
+ *
+ * Parent -->  %o0 == child's  pid, %o1 == 0
+ * Child  -->  %o0 == parent's pid, %o1 == 1
+ */
+static inline pid_t sparc_clone3(struct __clone_args *args, size_t size)
+{
+	long _cl_args = (long) (args);
+	long _size = (long) (size);
+	long _scn = __NR_clone3;
+
+	register long o0 __asm__ ("o0") = _cl_args;
+	register long o1 __asm__ ("o1") = _size;
+
+	asm volatile (__SYSCALL_STRING
+			: "=r" (o0), "=r" (o1)
+			: [scn] "r" (_scn), "0" (o0), "1" (o1)
+			: __SYSCALL_CLOBBERS);
+
+	if ((unsigned long) (o0) > -4096UL) {
+		errno = -o0;
+		o0 = -1L;
+	} else {
+		o0 &= (o1 - 1);
+	}
+
+	return o0;
+}
+
+static pid_t sys_clone3(struct __clone_args *args, size_t size)
+{
+	fflush(stdout);
+	fflush(stderr);
+	return sparc_clone3(args, size);
+}
+#else
 static pid_t sys_clone3(struct __clone_args *args, size_t size)
 {
 	fflush(stdout);
 	fflush(stderr);
 	return syscall(__NR_clone3, args, size);
 }
+#endif
 
 static inline void test_clone3_supported(void)
 {
-- 
2.35.3


