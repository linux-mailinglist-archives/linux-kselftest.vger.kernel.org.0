Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A22BC14456D
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Jan 2020 20:53:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727813AbgAUTxT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 21 Jan 2020 14:53:19 -0500
Received: from mail.efficios.com ([167.114.26.124]:42636 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726926AbgAUTxT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 21 Jan 2020 14:53:19 -0500
X-Greylist: delayed 376 seconds by postgrey-1.27 at vger.kernel.org; Tue, 21 Jan 2020 14:53:18 EST
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 1916D253772;
        Tue, 21 Jan 2020 14:47:02 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id jRqVdpN1xZ5t; Tue, 21 Jan 2020 14:47:01 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 9F9B0253771;
        Tue, 21 Jan 2020 14:47:01 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 9F9B0253771
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1579636021;
        bh=E94cVXKf+7yBhWNrnINyP+aFkmnjtYMO3cEcciVVmD4=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=Ti0zP5gdtHGlRjpE8NgSONpmGaMpDbXDucjZ4ML2d/FtC2sEeXRAh28boRfu3uS6h
         jPNXgQrerGWi0PzeywmkrIQp65Q6FFreLXhYnnBnszrN9/GVy2/0D4tkS5vZGWyBoA
         C8ig/tUIZz4Xoaddw/f9NUCJAO91qpbRyg+vmQQEuJf/pt+Eo3OxZMMMiKqNceggc6
         c3vvJ/Z+21Oe8LxX4BuzVlAmmINPYvp+QyKs+ZSUHcUR0dCV/+/L+FoPdrA63oFGU2
         dCATtZlTJk9mIDHutTp/5hGYYLJ5P0QY7keTfbMVqEFscLs6Q7hDlZKVpwizR2FPs3
         1ivD13gTc8irw==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id RiHK1mtuRx4U; Tue, 21 Jan 2020 14:47:01 -0500 (EST)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 803732538C3;
        Tue, 21 Jan 2020 14:47:01 -0500 (EST)
Date:   Tue, 21 Jan 2020 14:47:01 -0500 (EST)
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
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Paul Turner <pjt@google.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        rostedt <rostedt@goodmis.org>, Ben Maurer <bmaurer@fb.com>,
        linux-api <linux-api@vger.kernel.org>,
        Andy Lutomirski <luto@amacapital.net>
Message-ID: <430172781.596271.1579636021412.JavaMail.zimbra@efficios.com>
In-Reply-To: <CAG48ez2bQdoT9y7HkyU06DTazysUDdPdJe+gyV-NxgQA7JWQVQ@mail.gmail.com>
References: <20200121160312.26545-1-mathieu.desnoyers@efficios.com> <CAG48ez2bQdoT9y7HkyU06DTazysUDdPdJe+gyV-NxgQA7JWQVQ@mail.gmail.com>
Subject: Re: [RFC PATCH v1] pin_on_cpu: Introduce thread CPU pinning system
 call
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3895 (ZimbraWebClient - FF72 (Linux)/8.8.15_GA_3895)
Thread-Topic: pin_on_cpu: Introduce thread CPU pinning system call
Thread-Index: SUS+RZAe0aLWPsHzRvXWGarIM8oqwA==
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

----- On Jan 21, 2020, at 12:20 PM, Jann Horn jannh@google.com wrote:

> On Tue, Jan 21, 2020 at 5:13 PM Mathieu Desnoyers
> <mathieu.desnoyers@efficios.com> wrote:
>> There is an important use-case which is not possible with the
>> "rseq" (Restartable Sequences) system call, which was left as
>> future work.
>>
>> That use-case is to modify user-space per-cpu data structures
>> belonging to specific CPUs which may be brought offline and
>> online again by CPU hotplug. This can be used by memory
>> allocators to migrate free memory pools when CPUs are brought
>> offline, or by ring buffer consumers to target specific per-CPU
>> buffers, even when CPUs are brought offline.
>>
>> A few rather complex prior attempts were made to solve this.
>> Those were based on in-kernel interpreters (cpu_opv, do_on_cpu).
>> That complexity was generally frowned upon, even by their author.
>>
>> This patch fulfills this use-case in a refreshingly simple way:
>> it introduces a "pin_on_cpu" system call, which allows user-space
>> threads to pin themselves on a specific CPU (which needs to be
>> present in the thread's allowed cpu mask), and then clear this
>> pinned state.
> [...]
>> For instance, this allows implementing this userspace library API
>> for incrementing a per-cpu counter for a specific cpu number
>> received as parameter:
>>
>> static inline __attribute__((always_inline))
>> int percpu_addv(intptr_t *v, intptr_t count, int cpu)
>> {
>>         int ret;
>>
>>         ret = rseq_addv(v, count, cpu);
>> check:
>>         if (rseq_unlikely(ret)) {
>>                 pin_on_cpu_set(cpu);
>>                 ret = rseq_addv(v, count, percpu_current_cpu());
>>                 pin_on_cpu_clear();
>>                 goto check;
>>         }
>>         return 0;
>> }
> 
> What does userspace have to do if the set of allowed CPUs switches all
> the time? For example, on Android, if you first open Chrome and then
> look at its allowed CPUs, Chrome is allowed to use all CPU cores
> because it's running in the foreground:
> 
> walleye:/ # ps -AZ | grep 'android.chrome$'
> u:r:untrusted_app:s0:c145,c256,c512,c768 u0_a145 7845 805 1474472
> 197868 SyS_epoll_wait f09c0194 S com.android.chrome
> walleye:/ # grep cpuset /proc/7845/cgroup; grep Cpus_allowed_list
> /proc/7845/status
> 3:cpuset:/top-app
> Cpus_allowed_list: 0-7
> 
> But if you then switch to the home screen, the application is moved
> into a different cgroup, and is restricted to two CPU cores:
> 
> walleye:/ # grep cpuset /proc/7845/cgroup; grep Cpus_allowed_list
> /proc/7845/status
> 3:cpuset:/background
> Cpus_allowed_list: 0-1

Then at that point, pin_on_cpu() would only be allowed to pin on
CPUs 0 and 1.

> At the same time, I also wonder whether it is a good idea to allow
> userspace to stay active on a CPU even after the task has been told to
> move to another CPU core - that's probably not exactly a big deal, but
> seems suboptimal to me.

Do you mean the following scenario for a given task ?

1) set affinity to CPU 0,1,2
2) pin on CPU 2
3) set affinity to CPU 0,1

In the patch I propose here, step (3) is forbidden by this added check in
__set_cpus_allowed_ptr, which is used by sched_setaffinity(2):

+       /* Prevent removing the currently pinned CPU from the allowed cpu mask. */
+       if (is_pinned_task(p) && !cpumask_test_cpu(p->pinned_cpu, new_mask)) {
+               ret = -EINVAL;
+               goto out;
+       }


> I'm wondering whether it might be possible to rework this mechanism
> such that, instead of moving the current task onto a target CPU, it
> prevents all *other* threads of the current process from running on
> that CPU (either entirely or in user mode). That might be the easiest
> way to take care of issues like CPU hotplugging and changing cpusets
> all at once? The only potential issue I see with that approach would
> be that you wouldn't be able to use it for inter-process
> communication; and I have no idea whether this would be good or bad
> performance-wise.

Firstly, inter-process communication over shared memory is one of my use-cases
(for lttng-ust's ring buffer).

I'm not convinced that applying constraints on all other threads belonging to
the current process would be easier or faster than migrating the current thread
over to the target CPU. I'm unsure how those additional constraints would
fit with other threads already having their own cpu affinity masks (which
could generate an empty cpumask by adding an extra constraint).

Thanks for the feedback!

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
