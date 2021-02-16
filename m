Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D71E631D282
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Feb 2021 23:13:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230348AbhBPWNl convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 16 Feb 2021 17:13:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229985AbhBPWNg (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 16 Feb 2021 17:13:36 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95F40C06174A;
        Tue, 16 Feb 2021 14:12:56 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 93B4E1F4491A
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     =?utf-8?Q?Andr=C3=A9?= Almeida <andrealmeid@collabora.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Darren Hart <dvhart@infradead.org>,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        kernel@collabora.com, pgriffais@valvesoftware.com,
        z.figura12@gmail.com, joel@joelfernandes.org,
        malteskarupke@fastmail.fm, linux-api@vger.kernel.org,
        fweimer@redhat.com, libc-alpha@sourceware.org,
        linux-kselftest@vger.kernel.org, shuah@kernel.org, acme@kernel.org,
        corbet@lwn.net
Subject: Re: [RFC PATCH 01/13] futex2: Implement wait and wake functions
Organization: Collabora
References: <20210215152404.250281-1-andrealmeid@collabora.com>
        <20210215152404.250281-2-andrealmeid@collabora.com>
        <YCuWvlKRXAygNQZP@hirez.programming.kicks-ass.net>
Date:   Tue, 16 Feb 2021 17:12:51 -0500
In-Reply-To: <YCuWvlKRXAygNQZP@hirez.programming.kicks-ass.net> (Peter
        Zijlstra's message of "Tue, 16 Feb 2021 10:56:14 +0100")
Message-ID: <87h7mb64rg.fsf@collabora.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Peter Zijlstra <peterz@infradead.org> writes:

> On Mon, Feb 15, 2021 at 12:23:52PM -0300, André Almeida wrote:
>> Create a new set of futex syscalls known as futex2. This new interface
>> is aimed to implement a more maintainable code, while removing obsolete
>> features and expanding it with new functionalities.
>> 
>> Implements wait and wake semantics for futexes, along with the base
>> infrastructure for future operations.
>
>> +	futex_table = alloc_large_system_hash("futex2", sizeof(struct futex_bucket),
>> +					      futex2_hashsize, 0,
>> +					      futex2_hashsize < 256 ? HASH_SMALL : 0,
>> +					      &futex_shift, NULL,
>> +					      futex2_hashsize, futex2_hashsize);
>
> So why are we implementing a whole second infrastrure and doubling the
> memory footprint of all this?
>
> Sure, futex.c is a pain in the ass, but most of that is not because of
> the interface, most of it is having to deal with sharing state with
> userspace and that being fundamentally unreliable.
>
> Once you want to add {,UN}LOCK{,_PI} and robust futex support, you're
> back to it being a giant rats nest of corner cases. Thinking a new
> interface can solve any of that is naive.
>
> So while I'm in favour of adding a new interface, I'm not sure I see
> benefit of reimplementing the basics, sure it seems simpler now, but
> that's because you've not implemented all the 'fun' stuff.

Peter,

I think there was a question of how we'd introduce this new interface,
since the community is wary of introducing new features in the original
futex code.  The approach we discussed in the last LPC was writing a new
code from scratch that could even sit on the RT tree while it get
stabilized.

The code base duplication, and - perhaps more importantly - the double
memory footprint is bad, for sure.  But considering this implementation
modifies what is enqueued to separate the waiter structure from its
(potentially multiple) keys, we'd be looking at large changes in the
original futex code, which doesn't seem (as it should be) welcome by the
community. At least this feedback was the reason we started working on
futex2.

So, my question is, how else should we present this interface, if not in
a new code base?  If it is just a matter of integrating it into the
original code, I'd go back and ask why this new interface was made a
prerequisite for the futex wait multiple patches André originally wanted
to merge?  For sure, the multiplexing interface is not the sole reason
that stopped that work from being accepted.  The bigger goal was not
increasing the mess and not causing new bugs in the existing overcomplex
futex implementation.

Regarding NUMA support, I wouldn't expect André to implement all other
features before getting something upstreamable in the list.  His
interest in futex is directed at solving the multiple wait problem, but
consider he has already gone way beyond that by re-implementing the
basics of a new interface.  Collabora is willing to do the heavy lifting
necessary (within reason) on this patchset to get something the
community accepts, including NUMA support, provided we also get
semantics to fix the problem we are trying to solve.  But for that, we
gonna need more directioning on what the community is willing to accept
not only regarding the interface, but on internals too.

-- 
Gabriel Krisman Bertazi
