Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4D851735B
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 May 2019 10:12:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726631AbfEHIMa (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 8 May 2019 04:12:30 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44242 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725891AbfEHIMa (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 8 May 2019 04:12:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=dH7jDipyW2/IbT3T+4Br1AsjxNtqsrnnxXKC+NJUiRQ=; b=fjjDRnMkcQRy/bSUsLCt6Ym7yK
        1hmF4nCFE7d0aIWZH3ieSyJOFK25ztJ3uXxJJKTKPR/1E0b6SkEWdz9/j7grE4D6Be5tjlqZ2e4HS
        p0Mw9Vj84H2NlOSFsWk6ZRYkFUjQiqrBpS9X2KQIOIbAtAyCL1urRXNYZ1mL8mlFj0LgiFNlyvP3f
        NrhCjQmyOizKgr9LYKePNGdg7eykF1nJw6EZPzQt7z0l2w8RbUXaU0lyDAwGpamuHgEInI8odH7ex
        OqA75UmlhaxJEKFqBXpF+Q5aiGWB0i04q6F9+JK6LQWqEx85jO1bwWQabnvPwHsXQD3R5x/YacSmr
        1HjhRaTA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hOHgM-00012a-TP; Wed, 08 May 2019 08:12:07 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 2D5072029F87E; Wed,  8 May 2019 10:12:05 +0200 (CEST)
Message-Id: <20190508080612.721269814@infradead.org>
User-Agent: quilt/0.65
Date:   Wed, 08 May 2019 09:49:03 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Nicolai Stange <nstange@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
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
        linux-kselftest@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH 2/4] x86/kprobes: Fix frame pointer annotations
References: <20190508074901.982470324@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The kprobe trampolines have a FRAME_POINTER annotation that makes no
sense. It marks the frame in the middle of pt_regs, at the place of
saving BP.

Change it to mark the pt_regs frame as per the ENCODE_FRAME_POINTER
from the respective entry_*.S.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/kernel/kprobes/common.h |   32 +++++++++++++++++++++++---------
 1 file changed, 23 insertions(+), 9 deletions(-)

--- a/arch/x86/kernel/kprobes/common.h
+++ b/arch/x86/kernel/kprobes/common.h
@@ -6,14 +6,15 @@
 
 #include <asm/asm.h>
 
+#ifdef CONFIG_X86_64
+
 #ifdef CONFIG_FRAME_POINTER
-# define SAVE_RBP_STRING "	push %" _ASM_BP "\n" \
-			 "	mov  %" _ASM_SP ", %" _ASM_BP "\n"
+#define ENCODE_FRAME_POINTER			\
+	"	leaq 1(%rsp), %rbp\n"
 #else
-# define SAVE_RBP_STRING "	push %" _ASM_BP "\n"
+#define ENCODE_FRAME_POINTER
 #endif
 
-#ifdef CONFIG_X86_64
 #define SAVE_REGS_STRING			\
 	/* Skip cs, ip, orig_ax. */		\
 	"	subq $24, %rsp\n"		\
@@ -27,11 +28,13 @@
 	"	pushq %r10\n"			\
 	"	pushq %r11\n"			\
 	"	pushq %rbx\n"			\
-	SAVE_RBP_STRING				\
+	"	pushq %rbp\n"			\
 	"	pushq %r12\n"			\
 	"	pushq %r13\n"			\
 	"	pushq %r14\n"			\
-	"	pushq %r15\n"
+	"	pushq %r15\n"			\
+	ENCODE_FRAME_POINTER
+
 #define RESTORE_REGS_STRING			\
 	"	popq %r15\n"			\
 	"	popq %r14\n"			\
@@ -51,19 +54,30 @@
 	/* Skip orig_ax, ip, cs */		\
 	"	addq $24, %rsp\n"
 #else
+
+#ifdef CONFIG_FRAME_POINTER
+#define ENCODE_FRAME_POINTER			\
+	"	movl %esp, %ebp\n"		\
+	"	andl $0x7fffffff, %ebp\n"
+#else
+#define ENCODE_FRAME_POINTER
+#endif
+
 #define SAVE_REGS_STRING			\
 	/* Skip cs, ip, orig_ax and gs. */	\
-	"	subl $16, %esp\n"		\
+	"	subl $4*4, %esp\n"		\
 	"	pushl %fs\n"			\
 	"	pushl %es\n"			\
 	"	pushl %ds\n"			\
 	"	pushl %eax\n"			\
-	SAVE_RBP_STRING				\
+	"	pushl %ebp\n"			\
 	"	pushl %edi\n"			\
 	"	pushl %esi\n"			\
 	"	pushl %edx\n"			\
 	"	pushl %ecx\n"			\
-	"	pushl %ebx\n"
+	"	pushl %ebx\n"			\
+	ENCODE_FRAME_POINTER
+
 #define RESTORE_REGS_STRING			\
 	"	popl %ebx\n"			\
 	"	popl %ecx\n"			\


