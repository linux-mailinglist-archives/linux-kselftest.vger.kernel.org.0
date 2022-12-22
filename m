Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEDBB65443C
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Dec 2022 16:24:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235744AbiLVPYc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 22 Dec 2022 10:24:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235859AbiLVPYD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 22 Dec 2022 10:24:03 -0500
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1585A2876B;
        Thu, 22 Dec 2022 07:22:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1671722572;
        bh=9/RZc8hItgYv0kbP4q13dwNAEruOD5Qq/7GVoy+1Npo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=toi6pcBQ6wUUoEsOIAWjMUlzQP1+QdyALb2jqEwcHna0MheXeJ6hWSnDP8YeDRlu2
         jAVl7zqCow/EKp9t7UlhTuuLYCOhR0LIEpH/VHiuR4iH4qJ1WEAueFoJaC+1DLW5QA
         khagBg/XwimmlcjPRnlLI/QCQODB1G1o6hWqk3gOFEwrWwQ9WA+pOIDA73Yt4pwBzY
         E4fNeERWyG+PJocl/Mbtx7P64kbqYDh3mC4jCXk8+PiKcw3eRa22pPHgx6HJVKJeoC
         3lnURZKliRs6T2S+HAQGlv4bj6JGi0nbpyeEreVtgq9UM0p5VpjgRf/3o584FAcZik
         ABlkVEptcLInQ==
Received: from [10.1.0.30] (192-222-188-97.qc.cable.ebox.net [192.222.188.97])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4NdDb02CJWzbWh;
        Thu, 22 Dec 2022 10:22:52 -0500 (EST)
Message-ID: <0da8f3df-afb8-33e9-f90a-834fac0673e4@efficios.com>
Date:   Thu, 22 Dec 2022 10:23:17 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 1/2] sched/membarrier: Introduce
 MEMBARRIER_CMD_GET_REGISTRATIONS
Content-Language: en-US
To:     =?UTF-8?B?TWljaGHFgiBDxYJhcGnFhHNraQ==?= <mclapinski@google.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrei Vagin <avagin@gmail.com>, Shuah Khan <shuah@kernel.org>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20221207164338.1535591-1-mclapinski@google.com>
 <20221207164338.1535591-2-mclapinski@google.com>
 <843af7b5-8917-e9e3-de27-cb328f53fb70@efficios.com>
 <CAAi7L5eVa-KFxG5DLrFXbEdVx-CxLLPzg_kPE9OLa3mkrV+AjQ@mail.gmail.com>
 <CAAi7L5cRRbT=N1TmMc+SVnym7UOgD+2F=Skjzx=7CbUoyCzUhw@mail.gmail.com>
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <CAAi7L5cRRbT=N1TmMc+SVnym7UOgD+2F=Skjzx=7CbUoyCzUhw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2022-12-20 12:51, Michał Cłapiński wrote:
> On Wed, Dec 7, 2022 at 7:04 PM Michał Cłapiński <mclapinski@google.com> wrote:
>>
>> On Wed, Dec 7, 2022 at 6:07 PM Mathieu Desnoyers
>> <mathieu.desnoyers@efficios.com> wrote:
>>>
>>> On 2022-12-07 11:43, Michal Clapinski wrote:
>>>> Provide a method to query previously issued registrations.
>>>>
>>>> Signed-off-by: Michal Clapinski <mclapinski@google.com>
>>>> ---
>>>>    include/uapi/linux/membarrier.h |  4 ++++
>>>>    kernel/sched/membarrier.c       | 39 ++++++++++++++++++++++++++++++++-
>>>>    2 files changed, 42 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/include/uapi/linux/membarrier.h b/include/uapi/linux/membarrier.h
>>>> index 737605897f36..5f3ad6d5be6f 100644
>>>> --- a/include/uapi/linux/membarrier.h
>>>> +++ b/include/uapi/linux/membarrier.h
>>>> @@ -137,6 +137,9 @@
>>>>     * @MEMBARRIER_CMD_SHARED:
>>>>     *                          Alias to MEMBARRIER_CMD_GLOBAL. Provided for
>>>>     *                          header backward compatibility.
>>>> + * @MEMBARRIER_CMD_GET_REGISTRATIONS:
>>>> + *                          Returns a bitmask of previously issued
>>>> + *                          registration commands.
>>>>     *
>>>>     * Command to be passed to the membarrier system call. The commands need to
>>>>     * be a single bit each, except for MEMBARRIER_CMD_QUERY which is assigned to
>>>> @@ -153,6 +156,7 @@ enum membarrier_cmd {
>>>>        MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED_SYNC_CORE     = (1 << 6),
>>>>        MEMBARRIER_CMD_PRIVATE_EXPEDITED_RSEQ                   = (1 << 7),
>>>>        MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED_RSEQ          = (1 << 8),
>>>> +     MEMBARRIER_CMD_GET_REGISTRATIONS                        = (1 << 9),
>>
>> Btw. I could do this as a flag to MEMBARRIER_CMD_QUERY instead of a
>> separate command. Would that be preferable?

I do not think that would be better, no. We can keep it with 
GET_REGISTRATIONS.

>>
>>
>>>>
>>>>        /* Alias for header backward compatibility. */
>>>>        MEMBARRIER_CMD_SHARED                   = MEMBARRIER_CMD_GLOBAL,
>>>> diff --git a/kernel/sched/membarrier.c b/kernel/sched/membarrier.c
>>>> index 0c5be7ebb1dc..2ad881d07752 100644
>>>> --- a/kernel/sched/membarrier.c
>>>> +++ b/kernel/sched/membarrier.c
>>>> @@ -159,7 +159,8 @@
>>>>        | MEMBARRIER_CMD_PRIVATE_EXPEDITED                              \
>>>>        | MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED                     \
>>>>        | MEMBARRIER_PRIVATE_EXPEDITED_SYNC_CORE_BITMASK                \
>>>> -     | MEMBARRIER_PRIVATE_EXPEDITED_RSEQ_BITMASK)
>>>> +     | MEMBARRIER_PRIVATE_EXPEDITED_RSEQ_BITMASK                     \
>>>> +     | MEMBARRIER_CMD_GET_REGISTRATIONS)
>>>>
>>>>    static void ipi_mb(void *info)
>>>>    {
>>>> @@ -540,6 +541,40 @@ static int membarrier_register_private_expedited(int flags)
>>>>        return 0;
>>>>    }
>>>>
>>>> +static int membarrier_get_registrations(void)
>>>> +{
>>>> +     struct task_struct *p = current;
>>>> +     struct mm_struct *mm = p->mm;
>>>> +     int registrations_mask = 0, membarrier_state, i;
>>>> +     static const int states[] = {
>>>> +             MEMBARRIER_STATE_GLOBAL_EXPEDITED |
>>>> +                     MEMBARRIER_STATE_GLOBAL_EXPEDITED_READY,
>>>
>>> What is the purpose of checking for the _READY state flag as well here ?
>>
>> Answered below.
>>
>>
>>>
>>>
>>>> +             MEMBARRIER_STATE_PRIVATE_EXPEDITED |
>>>> +                     MEMBARRIER_STATE_PRIVATE_EXPEDITED_READY,
>>>> +             MEMBARRIER_STATE_PRIVATE_EXPEDITED_SYNC_CORE |
>>>> +                     MEMBARRIER_STATE_PRIVATE_EXPEDITED_SYNC_CORE_READY,
>>>> +             MEMBARRIER_STATE_PRIVATE_EXPEDITED_RSEQ |
>>>> +                     MEMBARRIER_STATE_PRIVATE_EXPEDITED_RSEQ_READY
>>>> +     };
>>>> +     static const int registration_cmds[] = {
>>>> +             MEMBARRIER_CMD_REGISTER_GLOBAL_EXPEDITED,
>>>> +             MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED,
>>>> +             MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED_SYNC_CORE,
>>>> +             MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED_RSEQ
>>>> +     };
>>>> +     BUILD_BUG_ON(ARRAY_SIZE(states) != ARRAY_SIZE(registration_cmds));
>>>> +
>>>> +     membarrier_state = atomic_read(&mm->membarrier_state);
>>>> +     for (i = 0; i < ARRAY_SIZE(states); ++i) {
>>>> +             if (membarrier_state & states[i]) {
>>>
>>> The mask will match if either of the flags to match are set. Is that
>>> your intent ?
>>
>> Kind of, it was just the easiest to write. As explained in the cover
>> letter, I don't really care much about the result of this while the
>> process is running. And when the process is frozen, either state and
>> state_ready are set or none of them.

OK

>>
>>
>>>
>>>
>>>> +                     registrations_mask |= registration_cmds[i];
>>>> +                     membarrier_state &= ~states[i];
>>>
>>> So I understand that those _READY flags are there purely for making sure
>>> we clear the membarrier_state for validation that they have all been
>>> checked with the following WARN_ON_ONCE(). Am I on the right track ?
>>
>> Yes, exactly. It wastes time but I'm worried about people adding new
>> states and not updating this function. A suggestion on how to do this
>> better (especially at compile time) would be greatly appreciated.

Although it's not a fast-path, so let's keep it this way for now.

>>
>>
>>>
>>>> +             }
>>>> +     }
>>>> +     WARN_ON_ONCE(membarrier_state != 0);
>>>
>>> Thanks,
>>>
>>> Mathieu
>>>
>>>> +     return registrations_mask;
>>>> +}
>>>> +
>>>>    /**
>>>>     * sys_membarrier - issue memory barriers on a set of threads
>>>>     * @cmd:    Takes command values defined in enum membarrier_cmd.
>>>> @@ -623,6 +658,8 @@ SYSCALL_DEFINE3(membarrier, int, cmd, unsigned int, flags, int, cpu_id)
>>>>                return membarrier_private_expedited(MEMBARRIER_FLAG_RSEQ, cpu_id);
>>>>        case MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED_RSEQ:
>>>>                return membarrier_register_private_expedited(MEMBARRIER_FLAG_RSEQ);
>>>> +     case MEMBARRIER_CMD_GET_REGISTRATIONS:
>>>> +             return membarrier_get_registrations();
>>>>        default:
>>>>                return -EINVAL;
>>>>        }
>>>
>>> --
>>> Mathieu Desnoyers
>>> EfficiOS Inc.
>>> https://www.efficios.com
>>>
> 
> Hi Mathieu,
> is there anything more you need from my side?

No, I think those patches are ok.

Thanks,

Mathieu





-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

