Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 81DF313506
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 May 2019 23:52:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726779AbfECVwC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 3 May 2019 17:52:02 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:46400 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725793AbfECVwC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 3 May 2019 17:52:02 -0400
Received: by mail-lj1-f194.google.com with SMTP id h21so6389942ljk.13
        for <linux-kselftest@vger.kernel.org>; Fri, 03 May 2019 14:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OHPmorpbDxR0+1cD6Wtpm6wssS7c1TjAnKQ3VKbd0q0=;
        b=GaGzUULhqjMmt9UB2McFPzy2KoE/vIFjOEPyZeAs9LRhzauYSNsf4aU/gnQ5NxPU7J
         78zVHJUH87faGstKDBEUoXudrE+Qtbp+EbYiXzb8OH5UHhhrvTdjAblZfz0SoEfmZTLA
         matHI53RRosv8whVcU1MDV9SaOQjdTK4xIaJU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OHPmorpbDxR0+1cD6Wtpm6wssS7c1TjAnKQ3VKbd0q0=;
        b=oMr0JCdOq1QC/ot4QxQy2xTc4lwk+QIvExJ3N4ziCh5oK7ibVn36HUDqxREYZinTx4
         +JuyQn1N/AHO8NeCjmZw+y71OIMnVw4wLIFa7/oHL3p8CmTDik1mFDuqLR6pEkss4t6N
         Nc76dmia1/gXgcYXXQgcqa4dnM2Ztanna58mNA5ARlNKNDJlC0xwPlsGCjYHKak8X3gv
         ghrirMHKicDXagV3eAdHb2A9vNOt2fq7PjoMjM6QgONHyXiMQG56fmCrshBWiDq30J6u
         J+xZcjKd1DyasiyZ05lOxgIYcQs3Fa60h1Jga5WBXVCdTEeNP2A94uuC4eN+u2G/lhgR
         292Q==
X-Gm-Message-State: APjAAAVAsmahT0+b/TO6DqQsG00m23DjOIixvqEaIUGOO6zawqIRFGtD
        WmI3NCthvNOWr2Muzqij5cRhvMQMg4c=
X-Google-Smtp-Source: APXvYqw0AIZ3jkVmp1JeXZIEvK0ogCPWcg5ToiXKgBrdWFmZi/NUixPmBbOVT87cT77axNwWKuckUw==
X-Received: by 2002:a2e:5c49:: with SMTP id q70mr6423501ljb.16.1556920320000;
        Fri, 03 May 2019 14:52:00 -0700 (PDT)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id v11sm630405lfb.68.2019.05.03.14.51.59
        for <linux-kselftest@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 May 2019 14:51:59 -0700 (PDT)
Received: by mail-lf1-f54.google.com with SMTP id w23so5387255lfc.9
        for <linux-kselftest@vger.kernel.org>; Fri, 03 May 2019 14:51:59 -0700 (PDT)
X-Received: by 2002:a19:ca02:: with SMTP id a2mr6303975lfg.88.1556919987963;
 Fri, 03 May 2019 14:46:27 -0700 (PDT)
MIME-Version: 1.0
References: <20190501202830.347656894@goodmis.org> <20190501203152.397154664@goodmis.org>
 <20190501232412.1196ef18@oasis.local.home> <20190502162133.GX2623@hirez.programming.kicks-ass.net>
 <CAHk-=wijZ-MD4g3zMJ9W2r=h8LUWneiu29OWuxZEoSfAF=0bhQ@mail.gmail.com>
 <20190502181811.GY2623@hirez.programming.kicks-ass.net> <CAHk-=wi6A9tgw=kkPh5Ywqt687VvsVEjYXVkAnq0jpt0u0tk6g@mail.gmail.com>
 <20190502202146.GZ2623@hirez.programming.kicks-ass.net> <CAHk-=wh8bi5c_GkyjPtDAiaXaZRqtmhWs30usUvs4qK_F+c9tg@mail.gmail.com>
 <20190503152405.2d741af8@gandalf.local.home>
In-Reply-To: <20190503152405.2d741af8@gandalf.local.home>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 3 May 2019 14:46:11 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiA-WbrFrDs-kOfJZMXy4zMo9-SZfk=7B-GfmBJ866naw@mail.gmail.com>
Message-ID: <CAHk-=wiA-WbrFrDs-kOfJZMXy4zMo9-SZfk=7B-GfmBJ866naw@mail.gmail.com>
Subject: Re: [RFC][PATCH 1/2] x86: Allow breakpoints to emulate call functions
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
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

On Fri, May 3, 2019 at 12:24 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> The problem with this approach is that it would require doing the same
> for x86_64, as the int3 C code is the same for both. And that may be a
> bit more difficult on the x86_64 side because it's all done with a
> simple flag in the idtentry macro to add the gap.

That argument is weakened by the fact that we have to do _other_
things differently on 32-bit and 64-bit anyway.

So we might as well have a "on 32-bit, the call emulation needs to
move the pt_regs to make space" special case in the call emulation
code. It's very easy to explain why.

And then we'd limit the special case to where it matters (with a big
comment about what's going on), rather than adding random special case
handling to random _other_ places.

Having to add s magic special case to "kernel_stack_pointer() is
certainly not obvious. Neither is adding magic special cases to system
call exit paths etc.

This has been why I've been arguing against the entry code changes.
Exactly because they tend to have these kind of odd cascading effects.
The entry code is fragile not just because it's a complex hardware
interface, but also because we know about those complex hardware
interfaces in random other places.

I'd much rather have the code that does special things be in one
place, and be the place that *needs* to do the special thing. If we
copy the pt_regs around when we do the "call" emulation, it's *really*
easy to explain *exactly* what we're doing and why in *exactly* that
one context where we are doing it. And it won't affect anything else,
and our existing code that looks at pt_regs will work both before and
after.

Would it need a #ifdef CONFIG_X86_32 around it because it's not needed
on x86-64? Sure. But that #ifdef would be right there, and the comment
that explains why the pt_regs need to be moved would also make it very
obvious why it is only needed for x86-32.

There's a lot of advantages to keeping your problems localized,
instead of letting your random hacks escape and become problems for
other, entirely unrelated, code.

                Linus
