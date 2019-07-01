Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 61FF815611
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 May 2019 00:38:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726249AbfEFWix (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 6 May 2019 18:38:53 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:42789 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726218AbfEFWix (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 6 May 2019 18:38:53 -0400
Received: by mail-lf1-f68.google.com with SMTP id w23so10319364lfc.9
        for <linux-kselftest@vger.kernel.org>; Mon, 06 May 2019 15:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Dxftzvjm/ITflLxpaon8lNkVkwZKAv6W1SNUZkWADvU=;
        b=QpAj51Mi2Y8qwLgnhbcKf/qXqptSySRdePaWjhEzne8z6S13GHE8jO+Y+Tb25ZwGd3
         i5iKwHdDqjZwGz2dkYEWWbrQUc5rqB0zVWEJXtAV3RZHsD4AYRss4H5uvz/lIp09NGTU
         y1PP7SzMglvop+x+MQmaR/R6GmlqoGbadW9GY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Dxftzvjm/ITflLxpaon8lNkVkwZKAv6W1SNUZkWADvU=;
        b=QTKLY7MTtx9zjNFV/His+9+Umv3w6hNOH6yXcMaZmnM01OVyq8VwDdYsxAiTuCr/t7
         E7Nt0Eqpt7HnjGoH+r51oDE/b1H6Qp2t0jaQRzwEYG2HaonKpWkbcvWcVkUCvGdLtuwv
         4jTi/Pgpdx3fU4v+K+g8fr/d++1JTfizl9Ake5JetqwkdldvI0hWwusbYj6ZTdErl8mM
         nWIg9/B8pwwEvP0OjHeVTC6TWqAmnGoF9EKgjbPNVRHdyqdFi6lt3bLfkVpSKZOOQ086
         QdbayWPLs9zOopfreVY2+LO6qNIA+Mz1Q1gLWl4oPgz5OViTcZ9nwHDKM9GNdlE0XvQD
         CpAQ==
X-Gm-Message-State: APjAAAXP8GdWlJRp5J93s1qs92Q3T6VVGqGQUKb6yvP47esM1fvCFOIe
        Klry5QUomXZoOvqz6B45f3NucRiei1k=
X-Google-Smtp-Source: APXvYqyaI1EGvMBGRWXubUkc7/ZJ/VXt/nNXgK4YFyiGfFG5XkLlyR/XaOFp1WCKJfQAqEhiBSItbA==
X-Received: by 2002:ac2:4833:: with SMTP id 19mr14430851lft.87.1557182330434;
        Mon, 06 May 2019 15:38:50 -0700 (PDT)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id q15sm2771630lfh.59.2019.05.06.15.38.50
        for <linux-kselftest@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 May 2019 15:38:50 -0700 (PDT)
Received: by mail-lf1-f52.google.com with SMTP id w23so10319339lfc.9
        for <linux-kselftest@vger.kernel.org>; Mon, 06 May 2019 15:38:50 -0700 (PDT)
X-Received: by 2002:a19:ca02:: with SMTP id a2mr14261445lfg.88.1557181933876;
 Mon, 06 May 2019 15:32:13 -0700 (PDT)
MIME-Version: 1.0
References: <20190502181811.GY2623@hirez.programming.kicks-ass.net>
 <20190502185225.0cdfc8bc@gandalf.local.home> <20190502193129.664c5b2e@gandalf.local.home>
 <20190502195052.0af473cf@gandalf.local.home> <20190503092959.GB2623@hirez.programming.kicks-ass.net>
 <20190503092247.20cc1ff0@gandalf.local.home> <2045370D-38D8-406C-9E94-C1D483E232C9@amacapital.net>
 <CAHk-=wjrOLqBG1qe9C3T=fLN0m=78FgNOGOEL22gU=+Pw6Mu9Q@mail.gmail.com>
 <20190506081951.GJ2606@hirez.programming.kicks-ass.net> <20190506095631.6f71ad7c@gandalf.local.home>
 <CAHk-=wgw_Jmn1iJWanoSFb1QZn3mbTD_JEoMsWcWj5QPeyHZHA@mail.gmail.com>
 <20190506130643.62c35eeb@gandalf.local.home> <CAHk-=whesas+GDtHZks62wqXWXe4d_g3XJ359GX81qj=Fgs6qQ@mail.gmail.com>
 <20190506145745.17c59596@gandalf.local.home> <CAHk-=witfFBW2O5v6g--FmqnAFsMkKNLosTFfWyaoJ7euQF8kQ@mail.gmail.com>
 <20190506162915.380993f9@gandalf.local.home> <CAHk-=wi5KBWUOvM94aTOPnoJ5L_aQG=vgLQ4SxxZDeQD0pF2tQ@mail.gmail.com>
 <20190506174511.2f8b696b@gandalf.local.home> <CAHk-=wj3R_s0RTJOmTBNaUPhu4fz2shNBUr4M6Ej65UYSNCs-g@mail.gmail.com>
In-Reply-To: <CAHk-=wj3R_s0RTJOmTBNaUPhu4fz2shNBUr4M6Ej65UYSNCs-g@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 6 May 2019 15:31:57 -0700
X-Gmail-Original-Message-ID: <CAHk-=wje38dbYFGNw0y==zd7Zo_4s2WOQjWaBDyr24RCdK2EPQ@mail.gmail.com>
Message-ID: <CAHk-=wje38dbYFGNw0y==zd7Zo_4s2WOQjWaBDyr24RCdK2EPQ@mail.gmail.com>
Subject: Re: [RFC][PATCH 1/2] x86: Allow breakpoints to emulate call functions
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
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
        Joerg Roedel <jroedel@suse.de>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, stable <stable@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, May 6, 2019 at 3:06 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Why are you emulating something different than what you are rewriting?

Side note: I'm also finding another bug on the ftrace side, which is a
simple race condition.

In particular, the logic with 'modifying_ftrace_code' is fundamentally racy.

What can happen is that on one CPU we rewrite one instruction:

        ftrace_update_func = ip;
        /* Make sure the breakpoints see the ftrace_update_func update */
        smp_wmb();

        /* See comment above by declaration of modifying_ftrace_code */
        atomic_inc(&modifying_ftrace_code);

        ret = ftrace_modify_code(ip, old, new);

        atomic_dec(&modifying_ftrace_code);

   but then another CPU hits the 'int3' while the modification is
going on, and takes the fault.

The fault handler does that

        if (unlikely(atomic_read(&modifying_ftrace_code))..

and sees that "yes, it's in the middle of modifying the ftrace code",
and calls ftrace_int3_handler().  All good and "obviously correct" so
far, no?

HOWEVER. It's actually buggy. Because in the meantime, the CPU that
was rewriting instructions has finished, and decrements the
modifying_ftrace_code, which doesn't hurt us (because we already saw
that the int3 was due to the modification.

BUT! There are two different races here:

 (a) maybe the fault handling was slow, and we saw the 'int3' and took
the fault, but the modifying CPU had already finished, so that
atomic_read(&modifying_ftrace_code) didn't actually trigger at all.

 (b) maybe the int3-faulting CPU *did* see the proper value of
modifying_ftrace_code, but the modifying CPU went on and started
*another* modification, and has changed ftrace_update_func in the
meantime, so now the int3 handling is looking at the wrong values!

In the case of (a), we'll die with an oops due to the inexplicable
'int3' we hit. And in the case of (b) we'll be fixing up using the
wrong address.

Things like this is why I'm wondering how much of the problems are due
to the entry code, and how much of it is due to simply races and
timing differences?

Again, I don't actually know the ftrace code, and maybe I'm missing
something, but this really looks like _another_ fundamental bug.

The way to handle that modifying_ftrace_code thing is most likely by
using a sequence counter. For example, one way to actually do some
thing like this might be

        ftrace_update_func = ip;
        ftrace_update_target = func;
        smp_wmb();
        atomic_inc(&modifying_ftrace_head);

        ret = ftrace_modify_code(ip, old, new);

        atomic_inc(&modifying_ftrace_tail);
        smp_wmb();

and now the int3 code could do something like

        int head, tail;

        head = atomic_read(&modifying_ftrace_head);
        smp_rmb();
        tail = atomic_read(&modifying_ftrace_tail);

        /* Are we still in the process of modification? */
        if (unlikely(head != tail+1))
                return 0;

        ip = ftrace_update_func;
        func = ftrace_update_target;
        smp_rmb();
        /* Need to re-check that the above two values are consistent
and we didn't exit */
        if (atomic_read(&modifying_ftrace_tail) != tail)
                return 0;

        *pregs int3_emulate_call(regs, ip, func);
        return 1;

although it probably really would be better to use a seqcount instead
of writing it out like the above.

NOTE! The above only fixes the (b) race. The (a) race is probably best
handled by actually checking if the 'int3' instruction is still there
before dying.

Again, maybe there's something I'm missing, but having looked at that
patch now what feels like a million times, I'm finding more worrisome
things in the ftrace code than in the kernel entry code..

                 Linus
