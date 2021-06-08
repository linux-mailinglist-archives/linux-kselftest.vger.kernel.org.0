Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2776B39F9E1
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Jun 2021 17:04:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233732AbhFHPGY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Jun 2021 11:06:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233712AbhFHPGX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Jun 2021 11:06:23 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF57DC061574;
        Tue,  8 Jun 2021 08:04:30 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: tonyk)
        with ESMTPSA id 91A511F42CA8
Subject: Re: [PATCH v4 00/15] Add futex2 syscalls
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Nicholas Piggin <npiggin@gmail.com>, acme@kernel.org,
        Andrey Semashev <andrey.semashev@gmail.com>, corbet@lwn.net,
        Davidlohr Bueso <dave@stgolabs.net>,
        Darren Hart <dvhart@infradead.org>, fweimer@redhat.com,
        joel@joelfernandes.org, kernel@collabora.com,
        krisman@collabora.com, libc-alpha@sourceware.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, malteskarupke@fastmail.fm,
        Ingo Molnar <mingo@redhat.com>, pgriffais@valvesoftware.com,
        Peter Oskolkov <posk@posk.io>,
        Steven Rostedt <rostedt@goodmis.org>, shuah@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, z.figura12@gmail.com,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
References: <20210603195924.361327-1-andrealmeid@collabora.com>
 <1622799088.hsuspipe84.astroid@bobo.none>
 <fb85fb20-5421-b095-e68b-955afa105467@collabora.com>
 <1622853816.mokf23xgnt.astroid@bobo.none>
 <22137ccd-c5e6-9fcc-a176-789558e9ab1e@collabora.com>
 <20210608122622.oxf662ruaawrtyrd@linutronix.de>
 <YL99cR0H+7xgU8L1@hirez.programming.kicks-ass.net>
From:   =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@collabora.com>
Message-ID: <7ab1a38e-5ba6-843d-9fa8-7480914c3d15@collabora.com>
Date:   Tue, 8 Jun 2021 12:04:18 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <YL99cR0H+7xgU8L1@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Às 11:23 de 08/06/21, Peter Zijlstra escreveu:
> On Tue, Jun 08, 2021 at 02:26:22PM +0200, Sebastian Andrzej Siewior wrote:
>> On 2021-06-07 12:40:54 [-0300], André Almeida wrote:
>>>
>>> When I first read Thomas proposal for per table process, I thought that
>>> the main goal there was to solve NUMA locality issues, not RT latency,
>>> but I think you are right. However, re-reading the thread at [0], it
>>> seems that the RT problems where not completely solved in that
>>> interface, maybe the people involved with that patchset can help to shed
>>> some light on it.
>>>
>>> Otherwise, this same proposal could be integrated in futex2, given that
>>> we would only need to provide to userland some extra flags and add some
>>> `if`s around the hash table code (in a very similar way the NUMA code
>>> will be implemented in futex2).
>>
>> There are slides at [0] describing some attempts and the kernel tree [1]
>> from that time.
>>
>> The process-table solves the problem to some degree that two random
>> process don't collide on the same hash bucket. But as Peter Zijlstra
>> pointed out back then two threads from the same task could collide on
>> the same hash bucket (and with ASLR not always). So the collision is
>> there but limited and this was not perfect.
>>
>> All the attempts with API extensions didn't go well because glibc did
>> not want to change a bit. This starts with a mutex that has a static
>> initializer which has to work (I don't remember why the first
>> pthread_mutex_lock() could not fail with -ENOMEM but there was
>> something) and ends with glibc's struct mutex which is full and has no
>> room for additional data storage.
>>
>> The additional data in user's struct mutex + init would have the benefit
>> that instead uaddr (which is hashed for the in-kernel lookup) a cookie
>> could be used for the hash-less lookup (and NUMA pointer where memory
>> should be stored).
>>
>> So. We couldn't change a thing back then so nothing did happen. We
>> didn't want to create a new interface and a library implementing it plus
>> all the functionality around it (like pthread_cond, phtread_barrier, …).
>> Not to mention that if glibc continues to use the "old" locking
>> internally then the application is still affected by the hash-collision
>> locking (or the NUMA problem) should it block on the lock.
> 
> There's more futex users than glibc, and some of them are really hurting
> because of the NUMA issue. Oracle used to (I've no idea what they do or
> do not do these days) use sysvsem because the futex hash table was a
> massive bottleneck for them.
> 
> And as Nick said, other vendors are having the same problems.

Since we're talking about NUMA, which userspace communities would be
able to provide feedback about the futex2() NUMA-aware feature, to check
if this interface would help solving those issues?

> 
> And if you don't extend the futex to store the nid you put the waiter in
> (see all the problems above) you will have to do wakeups on all nodes,
> which is both slower than it is today, and scales possibly even worse.
> 
> The whole numa-aware qspinlock saga is in part because of futex.
> 
> 
> That said; if we're going to do the whole futex-vector thing, we really
> do need a new interface, because the futex multiplex monster is about to
> crumble (see the fun wrt timeouts for example).
> 
> And if we're going to do a new interface, we ought to make one that can
> solve all these problems. Now, ideally glibc will bring forth some
> opinions, but if they don't want to play, we'll go back to the good old
> days of non-standard locking libraries.. we're halfway there already due
> to glibc not wanting to break with POSIX were we know POSIX was just
> dead wrong broken.
> 
> See: https://github.com/dvhart/librtpi
> 
> 
