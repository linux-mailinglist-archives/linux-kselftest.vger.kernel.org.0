Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3BCB3133D4
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 May 2019 21:04:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbfECTEA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 3 May 2019 15:04:00 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:33221 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726755AbfECTEA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 3 May 2019 15:04:00 -0400
Received: by mail-lf1-f66.google.com with SMTP id j11so5151653lfm.0
        for <linux-kselftest@vger.kernel.org>; Fri, 03 May 2019 12:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=FSgswcQFEYeHSdxX8AtrFGdX43ZrY81aC7FjCdnF1lw=;
        b=hNiCDOYPcNqnXKK/3FcnwPtAVxPFyrBg+J8d2W/RIoQtc6yDsjbQlTRVrCZF7yVBbf
         GTfzaeel2+A/oHQFAzZEgiHULvVGHr0RUbX7HmdD+IU7HwQy2urlZR/fO3433IvfJrgP
         +aivOpr26ud9zTNlsEaBbSi32zQ6a4Z2OLgV4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=FSgswcQFEYeHSdxX8AtrFGdX43ZrY81aC7FjCdnF1lw=;
        b=Bpviq5LTQoVg2MNkU+knTdswrIfZkZANPv2Lv0Tyjk44WFFIBekCtcTzpbMNgHSHP0
         HBm2QFuGp/1SSSob6FLzGCsYBlBA6Ps1cBOVyS/6tOHFkAsKcA5vUJo7s2XqrrGwOi3B
         3za0mlG/ThCMyUyA+qtAshly0IBKtUYcxFDqA7eyIidJiAiFuJH5eCZjJ6Z7uvv+wtyK
         ohQQGdAyEEJaKNriINhqpZP5Buh4ygRs9W8CFdq+VCCHLng6qVBmMtL0WXLANfU3TW18
         DVatbrZriHytnHFUP8nEfZ+zlqhkzurZRXcB7a6eijzJ5ZZuyNGe7HbnaEurd8scjQbd
         V/OQ==
X-Gm-Message-State: APjAAAWGYnsojzTj1RD8WJPkBnY/+1V64AeLUF5VMHne1FYr2wzBYeRE
        QrTM719JgJcZVY8ZxW2Aq/OdXiKaAi4=
X-Google-Smtp-Source: APXvYqyTHMv9FaaP7tPcvn9eIUBZil4ID3NTa0AoyCDMTxQ1cYeLu3Y5TXrpzV9C12++OfEAylNHPA==
X-Received: by 2002:a19:97c8:: with SMTP id z191mr5782467lfd.167.1556910238406;
        Fri, 03 May 2019 12:03:58 -0700 (PDT)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id p6sm539070ljj.97.2019.05.03.12.03.57
        for <linux-kselftest@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 May 2019 12:03:58 -0700 (PDT)
Received: by mail-lf1-f53.google.com with SMTP id j11so5151617lfm.0
        for <linux-kselftest@vger.kernel.org>; Fri, 03 May 2019 12:03:57 -0700 (PDT)
X-Received: by 2002:a19:ca02:: with SMTP id a2mr5916283lfg.88.1556909858698;
 Fri, 03 May 2019 11:57:38 -0700 (PDT)
MIME-Version: 1.0
References: <20190501203152.397154664@goodmis.org> <20190501232412.1196ef18@oasis.local.home>
 <20190502162133.GX2623@hirez.programming.kicks-ass.net> <CAHk-=wijZ-MD4g3zMJ9W2r=h8LUWneiu29OWuxZEoSfAF=0bhQ@mail.gmail.com>
 <20190502181811.GY2623@hirez.programming.kicks-ass.net> <CAHk-=wi6A9tgw=kkPh5Ywqt687VvsVEjYXVkAnq0jpt0u0tk6g@mail.gmail.com>
 <20190502202146.GZ2623@hirez.programming.kicks-ass.net> <20190502185225.0cdfc8bc@gandalf.local.home>
 <20190502193129.664c5b2e@gandalf.local.home> <20190502195052.0af473cf@gandalf.local.home>
 <20190503092959.GB2623@hirez.programming.kicks-ass.net> <20190503092247.20cc1ff0@gandalf.local.home>
 <2045370D-38D8-406C-9E94-C1D483E232C9@amacapital.net>
In-Reply-To: <2045370D-38D8-406C-9E94-C1D483E232C9@amacapital.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 3 May 2019 11:57:22 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjrOLqBG1qe9C3T=fLN0m=78FgNOGOEL22gU=+Pw6Mu9Q@mail.gmail.com>
Message-ID: <CAHk-=wjrOLqBG1qe9C3T=fLN0m=78FgNOGOEL22gU=+Pw6Mu9Q@mail.gmail.com>
Subject: Re: [RFC][PATCH 1/2] x86: Allow breakpoints to emulate call functions
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
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
Content-Transfer-Encoding: quoted-printable
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, May 3, 2019 at 9:21 AM Andy Lutomirski <luto@amacapital.net> wrote:
>
> So here=E2=80=99s a somewhat nutty suggestion: how about we tweak the 32-=
bit entry code to emulate the sane 64-bit frame, not just for int3 but alwa=
ys?

What would the code actually end up looking like? I don't necessarily
object, since that kernel_stack_pointer() thing certainly looks
horrible, but honestly, my suggestion to just pass in the 'struct
pt_regs' and let the call emulation fix it up would have also worked,
and avoided that bug (and who knows what else might be hiding).

I really think that you're now hitting all the special case magic
low-level crap that I wanted to avoid.

                   Linus
