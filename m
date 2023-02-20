Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9634569C44D
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Feb 2023 04:03:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbjBTDDg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 19 Feb 2023 22:03:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbjBTDDg (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 19 Feb 2023 22:03:36 -0500
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABF79E075;
        Sun, 19 Feb 2023 19:03:27 -0800 (PST)
Received: from localhost.localdomain (unknown [182.253.183.169])
        by gnuweeb.org (Postfix) with ESMTPSA id 6C37E8313A;
        Mon, 20 Feb 2023 03:03:20 +0000 (UTC)
X-GW-Data: lPqxHiMPbJw1wb7CM9QUryAGzr0yq5atzVDdxTR0iA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1676862207;
        bh=Qk7N/yCYGwUwnYVbbMe3gs22DUs6Sr0x8uxQAHDneuQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IuKsoVXYGbDJ72YXbhVTj1d+HJIpBuWIrQ7xLt2XkM+O/N1Q4YDXAb6OI817+zejz
         DcEWH6gc1VmG/Cb9aEyOM1D950g1tHOhmJsB6BWYUb7EgTjQhj2RpdRYa+40tLVvo9
         VeZZuWpgXD0cZtJvfSJXu0YjVEhE4cj9U7izkzZ7VwpIFBECtXGuxP9mdsWUK6byG4
         cFmz3gVfmJKmwJ2q7kGWXWO7kChpAM/bKxOWWHBdparqtBywvZpNYmz/qHBgO2Hy8B
         HwMmNNuwvt+1q+hpTlqeuPXTz64XnQt/IwZseDbkS27kTf0ma1ZgL1ozSVO89bPNYZ
         btB3J8z+bLTxw==
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
To:     Ingo Molnar <mingo@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@intel.com>, Xin Li <xin3.li@intel.com>
Cc:     Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        x86 Mailing List <x86@kernel.org>,
        Linux x86-64 Mailing List <linux-x86_64@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kselftest Mailing List 
        <linux-kselftest@vger.kernel.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>
Subject: [RFC PATCH v8 1/3] selftests/x86: sysret_rip: Handle syscall on the Intel FRED architecture
Date:   Mon, 20 Feb 2023 10:02:42 +0700
Message-Id: <20230220030244.115808-2-ammarfaizi2@gnuweeb.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230220030244.115808-1-ammarfaizi2@gnuweeb.org>
References: <20230220030244.115808-1-ammarfaizi2@gnuweeb.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The current selftest asserts %r11 == %rflags after the 'syscall' returns
to userspace. However, such an assertion doesn't apply to the Intel FRED
system because, in that system, the 'syscall' instruction does not set
%r11=%rflags and %rcx=%rip.

Handle the FRED system case. Now, test that:

  A) 'syscall' in a FRED system preserves %rcx and %r11.

  B) 'syscall' in a non-FRED system sets %rcx=%rip and %r11=%rflags.

Note for the '__raise()' helper:
Those tests must manipulate registers before the 'syscall' instruction
is invoked. However, the current 'raise()' function from libc cannot
accomplish it. Therefore, create a syscall wrapper in inline Assembly to
control them.

Fixes: 660602140103 ("selftests/x86: Add a selftest for SYSRET to noncanonical addresses")
Link: https://lore.kernel.org/lkml/25b96960-a07e-a952-5c23-786b55054126@zytor.com
Reported-by: Xin Li <xin3.li@intel.com>
Co-developed-by: H. Peter Anvin (Intel) <hpa@zytor.com>
Signed-off-by: H. Peter Anvin (Intel) <hpa@zytor.com>
Signed-off-by: Ammar Faizi <ammarfaizi2@gnuweeb.org>
---
 tools/testing/selftests/x86/sysret_rip.c | 122 +++++++++++++++++++++--
 1 file changed, 115 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/x86/sysret_rip.c b/tools/testing/selftests/x86/sysret_rip.c
index 84d74be1d90207ab..300104900192d396 100644
--- a/tools/testing/selftests/x86/sysret_rip.c
+++ b/tools/testing/selftests/x86/sysret_rip.c
@@ -39,6 +39,112 @@ asm (
 extern const char test_page[];
 static void const *current_test_page_addr = test_page;
 
+/*
+ * Arbitrary values.
+ */
+static const unsigned long r11_sentinel = 0xfeedfacedeadbeef;
+static const unsigned long rcx_sentinel = 0x5ca1ab1e0b57ac1e;
+
+/*
+ * An arbitrary *valid* RFLAGS value.
+ */
+static const unsigned long rflags_sentinel = 0x200a93;
+
+enum regs_ok {
+	REGS_UNDEFINED	= -1,
+	REGS_SAVED	=  0,	/* Registers properly preserved (Intel FRED). */
+	REGS_SYSRET	=  1	/* Registers match syscall/sysret. */
+};
+
+/*
+ * @rbx should be set to the syscall return %rip.
+ */
+static void check_regs_result(unsigned long r11, unsigned long rcx,
+			      unsigned long rbx)
+{
+	static enum regs_ok regs_ok_state = REGS_UNDEFINED;
+	enum regs_ok ret;
+
+	if (r11 == r11_sentinel && rcx == rcx_sentinel) {
+		ret = REGS_SAVED;
+	} else if (r11 == rflags_sentinel && rcx == rbx) {
+		ret = REGS_SYSRET;
+	} else {
+		printf("[FAIL] check_regs_result\n");
+		printf("        r11_sentinel = %#lx; %%r11 = %#lx;\n", r11_sentinel, r11);
+		printf("        rcx_sentinel = %#lx; %%rcx = %#lx;\n", rcx_sentinel, rcx);
+		printf("        rflags_sentinel = %#lx\n", rflags_sentinel);
+		exit(1);
+	}
+
+
+	/*
+	 * Test that we don't get a mix of REGS_SAVED and REGS_SYSRET.
+	 * It needs at least calling check_regs_result() twice to assert.
+	 */
+	if (regs_ok_state == REGS_UNDEFINED) {
+		/*
+		 * First time calling check_regs_result().
+		 */
+		regs_ok_state = ret;
+	} else {
+		assert(regs_ok_state == ret);
+	}
+}
+
+/*
+ * There are two cases:
+ *
+ *   A) 'syscall' in a FRED system preserves %rcx and %r11.
+ *   B) 'syscall' in a non-FRED system sets %rcx=%rip and %r11=%rflags.
+ *
+ * When the do_syscall() function is called for the first time,
+ * check_regs_result() will memorize the behavior, either (A) or (B).
+ * Then, the next do_syscall() call will verify that the 'syscall'
+ * behavior is the same.
+ *
+ * This function needs to be called at least twice to assert.
+ */
+static long do_syscall(long nr_syscall, unsigned long arg1, unsigned long arg2,
+		       unsigned long arg3, unsigned long arg4,
+		       unsigned long arg5, unsigned long arg6)
+{
+	unsigned long rbx;
+	unsigned long rcx = rcx_sentinel;
+	register unsigned long r11 __asm__("%r11") = r11_sentinel;
+	register unsigned long r10 __asm__("%r10") = arg4;
+	register unsigned long r8 __asm__("%r8") = arg5;
+	register unsigned long r9 __asm__("%r9") = arg6;
+
+	__asm__ volatile (
+		"movq       -8(%%rsp), %%r12\n\t"    // Do not clobber the red zone.
+		"pushq      %[rflags_sentinel]\n\t"
+		"popfq\n\t"
+		"movq       %%r12, -8(%%rsp)\n\t"
+		"leaq       1f(%%rip), %[rbx]\n\t"
+		"syscall\n"
+		"1:"
+
+		: "+a" (nr_syscall),
+		  "+r" (r11),
+		  "+c" (rcx),
+		  [rbx] "=b" (rbx)
+
+		: [rflags_sentinel] "g" (rflags_sentinel),
+		  "D" (arg1),	/* %rdi */
+		  "S" (arg2),	/* %rsi */
+		  "d" (arg3),	/* %rdx */
+		  "r" (r10),
+		  "r" (r8),
+		  "r" (r9)
+
+		: "r12", "memory"
+	);
+
+	check_regs_result(r11, rcx, rbx);
+	return nr_syscall;
+}
+
 static void sethandler(int sig, void (*handler)(int, siginfo_t *, void *),
 		       int flags)
 {
@@ -88,24 +194,26 @@ static void sigusr1(int sig, siginfo_t *info, void *ctx_void)
 
 	memcpy(&initial_regs, &ctx->uc_mcontext.gregs, sizeof(gregset_t));
 
+	check_regs_result(ctx->uc_mcontext.gregs[REG_R11],
+			  ctx->uc_mcontext.gregs[REG_RCX],
+			  ctx->uc_mcontext.gregs[REG_RBX]);
+
 	/* Set IP and CX to match so that SYSRET can happen. */
 	ctx->uc_mcontext.gregs[REG_RIP] = rip;
 	ctx->uc_mcontext.gregs[REG_RCX] = rip;
-
-	/* R11 and EFLAGS should already match. */
-	assert(ctx->uc_mcontext.gregs[REG_EFL] ==
-	       ctx->uc_mcontext.gregs[REG_R11]);
-
 	sethandler(SIGSEGV, sigsegv_for_sigreturn_test, SA_RESETHAND);
+}
 
-	return;
+static void __raise(int sig)
+{
+	do_syscall(__NR_kill, getpid(), sig, 0, 0, 0, 0);
 }
 
 static void test_sigreturn_to(unsigned long ip)
 {
 	rip = ip;
 	printf("[RUN]\tsigreturn to 0x%lx\n", ip);
-	raise(SIGUSR1);
+	__raise(SIGUSR1);
 }
 
 static jmp_buf jmpbuf;
-- 
Ammar Faizi

