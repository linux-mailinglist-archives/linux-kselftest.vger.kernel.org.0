Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 525506794CE
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Jan 2023 11:09:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233724AbjAXKJz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 24 Jan 2023 05:09:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233707AbjAXKJw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 24 Jan 2023 05:09:52 -0500
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1EA039B92;
        Tue, 24 Jan 2023 02:09:50 -0800 (PST)
Received: from localhost.localdomain (unknown [182.253.88.152])
        by gnuweeb.org (Postfix) with ESMTPSA id 3FCCB82EE9;
        Tue, 24 Jan 2023 10:09:43 +0000 (UTC)
X-GW-Data: lPqxHiMPbJw1wb7CM9QUryAGzr0yq5atzVDdxTR0iA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1674554990;
        bh=zGk+fqoVcu7nteU3S7cHzefc1r742z4IKcWRspTVyGg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OvWMBXP/OfXi6QuVO6d9EMW+Hz9nJJa6cnxfSA0FcVnTs39gRvwsb6MtMhdESr3Mt
         mxFkLav5gghOuhIWX4f5P756hN5Mr0EgGdyIqDpzrFjrMwatdBNBF5e6lrR68tSgHw
         yRqiUxYMbbd1l95n2FSZXJpt+mEvcaAzHNl54TFmtlT6MkXhcMxh76GqdFKCX7mPiM
         9UH8jYt5lWT2FTth+QPiov8Ug4EaWEnZxWdDC3n8WXzGHqvP2D/vRjoqbt5AensyHg
         8wPCBjZqIm6CrqmuR9D8CKupNaRfIqOrOzM+nc9V8FJnbelgOP4ettXSFPElHPkEiU
         bWcO5iEV4HW0Q==
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
Subject: [RFC PATCH v3 1/2] selftests/x86: sysret_rip: Handle syscall in a FRED system
Date:   Tue, 24 Jan 2023 17:09:24 +0700
Message-Id: <20230124100926.637335-2-ammarfaizi2@gnuweeb.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230124100926.637335-1-ammarfaizi2@gnuweeb.org>
References: <b6e36a5c-6f5e-eda6-54ad-a0c20eb00402@intel.com> <25b96960-a07e-a952-5c23-786b55054126@zytor.com> <fb1cab9f-a373-38e6-92e6-456332010653@gnuweeb.org> <6cd0db14-c9e2-3598-fd10-4b473d78c373@citrix.com> <5ecc383c-621b-57d9-7f6d-d63496fca3b3@zytor.com> <20230124022729.596997-1-ammarfaizi2@gnuweeb.org> <20230124022729.596997-3-ammarfaizi2@gnuweeb.org> <ce25e53f-91d4-d793-42a5-036d6bce0b4c@zytor.com> <Y899kHYbz32H1S6a@biznet-home.integral.gnuweeb.org> <BC632CA8-D2CB-4781-82E5-9810347293B0@zytor.com> <Y8+hGxVpgFVcm15g@biznet-home.integral.gnuweeb.org>
 <20230124100926.637335-1-ammarfaizi2@gnuweeb.org>
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
Co-developed-by: H. Peter Anvin (Intel) <hpa@zytor.com>
Signed-off-by: H. Peter Anvin (Intel) <hpa@zytor.com>
Acked-by: H. Peter Anvin (Intel) <hpa@zytor.com>
Signed-off-by: Ammar Faizi <ammarfaizi2@gnuweeb.org>
---
 tools/testing/selftests/x86/sysret_rip.c | 111 ++++++++++++++++++++++-
 1 file changed, 110 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/x86/sysret_rip.c b/tools/testing/selftests/x86/sysret_rip.c
index 84d74be1d90207ab..b0d271c19ddd7834 100644
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
+	REGS_UNDEFINED	= -2,	/* For init value checker, never returned */
+	REGS_ERROR	= -1,	/* Invalid register contents */
+	REGS_SAVED	=  0,	/* Registers properly preserved */
+	REGS_SYSRET	=  1	/* Registers match syscall/sysret */
+};
+
+static enum regs_ok regs_ok_state = REGS_UNDEFINED;
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
+	enum regs_ok ret;
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
+	ret = check_regs_result(r11, rcx, rbx);
+	assert(ret != REGS_ERROR);
+
+	/*
+	 * Test that we don't get a mix of REGS_SAVED and REGS_SYSRET.
+	 * Need at least 2 times 'syscall' invoked from this function.
+	 */
+	if (regs_ok_state == REGS_UNDEFINED)
+		regs_ok_state = ret;
+	else
+		assert(ret == regs_ok_state);
+
+	return nr_syscall;
+}
+
 static void sethandler(int sig, void (*handler)(int, siginfo_t *, void *),
 		       int flags)
 {
@@ -101,11 +205,16 @@ static void sigusr1(int sig, siginfo_t *info, void *ctx_void)
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

