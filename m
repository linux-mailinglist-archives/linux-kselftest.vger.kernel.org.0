Return-Path: <linux-kselftest+bounces-36949-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E9F7AFFF7C
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jul 2025 12:43:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC7857AFE68
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jul 2025 10:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 852D42D8DBE;
	Thu, 10 Jul 2025 10:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="KwQ+XrX1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 402AA2D97AC
	for <linux-kselftest@vger.kernel.org>; Thu, 10 Jul 2025 10:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752144222; cv=none; b=r5A/J3nGmMjWvNW5lRv3CAp7Z03RR6ETzvwPJpOQLXg4B/DEEdVdb1Kc9wKDN7fFpfKBW22Kw7bv+rqoYqSRi2U+MKAfBt7UNsmG2ozAfB2qDwoKj/5hmNXkYMhJJDgAqjT1+SpIDe8uQ1FBIiEQRSZfScXIsIDbMO/MO3zhIqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752144222; c=relaxed/simple;
	bh=KHLXfK8LOHoZCOq/Q97Nxi08t9DxZduEu4Ktdm7Qx/g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DfnmhNd6yG5tK62G9R5aD7QPpDA84EIZHmRgaHT6j1Ak7at/E+yqxjKCzWJVr2AW0JYZYeElVp5YtoDPfGJRVGRuTdI3Vbrfu4VQicklmq8UCgIC4lP6RHmI1Sbjn80zMfBDzixWoFmIb20/rFst3gJrs0KrxPsRmM8ZYNUFtvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=KwQ+XrX1; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=dBY1QZeqaJPtpvC9YHUSj3o3Rvlz6NcC/zaC/yG2fbk=;
	t=1752144220; x=1753353820; b=KwQ+XrX1b60IuVgxtSnPtJNc9NI9+fH99ERQu8U6XGCRuFm
	XRk/aOsXPeyfA7+PAAjatuuibE6tMhhh66ikbZ0FUHpcQdY3AAlNbcOvo626IHVAJ2RvwhkSjHizW
	zuar1Jk/ljbV/TsEvoFKKkMF1+frwIXcgtsZ1QFF4mo1/TpTfBxW2lKZzM0UvbgUbxUcom1ud1pVC
	VHHMhCtIA2mLEt2XObpjXd9bxpHjf3CY7MVjs5KJdpR60gByHnSqnrKzj3av13IxT+2AhAwbvJ0vx
	lZyYXc+wDVXXt7Q+iwOqhTzo7F7ETIuM1pLzPnqzxAI2WKM2f57jzD//kBL0ZVKQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1uZokT-0000000Eg4e-2LxN;
	Thu, 10 Jul 2025 12:43:30 +0200
From: Benjamin Berg <benjamin@sipsolutions.net>
To: Willy Tarreau <w@1wt.eu>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	linux-kselftest@vger.kernel.org
Cc: Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH v2 4/4] tools/nolibc: add signal support
Date: Thu, 10 Jul 2025 12:39:50 +0200
Message-ID: <20250710103950.1272379-5-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250710103950.1272379-1-benjamin@sipsolutions.net>
References: <20250710103950.1272379-1-benjamin@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Benjamin Berg <benjamin.berg@intel.com>

Add support for sigaction() and implement the normal sa_mask helpers.

On many architectures, linux/signal.h pulls in compatibility definitions
for the old sigaction syscall instead of rt_sigaction. However, the
kernel can be compiled without support for this compatibility syscall
and it also results in sa_mask to be too small for realtime signals.

To work around this, the includes are handled separately for each
architecture. This way either linux/signal.h or the asm-generic headers
can be used to get the correct definition for the rt_sigaction syscall
including sigset_t.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>

---

v2:
- Use newly added macros to check signal emission order
- Add tests for sigset handling
- Restore the default handler after signal test
- make signal_check variable static

v1:
- Update architecture support (adding sh)
- Move sparc sys_rt_sigaction logic into its header
- Add sig_atomic_t
- Use new BITSET_* macros
- Move test into syscall suite
- Various other small changes
---
 tools/include/nolibc/arch-arm.h              |   7 ++
 tools/include/nolibc/arch-arm64.h            |   3 +
 tools/include/nolibc/arch-loongarch.h        |   3 +
 tools/include/nolibc/arch-m68k.h             |  10 ++
 tools/include/nolibc/arch-mips.h             |   3 +
 tools/include/nolibc/arch-powerpc.h          |   8 ++
 tools/include/nolibc/arch-riscv.h            |   3 +
 tools/include/nolibc/arch-s390.h             |   8 +-
 tools/include/nolibc/arch-sh.h               |   5 +
 tools/include/nolibc/arch-sparc.h            |  47 ++++++++
 tools/include/nolibc/arch-x86.h              |  13 +++
 tools/include/nolibc/signal.h                | 103 +++++++++++++++++
 tools/include/nolibc/sys.h                   |   2 +-
 tools/include/nolibc/time.h                  |   3 +-
 tools/include/nolibc/types.h                 |   9 ++
 tools/testing/selftests/nolibc/nolibc-test.c | 115 +++++++++++++++++++
 16 files changed, 338 insertions(+), 4 deletions(-)

diff --git a/tools/include/nolibc/arch-arm.h b/tools/include/nolibc/arch-arm.h
index 1f66e7e5a444..1faf6c2dbeb8 100644
--- a/tools/include/nolibc/arch-arm.h
+++ b/tools/include/nolibc/arch-arm.h
@@ -10,6 +10,13 @@
 #include "compiler.h"
 #include "crt.h"
 
+/* Needed to get the correct struct sigaction definition */
+#define SA_RESTORER	0x04000000
+
+/* Avoid linux/signal.h, it has an incorrect _NSIG and sigset_t */
+#include <asm-generic/signal.h>
+#include <asm-generic/siginfo.h>
+
 /* Syscalls for ARM in ARM or Thumb modes :
  *   - registers are 32-bit
  *   - stack is 8-byte aligned
diff --git a/tools/include/nolibc/arch-arm64.h b/tools/include/nolibc/arch-arm64.h
index 02a3f74c8ec8..ad14fc0ae5cb 100644
--- a/tools/include/nolibc/arch-arm64.h
+++ b/tools/include/nolibc/arch-arm64.h
@@ -10,6 +10,9 @@
 #include "compiler.h"
 #include "crt.h"
 
+/* Architecture has a usable linux/signal.h */
+#include <linux/signal.h>
+
 /* Syscalls for ARM64 :
  *   - registers are 64-bit
  *   - stack is 16-byte aligned
diff --git a/tools/include/nolibc/arch-loongarch.h b/tools/include/nolibc/arch-loongarch.h
index 5511705303ea..68d60d04ef59 100644
--- a/tools/include/nolibc/arch-loongarch.h
+++ b/tools/include/nolibc/arch-loongarch.h
@@ -10,6 +10,9 @@
 #include "compiler.h"
 #include "crt.h"
 
+/* Architecture has a usable linux/signal.h */
+#include <linux/signal.h>
+
 /* Syscalls for LoongArch :
  *   - stack is 16-byte aligned
  *   - syscall number is passed in a7
diff --git a/tools/include/nolibc/arch-m68k.h b/tools/include/nolibc/arch-m68k.h
index 6dac1845f298..981b4cc55a69 100644
--- a/tools/include/nolibc/arch-m68k.h
+++ b/tools/include/nolibc/arch-m68k.h
@@ -13,6 +13,16 @@
 #include "compiler.h"
 #include "crt.h"
 
+/*
+ * Needed to get the correct struct sigaction definition. m68k does not use
+ * sa_restorer, but it is included in the structure.
+ */
+#define SA_RESTORER	0x04000000
+
+/* Avoid linux/signal.h, it has an incorrect _NSIG and sigset_t */
+#include <asm-generic/signal.h>
+#include <asm-generic/siginfo.h>
+
 #define _NOLIBC_SYSCALL_CLOBBERLIST "memory"
 
 #define my_syscall0(num)                                                      \
diff --git a/tools/include/nolibc/arch-mips.h b/tools/include/nolibc/arch-mips.h
index 0cbac63b249a..fb2f503f151f 100644
--- a/tools/include/nolibc/arch-mips.h
+++ b/tools/include/nolibc/arch-mips.h
@@ -14,6 +14,9 @@
 #error Unsupported MIPS ABI
 #endif
 
+/* Architecture has a usable linux/signal.h */
+#include <linux/signal.h>
+
 /* Syscalls for MIPS ABI O32 :
  *   - WARNING! there's always a delayed slot!
  *   - WARNING again, the syntax is different, registers take a '$' and numbers
diff --git a/tools/include/nolibc/arch-powerpc.h b/tools/include/nolibc/arch-powerpc.h
index 204564bbcd32..c846a7ddcf3c 100644
--- a/tools/include/nolibc/arch-powerpc.h
+++ b/tools/include/nolibc/arch-powerpc.h
@@ -10,6 +10,14 @@
 #include "compiler.h"
 #include "crt.h"
 
+/* Needed to get the correct struct sigaction definition */
+#define SA_RESTORER	0x04000000
+#define _NOLIBC_ARCH_NEEDS_SA_RESTORER
+
+/* Avoid linux/signal.h, it has an incorrect _NSIG and sigset_t */
+#include <asm-generic/signal.h>
+#include <asm-generic/siginfo.h>
+
 /* Syscalls for PowerPC :
  *   - stack is 16-byte aligned
  *   - syscall number is passed in r0
diff --git a/tools/include/nolibc/arch-riscv.h b/tools/include/nolibc/arch-riscv.h
index 885383a86c38..709e6a262d9a 100644
--- a/tools/include/nolibc/arch-riscv.h
+++ b/tools/include/nolibc/arch-riscv.h
@@ -10,6 +10,9 @@
 #include "compiler.h"
 #include "crt.h"
 
+/* Architecture has a usable linux/signal.h */
+#include <linux/signal.h>
+
 /* Syscalls for RISCV :
  *   - stack is 16-byte aligned
  *   - syscall number is passed in a7
diff --git a/tools/include/nolibc/arch-s390.h b/tools/include/nolibc/arch-s390.h
index df4c3cc713ac..0dccb6d1ad64 100644
--- a/tools/include/nolibc/arch-s390.h
+++ b/tools/include/nolibc/arch-s390.h
@@ -5,13 +5,19 @@
 
 #ifndef _NOLIBC_ARCH_S390_H
 #define _NOLIBC_ARCH_S390_H
-#include <linux/signal.h>
 #include <linux/unistd.h>
 
 #include "compiler.h"
 #include "crt.h"
 #include "std.h"
 
+/* Needed to get the correct struct sigaction definition */
+#define SA_RESTORER	0x04000000
+
+/* Avoid linux/signal.h, it has an incorrect _NSIG and sigset_t */
+#include <asm-generic/signal.h>
+#include <asm-generic/siginfo.h>
+
 /* Syscalls for s390:
  *   - registers are 64-bit
  *   - syscall number is passed in r1
diff --git a/tools/include/nolibc/arch-sh.h b/tools/include/nolibc/arch-sh.h
index a96b8914607e..3378afc78e26 100644
--- a/tools/include/nolibc/arch-sh.h
+++ b/tools/include/nolibc/arch-sh.h
@@ -7,9 +7,14 @@
 #ifndef _NOLIBC_ARCH_SH_H
 #define _NOLIBC_ARCH_SH_H
 
+#include <linux/unistd.h>
+
 #include "compiler.h"
 #include "crt.h"
 
+/* Architecture has a usable linux/signal.h */
+#include <linux/signal.h>
+
 /*
  * Syscalls for SuperH:
  *   - registers are 32bit wide
diff --git a/tools/include/nolibc/arch-sparc.h b/tools/include/nolibc/arch-sparc.h
index ca420d843e25..c9574e7f795a 100644
--- a/tools/include/nolibc/arch-sparc.h
+++ b/tools/include/nolibc/arch-sparc.h
@@ -12,6 +12,10 @@
 #include "compiler.h"
 #include "crt.h"
 
+/* The includes are sane, if one sets __WANT_POSIX1B_SIGNALS__ */
+#define __WANT_POSIX1B_SIGNALS__
+#include <linux/signal.h>
+
 /*
  * Syscalls for SPARC:
  *   - registers are native word size
@@ -204,4 +208,47 @@ pid_t sys_vfork(void)
 }
 #define sys_vfork sys_vfork
 
+#define __nolibc_sa_restorer __nolibc_sa_restorer
+void __nolibc_sa_restorer(void);
+void __nolibc_sa_restorer_wrapper(void);
+void __attribute__((weak,noreturn)) __nolibc_entrypoint __no_stack_protector
+__nolibc_sa_restorer_wrapper(void)
+{
+	/* The C function will have a prologue corrupting "sp" */
+	__asm__  volatile (
+		".section .text\n"
+		".align 4\n"
+		".type __nolibc_sa_restorer, @function\n"
+		"__nolibc_sa_restorer:\n"
+		"nop\n"
+		"nop\n"
+		"mov %0, %%g1 \n"
+#ifdef __arch64__
+		"t 0x6d\n"
+#else
+		"t 0x10\n"
+#endif
+		".size __nolibc_sa_restorer, .-__nolibc_sa_restorer\n"
+		:: "n"(__NR_rt_sigreturn)
+	);
+	__nolibc_entrypoint_epilogue();
+}
+
+/*
+ * sparc has ODD_RT_SIGACTION, we need to pass the restorer as an argument
+ * to rt_sigaction.
+ */
+#define sys_rt_sigaction sys_rt_sigaction
+static __attribute__((unused))
+int sys_rt_sigaction(int signum, const struct sigaction *act, struct sigaction *oldact)
+{
+	struct sigaction real_act = *act;
+
+	/* Otherwise we would need to use sigreturn instead of rt_sigreturn */
+	real_act.sa_flags |= SA_SIGINFO;
+
+	return my_syscall5(__NR_rt_sigaction, signum, &real_act, oldact,
+			   __nolibc_sa_restorer, sizeof(act->sa_mask));
+}
+
 #endif /* _NOLIBC_ARCH_SPARC_H */
diff --git a/tools/include/nolibc/arch-x86.h b/tools/include/nolibc/arch-x86.h
index d3efc0c3b8ad..1fe75203d834 100644
--- a/tools/include/nolibc/arch-x86.h
+++ b/tools/include/nolibc/arch-x86.h
@@ -10,8 +10,21 @@
 #include "compiler.h"
 #include "crt.h"
 
+/* Needed to get the correct struct sigaction definition */
+#define SA_RESTORER	0x04000000
+
+/* Restorer must be set on x86 for both 32 and 64 bit */
+#define _NOLIBC_ARCH_NEEDS_SA_RESTORER
+
+/* Avoid linux/signal.h, it has an incorrect _NSIG and sigset_t */
+#include <asm-generic/signal.h>
+#include <asm-generic/siginfo.h>
+
 #if !defined(__x86_64__)
 
+/* On i386 we need to set SA_SIGINFO to use rt_sigreturn */
+#define _NOLIBC_ARCH_FORCE_SIG_FLAGS SA_SIGINFO
+
 /* Syscalls for i386 :
  *   - mostly similar to x86_64
  *   - registers are 32-bit
diff --git a/tools/include/nolibc/signal.h b/tools/include/nolibc/signal.h
index ac13e53ac31d..16b8b17496bc 100644
--- a/tools/include/nolibc/signal.h
+++ b/tools/include/nolibc/signal.h
@@ -14,6 +14,14 @@
 #include "arch.h"
 #include "types.h"
 #include "sys.h"
+#include "string.h"
+/* other signal definitions are included by arch.h */
+
+/* The kernel headers do not provide a sig_atomic_t definition */
+#ifndef __sig_atomic_t_defined
+#define __sig_atomic_t_defined 1
+typedef int sig_atomic_t;
+#endif
 
 /* This one is not marked static as it's needed by libgcc for divide by zero */
 int raise(int signal);
@@ -23,4 +31,99 @@ int raise(int signal)
 	return sys_kill(sys_getpid(), signal);
 }
 
+/*
+ * sigaction(int signum, const struct sigaction *act, struct sigaction *oldact)
+ */
+#if defined(_NOLIBC_ARCH_NEEDS_SA_RESTORER) && !defined(__nolibc_sa_restorer)
+static __no_stack_protector
+void __nolibc_sa_restorer(void)
+{
+	my_syscall0(__NR_rt_sigreturn);
+}
+#endif
+
+#ifndef sys_rt_sigaction
+static __attribute__((unused))
+int sys_rt_sigaction(int signum, const struct sigaction *act, struct sigaction *oldact)
+{
+	struct sigaction real_act = *act;
+#if defined(_NOLIBC_ARCH_NEEDS_SA_RESTORER)
+	if (!(real_act.sa_flags & SA_RESTORER)) {
+		real_act.sa_flags |= SA_RESTORER;
+		real_act.sa_restorer = __nolibc_sa_restorer;
+	}
+#endif
+#ifdef _NOLIBC_ARCH_FORCE_SIG_FLAGS
+	real_act.sa_flags |= _NOLIBC_ARCH_FORCE_SIG_FLAGS;
+#endif
+
+	return my_syscall4(__NR_rt_sigaction, signum, &real_act, oldact,
+			   sizeof(act->sa_mask));
+}
+#endif
+
+static __attribute__((unused))
+int sigaction(int signum, const struct sigaction *act, struct sigaction *oldact)
+{
+	return __sysret(sys_rt_sigaction(signum, act, oldact));
+}
+
+/*
+ * int sigemptyset(sigset_t *set)
+ */
+static __attribute__((unused))
+int sigemptyset(sigset_t *set)
+{
+	__NOLIBC_BITMASK_ZERO(set->sig);
+	return 0;
+}
+
+/*
+ * int sigfillset(sigset_t *set)
+ */
+static __attribute__((unused))
+int sigfillset(sigset_t *set)
+{
+	__NOLIBC_BITMASK_FILL(set->sig);
+	return 0;
+}
+
+/*
+ * int sigaddset(sigset_t *set, int signum)
+ */
+static __attribute__((unused))
+int sigaddset(sigset_t *set, int signum)
+{
+	if (signum < 1 || signum > _NSIG)
+		return __sysret(-EINVAL);
+
+	__NOLIBC_BITMASK_SET(signum - 1, set->sig);
+	return 0;
+}
+
+/*
+ * int sigdelset(sigset_t *set, int signum)
+ */
+static __attribute__((unused))
+int sigdelset(sigset_t *set, int signum)
+{
+	if (signum < 1 || signum > _NSIG)
+		return __sysret(-EINVAL);
+
+	__NOLIBC_BITMASK_CLEAR(signum - 1, set->sig);
+	return 0;
+}
+
+/*
+ * int sigismember(sigset_t *set, int signum)
+ */
+static __attribute__((unused))
+int sigismember(sigset_t *set, int signum)
+{
+	if (signum < 1 || signum > _NSIG)
+		return __sysret(-EINVAL);
+
+	return __NOLIBC_BITMASK_TEST(signum - 1, set->sig);
+}
+
 #endif /* _NOLIBC_SIGNAL_H */
diff --git a/tools/include/nolibc/sys.h b/tools/include/nolibc/sys.h
index 295e71d34aba..73b935576561 100644
--- a/tools/include/nolibc/sys.h
+++ b/tools/include/nolibc/sys.h
@@ -14,7 +14,6 @@
 
 /* system includes */
 #include <linux/unistd.h>
-#include <linux/signal.h>  /* for SIGCHLD */
 #include <linux/termios.h>
 #include <linux/mman.h>
 #include <linux/fs.h>
@@ -24,6 +23,7 @@
 #include <linux/fcntl.h> /* for O_* and AT_* */
 #include <linux/sched.h> /* for clone_args */
 #include <linux/stat.h>  /* for statx() */
+/* signal definitions are included by arch.h */
 
 #include "errno.h"
 #include "stdarg.h"
diff --git a/tools/include/nolibc/time.h b/tools/include/nolibc/time.h
index d02bc44d2643..103574f76515 100644
--- a/tools/include/nolibc/time.h
+++ b/tools/include/nolibc/time.h
@@ -14,9 +14,8 @@
 #include "arch.h"
 #include "types.h"
 #include "sys.h"
-
-#include <linux/signal.h>
 #include <linux/time.h>
+/* signal definitions are included by arch.h */
 
 static __inline__
 void __nolibc_timespec_user_to_kernel(const struct timespec *ts, struct __kernel_timespec *kts)
diff --git a/tools/include/nolibc/types.h b/tools/include/nolibc/types.h
index f7f2ddf41e89..7e205386b72c 100644
--- a/tools/include/nolibc/types.h
+++ b/tools/include/nolibc/types.h
@@ -152,6 +152,15 @@
 			(*__set)[__idx] = 0;				\
 	} while (0)
 
+#define __NOLIBC_BITMASK_FILL(set) do {					\
+		__typeof__(set) *__set = &(set);			\
+		int __idx;						\
+		int __size = sizeof(*__set) / sizeof(**__set);		\
+		__typeof__(**__set) __zero = 0;				\
+		for (__idx = 0; __idx < __size; __idx++)		\
+			(*__set)[__idx] = ~__zero;			\
+	} while (0)
+
 #define FD_SETIDXMASK (8 * sizeof(unsigned long))
 #define FD_SETBITMASK (8 * sizeof(unsigned long)-1)
 
diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index d612150d2ea3..fcd44b27cd5e 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -1293,6 +1293,120 @@ int test_namespace(void)
 	return ret;
 }
 
+sig_atomic_t signal_check;
+
+static void sighandler(int signum)
+{
+	if (signum == SIGUSR1) {
+		kill(getpid(), SIGUSR2);
+		/* The second step has not run because SIGUSR2 is masked */
+		MARK_STEP_DONE(signal_check, 0);
+	} else {
+		MARK_STEP_DONE(signal_check, 1);
+	}
+}
+
+int test_signals(int test_idx)
+{
+	struct sigaction sa = {
+		.sa_flags = 0,
+		.sa_handler = sighandler,
+	};
+	struct sigaction sa_old = {
+		/* Anything other than SIG_DFL */
+		.sa_handler = sighandler,
+	};
+	int llen; /* line length */
+	int ret = 0;
+	int res;
+
+	signal_check = 0;
+
+#ifdef NOLIBC
+	/* Do some checks on sa_mask handling */
+	sigfillset(&sa.sa_mask);
+	llen = printf("    sa_mask.sig[0] (full): ");
+	EXPECT_EQ(1, sa.sa_mask.sig[0],
+		     ~(__typeof__(sa.sa_mask.sig[0]))0);
+	llen = printf("    sa_mask.sig[%d] (full): ", (int)_NSIG_WORDS - 1);
+	EXPECT_EQ(1, sa.sa_mask.sig[_NSIG_WORDS - 1],
+		     ~(__typeof__(sa.sa_mask.sig[0]))0);
+
+	sigemptyset(&sa.sa_mask);
+	llen = printf("    sa_mask.sig[0] (empty): ");
+	EXPECT_EQ(1, sa.sa_mask.sig[0], 0);
+	llen = printf("    sa_mask.sig[%d] (empty): ", (int)_NSIG_WORDS - 1);
+	EXPECT_EQ(1, sa.sa_mask.sig[_NSIG_WORDS - 1], 0);
+
+	/* SIGUSR2 is always in the first word */
+	sigaddset(&sa.sa_mask, SIGUSR2);
+	llen = printf("    sa_mask.sig[0] (SIGUSR2 set): ");
+	EXPECT_EQ(1, sa.sa_mask.sig[0], 1 << (SIGUSR2 - 1));
+
+	llen = printf("    sa_mask.sig[0] (test SIGUSR2): ");
+	EXPECT_NZ(1, sigismember(&sa.sa_mask, SIGUSR2));
+
+	sigdelset(&sa.sa_mask, SIGUSR2);
+	llen = printf("    sa_mask.sig[0] (SIGUSR2 unset): ");
+	EXPECT_ZR(1, sigismember(&sa.sa_mask, SIGUSR2));
+
+	/* _NSIG is the highest valid number and may not be in the first word */
+	sigaddset(&sa.sa_mask, _NSIG);
+	llen = printf("    sa_mask.sig[%d] (_NSIG set): ", (int)_NSIG_WORDS - 1);
+	EXPECT_EQ(1, sa.sa_mask.sig[_NSIG_WORDS - 1],
+		     1UL << (_NSIG - (_NSIG_WORDS - 1) * _NSIG_BPW - 1));
+
+	llen = printf("    sa_mask.sig[%d] (test _NSIG): ", (int)_NSIG_WORDS - 1);
+	EXPECT_NZ(1, sigismember(&sa.sa_mask, _NSIG));
+
+	sigdelset(&sa.sa_mask, _NSIG);
+	llen = printf("    sa_mask.sig[%d] (_NSIG unset): ", (int)_NSIG_WORDS - 1);
+	EXPECT_ZR(1, sigismember(&sa.sa_mask, _NSIG));
+#endif
+
+	/* sa_mask is empty at this point, set SIGUSR2 to verify masking */
+	sigaddset(&sa.sa_mask, SIGUSR2);
+
+	res = sigaction(SIGUSR1, &sa, &sa_old);
+	llen = printf("    register SIGUSR1: %d", res);
+	EXPECT_SYSZR(1, res);
+	if (res)
+		goto out;
+
+	llen = printf("    sa_old.sa_handler: SIG_DFL (%p)", SIG_DFL);
+	EXPECT_PTREQ(1, SIG_DFL, sa_old.sa_handler);
+	if (res)
+		goto out;
+
+	res = sigaction(SIGUSR2, &sa, NULL);
+	llen = printf("    register SIGUSR2: %d", res);
+	EXPECT_SYSZR(1, res);
+	if (res)
+		goto out;
+
+	/* Trigger the first signal. */
+	kill(getpid(), SIGUSR1);
+
+	/* Check the two signal handlers ran in the expected order */
+	llen = printf("    signal emission: ");
+	EXPECT_STEPS(1, signal_check, 2);
+
+out:
+	sa.sa_handler = SIG_DFL;
+	res = sigaction(SIGUSR1, &sa, NULL);
+	llen = printf("    restore SIGUSR1: %d", res);
+	EXPECT_SYSZR(1, res);
+
+	res = sigaction(SIGUSR1, &sa, NULL);
+	llen = printf("    restore SIGUSR2: %d", res);
+	EXPECT_SYSZR(1, res);
+
+	llen = printf("%d %s", test_idx, "sigaction");
+	EXPECT_EQ(1, res, 0);
+
+	return ret;
+}
+
 /* Run syscall tests between IDs <min> and <max>.
  * Return 0 on success, non-zero on failure.
  */
@@ -1421,6 +1535,7 @@ int run_syscall(int min, int max)
 		CASE_TEST(syscall_noargs);    EXPECT_SYSEQ(1, syscall(__NR_getpid), getpid()); break;
 		CASE_TEST(syscall_args);      EXPECT_SYSER(1, syscall(__NR_statx, 0, NULL, 0, 0, NULL), -1, EFAULT); break;
 		CASE_TEST(namespace);         EXPECT_SYSZR(euid0 && proc, test_namespace()); break;
+		case __LINE__:                ret += test_signals(test); break;
 		case __LINE__:
 			return ret; /* must be last */
 		/* note: do not set any defaults so as to permit holes above */
-- 
2.50.0


