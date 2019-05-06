Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF15B154AE
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 May 2019 21:53:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726277AbfEFTxt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 6 May 2019 15:53:49 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:37346 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726201AbfEFTxs (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 6 May 2019 15:53:48 -0400
Received: by mail-lf1-f68.google.com with SMTP id h126so10047010lfh.4
        for <linux-kselftest@vger.kernel.org>; Mon, 06 May 2019 12:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v4kkKa3SRWQVadtU9idY39CCQftkxcpIoOM0XAJqBTM=;
        b=cdF+EPKS6Ge2/s30X7OzfVs/i8EBdXNa487B1p2vGBTd+n7CgEMvurpKHpXcLVem3u
         rzevt8MxZIrbBVHT/2blPyzn4vnzFxGcHXwbP4Rlh59f3LBxbz5pPdNbdmV6lS7efsQa
         93j00k6IAskp5TeuRRIvJP0yqXdlZxHNFN5Nw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v4kkKa3SRWQVadtU9idY39CCQftkxcpIoOM0XAJqBTM=;
        b=SsRb5Ul83MenVB0pelet2fWm26/nTXjA+h3ZW+9O+iNawYLHC1vdaYYNxOSHRiIrj5
         +EZqC/Lt6vegEin8dqa3IyTuDxnl4ntV3BmMR3ScOIcVRQBOPGn6lUNOtS5himUuWvM+
         UTMZALGskpcthiIakklOaeIIjOXmnHgAO8qDHHObNRpbVNX6KlK1Dn/Ukti24t8Ck1BC
         5LyHaCtwB0Kvv1wrq3WzgTvQ3RorQVY5hF5dvHmcsktB/cLHyKViG82Ui0WszAN7pDz2
         tFO25VbeH5m63YMU6lTLcOw4M3yK67/9WtLuX2GCr+mmjR16m2clSbQ1XqAMpLpIb9v/
         eZIw==
X-Gm-Message-State: APjAAAXY5eTobWSkKBktfzZfWDnm7cN7WPI6u2FLob08HiPKDRLisUJO
        b74YLLmPR/F6LI5QJgZm1Nq68Rfd8Xw=
X-Google-Smtp-Source: APXvYqwZot8mTA8xgw8+LTR8gpSWo+QVe1gvAXEiG9LazDmh27cuOw/Lf03ErnRPyty+HrTj7cGOrQ==
X-Received: by 2002:ac2:5a47:: with SMTP id r7mr15028126lfn.116.1557172426451;
        Mon, 06 May 2019 12:53:46 -0700 (PDT)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id g10sm2613862lfb.85.2019.05.06.12.53.45
        for <linux-kselftest@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 May 2019 12:53:46 -0700 (PDT)
Received: by mail-lf1-f45.google.com with SMTP id j20so10066723lfh.2
        for <linux-kselftest@vger.kernel.org>; Mon, 06 May 2019 12:53:45 -0700 (PDT)
X-Received: by 2002:ac2:43cf:: with SMTP id u15mr13815824lfl.67.1557171988295;
 Mon, 06 May 2019 12:46:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190502181811.GY2623@hirez.programming.kicks-ass.net>
 <CAHk-=wi6A9tgw=kkPh5Ywqt687VvsVEjYXVkAnq0jpt0u0tk6g@mail.gmail.com>
 <20190502202146.GZ2623@hirez.programming.kicks-ass.net> <20190502185225.0cdfc8bc@gandalf.local.home>
 <20190502193129.664c5b2e@gandalf.local.home> <20190502195052.0af473cf@gandalf.local.home>
 <20190503092959.GB2623@hirez.programming.kicks-ass.net> <20190503092247.20cc1ff0@gandalf.local.home>
 <2045370D-38D8-406C-9E94-C1D483E232C9@amacapital.net> <CAHk-=wjrOLqBG1qe9C3T=fLN0m=78FgNOGOEL22gU=+Pw6Mu9Q@mail.gmail.com>
 <20190506081951.GJ2606@hirez.programming.kicks-ass.net> <20190506095631.6f71ad7c@gandalf.local.home>
 <CAHk-=wgw_Jmn1iJWanoSFb1QZn3mbTD_JEoMsWcWj5QPeyHZHA@mail.gmail.com>
 <20190506130643.62c35eeb@gandalf.local.home> <CAHk-=whesas+GDtHZks62wqXWXe4d_g3XJ359GX81qj=Fgs6qQ@mail.gmail.com>
 <20190506145745.17c59596@gandalf.local.home>
In-Reply-To: <20190506145745.17c59596@gandalf.local.home>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 6 May 2019 12:46:11 -0700
X-Gmail-Original-Message-ID: <CAHk-=witfFBW2O5v6g--FmqnAFsMkKNLosTFfWyaoJ7euQF8kQ@mail.gmail.com>
Message-ID: <CAHk-=witfFBW2O5v6g--FmqnAFsMkKNLosTFfWyaoJ7euQF8kQ@mail.gmail.com>
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
        <linux-kselftest@vger.kernel.org>, stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, May 6, 2019 at 11:57 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> You should have waited another week to open that merge window ;-)

Hmm. I'm looking at it while the test builds happen, and since I don't
see what's wrong in the low-level entry code, I'm looking at the
ftrace code instead.

What's going on here?

               *pregs = int3_emulate_call(regs, (unsigned
long)ftrace_regs_caller);

that line makes no sense. Why would we emulate a call to
ftrace_regs_caller()? That function sets up a pt_regs, and then calls
ftrace_stub().

But we *have* pt_regs here already with the right values. Why isn't
this just a direct call to ftrace_stub() from within the int3 handler?

And the thing is, calling ftrace_regs_caller() looks wrong, because
that's not what happens for *real* mcount handling, which uses that
"create_trampoline()" to create the thing we're supposed to really
use?

Anyway, I simply don't understand the code, so I'm confused. But why
is the int3 emulation creating a call that doesn't seem to match what
the instruction that we're actually rewriting is supposed to do?

IOW, it looks to me like ftrace_int3_handler() is actually emulating
something different than what ftrace_modify_code() is actually
modifying the code to do!

Since the only caller of ftrace_modify_code() is update_ftrace_func(),
why is that function not just saving the target and we'd emulate the
call to that? Using anything else looks crazy?

But as mentioned, I just don't understand the ftrace logic. It looks
insane to me, and much more likely to be buggy than the very simple
entry code.

             Linus
