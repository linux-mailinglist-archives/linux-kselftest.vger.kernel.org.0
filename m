Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 63F10FFCB
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Apr 2019 20:40:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726341AbfD3SkB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 30 Apr 2019 14:40:01 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:41331 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726061AbfD3SkB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 30 Apr 2019 14:40:01 -0400
Received: by mail-lf1-f65.google.com with SMTP id d8so11849lfb.8
        for <linux-kselftest@vger.kernel.org>; Tue, 30 Apr 2019 11:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uKQ5wQDmcWGNS5cFgE6sknQ1Vaz0sJXUmzUNGiZJEQw=;
        b=cA+Fnbmk0I5OJp9OtlS1S8PhpJVuthIr36z1RS/i4PikRfFVCqQc79YE883gVNbbQX
         rU4NivMUS9CGP8EKH0Hrd/XaBHYNd2ifkjss3yQ02d2fuubygig5Isugs+12vrC+6Brv
         XyP/4uH/8t46MMd0PxWi8jRHESv+uau/CAOfo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uKQ5wQDmcWGNS5cFgE6sknQ1Vaz0sJXUmzUNGiZJEQw=;
        b=q2VH3WRGFv9CwzG3L1m9x49Z/iZRKzgjOAT+E3JjEpV+zLEalJVHUMFD7ajZpo13Ou
         32ZdZAirihuCsZzcz2Rd207j51UOCXyBVYan37hVyHxp35h1YXNM0dyQsSq14PqGKsvA
         zkpJsY34we27cYXPwBL7CWBqu3T1t88tYMOYGmXagjOUJrqyWOEcpFbDJvKZtPUF6Vy/
         50dPAmcaWEmfEjWdD64k8y/3a5ciDgRgKr8VJqPhAoQb67HIcT2cjkGuGeBudE7rzg5u
         jFmOTi9HAYeg+IVZAEtwUwaogxeZ4xx2SOYrrtMGQbUQ8OcSAkGLsCm/68nTdhQaGBVi
         hKUQ==
X-Gm-Message-State: APjAAAVIgVyIpTYKH78sPanqfN8syhIR1PHFWulwzj0kdOP0jKkNc3pX
        XeRIj4AoE8qMwyw7VE7glGQHqBpt14E=
X-Google-Smtp-Source: APXvYqxRBiguLJjHuf0aUKaxcioV3sgnBjuHfpOnVj1tyJuFfuGaYnq7bk1o7h7Ul1tekbAn+jlWtw==
X-Received: by 2002:a19:cc52:: with SMTP id c79mr36399866lfg.30.1556649598723;
        Tue, 30 Apr 2019 11:39:58 -0700 (PDT)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id z26sm529987lfj.66.2019.04.30.11.39.58
        for <linux-kselftest@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Apr 2019 11:39:58 -0700 (PDT)
Received: by mail-lj1-f174.google.com with SMTP id w12so1997787ljh.12
        for <linux-kselftest@vger.kernel.org>; Tue, 30 Apr 2019 11:39:58 -0700 (PDT)
X-Received: by 2002:a2e:22c4:: with SMTP id i187mr36309820lji.94.1556649217849;
 Tue, 30 Apr 2019 11:33:37 -0700 (PDT)
MIME-Version: 1.0
References: <20190428133826.3e142cfd@oasis.local.home> <CAHk-=wh5OpheSU8Em_Q3Hg8qw_JtoijxOdPtHru6d+5K8TWM=A@mail.gmail.com>
 <CAHk-=wjphmrQXMfbw9j-tTzDvJ+Uc+asMHdFa=1_1xZoYVUC=g@mail.gmail.com>
 <CALCETrXvmZPHsfRVnW0AtyddfN-2zaCmWn+FsrF6XPTOFd_Jmw@mail.gmail.com>
 <CAHk-=whtt4K2f0KPtG-4Pykh3FK8UBOjD8jhXCUKB5nWDj_YRA@mail.gmail.com>
 <CALCETrWELBCK-kqX5FCEDVUy8kCT-yVu7m_7Dtn=GCsHY0Du5A@mail.gmail.com>
 <CAHk-=wgewK4eFhF3=0RNtk1KQjMANFH6oDE=8m=84RExn2gxhw@mail.gmail.com>
 <CAHk-=whay7eN6+2gZjY-ybRbkbcqAmgrLwwszzHx8ws3c=S-MA@mail.gmail.com>
 <CALCETrXzVU0Q7u1q=QFPaDr=aojjF5cjbOi9CxxXnp5GqTqsWA@mail.gmail.com>
 <CAHk-=wg1QPz0m+7jnVcjQgkySUQLzAXE8_PZARV-vWYK27LB=w@mail.gmail.com>
 <20190430135602.GD2589@hirez.programming.kicks-ass.net> <CAHk-=wg7vUGMRHyBsLig6qiPK0i4_BK3bRrTN+HHHziUGg1P_A@mail.gmail.com>
 <CALCETrXujRWxwkgAwB+8xja3N9H22t52AYBYM_mbrjKKZ624Eg@mail.gmail.com>
 <20190430130359.330e895b@gandalf.local.home> <20190430132024.0f03f5b8@gandalf.local.home>
 <20190430134913.4e29ce72@gandalf.local.home>
In-Reply-To: <20190430134913.4e29ce72@gandalf.local.home>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 30 Apr 2019 11:33:21 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjJ8D74+FDcXGL65Q9aB0cc7B4vr2s2rS6V4d4a3hU-1Q@mail.gmail.com>
Message-ID: <CAHk-=wjJ8D74+FDcXGL65Q9aB0cc7B4vr2s2rS6V4d4a3hU-1Q@mail.gmail.com>
Subject: Re: [RFC][PATCH] ftrace/x86: Emulate call function while updating in
 breakpoint handler
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Andy Lutomirski <luto@kernel.org>,
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

On Tue, Apr 30, 2019 at 10:49 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> +
> +asm(
> +       ".text\n"
> +
> +       /* Trampoline for function update with interrupts enabled */
> +       ".global ftrace_emulate_call_irqoff\n"
> +       ".type ftrace_emulate_call_irqoff, @function\n"
> +       "ftrace_emulate_call_irqoff:\n\t"
> +               "push %gs:ftrace_bp_call_return\n\t"

Well, as mentioned in my original suggestion, this won't work on
32-bit, or on UP. They have different models for per-cpu data (32-bti
uses %fs, and UP doesn't use a segment override at all).

Maybe we just don't care about UP at all for this code, of course.

And maybe we can make the decision to also make 32-bit just not use
this either - so maybe the code is ok per se, just needs to make sure
it never triggers for the cases that it's not written for..

> +       "ftrace_emulate_call_update_irqoff:\n\t"
> +               "push %gs:ftrace_bp_call_return\n\t"
> +               "sti\n\t"
> +               "jmp *ftrace_update_func_call\n"

.. and this should then use the "push push sti ret" model instead.

Plus get updated for objtool complaints.

Anyway, since Andy really likes the entry code change, can we have
that patch in parallel and judge the difference that way? Iirc, that
was x86-64 specific too.

                           Linus
