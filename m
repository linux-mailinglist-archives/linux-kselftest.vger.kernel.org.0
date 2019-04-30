Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9EFFFFABD
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Apr 2019 15:44:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726294AbfD3Nou (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 30 Apr 2019 09:44:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:51764 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726053AbfD3Nou (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 30 Apr 2019 09:44:50 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A8DAC21670;
        Tue, 30 Apr 2019 13:44:47 +0000 (UTC)
Date:   Tue, 30 Apr 2019 09:44:45 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
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
        Andy Lutomirski <luto@kernel.org>,
        Joerg Roedel <jroedel@suse.de>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        live-patching@vger.kernel.org,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH 3/4] x86/ftrace: make ftrace_int3_handler() not to skip
 fops invocation
Message-ID: <20190430094445.13e61f41@gandalf.local.home>
In-Reply-To: <20190430104648.GR2623@hirez.programming.kicks-ass.net>
References: <20190427100639.15074-1-nstange@suse.de>
        <20190427100639.15074-4-nstange@suse.de>
        <20190427102657.GF2623@hirez.programming.kicks-ass.net>
        <20190428133826.3e142cfd@oasis.local.home>
        <CAHk-=wh5OpheSU8Em_Q3Hg8qw_JtoijxOdPtHru6d+5K8TWM=A@mail.gmail.com>
        <20190429145250.1a5da6ed@gandalf.local.home>
        <20190430104648.GR2623@hirez.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, 30 Apr 2019 12:46:48 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> On Mon, Apr 29, 2019 at 02:52:50PM -0400, Steven Rostedt wrote:
> > On Mon, 29 Apr 2019 11:06:58 -0700
> > Linus Torvalds <torvalds@linux-foundation.org> wrote:
> >   
> > > +void replace_call(void *addr, const void *opcode, size_t len, void *target)
> > > +{
> > > +	bp_int3_call_target = target;
> > > +	bp_int3_call_return = addr + len;
> > > +	bp_int3_handler_irqoff = emulate_call_irqoff;
> > > +	text_poke_bp(addr, opcode, len, emulate_call_irqon);
> > > +}  
> > 
> > Note, the function tracer does not use text poke. It does it in batch
> > mode. It can update over 40,000 calls in one go:  
> 
> Note that Daniel is adding batch stuff to text_poke(), because
> jump_label/static_key stuffs also end up wanting to change more than one
> site at a time and IPI spraying the machine for every single instance is
> hurting.
> 
> So ideally ftrace would start to use the 'normal' code when that
> happens.

Sure, but that's a completely different issue. We would need to solve
the 'emulate' call for batch mode first.

-- Steve
