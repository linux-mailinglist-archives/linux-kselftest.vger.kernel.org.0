Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 402E9103B2
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 May 2019 03:35:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726412AbfEABfY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 30 Apr 2019 21:35:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:57002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726115AbfEABfX (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 30 Apr 2019 21:35:23 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EC08A21734;
        Wed,  1 May 2019 01:35:19 +0000 (UTC)
Date:   Tue, 30 Apr 2019 21:35:17 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Nicolai Stange <nstange@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
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
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Subject: Re: [RFC][PATCH v2] ftrace/x86: Emulate call function while
 updating in breakpoint handler
Message-ID: <20190430213517.7bcfaf8e@oasis.local.home>
In-Reply-To: <20190430175334.423821c0@gandalf.local.home>
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
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, 30 Apr 2019 17:53:34 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> +	if (ftrace_location(ip)) {
> +		/* A breakpoint at the beginning of the function was hit */
> +		if (in_nmi()) {
> +			/* NMIs have their own trampoline */
> +			this_cpu_write(ftrace_bp_call_nmi_return, (void *)ip + MCOUNT_INSN_SIZE);
> +			regs->ip = (unsigned long) ftrace_emulate_call_nmi;
> +			return 1;
> +		}
> +		this_cpu_write(ftrace_bp_call_return, (void *)ip + MCOUNT_INSN_SIZE);
> +		if (regs->flags & X86_EFLAGS_IF) {
> +			regs->flags &= ~X86_EFLAGS_IF;
> +			regs->ip = (unsigned long) ftrace_emulate_call_irqoff;
> +			/* Tell lockdep here we are enabling interrupts */
> +			trace_hardirqs_on();

This isn't good enough. The return from interrupt does call lockdep
saying interrupts are disabled. Need to add the lockdep tracking in the
asm as well.

Probably easier to move it from inline asm to ftrace_X.S and use the
lockdep TRACE_ON/OFF macros.

-- Steve




> +		} else {
> +			regs->ip = (unsigned long) ftrace_emulate_call_irqon;
> +		}
> +		return 1;
> +	} else if (is_ftrace_caller(ip)) {
> +		/* An ftrace trampoline is being updated */
> +		if (!ftrace_update_func_call) {
> +			/* If it's a jump, just need to skip it */
> +			regs->ip += MCOUNT_INSN_SIZE -1;
> +			return 1;
> +		}
> +		if (in_nmi()) {
> +			/* NMIs have their own trampoline */
> +			this_cpu_write(ftrace_bp_call_nmi_return, (void *)ip + MCOUNT_INSN_SIZE);
> +			regs->ip = (unsigned long) ftrace_emulate_call_update_nmi;
> +			return 1;
> +		}
> +		this_cpu_write(ftrace_bp_call_return, (void *)ip + MCOUNT_INSN_SIZE);
> +		if (regs->flags & X86_EFLAGS_IF) {
> +			regs->flags &= ~X86_EFLAGS_IF;
> +			regs->ip = (unsigned long) ftrace_emulate_call_update_irqoff;
> +			trace_hardirqs_on();
> +		} else {
> +			regs->ip = (unsigned long) ftrace_emulate_call_update_irqon;
> +		}
> +		return 1;
> +	}
>  
> -	return 1;
> +	return 0;
>  }
