Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAF6367BDF4
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Jan 2023 22:17:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236505AbjAYVRm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 25 Jan 2023 16:17:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236437AbjAYVRi (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 25 Jan 2023 16:17:38 -0500
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBF7630E80;
        Wed, 25 Jan 2023 13:17:31 -0800 (PST)
Received: from localhost.localdomain (unknown [182.253.88.152])
        by gnuweeb.org (Postfix) with ESMTPSA id 80DB582EFE;
        Wed, 25 Jan 2023 21:17:25 +0000 (UTC)
X-GW-Data: lPqxHiMPbJw1wb7CM9QUryAGzr0yq5atzVDdxTR0iA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1674681451;
        bh=Btm3NcJ/RK9GewCcxsk7hj+u/YbVqlV/6oZ5bJ8S7bQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XmJSlGHS5yzcit7fTMvoYJkCI0BQ30UI8X70gG+W54279auoUWUF8xoeVjmQ23RO2
         j9SyDhnveJ7JwSULem87RB8PL3XoxQfEbcMjlsBJcEjO5B5Wld/fElYkQvMK/14QKj
         S1d+OZpmaoGEBxAKbG7DFyZFlUJ29JUkJWNpdMydog+9sns768LW2Z8eso+97T8VoA
         VnZpK1Cf/5JWI9Xu0xlKla+XbJQpTvwKkmaW0wAOL5kzsEmGsq40S+CsZYFwzhjgen
         FBZQDt2uc7tOMHkE2roTk/wwlHdoVp+hYGyxhAy28azBJjGYEvvdUNS9PpYE7zCF4V
         WipOZ+3xmMNLg==
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
To:     "H. Peter Anvin" <hpa@zytor.com>, Xin Li <xin3.li@intel.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Brian Gerst <brgerst@gmail.com>,
        Borislav Petkov <bp@alien8.de>, Shuah Khan <shuah@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        x86 Mailing List <x86@kernel.org>,
        Linux Kselftest Mailing List 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH v6 1/3] selftests/x86: sysret_rip: Handle syscall in a FRED system
Date:   Thu, 26 Jan 2023 04:17:12 +0700
Message-Id: <20230125211714.838216-2-ammarfaizi2@gnuweeb.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230125211714.838216-1-ammarfaizi2@gnuweeb.org>
References: <b6e36a5c-6f5e-eda6-54ad-a0c20eb00402@intel.com> <25b96960-a07e-a952-5c23-786b55054126@zytor.com> <fb1cab9f-a373-38e6-92e6-456332010653@gnuweeb.org> <6cd0db14-c9e2-3598-fd10-4b473d78c373@citrix.com> <5ecc383c-621b-57d9-7f6d-d63496fca3b3@zytor.com> <20230124022729.596997-1-ammarfaizi2@gnuweeb.org> <20230124022729.596997-3-ammarfaizi2@gnuweeb.org> <ce25e53f-91d4-d793-42a5-036d6bce0b4c@zytor.com> <Y899kHYbz32H1S6a@biznet-home.integral.gnuweeb.org> <BC632CA8-D2CB-4781-82E5-9810347293B0@zytor.com> <Y8+hGxVpgFVcm15g@biznet-home.integral.gnuweeb.org>
 <20230125211714.838216-1-ammarfaizi2@gnuweeb.org>
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

The current selftest asserts (%r11 == %rflags) after the 'syscall'
returns to user. Such an assertion doesn't apply to the FRED system
because in that system the 'syscall' instruction does not set
%r11=%rflags and %rcx=%rip.

Handle the FRED case. Now, test that:

  - "syscall" in a FRED system doesn't clobber %rcx and %r11.
  - "syscall" in a non-FRED system sets %rcx=%rip and %r11=%rflags.

The 'raise()' function from libc can't be used to control those
registers. Therefore, create a syscall wrapper in inline Assembly to
fully control them.

Fixes: 660602140103 ("selftests/x86: Add a selftest for SYSRET to noncanonical addresses")
Link: https://lore.kernel.org/lkml/25b96960-a07e-a952-5c23-786b55054126@zytor.com
Reported-by: Xin Li <xin3.li@intel.com>
Co-developed-by: H. Peter Anvin (Intel) <hpa@zytor.com>
Signed-off-by: H. Peter Anvin (Intel) <hpa@zytor.com>
Signed-off-by: Ammar Faizi <ammarfaizi2@gnuweeb.org>
---
 tools/testing/selftests/x86/sysret_rip.c | 120 +++++++++++++++++++++--
 1 file changed, 113 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/x86/sysret_rip.c b/tools/testing/selftests/x86/sysret_rip.c
index 84d74be1d90207ab..100f55981d77a29b 100644
--- a/tools/testing/selftests/x86/sysret_rip.c
+++ b/tools/testing/selftests/x86/sysret_rip.c
@@ -39,6 +39,110 @@ asm (
 extern const char test_page[];
 static void const *current_test_page_addr = test_page;
 
+/* Arbitrary values */
+static const unsigned long r11_sentinel = 0xfeedfacedeadbeef;
+static const unsigned long rcx_sentinel = 0x5ca1ab1e0b57ac1e;
+
+/* An arbitrary *valid* RFLAGS value */
+static const unsigned long rflags_sentinel = 0x200a93;
+
+enum regs_ok {
+	REGS_UNDEFINED	= -1,	/* For consistency checker init, never returned */
+	REGS_SAVED	=  0,	/* Registers properly preserved */
+	REGS_SYSRET	=  1	/* Registers match syscall/sysret */
+};
+
+/*
+ * REGS_SAVED  = %rcx and %r11 preserved.
+ * REGS_SYSRET = %rcx and %r11 set to %rflags and %rip.
+ * REGS_ERROR  = %rcx and/or %r11 set to any other values.
+ *
+ * @rbx should be set to the syscall return %rip.
+ */
+static void check_regs_result(unsigned long r11, unsigned long rcx,
+			      unsigned long rbx)
+{
+	static enum regs_ok regs_ok_state = REGS_UNDEFINED;
+	enum regs_ok ret;
+
+	/*
+	 * Test that:
+	 *
+	 * - "syscall" in a FRED system doesn't clobber %rcx and %r11.
+	 * - "syscall" in a non-FRED system sets %rcx=%rip and %r11=%rflags.
+	 */
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
+static long do_syscall(long nr_syscall, unsigned long arg1, unsigned long arg2,
+		       unsigned long arg3, unsigned long arg4,
+		       unsigned long arg5, unsigned long arg6)
+{
+	register unsigned long r11 asm("%r11");
+	register unsigned long r10 asm("%r10");
+	register unsigned long r8 asm("%r8");
+	register unsigned long r9 asm("%r9");
+	register void *rsp asm("%rsp");
+	unsigned long rcx, rbx;
+
+	r11 = r11_sentinel;
+	rcx = rcx_sentinel;
+	r10 = arg4;
+	r8 = arg5;
+	r9 = arg6;
+
+	asm volatile (
+		"pushq	%[rflags_sentinel]\n\t"
+		"popf\n\t"
+		"leaq	1f(%%rip), %[rbx]\n\t"
+		"syscall\n"
+		"1:"
+
+		: "+a" (nr_syscall),
+		  "+r" (r11),
+		  "+c" (rcx),
+		  [rbx] "=b" (rbx),
+		  "+r" (rsp)	/* Clobber the redzone */
+
+		: [rflags_sentinel] "g" (rflags_sentinel),
+		  "D" (arg1),	/* %rdi */
+		  "S" (arg2),	/* %rsi */
+		  "d" (arg3),	/* %rdx */
+		  "r" (r10),
+		  "r" (r8),
+		  "r" (r9)
+
+		: "memory"
+	);
+
+	check_regs_result(r11, rcx, rbx);
+	return nr_syscall;
+}
+
 static void sethandler(int sig, void (*handler)(int, siginfo_t *, void *),
 		       int flags)
 {
@@ -88,24 +192,26 @@ static void sigusr1(int sig, siginfo_t *info, void *ctx_void)
 
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

