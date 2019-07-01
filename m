Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F14AC2881D
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 May 2019 21:40:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390418AbfEWTWM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 23 May 2019 15:22:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:59968 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390415AbfEWTWM (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 23 May 2019 15:22:12 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 250352184E;
        Thu, 23 May 2019 19:22:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558639330;
        bh=plf5khnwnrG7TJd0YaGiq3aILycf1dI/vg/fJhtd+SY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jJKI+t2YYMNHHkvveqK5D9cUEAzfbz65VMrmJxu6S3uwSh+mU8qZpOJ89iaoj+xDZ
         v3jhMUG7nsq51NSDiKZ+l8mhQpMUoOhTO4rQDyzzC3M32WM+db7jifm2PTGk1mSL5P
         dfNfA9E76RNYCe/Y0f0rnN82QkmCobbNazeYq6ko=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
        Nicolai Stange <nstange@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jiri Kosina <jikos@kernel.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Petr Mladek <pmladek@suse.com>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Juergen Gross <jgross@suse.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nayna Jain <nayna@linux.ibm.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Joerg Roedel <jroedel@suse.de>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Subject: [PATCH 5.0 065/139] x86_64: Allow breakpoints to emulate call instructions
Date:   Thu, 23 May 2019 21:05:53 +0200
Message-Id: <20190523181729.225177033@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190523181720.120897565@linuxfoundation.org>
References: <20190523181720.120897565@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

commit 4b33dadf37666c0860b88f9e52a16d07bf6d0b03 upstream.

In order to allow breakpoints to emulate call instructions, they need to push
the return address onto the stack. The x86_64 int3 handler adds a small gap
to allow the stack to grow some. Use this gap to add the return address to
be able to emulate a call instruction at the breakpoint location.

These helper functions are added:

  int3_emulate_jmp(): changes the location of the regs->ip to return there.

 (The next two are only for x86_64)
  int3_emulate_push(): to push the address onto the gap in the stack
  int3_emulate_call(): push the return address and change regs->ip

Cc: Andy Lutomirski <luto@kernel.org>
Cc: Nicolai Stange <nstange@suse.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: the arch/x86 maintainers <x86@kernel.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Jiri Kosina <jikos@kernel.org>
Cc: Miroslav Benes <mbenes@suse.cz>
Cc: Petr Mladek <pmladek@suse.com>
Cc: Joe Lawrence <joe.lawrence@redhat.com>
Cc: Shuah Khan <shuah@kernel.org>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Tim Chen <tim.c.chen@linux.intel.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Mimi Zohar <zohar@linux.ibm.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Nayna Jain <nayna@linux.ibm.com>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Joerg Roedel <jroedel@suse.de>
Cc: "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Cc: stable@vger.kernel.org
Fixes: b700e7f03df5 ("livepatch: kernel: add support for live patching")
Tested-by: Nicolai Stange <nstange@suse.de>
Reviewed-by: Nicolai Stange <nstange@suse.de>
Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
[ Modified to only work for x86_64 and added comment to int3_emulate_push() ]
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/include/asm/text-patching.h |   28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

--- a/arch/x86/include/asm/text-patching.h
+++ b/arch/x86/include/asm/text-patching.h
@@ -39,4 +39,32 @@ extern int poke_int3_handler(struct pt_r
 extern void *text_poke_bp(void *addr, const void *opcode, size_t len, void *handler);
 extern int after_bootmem;
 
+static inline void int3_emulate_jmp(struct pt_regs *regs, unsigned long ip)
+{
+	regs->ip = ip;
+}
+
+#define INT3_INSN_SIZE 1
+#define CALL_INSN_SIZE 5
+
+#ifdef CONFIG_X86_64
+static inline void int3_emulate_push(struct pt_regs *regs, unsigned long val)
+{
+	/*
+	 * The int3 handler in entry_64.S adds a gap between the
+	 * stack where the break point happened, and the saving of
+	 * pt_regs. We can extend the original stack because of
+	 * this gap. See the idtentry macro's create_gap option.
+	 */
+	regs->sp -= sizeof(unsigned long);
+	*(unsigned long *)regs->sp = val;
+}
+
+static inline void int3_emulate_call(struct pt_regs *regs, unsigned long func)
+{
+	int3_emulate_push(regs, regs->ip - INT3_INSN_SIZE + CALL_INSN_SIZE);
+	int3_emulate_jmp(regs, func);
+}
+#endif
+
 #endif /* _ASM_X86_TEXT_PATCHING_H */


