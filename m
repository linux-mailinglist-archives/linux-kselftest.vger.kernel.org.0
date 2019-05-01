Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E6A710D00
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 May 2019 21:04:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726120AbfEATEU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 1 May 2019 15:04:20 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:37302 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726096AbfEATEU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 1 May 2019 15:04:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=VNCyKNchmG8uJyDZBNfvh+ZXwPXv3ObxEe6ybUIbxas=; b=ZPHh/iHX909FhdEWVMA4QJdeW
        sLpmidqy0xvcDozQ+OXAes5vq91NYUU8aWQX86/k9ygeaIY4C7zZMqciOMHZ5R1OoZshv/ZPdS+K9
        u1PoDqxV0n/W43OV4ZA4s7ibK6p3RWi5YjKnVE8oCGoooF0f7HgqqqOkUfPzmRSaX8pRohKrfopVj
        EL1OQIax2iEVJGug2UG2gK7rSdYoYkZI4YzDwida3M3580xWnQVXqAkq+B42Wz50U3v4QZ0BV8z4m
        vc1eMsAwaflmpXsQfy08fXm43c2+yfdiZ0P8nvRJ6GDxEf0U0pMeCIHa+EDvgIm1EKKdmbrxvjHNk
        FoGC73ovw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hLuWF-0005bC-D6; Wed, 01 May 2019 19:03:51 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8B6B7984EB4; Wed,  1 May 2019 21:03:48 +0200 (CEST)
Date:   Wed, 1 May 2019 21:03:48 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
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
Subject: Re: [RFC][PATCH] ftrace/x86: Emulate call function while updating in
 breakpoint handler
Message-ID: <20190501190348.GT7905@worktop.programming.kicks-ass.net>
References: <CAHk-=wg1QPz0m+7jnVcjQgkySUQLzAXE8_PZARV-vWYK27LB=w@mail.gmail.com>
 <20190430135602.GD2589@hirez.programming.kicks-ass.net>
 <CAHk-=wg7vUGMRHyBsLig6qiPK0i4_BK3bRrTN+HHHziUGg1P_A@mail.gmail.com>
 <CALCETrXujRWxwkgAwB+8xja3N9H22t52AYBYM_mbrjKKZ624Eg@mail.gmail.com>
 <20190430130359.330e895b@gandalf.local.home>
 <20190430132024.0f03f5b8@gandalf.local.home>
 <20190430134913.4e29ce72@gandalf.local.home>
 <CAHk-=wjJ8D74+FDcXGL65Q9aB0cc7B4vr2s2rS6V4d4a3hU-1Q@mail.gmail.com>
 <20190501131117.GW2623@hirez.programming.kicks-ass.net>
 <20190501145824.08aed43a@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190501145824.08aed43a@gandalf.local.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, May 01, 2019 at 02:58:24PM -0400, Steven Rostedt wrote:
> > +	if (ftrace_location(ip)) {
> > +		int3_emulate_call(regs, ftrace_update_func_call);
> 
> Should be:
> 
> 		int3_emulate_call(regs, (unsigned long)ftrace_regs_caller);

Ah, I lost the plot a little there.

> > +		return 1;
> > +	} else if (is_ftrace_caller(ip)) {
> > +		if (!ftrace_update_func_call) {
> > +			int3_emulate_jmp(regs, regs->ip - INT3_INSN_SIZE + CALL_INSN_SIZE);
> 
> I see what you did here, but I think:
> 
> 			int3_emulate_jmp(regs, ip + CALL_INSN_SIZE);
> 
> looks better. But that said, we could in the beginning do:
> 
> 	ip = regs->ip - INT3_INSN_SIZE;
> 
> instead of
> 
> 	ip = regs->ip - 1;
> 
> I made these updates and posted them to Linus.

I was actually considering:

static inline void int3_emulate_nop(struct pt_regs *regs, unsigned long size)
{
	int3_emulate_jmp(regs, regs->ip - INT3_INSN_SIZE + size);
}

And then the above becomes:

	int3_emulate_nop(regs, CALL_INSN_SIZE);

Hmm?
