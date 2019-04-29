Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC7DBEA55
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Apr 2019 20:43:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729198AbfD2Smz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 29 Apr 2019 14:42:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:46666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729195AbfD2Smy (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 29 Apr 2019 14:42:54 -0400
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1211F217D8
        for <linux-kselftest@vger.kernel.org>; Mon, 29 Apr 2019 18:42:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556563373;
        bh=uk+tO9aXRLS/rmrBAuW4lAJObJJz4OESG+TqjlzC2Ic=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=wFd2OGX9/cao7jixixF0P5itZF/mWjJAD8gRrcPwhqC9EGB1JB7wS5gHB9lXwC0cG
         4VHrFChhnx5j8cTRX+5t6Fb+ZNPUXPnF18kaX5n3mUM/Lt/fhQUay/docUaElA1Mri
         amriFjlKKrTpu/qOVKO1uhQvYcmzQgLnhpcQ1gQw=
Received: by mail-wm1-f50.google.com with SMTP id b10so542053wmj.4
        for <linux-kselftest@vger.kernel.org>; Mon, 29 Apr 2019 11:42:53 -0700 (PDT)
X-Gm-Message-State: APjAAAUUryD2+O8fFyha8oQt9abku1tI9lCiOSMoCjrxqISRDFERkIad
        aAk+iP0FnvKbPL7Hy3DZSMhN2KvpoHWeXyGuCsElww==
X-Google-Smtp-Source: APXvYqwa7Mpp6C2EUdhLCqDMVFTtT/NhXr5uTtYEh1qXBrjJ8VtZx6no/tDmKT6keaVd/V7D8J/Iak+NDM4lciJSSJM=
X-Received: by 2002:a1c:eb18:: with SMTP id j24mr363919wmh.32.1556563369708;
 Mon, 29 Apr 2019 11:42:49 -0700 (PDT)
MIME-Version: 1.0
References: <20190427100639.15074-1-nstange@suse.de> <20190427100639.15074-4-nstange@suse.de>
 <20190427102657.GF2623@hirez.programming.kicks-ass.net> <20190428133826.3e142cfd@oasis.local.home>
 <CAHk-=wh5OpheSU8Em_Q3Hg8qw_JtoijxOdPtHru6d+5K8TWM=A@mail.gmail.com> <CAHk-=wjphmrQXMfbw9j-tTzDvJ+Uc+asMHdFa=1_1xZoYVUC=g@mail.gmail.com>
In-Reply-To: <CAHk-=wjphmrQXMfbw9j-tTzDvJ+Uc+asMHdFa=1_1xZoYVUC=g@mail.gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Mon, 29 Apr 2019 11:42:38 -0700
X-Gmail-Original-Message-ID: <CALCETrXvmZPHsfRVnW0AtyddfN-2zaCmWn+FsrF6XPTOFd_Jmw@mail.gmail.com>
Message-ID: <CALCETrXvmZPHsfRVnW0AtyddfN-2zaCmWn+FsrF6XPTOFd_Jmw@mail.gmail.com>
Subject: Re: [PATCH 3/4] x86/ftrace: make ftrace_int3_handler() not to skip
 fops invocation
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Apr 29, 2019 at 11:29 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Mon, Apr 29, 2019 at 11:06 AM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> >
> > It does *not* emulate the "call" in the BP handler itself, instead if
> > replace the %ip (the same way all the other BP handlers replace the
> > %ip) with a code sequence that just does
> >
> >         push %gs:bp_call_return
> >         jmp *%gs:bp_call_target
> >
> > after having filled in those per-cpu things.
>
> Note that if you read the patch, you'll see that my explanation
> glossed over the "what if an interrupt happens" part. Which is handled
> by having two handlers, one for "interrupts were already disabled" and
> one for "interrupts were enabled, so I disabled them before entering
> the handler".

This is quite a cute solution.

>
> The second handler does the same push/jmp sequence, but has a "sti"
> before the jmp. Because of the one-instruction sti shadow, interrupts
> won't actually be enabled until after the jmp instruction has
> completed, and thus the "push/jmp" is atomic wrt regular interrupts.
>
> It's not safe wrt NMI, of course, but since NMI won't be rescheduling,
> and since any SMP IPI won't be punching through that sequence anyway,
> it's still atomic wrt _another_ text_poke() attempt coming in and
> re-using the bp_call_return/tyarget slots.

I'm less than 100% convinced about this argument.  Sure, an NMI right
there won't cause a problem.  But an NMI followed by an interrupt will
kill us if preemption is on.  I can think of three solutions:

1. Assume that all CPUs (and all relevant hypervisors!) either mask
NMIs in the STI shadow or return from NMIs with interrupts masked for
one instruction.  Ditto for MCE.  This seems too optimistic.

2. Put a fixup in the NMI handler and MCE handler: if the return
address is one of these magic jumps, clear IF and back up IP by one
byte.  This should *work*, but it's a bit ugly.

3. Use a different magic sequence:

push %gs:bp_call_return
int3

and have the int3 handler adjust regs->ip and regs->flags as appropriate.

I think I like #3 the best, even though it's twice as slow.

FWIW, kernel shadow stack patches will show up eventually, and none of
these approaches are compatible as is.  Perhaps the actual sequence
should be this, instead:

bp_int3_fixup_irqsoff:
  call 1f
1:
  int3

bp_int3_fixup_irqson:
  call 1f
1:
  int3

and the int3 handler will update the conventional return address *and*
the shadow return address.  Linus, what do you think about this
variant?

Finally, with my maintainer hat on: if anyone actually wants to merge
this thing, I want to see a test case, exercised regularly (every boot
in configured, perhaps) that actually *runs* this code.  Hitting it in
practice will be rare, and I want bugs to be caught.
