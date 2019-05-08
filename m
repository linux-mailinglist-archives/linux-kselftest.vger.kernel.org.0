Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0892517362
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 May 2019 10:13:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727003AbfEHIM6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 8 May 2019 04:12:58 -0400
Received: from merlin.infradead.org ([205.233.59.134]:45990 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727000AbfEHIM5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 8 May 2019 04:12:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=2bDRX7PYK5Dk86gEBZtmcvWHD7+nFguvE7Xdy+wqe5s=; b=3WxxXTCoBDDtxdYWtMh2VsFB+w
        qbS7GuZM+Rci2jb22PH86KqEazAtt7yL/KkQkSJl9PKrQ33Ue6VoCregogNVPDdJPwACUhZO8D7k/
        jAkjHDjb30pLhrsgoRasiwELAJlq+uPdBnK2oymEGdQfwT7xpoC//lj8Vy+fRnzdvAL6NNWBD+XiV
        LjC25eWQLyberoewVE5o07K3LteFRHW2fP2ZKkvL2uUDFHrS5sQ7Ss85EyqEiENpjmnvudEjMV0Ug
        m31Ipt7taF5pd1LPC4RwM/nWBVIDJNuRXTsK6FvJgrKZNhRPUOXKVZpx3X3k0Hz07rVZPULX78BhU
        MceazB3w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hOHgM-000455-Kk; Wed, 08 May 2019 08:12:07 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 3262A2029F884; Wed,  8 May 2019 10:12:05 +0200 (CEST)
Message-Id: <20190508080612.776845854@infradead.org>
User-Agent: quilt/0.65
Date:   Wed, 08 May 2019 09:49:04 +0200
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
Subject: [PATCH 3/4] x86/ftrace: Add pt_regs frame annotations
References: <20190508074901.982470324@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

When CONFIG_FRAME_POINTER, we should mark pt_regs frames.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/kernel/ftrace_32.S |    6 ++++++
 arch/x86/kernel/ftrace_64.S |    3 +++
 2 files changed, 9 insertions(+)

--- a/arch/x86/kernel/ftrace_32.S
+++ b/arch/x86/kernel/ftrace_32.S
@@ -138,6 +138,12 @@ ENTRY(ftrace_regs_caller)
 #else
 	movl	0x4(%ebp), %edx			/* Load parent ip (2nd parameter) */
 #endif
+
+#ifdef CONFIG_FRAME_POINTER
+	movl	%esp, %ebp
+	andl	$0x7fffffff, %ebp
+#endif
+
 	movl	function_trace_op, %ecx		/* Save ftrace_pos in 3rd parameter */
 	pushl	%esp				/* Save pt_regs as 4th parameter */
 
--- a/arch/x86/kernel/ftrace_64.S
+++ b/arch/x86/kernel/ftrace_64.S
@@ -222,6 +222,9 @@ GLOBAL(ftrace_regs_caller_op_ptr)
 	leaq MCOUNT_REG_SIZE+8*2(%rsp), %rcx
 	movq %rcx, RSP(%rsp)
 
+#ifdef CONFIG_FRAME_POINTER
+	leaq 1(%rsp), %rbp
+#endif
 	/* regs go into 4th parameter */
 	leaq (%rsp), %rcx
 


