Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 703323755E4
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 May 2021 16:48:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234919AbhEFOtr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 6 May 2021 10:49:47 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:39838 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234759AbhEFOtq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 6 May 2021 10:49:46 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: tonyk)
        with ESMTPSA id 13DDA1F439BE
Subject: Re: [PATCH v3 00/13] Add futex2 syscalls
To:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Darren Hart <dvhart@infradead.org>,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        kernel@collabora.com, krisman@collabora.com,
        pgriffais@valvesoftware.com, z.figura12@gmail.com,
        joel@joelfernandes.org, malteskarupke@fastmail.fm,
        linux-api@vger.kernel.org, fweimer@redhat.com,
        libc-alpha@sourceware.org, linux-kselftest@vger.kernel.org,
        shuah@kernel.org, acme@kernel.org, corbet@lwn.net,
        Peter Oskolkov <posk@posk.io>
References: <20210427231248.220501-1-andrealmeid@collabora.com>
 <YJKQLkHuTH3EWJoR@hirez.programming.kicks-ass.net>
 <87bl9pi7if.ffs@nanos.tec.linutronix.de>
From:   =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@collabora.com>
Message-ID: <36e6951e-e7a9-5e82-200e-17668f02447f@collabora.com>
Date:   Thu, 6 May 2021 11:48:36 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <87bl9pi7if.ffs@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Thomas, Peter,

Às 11:23 de 05/05/21, Thomas Gleixner escreveu:
> On Wed, May 05 2021 at 14:31, Peter Zijlstra wrote:
> 
>> On Tue, Apr 27, 2021 at 08:12:35PM -0300, André Almeida wrote:
>>> Hi,
>>>
>>> This patch series introduces the futex2 syscalls.
>>
>> I still utterly detest that this adds a second hash-table for no
>> descernable reason.
>>
>> The new syscall interface does not depend on that in any way, you
>> previously implemented the multi-wait thing in the current futex code.
>>
>> Like I said last time; I'm okay with the new interface, but I don't see
>> why you need to reimplement the insides, that's all pointless code
>> duplication.
> 
> The real question is whether we really need to model all of this along
> the existing futex functionality. I wouldn't mind a new infrastructure
> which addresses all the other known issues of futexes and makes the
> overall design less horrible than what we have now.
> 

Thank you for the feedback. I think we are completing another full 
circle on the proposals. I've proposed a futex2 interface that would use 
the current futex infrastructure[0], but my understanding is that this 
is discouraged given it needs to do big changes in the current futex 
code. Given that, I proceeded with developing a new code for futex2, 
taking in consideration those new use cases (waitv, NUMA, sizes) and 
known issues.

As you know, my original goal with this work is to have a native and 
efficient way to wait on multiple objects. Right now, we've proposed it 
in three different ways, but so far none had much success in being 
merged. Of course, I want to take the approach that better fits the 
community goals, as this patchset suggests - a work that goes away 
further than just implementing a multi-wait feature. But for the benefit 
of not walking in circles, what we need back is a clear direction, in 
order to proceed that.

> But that needs input from futex users (libraries and other horrible
> wrappers) to figure out what they really need, hate, like or do not care
> about.
> 

I think it's clear the use case for "wait on multiple" as a way to 
emulate WinAPI and for Linux native loads like game engines is valid. 
We have been running it in the field with success for the past year or 
so. I'm also working with userspace communities to get a better sense of 
how this and other features would work in the real world. You can read 
an example of that effort with Chromium developers at [1], and there are 
more to come.

Maybe support for multiple futexes and futex2 are disjoint things? The 
multi-wait can be achieved through a (somewhat) simple implementation, 
on the old interface or in a new one, while for futex2 we are still 
unsure about how it should look like and its blocking this feature.

> Without that we are bound to pile more crap on the existing pile of
> horrors forever.
> 
> Thanks,
> 
>          tglx
> 

Thanks,
	André

[0] 
https://lore.kernel.org/lkml/20200612185122.327860-2-andrealmeid@collabora.com/
[1] https://groups.google.com/a/chromium.org/g/chromium-dev/c/5hpH3ckr6_Y
