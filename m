Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C292B10CF4
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 May 2019 21:00:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726088AbfEATAa (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 1 May 2019 15:00:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:33952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726019AbfEATA3 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 1 May 2019 15:00:29 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C985E20675;
        Wed,  1 May 2019 19:00:26 +0000 (UTC)
Date:   Wed, 1 May 2019 15:00:25 -0400
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
Subject: Re: [RFC][PATCH v3] ftrace/x86_64: Emulate call function while
 updating in breakpoint handler
Message-ID: <20190501150025.40169f1d@gandalf.local.home>
In-Reply-To: <20190501185726.GR7905@worktop.programming.kicks-ass.net>
References: <20190501113238.0ab3f9dd@gandalf.local.home>
        <CAHk-=wjvQxY4DvPrJ6haPgAa6b906h=MwZXO6G8OtiTGe=N7_w@mail.gmail.com>
        <20190501185726.GR7905@worktop.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, 1 May 2019 20:57:26 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> On Wed, May 01, 2019 at 11:01:07AM -0700, Linus Torvalds wrote:
> > This looks sane to me, although I'm surprised that we didn't already
> > have an annotation for the nonstandard stack frame for asm files. That
> > probably would be cleaner in a separate commit, but I guess it doesn't
> > matter.
> > 
> > Anyway, I'm willing to consider the entry code version if it looks a
> > _lot_ simpler than this (so I'd like to see them side-by-side), but
> > it's not like this looks all that complicated to me either.  
> 
> So I posted one earlier today:
> 
>   https://lkml.kernel.org/r/20190501131117.GW2623@hirez.programming.kicks-ass.net
> 
> it's about a 1/3rd the number of lines and has 32bit support. It also
> provides all the bits required to implement static_call().

That's the patch I started with.

> 
> That is; I think I'm firmly in favour of the entry variant -- provided
> it actually works of course.

And it works. I ran it through tools/testing/selftests/ftrace/ftracetest
and it passed as good as without that patch.

I haven't ran it through my full test suite. I can do that and see how
it makes out.

-- Steve
