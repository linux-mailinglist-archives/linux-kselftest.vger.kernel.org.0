Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B717E164A44
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Feb 2020 17:27:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726750AbgBSQ1Z (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 19 Feb 2020 11:27:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:56644 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726736AbgBSQ1Y (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 19 Feb 2020 11:27:24 -0500
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 546402465D;
        Wed, 19 Feb 2020 16:27:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582129644;
        bh=xbu9KCqi5HQvIrjHdqTnqNKT56lgpIgY3LJP0AlEXoE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=i6IQMuz+3M02Wha4KwaeamIq8y1VU0FUCBGJtlVUvijeaPRxPGRFk3bHSI06QSDQG
         qDJa8F18PXNn4PxAgzPIGeyoFCx/U3QclfaqSWcfGcaGshCdeqQvo7Nklw0UihdKQ0
         aeRQWIIMg4FzLCtfvDjwJefTZl9xTTVh2Q1syYZQ=
Subject: Re: [PATCH v3 0/4] Implement FUTEX_WAIT_MULTIPLE operation
To:     =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@collabora.com>,
        linux-kernel@vger.kernel.org, tglx@linutronix.de
Cc:     kernel@collabora.com, krisman@collabora.com,
        linux-kselftest@vger.kernel.org, rostedt@goodmis.org,
        ryao@gentoo.org, peterz@infradead.org, dvhart@infradead.org,
        mingo@redhat.com, z.figura12@gmail.com, steven@valvesoftware.com,
        pgriffais@valvesoftware.com, steven@liquorix.net,
        shuah <shuah@kernel.org>
References: <20200213214525.183689-1-andrealmeid@collabora.com>
From:   shuah <shuah@kernel.org>
Message-ID: <f91c0259-e9b3-3209-ee46-f6a066113b2a@kernel.org>
Date:   Wed, 19 Feb 2020 09:27:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200213214525.183689-1-andrealmeid@collabora.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2/13/20 2:45 PM, André Almeida wrote:
> Hello,
> 
> This patchset implements a new futex operation, called FUTEX_WAIT_MULTIPLE,
> which allows a thread to wait on several futexes at the same time, and be
> awoken by any of them.
> 
> The use case lies in the Wine implementation of the Windows NT interface
> WaitMultipleObjects. This Windows API function allows a thread to sleep
> waiting on the first of a set of event sources (mutexes, timers, signal,
> console input, etc) to signal.  Considering this is a primitive
> synchronization operation for Windows applications, being able to quickly
> signal events on the producer side, and quickly go to sleep on the
> consumer side is essential for good performance of those running over Wine.
> 
> Since this API exposes a mechanism to wait on multiple objects, and
> we might have multiple waiters for each of these events, a M->N
> relationship, the current Linux interfaces fell short on performance
> evaluation of large M,N scenarios.  We experimented, for instance, with
> eventfd, which has performance problems discussed below, but we also
> experimented with userspace solutions, like making each consumer wait on
> a condition variable guarding the entire list of objects, and then
> waking up multiple variables on the producer side, but this is
> prohibitively expensive since we either need to signal many condition
> variables or share that condition variable among multiple waiters, and
> then verify for the event being signaled in userspace, which means
> dealing with often false positive wakes ups.
> 
> The natural interface to implement the behavior we want, also
> considering that one of the waitable objects is a mutex itself, would be
> the futex interface.  Therefore, this patchset proposes a mechanism for
> a thread to wait on multiple futexes at once, and wake up on the first
> futex that was awaken.
> 
> In particular, using futexes in our Wine use case reduced the CPU
> utilization by 4% for the game Beat Saber and by 1.5% for the game
> Shadow of Tomb Raider, both running over Proton (a Wine based solution
> for Windows emulation), when compared to the eventfd interface. This
> implementation also doesn't rely of file descriptors, so it doesn't risk
> overflowing the resource.
> 
> In time, we are also proposing modifications to glibc and libpthread to
> make this feature available for Linux native multithreaded applications
> using libpthread, which can benefit from the behavior of waiting on any
> of a group of futexes.
> 
> Technically, the existing FUTEX_WAIT implementation can be easily
> reworked by using futex_wait_multiple() with a count of one, and I
> have a patch showing how it works.  I'm not proposing it, since
> futex is such a tricky code, that I'd be more comfortable to have
> FUTEX_WAIT_MULTIPLE running upstream for a couple development cycles,
> before considering modifying FUTEX_WAIT.
> 
> The patch series includes an extensive set of kselftests validating
> the behavior of the interface.  We also implemented support[1] on
> Syzkaller and survived the fuzzy testing.
> 
> Finally, if you'd rather pull directly a branch with this set you can
> find it here:
> 
> https://gitlab.collabora.com/tonyk/linux/commits/futex-dev-v3
> 
> The RFC for this patch can be found here:
> 
> https://lkml.org/lkml/2019/7/30/1399
> 
> === Performance of eventfd ===
> 
> Polling on several eventfd contexts with semaphore semantics would
> provide us with the exact semantics we are looking for.  However, as
> shown below, in a scenario with sufficient producers and consumers, the
> eventfd interface itself becomes a bottleneck, in particular because
> each thread will compete to acquire a sequence of waitqueue locks for
> each eventfd context in the poll list. In addition, in the uncontended
> case, where the producer is ready for consumption, eventfd still
> requires going into the kernel on the consumer side.
> 
> When a write or a read operation in an eventfd file succeeds, it will try
> to wake up all threads that are waiting to perform some operation to
> the file. The lock (ctx->wqh.lock) that hold the access to the file value
> (ctx->count) is the same lock used to control access the waitqueue. When
> all those those thread woke, they will compete to get this lock. Along
> with that, the poll() also manipulates the waitqueue and need to hold
> this same lock. This lock is specially hard to acquire when poll() calls
> poll_freewait(), where it tries to free all waitqueues associated with
> this poll. While doing that, it will compete with a lot of read and
> write operations that have been waken.
> 
> In our use case, with a huge number of parallel reads, writes and polls,
> this lock is a bottleneck and hurts the performance of applications. Our
> implementation of futex, however, decrease the calls of spin lock by more
> than 80% in some user applications.
> 
> Finally, eventfd operates on file descriptors, which is a limited
> resource that has shown its limitation in our use cases.  Despite the
> Windows interface not waiting on more than 64 objects at once, we still
> have multiple waiters at the same time, and we were easily able to
> exhaust the FD limits on applications like games.
> 
> Thanks,
>      André
> 
> [1] https://github.com/andrealmeid/syzkaller/tree/futex-wait-multiple
> 
> Gabriel Krisman Bertazi (4):
>    futex: Implement mechanism to wait on any of several futexes
>    selftests: futex: Add FUTEX_WAIT_MULTIPLE timeout test
>    selftests: futex: Add FUTEX_WAIT_MULTIPLE wouldblock test
>    selftests: futex: Add FUTEX_WAIT_MULTIPLE wake up test
> 
>   include/uapi/linux/futex.h                    |  20 +
>   kernel/futex.c                                | 358 +++++++++++++++++-
>   .../selftests/futex/functional/.gitignore     |   1 +
>   .../selftests/futex/functional/Makefile       |   3 +-
>   .../futex/functional/futex_wait_multiple.c    | 173 +++++++++
>   .../futex/functional/futex_wait_timeout.c     |  38 +-
>   .../futex/functional/futex_wait_wouldblock.c  |  28 +-
>   .../testing/selftests/futex/functional/run.sh |   3 +
>   .../selftests/futex/include/futextest.h       |  22 ++
>   9 files changed, 639 insertions(+), 7 deletions(-)
>   create mode 100644 tools/testing/selftests/futex/functional/futex_wait_multiple.c
> 

For selftests:

Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah
