Return-Path: <linux-kselftest+bounces-38122-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A265B176F5
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Jul 2025 22:13:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D739167787
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Jul 2025 20:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80357254AFF;
	Thu, 31 Jul 2025 20:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="IEvARiUq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23ABA255F2F
	for <linux-kselftest@vger.kernel.org>; Thu, 31 Jul 2025 20:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753992811; cv=none; b=GpIpcY7ZVWhxDgzrbETcZFG2KwHHbZelfQspFdCSt+V60xVTISLiu+tRGdUgxrDIHXAqZY24mVjyeZ0+ZMmbqYdBkZvs1tnQsndWJdgzddqtEe9HVNQHhHK3kvX0D7BHFlOSaprmMlikzH9V1yyGOExAv5Fu4DNCox3N+BHPnTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753992811; c=relaxed/simple;
	bh=aLzs9dzRzEAo2tK4MMSIPwmSe2g7HxbVFmYyjD7PBmo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r1Vago6u4mxt+boqUyGOGcUMJY9AxUaHztAh2zTnR8TSo6+WtntDoeR+q2hV28UYhCMx9FIzCyxomUFWIN0gADaEgtVEmbHYltY8b6VnrouEeYkxmcj9c3zcgmdgWnBiOVaYnNEMaqXuc3I+Pm285h11F2ozL4YziDnD9l+FEHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=IEvARiUq; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=aONCkZFz1dWufjMCuDnfUixHHXn1+w6yllabDr7/79k=;
	t=1753992809; x=1755202409; b=IEvARiUqzJPUIoWgO8JMs5xIpTMur2TdNQbACXT1qvt3TOc
	0YV28g4TQOa4B44dXC3sm3J3QKkwLcfjUhQjQEBjTTmSt7+0ByXUa0TEfOIETrllGnJ1LRWLF+2ny
	XCd/l9IfDDPr9T7/ZfhW0kRjSEfHk5LYlcw/Y/paeKI1eJQBSjiDO8o6Udb0tfda0dROpMDUGr+nl
	q1y4lDj1dlLvSwguwp3Pe8hQPWPPi4VPBQDD5IB/NZ8QRaGX+o/Dd8CHaWntDxFQ127+t6HGaOAdn
	EYetoGd944uSB4aFDWcGcwAMKL5cPatHomt0uV4xLRvvt7Zv8i2LvpYzTzmmqUjg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1uhZeX-00000001lJH-3e8w;
	Thu, 31 Jul 2025 22:13:26 +0200
From: Benjamin Berg <benjamin@sipsolutions.net>
To: Willy Tarreau <w@1wt.eu>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	linux-kselftest@vger.kernel.org
Cc: Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH v3 4/4] tools/nolibc: add signal support
Date: Thu, 31 Jul 2025 22:12:25 +0200
Message-ID: <20250731201225.323254-5-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250731201225.323254-1-benjamin@sipsolutions.net>
References: <20250731201225.323254-1-benjamin@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Benjamin Berg <benjamin.berg@intel.com>

Add support for sigaction() using the rt_sigaction syscall and implement
the normal sa_mask helpers.

For the uapi definitions, everything is copied into nolibc. This avoids
issues with kernel architecture headers that are not usable with the
rt_sigaction syscall.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>

---

v3:
- put everything into signal.h and the new asm-signal.h
- split out sigset_t tests
- actually mark signal_check static
- remove unused string.h include
- fix SIGUSR2 reset
- Use integer for signal_check as the signals are emitted from the
  syscall context.

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
 tools/include/nolibc/Makefile                |   1 +
 tools/include/nolibc/arch-s390.h             |   4 +-
 tools/include/nolibc/asm-signal.h            | 237 +++++++++++++++++++
 tools/include/nolibc/signal.h                | 179 ++++++++++++++
 tools/include/nolibc/sys.h                   |   2 +-
 tools/include/nolibc/sys/wait.h              |   1 +
 tools/include/nolibc/time.h                  |   2 +-
 tools/include/nolibc/types.h                 |   9 +
 tools/testing/selftests/nolibc/nolibc-test.c | 134 +++++++++++
 9 files changed, 566 insertions(+), 3 deletions(-)
 create mode 100644 tools/include/nolibc/asm-signal.h

diff --git a/tools/include/nolibc/Makefile b/tools/include/nolibc/Makefile
index 143c2d2c2ba6..55db0677cfc3 100644
--- a/tools/include/nolibc/Makefile
+++ b/tools/include/nolibc/Makefile
@@ -25,6 +25,7 @@ endif
 
 arch_file := arch-$(ARCH).h
 all_files := \
+		asm-signal.h \
 		compiler.h \
 		crt.h \
 		ctype.h \
diff --git a/tools/include/nolibc/arch-s390.h b/tools/include/nolibc/arch-s390.h
index df4c3cc713ac..f22f9a6d9887 100644
--- a/tools/include/nolibc/arch-s390.h
+++ b/tools/include/nolibc/arch-s390.h
@@ -5,13 +5,15 @@
 
 #ifndef _NOLIBC_ARCH_S390_H
 #define _NOLIBC_ARCH_S390_H
-#include <linux/signal.h>
 #include <linux/unistd.h>
 
 #include "compiler.h"
 #include "crt.h"
 #include "std.h"
 
+/* For SIGCHLD */
+#include "asm-signal.h"
+
 /* Syscalls for s390:
  *   - registers are 64-bit
  *   - syscall number is passed in r1
diff --git a/tools/include/nolibc/asm-signal.h b/tools/include/nolibc/asm-signal.h
new file mode 100644
index 000000000000..7831595745a8
--- /dev/null
+++ b/tools/include/nolibc/asm-signal.h
@@ -0,0 +1,237 @@
+/* SPDX-License-Identifier: LGPL-2.1 OR MIT */
+/*
+ * ASM signal definitions for NOLIBC
+ */
+
+#ifndef _NOLIBC_ASM_SIGNAL_H
+#define _NOLIBC_ASM_SIGNAL_H
+
+/*
+ * This reproduces the kernel headers for the different architectures.
+ */
+
+#include <linux/types.h>
+
+#if defined(__mips__)
+#define _NSIG		128
+#else
+#define _NSIG		64
+#endif
+#define _NSIG_BPW	__BITS_PER_LONG
+#define _NSIG_WORDS	(_NSIG / _NSIG_BPW)
+
+typedef struct {
+	unsigned long sig[_NSIG_WORDS];
+} sigset_t;
+
+#if defined(__mips__)
+#define SIGHUP		 1	/* Hangup (POSIX).  */
+#define SIGINT		 2	/* Interrupt (ANSI).  */
+#define SIGQUIT		 3	/* Quit (POSIX).  */
+#define SIGILL		 4	/* Illegal instruction (ANSI).	*/
+#define SIGTRAP		 5	/* Trace trap (POSIX).	*/
+#define SIGIOT		 6	/* IOT trap (4.2 BSD).	*/
+#define SIGABRT		 SIGIOT /* Abort (ANSI).  */
+#define SIGEMT		 7
+#define SIGFPE		 8	/* Floating-point exception (ANSI).  */
+#define SIGKILL		 9	/* Kill, unblockable (POSIX).  */
+#define SIGBUS		10	/* BUS error (4.2 BSD).	 */
+#define SIGSEGV		11	/* Segmentation violation (ANSI).  */
+#define SIGSYS		12
+#define SIGPIPE		13	/* Broken pipe (POSIX).	 */
+#define SIGALRM		14	/* Alarm clock (POSIX).	 */
+#define SIGTERM		15	/* Termination (ANSI).	*/
+#define SIGUSR1		16	/* User-defined signal 1 (POSIX).  */
+#define SIGUSR2		17	/* User-defined signal 2 (POSIX).  */
+#define SIGCHLD		18	/* Child status has changed (POSIX).  */
+#define SIGCLD		SIGCHLD /* Same as SIGCHLD (System V).	*/
+#define SIGPWR		19	/* Power failure restart (System V).  */
+#define SIGWINCH	20	/* Window size change (4.3 BSD, Sun).  */
+#define SIGURG		21	/* Urgent condition on socket (4.2 BSD).  */
+#define SIGIO		22	/* I/O now possible (4.2 BSD).	*/
+#define SIGPOLL		SIGIO	/* Pollable event occurred (System V).	*/
+#define SIGSTOP		23	/* Stop, unblockable (POSIX).  */
+#define SIGTSTP		24	/* Keyboard stop (POSIX).  */
+#define SIGCONT		25	/* Continue (POSIX).  */
+#define SIGTTIN		26	/* Background read from tty (POSIX).  */
+#define SIGTTOU		27	/* Background write to tty (POSIX).  */
+#define SIGVTALRM	28	/* Virtual alarm clock (4.2 BSD).  */
+#define SIGPROF		29	/* Profiling alarm clock (4.2 BSD).  */
+#define SIGXCPU		30	/* CPU limit exceeded (4.2 BSD).  */
+#define SIGXFSZ		31	/* File size limit exceeded (4.2 BSD).	*/
+
+#elif defined(__sparc__)
+/* On the Sparc the signal handlers get passed a 'sub-signal' code
+ * for certain signal types, which we document here.
+ */
+#define SIGHUP		 1
+#define SIGINT		 2
+#define SIGQUIT		 3
+#define SIGILL		 4
+#define    SUBSIG_STACK       0
+#define    SUBSIG_ILLINST     2
+#define    SUBSIG_PRIVINST    3
+#define    SUBSIG_BADTRAP(t)  (0x80 + (t))
+
+#define SIGTRAP		 5
+#define SIGABRT		 6
+#define SIGIOT		 6
+
+#define SIGEMT           7
+#define    SUBSIG_TAG    10
+
+#define SIGFPE		 8
+#define    SUBSIG_FPDISABLED     0x400
+#define    SUBSIG_FPERROR        0x404
+#define    SUBSIG_FPINTOVFL      0x001
+#define    SUBSIG_FPSTSIG        0x002
+#define    SUBSIG_IDIVZERO       0x014
+#define    SUBSIG_FPINEXACT      0x0c4
+#define    SUBSIG_FPDIVZERO      0x0c8
+#define    SUBSIG_FPUNFLOW       0x0cc
+#define    SUBSIG_FPOPERROR      0x0d0
+#define    SUBSIG_FPOVFLOW       0x0d4
+
+#define SIGKILL		 9
+#define SIGBUS          10
+#define    SUBSIG_BUSTIMEOUT    1
+#define    SUBSIG_ALIGNMENT     2
+#define    SUBSIG_MISCERROR     5
+
+#define SIGSEGV		11
+#define    SUBSIG_NOMAPPING     3
+#define    SUBSIG_PROTECTION    4
+#define    SUBSIG_SEGERROR      5
+
+#define SIGSYS		12
+
+#define SIGPIPE		13
+#define SIGALRM		14
+#define SIGTERM		15
+#define SIGURG          16
+
+/* SunOS values which deviate from the Linux/i386 ones */
+#define SIGSTOP		17
+#define SIGTSTP		18
+#define SIGCONT		19
+#define SIGCHLD		20
+#define SIGTTIN		21
+#define SIGTTOU		22
+#define SIGIO		23
+#define SIGPOLL		SIGIO   /* SysV name for SIGIO */
+#define SIGXCPU		24
+#define SIGXFSZ		25
+#define SIGVTALRM	26
+#define SIGPROF		27
+#define SIGWINCH	28
+#define SIGLOST		29
+#define SIGPWR		SIGLOST
+#define SIGUSR1		30
+#define SIGUSR2		31
+
+#else /* asm-generic signal definitions */
+#define SIGHUP		 1
+#define SIGINT		 2
+#define SIGQUIT		 3
+#define SIGILL		 4
+#define SIGTRAP		 5
+#define SIGABRT		 6
+#define SIGIOT		 6
+#define SIGBUS		 7
+#define SIGFPE		 8
+#define SIGKILL		 9
+#define SIGUSR1		10
+#define SIGSEGV		11
+#define SIGUSR2		12
+#define SIGPIPE		13
+#define SIGALRM		14
+#define SIGTERM		15
+#define SIGSTKFLT	16
+#define SIGCHLD		17
+#define SIGCONT		18
+#define SIGSTOP		19
+#define SIGTSTP		20
+#define SIGTTIN		21
+#define SIGTTOU		22
+#define SIGURG		23
+#define SIGXCPU		24
+#define SIGXFSZ		25
+#define SIGVTALRM	26
+#define SIGPROF		27
+#define SIGWINCH	28
+#define SIGIO		29
+#define SIGPOLL		SIGIO
+/*
+#define SIGLOST		29
+*/
+#define SIGPWR		30
+#define SIGSYS		31
+#define	SIGUNUSED	31
+#endif
+
+/* These should not be considered constants from userland.  */
+#define SIGRTMIN	32
+#ifndef SIGRTMAX
+#define SIGRTMAX	_NSIG
+#endif
+
+#if !defined MINSIGSTKSZ || !defined SIGSTKSZ
+#if defined(__aarch64__)
+#define MINSIGSTKSZ	 5120
+#define SIGSTKSZ	16384
+#elif defined(__loongarch__) || defined(__sparc__)
+#define MINSIGSTKSZ	 4096
+#define SIGSTKSZ	16384
+#elif defined(__powerpc64__)
+#define MINSIGSTKSZ	 8192
+#define SIGSTKSZ	32768
+#else
+#define MINSIGSTKSZ	 2048
+#define SIGSTKSZ	 8192
+#endif
+#endif
+
+#if defined(__mips__)
+#define SA_ONSTACK      0x08000000
+#define SA_RESETHAND    0x80000000
+#define SA_RESTART      0x10000000
+#define SA_SIGINFO      0x00000008
+#define SA_NODEFER      0x40000000
+#define SA_NOCLDWAIT    0x00010000
+#define SA_NOCLDSTOP    0x00000001
+
+#elif defined(__sparc__)
+#define _SV_SSTACK    1u
+#define _SV_INTR      2u
+#define _SV_RESET     4u
+#define _SV_IGNCHILD  8u
+
+#define SA_NOCLDSTOP    _SV_IGNCHILD
+#define SA_STACK        _SV_SSTACK
+#define SA_ONSTACK      _SV_SSTACK
+#define SA_RESTART      _SV_INTR
+#define SA_RESETHAND    _SV_RESET
+#define SA_NODEFER      0x20u
+#define SA_NOCLDWAIT    0x100u
+#define SA_SIGINFO      0x200u
+
+#else
+#define SA_NOCLDSTOP    0x00000001
+#define SA_NOCLDWAIT    0x00000002
+#define SA_SIGINFO      0x00000004
+#define SA_UNSUPPORTED  0x00000400
+#define SA_EXPOSE_TAGBITS       0x00000800
+#define SA_ONSTACK      0x08000000
+#define SA_RESTART      0x10000000
+#define SA_NODEFER      0x40000000
+#define SA_RESETHAND    0x80000000
+#endif
+
+#define SA_NOMASK       SA_NODEFER
+#define SA_ONESHOT      SA_RESETHAND
+
+#if defined(__ARM_EABI__) || defined(__aarch64__) || defined(__m68k__) || defined(__powerpc__) || defined(__s390x__) || defined(__s390__) || defined(__sh__) || defined(__i386__) || defined(__x86_64__)
+#define SA_RESTORER	0x04000000
+#endif
+
+#endif /* _NOLIBC_ASM_SIGNAL_H */
\ No newline at end of file
diff --git a/tools/include/nolibc/signal.h b/tools/include/nolibc/signal.h
index ac13e53ac31d..8a71bba8c1b6 100644
--- a/tools/include/nolibc/signal.h
+++ b/tools/include/nolibc/signal.h
@@ -14,6 +14,46 @@
 #include "arch.h"
 #include "types.h"
 #include "sys.h"
+#include <asm/siginfo.h>
+#include "asm-signal.h"
+
+typedef void __signalfn_t(int);
+typedef __signalfn_t *__sighandler_t;
+
+typedef void __restorefn_t(void);
+typedef __restorefn_t *__sigrestore_t;
+
+#define SIG_DFL ((__sighandler_t)0)     /* default signal handling */
+#define SIG_IGN ((__sighandler_t)1)     /* ignore signal */
+#define SIG_ERR ((__sighandler_t)-1)    /* error return from signal */
+
+#if defined(__mips__)
+struct sigaction {
+        unsigned int    sa_flags;
+        __sighandler_t  sa_handler;
+        sigset_t        sa_mask;
+};
+#else
+struct sigaction {
+	__sighandler_t sa_handler;
+	unsigned long sa_flags;
+#if defined(SA_RESTORER) || defined(__sparc__)
+	__sigrestore_t sa_restorer;
+#endif
+	sigset_t sa_mask;		/* mask last for extensibility */
+};
+#endif
+
+typedef struct sigaltstack {
+	void *ss_sp;
+	int ss_flags;
+	__kernel_size_t ss_size;
+} stack_t;
+
+#ifndef __sig_atomic_t_defined
+#define __sig_atomic_t_defined 1
+typedef int sig_atomic_t;
+#endif
 
 /* This one is not marked static as it's needed by libgcc for divide by zero */
 int raise(int signal);
@@ -23,4 +63,143 @@ int raise(int signal)
 	return sys_kill(sys_getpid(), signal);
 }
 
+/*
+ * sigaction(int signum, const struct sigaction *act, struct sigaction *oldact)
+ */
+#if defined(__sparc__)
+/*
+ * Sparc needs a restorer, which needs to be implemented in assembler and
+ * passed as a separate argument.
+ */
+
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
+#else
+#if defined(__x86_64__) || defined(__i386_) || defined(__powerpc__)
+static __no_stack_protector
+void __nolibc_sa_restorer(void)
+{
+	my_syscall0(__NR_rt_sigreturn);
+}
+#endif
+
+static __attribute__((unused))
+int sys_rt_sigaction(int signum, const struct sigaction *act, struct sigaction *oldact)
+{
+	struct sigaction real_act = *act;
+#if defined(__x86_64__) || defined(__i386_) || defined(__powerpc__)
+	if (!(real_act.sa_flags & SA_RESTORER)) {
+		real_act.sa_flags |= SA_RESTORER;
+		real_act.sa_restorer = __nolibc_sa_restorer;
+	}
+#endif
+#if defined(__i386__)
+	/* Otherwise we would need to use sigreturn instead of rt_sigreturn */
+	real_act.sa_flags |= SA_SIGINFO;
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
index 295e71d34aba..a790e816565b 100644
--- a/tools/include/nolibc/sys.h
+++ b/tools/include/nolibc/sys.h
@@ -14,7 +14,6 @@
 
 /* system includes */
 #include <linux/unistd.h>
-#include <linux/signal.h>  /* for SIGCHLD */
 #include <linux/termios.h>
 #include <linux/mman.h>
 #include <linux/fs.h>
@@ -28,6 +27,7 @@
 #include "errno.h"
 #include "stdarg.h"
 #include "types.h"
+#include "asm-signal.h" /* for SIGCHLD */
 
 
 /* Syscall return helper: takes the syscall value in argument and checks for an
diff --git a/tools/include/nolibc/sys/wait.h b/tools/include/nolibc/sys/wait.h
index 56ddb806da7f..e2aa90cc3cf3 100644
--- a/tools/include/nolibc/sys/wait.h
+++ b/tools/include/nolibc/sys/wait.h
@@ -10,6 +10,7 @@
 #ifndef _NOLIBC_SYS_WAIT_H
 #define _NOLIBC_SYS_WAIT_H
 
+#include <asm/siginfo.h>
 #include "../arch.h"
 #include "../std.h"
 #include "../types.h"
diff --git a/tools/include/nolibc/time.h b/tools/include/nolibc/time.h
index d02bc44d2643..6734a3a702a6 100644
--- a/tools/include/nolibc/time.h
+++ b/tools/include/nolibc/time.h
@@ -15,7 +15,7 @@
 #include "types.h"
 #include "sys.h"
 
-#include <linux/signal.h>
+#include <asm/siginfo.h>
 #include <linux/time.h>
 
 static __inline__
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
index 180f0436127a..75b96eaa4c65 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -1269,6 +1269,138 @@ int test_namespace(void)
 	return ret;
 }
 
+int test_sigset_t(int test_idx)
+{
+	int llen;
+	int ret = 0;
+
+#ifdef NOLIBC
+	if (is_nolibc) {
+		sigset_t sigset;
+
+		sigfillset(&sigset);
+		llen = printf("    sigset.sig[0] (full): ");
+		EXPECT_EQ(1, sigset.sig[0],
+			~(__typeof__(sigset.sig[0]))0);
+		llen = printf("    sigset.sig[%d] (full): ", (int)_NSIG_WORDS - 1);
+		EXPECT_EQ(1, sigset.sig[_NSIG_WORDS - 1],
+			~(__typeof__(sigset.sig[0]))0);
+
+		sigemptyset(&sigset);
+		llen = printf("    sigset.sig[0] (empty): ");
+		EXPECT_EQ(1, sigset.sig[0], 0);
+		llen = printf("    sigset.sig[%d] (empty): ", (int)_NSIG_WORDS - 1);
+		EXPECT_EQ(1, sigset.sig[_NSIG_WORDS - 1], 0);
+
+		/* SIGUSR2 is always in the first word */
+		sigaddset(&sigset, SIGUSR2);
+		llen = printf("    sigset.sig[0] (SIGUSR2 set): ");
+		EXPECT_EQ(1, sigset.sig[0], 1 << (SIGUSR2 - 1));
+
+		llen = printf("    sigset.sig[0] (test SIGUSR2): ");
+		EXPECT_NZ(1, sigismember(&sigset, SIGUSR2));
+
+		sigdelset(&sigset, SIGUSR2);
+		llen = printf("    sigset.sig[0] (SIGUSR2 unset): ");
+		EXPECT_ZR(1, sigismember(&sigset, SIGUSR2));
+
+		/* _NSIG is the highest valid number and may not be in the first word */
+		sigaddset(&sigset, _NSIG);
+		llen = printf("    sigset.sig[%d] (_NSIG set): ", (int)_NSIG_WORDS - 1);
+		EXPECT_EQ(1, sigset.sig[_NSIG_WORDS - 1],
+			1UL << (_NSIG - (_NSIG_WORDS - 1) * _NSIG_BPW - 1));
+
+		llen = printf("    sigset.sig[%d] (test _NSIG): ", (int)_NSIG_WORDS - 1);
+		EXPECT_NZ(1, sigismember(&sigset, _NSIG));
+
+		sigdelset(&sigset, _NSIG);
+		llen = printf("    sigset.sig[%d] (_NSIG unset): ", (int)_NSIG_WORDS - 1);
+		EXPECT_ZR(1, sigismember(&sigset, _NSIG));
+
+		llen = printf("%d %s", test_idx, "sigset_t");
+		EXPECT_EQ(1, ret, 0);
+	} else
+#endif
+	{
+		llen = printf("%d %s", test_idx, "sigset_t");
+		result(llen, SKIPPED);
+	}
+
+	return ret;
+}
+
+static int signal_check;
+
+static void sighandler(int signum)
+{
+	if (signum == SIGUSR1) {
+		kill(getpid(), SIGUSR2);
+		/* The second step has not run because SIGUSR2 is masked */
+		signal_check = 0x1;
+	} else {
+		signal_check |= 0x2;
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
+	/* sa_mask is empty at this point, set SIGUSR2 to verify masking */
+	sigaddset(&sa.sa_mask, SIGUSR2);
+
+	res = sigaction(SIGUSR1, &sa, &sa_old);
+	llen = printf("    register SIGUSR1:");
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
+	llen = printf("    register SIGUSR2");
+	EXPECT_SYSZR(1, res);
+	if (res)
+		goto out;
+
+	/* Trigger the first signal. */
+	kill(getpid(), SIGUSR1);
+
+	/* Check the two signal handlers ran in the expected order */
+	llen = printf("    signal emission: ");
+	EXPECT_EQ(1, signal_check, 0x3);
+
+out:
+	sa.sa_handler = SIG_DFL;
+	res = sigaction(SIGUSR1, &sa, NULL);
+	llen = printf("    restore SIGUSR1");
+	EXPECT_SYSZR(1, res);
+
+	res = sigaction(SIGUSR2, &sa, NULL);
+	llen = printf("    restore SIGUSR2");
+	EXPECT_SYSZR(1, res);
+
+	llen = printf("%d %s", test_idx, "sigaction");
+	EXPECT_EQ(1, ret, 0);
+
+	return ret;
+}
+
 /* Run syscall tests between IDs <min> and <max>.
  * Return 0 on success, non-zero on failure.
  */
@@ -1397,6 +1529,8 @@ int run_syscall(int min, int max)
 		CASE_TEST(syscall_noargs);    EXPECT_SYSEQ(1, syscall(__NR_getpid), getpid()); break;
 		CASE_TEST(syscall_args);      EXPECT_SYSER(1, syscall(__NR_statx, 0, NULL, 0, 0, NULL), -1, EFAULT); break;
 		CASE_TEST(namespace);         EXPECT_SYSZR(euid0 && proc, test_namespace()); break;
+		case __LINE__:                ret += test_sigset_t(test); break;
+		case __LINE__:                ret += test_signals(test); break;
 		case __LINE__:
 			return ret; /* must be last */
 		/* note: do not set any defaults so as to permit holes above */
-- 
2.50.1


