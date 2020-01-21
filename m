Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 13BE81445FF
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Jan 2020 21:37:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729076AbgAUUgD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 21 Jan 2020 15:36:03 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:46834 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728139AbgAUUgC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 21 Jan 2020 15:36:02 -0500
Received: by mail-ot1-f68.google.com with SMTP id r9so4170907otp.13
        for <linux-kselftest@vger.kernel.org>; Tue, 21 Jan 2020 12:36:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AjmyNrJxYMj9hx1pEuIb5xYTG+vY8gWyJHwqNS1wCUw=;
        b=lYMW2yUnqU+zx4ieWubcOjSROpxN401Tpbrn63gqgQ4x6brvwtQf7WG/yzoS5AsTRI
         WfzTFKvIH2QF+P+nH4Vc0B4YYLANVU0PI19pHWWP78vCzJ8jXCep86AuuKqS/TkOYJ28
         hxgriH4/k2QXkoKHO31Jun2sDkQahURBWm0aQ6TEM+yFi9xFJd2vU9hDC2cLVpyzz8aY
         u4n4IrbFv/Zhj1cUWps5ugGdUybSqNl3GTv+mHXDESyjyV5pN9+TaOW7NvfK5pUHK2iB
         RMeeEtXec/MxQnYQpAahMSSAaODYLL15L2jpd2DdsAEmtOZ0JxhXMGneRH5UlzCbFQrj
         xopQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AjmyNrJxYMj9hx1pEuIb5xYTG+vY8gWyJHwqNS1wCUw=;
        b=dnWbgWnyYMx3Xq5RJ5ABkcosnKT3gcl3FseaI5NCyuFm0SDrUABvtO4BVFp7o5CMGI
         2gzXYyV97Van9D5A/CIlgNohBMy5I6RyaoUcLBe8GgasInqBCC62P97/SDQ/kDvUIMud
         fwQPI0zQecwQTWD28m1lO7O7z6ghBSdAYiz43KpvHBIcMiY61x3ezohOPuauH8XXpouz
         nd5iAt0uQLdlqRQtvi6gG0HG7nEV6h+h/elgy1bAy3iPfgz19kZw2Xq4h/upt3yJLqtU
         DFDdVcayfVgDb4+vxN20Atu/gdrjkwROQf9sAobwAY2vWHbcPskeclunA4QHCwgRn/Cz
         i8og==
X-Gm-Message-State: APjAAAWDZYJIXVvHDEr81MMRryBChMvidXKzahhh3FsudZHtV+DJtCGX
        nIC0J0xaFX5OCKZksbslazHJLDOubmS+xsL1KVF1iTtj
X-Google-Smtp-Source: APXvYqwgXs7czsJCQcE0FxmXxjGa8yZWNEpRlzR0wER2hE9bDkrrsFEakgj5celusSdyT2BSRWkeNs0W3jvW/Er/wP0=
X-Received: by 2002:a9d:5f13:: with SMTP id f19mr5029900oti.180.1579638961077;
 Tue, 21 Jan 2020 12:36:01 -0800 (PST)
MIME-Version: 1.0
References: <20200121160312.26545-1-mathieu.desnoyers@efficios.com>
 <CAG48ez2bQdoT9y7HkyU06DTazysUDdPdJe+gyV-NxgQA7JWQVQ@mail.gmail.com> <430172781.596271.1579636021412.JavaMail.zimbra@efficios.com>
In-Reply-To: <430172781.596271.1579636021412.JavaMail.zimbra@efficios.com>
From:   Jann Horn <jannh@google.com>
Date:   Tue, 21 Jan 2020 21:35:33 +0100
Message-ID: <CAG48ez2Z5CesMfandNK+S32Rrgp_QGQHqQ1Fpd5-YTsCWGfHeg@mail.gmail.com>
Subject: Re: [RFC PATCH v1] pin_on_cpu: Introduce thread CPU pinning system call
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
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
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Paul Turner <pjt@google.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        rostedt <rostedt@goodmis.org>, Ben Maurer <bmaurer@fb.com>,
        linux-api <linux-api@vger.kernel.org>,
        Andy Lutomirski <luto@amacapital.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Jan 21, 2020 at 8:47 PM Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>
> ----- On Jan 21, 2020, at 12:20 PM, Jann Horn jannh@google.com wrote:
>
> > On Tue, Jan 21, 2020 at 5:13 PM Mathieu Desnoyers
> > <mathieu.desnoyers@efficios.com> wrote:
> >> There is an important use-case which is not possible with the
> >> "rseq" (Restartable Sequences) system call, which was left as
> >> future work.
> >>
> >> That use-case is to modify user-space per-cpu data structures
> >> belonging to specific CPUs which may be brought offline and
> >> online again by CPU hotplug. This can be used by memory
> >> allocators to migrate free memory pools when CPUs are brought
> >> offline, or by ring buffer consumers to target specific per-CPU
> >> buffers, even when CPUs are brought offline.
> >>
> >> A few rather complex prior attempts were made to solve this.
> >> Those were based on in-kernel interpreters (cpu_opv, do_on_cpu).
> >> That complexity was generally frowned upon, even by their author.
> >>
> >> This patch fulfills this use-case in a refreshingly simple way:
> >> it introduces a "pin_on_cpu" system call, which allows user-space
> >> threads to pin themselves on a specific CPU (which needs to be
> >> present in the thread's allowed cpu mask), and then clear this
> >> pinned state.
> > [...]
> >> For instance, this allows implementing this userspace library API
> >> for incrementing a per-cpu counter for a specific cpu number
> >> received as parameter:
> >>
> >> static inline __attribute__((always_inline))
> >> int percpu_addv(intptr_t *v, intptr_t count, int cpu)
> >> {
> >>         int ret;
> >>
> >>         ret = rseq_addv(v, count, cpu);
> >> check:
> >>         if (rseq_unlikely(ret)) {
> >>                 pin_on_cpu_set(cpu);
> >>                 ret = rseq_addv(v, count, percpu_current_cpu());
> >>                 pin_on_cpu_clear();
> >>                 goto check;
> >>         }
> >>         return 0;
> >> }
> >
> > What does userspace have to do if the set of allowed CPUs switches all
> > the time? For example, on Android, if you first open Chrome and then
> > look at its allowed CPUs, Chrome is allowed to use all CPU cores
> > because it's running in the foreground:
> >
> > walleye:/ # ps -AZ | grep 'android.chrome$'
> > u:r:untrusted_app:s0:c145,c256,c512,c768 u0_a145 7845 805 1474472
> > 197868 SyS_epoll_wait f09c0194 S com.android.chrome
> > walleye:/ # grep cpuset /proc/7845/cgroup; grep Cpus_allowed_list
> > /proc/7845/status
> > 3:cpuset:/top-app
> > Cpus_allowed_list: 0-7
> >
> > But if you then switch to the home screen, the application is moved
> > into a different cgroup, and is restricted to two CPU cores:
> >
> > walleye:/ # grep cpuset /proc/7845/cgroup; grep Cpus_allowed_list
> > /proc/7845/status
> > 3:cpuset:/background
> > Cpus_allowed_list: 0-1
>
> Then at that point, pin_on_cpu() would only be allowed to pin on
> CPUs 0 and 1.

Which means that you can't actually reliably use pin_on_cpu_set() to
manipulate percpu data structures since you have to call it with the
assumption that it might randomly fail at any time, right? And then
userspace needs to code a fallback path that somehow halts all the
threads with thread-directed signals or something?
Especially if the task trying to use pin_on_cpu_set() isn't allowed to
pin to the target CPU, but all the other tasks using the shared data
structure are allowed to do that. Or if the CPU you want to pin to is
always removed from your affinity mask immediately before
pin_on_cpu_set() and added back immediately afterwards.

> > At the same time, I also wonder whether it is a good idea to allow
> > userspace to stay active on a CPU even after the task has been told to
> > move to another CPU core - that's probably not exactly a big deal, but
> > seems suboptimal to me.
>
> Do you mean the following scenario for a given task ?
>
> 1) set affinity to CPU 0,1,2
> 2) pin on CPU 2
> 3) set affinity to CPU 0,1
>
> In the patch I propose here, step (3) is forbidden by this added check in
> __set_cpus_allowed_ptr, which is used by sched_setaffinity(2):
>
> +       /* Prevent removing the currently pinned CPU from the allowed cpu mask. */
> +       if (is_pinned_task(p) && !cpumask_test_cpu(p->pinned_cpu, new_mask)) {
> +               ret = -EINVAL;
> +               goto out;
> +       }

How does that interact with things like cgroups? What happens when
root tries to move a process from the cpuset:/top-app cgroup to the
cpuset:/background cgroup? Does that also just throw an error code?

> > I'm wondering whether it might be possible to rework this mechanism
> > such that, instead of moving the current task onto a target CPU, it
> > prevents all *other* threads of the current process from running on
> > that CPU (either entirely or in user mode). That might be the easiest
> > way to take care of issues like CPU hotplugging and changing cpusets
> > all at once? The only potential issue I see with that approach would
> > be that you wouldn't be able to use it for inter-process
> > communication; and I have no idea whether this would be good or bad
> > performance-wise.
>
> Firstly, inter-process communication over shared memory is one of my use-cases
> (for lttng-ust's ring buffer).
>
> I'm not convinced that applying constraints on all other threads belonging to
> the current process would be easier or faster than migrating the current thread
> over to the target CPU. I'm unsure how those additional constraints would
> fit with other threads already having their own cpu affinity masks (which
> could generate an empty cpumask by adding an extra constraint).

Hm - is an empty cpumask a problem here? If one task is in the middle
of a critical section for performing maintenance on a percpu data
structure, isn't it a nice design property to exclude concurrent
access from other tasks to that data structure automatically (by
preventing those tasks by running on that CPU)? That way the
(presumably rarely-executed) update path doesn't have to be
rseq-reentrancy-safe.
