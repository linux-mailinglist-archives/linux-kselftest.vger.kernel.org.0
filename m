Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 81C93155F5
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 May 2019 00:14:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726118AbfEFWOu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 6 May 2019 18:14:50 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:35835 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725994AbfEFWOu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 6 May 2019 18:14:50 -0400
Received: by mail-lf1-f68.google.com with SMTP id j20so10304195lfh.2
        for <linux-kselftest@vger.kernel.org>; Mon, 06 May 2019 15:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KnC6sHzJKQT/H/efllpurOKq1DqCgmhhrIn+ALVg0f8=;
        b=UuWTDsQLlvb0PtcfEid4ABezWzyagSu44050e/2j488U+99fI3xCIqtuQS8vXMHPrQ
         xvVSucwGErlEAEYFFWNYIWMj4gj1EPGneYgBBhuklMQ9H4OeRQjj1yrsseBu+AGIqRuC
         1DBfQJo9MbI0m5IyIe848iiX0VPuZXVlACZoY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KnC6sHzJKQT/H/efllpurOKq1DqCgmhhrIn+ALVg0f8=;
        b=k/f0JKtRT5eG9nUiGSwBBteIoKT5we38TUxjEITS/OH2chh7furapTY4+jYYdGaHh0
         1QN41aUi6j7c2bD7h5jcg0obIm5a/19sTuZNuMiS6i/7OhwA1Z1qNkGUS/9OSI1L+Qrn
         gJVTPZIeqcFPxCPCvzmUgZpWiHjpa8aAyuZuBaEnFe4fdaTfvzh5c2xwS3/YjT7mhdQq
         gk7lES7cvGmtR/nU6m8mNxb9AOX7p83JzjaxroP/nYljeN9OP73p+TGz9tLonfrsvmsf
         hLZbfcf+B/XKUudmXCh1G+6mjE/Pj2+B0NeCvjkM/gYkRtA1c1uX0SNOgwwincinKd6A
         1K5Q==
X-Gm-Message-State: APjAAAWitaGQNvogWEVUmnntZ4bEYkRGb536URDR7AKvLha2J1xgVIk1
        PbvmF7zCKhNTY8FWIekitgP35AF7PQU=
X-Google-Smtp-Source: APXvYqy1UmXDJgNw7EAOdLMqqhQdCQe4tD1IAFg4h1oq9RMcvXTIipZxZlOTVjMyP8huIHGGxmfR4Q==
X-Received: by 2002:ac2:428f:: with SMTP id m15mr14192655lfh.40.1557180887486;
        Mon, 06 May 2019 15:14:47 -0700 (PDT)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id z7sm2809982lfg.40.2019.05.06.15.14.47
        for <linux-kselftest@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 May 2019 15:14:47 -0700 (PDT)
Received: by mail-lf1-f42.google.com with SMTP id o16so10280688lfl.7
        for <linux-kselftest@vger.kernel.org>; Mon, 06 May 2019 15:14:47 -0700 (PDT)
X-Received: by 2002:a19:4f54:: with SMTP id a20mr14066761lfk.136.1557180433906;
 Mon, 06 May 2019 15:07:13 -0700 (PDT)
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
 <20190506174511.2f8b696b@gandalf.local.home>
In-Reply-To: <20190506174511.2f8b696b@gandalf.local.home>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 6 May 2019 15:06:57 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj3R_s0RTJOmTBNaUPhu4fz2shNBUr4M6Ej65UYSNCs-g@mail.gmail.com>
Message-ID: <CAHk-=wj3R_s0RTJOmTBNaUPhu4fz2shNBUr4M6Ej65UYSNCs-g@mail.gmail.com>
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

On Mon, May 6, 2019 at 2:45 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> To do that we would need to rewrite the logic to update each of those
> 40,000 calls one at a time, or group them together to what gets
> changed.

Stephen, YOU ARE NOT LISTENING.

You are already fixing the value of the call in the instruction as
part of the instruction rewriting.

When you do things like this:

        unsigned long ip = (unsigned long)(&ftrace_call);
        unsigned char *new;
        int ret;

        new = ftrace_call_replace(ip, (unsigned long)func);
        ret = update_ftrace_func(ip, new);

you have already decided to rewrite the instruction with one single
fixed call target: "func".

I'm just saying that you should ALWAYS use the same call target in the
int3 emulation.

Instead, you hardcode something else than what you are AT THE SAME
TIME rewriting the instruction with.

See what I'm saying?

You already save off the "ip" of the instruction you modify in
update_ftrace_func(). I'm just saying that you should *also* save off
the actual target of the call, and use *THAT*.

So that the int3 emulation and the instruction rewriting *match*.

What you do now makes no sense. You're modifing the code with one
thing (the "func" argument in update_ftrace_func), so if your
modification completed, that's what you'll actually *run*. But you're
then _emulating_ doing somethiing completely different, not using
"func" at all there.

So let me say one more time: how can it *possibly* make sense to
emulate something else than you are changing the instruction to read?

Are you finally understanding what craziness I'm talking about?

Stop with the "there could be thousands of targets" arguyment. The
"call" instruction THAT YOU ARE REWRITING has exactly one target.
There aren't 40,000 of them. x86 does not have that kind of "call"
instruction that randomly calls 40k different functions. You are
replacing FIVE BYTES of memory, and the emulation you do should
emulate those FIVE BYTES.

See?

Why are you emulating something different than what you are rewriting?

                    Linus
