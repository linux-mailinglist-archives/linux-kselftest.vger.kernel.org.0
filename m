Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A02B16D3C9C
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Apr 2023 06:55:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231310AbjDCEzu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 3 Apr 2023 00:55:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230493AbjDCEzn (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 3 Apr 2023 00:55:43 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6764C8A5E;
        Sun,  2 Apr 2023 21:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680497740; x=1712033740;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=vfgDViWJ7zk/qoC5nEzW6DFni6a5M80nOTSbnNq7Un8=;
  b=SuNWSuOUu8oonDRg2vNQgq3yopLLfmeQYCPFUj/TCqtkuI1ubpse7IMD
   fww7Tgt5T6nhz5A7QkuHTDHvQJUNjLXL79UX6Id0XL1lDcRB1LQ5x5KjS
   R8d8RQ+R3+6N2qLGP9FGj3fiWrz0YZ60/VsC91eCngWZt+iRE+ICzByGP
   nPyoEIUN3vI8RMiavKlb52ObzAG0fL6Z2O3Z88Oiv14adeo0H1h2xY1XC
   ENnLeQ+TzuOqPoE5wB2PXIs3t0vmBFYuvSb9KzXCKXmwd4D6ttR92f9zM
   mBEIY2KtKDxCCOImx6Hu4fZR8pv+ofbkvBb/r8py7t2WLWvznRCeyVdyN
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10668"; a="344362552"
X-IronPort-AV: E=Sophos;i="5.98,314,1673942400"; 
   d="scan'208";a="344362552"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2023 21:55:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10668"; a="829421523"
X-IronPort-AV: E=Sophos;i="5.98,314,1673942400"; 
   d="scan'208";a="829421523"
Received: from chang-linux-3.sc.intel.com ([172.25.66.173])
  by fmsmga001.fm.intel.com with ESMTP; 02 Apr 2023 21:55:37 -0700
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     shuah@kernel.org, luto@kernel.org, dave.hansen@intel.com,
        tglx@linutronix.de, bp@suse.de, jun.miao@windriver.com,
        chang.seok.bae@intel.com, Borislav Petkov <bp@alien8.de>
Subject: [PATCH v1 3/4] selftests/x86: Consolidate signal handler helpers
Date:   Sun,  2 Apr 2023 21:43:39 -0700
Message-Id: <20230403044340.1312-4-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230403044340.1312-1-chang.seok.bae@intel.com>
References: <20230403044340.1312-1-chang.seok.bae@intel.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Many test cases have the same signal handler (un)register helpers
which have been copied exactly over there.

Clean up this by moving this helper into a common place. Also, update
the Makefile to support this shared code.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Cc: Shuah Khan <shuah@kernel.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Borislav Petkov <bp@alien8.de>
Cc: linux-kernel@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org
---
 tools/testing/selftests/x86/Makefile          | 16 ++++++++--
 tools/testing/selftests/x86/amx.c             | 25 +---------------
 .../selftests/x86/corrupt_xstate_header.c     | 15 +---------
 tools/testing/selftests/x86/entry_from_vm86.c | 25 ++--------------
 tools/testing/selftests/x86/fsgsbase.c        | 25 ++--------------
 tools/testing/selftests/x86/helpers.c         | 30 +++++++++++++++++++
 tools/testing/selftests/x86/helpers.h         |  6 ++++
 tools/testing/selftests/x86/ioperm.c          | 26 ++--------------
 tools/testing/selftests/x86/iopl.c            | 26 ++--------------
 tools/testing/selftests/x86/ldt_gdt.c         | 19 +++---------
 tools/testing/selftests/x86/mov_ss_trap.c     | 15 ++--------
 tools/testing/selftests/x86/ptrace_syscall.c  | 24 ++-------------
 tools/testing/selftests/x86/sigaltstack.c     | 27 ++---------------
 tools/testing/selftests/x86/sigreturn.c       | 25 ++--------------
 .../selftests/x86/single_step_syscall.c       | 23 --------------
 .../testing/selftests/x86/syscall_arg_fault.c | 13 --------
 tools/testing/selftests/x86/syscall_nt.c      | 13 --------
 tools/testing/selftests/x86/sysret_rip.c      | 24 +--------------
 tools/testing/selftests/x86/test_vsyscall.c   | 13 --------
 tools/testing/selftests/x86/unwind_vdso.c     | 13 --------
 20 files changed, 72 insertions(+), 331 deletions(-)
 create mode 100644 tools/testing/selftests/x86/helpers.c

diff --git a/tools/testing/selftests/x86/Makefile b/tools/testing/selftests/x86/Makefile
index ca9374b56ead..382585a314c0 100644
--- a/tools/testing/selftests/x86/Makefile
+++ b/tools/testing/selftests/x86/Makefile
@@ -36,6 +36,10 @@ BINARIES_64 := $(patsubst %,$(OUTPUT)/%,$(BINARIES_64))
 
 CFLAGS := -O2 -g -std=gnu99 -pthread -Wall $(KHDR_INCLUDES)
 
+LIB := helpers
+LIB_OBJ_32 := $(patsubst %,$(OUTPUT)/%.o,$(LIB:%=%_32))
+LIB_OBJ_64 := $(patsubst %,$(OUTPUT)/%.o,$(LIB:%=%_64))
+
 # call32_from_64 in thunks.S uses absolute addresses.
 ifeq ($(CAN_BUILD_WITH_NOPIE),1)
 CFLAGS += -no-pie
@@ -69,12 +73,18 @@ all_32: $(BINARIES_32)
 
 all_64: $(BINARIES_64)
 
-EXTRA_CLEAN := $(BINARIES_32) $(BINARIES_64)
+EXTRA_CLEAN := $(BINARIES_32) $(BINARIES_64) $(LIB_OBJ_32) $(LIB_OBJ_64)
+
+$(LIB_OBJ_32): $(OUTPUT)/%_32.o: %.c
+	$(CC) -O -m32 -o $@ -c $^ $(CFLAGS) $(EXTRA_CFLAGS)
+
+$(LIB_OBJ_64): $(OUTPUT)/%_64.o: %.c
+	$(CC) -O -m64 -o $@ -c $^ $(CFLAGS) $(EXTRA_CFLAGS)
 
-$(BINARIES_32): $(OUTPUT)/%_32: %.c helpers.h
+$(BINARIES_32): $(OUTPUT)/%_32: %.c helpers.h $(LIB_OBJ_32)
 	$(CC) -m32 -o $@ $(CFLAGS) $(EXTRA_CFLAGS) $^ -lrt -ldl -lm
 
-$(BINARIES_64): $(OUTPUT)/%_64: %.c helpers.h
+$(BINARIES_64): $(OUTPUT)/%_64: %.c helpers.h $(LIB_OBJ_64)
 	$(CC) -m64 -o $@ $(CFLAGS) $(EXTRA_CFLAGS) $^ -lrt -ldl
 
 # x86_64 users should be encouraged to install 32-bit libraries
diff --git a/tools/testing/selftests/x86/amx.c b/tools/testing/selftests/x86/amx.c
index 854f7d61be89..1e8e60b1f7b9 100644
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
index cf9ce8fbb656..111ec58cd1d0 100644
--- a/tools/testing/selftests/x86/corrupt_xstate_header.c
+++ b/tools/testing/selftests/x86/corrupt_xstate_header.c
@@ -11,13 +11,13 @@
 #include <stdio.h>
 #include <string.h>
 #include <sched.h>
-#include <signal.h>
 #include <err.h>
 #include <unistd.h>
 #include <stdint.h>
 #include <sys/wait.h>
 
 #include "../kselftest.h" /* For __cpuid_count() */
+#include "helpers.h"
 
 static inline int xsave_enabled(void)
 {
@@ -29,19 +29,6 @@ static inline int xsave_enabled(void)
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
index d1e919b0c1dc..535596f9ce24 100644
--- a/tools/testing/selftests/x86/entry_from_vm86.c
+++ b/tools/testing/selftests/x86/entry_from_vm86.c
@@ -11,7 +11,6 @@
 #include <assert.h>
 #include <stdlib.h>
 #include <sys/syscall.h>
-#include <sys/signal.h>
 #include <sys/ucontext.h>
 #include <unistd.h>
 #include <stdio.h>
@@ -24,31 +23,11 @@
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
index 8c780cce941d..94642c57e483 100644
--- a/tools/testing/selftests/x86/fsgsbase.c
+++ b/tools/testing/selftests/x86/fsgsbase.c
@@ -15,7 +15,6 @@
 #include <sys/user.h>
 #include <asm/prctl.h>
 #include <sys/prctl.h>
-#include <signal.h>
 #include <limits.h>
 #include <sys/ucontext.h>
 #include <sched.h>
@@ -28,6 +27,8 @@
 #include <sys/wait.h>
 #include <setjmp.h>
 
+#include "helpers.h"
+
 #ifndef __x86_64__
 # error This test is 64-bit only
 #endif
@@ -39,28 +40,6 @@ static unsigned short *shared_scratch;
 
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
diff --git a/tools/testing/selftests/x86/helpers.c b/tools/testing/selftests/x86/helpers.c
new file mode 100644
index 000000000000..a6ecc42d359f
--- /dev/null
+++ b/tools/testing/selftests/x86/helpers.c
@@ -0,0 +1,30 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#define _GNU_SOURCE
+#include <string.h>
+#include <err.h>
+
+#include "helpers.h"
+
+void sethandler(int sig, void (*handler)(int, siginfo_t *, void *),
+		int flags)
+{
+	struct sigaction sa;
+
+	memset(&sa, 0, sizeof(sa));
+	sa.sa_sigaction = handler;
+	sa.sa_flags = SA_SIGINFO | flags;
+	sigemptyset(&sa.sa_mask);
+	if (sigaction(sig, &sa, 0))
+		err(1, "sigaction");
+}
+
+void clearhandler(int sig)
+{
+	struct sigaction sa;
+
+	memset(&sa, 0, sizeof(sa));
+	sa.sa_handler = SIG_DFL;
+	sigemptyset(&sa.sa_mask);
+	if (sigaction(sig, &sa, 0))
+		err(1, "sigaction");
+}
diff --git a/tools/testing/selftests/x86/helpers.h b/tools/testing/selftests/x86/helpers.h
index 4ef42c4559a9..35ff4df35397 100644
--- a/tools/testing/selftests/x86/helpers.h
+++ b/tools/testing/selftests/x86/helpers.h
@@ -2,8 +2,14 @@
 #ifndef __SELFTESTS_X86_HELPERS_H
 #define __SELFTESTS_X86_HELPERS_H
 
+#include <signal.h>
 #include <asm/processor-flags.h>
 
+void sethandler(int sig, void (*handler)(int, siginfo_t *, void *),
+		int flags);
+
+void clearhandler(int sig);
+
 static inline unsigned long get_eflags(void)
 {
 #ifdef __x86_64__
diff --git a/tools/testing/selftests/x86/ioperm.c b/tools/testing/selftests/x86/ioperm.c
index 57ec5e99edb9..103573c3d855 100644
--- a/tools/testing/selftests/x86/ioperm.c
+++ b/tools/testing/selftests/x86/ioperm.c
@@ -8,7 +8,6 @@
 #include <err.h>
 #include <stdio.h>
 #include <stdint.h>
-#include <signal.h>
 #include <setjmp.h>
 #include <stdlib.h>
 #include <string.h>
@@ -20,30 +19,9 @@
 #include <sched.h>
 #include <sys/io.h>
 
-static int nerrs = 0;
-
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
+#include "helpers.h"
 
-static void clearhandler(int sig)
-{
-	struct sigaction sa;
-	memset(&sa, 0, sizeof(sa));
-	sa.sa_handler = SIG_DFL;
-	sigemptyset(&sa.sa_mask);
-	if (sigaction(sig, &sa, 0))
-		err(1, "sigaction");
-}
+static int nerrs = 0;
 
 static jmp_buf jmpbuf;
 
diff --git a/tools/testing/selftests/x86/iopl.c b/tools/testing/selftests/x86/iopl.c
index 7e3e09c1abac..09544e598def 100644
--- a/tools/testing/selftests/x86/iopl.c
+++ b/tools/testing/selftests/x86/iopl.c
@@ -8,7 +8,6 @@
 #include <err.h>
 #include <stdio.h>
 #include <stdint.h>
-#include <signal.h>
 #include <setjmp.h>
 #include <stdlib.h>
 #include <string.h>
@@ -20,30 +19,9 @@
 #include <sched.h>
 #include <sys/io.h>
 
-static int nerrs = 0;
-
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
+#include "helpers.h"
 
-static void clearhandler(int sig)
-{
-	struct sigaction sa;
-	memset(&sa, 0, sizeof(sa));
-	sa.sa_handler = SIG_DFL;
-	sigemptyset(&sa.sa_mask);
-	if (sigaction(sig, &sa, 0))
-		err(1, "sigaction");
-}
+static int nerrs = 0;
 
 static jmp_buf jmpbuf;
 
diff --git a/tools/testing/selftests/x86/ldt_gdt.c b/tools/testing/selftests/x86/ldt_gdt.c
index 3a29346e1452..80acade5d7df 100644
--- a/tools/testing/selftests/x86/ldt_gdt.c
+++ b/tools/testing/selftests/x86/ldt_gdt.c
@@ -8,7 +8,6 @@
 #include <err.h>
 #include <stdio.h>
 #include <stdint.h>
-#include <signal.h>
 #include <setjmp.h>
 #include <stdlib.h>
 #include <string.h>
@@ -26,6 +25,8 @@
 #include <asm/prctl.h>
 #include <sys/prctl.h>
 
+#include "helpers.h"
+
 #define AR_ACCESSED		(1<<8)
 
 #define AR_TYPE_RODATA		(0 * (1<<9))
@@ -506,20 +507,6 @@ static void fix_sa_restorer(int sig)
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
@@ -549,9 +536,11 @@ static void do_multicpu_tests(void)
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
index f8633aafc90c..cfec7a3e30b7 100644
--- a/tools/testing/selftests/x86/mov_ss_trap.c
+++ b/tools/testing/selftests/x86/mov_ss_trap.c
@@ -35,7 +35,8 @@
 #include <string.h>
 #include <setjmp.h>
 #include <sys/prctl.h>
-#include <asm/processor-flags.h>
+
+#include "helpers.h"
 
 #if __x86_64__
 # define REG_IP REG_RIP
@@ -93,18 +94,6 @@ static void enable_watchpoint(void)
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
index 22a88b764a8e..7c2bd27908d5 100644
--- a/tools/testing/selftests/x86/sigaltstack.c
+++ b/tools/testing/selftests/x86/sigaltstack.c
@@ -1,7 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 
 #define _GNU_SOURCE
-#include <signal.h>
 #include <stdio.h>
 #include <stdbool.h>
 #include <string.h>
@@ -14,6 +13,8 @@
 #include <sys/resource.h>
 #include <setjmp.h>
 
+#include "helpers.h"
+
 /* sigaltstack()-enforced minimum stack */
 #define ENFORCED_MINSIGSTKSZ	2048
 
@@ -27,30 +28,6 @@ static bool sigalrm_expected;
 
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
index 5d7961a5f7f6..b2282ca57e23 100644
--- a/tools/testing/selftests/x86/sigreturn.c
+++ b/tools/testing/selftests/x86/sigreturn.c
@@ -36,7 +36,6 @@
 #include <string.h>
 #include <inttypes.h>
 #include <sys/mman.h>
-#include <sys/signal.h>
 #include <sys/ucontext.h>
 #include <asm/ldt.h>
 #include <err.h>
@@ -46,6 +45,8 @@
 #include <sys/ptrace.h>
 #include <sys/user.h>
 
+#include "helpers.h"
+
 /* Pull in AR_xyz defines. */
 typedef unsigned int u32;
 typedef unsigned short u16;
@@ -138,28 +139,6 @@ static unsigned short LDT3(int idx)
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
index 2d8e0edca23f..4c9b8fd7a41a 100644
--- a/tools/testing/selftests/x86/single_step_syscall.c
+++ b/tools/testing/selftests/x86/single_step_syscall.c
@@ -21,7 +21,6 @@
 #include <string.h>
 #include <inttypes.h>
 #include <sys/mman.h>
-#include <sys/signal.h>
 #include <sys/ucontext.h>
 #include <asm/ldt.h>
 #include <err.h>
@@ -33,28 +32,6 @@
 
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
index 461fa41a4d02..1149ac24921a 100644
--- a/tools/testing/selftests/x86/syscall_arg_fault.c
+++ b/tools/testing/selftests/x86/syscall_arg_fault.c
@@ -9,7 +9,6 @@
 #include <stdlib.h>
 #include <stdio.h>
 #include <string.h>
-#include <sys/signal.h>
 #include <sys/ucontext.h>
 #include <err.h>
 #include <setjmp.h>
@@ -17,18 +16,6 @@
 
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
 static volatile sig_atomic_t sig_traps;
 static sigjmp_buf jmpbuf;
 
diff --git a/tools/testing/selftests/x86/syscall_nt.c b/tools/testing/selftests/x86/syscall_nt.c
index a108b80dd082..1a019bc43b9d 100644
--- a/tools/testing/selftests/x86/syscall_nt.c
+++ b/tools/testing/selftests/x86/syscall_nt.c
@@ -10,7 +10,6 @@
 #include <stdio.h>
 #include <unistd.h>
 #include <string.h>
-#include <signal.h>
 #include <err.h>
 #include <sys/syscall.h>
 
@@ -18,18 +17,6 @@
 
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
index 84d74be1d902..da5164fde79a 100644
--- a/tools/testing/selftests/x86/sysret_rip.c
+++ b/tools/testing/selftests/x86/sysret_rip.c
@@ -11,7 +11,6 @@
 #include <stdio.h>
 #include <string.h>
 #include <inttypes.h>
-#include <sys/signal.h>
 #include <sys/ucontext.h>
 #include <sys/syscall.h>
 #include <err.h>
@@ -22,6 +21,7 @@
 #include <sys/mman.h>
 #include <assert.h>
 
+#include "helpers.h"
 
 asm (
 	".pushsection \".text\", \"ax\"\n\t"
@@ -39,28 +39,6 @@ asm (
 extern const char test_page[];
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
index 47cab972807c..d54f5e767abe 100644
--- a/tools/testing/selftests/x86/test_vsyscall.c
+++ b/tools/testing/selftests/x86/test_vsyscall.c
@@ -11,7 +11,6 @@
 #include <dlfcn.h>
 #include <string.h>
 #include <inttypes.h>
-#include <signal.h>
 #include <sys/ucontext.h>
 #include <errno.h>
 #include <err.h>
@@ -39,18 +38,6 @@
 /* max length of lines in /proc/self/maps - anything longer is skipped here */
 #define MAPS_LINE_LEN 128
 
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
 /* vsyscalls and vDSO */
 bool vsyscall_map_r = false, vsyscall_map_x = false;
 
diff --git a/tools/testing/selftests/x86/unwind_vdso.c b/tools/testing/selftests/x86/unwind_vdso.c
index 4c311e1af4c7..51ba53904130 100644
--- a/tools/testing/selftests/x86/unwind_vdso.c
+++ b/tools/testing/selftests/x86/unwind_vdso.c
@@ -31,7 +31,6 @@ int main()
 #include <string.h>
 #include <inttypes.h>
 #include <sys/mman.h>
-#include <signal.h>
 #include <sys/ucontext.h>
 #include <err.h>
 #include <stddef.h>
@@ -43,18 +42,6 @@ int main()
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
2.17.1

