Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A801819705
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 May 2019 05:21:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726864AbfEJDVN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 9 May 2019 23:21:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:36300 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726806AbfEJDVN (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 9 May 2019 23:21:13 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A0CDF2070D;
        Fri, 10 May 2019 03:21:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557458472;
        bh=md8uJQjbiTeBgDn8x+o0ykkj2VLCdtiUYXST6ImPwpA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=PwriJ4AKSBF0zoTUeOVwgZsqV66HEyD9rNCW0AkHHpwF53EFchLmkgKr08TS8EekO
         PLRvTz1iwC/MZRVm6oqELS+MJukS2G62gmhz5fKZC4Ss0iRcH1juEV6/omtNelJSJd
         dp8b0BTUWfTr/RWXFg7uE/hy+yTMtxHgGxjUDp88=
Date:   Fri, 10 May 2019 12:21:03 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Peter Zijlstra <peterz@infradead.org>,
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
Message-Id: <20190510122103.5a7bc5416b7af96b27d4fab4@kernel.org>
In-Reply-To: <20190509174316.pzuakeu657g3fnlm@home.goodmis.org>
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
        <20190509174316.pzuakeu657g3fnlm@home.goodmis.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, 9 May 2019 13:43:16 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Thu, May 09, 2019 at 09:20:06AM -0700, Andy Lutomirski wrote:
> > > +END(call_to_exception_trampoline)
> > > --- a/arch/x86/kernel/kprobes/core.c
> > > +++ b/arch/x86/kernel/kprobes/core.c
> > > @@ -731,29 +731,8 @@ asm(
> > >    ".global kretprobe_trampoline\n"
> > >    ".type kretprobe_trampoline, @function\n"
> > >    "kretprobe_trampoline:\n"
> > > -    /* We don't bother saving the ss register */
> > > -#ifdef CONFIG_X86_64
> > > -    "    pushq %rsp\n"
> > > -    "    pushfq\n"
> > > -    SAVE_REGS_STRING
> > > -    "    movq %rsp, %rdi\n"
> > > -    "    call trampoline_handler\n"
> > > -    /* Replace saved sp with true return address. */
> > > -    "    movq %rax, 19*8(%rsp)\n"
> > > -    RESTORE_REGS_STRING
> > > -    "    popfq\n"
> > > -#else
> > > -    "    pushl %esp\n"
> > > -    "    pushfl\n"
> > > -    SAVE_REGS_STRING
> > > -    "    movl %esp, %eax\n"
> > > -    "    call trampoline_handler\n"
> > > -    /* Replace saved sp with true return address. */
> > > -    "    movl %eax, 15*4(%esp)\n"
> > > -    RESTORE_REGS_STRING
> > > -    "    popfl\n"
> > > -#endif
> > > -    "    ret\n"
> > > +    "push trampoline_handler\n"
> > > +    "jmp call_to_exception_trampoline\n"
> > >    ".size kretprobe_trampoline, .-kretprobe_trampoline\n"
> > > );
> > 
> > 
> > Potentially minor nit: you’re doing popfl, but you’re not doing TRACE_IRQ_whatever.  This makes me think that you should either add the tracing (ugh!) or you should maybe just skip the popfl.
> 
> 
> Note, kprobes (and ftrace for that matter) are not saving flags for
> interrupts, but because it must not modify the sign, zero and carry flags.

Yes, optprobe also has to save and restore the flags.
Above trampline is for kretprobe, which is placed at the function return, so
we don't have to care about flags.

Thanks,
-- 
Masami Hiramatsu <mhiramat@kernel.org>
