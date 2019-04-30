Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B9D4FB4A
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Apr 2019 16:21:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726400AbfD3OVX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 30 Apr 2019 10:21:23 -0400
Received: from merlin.infradead.org ([205.233.59.134]:37940 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726015AbfD3OVX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 30 Apr 2019 10:21:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=DmPQLX/JhEDEHGtqAEZE1FkXZlxjBDwjwufypaIFiWs=; b=VnwvnEcnA1SyY3k0IXuwFMawd
        DPw6MkCqF+3qVTl302bH8+OWQeMLZxjmBZkpjs84ZS4cMoytqKQoNtRXSlK0k7TcKUpAZyLnv6atk
        eeSC9a1NLauiM7FrPFkXg13HgtTQLngTScVK2LVJqSu7KhSJq3Vwk3UDktsjfB2qwtKv5q+DNkl/C
        3aen4Z2JIxMF1it3ut5qhj6Cy2WjlBzd+LBWtttEy5BceexLULpmSj85ylW9ajEnRUtSMVzCLItKx
        A0WWvqcB3pVZs9iHg6k0Em3cCrh/cuzy9zWWLJCHSD6/tFWsliJmEzRKbZfQ56uQT+4Gv+/e0VWSc
        olIuh6UXg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hLTcm-0001Yt-O1; Tue, 30 Apr 2019 14:20:48 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8106F29D226A0; Tue, 30 Apr 2019 16:20:47 +0200 (CEST)
Date:   Tue, 30 Apr 2019 16:20:47 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
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
Message-ID: <20190430142047.GF2589@hirez.programming.kicks-ass.net>
References: <20190427100639.15074-1-nstange@suse.de>
 <20190427100639.15074-4-nstange@suse.de>
 <20190427102657.GF2623@hirez.programming.kicks-ass.net>
 <20190428133826.3e142cfd@oasis.local.home>
 <CAHk-=wh5OpheSU8Em_Q3Hg8qw_JtoijxOdPtHru6d+5K8TWM=A@mail.gmail.com>
 <20190429145250.1a5da6ed@gandalf.local.home>
 <20190430104648.GR2623@hirez.programming.kicks-ass.net>
 <20190430094445.13e61f41@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190430094445.13e61f41@gandalf.local.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Apr 30, 2019 at 09:44:45AM -0400, Steven Rostedt wrote:
> On Tue, 30 Apr 2019 12:46:48 +0200
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > On Mon, Apr 29, 2019 at 02:52:50PM -0400, Steven Rostedt wrote:
> > > On Mon, 29 Apr 2019 11:06:58 -0700
> > > Linus Torvalds <torvalds@linux-foundation.org> wrote:
> > >   
> > > > +void replace_call(void *addr, const void *opcode, size_t len, void *target)
> > > > +{
> > > > +	bp_int3_call_target = target;
> > > > +	bp_int3_call_return = addr + len;
> > > > +	bp_int3_handler_irqoff = emulate_call_irqoff;
> > > > +	text_poke_bp(addr, opcode, len, emulate_call_irqon);
> > > > +}  
> > > 
> > > Note, the function tracer does not use text poke. It does it in batch
> > > mode. It can update over 40,000 calls in one go:  
> > 
> > Note that Daniel is adding batch stuff to text_poke(), because
> > jump_label/static_key stuffs also end up wanting to change more than one
> > site at a time and IPI spraying the machine for every single instance is
> > hurting.
> > 
> > So ideally ftrace would start to use the 'normal' code when that
> > happens.
> 
> Sure, but that's a completely different issue. We would need to solve
> the 'emulate' call for batch mode first.

I don't see a problem there; when INT3 happens; you bsearch() the batch
array to find the one you hit, you frob that into the percpu variables
and do the thing. Or am I loosing the plot again?
