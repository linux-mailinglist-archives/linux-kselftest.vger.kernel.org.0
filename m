Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3DD95EC7D
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Apr 2019 00:09:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729252AbfD2WHj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 29 Apr 2019 18:07:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:58512 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729409AbfD2WHj (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 29 Apr 2019 18:07:39 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 70E8B2075E;
        Mon, 29 Apr 2019 22:07:35 +0000 (UTC)
Date:   Mon, 29 Apr 2019 18:07:33 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Nicolai Stange <nstange@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
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
Message-ID: <20190429180733.3f25d8b9@gandalf.local.home>
In-Reply-To: <CAHk-=wjGquN7-kQCoa+LHCuiVTjefkk38qwaysd4wLLtoSZhpg@mail.gmail.com>
References: <20190427100639.15074-1-nstange@suse.de>
        <20190427100639.15074-4-nstange@suse.de>
        <20190427102657.GF2623@hirez.programming.kicks-ass.net>
        <20190428133826.3e142cfd@oasis.local.home>
        <CAHk-=wh5OpheSU8Em_Q3Hg8qw_JtoijxOdPtHru6d+5K8TWM=A@mail.gmail.com>
        <20190429145250.1a5da6ed@gandalf.local.home>
        <CAHk-=wjm93jLtVxTX4HZs6K4k1Wqh3ujjmapqaYtcibVk_YnzQ@mail.gmail.com>
        <20190429150724.6e501d27@gandalf.local.home>
        <CAHk-=wgbC-wiSrdDYAh1ORF4EKmecY+MkNsJBF=BWf4W1bXXgA@mail.gmail.com>
        <20190429163043.535f4272@gandalf.local.home>
        <CAHk-=wjGquN7-kQCoa+LHCuiVTjefkk38qwaysd4wLLtoSZhpg@mail.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, 29 Apr 2019 14:38:35 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Mon, Apr 29, 2019 at 1:30 PM Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > The update from "call custom_trampoline" to "call iterator_trampoline"
> > is where we have an issue.  
> 
> So it has never worked. Just tell people that they have two chocies:

The custom call to iterator translation never worked. One option is to
always call the iterator, and just take the hit. There's another
solution to to make permanent updates that would handle the live
patching case, but not for the tracing case. It is more critical for
live patching than tracing (missed traced function is not as critical
as running buggy code unexpectedly). I could look to work on that
instead.

> 
>  - you do the careful rewriting, which takes more time

Which would be the method I said making the call to call a special case.

> 
>  - you do it by rewriting as nop and then back, which is what
> historically has been done, and that is fast and simple, because
> there's no need to be careful.

Except in the live kernel patching case where you just put back the
buggy function.

> 
> Really. I find your complaints completely incomprehensible. You've
> never rewritten call instructions atomically before, and now you
> complain about it being slightly more expensive to do it when I give
> you the code? Yes it damn well will be slightly more expensive. Deal
> with it.

I wasn't complaining about the expense of doing it that way. I was
stating that it would take more time to get it right as it as it would
require a different implementation for the call to call case.


> 
> Btw, once again - I several months ago also gave a suggestion on how
> it could be done batch-mode by having lots of those small stubs and
> just generating them dynamically.
> 
> You never wrote that code *EITHER*. It's been *months*.

Note, I wasn't the one writing the code back then either. I posted a
proof of concept for a similar topic (trace events) for the purpose of
bringing back the performance lost due to the retpolines (something
like 8% hit). Josh took the initiative to do that work, but I don't
remember ever getting to a consensus on a solution to that. Yes you had
given us ideas, but I remember people (like Andy) having concerns with
it. But because it was just an optimization change, and Josh had other
things to work on, that work just stalled.

But I just found out that the function tracing code has the same issue,
but this can cause real problems with live kernel patching. This is why
this patch set started.

> 
> So now I've written the non-batch-mode code for you, and you just
> *complain* about it?

Because this is a different story. The trace event code is updated one
at a time (there's patches out there to do it in batch). But this is
not trace events. This is function tracing which only does batching.


> 
> I'm done with this discussion. I'm totally fed up.
> 

Note, I wasn't writing this code anyway as I didn't have the time to. I
was helping others who took the initiative to do this work. But I guess
they didn't have time to move it forward either.

For the live kernel patching case, I'll start working on the permanent
changes, where once a function entry is changed, it can never be put
back. Then we wont have an issue with the live kernel patching case,
but only for tracing. But the worse thing there is you miss tracing
functions while an update is being made.

If Nicolai has time, perhaps he can try out the method you suggest and
see if we can move this forward.

-- Steve
