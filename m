Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C61117AA51
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Mar 2020 17:17:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726128AbgCEQRB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 5 Mar 2020 11:17:01 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:56738 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725974AbgCEQRB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 5 Mar 2020 11:17:01 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: tonyk)
        with ESMTPSA id 19154296C97
Subject: Re: 'simple' futex interface [Was: [PATCH v3 1/4] futex: Implement
 mechanism to wait on any of several futexes]
To:     Peter Zijlstra <peterz@infradead.org>,
        Florian Weimer <fweimer@redhat.com>
Cc:     "Pierre-Loup A. Griffais" <pgriffais@valvesoftware.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        krisman@collabora.com, shuah@kernel.org,
        linux-kselftest@vger.kernel.org, rostedt@goodmis.org,
        ryao@gentoo.org, dvhart@infradead.org, mingo@redhat.com,
        z.figura12@gmail.com, steven@valvesoftware.com,
        steven@liquorix.net, malteskarupke@web.de, carlos@redhat.com,
        adhemerval.zanella@linaro.org, libc-alpha@sourceware.org,
        linux-api@vger.kernel.org
References: <20200228190717.GM18400@hirez.programming.kicks-ass.net>
 <20200228194958.GO14946@hirez.programming.kicks-ass.net>
 <87tv3aflqm.fsf@nanos.tec.linutronix.de>
 <967d5047-2cb6-d6d8-6107-edb99a4c9696@valvesoftware.com>
 <87o8thg031.fsf@nanos.tec.linutronix.de>
 <beb82055-96fa-cb64-a06e-9d7a0946587b@valvesoftware.com>
 <20200303120050.GC2596@hirez.programming.kicks-ass.net>
 <87pndth9ur.fsf@oldenburg2.str.redhat.com>
 <20200303132150.GD2596@hirez.programming.kicks-ass.net>
 <878skhh7og.fsf@oldenburg2.str.redhat.com>
 <20200303150104.GE2596@hirez.programming.kicks-ass.net>
From:   =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@collabora.com>
Message-ID: <52406c54-60b3-dcfe-65d8-4c425459e37b@collabora.com>
Date:   Thu, 5 Mar 2020 13:14:17 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200303150104.GE2596@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 3/3/20 12:01 PM, Peter Zijlstra wrote:
> On Tue, Mar 03, 2020 at 02:47:11PM +0100, Florian Weimer wrote:
>> (added missing Cc: for linux-api, better late than never I guess)
>>
>> * Peter Zijlstra:
>>
>>>> What's the actual type of *uaddr?  Does it vary by size (which I assume
>>>> is in bits?)?  Are there alignment constraints?
>>>
>>> Yeah, u8, u16, u32, u64 depending on the size specified in flags.
>>> Naturally aligned.
>>
>> So 4-byte alignment for u32 and 8-byte alignment for u64 on all
>> architectures?
>>
>> (I really want to nail this down, sorry.)
> 
> Exactly so.
> 
>>>> These system calls seemed to be type-polymorphic still, which is
>>>> problematic for defining a really nice C interface.  I would really like
>>>> to have a strongly typed interface for this, with a nice struct futex
>>>> wrapper type (even if it means that we need four of them).
>>>
>>> You mean like: futex_wait1(u8 *,...) futex_wait2(u16 *,...)
>>> futex_wait4(u32 *,...) etc.. ?
>>>
>>> I suppose making it 16 or so syscalls (more if we want WAKE_OP or
>>> requeue across size) is a bit daft, so yeah, sucks.
>>
>> We could abstract this in the userspace wrapper.  It would help to have
>> an explicit size argument, or at least an extension-safe way to pass
>> this information to the kernel.  I guess if everything else fails, we
>> could use the flags bits for that, as long as it is clear that the
>> interface will only support these six types (four without NUMA, two with
>> NUMA).
> 
> The problem is the cmp_requeue syscall, that already has 6 arguments. I
> don't see where else than the flags field we can stuff this :/
> 
>>>> Will all architectures support all sizes?  If not, how do we probe which
>>>> size/flags combinations are supported?
>>>
>>> Up to the native word size (long), IOW ILP32 will not support u64.
>>
>> Many ILP32 targets could support atomic accesses on 8-byte storage
>> units, as long as there is 8-byte alignment.  But given how common
>> 4-byte-align u64 is on 32-bit, maybe that's not such a good idea.
> 
> 'Many' might be over-stating it, but yeah, there are definitely a bunch
> of them that can do it (x86, armv7-lpae, arc, are the ones I know from
> memory). The problem is that the syscalls then look like:
> 
>   sys_futex_wait(void *uaddr, u64 val, unsigned long flags, ktime_t *timo);
>   struct futex_wait {
> 	  void *uaddr;
> 	  u64 val;
> 	  u64 flags;
>   };
>   sys_futex_waitv(struct futex_wait *waiters, unsigned int nr_waiters,
> 		  u64 flags, ktime_t *timo);
>   sys_futex_wake(void *uaddr, unsigned int nr, u64 flags);
>   sys_futex_cmp_requeue(void *uaddr1, void *uaddr2, unsigned int nr_wake,
> 		  unsigned int nr_requeue, u64 cmpval, unsigned long flags);
> 
> And that makes 7 arguments for cmp_requeue, which can't be. Maybe we if
> combine nr_wake and nr_requeue in one as 2 u16... ?
> 
> And then we need to go detector if the platform supports it or not..
> 

Thanks everyone for the feedback around our mechanism. Are the
performance benefits of implementing a syscall to wait on a single futex
significant enough to maintain it instead of just using
`sys_futex_waitv()` with `nr_waiters = 1`? If we join both cases in a
single interface, we may even add a new member for NUMA hint in `struct
futex_wait`.

>>>>> For NUMA I propose that when NUMA_FLAG is set, uaddr-4 will be 'int
>>>>> node_id', with the following semantics:
>>>>>
>>>>>  - on WAIT, node_id is read and when 0 <= node_id <= nr_nodes, is
>>>>>    directly used to index into per-node hash-tables. When -1, it is
>>>>>    replaced by the current node_id and an smp_mb() is issued before we
>>>>>    load and compare the @uaddr.
>>>>>
>>>>>  - on WAKE/REQUEUE, it is an immediate index.
>>>>
>>>> Does this mean the first waiter determines the NUMA index, and all
>>>> future waiters use the same chain even if they are on different nodes?
>>>
>>> Every new waiter could (re)set node_id, after all, when its not actually
>>> waiting, nobody cares what's in that field.
>>>
>>>> I think documenting this as a node index would be a mistake.  It could
>>>> be an arbitrary hint for locating the corresponding kernel data
>>>> structures.
>>>
>>> Nah, it allows explicit placement, after all, we have set_mempolicy()
>>> and sched_setaffinity() and all the other NUMA crud so that programs
>>> that think they know what they're doing, can do explicit placement.
>>
>> But I'm not sure if it makes sense to read the node ID from the
>> neighboring value of a futex used in this way.  Or do you think that
>> userspace might set the node ID to help the kernel implementation, and
>> not just relying on it to be set by the kernel after initializing it to
>> -1?
> 
> I'm fairly sure that there will be a number of users that will
> definitely want to do that; this would be the same people that use
> set_mempolicy() and sched_setaffinity() and do all the other numa
> binding crud.
> 
> HPC, certain database vendors, possibly RT and KVM users.
> 
>> Conversely, even for non-NUMA systems, a lookup hint that allows to
>> reduce in-kernel futex contention might be helpful.  If it's documented
>> to be the NUME node ID, that wouldn't be possible.
> 
> Do we really have significant contention on small systems? And how would
> increasing the hash-table not solve that?
> 
>>>>> Any invalid value with result in EINVAL.
>>>>
>>>> Using uaddr-4 is slightly tricky with a 64-bit futex value, due to the
>>>> need to maintain alignment and avoid padding.
>>>
>>> Yes, but it works, unlike uaddr+4 :-) Also, 1 and 2 byte futexes and
>>> NUMA_FLAG are incompatible due to this, but I feel short futexes and
>>> NUMA don't really make sense anyway, the only reason to use a short
>>> futex is to save space, so you don't want another 4 bytes for numa on
>>> top of that anyway.
>>
>> I think it would be much easier to make the NUMA hint the same size of
>> the futex, so 4 and 8 bytes.  It could also make sense to require 8 and
>> 16 byte alignment, to permit different implementation choices in the
>> future.
>>
>> So we'd have:
>>
>> struct futex8  { u8 value; };
>> struct futex16 { u16 value __attribute__ ((aligned (2))); };
>> struct futex32 { u32 value __attribute__ ((aligned (4))); };
>> struct futex64 { u64 value __attribute__ ((aligned (8))); };
>> struct futex32_numa { u32 value __attribute__ ((aligned (8))); u32 hint; };
>> struct futex64_numa { u64 value __attribute__ ((aligned (16))); u64 hint; };
> 
> That works, I suppose... although I'm sure someone will curse us for it
> when trying to pack some extra things in his cacheline.
>
