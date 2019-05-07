Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0CB22166F7
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 May 2019 17:38:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726438AbfEGPiM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 7 May 2019 11:38:12 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:40339 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726487AbfEGPiM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 7 May 2019 11:38:12 -0400
Received: by mail-lf1-f66.google.com with SMTP id o16so12199197lfl.7
        for <linux-kselftest@vger.kernel.org>; Tue, 07 May 2019 08:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y6ybn9R2wRwK7OVl8uatl/i1llM+QJoRgaCyqAFbo9Y=;
        b=BNzVqUAAViERdEuxZy8DHUiuYxo8ddmm9cVx4BOchUH3WtVYroxRTUSipMK+LTDMnx
         G6Nz0qaFq78h9Jxdf15yovQ7B7GKRx+9GVUL2kenVn+ddQfRmu4UzyEd25IlQcp/jSGE
         dAIUJDF1c1Wz5T5Q+QRd4jWS9Etfzd3108pkw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y6ybn9R2wRwK7OVl8uatl/i1llM+QJoRgaCyqAFbo9Y=;
        b=jwXrHXToYkEA3zNwqGXgm5tq8ja+m/4sTEQsjQ7uI/cenD1icFkXd/36UlligSF9Kp
         vBiO3aw51AG7DsRNZsx92KF3Iy+kyPcGqmVvdAPUm8+GocY8K45SVXRWptxIk1tHkoQq
         7XrtJRtycRizr/EZqw0DMofeMwEXAU/jpcKMILYm7dzOdSLqAsyAC5D+S385AK3K1LTZ
         PkeHj0ZmCEXUzVwGGVLg9pt2q0NskNIptQ5JgUFplu46xdPbYHyyCrJZppG25k8dwuDp
         MJ4X0hLSUFzwnx5WWng0TcgW6KrWQcRTvtnN0yKGMoXYMsyYUdHb/rSXaSZC5OwBIM5w
         OeVA==
X-Gm-Message-State: APjAAAXDgrDRNgZ6gQsja8f9yBhhQBNKyeEAJrqeFUzehAulypEzMtmF
        8MlN/LPLXpUgmzbD5r9X8PLtssqzYlE=
X-Google-Smtp-Source: APXvYqwBrsoNfzvPQYDlmAoHAFxsWUPPqhqv+u2KtO/dOECxq3uRd8Y0FSHRr9vyj+gABBYUP8cjmA==
X-Received: by 2002:ac2:554a:: with SMTP id l10mr15467921lfk.45.1557243489584;
        Tue, 07 May 2019 08:38:09 -0700 (PDT)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id e16sm3374263lfn.91.2019.05.07.08.38.09
        for <linux-kselftest@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 May 2019 08:38:09 -0700 (PDT)
Received: by mail-lj1-f173.google.com with SMTP id z5so9654110lji.10
        for <linux-kselftest@vger.kernel.org>; Tue, 07 May 2019 08:38:09 -0700 (PDT)
X-Received: by 2002:a2e:3e0e:: with SMTP id l14mr17667665lja.125.1557243091071;
 Tue, 07 May 2019 08:31:31 -0700 (PDT)
MIME-Version: 1.0
References: <20190502181811.GY2623@hirez.programming.kicks-ass.net>
 <20190506145745.17c59596@gandalf.local.home> <CAHk-=witfFBW2O5v6g--FmqnAFsMkKNLosTFfWyaoJ7euQF8kQ@mail.gmail.com>
 <20190506162915.380993f9@gandalf.local.home> <CAHk-=wi5KBWUOvM94aTOPnoJ5L_aQG=vgLQ4SxxZDeQD0pF2tQ@mail.gmail.com>
 <20190506174511.2f8b696b@gandalf.local.home> <CAHk-=wj3R_s0RTJOmTBNaUPhu4fz2shNBUr4M6Ej65UYSNCs-g@mail.gmail.com>
 <20190506210416.2489a659@oasis.local.home> <CAHk-=whZwqzbu-=1r_j_cXfd=ta1q7RFCuneqBZfQQhS_P-BmQ@mail.gmail.com>
 <20190506215353.14a8ef78@oasis.local.home> <CAHk-=wjLXmOn=Cp=uOfO4gE01eN_-UcOUyrMTTw5-f_OfPO48Q@mail.gmail.com>
 <20190506225819.11756974@oasis.local.home> <CAHk-=wh4FCNBLe8OyDZt2Tr+k9JhhTsg3H8R4b55peKcf0b6eQ@mail.gmail.com>
 <20190506232158.13c9123b@oasis.local.home> <CAHk-=wi4vPg4pu6RvxQrUuBL4Vgwd2G2iaEJVVumny+cBOWMZw@mail.gmail.com>
 <CAHk-=wg2_okyU8mpkGCUrudgfg8YmNetSD8=scNbOkN+imqZdQ@mail.gmail.com> <20190507111227.1d4268d7@gandalf.local.home>
In-Reply-To: <20190507111227.1d4268d7@gandalf.local.home>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 7 May 2019 08:31:14 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjYdj+vvV8uUA8eaUSxOhu=xuQxdo-dtM927j0-3hSkEw@mail.gmail.com>
Message-ID: <CAHk-=wjYdj+vvV8uUA8eaUSxOhu=xuQxdo-dtM927j0-3hSkEw@mail.gmail.com>
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

On Tue, May 7, 2019 at 8:12 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>>
> Yes, band-aids are usually simpler than a proper fix.

What? No/.

My fix is the *proper* fix.

PeterZ's is the bandaid.

>             We have 28 years
> of hacks built on hacks. There's a lot of hacks in the C code to handle
> the differences between the crappy way x86_32 does pt_regs and the
> proper way x86_64 does them.

You're confusing "reality": with "your dream world". They are different.

The reality is that the i386 kernel stack is just how things work. End of story.

The reality is that changing something fundamental like the kernel
stack at this point for an architecture that will not change in the
future is silly.

The reality is that Peter's patch is much bigger than mine, because it
needed a lot of other changes *because* it did that change.

> To implement your way, we need to change how the int3 handler works.
> It will be the only exception handler having to return regs, otherwise
> it will crash.

What? That's what the patch *does*. It's trivial.  It is done.

                  Linus
