Return-Path: <linux-kselftest+bounces-13879-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F4F8934CA3
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Jul 2024 13:33:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56250281A36
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Jul 2024 11:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3C3013A250;
	Thu, 18 Jul 2024 11:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Re1EtLNs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7785139CEF;
	Thu, 18 Jul 2024 11:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721302387; cv=none; b=WhC9XFHloZwwjEyWzh/v9GO9xT1rP1DQmNTEEz+MEbmGxopFmNha2WyuXOfGl/daRU3qPfwm4U/IMGz0vI9BxTsrb5Mv5B40G0FM0TnmIOH7vmOeHxHEN8ytoW5FTdqayqz4Ue1mnSL9gKTVTG68sWqg8sfniE9y+nRQRLaxzbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721302387; c=relaxed/simple;
	bh=iBD6LISKQBdwiuyAGa/oeh2m8vhSNJ++AQgs8WSR6Js=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GM3osQoJhCrURYjPa+cxG9Z51vUgZZOqjtINXyuf0MPNI6BBnFm2OXdtSwZrc78aCAEp9NnHezWqEEKyJbM4TY8exvwcyqvUTgWo0dFJG8ROLnHEYdIDxUfKhIpJ6d0PP1BC7VyyQ97y8znqZoZjCTmX8DiKp96UvRIJSqJmudE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Re1EtLNs; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1721302384;
	bh=iBD6LISKQBdwiuyAGa/oeh2m8vhSNJ++AQgs8WSR6Js=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Re1EtLNstrpkDt3JlBEYS8CkOkWcXLRcHgy2eRmUt1lyjtMxhCbxqZR883QCJBCN5
	 Hf8P1x2blLXmV/s39cFS12abU6apax0Mx2tx7J3biiMRfvKUK3xeyznfM1MQ+3+Z/K
	 NNZzgAzrbD3eltNC1rFEuBSc0k1MtjnJYJEuMyEVX9Kvqcvzq/k5Fwu8X5ZKs0/7n3
	 v4qPjWQ84qSzZs95iqwnouGFPz54Z5e/K5UhsCyRSTP6tI+zxq6KOeM8R/dv+dzDg4
	 vZqNkjbt6i2kIoCdHJWiy5ndeOs1SFKy1uoFzJN8my/7mXYq3bOyMYxNZnl+3lRS1o
	 0mh1n30snMORA==
Received: from localhost.localdomain (broslavsky.collaboradmins.com [68.183.210.73])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 9478F378202D;
	Thu, 18 Jul 2024 11:32:58 +0000 (UTC)
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
To: Shuah Khan <shuah@kernel.org>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: kernel@collabora.com,
	"Chang S . Bae" <chang.seok.bae@intel.com>,
	Binbin Wu <binbin.wu@linux.intel.com>,
	Ingo Molnar <mingo@kernel.org>,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH v3 4/4] selftests: x86: entry_from_vm86: remove manual counting and increase maintainability
Date: Thu, 18 Jul 2024 16:32:22 +0500
Message-Id: <20240718113222.867116-5-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240718113222.867116-1-usama.anjum@collabora.com>
References: <20240718113222.867116-1-usama.anjum@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove the manual pass/fail tests counting and use kselftests helpers
which improves readability as well. Print details about errno if error
occurs and also print logs in standard format.

Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
Changes since v1:
- correct description of the patch

Changes since v2:
- Update description of the patch and add before/after output

Before:
  # selftests: x86: entry_from_vm86_32
  # ERROR: ld.so: object '/usr/libexec/coreutils/libstdbuf.so' from LD_PRELOAD cannot be preloaded (wrong ELF class: ELFCLASS64): ignored.
  # [RUN]	#BR from vm86 mode
  # [SKIP]	vm86 not supported
  # [RUN]	SYSENTER from vm86 mode
  # [SKIP]	vm86 not supported
  # [RUN]	SYSCALL from vm86 mode
  # [SKIP]	vm86 not supported
  # [RUN]	STI with VIP set from vm86 mode
  # [SKIP]	vm86 not supported
  # [RUN]	POPF with VIP set and IF clear from vm86 mode
  # [SKIP]	vm86 not supported
  # [RUN]	POPF with VIP and IF set from vm86 mode
  # [SKIP]	vm86 not supported
  # [RUN]	POPF with VIP clear and IF set from vm86 mode
  # [SKIP]	vm86 not supported
  # [RUN]	INT3 from vm86 mode
  # [SKIP]	vm86 not supported
  # [RUN]	int80 from vm86 mode
  # [SKIP]	vm86 not supported
  # [RUN]	UMIP tests from vm86 mode
  # [SKIP]	vm86 not supported
  # [INFO]	Result from SMSW:[0x0000]
  # [INFO]	Result from SIDT: limit[0x0000]base[0x00000000]
  # [INFO]	Result from SGDT: limit[0x0000]base[0x00000000]
  # [PASS]	All the results from SMSW are identical.
  # [PASS]	All the results from SGDT are identical.
  # [PASS]	All the results from SIDT are identical.
  # [RUN]	STR instruction from vm86 mode
  # [SKIP]	vm86 not supported
  # [RUN]	SLDT instruction from vm86 mode
  # [SKIP]	vm86 not supported
  # [RUN]	Execute null pointer from vm86 mode
  # [SKIP]	vm86 not supported
  # [RUN]	#BR from vm86 mode
  # [SKIP]	vm86 not supported
  # [RUN]	SYSENTER from vm86 mode
  # [SKIP]	vm86 not supported
  # [RUN]	SYSCALL from vm86 mode
  # [SKIP]	vm86 not supported
  # [RUN]	STI with VIP set from vm86 mode
  # [SKIP]	vm86 not supported
  # [RUN]	POPF with VIP set and IF clear from vm86 mode
  # [SKIP]	vm86 not supported
  # [RUN]	POPF with VIP and IF set from vm86 mode
  # [SKIP]	vm86 not supported
  # [RUN]	POPF with VIP clear and IF set from vm86 mode
  # [SKIP]	vm86 not supported
  # [RUN]	INT3 from vm86 mode
  # [SKIP]	vm86 not supported
  # [RUN]	int80 from vm86 mode
  # [SKIP]	vm86 not supported
  # [RUN]	UMIP tests from vm86 mode
  # [SKIP]	vm86 not supported
  # [INFO]	Result from SMSW:[0x0000]
  # [INFO]	Result from SIDT: limit[0x0000]base[0x00000000]
  # [INFO]	Result from SGDT: limit[0x0000]base[0x00000000]
  # [PASS]	All the results from SMSW are identical.
  # [PASS]	All the results from SGDT are identical.
  # [PASS]	All the results from SIDT are identical.
  # [RUN]	STR instruction from vm86 mode
  # [SKIP]	vm86 not supported
  # [RUN]	SLDT instruction from vm86 mode
  # [SKIP]	vm86 not supported
  # [RUN]	Execute null pointer from vm86 mode
  # [SKIP]	vm86 not supported
  ok 15 selftests: x86: entry_from_vm86_32

After:
  # selftests: x86: entry_from_vm86_32
  # ERROR: ld.so: object '/usr/libexec/coreutils/libstdbuf.so' from LD_PRELOAD cannot be preloaded (wrong ELF class: ELFCLASS64): ignored.
  # TAP version 13
  # 1..18
  # # #BR from vm86 mode
  # ok 1 # SKIP vm86 not supported
  # # SYSENTER from vm86 mode
  # ok 2 # SKIP vm86 not supported
  # # SYSCALL from vm86 mode
  # ok 3 # SKIP vm86 not supported
  # # STI with VIP set from vm86 mode
  # ok 4 # SKIP vm86 not supported
  # # POPF with VIP set and IF clear from vm86 mode
  # ok 5 # SKIP vm86 not supported
  # # POPF with VIP and IF set from vm86 mode
  # ok 6 # SKIP vm86 not supported
  # # POPF with VIP clear and IF set from vm86 mode
  # ok 7 # SKIP vm86 not supported
  # # INT3 from vm86 mode
  # ok 8 # SKIP vm86 not supported
  # # int80 from vm86 mode
  # ok 9 # SKIP vm86 not supported
  # # UMIP tests from vm86 mode
  # ok 10 # SKIP vm86 not supported
  # # Result from SMSW:[0x0000]
  # # Result from SIDT: limit[0x0000]base[0x00000000]
  # # Result from SGDT: limit[0x0000]base[0x00000000]
  # ok 11 All the results from SMSW are identical.
  # ok 12 All the results from SGDT are identical.
  # ok 13 All the results from SIDT are identical.
  # # STR instruction from vm86 mode
  # ok 14 # SKIP vm86 not supported
  # # SLDT instruction from vm86 mode
  # ok 15 # SKIP vm86 not supported
  # # Execute null pointer from vm86 mode
  # ok 16 # SKIP vm86 not supported
  # ok 17 # SKIP Received SIGSEGV
  # ok 18 fork succeeded
  # # Totals: pass:4 fail:0 xfail:0 xpass:0 skip:14 error:0
  ok 15 selftests: x86: entry_from_vm86_32
---
 tools/testing/selftests/x86/entry_from_vm86.c | 109 +++++++++---------
 1 file changed, 53 insertions(+), 56 deletions(-)

diff --git a/tools/testing/selftests/x86/entry_from_vm86.c b/tools/testing/selftests/x86/entry_from_vm86.c
index d1e919b0c1dc8..a4efa4588e6f8 100644
--- a/tools/testing/selftests/x86/entry_from_vm86.c
+++ b/tools/testing/selftests/x86/entry_from_vm86.c
@@ -23,9 +23,9 @@
 #include <stdbool.h>
 #include <errno.h>
 #include <sys/vm86.h>
+#include "../kselftest.h"
 
 static unsigned long load_addr = 0x10000;
-static int nerrs = 0;
 
 static void sethandler(int sig, void (*handler)(int, siginfo_t *, void *),
 		       int flags)
@@ -36,7 +36,7 @@ static void sethandler(int sig, void (*handler)(int, siginfo_t *, void *),
 	sa.sa_flags = SA_SIGINFO | flags;
 	sigemptyset(&sa.sa_mask);
 	if (sigaction(sig, &sa, 0))
-		err(1, "sigaction");
+		ksft_exit_fail_perror("sigaction");
 }
 
 static void clearhandler(int sig)
@@ -46,7 +46,7 @@ static void clearhandler(int sig)
 	sa.sa_handler = SIG_DFL;
 	sigemptyset(&sa.sa_mask);
 	if (sigaction(sig, &sa, 0))
-		err(1, "sigaction");
+		ksft_exit_fail_perror("sigaction");
 }
 
 static sig_atomic_t got_signal;
@@ -56,10 +56,8 @@ static void sighandler(int sig, siginfo_t *info, void *ctx_void)
 	ucontext_t *ctx = (ucontext_t*)ctx_void;
 
 	if (ctx->uc_mcontext.gregs[REG_EFL] & X86_EFLAGS_VM ||
-	    (ctx->uc_mcontext.gregs[REG_CS] & 3) != 3) {
-		printf("[FAIL]\tSignal frame should not reflect vm86 mode\n");
-		nerrs++;
-	}
+	    (ctx->uc_mcontext.gregs[REG_CS] & 3) != 3)
+		ksft_test_result_fail("Signal frame should not reflect vm86 mode\n");
 
 	const char *signame;
 	if (sig == SIGSEGV)
@@ -69,9 +67,9 @@ static void sighandler(int sig, siginfo_t *info, void *ctx_void)
 	else
 		signame = "unexpected signal";
 
-	printf("[INFO]\t%s: FLAGS = 0x%lx, CS = 0x%hx\n", signame,
-	       (unsigned long)ctx->uc_mcontext.gregs[REG_EFL],
-	       (unsigned short)ctx->uc_mcontext.gregs[REG_CS]);
+	ksft_test_result_pass("%s: FLAGS = 0x%lx, CS = 0x%hx\n", signame,
+			      (unsigned long)ctx->uc_mcontext.gregs[REG_EFL],
+			      (unsigned short)ctx->uc_mcontext.gregs[REG_CS]);
 
 	got_signal = 1;
 }
@@ -137,13 +135,13 @@ static bool do_test(struct vm86plus_struct *v86, unsigned long eip,
 {
 	long ret;
 
-	printf("[RUN]\t%s from vm86 mode\n", text);
+	ksft_print_msg("%s from vm86 mode\n", text);
 	v86->regs.eip = eip;
 	ret = vm86(VM86_ENTER, v86);
 
 	if (ret == -1 && (errno == ENOSYS || errno == EPERM)) {
-		printf("[SKIP]\tvm86 %s\n",
-		       errno == ENOSYS ? "not supported" : "not allowed");
+		ksft_test_result_skip("vm86 %s\n",
+				      errno == ENOSYS ? "not supported" : "not allowed");
 		return false;
 	}
 
@@ -159,29 +157,27 @@ static bool do_test(struct vm86plus_struct *v86, unsigned long eip,
 		else
 			sprintf(trapname, "%d", trapno);
 
-		printf("[INFO]\tExited vm86 mode due to #%s\n", trapname);
+		ksft_print_msg("Exited vm86 mode due to #%s\n", trapname);
 	} else if (VM86_TYPE(ret) == VM86_UNKNOWN) {
-		printf("[INFO]\tExited vm86 mode due to unhandled GP fault\n");
+		ksft_print_msg("Exited vm86 mode due to unhandled GP fault\n");
 	} else if (VM86_TYPE(ret) == VM86_TRAP) {
-		printf("[INFO]\tExited vm86 mode due to a trap (arg=%ld)\n",
-		       VM86_ARG(ret));
+		ksft_print_msg("Exited vm86 mode due to a trap (arg=%ld)\n",
+			       VM86_ARG(ret));
 	} else if (VM86_TYPE(ret) == VM86_SIGNAL) {
-		printf("[INFO]\tExited vm86 mode due to a signal\n");
+		ksft_print_msg("Exited vm86 mode due to a signal\n");
 	} else if (VM86_TYPE(ret) == VM86_STI) {
-		printf("[INFO]\tExited vm86 mode due to STI\n");
+		ksft_print_msg("Exited vm86 mode due to STI\n");
 	} else {
-		printf("[INFO]\tExited vm86 mode due to type %ld, arg %ld\n",
-		       VM86_TYPE(ret), VM86_ARG(ret));
+		ksft_print_msg("Exited vm86 mode due to type %ld, arg %ld\n",
+			       VM86_TYPE(ret), VM86_ARG(ret));
 	}
 
 	if (rettype == -1 ||
-	    (VM86_TYPE(ret) == rettype && VM86_ARG(ret) == retarg)) {
-		printf("[OK]\tReturned correctly\n");
-	} else {
-		printf("[FAIL]\tIncorrect return reason (started at eip = 0x%lx, ended at eip = 0x%lx)\n", eip, v86->regs.eip);
-		nerrs++;
-	}
-
+	    (VM86_TYPE(ret) == rettype && VM86_ARG(ret) == retarg))
+		ksft_test_result_pass("Returned correctly\n");
+	else
+		ksft_test_result_fail("Incorrect return reason (started at eip = 0x%lx, ended at eip = 0x%lx)\n",
+				      eip, v86->regs.eip);
 	return true;
 }
 
@@ -215,26 +211,20 @@ void do_umip_tests(struct vm86plus_struct *vm86, unsigned char *test_mem)
 	/* Results when using register operands */
 	msw3 = *(unsigned short *)(test_mem + 2080);
 
-	printf("[INFO]\tResult from SMSW:[0x%04x]\n", msw1);
-	printf("[INFO]\tResult from SIDT: limit[0x%04x]base[0x%08lx]\n",
-	       idt1.limit, idt1.base);
-	printf("[INFO]\tResult from SGDT: limit[0x%04x]base[0x%08lx]\n",
-	       gdt1.limit, gdt1.base);
+	ksft_print_msg("Result from SMSW:[0x%04x]\n", msw1);
+	ksft_print_msg("Result from SIDT: limit[0x%04x]base[0x%08lx]\n",
+		       idt1.limit, idt1.base);
+	ksft_print_msg("Result from SGDT: limit[0x%04x]base[0x%08lx]\n",
+		       gdt1.limit, gdt1.base);
 
-	if (msw1 != msw2 || msw1 != msw3)
-		printf("[FAIL]\tAll the results of SMSW should be the same.\n");
-	else
-		printf("[PASS]\tAll the results from SMSW are identical.\n");
+	ksft_test_result((msw1 == msw2 && msw1 == msw3),
+			 "All the results from SMSW are identical.\n");
 
-	if (memcmp(&gdt1, &gdt2, sizeof(gdt1)))
-		printf("[FAIL]\tAll the results of SGDT should be the same.\n");
-	else
-		printf("[PASS]\tAll the results from SGDT are identical.\n");
+	ksft_test_result(!memcmp(&gdt1, &gdt2, sizeof(gdt1)),
+			 "All the results from SGDT are identical.\n");
 
-	if (memcmp(&idt1, &idt2, sizeof(idt1)))
-		printf("[FAIL]\tAll the results of SIDT should be the same.\n");
-	else
-		printf("[PASS]\tAll the results from SIDT are identical.\n");
+	ksft_test_result(!memcmp(&idt1, &idt2, sizeof(idt1)),
+			 "All the results from SIDT are identical.\n");
 
 	sethandler(SIGILL, sighandler, 0);
 	do_test(vm86, vmcode_umip_str - vmcode, VM86_SIGNAL, 0,
@@ -250,11 +240,15 @@ void do_umip_tests(struct vm86plus_struct *vm86, unsigned char *test_mem)
 int main(void)
 {
 	struct vm86plus_struct v86;
-	unsigned char *addr = mmap((void *)load_addr, 4096,
-				   PROT_READ | PROT_WRITE | PROT_EXEC,
-				   MAP_ANONYMOUS | MAP_PRIVATE, -1,0);
+	unsigned char *addr;
+
+	ksft_print_header();
+	ksft_set_plan(18);
+
+	addr = mmap((void *)load_addr, 4096, PROT_READ | PROT_WRITE | PROT_EXEC,
+		    MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
 	if (addr != (unsigned char *)load_addr)
-		err(1, "mmap");
+		ksft_exit_fail_perror("mmap");
 
 	memcpy(addr, vmcode, end_vmcode - vmcode);
 	addr[2048] = 2;
@@ -270,7 +264,8 @@ int main(void)
 	/* Use the end of the page as our stack. */
 	v86.regs.esp = 4096;
 
-	assert((v86.regs.cs & 3) == 0);	/* Looks like RPL = 0 */
+	if (v86.regs.cs & 3)
+		ksft_exit_fail_msg("Looks like RPL = 0\n");
 
 	/* #BR -- should deliver SIG??? */
 	do_test(&v86, vmcode_bound - vmcode, VM86_INTx, 5, "#BR");
@@ -333,16 +328,18 @@ int main(void)
 	v86.regs.ss = 0;
 	sethandler(SIGSEGV, sighandler, 0);
 	got_signal = 0;
-	if (do_test(&v86, 0, VM86_SIGNAL, 0, "Execute null pointer") &&
-	    !got_signal) {
-		printf("[FAIL]\tDid not receive SIGSEGV\n");
-		nerrs++;
-	}
+	if (do_test(&v86, 0, VM86_SIGNAL, 0, "Execute null pointer"))
+		ksft_test_result(got_signal, "Received SIGSEGV\n");
+	else
+		ksft_test_result_skip("Received SIGSEGV\n");
+
 	clearhandler(SIGSEGV);
 
 	/* Make sure nothing explodes if we fork. */
 	if (fork() == 0)
 		return 0;
 
-	return (nerrs == 0 ? 0 : 1);
+	ksft_test_result_pass("fork succeeded\n");
+
+	ksft_finished();
 }
-- 
2.39.2


