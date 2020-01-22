Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 03BF6144D8E
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Jan 2020 09:23:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725868AbgAVIXe (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 22 Jan 2020 03:23:34 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:41061 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726049AbgAVIX3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 22 Jan 2020 03:23:29 -0500
Received: by mail-ot1-f67.google.com with SMTP id r27so5508353otc.8
        for <linux-kselftest@vger.kernel.org>; Wed, 22 Jan 2020 00:23:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=newysj2ZL/VSTfuHShTKoBBsv78QbKLgFXEyPsWB43Q=;
        b=sad90dnekqlccjQQPFDugkDbhJ08amgSt8lL/wJWNY1SSgdp5GEjDXlD3mkpAqamru
         Sn7mpch98hT/OWzDxgqgwuRaPVE1Keluw8AxfuAEkQmTSqJHms2vRmAef3Vuex3MtapB
         zUUeBzCIW9Mg08cXEQnWIN26XqyDZVr4bulTtYjQ2VRlMuWQZS2BfbyTNdcKah5VKKyz
         L4clA549Rk+yhGpg1igXPIRaKRiVWdjEaMj9vDYdqlQMV2JrdxnelSQME7Woqle8TWxx
         rRJGQBcuFW1iwfaH0FcERy0YV2T4IZgiRFWt7c6EhJ9lWfY+bW9QJkDlXsyS2LJ1N2sn
         Qcxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=newysj2ZL/VSTfuHShTKoBBsv78QbKLgFXEyPsWB43Q=;
        b=FKrygtSVPBlLYT/YQPUpAbiO/XCytEtwMtF0+RWOpGd3OxiEC1qFt1YaATTFjew3U8
         tIpSg3GJSS2IadH6dlnyDX/46kLFjgMM+bQ/sp166JhGXtfVNvTqkYO94oXRJGLr/BSd
         H0yAKj7EsjqQN0/1dVCOOZclvWCoqYuAv0x48egfyKjgN1+LK59/103DZGtpK4zdF+/B
         eZ5rkVvYiZ6BVFC6ku/1YMife4FaD6DVzUFiSLC2zHOe7diG1OBHoNkT5py4Ypuvjrxu
         /0vGDxDVqoWmsb5jsSvk4iAlEgMvNVX7VmSjMz3JZQ0NojpTBqU/7MTZYnTIs7RY1M/S
         k9DQ==
X-Gm-Message-State: APjAAAUE0j74l/vHND14Q5Wrs4rUY3GUdhOmg7xp0ZRalIV0CNsaHQVO
        S/OW7Lu8uKrDGDYGiFSELxcSOrnbwXDjRSDNl07o7w==
X-Google-Smtp-Source: APXvYqywIYwxTLG6xTrdA7i/IBRjYdry2QDfn0bX6MZDDvI3iaG98yt2MoshvA2vPRiIpwZePTpxDhDTTVqG5M0jnNI=
X-Received: by 2002:a05:6830:44e:: with SMTP id d14mr6268112otc.228.1579681408192;
 Wed, 22 Jan 2020 00:23:28 -0800 (PST)
MIME-Version: 1.0
References: <20200121160312.26545-1-mathieu.desnoyers@efficios.com>
 <CAG48ez2bQdoT9y7HkyU06DTazysUDdPdJe+gyV-NxgQA7JWQVQ@mail.gmail.com>
 <430172781.596271.1579636021412.JavaMail.zimbra@efficios.com>
 <CAG48ez2Z5CesMfandNK+S32Rrgp_QGQHqQ1Fpd5-YTsCWGfHeg@mail.gmail.com> <2049164886.596497.1579641536619.JavaMail.zimbra@efficios.com>
In-Reply-To: <2049164886.596497.1579641536619.JavaMail.zimbra@efficios.com>
From:   Jann Horn <jannh@google.com>
Date:   Wed, 22 Jan 2020 09:23:00 +0100
Message-ID: <CAG48ez2Zz7gOTir4qm2ZuYEj2ZH4isZipiDbvevzfgor27jHkA@mail.gmail.com>
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
        Paul <paulmck@linux.vnet.ibm.com>, Paul Turner <pjt@google.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        rostedt <rostedt@goodmis.org>, Ben Maurer <bmaurer@fb.com>,
        linux-api <linux-api@vger.kernel.org>,
        Andy Lutomirski <luto@amacapital.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Jan 21, 2020 at 10:18 PM Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
> ----- On Jan 21, 2020, at 3:35 PM, Jann Horn jannh@google.com wrote:
>
> > On Tue, Jan 21, 2020 at 8:47 PM Mathieu Desnoyers
> > <mathieu.desnoyers@efficios.com> wrote:
> >>
> >> ----- On Jan 21, 2020, at 12:20 PM, Jann Horn jannh@google.com wrote:
> >>
> >> > On Tue, Jan 21, 2020 at 5:13 PM Mathieu Desnoyers
> >> > <mathieu.desnoyers@efficios.com> wrote:
> >> >> There is an important use-case which is not possible with the
> >> >> "rseq" (Restartable Sequences) system call, which was left as
> >> >> future work.
> >> >>
> >> >> That use-case is to modify user-space per-cpu data structures
> >> >> belonging to specific CPUs which may be brought offline and
> >> >> online again by CPU hotplug. This can be used by memory
> >> >> allocators to migrate free memory pools when CPUs are brought
> >> >> offline, or by ring buffer consumers to target specific per-CPU
> >> >> buffers, even when CPUs are brought offline.
> >> >>
> >> >> A few rather complex prior attempts were made to solve this.
> >> >> Those were based on in-kernel interpreters (cpu_opv, do_on_cpu).
> >> >> That complexity was generally frowned upon, even by their author.
> >> >>
> >> >> This patch fulfills this use-case in a refreshingly simple way:
> >> >> it introduces a "pin_on_cpu" system call, which allows user-space
> >> >> threads to pin themselves on a specific CPU (which needs to be
> >> >> present in the thread's allowed cpu mask), and then clear this
> >> >> pinned state.
> >> > [...]
> >> >> For instance, this allows implementing this userspace library API
> >> >> for incrementing a per-cpu counter for a specific cpu number
> >> >> received as parameter:
> >> >>
> >> >> static inline __attribute__((always_inline))
> >> >> int percpu_addv(intptr_t *v, intptr_t count, int cpu)
> >> >> {
> >> >>         int ret;
> >> >>
> >> >>         ret =3D rseq_addv(v, count, cpu);
> >> >> check:
> >> >>         if (rseq_unlikely(ret)) {
> >> >>                 pin_on_cpu_set(cpu);
> >> >>                 ret =3D rseq_addv(v, count, percpu_current_cpu());
> >> >>                 pin_on_cpu_clear();
> >> >>                 goto check;
> >> >>         }
> >> >>         return 0;
> >> >> }
> >> >
> >> > What does userspace have to do if the set of allowed CPUs switches a=
ll
> >> > the time? For example, on Android, if you first open Chrome and then
> >> > look at its allowed CPUs, Chrome is allowed to use all CPU cores
> >> > because it's running in the foreground:
> >> >
> >> > walleye:/ # ps -AZ | grep 'android.chrome$'
> >> > u:r:untrusted_app:s0:c145,c256,c512,c768 u0_a145 7845 805 1474472
> >> > 197868 SyS_epoll_wait f09c0194 S com.android.chrome
> >> > walleye:/ # grep cpuset /proc/7845/cgroup; grep Cpus_allowed_list
> >> > /proc/7845/status
> >> > 3:cpuset:/top-app
> >> > Cpus_allowed_list: 0-7
> >> >
> >> > But if you then switch to the home screen, the application is moved
> >> > into a different cgroup, and is restricted to two CPU cores:
> >> >
> >> > walleye:/ # grep cpuset /proc/7845/cgroup; grep Cpus_allowed_list
> >> > /proc/7845/status
> >> > 3:cpuset:/background
> >> > Cpus_allowed_list: 0-1
> >>
> >> Then at that point, pin_on_cpu() would only be allowed to pin on
> >> CPUs 0 and 1.
> >
> > Which means that you can't actually reliably use pin_on_cpu_set() to
> > manipulate percpu data structures since you have to call it with the
> > assumption that it might randomly fail at any time, right?
>
> Only if the cpu affinity of the thread is being changed concurrently
> by another thread which is a possibility in some applications, indeed.

Not just some applications, but also some environments, right? See the
Android example - the set of permitted CPUs is changed not by the
application itself, but by a management process that uses cgroup
modifications to indirectly change the set of permitted CPUs. I
wouldn't be surprised if the same could happen in e.g. container
environments.

> > And then
> > userspace needs to code a fallback path that somehow halts all the
> > threads with thread-directed signals or something?
>
> The example use of pin_on_cpu() did not include handling of the return
> value in that case (-1, errno=3DEINVAL) for conciseness. But yes, the
> application would have to handle this.
>
> It's not so different from error handling which is required when using
> sched_setaffinity(), which can fail with -1, errno=3DEINVAL in the follow=
ing
> scenario:
>
>        EINVAL The  affinity bit mask mask contains no processors that are=
 cur=E2=80=90
>               rently physically on the system  and  permitted  to  the  t=
hread
>               according  to  any  restrictions  that  may  be  imposed  b=
y the
>               "cpuset" mechanism described in cpuset(7).

Except that sched_setaffinity() is normally just a performance
optimization, right? Whereas pin_to_cpu() is more of a correctness
thing?

> > Especially if the task trying to use pin_on_cpu_set() isn't allowed to
> > pin to the target CPU, but all the other tasks using the shared data
> > structure are allowed to do that. Or if the CPU you want to pin to is
> > always removed from your affinity mask immediately before
> > pin_on_cpu_set() and added back immediately afterwards.
>
> I am tempted to state that using pin_on_cpu() targeting a disallowed cpu
> should be considered a programming error and handled accordingly by the
> application.

How can it be a programming error if that situation can be triggered
by legitimate external modifications to CPU affinity?

[...]
> >> > I'm wondering whether it might be possible to rework this mechanism
> >> > such that, instead of moving the current task onto a target CPU, it
> >> > prevents all *other* threads of the current process from running on
> >> > that CPU (either entirely or in user mode). That might be the easies=
t
> >> > way to take care of issues like CPU hotplugging and changing cpusets
> >> > all at once? The only potential issue I see with that approach would
> >> > be that you wouldn't be able to use it for inter-process
> >> > communication; and I have no idea whether this would be good or bad
> >> > performance-wise.
> >>
> >> Firstly, inter-process communication over shared memory is one of my u=
se-cases
> >> (for lttng-ust's ring buffer).
> >>
> >> I'm not convinced that applying constraints on all other threads belon=
ging to
> >> the current process would be easier or faster than migrating the curre=
nt thread
> >> over to the target CPU. I'm unsure how those additional constraints wo=
uld
> >> fit with other threads already having their own cpu affinity masks (wh=
ich
> >> could generate an empty cpumask by adding an extra constraint).
> >
> > Hm - is an empty cpumask a problem here? If one task is in the middle
> > of a critical section for performing maintenance on a percpu data
> > structure, isn't it a nice design property to exclude concurrent
> > access from other tasks to that data structure automatically (by
> > preventing those tasks by running on that CPU)? That way the
> > (presumably rarely-executed) update path doesn't have to be
> > rseq-reentrancy-safe.
>
> Given we already have rseq, simply using it to protect against other
> threads trying to touch the same per-cpu data seems rather more lightweig=
ht
> than to try to exclude all other threads from that CPU for a possibly
> unbounded amount of time.

That only works if the cpu-targeted maintenance operation is something
that can be implemented in rseq, right? I was thinking that it might
be nice to avoid that limitation - but I don't know much about the
kinds of data structures that one might want to build on top of rseq,
so maybe that's a silly idea.

> Allowing a completely empty cpumask could effectively allow those
> critical sections to prevent execution of possibly higher priority
> threads on the system, which ends up being the definition of a priority
> inversion, which I'd like to avoid.

Linux does have the infrastructure for RT futexes, right? Maybe that
could be useful here.
