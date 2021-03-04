Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C07E132D9D9
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Mar 2021 20:00:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235873AbhCDS7A (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 4 Mar 2021 13:59:00 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:54832 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236077AbhCDS65 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 4 Mar 2021 13:58:57 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: tonyk)
        with ESMTPSA id 481E91F46675
Subject: Re: [RFC PATCH v2 00/13] Add futex2 syscall
To:     Peter Oskolkov <posk@posk.io>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        kernel@collabora.com, krisman@collabora.com,
        pgriffais@valvesoftware.com, z.figura12@gmail.com,
        joel@joelfernandes.org, malteskarupke@fastmail.fm,
        linux-api@vger.kernel.org, fweimer@redhat.com,
        libc-alpha@sourceware.org, linux-kselftest@vger.kernel.org,
        shuah@kernel.org, acme@kernel.org, Jonathan Corbet <corbet@lwn.net>
References: <20210304004219.134051-1-andrealmeid@collabora.com>
 <CAFTs51XAr2b3DmcSM4=qeU5cNuh0mTxUbhG66U6bc63YYzkzYA@mail.gmail.com>
From:   =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@collabora.com>
Message-ID: <bc54423b-753f-44be-4e4f-4535e27ad35c@collabora.com>
Date:   Thu, 4 Mar 2021 15:58:07 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <CAFTs51XAr2b3DmcSM4=qeU5cNuh0mTxUbhG66U6bc63YYzkzYA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Peter,

Às 02:44 de 04/03/21, Peter Oskolkov escreveu:
> On Wed, Mar 3, 2021 at 5:22 PM André Almeida <andrealmeid@collabora.com> wrote:
>>
>> Hi,
>>
>> This patch series introduces the futex2 syscalls.
>>
>> * FAQ
>>
>>   ** "And what's about FUTEX_64?"
>>
>>   By supporting 64 bit futexes, the kernel structure for futex would
>>   need to have a 64 bit field for the value, and that could defeat one of
>>   the purposes of having different sized futexes in the first place:
>>   supporting smaller ones to decrease memory usage. This might be
>>   something that could be disabled for 32bit archs (and even for
>>   CONFIG_BASE_SMALL).
>>
>>   Which use case would benefit for FUTEX_64? Does it worth the trade-offs?
> 
> The ability to store a pointer value on 64bit platforms is an
> important use case.
> Imagine a simple producer/consumer scenario, with the producer updating
> some shared memory data and waking the consumer. Storing the pointer
> in the futex makes it so that only one shared memory location needs to be
> accessed "atomically", etc. With two atomics synchronization becomes
> more involved (= slower).
> 

So the idea is to, instead of doing this:

T1:
atomic_set(&shm_addr, buffer_addr);
atomic_set(&futex, 0);
futex_wake(&futex, 1);

T2:
consume(shm_addr);

To do that:

T1:
atomic_set(&futex, buffer_addr);
futex_wake(&futex, 1);

T2:
consume(futex);

Right?

I'll try to write a small test to see how the perf numbers looks like.
