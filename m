Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 55BAF17992
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 May 2019 14:40:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbfEHMk0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 8 May 2019 08:40:26 -0400
Received: from merlin.infradead.org ([205.233.59.134]:48540 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726527AbfEHMk0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 8 May 2019 08:40:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=LYKoqpJMlMO57vcE4nAKzPxnDzGZFaIp9M1SEgLNgCw=; b=rHfMNiUq+0Mt899oc+tcdryYT
        sZmOi0MTs73jiU1Hyr32wPvXQaQRHSTDj9rQI2KyeinVpYvaMeST8vyH74hi9RIbEkBuJM1v9qXmj
        U+EDlzUm5fSyrtZex0IIZTUBwoe9thV83JGvs+qcYfbY9MjRwv0xoWdY/mALkD+vPyUDQ7qUaD/rg
        GszAEYwEuExk+h5vfd3euSGKVlko0+Lya5ikG+hf0rDtA5xHroA7PvyoUGtPaQkujYp4iLu1+S6lH
        0OWhZWP0EUiVYeU2BkysUroFycGANvd76JCz6yhPzQ6RGD879O4lhwUWRdDBClcdFTHnRjbX86CTG
        A1jGot0TQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hOLrh-0007Ad-AI; Wed, 08 May 2019 12:40:05 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9BD062029F87A; Wed,  8 May 2019 14:40:02 +0200 (CEST)
Date:   Wed, 8 May 2019 14:40:02 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Nicolai Stange <nstange@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
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
        linux-kselftest@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH 2/4] x86/kprobes: Fix frame pointer annotations
Message-ID: <20190508124002.GJ2650@hirez.programming.kicks-ass.net>
References: <20190508074901.982470324@infradead.org>
 <20190508080612.721269814@infradead.org>
 <20190508115416.nblx7c2kocidpytm@treble>
 <20190508120416.GL2589@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190508120416.GL2589@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, May 08, 2019 at 02:04:16PM +0200, Peter Zijlstra wrote:
> On Wed, May 08, 2019 at 06:54:16AM -0500, Josh Poimboeuf wrote:

> > We should put these macros in a header file somewhere (including
> > stringified versions).
> 
> Probably a good idea. I'll frob them into asm/frame.h.

---
Subject: x86: Move ENCODE_FRAME_POINTER to asm/frame.h
From: Peter Zijlstra <peterz@infradead.org>
Date: Wed May 8 14:30:48 CEST 2019

In preparation for wider use, move the ENCODE_FRAME_POINTER macros to
a common header and provide inline asm versions.

These macros are used to encode a pt_regs frame for the unwinder; see
unwind_frame.c:decode_frame_pointer().

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/entry/calling.h     |   15 --------------
 arch/x86/entry/entry_32.S    |   16 --------------
 arch/x86/include/asm/frame.h |   46 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 46 insertions(+), 31 deletions(-)

--- a/arch/x86/entry/calling.h
+++ b/arch/x86/entry/calling.h
@@ -172,21 +172,6 @@ For 32-bit we have the following convent
 	.endif
 .endm
 
-/*
- * This is a sneaky trick to help the unwinder find pt_regs on the stack.  The
- * frame pointer is replaced with an encoded pointer to pt_regs.  The encoding
- * is just setting the LSB, which makes it an invalid stack address and is also
- * a signal to the unwinder that it's a pt_regs pointer in disguise.
- *
- * NOTE: This macro must be used *after* PUSH_AND_CLEAR_REGS because it corrupts
- * the original rbp.
- */
-.macro ENCODE_FRAME_POINTER ptregs_offset=0
-#ifdef CONFIG_FRAME_POINTER
-	leaq 1+\ptregs_offset(%rsp), %rbp
-#endif
-.endm
-
 #ifdef CONFIG_PAGE_TABLE_ISOLATION
 
 /*
--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -246,22 +246,6 @@
 .Lend_\@:
 .endm
 
-/*
- * This is a sneaky trick to help the unwinder find pt_regs on the stack.  The
- * frame pointer is replaced with an encoded pointer to pt_regs.  The encoding
- * is just clearing the MSB, which makes it an invalid stack address and is also
- * a signal to the unwinder that it's a pt_regs pointer in disguise.
- *
- * NOTE: This macro must be used *after* SAVE_ALL because it corrupts the
- * original rbp.
- */
-.macro ENCODE_FRAME_POINTER
-#ifdef CONFIG_FRAME_POINTER
-	mov %esp, %ebp
-	andl $0x7fffffff, %ebp
-#endif
-.endm
-
 .macro RESTORE_INT_REGS
 	popl	%ebx
 	popl	%ecx
--- a/arch/x86/include/asm/frame.h
+++ b/arch/x86/include/asm/frame.h
@@ -22,6 +22,39 @@
 	pop %_ASM_BP
 .endm
 
+#ifdef CONFIG_X86_64
+/*
+ * This is a sneaky trick to help the unwinder find pt_regs on the stack.  The
+ * frame pointer is replaced with an encoded pointer to pt_regs.  The encoding
+ * is just setting the LSB, which makes it an invalid stack address and is also
+ * a signal to the unwinder that it's a pt_regs pointer in disguise.
+ *
+ * NOTE: This macro must be used *after* PUSH_AND_CLEAR_REGS because it corrupts
+ * the original rbp.
+ */
+.macro ENCODE_FRAME_POINTER ptregs_offset=0
+#ifdef CONFIG_FRAME_POINTER
+	leaq 1+\ptregs_offset(%rsp), %rbp
+#endif
+.endm
+#else /* !CONFIG_X86_64 */
+/*
+ * This is a sneaky trick to help the unwinder find pt_regs on the stack.  The
+ * frame pointer is replaced with an encoded pointer to pt_regs.  The encoding
+ * is just clearing the MSB, which makes it an invalid stack address and is also
+ * a signal to the unwinder that it's a pt_regs pointer in disguise.
+ *
+ * NOTE: This macro must be used *after* SAVE_ALL because it corrupts the
+ * original ebp.
+ */
+.macro ENCODE_FRAME_POINTER
+#ifdef CONFIG_FRAME_POINTER
+	mov %esp, %ebp
+	andl $0x7fffffff, %ebp
+#endif
+.endm
+#endif /* CONFIG_X86_64 */
+
 #else /* !__ASSEMBLY__ */
 
 #define FRAME_BEGIN				\
@@ -30,6 +63,19 @@
 
 #define FRAME_END "pop %" _ASM_BP "\n"
 
+#ifdef CONFIG_FRAME_POINTER
+#ifdef CONFIG_X86_64
+#define ENCODE_FRAME_POINTER			\
+	"lea 1(%rsp), %rbp\n\t"
+#else /* !CONFIG_X86_64 */
+#define ENCODE_FRAME_POINTER			\
+	"movl %esp, %ebp\n\t"			\
+	"andl $0x7fffffff, %ebp\n\t"
+#endif /* CONFIG_X86_64 */
+#else /* CONFIG_FRAME_POINTER */
+#define ENCODE_FRAME_POINTER
+#endif /* CONFIG_FRAME_POINTER */
+
 #endif /* __ASSEMBLY__ */
 
 #define FRAME_OFFSET __ASM_SEL(4, 8)
