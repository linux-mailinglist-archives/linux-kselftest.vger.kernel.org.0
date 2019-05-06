Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 250BC15127
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 May 2019 18:23:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726321AbfEFQX1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 6 May 2019 12:23:27 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:34013 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726218AbfEFQX1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 6 May 2019 12:23:27 -0400
Received: by mail-lf1-f67.google.com with SMTP id v18so7399692lfi.1
        for <linux-kselftest@vger.kernel.org>; Mon, 06 May 2019 09:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gdKWMzG0jTPJKQefPY2Ldaf6Ms3KDojiEWREzp6GY/0=;
        b=acUkx/SyXE0iTsaLBqBApazjPIDAcpKLa6eanB/pwg3/nd2wX7zX61gfnOb7YkZ3Ll
         QSKrbp97fW9PaMvvakbU30HZC6d9E8ZxMJWyn8rtqBZLvZSLIjhpYOKX3sVWKA+T51pr
         jCo9GXVhBGPddoOghrCGtgtxD8b+3ePfN7F28=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gdKWMzG0jTPJKQefPY2Ldaf6Ms3KDojiEWREzp6GY/0=;
        b=Q+fCbpfHkG3oswbOObJmWoLUGLZ64+WrI/nzkzgP+8Ocota+abUL3/SVD+kxY5vAjJ
         xkHoGs+n2aDTustGQt7Z1SxSLSWgf27AGZENwOVedZp4EyWraqgFm1UBch8Gv42r2EFn
         6juHvEA3Id2L5l+OB6UEqxv1etPgMZDPtGkNXIw/fgupSbC78LnTcqsfYHdfpekmVWdP
         yrPkPBFiDcX8l0IwKg6knF/eUfZkRBZUnWPxW0Z19Q8Q6vICIDbIkxD35MhL6L6OnaL+
         hQwLy2tEgtMbzk/sCP6gd6/tLUfKFe2cnb4mn3pSYIysbqQopf6sQX1endadxxX34DJu
         O7mg==
X-Gm-Message-State: APjAAAUodMjAI1ypK5GYvwcdyjPxzTRwRQs33eQgbeKRvMlFKVMhAMIh
        siK5z5jnAVVeAUy8iQ8jlyK/BTy1rtQ=
X-Google-Smtp-Source: APXvYqwn3Elv99lMbPZc5EOaMKqyor1+QUNChcT3xrSnVEB0rfZ7w9t6o1aF+x2yPI+J5BEOxPeZpA==
X-Received: by 2002:a19:97c8:: with SMTP id z191mr13124889lfd.167.1557159804922;
        Mon, 06 May 2019 09:23:24 -0700 (PDT)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id d22sm2533802lfc.80.2019.05.06.09.23.24
        for <linux-kselftest@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 May 2019 09:23:24 -0700 (PDT)
Received: by mail-lf1-f54.google.com with SMTP id n22so2067660lfe.12
        for <linux-kselftest@vger.kernel.org>; Mon, 06 May 2019 09:23:24 -0700 (PDT)
X-Received: by 2002:a19:ec07:: with SMTP id b7mr7420419lfa.62.1557159455483;
 Mon, 06 May 2019 09:17:35 -0700 (PDT)
MIME-Version: 1.0
References: <20190502181811.GY2623@hirez.programming.kicks-ass.net>
 <CAHk-=wi6A9tgw=kkPh5Ywqt687VvsVEjYXVkAnq0jpt0u0tk6g@mail.gmail.com>
 <20190502202146.GZ2623@hirez.programming.kicks-ass.net> <20190502185225.0cdfc8bc@gandalf.local.home>
 <20190502193129.664c5b2e@gandalf.local.home> <20190502195052.0af473cf@gandalf.local.home>
 <20190503092959.GB2623@hirez.programming.kicks-ass.net> <20190503092247.20cc1ff0@gandalf.local.home>
 <2045370D-38D8-406C-9E94-C1D483E232C9@amacapital.net> <CAHk-=wjrOLqBG1qe9C3T=fLN0m=78FgNOGOEL22gU=+Pw6Mu9Q@mail.gmail.com>
 <20190506081951.GJ2606@hirez.programming.kicks-ass.net> <20190506095631.6f71ad7c@gandalf.local.home>
In-Reply-To: <20190506095631.6f71ad7c@gandalf.local.home>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 6 May 2019 09:17:19 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgw_Jmn1iJWanoSFb1QZn3mbTD_JEoMsWcWj5QPeyHZHA@mail.gmail.com>
Message-ID: <CAHk-=wgw_Jmn1iJWanoSFb1QZn3mbTD_JEoMsWcWj5QPeyHZHA@mail.gmail.com>
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

On Mon, May 6, 2019 at 6:56 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> I can test this too. I was hoping to get this in by this merge window.
> I spent 3 hours yesterday trying to get Linus's version working on
> i386 with no success. Not sure how much time Linus will have to look at
> this, as he just opened the merge window.

I acvtually just tested it in qemu, and it worked fine.

Ok, so my test was admittedly really simple and stupid, in that al I did was

        printk("Before int3\n");
        asm("int3; nop; nop; nop; nop" : : :"ax","dx","cx");
        printk("After int3\n");

and then I hacked up do_kernel_int3() to just unconditionally do

        return int3_emulate_call(regs, (unsigned long)test_int3);

with a stupid test-function:

    void test_int3(void)
    {
        printk("In int3 handler");
    }

instead fo anything fancy.

But it did exactly the expected thing, and resulted in

    Before int3
    In int3 handler
    After int3

on the screen.

So what is it that doesn't actually work? I've looked at the patch
even more, and I can't for the life of me see how it wouldn't work.

Of course, I didn't test any of the actual ftrace parts, since I
short-circuited them intentionally with the above test function hack.
I have no idea what the semantics for those
ftrace_location(ip)/is_ftrace_caller(ip) cases are supposed to be, I
only tested that yes, the infrastructure clearly emulates a call
instruction.

               Linus
