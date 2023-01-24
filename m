Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD8D6678E37
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Jan 2023 03:27:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231588AbjAXC15 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 23 Jan 2023 21:27:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbjAXC15 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 23 Jan 2023 21:27:57 -0500
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4225BB92;
        Mon, 23 Jan 2023 18:27:55 -0800 (PST)
Received: from localhost.localdomain (unknown [182.253.88.152])
        by gnuweeb.org (Postfix) with ESMTPSA id 5BFCA82EF1;
        Tue, 24 Jan 2023 02:27:49 +0000 (UTC)
X-GW-Data: lPqxHiMPbJw1wb7CM9QUryAGzr0yq5atzVDdxTR0iA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1674527275;
        bh=AMxhIY8F9NcOm9hGLru6XuDWA/BDaiwDAsw8iN0V4UA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y6AboJmoR0/2xDYJv0kzk8/pfJs0XiA4DWEt6/0b87elQZLijlMAXdBykamo4VmS9
         zG4B/9ZxVsP3wXM+8GPdZCDbedtKlc8ySTudAQBphLQ2D46XPXJsfCwd5hYFyfBUg/
         DrmVo1PAm2sTehuw7xwmMxkeVn9ZjHsleNujtqCO4lg0R8/9vLlrrgi0TnGOsbBhsW
         4P1Of+2nYkdLht0IIHgzO6XX9kkFzymewIL4KamCkpUi8zsIeNq5riBjITQWglwPHX
         WrlGk8+r5XElF+gVH30c9EUG16H0pp7FBQT4cYUMQ6BF+o0rmrYpMqyzRIaaiJ7RL2
         O9GKwZ5RFCxCg==
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
To:     "H. Peter Anvin" <hpa@zytor.com>, x86 Mailing List <x86@kernel.org>
Cc:     Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Xin Li <xin3.li@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        Brian Gerst <brgerst@gmail.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Shuah Khan <shuah@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Linux Kselftest Mailing List 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH v2 1/2] selftests/x86: sysret_rip: Handle syscall in a FRED system
Date:   Tue, 24 Jan 2023 09:27:28 +0700
Message-Id: <20230124022729.596997-2-ammarfaizi2@gnuweeb.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230124022729.596997-1-ammarfaizi2@gnuweeb.org>
References: <SA1PR11MB6734FA9139B9C9F6CC2ED123A8C59@SA1PR11MB6734.namprd11.prod.outlook.com> <5d4ad3e3-034f-c7da-d141-9c001c2343af@intel.com> <18B5DB6D-AEBD-4A67-A7B3-CE64940819B7@zytor.com> <SA1PR11MB673498933098295BFC7C2900A8CB9@SA1PR11MB6734.namprd11.prod.outlook.com> <b6e36a5c-6f5e-eda6-54ad-a0c20eb00402@intel.com> <25b96960-a07e-a952-5c23-786b55054126@zytor.com> <fb1cab9f-a373-38e6-92e6-456332010653@gnuweeb.org> <6cd0db14-c9e2-3598-fd10-4b473d78c373@citrix.com> <5ecc383c-621b-57d9-7f6d-d63496fca3b3@zytor.com>
 <20230124022729.596997-1-ammarfaizi2@gnuweeb.org>
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

From: Ammar Faizi <ammarfaizi2@gnuweeb.org>

The current selftest asserts %r11 == %rflags after the 'syscall'
returns to user. Such an assertion doesn't apply to a FRED system
because in a FRED system the 'syscall' instruction does not set
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
Co-developed-by: "H. Peter Anvin" <hpa@zytor.com>
Signed-off-by: Ammar Faizi <ammarfaizi2@gnuweeb.org>
---

Need hpa's sign off.

## Changelog v2:

   - Use "+r"(rsp) as the right way to avoid redzone problems
     per Andrew's comment (hpa).
     (Ref: https://lore.kernel.org/lkml/8f5c24df-514d-5d89-f58f-ec8c3eb1e049@zytor.com )

 tools/testing/selftests/x86/sysret_rip.c | 96 +++++++++++++++++++++++-
 1 file changed, 95 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/x86/sysret_rip.c b/tools/testing/selftests/x86/sysret_rip.c
index 84d74be1d90207ab..550bc4e69ac46997 100644
--- a/tools/testing/selftests/x86/sysret_rip.c
+++ b/tools/testing/selftests/x86/sysret_rip.c
@@ -39,6 +39,95 @@ asm (
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
+	REGS_ERROR  = -1,	/* Invalid register contents */
+	REGS_SAVED  =  0,	/* Registers properly preserved */
+	REGS_SYSRET =  1	/* Registers match syscall/sysret */
+};
+
+/*
+ * Returns:
+ *  0 = %rcx and %r11 preserved.
+ *  1 = %rcx and %r11 set to %rflags and %rip.
+ * -1 = %rcx and/or %r11 set to any other values.
+ *
+ * Note that check_regs_syscall() sets %rbx to the syscall return %rip.
+ */
+static enum regs_ok check_regs_result(unsigned long r11, unsigned long rcx,
+				      unsigned long rbx)
+{
+	if (r11 == r11_sentinel && rcx == rcx_sentinel) {
+		return REGS_SAVED;
+	} else if (r11 == rflags_sentinel && rcx == rbx) {
+		return REGS_SYSRET;
+	} else {
+		printf("[FAIL] check_regs_result\n");
+		printf("        r11_sentinel = %#lx; %%r11 = %#lx;\n", r11_sentinel, r11);
+		printf("        rcx_sentinel = %#lx; %%rcx = %#lx;\n", rcx_sentinel, rcx);
+		printf("        rflags_sentinel = %#lx\n", rflags_sentinel);
+		return REGS_ERROR;
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
+	/*
+	 * Test that:
+	 *
+	 * - "syscall" in a FRED system doesn't clobber %rcx and %r11.
+	 * - "syscall" in a non-FRED system sets %rcx=%rip and %r11=%rflags.
+	 *
+	 */
+	assert(check_regs_result(r11, rcx, rbx) != REGS_ERROR);
+	return nr_syscall;
+}
+
 static void sethandler(int sig, void (*handler)(int, siginfo_t *, void *),
 		       int flags)
 {
@@ -101,11 +190,16 @@ static void sigusr1(int sig, siginfo_t *info, void *ctx_void)
 	return;
 }
 
+static void __raise(int sig)
+{
+	do_syscall(__NR_kill, getpid(), sig, 0, 0, 0, 0);
+}
+
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

