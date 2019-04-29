Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 55BC8EC91
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Apr 2019 00:12:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729252AbfD2WL7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 29 Apr 2019 18:11:59 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:43075 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728105AbfD2WL7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 29 Apr 2019 18:11:59 -0400
Received: by mail-lf1-f68.google.com with SMTP id i68so9082547lfi.10
        for <linux-kselftest@vger.kernel.org>; Mon, 29 Apr 2019 15:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cTkJ5qHxsD8SYnb8NRVfGGysKDzTffkMwFGKzHjAIes=;
        b=P/hvsAFBYFuVdRyxHJQqYZPAHZlzO7DpELqDJ8wtqrIzcq7eThvNjt852fIlr3+1hp
         vVyLfbe/O0jvxqP511QI0JfPRN9J+m8BMRz0pKGIgZRo0Qiu2YusRGP2+ndwrIJZA81T
         qOBt9kqSGLrhz0pQMSTGYNPFKlQsei2x7M0lc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cTkJ5qHxsD8SYnb8NRVfGGysKDzTffkMwFGKzHjAIes=;
        b=XkKMgSy3KbgbvJabb2rv9aiQSFRXYiaJCMOgyWQO3LBOK5MRdj2k8a222LRlrqgqpp
         4hpPsT7fKgfjq+AivbzvG2ChlCeQlvbr2W+D71bOPdfIXQN5+S/Xf4JeTCBJNl3rYCOu
         DiSPyNa0m6HVxfZtgU8mgykcsrM9P1Z/2Q/1DhdtEk7dzKx3qlYkJag+XjXXyue2EhPl
         JojASb3Sd2K/NRiLRDDSpPep5w0Lu1Qty3Gj56J05hzZS0l4r/IK/eufurbO0MLyAe2B
         IpjgJELfOJXUILxIsio9+fwiMlH5YnW3vV/3U7+yXLD5q+4G8IK1etkP+lg/37xkQYzP
         ZGCA==
X-Gm-Message-State: APjAAAWxqw8MzhHFkGsvk1b/OZjTkkHA5ylPd4+jpSFQdzeu3fCkc9xz
        ZTxnGLWLLz22OJeAxyN3DF5/ImZgPHc=
X-Google-Smtp-Source: APXvYqz3i66XPssfLaamAavrN/7sJ6zb6sGbNoG+gFbPE/4riiRUMceAaDNnFmIGAjKuBi7C84wmTQ==
X-Received: by 2002:ac2:4893:: with SMTP id x19mr120936lfc.109.1556575917124;
        Mon, 29 Apr 2019 15:11:57 -0700 (PDT)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id t206sm7596204lff.21.2019.04.29.15.11.56
        for <linux-kselftest@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Apr 2019 15:11:56 -0700 (PDT)
Received: by mail-lf1-f41.google.com with SMTP id k18so9085668lfj.13
        for <linux-kselftest@vger.kernel.org>; Mon, 29 Apr 2019 15:11:56 -0700 (PDT)
X-Received: by 2002:a19:48c9:: with SMTP id v192mr32975252lfa.136.1556575607339;
 Mon, 29 Apr 2019 15:06:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190427100639.15074-1-nstange@suse.de> <20190427100639.15074-4-nstange@suse.de>
 <20190427102657.GF2623@hirez.programming.kicks-ass.net> <20190428133826.3e142cfd@oasis.local.home>
 <CAHk-=wh5OpheSU8Em_Q3Hg8qw_JtoijxOdPtHru6d+5K8TWM=A@mail.gmail.com>
 <CAHk-=wjphmrQXMfbw9j-tTzDvJ+Uc+asMHdFa=1_1xZoYVUC=g@mail.gmail.com>
 <CALCETrXvmZPHsfRVnW0AtyddfN-2zaCmWn+FsrF6XPTOFd_Jmw@mail.gmail.com>
 <CAHk-=whtt4K2f0KPtG-4Pykh3FK8UBOjD8jhXCUKB5nWDj_YRA@mail.gmail.com> <CALCETrWELBCK-kqX5FCEDVUy8kCT-yVu7m_7Dtn=GCsHY0Du5A@mail.gmail.com>
In-Reply-To: <CALCETrWELBCK-kqX5FCEDVUy8kCT-yVu7m_7Dtn=GCsHY0Du5A@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 29 Apr 2019 15:06:30 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjAQaowLHBrXs1M5K-Nr-eVQMt0K8oyCuWxKTvP9k=qqA@mail.gmail.com>
Message-ID: <CAHk-=wjAQaowLHBrXs1M5K-Nr-eVQMt0K8oyCuWxKTvP9k=qqA@mail.gmail.com>
Subject: Re: [PATCH 3/4] x86/ftrace: make ftrace_int3_handler() not to skip
 fops invocation
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
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

On Mon, Apr 29, 2019 at 11:57 AM Andy Lutomirski <luto@kernel.org> wrote:
> >
> > Otherwise you could never trust the whole sti shadow thing - and it very much is part of the architecture.
>
> Is this documented somewhere?

Btw, if you really don't trust the sti shadow despite it going all the
way back to the 8086, then you could instead make the irqoff code do

        push %gs:bp_call_return
        push %gs:bp_call_target
        sti
        ret

which just keeps interrupts explicitly disabled over the whole use of
the percpu data.

The actual "ret" instruction doesn't matter, it's not going to change
in this model (where the code isn't dynamically generated or changed).
So I claim that it will still be protected by the sti shadow, but when
written that way it doesn't actually matter, and you could reschedule
immediately after the sti (getting an interrupt there might make the
stack frame look odd, but it doesn't really affect anything else)

                  Linus
