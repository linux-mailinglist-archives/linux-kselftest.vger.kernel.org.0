Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B18D10D68
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 May 2019 21:44:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726077AbfEATop (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 1 May 2019 15:44:45 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:40574 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726004AbfEATop (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 1 May 2019 15:44:45 -0400
Received: by mail-lj1-f194.google.com with SMTP id d15so79433ljc.7
        for <linux-kselftest@vger.kernel.org>; Wed, 01 May 2019 12:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1aWTopvtcpE1sMBLog+svv/V7Oyc8azAzAFUDC8QSPA=;
        b=g5Olcm90ZhHiM7hLghWqEsHCmJOQJKveCq93FgS32/SOMLiESIU19RmapyE9Ee9EYf
         ViBeexnj6bwofQ4qsmRyD1ujInNeMtVrrzEmNmw9ZRifskM7p87DSr1orgBEPN8GpwJA
         AtMCjbwPS+2qzsxmpJz+Cd9TiwHXhMCbJ9VGo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1aWTopvtcpE1sMBLog+svv/V7Oyc8azAzAFUDC8QSPA=;
        b=CmysHNGUzGRmjQNgGg4PfGAccecY5hjzZubN77+Izs2gn7t/GTJM2kcom0vyY5ZeHb
         RH5fBZQinIN1+G74qJg3FpOFuqUoXIkC3MsMPF+BV22883gJJEjeYTLxQOiriv3XbuWz
         /Rouxq+8K33VO7Up/Yv5ud1KNZuw/hemSH9M3zQAXiWe9Y+9fvXiXP9niodTO5rcfuoh
         gw7LtKva2ZwID4yxs7jZLGa3PRs8iiLRkKp9Vauh+5aUNYaDkoQx8/hVMhqTL5Pnpr54
         PAFPqbY9r6PfWmeiEpYx8HOAK5b6FLiU3xPu8IhmACMJGCbVnyPZTBu55Tj3kf9vNmaK
         7ZGQ==
X-Gm-Message-State: APjAAAXnl1iT+cp9jg1k5fGIVXdIsope2B5PE7F38leOog3LWe4HPUIn
        PahFlITfxDgIgcJKOZ70zz7p98whU88=
X-Google-Smtp-Source: APXvYqyYGJqzHysFnyj79vPWQyBEEZ1j/XUViePjdZ1CoHTPlNDDKVPHRWarBFYzC9K804GpxVSoMQ==
X-Received: by 2002:a2e:d1a:: with SMTP id 26mr11943490ljn.147.1556739883016;
        Wed, 01 May 2019 12:44:43 -0700 (PDT)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id m3sm8931255lfh.94.2019.05.01.12.44.42
        for <linux-kselftest@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 May 2019 12:44:42 -0700 (PDT)
Received: by mail-lj1-f172.google.com with SMTP id q10so83122ljc.6
        for <linux-kselftest@vger.kernel.org>; Wed, 01 May 2019 12:44:42 -0700 (PDT)
X-Received: by 2002:a05:651c:8f:: with SMTP id 15mr4971551ljq.118.1556739386764;
 Wed, 01 May 2019 12:36:26 -0700 (PDT)
MIME-Version: 1.0
References: <20190501113238.0ab3f9dd@gandalf.local.home> <CAHk-=wjvQxY4DvPrJ6haPgAa6b906h=MwZXO6G8OtiTGe=N7_w@mail.gmail.com>
 <20190501145200.6c095d7f@oasis.local.home> <CAHk-=wgMZJeMCW5MA25WFJZeYYWCOWr0nGaHhJ7kg+zsu5FY_A@mail.gmail.com>
 <20190501191716.GV7905@worktop.programming.kicks-ass.net>
In-Reply-To: <20190501191716.GV7905@worktop.programming.kicks-ass.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 1 May 2019 12:36:10 -0700
X-Gmail-Original-Message-ID: <CAHk-=whWOStbe8nAxuaovrmqsq_YW-rDFu1AkpgisaWMqdMibg@mail.gmail.com>
Message-ID: <CAHk-=whWOStbe8nAxuaovrmqsq_YW-rDFu1AkpgisaWMqdMibg@mail.gmail.com>
Subject: Re: [RFC][PATCH v3] ftrace/x86_64: Emulate call function while
 updating in breakpoint handler
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

On Wed, May 1, 2019 at 12:17 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> Something like so then?

Yes, that looks correct.

We have those X86_EFLAGS_VM tests pretty randomly scattered around,
and I wish there was some cleaner model for this, but I also guess
that there's no point in worrying about the 32-bit code much.

                Linus
