Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 19F051B1BA
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 May 2019 10:15:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727371AbfEMIPV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 13 May 2019 04:15:21 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:56524 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727355AbfEMIPV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 13 May 2019 04:15:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=KnyNPpS3/IuZil8Uli/e5qg23u6Dh+UGd1Izdvt9Xl4=; b=ryFblFXjlXk+SBg6r2yrKzeaE
        oNV1g8kuLX0GcGWBlWRn4+AGoZfop572rLjUfVXK2G5b8+oF57G4YLNQ3nTamzPjdSky5aPd7q74f
        855iziskHlTtfgJZVmHqUHQFgsUyUVLw6q/Rz5qQ0fHSGAyw6Gbx5AO9zyp4lOyz/M2y5ij6/71J+
        KjEK3HOHjMa85n313NabRj9GoTRj9eTaZz8e637X50fcPmaMnC9cd934Yd1SnWb5uE+LNBz8t3z6O
        zO/avz/svOREVoXFSULdd5XfrmuJtEvANn8pk6XeYKVJZgcolRn3KmkxR6V9uxMc8OZmZwNIeawR+
        LCBLlT/tA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hQ670-000470-DV; Mon, 13 May 2019 08:15:06 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id DCF902029FD7A; Mon, 13 May 2019 10:15:03 +0200 (CEST)
Date:   Mon, 13 May 2019 10:15:03 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
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
Message-ID: <20190513081503.GK2623@hirez.programming.kicks-ass.net>
References: <20190508124248.u5ukpbhnh4wpiccq@treble>
 <20190508153907.GM2589@hirez.programming.kicks-ass.net>
 <20190508184848.qerg3flv3ej3xsev@treble>
 <20190509102030.dfa62e058f09d0d8cbdd6053@kernel.org>
 <20190509081431.GO2589@hirez.programming.kicks-ass.net>
 <20190509230106.3551b08553440d125e437f66@kernel.org>
 <20190509171416.GY2623@hirez.programming.kicks-ass.net>
 <20190510135831.c4ad309c68fc254f819194fc@kernel.org>
 <20190510124054.GV2589@hirez.programming.kicks-ass.net>
 <20190511095655.405147cde331cd1da539d0e8@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190511095655.405147cde331cd1da539d0e8@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, May 11, 2019 at 09:56:55AM +0900, Masami Hiramatsu wrote:
> On Fri, 10 May 2019 14:40:54 +0200
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > On Fri, May 10, 2019 at 01:58:31PM +0900, Masami Hiramatsu wrote:
> > > On Thu, 9 May 2019 19:14:16 +0200
> > > Peter Zijlstra <peterz@infradead.org> wrote:
> > > > > > --- a/arch/x86/kernel/kprobes/core.c
> > > > > > +++ b/arch/x86/kernel/kprobes/core.c
> > > > > > @@ -731,29 +731,8 @@ asm(
> > > > > >  	".global kretprobe_trampoline\n"
> > > > > >  	".type kretprobe_trampoline, @function\n"
> > > > > >  	"kretprobe_trampoline:\n"
> > 
> > > > > Here, we need a gap for storing ret-ip, because kretprobe_trampoline is
> > > > > the address which is returned from the target function. We have no 
> > > > > "ret-ip" here at this point. So something like
> > > > > 
> > > > > +	"push $0\n"	/* This is a gap, will be filled with real return address*/
> > > > 
> > > > The trampoline already provides a gap, trampoline_handler() will need to
> > > > use int3_emulate_push() if it wants to inject something on the return
> > > > stack.
> > > 
> > > I guess you mean the int3 case. This trampoline is used as a return destination.
> > 
> > > When the target function is called, kretprobe interrupts the first instruction,
> > > and replace the return address with this trampoline. When a "ret" instruction
> > > is done, it returns to this trampoline. Thus the stack frame start with
> > > previous context here. As you described above,
> > 
> > I would prefer to change that to inject an extra return address, instead
> > of replacing it. With the new exception stuff we can actually do that.
> > 
> > So on entry we then go from:
> > 
> > 	<previous context>
> > 	RET-IP
> > 
> > to
> > 
> > 	<previous context>
> > 	RET-IP
> > 	return-trampoline
> > 
> > So when the function returns, it falls into the trampoline instead.
> 
> Is that really possible? On x86-64, most parameters are passed by registers,
> but x86-32 (and x86-64 in rare case) some parameters can be passed by stack.
> If we change the stack layout in the function prologue, the code in
> function body can not access those parameters on stack.

Ooh, I see what you mean... yes that might be trouble indeed. Damn..
