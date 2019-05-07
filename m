Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3967E157A0
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 May 2019 04:30:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726321AbfEGCan (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 6 May 2019 22:30:43 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:41416 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725994AbfEGCan (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 6 May 2019 22:30:43 -0400
Received: by mail-lf1-f65.google.com with SMTP id d8so10584260lfb.8
        for <linux-kselftest@vger.kernel.org>; Mon, 06 May 2019 19:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ypUKVfXP1AnEUI/86w3NTruGsAT5Q4/8InuZQk2I41A=;
        b=HvzylswzK0iwVTB7jh+W5xIzbRs3EObetMulP9nYo9fB268CEFD8tzX31ifgvQQu4d
         qJ1+RAsHFhkxjEIpjrJ171YbfAj3v5TrNNL3YUmY4vCZa7jFrJEg1nLxBd5suR5uxHiL
         KvsYrpA3B/kr3kdSn54TQW8kJ2dBWgNGaOGwc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ypUKVfXP1AnEUI/86w3NTruGsAT5Q4/8InuZQk2I41A=;
        b=e/lstQPMYOuva0Es8JrJdr/h1fv77Mx6zSx47UqwdrcFDsMtnSqDOJJ00q3OVuKiJp
         yRyk+2iJS1y0yotEM3AfZfBcPJ5byEwuzNqEOAoI6IQN76Nr+Jt2JrRaXjQ9ubRqkw6S
         UjEeo/FpYC7aHfZUPGJqfF9kBWkHRKDNn4UYkSvJ1gp83JaNPY/GPixUVVXYWJ0KVOt7
         exhVxAKKNqdlDQF+7zU3TfgR4PUHy6BDM09Y4XqvQWMoWhYxO6ME+cuhd4QmoKBjAk1y
         po8H8sbIQMNIDXPjRO/GROscQDIsvGvKO9gKT1qFFnaOxg//pfLDb9kjLIB64X2X92De
         L4zQ==
X-Gm-Message-State: APjAAAXW83Z6dOURtCsuESZ8D99I1m4grW+E0VbW/kZg0x8tSHMmioBq
        iyN4auZLRiawnKJJ/+9vLQNfv8k82XA=
X-Google-Smtp-Source: APXvYqzzFcU9aCam/pzXz7TvU9pNg5FhOi3Ytap/fZBuV2jpvtXdk+w0GCE5jP+hBE6FYx473Pyy/Q==
X-Received: by 2002:ac2:51a9:: with SMTP id f9mr6555222lfk.56.1557196241005;
        Mon, 06 May 2019 19:30:41 -0700 (PDT)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id f12sm2926501lfk.6.2019.05.06.19.30.40
        for <linux-kselftest@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 May 2019 19:30:40 -0700 (PDT)
Received: by mail-lf1-f48.google.com with SMTP id j20so10614008lfh.2
        for <linux-kselftest@vger.kernel.org>; Mon, 06 May 2019 19:30:40 -0700 (PDT)
X-Received: by 2002:a19:2952:: with SMTP id p79mr6096241lfp.166.1557195742856;
 Mon, 06 May 2019 19:22:22 -0700 (PDT)
MIME-Version: 1.0
References: <20190502181811.GY2623@hirez.programming.kicks-ass.net>
 <20190503092247.20cc1ff0@gandalf.local.home> <2045370D-38D8-406C-9E94-C1D483E232C9@amacapital.net>
 <CAHk-=wjrOLqBG1qe9C3T=fLN0m=78FgNOGOEL22gU=+Pw6Mu9Q@mail.gmail.com>
 <20190506081951.GJ2606@hirez.programming.kicks-ass.net> <20190506095631.6f71ad7c@gandalf.local.home>
 <CAHk-=wgw_Jmn1iJWanoSFb1QZn3mbTD_JEoMsWcWj5QPeyHZHA@mail.gmail.com>
 <20190506130643.62c35eeb@gandalf.local.home> <CAHk-=whesas+GDtHZks62wqXWXe4d_g3XJ359GX81qj=Fgs6qQ@mail.gmail.com>
 <20190506145745.17c59596@gandalf.local.home> <CAHk-=witfFBW2O5v6g--FmqnAFsMkKNLosTFfWyaoJ7euQF8kQ@mail.gmail.com>
 <20190506162915.380993f9@gandalf.local.home> <CAHk-=wi5KBWUOvM94aTOPnoJ5L_aQG=vgLQ4SxxZDeQD0pF2tQ@mail.gmail.com>
 <20190506174511.2f8b696b@gandalf.local.home> <CAHk-=wj3R_s0RTJOmTBNaUPhu4fz2shNBUr4M6Ej65UYSNCs-g@mail.gmail.com>
 <20190506210416.2489a659@oasis.local.home> <CAHk-=whZwqzbu-=1r_j_cXfd=ta1q7RFCuneqBZfQQhS_P-BmQ@mail.gmail.com>
 <20190506215353.14a8ef78@oasis.local.home>
In-Reply-To: <20190506215353.14a8ef78@oasis.local.home>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 6 May 2019 19:22:06 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjLXmOn=Cp=uOfO4gE01eN_-UcOUyrMTTw5-f_OfPO48Q@mail.gmail.com>
Message-ID: <CAHk-=wjLXmOn=Cp=uOfO4gE01eN_-UcOUyrMTTw5-f_OfPO48Q@mail.gmail.com>
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

On Mon, May 6, 2019 at 6:53 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> Also, I figured just calling ftrace_regs_caller() was simpler then
> having that int3 handler do the hash look ups to determine what handler
> it needs to call.

So what got me looking at this - and the races (that didn't turn out
to be races) - and why I really hate it, is because of the whole
notion of "atomic state".

Running an "int3" handler (when the int3 is in the kernel) is in some
sense "atomic". There is the state in the caller, of course, and
there's the state that the int3 handler has, but you can *mostly*
think of the two as independent.

In particular, if the int3 handler doesn't ever enable interrupts, and
if it doesn't need to do any stack switches, the int3 handler part
looks "obvious". It can be interrupted by NMI, but it can't be
interrupted (for example) by the cross-cpu IPI.

That was at least the mental model I was going for.

Similarly, the "caller" side mostly looks obvious too. If we don't
take an int3, none of this matter, and if we *do* take an int3, if we
can at least make it "atomic" wrt the rewriter (before or after
state), it should be easy to think about.

One of the things I was thinking of doing, for example, was to simply
make the call emulation do a "load four bytes from the instruction
stream, and just use that as the emulation target offset".

Why would that matter?

We do *not* have very strict guarantees for D$-vs-I$ coherency on x86,
but we *do* have very strict guarantees for D$-vs-D$ coherency. And so
we could use the D$ coherency to give us atomicity guarantees for
loading and storing the instruction offset for instruction emulation,
in ways we can *not* use the D$-to-I$ guarantees and just executing it
directly.

So while we still need those nasty IPI's to guarantee the D$-vs-I$
coherency in the "big picture" model and to get the serialization with
the actual 'int3' exception right, we *could* just do all the other
parts of the instruction emulation using the D$ coherency.

So we could do the actual "call offset" write with a single atomic
4-byte locked cycle (just use "xchg" to write - it's always locked).
And similarly we could do the call offset *read* with a single locked
cycle (cmpxchg with a 0 value, for example). It would be atomic even
if it crosses a cacheline boundary.

And now we'd be guaranteed that on a D$ side, we'd get either the old
value _or_ the new value for the emulation, and never a mix of them.
Which is very much unlike the I$ side guarantees that aren't
documented and people have been worrying about.

Notice? We'd not even have to look up any values.  We'd literally just
do something like

        int offset = locked_atomic_read(ip+1);
        return int3_emulate_call(ip, ip+5+offset);

and it would be *atomic* with respect to whatever other user that
updates the instruction, as long as they update the offset with a
"xchg" instruction.

Wouldn't that be lovely? We'd literally use the emulation as a way to
get the kinds of coherency guarantees that we don't get natively with
the I$.

Except that was _so_ not the case with the whole ftrace_regs_caller()
thing. That whole hack made me go "this doesn't emulate either the old
_or_ the new call". And see above why that would matter. Because a
"let's just make the four bytes after the 'int3' instruction be
atomic" would very much be all about "emulate either the old or the
new call".

So this was why I was then looking at what the heck that code was
doing, and it was making zero sense to me. Emulating something that is
different from what you're actually rewriting means that tricks like
the above don't work.

                  Linus
