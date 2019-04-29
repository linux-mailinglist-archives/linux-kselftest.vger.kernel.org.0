Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E1C06EBA6
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Apr 2019 22:30:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729316AbfD2Uat (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 29 Apr 2019 16:30:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:44326 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729252AbfD2Uas (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 29 Apr 2019 16:30:48 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6EAB1215EA;
        Mon, 29 Apr 2019 20:30:45 +0000 (UTC)
Date:   Mon, 29 Apr 2019 16:30:43 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
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
Subject: Re: [PATCH 3/4] x86/ftrace: make ftrace_int3_handler() not to skip
 fops invocation
Message-ID: <20190429163043.535f4272@gandalf.local.home>
In-Reply-To: <CAHk-=wgbC-wiSrdDYAh1ORF4EKmecY+MkNsJBF=BWf4W1bXXgA@mail.gmail.com>
References: <20190427100639.15074-1-nstange@suse.de>
        <20190427100639.15074-4-nstange@suse.de>
        <20190427102657.GF2623@hirez.programming.kicks-ass.net>
        <20190428133826.3e142cfd@oasis.local.home>
        <CAHk-=wh5OpheSU8Em_Q3Hg8qw_JtoijxOdPtHru6d+5K8TWM=A@mail.gmail.com>
        <20190429145250.1a5da6ed@gandalf.local.home>
        <CAHk-=wjm93jLtVxTX4HZs6K4k1Wqh3ujjmapqaYtcibVk_YnzQ@mail.gmail.com>
        <20190429150724.6e501d27@gandalf.local.home>
        <CAHk-=wgbC-wiSrdDYAh1ORF4EKmecY+MkNsJBF=BWf4W1bXXgA@mail.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, 29 Apr 2019 13:06:17 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Mon, Apr 29, 2019 at 12:07 PM Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > Are you suggesting that I rewrite the code to do it one function at a
> > time? This has always been batch mode. This is not something new. The
> > function tracer has been around longer than the text poke code.  
> 
> Only do the 'call' instructions one at a time. Why would you change
> _existing_ code?

The function tracing is a call instruction.

On boot:

<function_X>:
	nop
	blah
	blah

After a callback to function tracing is called:

<function_X>
	call custom_trampoline
	blah
	blah


If we have two functions to that function added:

<function_X>
	call iterator_trampoline
	blah
	blah

The update from "call custom_trampoline" to "call iterator_trampoline"
is where we have an issue.

We could make this a special case where we do this one at a time, but
currently the code is all the same looking at tables to determine to
what to do. Which is one of three:

 1) change nop to call function
 2) change call function to nop
 3) update call function to another call function

#3 is where we have an issue. But if we want this to be different, we
would need to change the code significantly, and know that we are only
updating calls to calls. Which would take a bit of accounting to see if
that's the change that is being made.

This thread started about that #3 operation causing a call to be missed
because we turn it into a nop while we make the transition, where in
reality it needs to be a call to one of the two functions in the
transition.

-- Steve
