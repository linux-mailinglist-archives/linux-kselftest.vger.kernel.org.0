Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6ED9210848
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 May 2019 15:22:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726224AbfEANWz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 1 May 2019 09:22:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:42174 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725993AbfEANWy (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 1 May 2019 09:22:54 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 67D95206DF;
        Wed,  1 May 2019 13:22:51 +0000 (UTC)
Date:   Wed, 1 May 2019 09:22:49 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Nicolai Stange <nstange@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "the arch\/x86 maintainers" <x86@kernel.org>,
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
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        live-patching@vger.kernel.org,
        "open list\:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Subject: Re: [RFC][PATCH v2] ftrace/x86: Emulate call function while
 updating in breakpoint handler
Message-ID: <20190501092249.54cdbd94@gandalf.local.home>
In-Reply-To: <87muk6vavb.fsf@suse.de>
References: <20190428133826.3e142cfd@oasis.local.home>
        <CALCETrXvmZPHsfRVnW0AtyddfN-2zaCmWn+FsrF6XPTOFd_Jmw@mail.gmail.com>
        <CAHk-=whtt4K2f0KPtG-4Pykh3FK8UBOjD8jhXCUKB5nWDj_YRA@mail.gmail.com>
        <CALCETrWELBCK-kqX5FCEDVUy8kCT-yVu7m_7Dtn=GCsHY0Du5A@mail.gmail.com>
        <CAHk-=wgewK4eFhF3=0RNtk1KQjMANFH6oDE=8m=84RExn2gxhw@mail.gmail.com>
        <CAHk-=whay7eN6+2gZjY-ybRbkbcqAmgrLwwszzHx8ws3c=S-MA@mail.gmail.com>
        <CALCETrXzVU0Q7u1q=QFPaDr=aojjF5cjbOi9CxxXnp5GqTqsWA@mail.gmail.com>
        <CAHk-=wg1QPz0m+7jnVcjQgkySUQLzAXE8_PZARV-vWYK27LB=w@mail.gmail.com>
        <20190430135602.GD2589@hirez.programming.kicks-ass.net>
        <CAHk-=wg7vUGMRHyBsLig6qiPK0i4_BK3bRrTN+HHHziUGg1P_A@mail.gmail.com>
        <CALCETrXujRWxwkgAwB+8xja3N9H22t52AYBYM_mbrjKKZ624Eg@mail.gmail.com>
        <20190430130359.330e895b@gandalf.local.home>
        <20190430132024.0f03f5b8@gandalf.local.home>
        <20190430134913.4e29ce72@gandalf.local.home>
        <20190430175334.423821c0@gandalf.local.home>
        <87muk6vavb.fsf@suse.de>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, 01 May 2019 10:26:32 +0200
Nicolai Stange <nstange@suse.de> wrote:

> > +extern asmlinkage void ftrace_emulate_call_irqon(void);
> > +extern asmlinkage void ftrace_emulate_call_irqoff(void);
> > +extern asmlinkage void ftrace_emulate_call_nmi(void);
> > +extern asmlinkage void ftrace_emulate_call_update_irqoff(void);
> > +extern asmlinkage void ftrace_emulate_call_update_irqon(void);
> > +extern asmlinkage void ftrace_emulate_call_update_nmi(void);
> > +
> > +static DEFINE_PER_CPU(void *, ftrace_bp_call_return);
> > +static DEFINE_PER_CPU(void *, ftrace_bp_call_nmi_return);  
> 
> Andy mentioned #DB and #MC exceptions here:
> https://lkml.kernel.org/r/C55DED25-C60D-4731-9A6B-92BDA8771766@amacapital.net
> 
> I think that #DB won't be possible, provided the trampolines below get
> tagged as NOKPROBE (do_int3() and ftrace_int3_handler() already have
> it).
> 
> It's highly theoretic, but tracing do_machine_check() could clobber
> ftrace_bp_call_return or ftrace_bp_call_nmi_return?

Probably shouldn't trace do_machine_check() then ;-)

> 
> 
> > +#ifdef CONFIG_SMP
> > +#ifdef CONFIG_X86_64
> > +# define BP_CALL_RETURN		"%gs:ftrace_bp_call_return"
> > +# define BP_CALL_NMI_RETURN	"%gs:ftrace_bp_call_nmi_return"
> > +#else
> > +# define BP_CALL_RETURN		"%fs:ftrace_bp_call_return"
> > +# define BP_CALL_NMI_RETURN	"%fs:ftrace_bp_call_nmi_return"
> > +#endif
> > +#else /* SMP */
> > +# define BP_CALL_RETURN		"ftrace_bp_call_return"
> > +# define BP_CALL_NMI_RETURN	"ftrace_bp_call_nmi_return"
> > +#endif
> > +
> > +/* To hold the ftrace_caller address to push on the stack */
> > +void *ftrace_caller_func = (void *)ftrace_caller;  
> 
> The live patching ftrace_ops need ftrace_regs_caller.

Ah, you're right. Luckily ftrace_regs_caller is a superset of
ftrace_caller. That is, those only needing ftrace_caller can do fine
with ftrace_regs_caller (but not vice versa).

Easy enough to fix.

> 
> 
> > +
> > +asm(
> > +	".text\n"
> > +
> > +	/* Trampoline for function update with interrupts enabled */
> > +	".global ftrace_emulate_call_irqoff\n"
> > +	".type ftrace_emulate_call_irqoff, @function\n"
> > +	"ftrace_emulate_call_irqoff:\n\t"
> > +		"push "BP_CALL_RETURN"\n\t"
> > +		"push ftrace_caller_func\n"
> > +		"sti\n\t"
> > +		"ret\n\t"
> > +	".size ftrace_emulate_call_irqoff, .-ftrace_emulate_call_irqoff\n"
> > +
> > +	/* Trampoline for function update with interrupts disabled*/
> > +	".global ftrace_emulate_call_irqon\n"  
> 
> The naming is perhaps a bit confusing, i.e. "update with interrupts
> disabled" vs. "irqon"... How about swapping irqoff<->irqon?

I just used the terminology Linus used. It is confusing. Perhaps just
call it ftrace_emulate_call (for non sti case) and
ftrace_emulate_call_sti for the sti case. That should remove the
confusion.

-- Steve


