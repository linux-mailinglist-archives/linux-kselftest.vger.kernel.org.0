Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4638A18F4E
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 May 2019 19:37:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726632AbfEIRhw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 9 May 2019 13:37:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:34388 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726576AbfEIRhw (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 9 May 2019 13:37:52 -0400
Received: from home.goodmis.org (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 66CDD20675;
        Thu,  9 May 2019 17:37:49 +0000 (UTC)
Date:   Thu, 9 May 2019 13:37:42 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        linux-kernel@vger.kernel.org,
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
        Joerg Roedel <jroedel@suse.de>, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 2/4] x86/kprobes: Fix frame pointer annotations
Message-ID: <20190509173741.pfvecznqdndihxzg@home.goodmis.org>
References: <20190508074901.982470324@infradead.org>
 <20190508080612.721269814@infradead.org>
 <20190508115416.nblx7c2kocidpytm@treble>
 <20190508120416.GL2589@hirez.programming.kicks-ass.net>
 <20190508124248.u5ukpbhnh4wpiccq@treble>
 <20190508153907.GM2589@hirez.programming.kicks-ass.net>
 <20190508184848.qerg3flv3ej3xsev@treble>
 <20190509102030.dfa62e058f09d0d8cbdd6053@kernel.org>
 <20190509081431.GO2589@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190509081431.GO2589@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, May 09, 2019 at 10:14:31AM +0200, Peter Zijlstra wrote:
> 
> Right; I already fixed that in my patch changing i386's pt_regs.
> 
> But what I'd love to do is something like the belwo patch, and make all
> the trampolines (very much including ftrace) use that. Such that we then
> only have 1 copy of this magic (well, 2 because x86_64 also needs an
> implementation of this of course).
> 
> Changing ftrace over to this would be a little more work but it can
> easily chain things a little to get its original context back:
> 
> ENTRY(ftrace_regs_caller)
> GLOBAL(ftrace_regs_func)
> 	push ftrace_stub
> 	push ftrace_regs_handler

Note, ftrace_stub is dynamically modified to remove any indirect calls.

> 	jmp call_to_exception_trampoline
> END(ftrace_regs_caller)
> 
> typedef void (*ftrace_func_t)(unsigned long, unsigned long, struct ftrace_op *, struct pt_regs *);
> 
> struct ftrace_regs_stack {
> 	ftrace_func_t func;
> 	unsigned long parent_ip;
> };
> 
> void ftrace_regs_handler(struct pr_regs *regs)
> {
> 	struct ftrace_regs_stack *st = (void *)regs->sp;
> 	ftrace_func_t func = st->func;
> 
> 	regs->sp += sizeof(long); /* pop func */
> 
> 	func(regs->ip, st->parent_ip, function_trace_op, regs);

I try very hard to limit all indirect function calls from the function tracing
path, as they do add noticeable overhead.

-- Steve

> }
> 
> Hmm? I didn't look into the function_graph thing, but I imagine it can
> be added without too much pain.
> 
