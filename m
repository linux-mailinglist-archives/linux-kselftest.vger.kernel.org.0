Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9565510D16
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 May 2019 21:14:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726077AbfEATOI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 1 May 2019 15:14:08 -0400
Received: from merlin.infradead.org ([205.233.59.134]:47726 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726019AbfEATOI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 1 May 2019 15:14:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=CQZu/nhAN5edPKc+7iLxYRmq0e/3BquQrybqmy+ub08=; b=kV7BH9e/fZOTUtilmbKXOkCiV
        cz68cQ45IykgvQQvjPtQ91s1A3FHoc4l8yPl6DtyoAUW7psmDTq8TptOuHRy2DWwxof2ScJ0n26g8
        +p3QtsdE8qhgm5ys0tT6IZP/bZVqrceefDeDn3zbQWrd0WSiBJnE7Dez8c9R1B5K96xBI5BzioGke
        aOQm85JWi3oV0BrQvPO3gcl2SE1WsnnhDDPHJZpLgGkuPaHyZ5hov9fbcukmlTq9Y5TcvpvRxWY3C
        +qIr+b+4qcPdAZqkigz6+8+61KkKJf2x7Hefo+6LTLtysSYIp4SLDWa351erSFGEgA45thEMbmePY
        Zk5Af9Wfg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hLufX-0002s6-8q; Wed, 01 May 2019 19:13:27 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7370D984EB4; Wed,  1 May 2019 21:13:24 +0200 (CEST)
Date:   Wed, 1 May 2019 21:13:24 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
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
Message-ID: <20190501191324.GU7905@worktop.programming.kicks-ass.net>
References: <CAHk-=wg1QPz0m+7jnVcjQgkySUQLzAXE8_PZARV-vWYK27LB=w@mail.gmail.com>
 <20190430135602.GD2589@hirez.programming.kicks-ass.net>
 <CAHk-=wg7vUGMRHyBsLig6qiPK0i4_BK3bRrTN+HHHziUGg1P_A@mail.gmail.com>
 <CALCETrXujRWxwkgAwB+8xja3N9H22t52AYBYM_mbrjKKZ624Eg@mail.gmail.com>
 <20190430130359.330e895b@gandalf.local.home>
 <20190430132024.0f03f5b8@gandalf.local.home>
 <20190430134913.4e29ce72@gandalf.local.home>
 <CAHk-=wjJ8D74+FDcXGL65Q9aB0cc7B4vr2s2rS6V4d4a3hU-1Q@mail.gmail.com>
 <20190501131117.GW2623@hirez.programming.kicks-ass.net>
 <CAHk-=wjCoycqdVjvWkkFnVRQS9fHEzdmiAG4uUV8B04xv7ZVwA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjCoycqdVjvWkkFnVRQS9fHEzdmiAG4uUV8B04xv7ZVwA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, May 01, 2019 at 12:03:52PM -0700, Linus Torvalds wrote:
> On Wed, May 1, 2019 at 6:11 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > Here goes, compile tested only...
> 
> Ugh, two different threads. This has the same bug (same source) as the
> one Steven posted:

This is what Steve started from; lets continue in the other thread.

> > --- a/arch/x86/entry/entry_32.S
> > +++ b/arch/x86/entry/entry_32.S
> > @@ -1479,6 +1479,13 @@ ENTRY(int3)
> >         ASM_CLAC
> >         pushl   $-1                             # mark this as an int
> >
> > +       testl   $SEGMENT_RPL_MASK, PT_CS(%esp)
> > +       jnz     .Lfrom_usermode_no_gap
> > +       .rept 6
> > +       pushl   5*4(%esp)
> > +       .endr
> > +.Lfrom_usermode_no_gap:
> 
> This will corrupt things horribly if you still use vm86 mode. Checking
> CS RPL is simply not correct.

I'll go fix; I never really understood that vm86 crud and I cobbled this
32bit thing together based on the 64bit version (that Josh did a while
ago).
