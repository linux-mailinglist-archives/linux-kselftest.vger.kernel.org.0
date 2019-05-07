Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 41F8A15758
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 May 2019 03:35:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbfEGBfX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 6 May 2019 21:35:23 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:45865 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726546AbfEGBfW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 6 May 2019 21:35:22 -0400
Received: by mail-lf1-f68.google.com with SMTP id n22so2998689lfe.12
        for <linux-kselftest@vger.kernel.org>; Mon, 06 May 2019 18:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6H70OYCWqWNzJ1zGHNlYsHEsCgxXv8c0o/4c1a8H4TM=;
        b=dpFgNSCaKcwRzOTxc2CRA45EB/B/5baFN6H/ywJJjn2iC4DVw0z3j37EPur3kF2BcM
         gR5dH5TJcCt0L08AcgiCY39z5fIt5og+cl6z+Q6Orik7/B2A+FvQSQtx6uaVPo9r5nWT
         BpDf9SS2XWqZ2zgNFN0ahQyv31mOBnC8Onm0o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6H70OYCWqWNzJ1zGHNlYsHEsCgxXv8c0o/4c1a8H4TM=;
        b=Fy7x/6m3rlSIpPLJSVhVPOrSeobRpOJrUlu2q+uG0xnFK1NNd2m4/7cmtpjPI2gz46
         pl+BFF0Ct3xihsut2ZxOtEKsQoHNLM8SbVW1oEEOCYAh9rnIbXIHuOj7f72xKpaZQUlc
         bD1rEszn7Pgf5Zww51PKChHkQmrtr+IfwaEUxdeVJdJ0DswvVm1izsJo3TarH47IcMsC
         dMwOtD8gCV5VFvJTsPZ4adTpHt2+kvtaJDNwqSev93D4XrtHfLk2vvil9hH4kxncI+jZ
         NDIlT9MsjHQyTdhoJ3Iam4Je/Zalox2GysxsEUNp0UFjeAJxzvN/b6YSbP5AKtk623xG
         wyJA==
X-Gm-Message-State: APjAAAXntIjQ9ajSGz4v4gEeM9eYrbAYJeYkT7Kjlt4M+1rF0oPP61bN
        pbjFmh1OsXnFUgwQK0SDVGXMrKkymx0=
X-Google-Smtp-Source: APXvYqzBv6DTgDbtgAdli9wXx463pO7xBdBCIh4kguH0JG0Jow7OXeqpmWw8RKwUUCmjGqKMCjdj6Q==
X-Received: by 2002:a19:5218:: with SMTP id m24mr13411466lfb.113.1557192920673;
        Mon, 06 May 2019 18:35:20 -0700 (PDT)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id c19sm2751727lfi.69.2019.05.06.18.35.17
        for <linux-kselftest@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 May 2019 18:35:20 -0700 (PDT)
Received: by mail-lf1-f49.google.com with SMTP id u27so10266840lfg.10
        for <linux-kselftest@vger.kernel.org>; Mon, 06 May 2019 18:35:17 -0700 (PDT)
X-Received: by 2002:a19:2952:: with SMTP id p79mr5995097lfp.166.1557192915891;
 Mon, 06 May 2019 18:35:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190502181811.GY2623@hirez.programming.kicks-ass.net>
 <20190502195052.0af473cf@gandalf.local.home> <20190503092959.GB2623@hirez.programming.kicks-ass.net>
 <20190503092247.20cc1ff0@gandalf.local.home> <2045370D-38D8-406C-9E94-C1D483E232C9@amacapital.net>
 <CAHk-=wjrOLqBG1qe9C3T=fLN0m=78FgNOGOEL22gU=+Pw6Mu9Q@mail.gmail.com>
 <20190506081951.GJ2606@hirez.programming.kicks-ass.net> <20190506095631.6f71ad7c@gandalf.local.home>
 <CAHk-=wgw_Jmn1iJWanoSFb1QZn3mbTD_JEoMsWcWj5QPeyHZHA@mail.gmail.com>
 <20190506130643.62c35eeb@gandalf.local.home> <CAHk-=whesas+GDtHZks62wqXWXe4d_g3XJ359GX81qj=Fgs6qQ@mail.gmail.com>
 <20190506145745.17c59596@gandalf.local.home> <CAHk-=witfFBW2O5v6g--FmqnAFsMkKNLosTFfWyaoJ7euQF8kQ@mail.gmail.com>
 <20190506162915.380993f9@gandalf.local.home> <CAHk-=wi5KBWUOvM94aTOPnoJ5L_aQG=vgLQ4SxxZDeQD0pF2tQ@mail.gmail.com>
 <20190506174511.2f8b696b@gandalf.local.home> <CAHk-=wj3R_s0RTJOmTBNaUPhu4fz2shNBUr4M6Ej65UYSNCs-g@mail.gmail.com>
 <20190506210416.2489a659@oasis.local.home>
In-Reply-To: <20190506210416.2489a659@oasis.local.home>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 6 May 2019 18:34:59 -0700
X-Gmail-Original-Message-ID: <CAHk-=whZwqzbu-=1r_j_cXfd=ta1q7RFCuneqBZfQQhS_P-BmQ@mail.gmail.com>
Message-ID: <CAHk-=whZwqzbu-=1r_j_cXfd=ta1q7RFCuneqBZfQQhS_P-BmQ@mail.gmail.com>
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

On Mon, May 6, 2019 at 6:04 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> That iterator does something special for each individual record. All
> 40,000 of them.

.. yes, but the 'int3' only happens for *one* of them at a time.

Why would it bother with the other 39,999 calls?

You could easily just look up the record at the int3 time, and just
use the record. Exactly the same way you use the one-at-a-time ones.

Instead, you emulate a fake call to a function that *wouldn't* get
called, which now does the lookup there. That's the part I don't get.
Why are you emulating something else than what you'd be rewriting?

             Linus
