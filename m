Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 214461703C
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 May 2019 06:58:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725860AbfEHE6B (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 8 May 2019 00:58:01 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:38395 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbfEHE6B (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 8 May 2019 00:58:01 -0400
Received: by mail-lj1-f195.google.com with SMTP id u21so7146907lja.5
        for <linux-kselftest@vger.kernel.org>; Tue, 07 May 2019 21:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I5e/UfOxO1ET3GG/v6CYadKGMC4a8arhmGhydGAJn8s=;
        b=fCVBMlCqXFaNG3/T7joMRaQg4ceXtuYdPorGYMf1oXOX02JSfkDNtMBZ392mp3Xa+w
         XzLxNjp4lFJG4QNeeBTaE98AcmNY9mHk/ZS6OieHVwaCDyObPW9cGux/hc2VnbzcJFR6
         4ExSRI8O2Vzt05xYgeQ6pkrUST7OnP3nm4W/A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I5e/UfOxO1ET3GG/v6CYadKGMC4a8arhmGhydGAJn8s=;
        b=ekVNIYnFrEBI4mDDy67yGO2tic47Ztm+23T4YtBHw9c4A6koHoaSG/VrnIak151J52
         XluAO22hZLx1fbffyQcIt7GDND47sNBfFkvHb/50nW6bFYXFEJX3qFR/l9T6oez+rEjD
         rYKShuPA+g5ICCJrR+3jg4sTu+bb5zcOmLDWZ4rdKpjBSDUxQieBJ+98giuW/c6ii37C
         pVmGETfVwhoObPJseUyRfVGXfDWobRLGW3gzWCj3KOjrsPs/a4gLPl1PUAL75U42hKat
         8rQEId3+HKsK4B0dU1I68gZJkwz+zKJL3JHcwWH6YX4hU1G287ZJJMx2QfQq1hLC18PH
         em2A==
X-Gm-Message-State: APjAAAUlamij7rnLA1gUuJx52jz2KL5PAgXqzYdhDutZ4XLg7s2cLTJG
        b/Qc8qpBWwZCy/HsU4NEU7oHEEDwDpA=
X-Google-Smtp-Source: APXvYqxS3gf5ZrWAC4C1iPXgz+5kkaT4tBKMD1X3lh9c0t3kvqNJLw7S1+3rLgvxYaU9+JVBF0zTLg==
X-Received: by 2002:a2e:281:: with SMTP id y1mr6864228lje.175.1557291478907;
        Tue, 07 May 2019 21:57:58 -0700 (PDT)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id t17sm3789029lfp.82.2019.05.07.21.57.58
        for <linux-kselftest@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 May 2019 21:57:58 -0700 (PDT)
Received: by mail-lj1-f177.google.com with SMTP id e13so1693187ljl.11
        for <linux-kselftest@vger.kernel.org>; Tue, 07 May 2019 21:57:58 -0700 (PDT)
X-Received: by 2002:a2e:9d86:: with SMTP id c6mr17393609ljj.135.1557291068666;
 Tue, 07 May 2019 21:51:08 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wjLXmOn=Cp=uOfO4gE01eN_-UcOUyrMTTw5-f_OfPO48Q@mail.gmail.com>
 <20190506225819.11756974@oasis.local.home> <CAHk-=wh4FCNBLe8OyDZt2Tr+k9JhhTsg3H8R4b55peKcf0b6eQ@mail.gmail.com>
 <20190506232158.13c9123b@oasis.local.home> <CAHk-=wi4vPg4pu6RvxQrUuBL4Vgwd2G2iaEJVVumny+cBOWMZw@mail.gmail.com>
 <CAHk-=wg2_okyU8mpkGCUrudgfg8YmNetSD8=scNbOkN+imqZdQ@mail.gmail.com>
 <20190507111227.1d4268d7@gandalf.local.home> <CAHk-=wjYdj+vvV8uUA8eaUSxOhu=xuQxdo-dtM927j0-3hSkEw@mail.gmail.com>
 <20190507163440.GV2606@hirez.programming.kicks-ass.net> <CAHk-=wiuue37opWK5QaQ9f6twqDZuSratdP-1bK6kD9-Az5WnA@mail.gmail.com>
 <20190507172159.5t3bm3mjkwagvite@treble> <20190507172418.67ef6fc3@gandalf.local.home>
In-Reply-To: <20190507172418.67ef6fc3@gandalf.local.home>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 7 May 2019 21:50:52 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg5_fwx_-ybD9TLQE4rAUqtYzO2CAmpciWTkDn3dtKMOw@mail.gmail.com>
Message-ID: <CAHk-=wg5_fwx_-ybD9TLQE4rAUqtYzO2CAmpciWTkDn3dtKMOw@mail.gmail.com>
Subject: Re: [RFC][PATCH 1/2] x86: Allow breakpoints to emulate call functions
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
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

On Tue, May 7, 2019 at 2:24 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> And there's been several times I forget that regs->sp can not be read
> directly. Especially most of my bug reports are for x86_64 these days.
> But when I had that seldom x86_32 one, and go debugging, I would print
> out "regs->sp" and then the system would crash. And I spend some time
> wondering why?
>
> It's been a bane of mine for some time.

Guys, I have basically a one-liner patch for your hangups.

It's called "rename 'sp' to 'user_sp' on x86-32".

Then we make the 'sp' field on x86-64 be a union, so that you can call
it user_sp or sp as you wish.

Yeah, it's really more than one line, because obviously the users will
need chaning, but honestly, that would be a _real_ cleanup. Make the
register match what it actually is.

And it doesn't mess up the stack frame, and it doesn't change the
entry code. It just reminds people that the entry is the USER stack
pointer.

Problem solved.

               Linus
