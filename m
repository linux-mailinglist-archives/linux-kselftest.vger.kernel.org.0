Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A1A9EA1F
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Apr 2019 20:29:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728844AbfD2S3k (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 29 Apr 2019 14:29:40 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:44079 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728962AbfD2S3k (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 29 Apr 2019 14:29:40 -0400
Received: by mail-lj1-f194.google.com with SMTP id c6so3805847lji.11
        for <linux-kselftest@vger.kernel.org>; Mon, 29 Apr 2019 11:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=liktUAQ84meAwYxARrOaB57hFmqHknre6y7TLap/pyw=;
        b=TlX1vlaNRutHcVL0zAHMii8+n9hCbC2fIKsPMUSq4g7TknK8mmi/6eY9keIz02Ws6a
         0sxXLjiXKqUe5nVD8Hq9h6XVk1mWLMo7lAqkO0QgXrp0M7JguoB/2YMziFqvFKujU3CI
         Oo2bSTLegqzhOQTgHMmIMbR2g7S9IuZHsXaQU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=liktUAQ84meAwYxARrOaB57hFmqHknre6y7TLap/pyw=;
        b=O8H61j01hWOKYqaSAcfUIHWaKjzcjQNfu+WHf7IHJnchMKwR5sna8wWsBOph5HizdW
         eAY54elh6eaYvqy87AzDUpFJVX1504K3GlqafUl5Lo8lM8wiDwDzIc0nH45n8LS6X21t
         uNrL0fqfqyssExQwPhhbFhgt0evFSGPxuQ0rLZ/36y6h01oD4e4Pz+LyDSoi30RPIKnL
         UECvxaqcwNbRLpkQLO2NuZgSbpgV8W0Jo4oJ2xw4haEziL37EYuIsDylLjO5SjsUAHPK
         iccPJJnesGCO2O2TJeNLezIoiMSzTQ39iB5Iws02DxugxBrv3Ng+aF/xcOJao9frMpQQ
         0CKw==
X-Gm-Message-State: APjAAAVQ0AtJAV+cRJvA7k30K3XPd1dIf9ERNmSX6xawS+IRtw5pNO/3
        TnbI0Qin5kGuNouvBpbaqvp5OtzyNo8=
X-Google-Smtp-Source: APXvYqzzX6cPziYoYG/FCvLOO/s2IxIzF/7Oj6q1vAnTTE0k2kXKsH2u6YiLrKZAeOSHt0knIh14fw==
X-Received: by 2002:a2e:9a0f:: with SMTP id o15mr23479707lji.130.1556562577749;
        Mon, 29 Apr 2019 11:29:37 -0700 (PDT)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id b28sm6404265lfc.7.2019.04.29.11.29.37
        for <linux-kselftest@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Apr 2019 11:29:37 -0700 (PDT)
Received: by mail-lj1-f178.google.com with SMTP id t10so9271626ljg.7
        for <linux-kselftest@vger.kernel.org>; Mon, 29 Apr 2019 11:29:37 -0700 (PDT)
X-Received: by 2002:a2e:9ac8:: with SMTP id p8mr30224042ljj.79.1556562187132;
 Mon, 29 Apr 2019 11:23:07 -0700 (PDT)
MIME-Version: 1.0
References: <20190427100639.15074-1-nstange@suse.de> <20190427100639.15074-4-nstange@suse.de>
 <20190427102657.GF2623@hirez.programming.kicks-ass.net> <20190428133826.3e142cfd@oasis.local.home>
 <CAHk-=wh5OpheSU8Em_Q3Hg8qw_JtoijxOdPtHru6d+5K8TWM=A@mail.gmail.com>
In-Reply-To: <CAHk-=wh5OpheSU8Em_Q3Hg8qw_JtoijxOdPtHru6d+5K8TWM=A@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 29 Apr 2019 11:22:51 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjphmrQXMfbw9j-tTzDvJ+Uc+asMHdFa=1_1xZoYVUC=g@mail.gmail.com>
Message-ID: <CAHk-=wjphmrQXMfbw9j-tTzDvJ+Uc+asMHdFa=1_1xZoYVUC=g@mail.gmail.com>
Subject: Re: [PATCH 3/4] x86/ftrace: make ftrace_int3_handler() not to skip
 fops invocation
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
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
        Andy Lutomirski <luto@kernel.org>,
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

On Mon, Apr 29, 2019 at 11:06 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
>
> It does *not* emulate the "call" in the BP handler itself, instead if
> replace the %ip (the same way all the other BP handlers replace the
> %ip) with a code sequence that just does
>
>         push %gs:bp_call_return
>         jmp *%gs:bp_call_target
>
> after having filled in those per-cpu things.

Note that if you read the patch, you'll see that my explanation
glossed over the "what if an interrupt happens" part. Which is handled
by having two handlers, one for "interrupts were already disabled" and
one for "interrupts were enabled, so I disabled them before entering
the handler".

The second handler does the same push/jmp sequence, but has a "sti"
before the jmp. Because of the one-instruction sti shadow, interrupts
won't actually be enabled until after the jmp instruction has
completed, and thus the "push/jmp" is atomic wrt regular interrupts.

It's not safe wrt NMI, of course, but since NMI won't be rescheduling,
and since any SMP IPI won't be punching through that sequence anyway,
it's still atomic wrt _another_ text_poke() attempt coming in and
re-using the bp_call_return/tyarget slots.

So yeah, it's not "one-liner" trivial, but it's not like it's
complicated either, and it actually matches the existing "call this
code to emulate the replaced instruction". So I'd much rather have a
couple of tens of lines of code here that still acts pretty much
exactly like all the other rewriting does, rather than play subtle
games with the entry stack frame.

Finally: there might be other situations where you want to have this
kind of "pseudo-atomic" replacement sequence, so I think while it's a
hack specific to emulating a "call" instruction, I don't think it is
conceptually limited to just that case.

                 Linus
