Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E83118F7F
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 May 2019 19:43:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbfEIRn1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 9 May 2019 13:43:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:37600 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726576AbfEIRn1 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 9 May 2019 13:43:27 -0400
Received: from home.goodmis.org (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A989A20675;
        Thu,  9 May 2019 17:43:23 +0000 (UTC)
Date:   Thu, 9 May 2019 13:43:16 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
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
Message-ID: <20190509174316.pzuakeu657g3fnlm@home.goodmis.org>
References: <20190508074901.982470324@infradead.org>
 <20190508080612.721269814@infradead.org>
 <20190508115416.nblx7c2kocidpytm@treble>
 <20190508120416.GL2589@hirez.programming.kicks-ass.net>
 <20190508124248.u5ukpbhnh4wpiccq@treble>
 <20190508153907.GM2589@hirez.programming.kicks-ass.net>
 <20190508184848.qerg3flv3ej3xsev@treble>
 <20190509102030.dfa62e058f09d0d8cbdd6053@kernel.org>
 <20190509081431.GO2589@hirez.programming.kicks-ass.net>
 <81170F0B-A2BB-4CD6-A1B5-5E7E0DDBC282@amacapital.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <81170F0B-A2BB-4CD6-A1B5-5E7E0DDBC282@amacapital.net>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, May 09, 2019 at 09:20:06AM -0700, Andy Lutomirski wrote:
> > +END(call_to_exception_trampoline)
> > --- a/arch/x86/kernel/kprobes/core.c
> > +++ b/arch/x86/kernel/kprobes/core.c
> > @@ -731,29 +731,8 @@ asm(
> >    ".global kretprobe_trampoline\n"
> >    ".type kretprobe_trampoline, @function\n"
> >    "kretprobe_trampoline:\n"
> > -    /* We don't bother saving the ss register */
> > -#ifdef CONFIG_X86_64
> > -    "    pushq %rsp\n"
> > -    "    pushfq\n"
> > -    SAVE_REGS_STRING
> > -    "    movq %rsp, %rdi\n"
> > -    "    call trampoline_handler\n"
> > -    /* Replace saved sp with true return address. */
> > -    "    movq %rax, 19*8(%rsp)\n"
> > -    RESTORE_REGS_STRING
> > -    "    popfq\n"
> > -#else
> > -    "    pushl %esp\n"
> > -    "    pushfl\n"
> > -    SAVE_REGS_STRING
> > -    "    movl %esp, %eax\n"
> > -    "    call trampoline_handler\n"
> > -    /* Replace saved sp with true return address. */
> > -    "    movl %eax, 15*4(%esp)\n"
> > -    RESTORE_REGS_STRING
> > -    "    popfl\n"
> > -#endif
> > -    "    ret\n"
> > +    "push trampoline_handler\n"
> > +    "jmp call_to_exception_trampoline\n"
> >    ".size kretprobe_trampoline, .-kretprobe_trampoline\n"
> > );
> 
> 
> Potentially minor nit: you’re doing popfl, but you’re not doing TRACE_IRQ_whatever.  This makes me think that you should either add the tracing (ugh!) or you should maybe just skip the popfl.


Note, kprobes (and ftrace for that matter) are not saving flags for
interrupts, but because it must not modify the sign, zero and carry flags.

-- Steve

