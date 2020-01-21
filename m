Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D3005144651
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Jan 2020 22:19:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728896AbgAUVTA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 21 Jan 2020 16:19:00 -0500
Received: from mail.efficios.com ([167.114.26.124]:54840 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728741AbgAUVTA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 21 Jan 2020 16:19:00 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 79EF625436D;
        Tue, 21 Jan 2020 16:18:57 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id mJGCyF325qsg; Tue, 21 Jan 2020 16:18:57 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id DC3732547B2;
        Tue, 21 Jan 2020 16:18:56 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com DC3732547B2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1579641536;
        bh=vKFxI6ckMuJ2NCIZCuTf0QzEtnvwMcH3TldZCF12Dw8=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=eBlVWt2wv9SF22rLcI+rSmVwuixq2TXajXodx4clu0lusBeIgZqE/DHvaEf4iQb7F
         H8db1szVyjCNfQwUnf+RXMPaiLuH4vncbQHRJk/3K3mDRzt0mOXHtCkbggxyELVryr
         gy6mE6aF7/rCeG4+qcasTcYzqsvI24r3kdLvOVdPK5Iq6s5oXkOS0bRadGVU5EUpC9
         GTM3XXUWDqsDhJZm3EvH5iZi67CATeRMUGkuxerS05z+xNG8zFBwYE5oNVX8H9qnKy
         MCvrDHCiqGkuTGGWUybwjmz9qzGx5HKOxcJFPvw/kWdHb5jF5Rb/yHeKb+/GS9mH4m
         hiczdPR9TMJRg==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id gBcakcD4MPSv; Tue, 21 Jan 2020 16:18:56 -0500 (EST)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id AF013254643;
        Tue, 21 Jan 2020 16:18:56 -0500 (EST)
Date:   Tue, 21 Jan 2020 16:18:56 -0500 (EST)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Jann Horn <jannh@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Joel Fernandes <joelaf@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Watson <davejwatson@fb.com>,
        Will Deacon <will.deacon@arm.com>, shuah <shuah@kernel.org>,
        Andi Kleen <andi@firstfloor.org>,
        linux-kselftest <linux-kselftest@vger.kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Chris Lameter <cl@linux.com>,
        Russell King <linux@arm.linux.org.uk>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Paul <paulmck@linux.vnet.ibm.com>, Paul Turner <pjt@google.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        rostedt <rostedt@goodmis.org>, Ben Maurer <bmaurer@fb.com>,
        linux-api <linux-api@vger.kernel.org>,
        Andy Lutomirski <luto@amacapital.net>
Message-ID: <2049164886.596497.1579641536619.JavaMail.zimbra@efficios.com>
In-Reply-To: <CAG48ez2Z5CesMfandNK+S32Rrgp_QGQHqQ1Fpd5-YTsCWGfHeg@mail.gmail.com>
References: <20200121160312.26545-1-mathieu.desnoyers@efficios.com> <CAG48ez2bQdoT9y7HkyU06DTazysUDdPdJe+gyV-NxgQA7JWQVQ@mail.gmail.com> <430172781.596271.1579636021412.JavaMail.zimbra@efficios.com> <CAG48ez2Z5CesMfandNK+S32Rrgp_QGQHqQ1Fpd5-YTsCWGfHeg@mail.gmail.com>
Subject: Re: [RFC PATCH v1] pin_on_cpu: Introduce thread CPU pinning system
 call
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3895 (ZimbraWebClient - FF72 (Linux)/8.8.15_GA_3895)
Thread-Topic: pin_on_cpu: Introduce thread CPU pinning system call
Thread-Index: sZllX64PNnu8Z36Wdxk3KHh4n0P/HQ==
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

----- On Jan 21, 2020, at 3:35 PM, Jann Horn jannh@google.com wrote:

> On Tue, Jan 21, 2020 at 8:47 PM Mathieu Desnoyers
> <mathieu.desnoyers@efficios.com> wrote:
>>
>> ----- On Jan 21, 2020, at 12:20 PM, Jann Horn jannh@google.com wrote:
>>
>> > On Tue, Jan 21, 2020 at 5:13 PM Mathieu Desnoyers
>> > <mathieu.desnoyers@efficios.com> wrote:
>> >> There is an important use-case which is not possible with the
>> >> "rseq" (Restartable Sequences) system call, which was left as
>> >> future work.
>> >>
>> >> That use-case is to modify user-space per-cpu data structures
>> >> belonging to specific CPUs which may be brought offline and
>> >> online again by CPU hotplug. This can be used by memory
>> >> allocators to migrate free memory pools when CPUs are brought
>> >> offline, or by ring buffer consumers to target specific per-CPU
>> >> buffers, even when CPUs are brought offline.
>> >>
>> >> A few rather complex prior attempts were made to solve this.
>> >> Those were based on in-kernel interpreters (cpu_opv, do_on_cpu).
>> >> That complexity was generally frowned upon, even by their author.
>> >>
>> >> This patch fulfills this use-case in a refreshingly simple way:
>> >> it introduces a "pin_on_cpu" system call, which allows user-space
>> >> threads to pin themselves on a specific CPU (which needs to be
>> >> present in the thread's allowed cpu mask), and then clear this
>> >> pinned state.
>> > [...]
>> >> For instance, this allows implementing this userspace library API
>> >> for incrementing a per-cpu counter for a specific cpu number
>> >> received as parameter:
>> >>
>> >> static inline __attribute__((always_inline))
>> >> int percpu_addv(intptr_t *v, intptr_t count, int cpu)
>> >> {
>> >>         int ret;
>> >>
>> >>         ret =3D rseq_addv(v, count, cpu);
>> >> check:
>> >>         if (rseq_unlikely(ret)) {
>> >>                 pin_on_cpu_set(cpu);
>> >>                 ret =3D rseq_addv(v, count, percpu_current_cpu());
>> >>                 pin_on_cpu_clear();
>> >>                 goto check;
>> >>         }
>> >>         return 0;
>> >> }
>> >
>> > What does userspace have to do if the set of allowed CPUs switches all
>> > the time? For example, on Android, if you first open Chrome and then
>> > look at its allowed CPUs, Chrome is allowed to use all CPU cores
>> > because it's running in the foreground:
>> >
>> > walleye:/ # ps -AZ | grep 'android.chrome$'
>> > u:r:untrusted_app:s0:c145,c256,c512,c768 u0_a145 7845 805 1474472
>> > 197868 SyS_epoll_wait f09c0194 S com.android.chrome
>> > walleye:/ # grep cpuset /proc/7845/cgroup; grep Cpus_allowed_list
>> > /proc/7845/status
>> > 3:cpuset:/top-app
>> > Cpus_allowed_list: 0-7
>> >
>> > But if you then switch to the home screen, the application is moved
>> > into a different cgroup, and is restricted to two CPU cores:
>> >
>> > walleye:/ # grep cpuset /proc/7845/cgroup; grep Cpus_allowed_list
>> > /proc/7845/status
>> > 3:cpuset:/background
>> > Cpus_allowed_list: 0-1
>>
>> Then at that point, pin_on_cpu() would only be allowed to pin on
>> CPUs 0 and 1.
>=20
> Which means that you can't actually reliably use pin_on_cpu_set() to
> manipulate percpu data structures since you have to call it with the
> assumption that it might randomly fail at any time, right?

Only if the cpu affinity of the thread is being changed concurrently
by another thread which is a possibility in some applications, indeed.

> And then
> userspace needs to code a fallback path that somehow halts all the
> threads with thread-directed signals or something?

The example use of pin_on_cpu() did not include handling of the return
value in that case (-1, errno=3DEINVAL) for conciseness. But yes, the
application would have to handle this.

It's not so different from error handling which is required when using
sched_setaffinity(), which can fail with -1, errno=3DEINVAL in the followin=
g
scenario:

       EINVAL The  affinity bit mask mask contains no processors that are c=
ur=E2=80=90
              rently physically on the system  and  permitted  to  the  thr=
ead
              according  to  any  restrictions  that  may  be  imposed  by =
the
              "cpuset" mechanism described in cpuset(7).

> Especially if the task trying to use pin_on_cpu_set() isn't allowed to
> pin to the target CPU, but all the other tasks using the shared data
> structure are allowed to do that. Or if the CPU you want to pin to is
> always removed from your affinity mask immediately before
> pin_on_cpu_set() and added back immediately afterwards.

I am tempted to state that using pin_on_cpu() targeting a disallowed cpu
should be considered a programming error and handled accordingly by the
application.

>=20
>> > At the same time, I also wonder whether it is a good idea to allow
>> > userspace to stay active on a CPU even after the task has been told to
>> > move to another CPU core - that's probably not exactly a big deal, but
>> > seems suboptimal to me.
>>
>> Do you mean the following scenario for a given task ?
>>
>> 1) set affinity to CPU 0,1,2
>> 2) pin on CPU 2
>> 3) set affinity to CPU 0,1
>>
>> In the patch I propose here, step (3) is forbidden by this added check i=
n
>> __set_cpus_allowed_ptr, which is used by sched_setaffinity(2):
>>
>> +       /* Prevent removing the currently pinned CPU from the allowed cp=
u mask.
>> */
>> +       if (is_pinned_task(p) && !cpumask_test_cpu(p->pinned_cpu, new_ma=
sk)) {
>> +               ret =3D -EINVAL;
>> +               goto out;
>> +       }
>=20
> How does that interact with things like cgroups? What happens when
> root tries to move a process from the cpuset:/top-app cgroup to the
> cpuset:/background cgroup? Does that also just throw an error code?

Looking at kernel/cgroup/cpuset.c use of set_cpus_allowed_ptr(), either
it:

A) silently ignores the error (3 instances),
or
B) triggers a WARN_ON_ONCE() (1 instance).

So yeah, that cgroup code seems rather optimistic that this operation
should always succeed (?!?)

I can say up front I am not entirely sure what's the best way to proceed
here. Either sched_setaffinity and cgroup can fail if trying to remove a
CPU from affinity mask while the task is pinned, or we let them succeed
and leave the task running on the pinned CPU anyway, or any better idea ?

>=20
>> > I'm wondering whether it might be possible to rework this mechanism
>> > such that, instead of moving the current task onto a target CPU, it
>> > prevents all *other* threads of the current process from running on
>> > that CPU (either entirely or in user mode). That might be the easiest
>> > way to take care of issues like CPU hotplugging and changing cpusets
>> > all at once? The only potential issue I see with that approach would
>> > be that you wouldn't be able to use it for inter-process
>> > communication; and I have no idea whether this would be good or bad
>> > performance-wise.
>>
>> Firstly, inter-process communication over shared memory is one of my use=
-cases
>> (for lttng-ust's ring buffer).
>>
>> I'm not convinced that applying constraints on all other threads belongi=
ng to
>> the current process would be easier or faster than migrating the current=
 thread
>> over to the target CPU. I'm unsure how those additional constraints woul=
d
>> fit with other threads already having their own cpu affinity masks (whic=
h
>> could generate an empty cpumask by adding an extra constraint).
>=20
> Hm - is an empty cpumask a problem here? If one task is in the middle
> of a critical section for performing maintenance on a percpu data
> structure, isn't it a nice design property to exclude concurrent
> access from other tasks to that data structure automatically (by
> preventing those tasks by running on that CPU)? That way the
> (presumably rarely-executed) update path doesn't have to be
> rseq-reentrancy-safe.

Given we already have rseq, simply using it to protect against other
threads trying to touch the same per-cpu data seems rather more lightweight
than to try to exclude all other threads from that CPU for a possibly
unbounded amount of time.

Allowing a completely empty cpumask could effectively allow those
critical sections to prevent execution of possibly higher priority
threads on the system, which ends up being the definition of a priority
inversion, which I'd like to avoid.

Thanks,

Mathieu

--=20
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
