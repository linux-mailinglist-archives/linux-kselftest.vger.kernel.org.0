Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B2D5EA90
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Apr 2019 20:57:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728962AbfD2S5L (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 29 Apr 2019 14:57:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:52696 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728946AbfD2S5K (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 29 Apr 2019 14:57:10 -0400
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EE847217D4
        for <linux-kselftest@vger.kernel.org>; Mon, 29 Apr 2019 18:57:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556564229;
        bh=ZDqmipFipLpIZw5XbwEeviScDby2c6433f2grnTYDCA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Ao1BVcNPwNf0yh8qnDaggwfnP8lN4iW+WoY3L+qCIRO2F8n/zMqxfRWEz5SnoYr8K
         lnoQVz8nIstYY3gLTItaPJB8Z5GkZGnI8coN5Le1pOM9Nnv2IGeHXAg+N6lyuYVg2G
         xyBZ/oX/5sX1A8bkBDTseC3+IvRNBWHyKCng/NZ8=
Received: by mail-wm1-f43.google.com with SMTP id b10so598263wmj.4
        for <linux-kselftest@vger.kernel.org>; Mon, 29 Apr 2019 11:57:08 -0700 (PDT)
X-Gm-Message-State: APjAAAWIdD6TnBxH97l7CiuPaYRzQr8ids8Feu9eBDEZVtPyFArAc50Z
        01GHEBx5IXwH456K6MaMkJ+ztbUcpqzmVfnLzOE6xQ==
X-Google-Smtp-Source: APXvYqxEdOXJyL2h0BrYQ1dX1a3pxXda/RLsa05pr12OOLPLgHzV0MO6FYK54RYNjcpxUHVfzDTCq2sPoqQc90HVxD0=
X-Received: by 2002:a7b:c257:: with SMTP id b23mr344247wmj.83.1556564225766;
 Mon, 29 Apr 2019 11:57:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190427100639.15074-1-nstange@suse.de> <20190427100639.15074-4-nstange@suse.de>
 <20190427102657.GF2623@hirez.programming.kicks-ass.net> <20190428133826.3e142cfd@oasis.local.home>
 <CAHk-=wh5OpheSU8Em_Q3Hg8qw_JtoijxOdPtHru6d+5K8TWM=A@mail.gmail.com>
 <CAHk-=wjphmrQXMfbw9j-tTzDvJ+Uc+asMHdFa=1_1xZoYVUC=g@mail.gmail.com>
 <CALCETrXvmZPHsfRVnW0AtyddfN-2zaCmWn+FsrF6XPTOFd_Jmw@mail.gmail.com> <CAHk-=whtt4K2f0KPtG-4Pykh3FK8UBOjD8jhXCUKB5nWDj_YRA@mail.gmail.com>
In-Reply-To: <CAHk-=whtt4K2f0KPtG-4Pykh3FK8UBOjD8jhXCUKB5nWDj_YRA@mail.gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Mon, 29 Apr 2019 11:56:54 -0700
X-Gmail-Original-Message-ID: <CALCETrWELBCK-kqX5FCEDVUy8kCT-yVu7m_7Dtn=GCsHY0Du5A@mail.gmail.com>
Message-ID: <CALCETrWELBCK-kqX5FCEDVUy8kCT-yVu7m_7Dtn=GCsHY0Du5A@mail.gmail.com>
Subject: Re: [PATCH 3/4] x86/ftrace: make ftrace_int3_handler() not to skip
 fops invocation
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Lutomirski <luto@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
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

On Mon, Apr 29, 2019 at 11:53 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
>
>
> On Mon, Apr 29, 2019, 11:42 Andy Lutomirski <luto@kernel.org> wrote:
>>
>>
>> I'm less than 100% convinced about this argument.  Sure, an NMI right
>> there won't cause a problem.  But an NMI followed by an interrupt will
>> kill us if preemption is on.  I can think of three solutions:
>
>
> No, because either the sti shadow disables nmi too (that's the case on some CPUs at least) or the iret from nmi does.
>
> Otherwise you could never trust the whole sti shadow thing - and it very much is part of the architecture.
>

Is this documented somewhere?  And do you actually believe that this
is true under KVM, Hyper-V, etc?  As I recall, Andrew Cooper dug in to
the way that VMX dealt with this stuff and concluded that the SDM was
blatantly wrong in many cases, which leads me to believe that Xen
HVM/PVH is the *only* hypervisor that gets it right.

Steven's point about batched updates is quite valid, though.  My
personal favorite solution to this whole mess is to rework the whole
thing so that the int3 handler simply returns and retries and to
replace the sync_core() broadcast with an SMI broadcast.  I don't know
whether this will actually work on real CPUs and on VMs and whether
it's going to crash various BIOSes out there.
