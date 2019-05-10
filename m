Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D6FD19D11
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 May 2019 14:15:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727186AbfEJMPN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 10 May 2019 08:15:13 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:41502 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727071AbfEJMPM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 10 May 2019 08:15:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Em3xUx8OU5myWSz19MVf2olcW8HqbJsKte6x2bbfO4c=; b=GgSVnXOqy6bXFxi9moLjllNQ+l
        AQ3cemlSicRCOAD5N4AQoB5OzXTJMHMxN08gce5nHeYLmEU4jU0TNwAuLnDtQbtfogERybtgP353Q
        iNZvH230ZQYA3Rlt6W5eMm6463sstKfBIDpE9Hbs3s4QaFtVnviRsYCkBjzEES37YpFXuK4o2iiqg
        kHUlS4oCerEpt957g7Ukk3OsDcI9PzrtwumCFllLmw1uXVwS1+Tv0hzgOS9E/ll3VouERMDkcuA35
        gaJ3b1Y3wCTg+peOJurHetwWu6J091tUKb1K6L5X9KLgIcf6AGUGzqtHdNHNj9wv32kaYaFZiYB80
        Cc67HBPg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hP4QJ-0004iz-7L; Fri, 10 May 2019 12:14:47 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 896172029F1F3; Fri, 10 May 2019 14:14:45 +0200 (CEST)
Date:   Fri, 10 May 2019 14:14:45 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Andy Lutomirski <luto@amacapital.net>,
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
Message-ID: <20190510121445.GS2589@hirez.programming.kicks-ass.net>
References: <20190508115416.nblx7c2kocidpytm@treble>
 <20190508120416.GL2589@hirez.programming.kicks-ass.net>
 <20190508124248.u5ukpbhnh4wpiccq@treble>
 <20190508153907.GM2589@hirez.programming.kicks-ass.net>
 <20190508184848.qerg3flv3ej3xsev@treble>
 <20190509102030.dfa62e058f09d0d8cbdd6053@kernel.org>
 <20190509081431.GO2589@hirez.programming.kicks-ass.net>
 <81170F0B-A2BB-4CD6-A1B5-5E7E0DDBC282@amacapital.net>
 <20190509174316.pzuakeu657g3fnlm@home.goodmis.org>
 <20190510122103.5a7bc5416b7af96b27d4fab4@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190510122103.5a7bc5416b7af96b27d4fab4@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, May 10, 2019 at 12:21:03PM +0900, Masami Hiramatsu wrote:
> On Thu, 9 May 2019 13:43:16 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > On Thu, May 09, 2019 at 09:20:06AM -0700, Andy Lutomirski wrote:
> > > > +END(call_to_exception_trampoline)
> > > > --- a/arch/x86/kernel/kprobes/core.c
> > > > +++ b/arch/x86/kernel/kprobes/core.c
> > > > @@ -731,29 +731,8 @@ asm(
> > > >    ".global kretprobe_trampoline\n"
> > > >    ".type kretprobe_trampoline, @function\n"
> > > >    "kretprobe_trampoline:\n"
> > > > -    /* We don't bother saving the ss register */
> > > > -#ifdef CONFIG_X86_64
> > > > -    "    pushq %rsp\n"
> > > > -    "    pushfq\n"
> > > > -    SAVE_REGS_STRING
> > > > -    "    movq %rsp, %rdi\n"
> > > > -    "    call trampoline_handler\n"
> > > > -    /* Replace saved sp with true return address. */
> > > > -    "    movq %rax, 19*8(%rsp)\n"
> > > > -    RESTORE_REGS_STRING
> > > > -    "    popfq\n"
> > > > -#else
> > > > -    "    pushl %esp\n"
> > > > -    "    pushfl\n"
> > > > -    SAVE_REGS_STRING
> > > > -    "    movl %esp, %eax\n"
> > > > -    "    call trampoline_handler\n"
> > > > -    /* Replace saved sp with true return address. */
> > > > -    "    movl %eax, 15*4(%esp)\n"
> > > > -    RESTORE_REGS_STRING
> > > > -    "    popfl\n"
> > > > -#endif
> > > > -    "    ret\n"
> > > > +    "push trampoline_handler\n"
> > > > +    "jmp call_to_exception_trampoline\n"
> > > >    ".size kretprobe_trampoline, .-kretprobe_trampoline\n"
> > > > );
> > > 
> > > 
> > > Potentially minor nit: you’re doing popfl, but you’re not doing TRACE_IRQ_whatever.  This makes me think that you should either add the tracing (ugh!) or you should maybe just skip the popfl.
> > 
> > 
> > Note, kprobes (and ftrace for that matter) are not saving flags for
> > interrupts, but because it must not modify the sign, zero and carry flags.

Uh, C ABI considers those clobbered over function calls, surely. Relying
on those flags over a CALL would be _insane_.
