Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF33FF2BD
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Apr 2019 11:25:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726309AbfD3JYa (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 30 Apr 2019 05:24:30 -0400
Received: from mx2.suse.de ([195.135.220.15]:38526 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726119AbfD3JYa (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 30 Apr 2019 05:24:30 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5D9C7AC52;
        Tue, 30 Apr 2019 09:24:27 +0000 (UTC)
From:   Nicolai Stange <nstange@suse.de>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Nicolai Stange <nstange@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "the arch\/x86 maintainers" <x86@kernel.org>,
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
        "open list\:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH 3/4] x86/ftrace: make ftrace_int3_handler() not to skip fops invocation
References: <20190427100639.15074-1-nstange@suse.de>
        <20190427100639.15074-4-nstange@suse.de>
        <20190427102657.GF2623@hirez.programming.kicks-ass.net>
        <20190428133826.3e142cfd@oasis.local.home>
        <CAHk-=wh5OpheSU8Em_Q3Hg8qw_JtoijxOdPtHru6d+5K8TWM=A@mail.gmail.com>
        <20190429145250.1a5da6ed@gandalf.local.home>
        <CAHk-=wjm93jLtVxTX4HZs6K4k1Wqh3ujjmapqaYtcibVk_YnzQ@mail.gmail.com>
        <20190429150724.6e501d27@gandalf.local.home>
        <CAHk-=wgbC-wiSrdDYAh1ORF4EKmecY+MkNsJBF=BWf4W1bXXgA@mail.gmail.com>
        <20190429163043.535f4272@gandalf.local.home>
        <CAHk-=wjGquN7-kQCoa+LHCuiVTjefkk38qwaysd4wLLtoSZhpg@mail.gmail.com>
        <20190429180733.3f25d8b9@gandalf.local.home>
Date:   Tue, 30 Apr 2019 11:24:23 +0200
In-Reply-To: <20190429180733.3f25d8b9@gandalf.local.home> (Steven Rostedt's
        message of "Mon, 29 Apr 2019 18:07:33 -0400")
Message-ID: <87imuv977c.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Steven Rostedt <rostedt@goodmis.org> writes:

> On Mon, 29 Apr 2019 14:38:35 -0700
> Linus Torvalds <torvalds@linux-foundation.org> wrote:
>
>> On Mon, Apr 29, 2019 at 1:30 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>> >
>> > The update from "call custom_trampoline" to "call iterator_trampoline"
>> > is where we have an issue.  
>> 
>> So it has never worked. Just tell people that they have two chocies:
>
> The custom call to iterator translation never worked. One option is to
> always call the iterator, and just take the hit. There's another
> solution to to make permanent updates that would handle the live
> patching case, but not for the tracing case. It is more critical for
> live patching than tracing (missed traced function is not as critical
> as running buggy code unexpectedly). I could look to work on that
> instead.

Making the live patching case permanent would disable tracing of live
patched functions though?

For unconditionally calling the iterator: I don't have numbers, but
would expect that always searching through something like 50-70 live
patching ftrace_ops from some hot path will be noticeable.


> If Nicolai has time, perhaps he can try out the method you suggest and
> see if we can move this forward.

You mean making ftrace handle call->call transitions one by one in
non-batch mode, right? Sure, I can do that.

Another question though: is there anything that prevents us from calling
ftrace_ops_list_func() directly from ftrace_int3_handler()? We don't
have parent_ip, but if that is used for reporting only, maybe setting it
to some ftrace_is_in_int3_and_doesnt_now_the_parent() will work?
Graph tracing entries would still be lost, but well...

Thanks,

Nicolai
