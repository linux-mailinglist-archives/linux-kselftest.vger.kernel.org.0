Return-Path: <linux-kselftest+bounces-13658-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15AC592F735
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Jul 2024 10:48:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A2721F234C6
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Jul 2024 08:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23A19143746;
	Fri, 12 Jul 2024 08:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="PBzRRGF3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D9B21474D8;
	Fri, 12 Jul 2024 08:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720774052; cv=none; b=UF3kQEKJ69qJ2OCCPoJkkWJ57cPiVmHI13eLOBSC6DSpgaMWjrmy02O5TATFJWSeRlUrEUhmFDpf+C4YtdH0hhm2I3t7r4VK+JbzllQs33oByEdFeYWT0ZJkp3WRywZbyEsLX2k5qk6/M1YZojFnjcla4+RUbEIhBStGAY1qx54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720774052; c=relaxed/simple;
	bh=JBnSgEtjvbqAYAYT7HqqfFOQJ7n55CtQ798gF9GpfEc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=t4E0ISK1y7uOHLbsndF+TeRc/NyGaVGE5jGVdfLcggBfxAj1/c3rd8R6fjTLDURThOuNsatdxg1jsyPKpI5gpPz74IF0DxK590C4vjOkXphQ5JJQBOAUXxXMvELTnqOq3J41aE5xmkCkvZqJHrHky7gf0RdINKh6MwtgMRcdU/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=PBzRRGF3; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1720774048;
	bh=JBnSgEtjvbqAYAYT7HqqfFOQJ7n55CtQ798gF9GpfEc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PBzRRGF3Dl11CaD6DbX1JSpLGw73n0X2bPd94QBh5e6DWu3ck8uBrs2Ytqx3i7nuW
	 4zds/x/Iommi6hM0o9UtH4P3f8aHe2qc0/UTLNc+pc65LbO3sMkhQxw7wuD0sw1d9W
	 HGqr441ByQ2aaKd9P9qlgcafCYrpdKFu0Rc74wGu9OxmgEmOwGgtDMwkaBJb2u0BUv
	 XrqNFWyezZzkGDh+rJ2E+wChJTOElylo4oMqjJejsbKysEnc3qGnNk/YX42aT3wJfQ
	 xMzJi5/ScVa59t8Yj5pOQ5TO250Q644cGTI0BSzo1GL5VODux1o/WZrKgHskunrY2F
	 YiP8UuTOIC+TA==
Received: from localhost.localdomain (ec2-34-240-57-77.eu-west-1.compute.amazonaws.com [34.240.57.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 472D237821DB;
	Fri, 12 Jul 2024 08:47:26 +0000 (UTC)
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
Subject: [PATCH v2 4/4] selftests: x86: entry_from_vm86: remove manual counting and increase maintainability
Date: Fri, 12 Jul 2024 13:46:25 +0500
Message-Id: <20240712084625.297249-5-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240712084625.297249-1-usama.anjum@collabora.com>
References: <20240712084625.297249-1-usama.anjum@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

- Remove manual pass/fail tests counting
- Increase readability
- Print details about errno if error occurs
- Print logs in standard format

Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
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


