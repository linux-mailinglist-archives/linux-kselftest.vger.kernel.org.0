Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B9D210CEF
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 May 2019 20:58:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726101AbfEAS63 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 1 May 2019 14:58:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:32810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726019AbfEAS63 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 1 May 2019 14:58:29 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D793420675;
        Wed,  1 May 2019 18:58:25 +0000 (UTC)
Date:   Wed, 1 May 2019 14:58:24 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
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
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        live-patching@vger.kernel.org,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Subject: Re: [RFC][PATCH] ftrace/x86: Emulate call function while updating
 in breakpoint handler
Message-ID: <20190501145824.08aed43a@gandalf.local.home>
In-Reply-To: <20190501131117.GW2623@hirez.programming.kicks-ass.net>
References: <CAHk-=whay7eN6+2gZjY-ybRbkbcqAmgrLwwszzHx8ws3c=S-MA@mail.gmail.com>
 <CALCETrXzVU0Q7u1q=QFPaDr=aojjF5cjbOi9CxxXnp5GqTqsWA@mail.gmail.com>
 <CAHk-=wg1QPz0m+7jnVcjQgkySUQLzAXE8_PZARV-vWYK27LB=w@mail.gmail.com>
 <20190430135602.GD2589@hirez.programming.kicks-ass.net>
 <CAHk-=wg7vUGMRHyBsLig6qiPK0i4_BK3bRrTN+HHHziUGg1P_A@mail.gmail.com>
 <CALCETrXujRWxwkgAwB+8xja3N9H22t52AYBYM_mbrjKKZ624Eg@mail.gmail.com>
 <20190430130359.330e895b@gandalf.local.home>
 <20190430132024.0f03f5b8@gandalf.local.home>
 <20190430134913.4e29ce72@gandalf.local.home>
 <CAHk-=wjJ8D74+FDcXGL65Q9aB0cc7B4vr2s2rS6V4d4a3hU-1Q@mail.gmail.com>
 <20190501131117.GW2623@hirez.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, 1 May 2019 15:11:17 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> On Tue, Apr 30, 2019 at 11:33:21AM -0700, Linus Torvalds wrote:
> > Anyway, since Andy really likes the entry code change, can we have
> > that patch in parallel and judge the difference that way? Iirc, that
> > was x86-64 specific too.  
> 
> Here goes, compile tested only...
> 
> It obviously needs a self-test, but that shoulnd't be too hard to
> arrange.
> 

I was able to get it applied (with slight tweaking) but it then
crashed. But that was due to incorrect updates in the
ftrace_int3_handler().

> ---
>  arch/x86/entry/entry_32.S            |  7 +++++++
>  arch/x86/entry/entry_64.S            | 14 ++++++++++++--
>  arch/x86/include/asm/text-patching.h | 20 ++++++++++++++++++++
>  arch/x86/kernel/ftrace.c             | 24 +++++++++++++++++++-----
>  4 files changed, 58 insertions(+), 7 deletions(-)


>  #endif /* _ASM_X86_TEXT_PATCHING_H */
> diff --git a/arch/x86/kernel/ftrace.c b/arch/x86/kernel/ftrace.c
> index ef49517f6bb2..90d319687d7e 100644
> --- a/arch/x86/kernel/ftrace.c
> +++ b/arch/x86/kernel/ftrace.c
> @@ -29,6 +29,7 @@
>  #include <asm/kprobes.h>
>  #include <asm/ftrace.h>
>  #include <asm/nops.h>
> +#include <asm/text-patching.h>
>  
>  #ifdef CONFIG_DYNAMIC_FTRACE
>  
> @@ -231,6 +232,7 @@ int ftrace_modify_call(struct dyn_ftrace *rec,
> unsigned long old_addr, }
>  
>  static unsigned long ftrace_update_func;
> +static unsigned long ftrace_update_func_call;
>  
>  static int update_ftrace_func(unsigned long ip, void *new)
>  {
> @@ -259,6 +261,8 @@ int ftrace_update_ftrace_func(ftrace_func_t func)
>  	unsigned char *new;
>  	int ret;
>  
> +	ftrace_update_func_call = (unsigned long)func;
> +
>  	new = ftrace_call_replace(ip, (unsigned long)func);
>  	ret = update_ftrace_func(ip, new);
>  
> @@ -295,12 +299,19 @@ int ftrace_int3_handler(struct pt_regs *regs)
>  		return 0;
>  
>  	ip = regs->ip - 1;
> -	if (!ftrace_location(ip) && !is_ftrace_caller(ip))
> -		return 0;
> -
> -	regs->ip += MCOUNT_INSN_SIZE - 1;
> +	if (ftrace_location(ip)) {
> +		int3_emulate_call(regs, ftrace_update_func_call);

Should be:

		int3_emulate_call(regs, (unsigned long)ftrace_regs_caller);

> +		return 1;
> +	} else if (is_ftrace_caller(ip)) {
> +		if (!ftrace_update_func_call) {
> +			int3_emulate_jmp(regs, regs->ip - INT3_INSN_SIZE + CALL_INSN_SIZE);

I see what you did here, but I think:

			int3_emulate_jmp(regs, ip + CALL_INSN_SIZE);

looks better. But that said, we could in the beginning do:

	ip = regs->ip - INT3_INSN_SIZE;

instead of

	ip = regs->ip - 1;

I made these updates and posted them to Linus.

-- Steve


> +			return 1;
> +		}
> +		int3_emulate_call(regs, ftrace_update_func_call);
> +		return 1;
> +	}
>  
> -	return 1;
> +	return 0;
>  }
>  NOKPROBE_SYMBOL(ftrace_int3_handler);
>  
> @@ -859,6 +870,8 @@ void arch_ftrace_update_trampoline(struct
> ftrace_ops *ops) 
>  	func = ftrace_ops_get_func(ops);
>  
> +	ftrace_update_func_call = (unsigned long)func;
> +
>  	/* Do a safe modify in case the trampoline is executing */
>  	new = ftrace_call_replace(ip, (unsigned long)func);
>  	ret = update_ftrace_func(ip, new);
> @@ -960,6 +973,7 @@ static int ftrace_mod_jmp(unsigned long ip, void
> *func) {
>  	unsigned char *new;
>  
> +	ftrace_update_func_call = 0UL;
>  	new = ftrace_jmp_replace(ip, (unsigned long)func);
>  
>  	return update_ftrace_func(ip, new);
