Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A49B618B16
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 May 2019 16:00:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726426AbfEIOAN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 9 May 2019 10:00:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47604 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726192AbfEIOAN (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 9 May 2019 10:00:13 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 435DB307C643;
        Thu,  9 May 2019 14:00:13 +0000 (UTC)
Received: from treble (ovpn-123-166.rdu2.redhat.com [10.10.123.166])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 76DEB10027C3;
        Thu,  9 May 2019 14:00:03 +0000 (UTC)
Date:   Thu, 9 May 2019 09:00:01 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
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
Message-ID: <20190509140001.fvwzlnhai6ddqjmt@treble>
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
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190509081431.GO2589@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Thu, 09 May 2019 14:00:13 +0000 (UTC)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, May 09, 2019 at 10:14:31AM +0200, Peter Zijlstra wrote:
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
> }
> 
> Hmm? I didn't look into the function_graph thing, but I imagine it can
> be added without too much pain.

I like this patch a lot, assuming it can be made to work for the
different users.

-- 
Josh
