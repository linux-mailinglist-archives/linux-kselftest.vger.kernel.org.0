Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5DB4310CFE
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 May 2019 21:04:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726019AbfEATEP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 1 May 2019 15:04:15 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:35517 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726096AbfEATEP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 1 May 2019 15:04:15 -0400
Received: by mail-lj1-f195.google.com with SMTP id z26so10764ljj.2
        for <linux-kselftest@vger.kernel.org>; Wed, 01 May 2019 12:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TiBsTWgzzAF+KdkEXxajDMuwYJJBRVV+mYkYOCtAGk0=;
        b=XhXhYve5yp/7i7ghcjSgqe8Ah4/jDyKSdA4S4qrEgBU4LVdnD257Ifh54gJv84NAiR
         JZoS2qQKQRUzHFnqFyLTaaVMOqgJnwidqknuDV//VcmEILwJrVqHQ7CVkyI5GbnNHtsk
         xTszDTRHy7x7pFIaZAu5kKKzR6BGVz7v+AD6s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TiBsTWgzzAF+KdkEXxajDMuwYJJBRVV+mYkYOCtAGk0=;
        b=YLv5jjHI1EXM1f00Uxh+P5MqLFuQWrUPYOvfsVKbG3p7+pK1rUagIY6nbkOd1VrPRo
         QPNM6e1y2/cW17RPJKo7Yj15no4I+yBvjQuGfbawGNkrz0gSopg8YyGgj9MevQvYW/tZ
         v6qH1GGldkSiIUX7LTnEwfjOxNDmSqohYMqb4+SbU9Qx7tEBxOcdHhdBlWxGZriGTEuN
         wrE2zxJFhg31WVmuINoZwL9ZtvV3qT3Mq3Bjdc19d5gdTDakbxp3js8mkuu0ZHZxnkBW
         lCoP8eEemhM2TpOalVaUB0cClA7YwnczepFGgnK8s1IYOVfdlpnvwl6DYjvKW0HR0Y9P
         723A==
X-Gm-Message-State: APjAAAWKjFistgA2VnEeFqAZTi0JmKF6kMKTkxoYeOBus0x9KMgT394+
        wSzM5DQoVKeMB2GGj19DVqJ9XbprV4w=
X-Google-Smtp-Source: APXvYqyLjUwsmxIWEiMrteWHbhE4J8YxmrSGjRIPZvooy068BK0/cwB9YOaJyD4ryBzhWoYVwK0GAw==
X-Received: by 2002:a2e:9155:: with SMTP id q21mr26521493ljg.178.1556737452857;
        Wed, 01 May 2019 12:04:12 -0700 (PDT)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id m71sm223868lje.24.2019.05.01.12.04.09
        for <linux-kselftest@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 May 2019 12:04:12 -0700 (PDT)
Received: by mail-lf1-f44.google.com with SMTP id i68so35953lfi.10
        for <linux-kselftest@vger.kernel.org>; Wed, 01 May 2019 12:04:09 -0700 (PDT)
X-Received: by 2002:ac2:547a:: with SMTP id e26mr18587346lfn.148.1556737448492;
 Wed, 01 May 2019 12:04:08 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=whay7eN6+2gZjY-ybRbkbcqAmgrLwwszzHx8ws3c=S-MA@mail.gmail.com>
 <CALCETrXzVU0Q7u1q=QFPaDr=aojjF5cjbOi9CxxXnp5GqTqsWA@mail.gmail.com>
 <CAHk-=wg1QPz0m+7jnVcjQgkySUQLzAXE8_PZARV-vWYK27LB=w@mail.gmail.com>
 <20190430135602.GD2589@hirez.programming.kicks-ass.net> <CAHk-=wg7vUGMRHyBsLig6qiPK0i4_BK3bRrTN+HHHziUGg1P_A@mail.gmail.com>
 <CALCETrXujRWxwkgAwB+8xja3N9H22t52AYBYM_mbrjKKZ624Eg@mail.gmail.com>
 <20190430130359.330e895b@gandalf.local.home> <20190430132024.0f03f5b8@gandalf.local.home>
 <20190430134913.4e29ce72@gandalf.local.home> <CAHk-=wjJ8D74+FDcXGL65Q9aB0cc7B4vr2s2rS6V4d4a3hU-1Q@mail.gmail.com>
 <20190501131117.GW2623@hirez.programming.kicks-ass.net>
In-Reply-To: <20190501131117.GW2623@hirez.programming.kicks-ass.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 1 May 2019 12:03:52 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjCoycqdVjvWkkFnVRQS9fHEzdmiAG4uUV8B04xv7ZVwA@mail.gmail.com>
Message-ID: <CAHk-=wjCoycqdVjvWkkFnVRQS9fHEzdmiAG4uUV8B04xv7ZVwA@mail.gmail.com>
Subject: Re: [RFC][PATCH] ftrace/x86: Emulate call function while updating in
 breakpoint handler
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
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
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        live-patching@vger.kernel.org,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, May 1, 2019 at 6:11 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> Here goes, compile tested only...

Ugh, two different threads. This has the same bug (same source) as the
one Steven posted:

> --- a/arch/x86/entry/entry_32.S
> +++ b/arch/x86/entry/entry_32.S
> @@ -1479,6 +1479,13 @@ ENTRY(int3)
>         ASM_CLAC
>         pushl   $-1                             # mark this as an int
>
> +       testl   $SEGMENT_RPL_MASK, PT_CS(%esp)
> +       jnz     .Lfrom_usermode_no_gap
> +       .rept 6
> +       pushl   5*4(%esp)
> +       .endr
> +.Lfrom_usermode_no_gap:

This will corrupt things horribly if you still use vm86 mode. Checking
CS RPL is simply not correct.

                 Linus
