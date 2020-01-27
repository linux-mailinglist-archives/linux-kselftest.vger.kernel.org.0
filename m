Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 942DD14AA9F
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Jan 2020 20:39:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726240AbgA0TjT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 27 Jan 2020 14:39:19 -0500
Received: from mail.efficios.com ([167.114.26.124]:42062 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725845AbgA0TjT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 27 Jan 2020 14:39:19 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 903EB26182F;
        Mon, 27 Jan 2020 14:39:16 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id BuZ1mzTj8K_8; Mon, 27 Jan 2020 14:39:16 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 1167326182E;
        Mon, 27 Jan 2020 14:39:16 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 1167326182E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1580153956;
        bh=a+z2jgdRlezMX79vOCzc8mxeCu4L9ZU0UnVfTLsT4xE=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=PujAkfG77eWa3Z8+LhDU/pQYQYaUXEt64sEmHWxkoYGAoAldVEDW+tRKJMVRUIrbV
         KQcdDE1OMdNI/hw7T4ybuNoqLL9ZIue3//zRizGExmgsGWx3ayLk05OU9vsOnwiUO2
         IL0caaONDhJ8rYlbfTjutjbt2jSRFDTHkLLuTbK8zh75pmO6h36eYBobKwo3+0Gns5
         Z3R2oMHjDaNCd/+erKCyLvzdyqAaHd9NTYj/84cx3o49HGhHllWXtVTzwK4aT1KamD
         JOwHyiYN+2V+9OQmQGvWmDJt9HJ8u7WSmrKTyATRGmIfEv0ftv2+NUVfsL5xrgjmkG
         oI0CpNy1Prf4A==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id AjjdAfrNnWJi; Mon, 27 Jan 2020 14:39:15 -0500 (EST)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id E6FBF2618D4;
        Mon, 27 Jan 2020 14:39:15 -0500 (EST)
Date:   Mon, 27 Jan 2020 14:39:15 -0500 (EST)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Florian Weimer <fweimer@redhat.com>
Cc:     "H. Peter Anvin" <hpa@zytor.com>, Chris Lameter <cl@linux.com>,
        Jann Horn <jannh@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Joel Fernandes <joelaf@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Watson <davejwatson@fb.com>,
        Will Deacon <will.deacon@arm.com>, shuah <shuah@kernel.org>,
        Andi Kleen <andi@firstfloor.org>,
        linux-kselftest <linux-kselftest@vger.kernel.org>,
        Russell King <linux@arm.linux.org.uk>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Paul <paulmck@linux.vnet.ibm.com>, Paul Turner <pjt@google.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        rostedt <rostedt@goodmis.org>, Ben Maurer <bmaurer@fb.com>,
        linux-api <linux-api@vger.kernel.org>,
        Andy Lutomirski <luto@amacapital.net>
Message-ID: <134428560.600911.1580153955842.JavaMail.zimbra@efficios.com>
In-Reply-To: <87a76efuux.fsf@oldenburg2.str.redhat.com>
References: <20200121160312.26545-1-mathieu.desnoyers@efficios.com> <430172781.596271.1579636021412.JavaMail.zimbra@efficios.com> <CAG48ez2Z5CesMfandNK+S32Rrgp_QGQHqQ1Fpd5-YTsCWGfHeg@mail.gmail.com> <2049164886.596497.1579641536619.JavaMail.zimbra@efficios.com> <alpine.DEB.2.21.2001212141590.1231@www.lameter.com> <1648013936.596672.1579655468604.JavaMail.zimbra@efficios.com> <ead7a565-9a23-a7d7-904d-c4860f63952a@zytor.com> <87a76efuux.fsf@oldenburg2.str.redhat.com>
Subject: Re: [RFC PATCH v1] pin_on_cpu: Introduce thread CPU pinning system
 call
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3895 (ZimbraWebClient - FF72 (Linux)/8.8.15_GA_3895)
Thread-Topic: pin_on_cpu: Introduce thread CPU pinning system call
Thread-Index: cCaL2Q60ZJk3Wpd/+nMzkSPHBHn5oQ==
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


----- On Jan 23, 2020, at 3:19 AM, Florian Weimer fweimer@redhat.com wrote:

> * H. Peter Anvin:
> 
>> On 2020-01-21 17:11, Mathieu Desnoyers wrote:
>>> ----- On Jan 21, 2020, at 4:44 PM, Chris Lameter cl@linux.com wrote:
>>> 
>>>> These scenarios are all pretty complex and will be difficult to understand
>>>> for the user of these APIs.
>>>>
>>>> I think the easiest solution (and most comprehensible) is for the user
>>>> space process that does per cpu operations to get some sort of signal. If
>>>> its not able to handle that then terminate it. The code makes a basic
>>>> assumption after all that the process is running on a specific cpu. If
>>>> this is no longer the case then its better to abort if the process cannot
>>>> handle moving to a different processor.
>>> 
>>> The point of pin_on_cpu() is to allow threads to access per-cpu data
>>> structures belonging to a given CPU even if they cannot run on that
>>> CPU (because it is offline).
>>> 
>>> I am not sure what scenario your signal delivery proposal aims to cover.
>>> 
>>> Just to try to put this into the context of a specific scenario to see
>>> if I understand your point, is the following what you have in mind ?
>>> 
>>> 1. Thread A issues pin_on_cpu(5),
>>> 2. Thread B issues sched_setaffinity removing cpu 5 from thread A's
>>>    affinity mask,
>>> 3. Noticing that it would generate an invalid combination, rather than
>>>    failing sched_setaffinity, it would send a SIGSEGV (or other) signal
>>>    to thread A.
>>> 
>>> Or so you have something entirely different in mind ?
>>> 
>>
>> I would agree that this seems like the only sane option, or you will
>> be in a world of hurt because of conflicting semantics. It is not just
>> offlining, but what happens if a policy manager calls
>> sched_setaffinity() on another thread -- and now the universe breaks
>> because a library is updated to use this new system call which
>> collides with the expectations of the policy manager.
> 
> Yes, this new interface seems fundamentally incompatible with how
> affinity masks are changed today.
> 
> Would it be possible to make pin_on_cpu_set to use fallback
> synchronization via a futex if the CPU cannot be acquired by running on
> it?  The rseq section would need to check the futex as well, but would
> not have to acquire it.

I would really prefer to avoid adding any "mutual-exclusion-based" locking to
rseq, because it would then remove lock-freedom guarantees, which are really
useful when designing data structures shared across processes over shared
memory. Also, I would prefer to avoid adding additional load and comparisons
to the rseq fast-path, because those quickly add up in terms of overhead
compared to the "basic" fast-path.

It brings an interesting idea to the table though. Let's assume for now that
the only intended use of pin_on_cpu(2) would be to allow rseq(2) critical
sections to update per-cpu data on specific cpu number targets. In fact,
considering that userspace can be preempted at any point, we still need a
mechanism to guarantee atomicity with respect to other threads running on
the same runqueue, which rseq(2) provides. Therefore, that assumption does
not appear too far-fetched.

There are 2 scenarios we need to consider here:

A) pin_on_cpu(2) targets a CPU which is not part of the affinity mask.

This case is easy: pin_on_cpu can return an error, and the caller needs to act
accordingly (e.g. figure out that this is a design error and report it, or
decide that it really did not want to touch that per-cpu data that badly and
make the entire process fall-back to a mechanism which does not use per-cpu
data at all from that point onwards)

B) pin_on_cpu(2) targets a CPU part of affinity mask, which is then removed
   by cpuset or sched_setaffinity before unpin.

When the pinned cpu is removed from the affinity mask, we make sure the target
task enters the kernel (or is already in the kernel) so it can update
__rseq_abi.cpu_id when returning to user-space setting it to:

__rseq_abi.cpu_id = RSEQ_CPU_ID_PINNED_DISALLOWED  (= -3)

Which would ensure that all rseq critical sections fail. It would be restored
to the proper CPU number value when unpinning.

This would allow us to ensure user-space does not update the per-cpu data while
it is in the wrong state without having to play tricks with signals, which can be
rather cumbersome to do from userspace libraries.

Independently of the mechanism we choose to deliver information about this
unexpected state (pinned && disallowed), whether it's signal delivery or
through a special __rseq_abi.cpu_id value, the important part is to figure
out how exactly we expect applications to handle this condition. If the application
has a fallback available which does not require per-cpu data, it could be
enabled from that point onwards (quiescence of that transition could be
provided by a rseq barrier). Or if the application really requires per-cpu
data by design, it could simply choose to abort.

Thoughts ?

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
