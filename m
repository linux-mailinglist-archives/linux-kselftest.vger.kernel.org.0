Return-Path: <linux-kselftest+bounces-27542-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B126BA451EB
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Feb 2025 02:07:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E14E19C38CE
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Feb 2025 01:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39A7315852F;
	Wed, 26 Feb 2025 01:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S6wJRlTP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D4342A9D;
	Wed, 26 Feb 2025 01:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740532058; cv=none; b=jRIAOPRgTAxUuFK+4K2Z9NoFHy4hh+6dOlQzrZEm0SvLosn3JObaLpzYiqHRQSTqxEut/STaTdqj0/TlYndjDwWTGVotD+YSmRIoELRRBY1g4tzCzmStgrIIJetFBzMzEmzHuVcywokJkISK5lkyB2r9r1asWdWEVRkpgyLSCic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740532058; c=relaxed/simple;
	bh=CDBcft1we3o/9e/Ovr02k3sW+m+b+C4klkPtxBiADrI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TfGYx02Xd1n82OxzLkjzMjo6T07SocDKXFErR+soM0NrNQ21truQiSZ0FtPvAachN3xZUb0sAUkpdxfz6uPXSsYDeg7c74il/qLR55+W6Yj3IQUch0ho/oBT30vK6KB/fmztHqXR8AS8g6owFiv/b7T4AkxTLs3kMke51An2q8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S6wJRlTP; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740532055; x=1772068055;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CDBcft1we3o/9e/Ovr02k3sW+m+b+C4klkPtxBiADrI=;
  b=S6wJRlTP7j/YNnNuqtd/FBhdJpv4I2UssZapI2kaOLfW7C6/6xoHSNwW
   WBXos4vnhBvuZnPcsmK3VOxWryTh1ft/p0r/lNEkaPS/lv+eQfd52Ajmb
   WUNrDfO11GpmP1UN+XGYKa5juiDcNvlt34VAl87/59wnOsiSli1/Yn396
   T1z1CZE5QFm/0kv/vHu7IRqefMhZCO6beTZ/EiyJ3O5E1IViZh2cRca98
   kf6nn4cl+4z5IRiAfRJ06cuET3ejTVdTDBHhv7mf2wPY+frMAUxdtAcXF
   hSML001vqeox5zxZ9x+rPKU6vn9qHfzbjCyWp04kx4wR/7rQX19icr5az
   g==;
X-CSE-ConnectionGUID: 8OjaT546SFOGaxe/N5XcWw==
X-CSE-MsgGUID: ThwQq+EvRTyFaebYyj4Ttg==
X-IronPort-AV: E=McAfee;i="6700,10204,11356"; a="52362178"
X-IronPort-AV: E=Sophos;i="6.13,316,1732608000"; 
   d="scan'208";a="52362178"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 17:07:34 -0800
X-CSE-ConnectionGUID: Dk7yFpSgR96F6IbRCfxjCQ==
X-CSE-MsgGUID: V3oTVSOnTL6JDtR63UvfLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="147467335"
Received: from cbae1-mobl.amr.corp.intel.com (HELO cbae1-mobl.intel.com) ([10.124.166.169])
  by fmviesa001.fm.intel.com with ESMTP; 25 Feb 2025 17:07:33 -0800
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: x86@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	shuah@kernel.org,
	chang.seok.bae@intel.com
Subject: [PATCH 1/9] selftests/x86: Consolidate redundant signal helper functions
Date: Tue, 25 Feb 2025 17:07:21 -0800
Message-ID: <20250226010731.2456-2-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250226010731.2456-1-chang.seok.bae@intel.com>
References: <20250226010731.2456-1-chang.seok.bae@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The x86 selftests frequently register and clean up signal handlers, but
the sethandler() and clearhandler() functions have been redundantly
copied across multiple .c files.

Move these functions to helpers.h to enable reuse across tests,
eliminating around 250 lines of duplicate code.

Converge the error handling by using ksft_exit_fail_msg(), which is
functionally equivalent with err() within the selftest framework.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
---
This change is a prerequisite for the upcoming xstate selftest, which
requires signal handling for registering and cleaning up handlers.

References:
* ksft_exit_fail_msg()
  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/testing/selftests/kselftest.h#n383
* err()
  https://sourceware.org/git/?p=glibc.git;a=blob;f=misc/err.c;h=2528d36e2da0f9c020c9a0bea3e18ae444f17ea8;hb=HEAD#l103
---
 tools/testing/selftests/x86/amx.c             | 25 +----------------
 .../selftests/x86/corrupt_xstate_header.c     | 14 +---------
 tools/testing/selftests/x86/entry_from_vm86.c | 24 ++--------------
 tools/testing/selftests/x86/fsgsbase.c        | 24 ++--------------
 tools/testing/selftests/x86/helpers.h         | 28 +++++++++++++++++++
 tools/testing/selftests/x86/ioperm.c          | 25 ++---------------
 tools/testing/selftests/x86/iopl.c            | 25 ++---------------
 tools/testing/selftests/x86/ldt_gdt.c         | 18 +++---------
 tools/testing/selftests/x86/mov_ss_trap.c     | 14 +---------
 tools/testing/selftests/x86/ptrace_syscall.c  | 24 ++--------------
 tools/testing/selftests/x86/sigaltstack.c     | 26 ++---------------
 tools/testing/selftests/x86/sigreturn.c       | 24 ++--------------
 .../selftests/x86/single_step_syscall.c       | 22 ---------------
 .../testing/selftests/x86/syscall_arg_fault.c | 12 --------
 tools/testing/selftests/x86/syscall_nt.c      | 12 --------
 tools/testing/selftests/x86/sysret_rip.c      | 24 ++--------------
 tools/testing/selftests/x86/test_vsyscall.c   | 13 ---------
 tools/testing/selftests/x86/unwind_vdso.c     | 12 --------
 18 files changed, 51 insertions(+), 315 deletions(-)

diff --git a/tools/testing/selftests/x86/amx.c b/tools/testing/selftests/x86/amx.c
index 1fdf35a4d7f6..0f355f331f41 100644
--- a/tools/testing/selftests/x86/amx.c
+++ b/tools/testing/selftests/x86/amx.c
@@ -20,6 +20,7 @@
 #include <sys/uio.h>
 
 #include "../kselftest.h" /* For __cpuid_count() */
+#include "helpers.h"
 
 #ifndef __x86_64__
 # error This test is 64-bit only
@@ -61,30 +62,6 @@ static inline void xrstor(struct xsave_buffer *xbuf, uint64_t rfbm)
 /* err() exits and will not return */
 #define fatal_error(msg, ...)	err(1, "[FAIL]\t" msg, ##__VA_ARGS__)
 
-static void sethandler(int sig, void (*handler)(int, siginfo_t *, void *),
-		       int flags)
-{
-	struct sigaction sa;
-
-	memset(&sa, 0, sizeof(sa));
-	sa.sa_sigaction = handler;
-	sa.sa_flags = SA_SIGINFO | flags;
-	sigemptyset(&sa.sa_mask);
-	if (sigaction(sig, &sa, 0))
-		fatal_error("sigaction");
-}
-
-static void clearhandler(int sig)
-{
-	struct sigaction sa;
-
-	memset(&sa, 0, sizeof(sa));
-	sa.sa_handler = SIG_DFL;
-	sigemptyset(&sa.sa_mask);
-	if (sigaction(sig, &sa, 0))
-		fatal_error("sigaction");
-}
-
 #define XFEATURE_XTILECFG	17
 #define XFEATURE_XTILEDATA	18
 #define XFEATURE_MASK_XTILECFG	(1 << XFEATURE_XTILECFG)
diff --git a/tools/testing/selftests/x86/corrupt_xstate_header.c b/tools/testing/selftests/x86/corrupt_xstate_header.c
index cf9ce8fbb656..93a89a5997ca 100644
--- a/tools/testing/selftests/x86/corrupt_xstate_header.c
+++ b/tools/testing/selftests/x86/corrupt_xstate_header.c
@@ -18,6 +18,7 @@
 #include <sys/wait.h>
 
 #include "../kselftest.h" /* For __cpuid_count() */
+#include "helpers.h"
 
 static inline int xsave_enabled(void)
 {
@@ -29,19 +30,6 @@ static inline int xsave_enabled(void)
 	return ecx & (1U << 27);
 }
 
-static void sethandler(int sig, void (*handler)(int, siginfo_t *, void *),
-		       int flags)
-{
-	struct sigaction sa;
-
-	memset(&sa, 0, sizeof(sa));
-	sa.sa_sigaction = handler;
-	sa.sa_flags = SA_SIGINFO | flags;
-	sigemptyset(&sa.sa_mask);
-	if (sigaction(sig, &sa, 0))
-		err(1, "sigaction");
-}
-
 static void sigusr1(int sig, siginfo_t *info, void *uc_void)
 {
 	ucontext_t *uc = uc_void;
diff --git a/tools/testing/selftests/x86/entry_from_vm86.c b/tools/testing/selftests/x86/entry_from_vm86.c
index d1e919b0c1dc..5cb8393737d0 100644
--- a/tools/testing/selftests/x86/entry_from_vm86.c
+++ b/tools/testing/selftests/x86/entry_from_vm86.c
@@ -24,31 +24,11 @@
 #include <errno.h>
 #include <sys/vm86.h>
 
+#include "helpers.h"
+
 static unsigned long load_addr = 0x10000;
 static int nerrs = 0;
 
-static void sethandler(int sig, void (*handler)(int, siginfo_t *, void *),
-		       int flags)
-{
-	struct sigaction sa;
-	memset(&sa, 0, sizeof(sa));
-	sa.sa_sigaction = handler;
-	sa.sa_flags = SA_SIGINFO | flags;
-	sigemptyset(&sa.sa_mask);
-	if (sigaction(sig, &sa, 0))
-		err(1, "sigaction");
-}
-
-static void clearhandler(int sig)
-{
-	struct sigaction sa;
-	memset(&sa, 0, sizeof(sa));
-	sa.sa_handler = SIG_DFL;
-	sigemptyset(&sa.sa_mask);
-	if (sigaction(sig, &sa, 0))
-		err(1, "sigaction");
-}
-
 static sig_atomic_t got_signal;
 
 static void sighandler(int sig, siginfo_t *info, void *ctx_void)
diff --git a/tools/testing/selftests/x86/fsgsbase.c b/tools/testing/selftests/x86/fsgsbase.c
index 50cf32de6313..0a75252d31b6 100644
--- a/tools/testing/selftests/x86/fsgsbase.c
+++ b/tools/testing/selftests/x86/fsgsbase.c
@@ -28,6 +28,8 @@
 #include <sys/wait.h>
 #include <setjmp.h>
 
+#include "helpers.h"
+
 #ifndef __x86_64__
 # error This test is 64-bit only
 #endif
@@ -39,28 +41,6 @@ static unsigned short *shared_scratch;
 
 static int nerrs;
 
-static void sethandler(int sig, void (*handler)(int, siginfo_t *, void *),
-		       int flags)
-{
-	struct sigaction sa;
-	memset(&sa, 0, sizeof(sa));
-	sa.sa_sigaction = handler;
-	sa.sa_flags = SA_SIGINFO | flags;
-	sigemptyset(&sa.sa_mask);
-	if (sigaction(sig, &sa, 0))
-		err(1, "sigaction");
-}
-
-static void clearhandler(int sig)
-{
-	struct sigaction sa;
-	memset(&sa, 0, sizeof(sa));
-	sa.sa_handler = SIG_DFL;
-	sigemptyset(&sa.sa_mask);
-	if (sigaction(sig, &sa, 0))
-		err(1, "sigaction");
-}
-
 static void sigsegv(int sig, siginfo_t *si, void *ctx_void)
 {
 	ucontext_t *ctx = (ucontext_t*)ctx_void;
diff --git a/tools/testing/selftests/x86/helpers.h b/tools/testing/selftests/x86/helpers.h
index 4ef42c4559a9..6deaad035161 100644
--- a/tools/testing/selftests/x86/helpers.h
+++ b/tools/testing/selftests/x86/helpers.h
@@ -2,8 +2,13 @@
 #ifndef __SELFTESTS_X86_HELPERS_H
 #define __SELFTESTS_X86_HELPERS_H
 
+#include <signal.h>
+#include <string.h>
+
 #include <asm/processor-flags.h>
 
+#include "../kselftest.h"
+
 static inline unsigned long get_eflags(void)
 {
 #ifdef __x86_64__
@@ -22,4 +27,27 @@ static inline void set_eflags(unsigned long eflags)
 #endif
 }
 
+static inline void sethandler(int sig, void (*handler)(int, siginfo_t *, void *), int flags)
+{
+	struct sigaction sa;
+
+	memset(&sa, 0, sizeof(sa));
+	sa.sa_sigaction = handler;
+	sa.sa_flags = SA_SIGINFO | flags;
+	sigemptyset(&sa.sa_mask);
+	if (sigaction(sig, &sa, 0))
+		ksft_exit_fail_msg("sigaction failed");
+}
+
+static inline void clearhandler(int sig)
+{
+	struct sigaction sa;
+
+	memset(&sa, 0, sizeof(sa));
+	sa.sa_handler = SIG_DFL;
+	sigemptyset(&sa.sa_mask);
+	if (sigaction(sig, &sa, 0))
+		ksft_exit_fail_msg("sigaction failed");
+}
+
 #endif /* __SELFTESTS_X86_HELPERS_H */
diff --git a/tools/testing/selftests/x86/ioperm.c b/tools/testing/selftests/x86/ioperm.c
index 57ec5e99edb9..69d5fb7050c2 100644
--- a/tools/testing/selftests/x86/ioperm.c
+++ b/tools/testing/selftests/x86/ioperm.c
@@ -20,31 +20,10 @@
 #include <sched.h>
 #include <sys/io.h>
 
+#include "helpers.h"
+
 static int nerrs = 0;
 
-static void sethandler(int sig, void (*handler)(int, siginfo_t *, void *),
-		       int flags)
-{
-	struct sigaction sa;
-	memset(&sa, 0, sizeof(sa));
-	sa.sa_sigaction = handler;
-	sa.sa_flags = SA_SIGINFO | flags;
-	sigemptyset(&sa.sa_mask);
-	if (sigaction(sig, &sa, 0))
-		err(1, "sigaction");
-
-}
-
-static void clearhandler(int sig)
-{
-	struct sigaction sa;
-	memset(&sa, 0, sizeof(sa));
-	sa.sa_handler = SIG_DFL;
-	sigemptyset(&sa.sa_mask);
-	if (sigaction(sig, &sa, 0))
-		err(1, "sigaction");
-}
-
 static jmp_buf jmpbuf;
 
 static void sigsegv(int sig, siginfo_t *si, void *ctx_void)
diff --git a/tools/testing/selftests/x86/iopl.c b/tools/testing/selftests/x86/iopl.c
index 7e3e09c1abac..457b6715542b 100644
--- a/tools/testing/selftests/x86/iopl.c
+++ b/tools/testing/selftests/x86/iopl.c
@@ -20,31 +20,10 @@
 #include <sched.h>
 #include <sys/io.h>
 
+#include "helpers.h"
+
 static int nerrs = 0;
 
-static void sethandler(int sig, void (*handler)(int, siginfo_t *, void *),
-		       int flags)
-{
-	struct sigaction sa;
-	memset(&sa, 0, sizeof(sa));
-	sa.sa_sigaction = handler;
-	sa.sa_flags = SA_SIGINFO | flags;
-	sigemptyset(&sa.sa_mask);
-	if (sigaction(sig, &sa, 0))
-		err(1, "sigaction");
-
-}
-
-static void clearhandler(int sig)
-{
-	struct sigaction sa;
-	memset(&sa, 0, sizeof(sa));
-	sa.sa_handler = SIG_DFL;
-	sigemptyset(&sa.sa_mask);
-	if (sigaction(sig, &sa, 0))
-		err(1, "sigaction");
-}
-
 static jmp_buf jmpbuf;
 
 static void sigsegv(int sig, siginfo_t *si, void *ctx_void)
diff --git a/tools/testing/selftests/x86/ldt_gdt.c b/tools/testing/selftests/x86/ldt_gdt.c
index 3a29346e1452..bb99a71380a5 100644
--- a/tools/testing/selftests/x86/ldt_gdt.c
+++ b/tools/testing/selftests/x86/ldt_gdt.c
@@ -26,6 +26,8 @@
 #include <asm/prctl.h>
 #include <sys/prctl.h>
 
+#include "helpers.h"
+
 #define AR_ACCESSED		(1<<8)
 
 #define AR_TYPE_RODATA		(0 * (1<<9))
@@ -506,20 +508,6 @@ static void fix_sa_restorer(int sig)
 }
 #endif
 
-static void sethandler(int sig, void (*handler)(int, siginfo_t *, void *),
-		       int flags)
-{
-	struct sigaction sa;
-	memset(&sa, 0, sizeof(sa));
-	sa.sa_sigaction = handler;
-	sa.sa_flags = SA_SIGINFO | flags;
-	sigemptyset(&sa.sa_mask);
-	if (sigaction(sig, &sa, 0))
-		err(1, "sigaction");
-
-	fix_sa_restorer(sig);
-}
-
 static jmp_buf jmpbuf;
 
 static void sigsegv(int sig, siginfo_t *info, void *ctx_void)
@@ -549,9 +537,11 @@ static void do_multicpu_tests(void)
 	}
 
 	sethandler(SIGSEGV, sigsegv, 0);
+	fix_sa_restorer(SIGSEGV);
 #ifdef __i386__
 	/* True 32-bit kernels send SIGILL instead of SIGSEGV on IRET faults. */
 	sethandler(SIGILL, sigsegv, 0);
+	fix_sa_restorer(SIGILL);
 #endif
 
 	printf("[RUN]\tCross-CPU LDT invalidation\n");
diff --git a/tools/testing/selftests/x86/mov_ss_trap.c b/tools/testing/selftests/x86/mov_ss_trap.c
index cc3de6ff9fba..f22cb6b382f9 100644
--- a/tools/testing/selftests/x86/mov_ss_trap.c
+++ b/tools/testing/selftests/x86/mov_ss_trap.c
@@ -36,7 +36,7 @@
 #include <setjmp.h>
 #include <sys/prctl.h>
 
-#define X86_EFLAGS_RF (1UL << 16)
+#include "helpers.h"
 
 #if __x86_64__
 # define REG_IP REG_RIP
@@ -94,18 +94,6 @@ static void enable_watchpoint(void)
 	}
 }
 
-static void sethandler(int sig, void (*handler)(int, siginfo_t *, void *),
-		       int flags)
-{
-	struct sigaction sa;
-	memset(&sa, 0, sizeof(sa));
-	sa.sa_sigaction = handler;
-	sa.sa_flags = SA_SIGINFO | flags;
-	sigemptyset(&sa.sa_mask);
-	if (sigaction(sig, &sa, 0))
-		err(1, "sigaction");
-}
-
 static char const * const signames[] = {
 	[SIGSEGV] = "SIGSEGV",
 	[SIGBUS] = "SIBGUS",
diff --git a/tools/testing/selftests/x86/ptrace_syscall.c b/tools/testing/selftests/x86/ptrace_syscall.c
index 12aaa063196e..360ec88d5432 100644
--- a/tools/testing/selftests/x86/ptrace_syscall.c
+++ b/tools/testing/selftests/x86/ptrace_syscall.c
@@ -15,6 +15,8 @@
 #include <asm/ptrace-abi.h>
 #include <sys/auxv.h>
 
+#include "helpers.h"
+
 /* Bitness-agnostic defines for user_regs_struct fields. */
 #ifdef __x86_64__
 # define user_syscall_nr	orig_rax
@@ -93,18 +95,6 @@ static siginfo_t wait_trap(pid_t chld)
 	return si;
 }
 
-static void sethandler(int sig, void (*handler)(int, siginfo_t *, void *),
-		       int flags)
-{
-	struct sigaction sa;
-	memset(&sa, 0, sizeof(sa));
-	sa.sa_sigaction = handler;
-	sa.sa_flags = SA_SIGINFO | flags;
-	sigemptyset(&sa.sa_mask);
-	if (sigaction(sig, &sa, 0))
-		err(1, "sigaction");
-}
-
 static void setsigign(int sig, int flags)
 {
 	struct sigaction sa;
@@ -116,16 +106,6 @@ static void setsigign(int sig, int flags)
 		err(1, "sigaction");
 }
 
-static void clearhandler(int sig)
-{
-	struct sigaction sa;
-	memset(&sa, 0, sizeof(sa));
-	sa.sa_handler = SIG_DFL;
-	sigemptyset(&sa.sa_mask);
-	if (sigaction(sig, &sa, 0))
-		err(1, "sigaction");
-}
-
 #ifdef __x86_64__
 # define REG_BP REG_RBP
 #else
diff --git a/tools/testing/selftests/x86/sigaltstack.c b/tools/testing/selftests/x86/sigaltstack.c
index f689af75e979..0ae1b784498c 100644
--- a/tools/testing/selftests/x86/sigaltstack.c
+++ b/tools/testing/selftests/x86/sigaltstack.c
@@ -14,6 +14,8 @@
 #include <sys/resource.h>
 #include <setjmp.h>
 
+#include "helpers.h"
+
 /* sigaltstack()-enforced minimum stack */
 #define ENFORCED_MINSIGSTKSZ	2048
 
@@ -27,30 +29,6 @@ static bool sigalrm_expected;
 
 static unsigned long at_minstack_size;
 
-static void sethandler(int sig, void (*handler)(int, siginfo_t *, void *),
-		       int flags)
-{
-	struct sigaction sa;
-
-	memset(&sa, 0, sizeof(sa));
-	sa.sa_sigaction = handler;
-	sa.sa_flags = SA_SIGINFO | flags;
-	sigemptyset(&sa.sa_mask);
-	if (sigaction(sig, &sa, 0))
-		err(1, "sigaction");
-}
-
-static void clearhandler(int sig)
-{
-	struct sigaction sa;
-
-	memset(&sa, 0, sizeof(sa));
-	sa.sa_handler = SIG_DFL;
-	sigemptyset(&sa.sa_mask);
-	if (sigaction(sig, &sa, 0))
-		err(1, "sigaction");
-}
-
 static int setup_altstack(void *start, unsigned long size)
 {
 	stack_t ss;
diff --git a/tools/testing/selftests/x86/sigreturn.c b/tools/testing/selftests/x86/sigreturn.c
index 0b75b29f794b..26ef562f4232 100644
--- a/tools/testing/selftests/x86/sigreturn.c
+++ b/tools/testing/selftests/x86/sigreturn.c
@@ -46,6 +46,8 @@
 #include <sys/ptrace.h>
 #include <sys/user.h>
 
+#include "helpers.h"
+
 /* Pull in AR_xyz defines. */
 typedef unsigned int u32;
 typedef unsigned short u16;
@@ -138,28 +140,6 @@ static unsigned short LDT3(int idx)
 	return (idx << 3) | 7;
 }
 
-static void sethandler(int sig, void (*handler)(int, siginfo_t *, void *),
-		       int flags)
-{
-	struct sigaction sa;
-	memset(&sa, 0, sizeof(sa));
-	sa.sa_sigaction = handler;
-	sa.sa_flags = SA_SIGINFO | flags;
-	sigemptyset(&sa.sa_mask);
-	if (sigaction(sig, &sa, 0))
-		err(1, "sigaction");
-}
-
-static void clearhandler(int sig)
-{
-	struct sigaction sa;
-	memset(&sa, 0, sizeof(sa));
-	sa.sa_handler = SIG_DFL;
-	sigemptyset(&sa.sa_mask);
-	if (sigaction(sig, &sa, 0))
-		err(1, "sigaction");
-}
-
 static void add_ldt(const struct user_desc *desc, unsigned short *var,
 		    const char *name)
 {
diff --git a/tools/testing/selftests/x86/single_step_syscall.c b/tools/testing/selftests/x86/single_step_syscall.c
index 9a30f443e928..280d7a22b9c9 100644
--- a/tools/testing/selftests/x86/single_step_syscall.c
+++ b/tools/testing/selftests/x86/single_step_syscall.c
@@ -33,28 +33,6 @@
 
 #include "helpers.h"
 
-static void sethandler(int sig, void (*handler)(int, siginfo_t *, void *),
-		       int flags)
-{
-	struct sigaction sa;
-	memset(&sa, 0, sizeof(sa));
-	sa.sa_sigaction = handler;
-	sa.sa_flags = SA_SIGINFO | flags;
-	sigemptyset(&sa.sa_mask);
-	if (sigaction(sig, &sa, 0))
-		err(1, "sigaction");
-}
-
-static void clearhandler(int sig)
-{
-	struct sigaction sa;
-	memset(&sa, 0, sizeof(sa));
-	sa.sa_handler = SIG_DFL;
-	sigemptyset(&sa.sa_mask);
-	if (sigaction(sig, &sa, 0))
-		err(1, "sigaction");
-}
-
 static volatile sig_atomic_t sig_traps, sig_eflags;
 sigjmp_buf jmpbuf;
 
diff --git a/tools/testing/selftests/x86/syscall_arg_fault.c b/tools/testing/selftests/x86/syscall_arg_fault.c
index 48ab065a76f9..f67a2df335ba 100644
--- a/tools/testing/selftests/x86/syscall_arg_fault.c
+++ b/tools/testing/selftests/x86/syscall_arg_fault.c
@@ -17,18 +17,6 @@
 
 #include "helpers.h"
 
-static void sethandler(int sig, void (*handler)(int, siginfo_t *, void *),
-		       int flags)
-{
-	struct sigaction sa;
-	memset(&sa, 0, sizeof(sa));
-	sa.sa_sigaction = handler;
-	sa.sa_flags = SA_SIGINFO | flags;
-	sigemptyset(&sa.sa_mask);
-	if (sigaction(sig, &sa, 0))
-		err(1, "sigaction");
-}
-
 static sigjmp_buf jmpbuf;
 
 static volatile sig_atomic_t n_errs;
diff --git a/tools/testing/selftests/x86/syscall_nt.c b/tools/testing/selftests/x86/syscall_nt.c
index a108b80dd082..f9c9814160f0 100644
--- a/tools/testing/selftests/x86/syscall_nt.c
+++ b/tools/testing/selftests/x86/syscall_nt.c
@@ -18,18 +18,6 @@
 
 static unsigned int nerrs;
 
-static void sethandler(int sig, void (*handler)(int, siginfo_t *, void *),
-		       int flags)
-{
-	struct sigaction sa;
-	memset(&sa, 0, sizeof(sa));
-	sa.sa_sigaction = handler;
-	sa.sa_flags = SA_SIGINFO | flags;
-	sigemptyset(&sa.sa_mask);
-	if (sigaction(sig, &sa, 0))
-		err(1, "sigaction");
-}
-
 static void sigtrap(int sig, siginfo_t *si, void *ctx_void)
 {
 }
diff --git a/tools/testing/selftests/x86/sysret_rip.c b/tools/testing/selftests/x86/sysret_rip.c
index b30de9aaa6d4..5fb531e3ad7c 100644
--- a/tools/testing/selftests/x86/sysret_rip.c
+++ b/tools/testing/selftests/x86/sysret_rip.c
@@ -22,6 +22,8 @@
 #include <sys/mman.h>
 #include <assert.h>
 
+#include "helpers.h"
+
 /*
  * These items are in clang_helpers_64.S, in order to avoid clang inline asm
  * limitations:
@@ -31,28 +33,6 @@ extern const char test_page[];
 
 static void const *current_test_page_addr = test_page;
 
-static void sethandler(int sig, void (*handler)(int, siginfo_t *, void *),
-		       int flags)
-{
-	struct sigaction sa;
-	memset(&sa, 0, sizeof(sa));
-	sa.sa_sigaction = handler;
-	sa.sa_flags = SA_SIGINFO | flags;
-	sigemptyset(&sa.sa_mask);
-	if (sigaction(sig, &sa, 0))
-		err(1, "sigaction");
-}
-
-static void clearhandler(int sig)
-{
-	struct sigaction sa;
-	memset(&sa, 0, sizeof(sa));
-	sa.sa_handler = SIG_DFL;
-	sigemptyset(&sa.sa_mask);
-	if (sigaction(sig, &sa, 0))
-		err(1, "sigaction");
-}
-
 /* State used by our signal handlers. */
 static gregset_t initial_regs;
 
diff --git a/tools/testing/selftests/x86/test_vsyscall.c b/tools/testing/selftests/x86/test_vsyscall.c
index 6de11b4df458..05e1e6774fba 100644
--- a/tools/testing/selftests/x86/test_vsyscall.c
+++ b/tools/testing/selftests/x86/test_vsyscall.c
@@ -310,19 +310,6 @@ static void test_getcpu(int cpu)
 static jmp_buf jmpbuf;
 static volatile unsigned long segv_err;
 
-static void sethandler(int sig, void (*handler)(int, siginfo_t *, void *),
-		       int flags)
-{
-	struct sigaction sa;
-
-	memset(&sa, 0, sizeof(sa));
-	sa.sa_sigaction = handler;
-	sa.sa_flags = SA_SIGINFO | flags;
-	sigemptyset(&sa.sa_mask);
-	if (sigaction(sig, &sa, 0))
-		ksft_exit_fail_msg("sigaction failed\n");
-}
-
 static void sigsegv(int sig, siginfo_t *info, void *ctx_void)
 {
 	ucontext_t *ctx = (ucontext_t *)ctx_void;
diff --git a/tools/testing/selftests/x86/unwind_vdso.c b/tools/testing/selftests/x86/unwind_vdso.c
index 4c311e1af4c7..9cc17588d818 100644
--- a/tools/testing/selftests/x86/unwind_vdso.c
+++ b/tools/testing/selftests/x86/unwind_vdso.c
@@ -43,18 +43,6 @@ int main()
 #include <dlfcn.h>
 #include <unwind.h>
 
-static void sethandler(int sig, void (*handler)(int, siginfo_t *, void *),
-		       int flags)
-{
-	struct sigaction sa;
-	memset(&sa, 0, sizeof(sa));
-	sa.sa_sigaction = handler;
-	sa.sa_flags = SA_SIGINFO | flags;
-	sigemptyset(&sa.sa_mask);
-	if (sigaction(sig, &sa, 0))
-		err(1, "sigaction");
-}
-
 static volatile sig_atomic_t nerrs;
 static unsigned long sysinfo;
 static bool got_sysinfo = false;
-- 
2.45.2


