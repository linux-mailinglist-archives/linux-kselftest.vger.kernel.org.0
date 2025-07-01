Return-Path: <linux-kselftest+bounces-36178-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 350EDAEF883
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Jul 2025 14:30:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B982016F426
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Jul 2025 12:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8C5D245022;
	Tue,  1 Jul 2025 12:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="ZqRMJwtG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B37433C4
	for <linux-kselftest@vger.kernel.org>; Tue,  1 Jul 2025 12:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751372977; cv=none; b=m+j3pHStLd7reZas0b6CyVhZTa2Fd2SFeko3SjvcNabXw10Mp9me2UJnVRi3rPnVcfexuWaMdowDObbUhM4pkh6SohgGbxD9YnDTxrNjJfPwJTjwrc5KKtf8nTOw4lP93dVJxAi1MDUOgjku8on9KsxBA2Kzqw/AkKNvAUoCxrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751372977; c=relaxed/simple;
	bh=NFXyUrH3z/pNbiAlM8gggrZR+mdEZF+u61ME/dRNgG8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HF8RF0S8+/s57u8MDYaELNStyQemNUbJTWdpmYGzXn543IO5NoI+ow0LxO4MTCSKyEQUr1Iv48xLOXC9HhFJt181fgLVBh16t1AxDLeiVQQJmVst174z8wjS2XXdUtUP4dtudgNSz3zM45vo7RWHJyn9KXc1dElBZD6v4RxXVIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=ZqRMJwtG; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=N2QZ5VmqhveeZldAweQnOhYdA36p5QMbRP30nxtQWFw=; t=1751372975; x=1752582575; 
	b=ZqRMJwtGEkO0JTVuPhNNjrVxurNDsoM7bqaTpo/bwDX2oSk5TEFv3aJVsKM7sDApCOlR99Z8XX+
	RlRRrmvqS5g5jsxBt1KXvrTO37DKh/ubRf7ufN88qHrKYij2Eog9lSYNu1t9rqbQw9AdurAGW6DCa
	loWyjrBnPpYbQy1ANmKgnAPF0tvFkaTLHF2ANiDTF51PIPMR9AXqSVHwbWuBnJuFa9ebdUZGY+lZS
	GHbIcMV88rdyd96npmHqk9yW62UDkIlA13SxVLjxhjEFzqR7siaynXRPgcGKPkRNG0mU2hisHCcCi
	iLhLRwD0r5k31vw8oPstM36u/mV1kYuxY0Hw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1uWa79-00000002lWn-3NY8;
	Tue, 01 Jul 2025 14:29:32 +0200
From: Benjamin Berg <benjamin@sipsolutions.net>
To: linux-kselftest@vger.kernel.org,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: Benjamin Berg <benjamin.berg@intel.com>
Subject: [RFC v2] tools/nolibc: add sigaction()
Date: Tue,  1 Jul 2025 14:29:10 +0200
Message-ID: <20250701122910.45823-1-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Benjamin Berg <benjamin.berg@intel.com>

In preparation to add tests that use it.

Note that some architectures do not have a usable linux/signal.h include
file. However, in those cases we can use asm-generic/signal.h instead.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>

---

Another attempt at signal handling for nolibc which should actually be
working. Some trickery is needed to get the right definition, but I feel
it is sufficiently clean this way.

Submitting this as RFC mostly because I do not yet have a proper patch
to add a test that uses the feature.

Benjamin
---
 tools/include/nolibc/arch-aarch64.h          |  3 +
 tools/include/nolibc/arch-arm.h              |  7 ++
 tools/include/nolibc/arch-i386.h             | 13 +++
 tools/include/nolibc/arch-loongarch.h        |  3 +
 tools/include/nolibc/arch-m68k.h             | 10 ++
 tools/include/nolibc/arch-mips.h             |  3 +
 tools/include/nolibc/arch-powerpc.h          |  8 ++
 tools/include/nolibc/arch-riscv.h            |  3 +
 tools/include/nolibc/arch-s390.h             |  8 +-
 tools/include/nolibc/arch-sparc.h            | 43 +++++++++
 tools/include/nolibc/arch-x86_64.h           | 10 ++
 tools/include/nolibc/signal.h                | 97 ++++++++++++++++++++
 tools/include/nolibc/sys.h                   |  2 +-
 tools/include/nolibc/time.h                  |  3 +-
 tools/testing/selftests/nolibc/nolibc-test.c | 52 +++++++++++
 15 files changed, 261 insertions(+), 4 deletions(-)

diff --git a/tools/include/nolibc/arch-aarch64.h b/tools/include/nolibc/arch-aarch64.h
index 937a348da42e..736aae6dbd47 100644
--- a/tools/include/nolibc/arch-aarch64.h
+++ b/tools/include/nolibc/arch-aarch64.h
@@ -10,6 +10,9 @@
 #include "compiler.h"
 #include "crt.h"
 
+/* Architecture has a usable linux/signal.h */
+#include <linux/signal.h>
+
 /* Syscalls for AARCH64 :
  *   - registers are 64-bit
  *   - stack is 16-byte aligned
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
diff --git a/tools/include/nolibc/arch-i386.h b/tools/include/nolibc/arch-i386.h
index 7c9b38e96418..fbec7490a92c 100644
--- a/tools/include/nolibc/arch-i386.h
+++ b/tools/include/nolibc/arch-i386.h
@@ -10,6 +10,19 @@
 #include "compiler.h"
 #include "crt.h"
 
+/* Needed to get the correct struct sigaction definition */
+#define SA_RESTORER	0x04000000
+
+/* Restorer must be set on i386 */
+#define _NOLIBC_ARCH_NEEDS_SA_RESTORER
+
+/* Otherwise we would need to use sigreturn instead of rt_sigreturn */
+#define _NOLIBC_ARCH_FORCE_SIG_FLAGS SA_SIGINFO
+
+/* Avoid linux/signal.h, it has an incorrect _NSIG and sigset_t */
+#include <asm-generic/signal.h>
+#include <asm-generic/siginfo.h>
+
 /* Syscalls for i386 :
  *   - mostly similar to x86_64
  *   - registers are 32-bit
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
index 753a8ed2cf69..a8837452e744 100644
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
diff --git a/tools/include/nolibc/arch-sparc.h b/tools/include/nolibc/arch-sparc.h
index 1435172f3dfe..303291d4b8fb 100644
--- a/tools/include/nolibc/arch-sparc.h
+++ b/tools/include/nolibc/arch-sparc.h
@@ -12,6 +12,19 @@
 #include "compiler.h"
 #include "crt.h"
 
+/* Otherwise we would need to use sigreturn instead of rt_sigreturn */
+#define _NOLIBC_ARCH_FORCE_SIG_FLAGS SA_SIGINFO
+
+/* The includes are sane, if one sets __WANT_POSIX1B_SIGNALS__ */
+#define __WANT_POSIX1B_SIGNALS__
+#include <linux/signal.h>
+
+/*
+ * sparc has ODD_RT_SIGACTION, we always pass our restorer as an argument
+ * to rt_sigaction. The restorer is implemented in this file.
+ */
+#define _NOLIBC_RT_SIGACTION_PASSES_RESTORER
+
 /*
  * Syscalls for SPARC:
  *   - registers are native word size
@@ -188,4 +201,34 @@ pid_t sys_fork(void)
 }
 #define sys_fork sys_fork
 
+#define __nolibc_stringify_1(x...)     #x
+#define __nolibc_stringify(x...)       __stringify_1(x)
+
+/* The compiler insists on adding a SAVE call to the start of every function */
+#define __nolibc_sa_restorer __nolibc_sa_restorer
+void __nolibc_sa_restorer (void);
+#ifdef __arch64__
+__asm__(                                                        \
+	".section .text\n"                                      \
+	".align  4 \n"                                          \
+	"__nolibc_sa_restorer:\n"                               \
+	"nop\n"                                                 \
+	"nop\n"                                                 \
+	"mov     " __stringify(__NR_rt_sigreturn) ", %g1 \n"    \
+	"t       0x6d \n");
+#else
+__asm__(                                                        \
+	".section .text\n"                                      \
+	".align  4 \n"                                          \
+	"__nolibc_sa_restorer:\n"                               \
+	"nop\n"                                                 \
+	"nop\n"                                                 \
+	"mov     " __stringify(__NR_rt_sigreturn) ", %g1 \n"    \
+	"t       0x10 \n"                                       \
+	);
+#endif
+
+#undef __nolibc_stringify_1(x...)
+#undef __nolibc_stringify
+
 #endif /* _NOLIBC_ARCH_SPARC_H */
diff --git a/tools/include/nolibc/arch-x86_64.h b/tools/include/nolibc/arch-x86_64.h
index 67305e24dbef..9f13a2205876 100644
--- a/tools/include/nolibc/arch-x86_64.h
+++ b/tools/include/nolibc/arch-x86_64.h
@@ -10,6 +10,16 @@
 #include "compiler.h"
 #include "crt.h"
 
+/* Needed to get the correct struct sigaction definition */
+#define SA_RESTORER	0x04000000
+
+/* Restorer must be set on i386 */
+#define _NOLIBC_ARCH_NEEDS_SA_RESTORER
+
+/* Avoid linux/signal.h, it has an incorrect _NSIG and sigset_t */
+#include <asm-generic/signal.h>
+#include <asm-generic/siginfo.h>
+
 /* Syscalls for x86_64 :
  *   - registers are 64-bit
  *   - syscall number is passed in rax
diff --git a/tools/include/nolibc/signal.h b/tools/include/nolibc/signal.h
index ac13e53ac31d..829672250ede 100644
--- a/tools/include/nolibc/signal.h
+++ b/tools/include/nolibc/signal.h
@@ -14,6 +14,8 @@
 #include "arch.h"
 #include "types.h"
 #include "sys.h"
+#include "string.h"
+/* signal definitions are included by arch.h */
 
 /* This one is not marked static as it's needed by libgcc for divide by zero */
 int raise(int signal);
@@ -23,4 +25,99 @@ int raise(int signal)
 	return sys_kill(sys_getpid(), signal);
 }
 
+/*
+ * sigaction(int signum, const struct sigaction *act, struct sigaction *oldact)
+ */
+#if defined(_NOLIBC_ARCH_NEEDS_SA_RESTORER) && !defined(__nolibc_sa_restorer)
+static __attribute__((noreturn)) __nolibc_entrypoint __no_stack_protector
+void __nolibc_sa_restorer(void)
+{
+	my_syscall0(__NR_rt_sigreturn);
+	__nolibc_entrypoint_epilogue();
+}
+#endif
+
+static __attribute__((unused))
+int sys_rt_sigaction(int signum, const struct sigaction *act, struct sigaction *oldact)
+{
+	struct sigaction real_act = *act;
+#if defined(SA_RESTORER) && defined(_NOLIBC_ARCH_NEEDS_SA_RESTORER)
+	if (!(real_act.sa_flags & SA_RESTORER)) {
+		real_act.sa_flags |= SA_RESTORER;
+		real_act.sa_restorer = __nolibc_sa_restorer;
+	}
+#endif
+#ifdef _NOLIBC_ARCH_FORCE_SIG_FLAGS
+	real_act.sa_flags |= _NOLIBC_ARCH_FORCE_SIG_FLAGS;
+#endif
+
+#ifndef _NOLIBC_RT_SIGACTION_PASSES_RESTORER
+	return my_syscall4(__NR_rt_sigaction, signum, &real_act, oldact,
+			   sizeof(act->sa_mask));
+#else
+	return my_syscall5(__NR_rt_sigaction, signum, &real_act, oldact,
+			   __nolibc_sa_restorer, sizeof(act->sa_mask));
+#endif
+}
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
+	memset(set, 0, sizeof(*set));
+	return 0;
+}
+
+/*
+ * int sigfillset(sigset_t *set)
+ */
+static __attribute__((unused))
+int sigfillset(sigset_t *set)
+{
+	memset(set, 0xff, sizeof(*set));
+	return 0;
+}
+
+/*
+ * int sigaddset(sigset_t *set, int signum)
+ */
+static __attribute__((unused))
+int sigaddset(sigset_t *set, int signum)
+{
+	set->sig[(signum - 1) / (8 * sizeof(set->sig[0]))] |=
+		1UL << ((signum - 1) % (8 * sizeof(set->sig[0])));
+	return 0;
+}
+
+/*
+ * int sigdelset(sigset_t *set, int signum)
+ */
+static __attribute__((unused))
+int sigdelset(sigset_t *set, int signum)
+{
+	set->sig[(signum - 1) / (8 * sizeof(set->sig[0]))] &=
+		~(1UL << ((signum - 1) % (8 * sizeof(set->sig[0]))));
+	return 0;
+}
+
+/*
+ * int sigismember(sigset_t *set, int signum)
+ */
+static __attribute__((unused))
+int sigismember(sigset_t *set, int signum)
+{
+	unsigned long res =
+		set->sig[(signum - 1) / (8 * sizeof(set->sig[0]))] &
+			(1UL << ((signum - 1) % (8 * sizeof(set->sig[0]))));
+	return !!res;
+}
+
 #endif /* _NOLIBC_SIGNAL_H */
diff --git a/tools/include/nolibc/sys.h b/tools/include/nolibc/sys.h
index 9556c69a6ae1..fb9a1ccf2440 100644
--- a/tools/include/nolibc/sys.h
+++ b/tools/include/nolibc/sys.h
@@ -14,7 +14,6 @@
 
 /* system includes */
 #include <linux/unistd.h>
-#include <linux/signal.h>  /* for SIGCHLD */
 #include <linux/termios.h>
 #include <linux/mman.h>
 #include <linux/fs.h>
@@ -23,6 +22,7 @@
 #include <linux/auxvec.h>
 #include <linux/fcntl.h> /* for O_* and AT_* */
 #include <linux/stat.h>  /* for statx() */
+/* signal definitions are included by arch.h */
 
 #include "errno.h"
 #include "stdarg.h"
diff --git a/tools/include/nolibc/time.h b/tools/include/nolibc/time.h
index fc387940d51f..70ef31d4117f 100644
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
diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index dbe13000fb1a..af66b739ea18 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -1750,6 +1750,57 @@ static int run_protection(int min __attribute__((unused)),
 	}
 }
 
+volatile int signal_check;
+
+void test_sighandler(int signum)
+{
+	if (signum == SIGUSR1) {
+		kill(getpid(), SIGUSR2);
+		signal_check = 1;
+	} else {
+		signal_check++;
+	}
+}
+
+int run_signal(int min, int max)
+{
+	struct sigaction sa = {
+		.sa_flags = 0,
+		.sa_handler = test_sighandler,
+	};
+	int llen; /* line length */
+	int ret = 0;
+	int res;
+
+	(void)min;
+	(void)max;
+
+	signal_check = 0;
+
+	sigemptyset(&sa.sa_mask);
+	sigaddset(&sa.sa_mask, SIGUSR2);
+
+	res = sigaction(SIGUSR1, &sa, NULL);
+	llen = printf("register SIGUSR1: %d", res);
+	EXPECT_EQ(1, 0, res);
+	res = sigaction(SIGUSR2, &sa, NULL);
+	llen = printf("register SIGUSR2: %d", res);
+	EXPECT_EQ(1, 0, res);
+
+	/* Trigger the first signal. */
+	kill(getpid(), SIGUSR1);
+
+	/* If signal_check is 1 or higher, then signal emission worked */
+	llen = printf("signal emission: 1 <= signal_check");
+	EXPECT_GE(1, signal_check, 1);
+
+	/* If it is 2, then signal masking worked */
+	llen = printf("signal masking: 2 == signal_check");
+	EXPECT_EQ(1, signal_check, 2);
+
+	return ret;
+}
+
 /* prepare what needs to be prepared for pid 1 (stdio, /dev, /proc, etc) */
 int prepare(void)
 {
@@ -1815,6 +1866,7 @@ static const struct test test_names[] = {
 	{ .name = "stdlib",     .func = run_stdlib     },
 	{ .name = "printf",     .func = run_printf     },
 	{ .name = "protection", .func = run_protection },
+	{ .name = "signal",     .func = run_signal },
 	{ 0 }
 };
 
-- 
2.50.0


