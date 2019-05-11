Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 16B3E1A5F7
	for <lists+linux-kselftest@lfdr.de>; Sat, 11 May 2019 02:57:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728165AbfEKA5F (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 10 May 2019 20:57:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:49294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728079AbfEKA5F (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 10 May 2019 20:57:05 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D9419217D7;
        Sat, 11 May 2019 00:56:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557536223;
        bh=192hqAeX73EIOnp8rUHUxJQFygKBG3o6jcfAO47fW1o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=g/mmeDe64gdo1ZjwwOmn4qMdV9rQze6g9V9u38yEXR51rNwckbO5Hq3iLvya1p2Ci
         q6nZZTK4RLWkcnTchlYU2FnYXJKSXl3iKtUHsy3a/MC6WY/XSkXwrB6DgbHR0j0GS+
         rQU4xloCOUyoX348bNXGo4YdpszyohKPxGAjsrtc=
Date:   Sat, 11 May 2019 09:56:55 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>, linux-kernel@vger.kernel.org,
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
Message-Id: <20190511095655.405147cde331cd1da539d0e8@kernel.org>
In-Reply-To: <20190510124054.GV2589@hirez.programming.kicks-ass.net>
References: <20190508115416.nblx7c2kocidpytm@treble>
        <20190508120416.GL2589@hirez.programming.kicks-ass.net>
        <20190508124248.u5ukpbhnh4wpiccq@treble>
        <20190508153907.GM2589@hirez.programming.kicks-ass.net>
        <20190508184848.qerg3flv3ej3xsev@treble>
        <20190509102030.dfa62e058f09d0d8cbdd6053@kernel.org>
        <20190509081431.GO2589@hirez.programming.kicks-ass.net>
        <20190509230106.3551b08553440d125e437f66@kernel.org>
        <20190509171416.GY2623@hirez.programming.kicks-ass.net>
        <20190510135831.c4ad309c68fc254f819194fc@kernel.org>
        <20190510124054.GV2589@hirez.programming.kicks-ass.net>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, 10 May 2019 14:40:54 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> On Fri, May 10, 2019 at 01:58:31PM +0900, Masami Hiramatsu wrote:
> > On Thu, 9 May 2019 19:14:16 +0200
> > Peter Zijlstra <peterz@infradead.org> wrote:
> > > > > --- a/arch/x86/kernel/kprobes/core.c
> > > > > +++ b/arch/x86/kernel/kprobes/core.c
> > > > > @@ -731,29 +731,8 @@ asm(
> > > > >  	".global kretprobe_trampoline\n"
> > > > >  	".type kretprobe_trampoline, @function\n"
> > > > >  	"kretprobe_trampoline:\n"
> 
> > > > Here, we need a gap for storing ret-ip, because kretprobe_trampoline is
> > > > the address which is returned from the target function. We have no 
> > > > "ret-ip" here at this point. So something like
> > > > 
> > > > +	"push $0\n"	/* This is a gap, will be filled with real return address*/
> > > 
> > > The trampoline already provides a gap, trampoline_handler() will need to
> > > use int3_emulate_push() if it wants to inject something on the return
> > > stack.
> > 
> > I guess you mean the int3 case. This trampoline is used as a return destination.
> 
> > When the target function is called, kretprobe interrupts the first instruction,
> > and replace the return address with this trampoline. When a "ret" instruction
> > is done, it returns to this trampoline. Thus the stack frame start with
> > previous context here. As you described above,
> 
> I would prefer to change that to inject an extra return address, instead
> of replacing it. With the new exception stuff we can actually do that.
> 
> So on entry we then go from:
> 
> 	<previous context>
> 	RET-IP
> 
> to
> 
> 	<previous context>
> 	RET-IP
> 	return-trampoline
> 
> So when the function returns, it falls into the trampoline instead.

Is that really possible? On x86-64, most parameters are passed by registers,
but x86-32 (and x86-64 in rare case) some parameters can be passed by stack.
If we change the stack layout in the function prologue, the code in
function body can not access those parameters on stack.

Thank you,

> 
> > > > > +	 * On entry the stack looks like:
> > > > > +	 *
> > > > > +	 *   2*4(%esp) <previous context>
> > > > > +	 *   1*4(%esp) RET-IP
> > > > > +	 *   0*4(%esp) func
> > 
> > From this trampoline call, the stack looks like:
> > 
> > 	 *   1*4(%esp) <previous context>
> > 	 *   0*4(%esp) func
> > 
> > So we need one more push.
> 
> And then the stack looks just right at this point.
> 
> > > > > +	"push trampoline_handler\n"
> > > > > +	"jmp call_to_exception_trampoline\n"
> > > > >  	".size kretprobe_trampoline, .-kretprobe_trampoline\n"
> > > > >  );
> > > > >  NOKPROBE_SYMBOL(kretprobe_trampoline);


-- 
Masami Hiramatsu <mhiramat@kernel.org>
