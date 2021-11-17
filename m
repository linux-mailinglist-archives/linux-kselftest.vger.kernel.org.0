Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 497DD45507B
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Nov 2021 23:30:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241262AbhKQWdG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 17 Nov 2021 17:33:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241279AbhKQWdF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 17 Nov 2021 17:33:05 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EBA6C061764
        for <linux-kselftest@vger.kernel.org>; Wed, 17 Nov 2021 14:30:06 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id y12so17724228eda.12
        for <linux-kselftest@vger.kernel.org>; Wed, 17 Nov 2021 14:30:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kylehuey.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/dbCdpFMMa63XSMKyMFWQhocelYW9Pi1PBQWlvxTsug=;
        b=ObaRcTnhtplTRGzScpGB7fdNOCVwBaZbweGKJhnPwOQoppmt4/L7czLDRFB2DwTnM/
         K0TzYgu2fGU3JYykOTCWKC5KTZ/BHnjhsvVRk8JLyk+hJuM06wi6fkXTAaX99/JyyCEY
         w4fCnQ3yJNoZssKTgpIGcylSmmOK07bBT8XmkR2IaWIZHQmy61xLFzlvQzesMqaK15qw
         0Kho8hyS91sJwuZsUR07r+3cFmc56FSI8IMt2XQnvgp+JopZ5zUP4BoVssqhnsP7+her
         0WSXatbzrhFaPt1NSFZoNcHXtA5Azwm2VsVqEAH0v4NSOXzgetIJg0oPJwUTOkG7JqEF
         QZ2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/dbCdpFMMa63XSMKyMFWQhocelYW9Pi1PBQWlvxTsug=;
        b=NQB4EK/gARV8pxcwlW27EmlLim6lDxlKc+3SQdAnF97KeojsybFKFbR3mUwFJ89y42
         a9A3HrvUw3buLbZGsNghT1LELOYIld/cMQrsz8tKKOvHUD7gMeRAZ3lkbXjcPCNyqhZF
         NpfoOVW0naYIuALP5+PlZMPDfWo5tfL/jLN22JbwVJmYY+JVEC4jFBdr04qCf8tvkAXH
         Z/XRHKsI3DwkGFqprrBxwXZ8401tqozPHQN71r8Qd5z00p7E2m6UC1ovtDFNzGaVtOXD
         KXZVJNH7toZy3vOTDIJl+bG72CpfzQNL0ytf5eeZny818SfimzSe7YAiPlP09mu3mOiP
         aXiw==
X-Gm-Message-State: AOAM5338scxcbEx5mW7R4iSQqj5vWllinNDQbw7/5DO92RjfeWV9NPLk
        0Zj1DzieAL6Kru1ZO5OZJIUd8t9xN9leemgc3DOtYQ==
X-Google-Smtp-Source: ABdhPJyn59BQm41DfYh6GNKdmsbDn3XuE6GIPwQRfQZe7cJQlxXegYj155Z4J3iyTzG3Diq+flRBzAbqWrZKJ6F/Gfc=
X-Received: by 2002:a50:e608:: with SMTP id y8mr3389833edm.39.1637188204599;
 Wed, 17 Nov 2021 14:30:04 -0800 (PST)
MIME-Version: 1.0
References: <CAP045AoMY4xf8aC_4QU_-j7obuEPYgTcnQQP3Yxk=2X90jtpjw@mail.gmail.com>
 <202111171049.3F9C5F1@keescook> <CAP045Apg9AUZN_WwDd6AwxovGjCA++mSfzrWq-mZ7kXYS+GCfA@mail.gmail.com>
 <CAP045AqjHRL=bcZeQ-O+-Yh4nS93VEW7Mu-eE2GROjhKOa-VxA@mail.gmail.com> <87k0h6334w.fsf@email.froward.int.ebiederm.org>
In-Reply-To: <87k0h6334w.fsf@email.froward.int.ebiederm.org>
From:   Kyle Huey <me@kylehuey.com>
Date:   Wed, 17 Nov 2021 14:29:53 -0800
Message-ID: <CAP045AqeXdZpSicKmQ_VU0SkA-igJ-VKM0E=VF+-gzgNS=ckdw@mail.gmail.com>
Subject: Re: [REGRESSION] 5.16rc1: SA_IMMUTABLE breaks debuggers
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Andrea Righi <andrea.righi@canonical.com>,
        Shuah Khan <shuah@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, bpf@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        linux-hardening@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Robert O'Callahan" <rocallahan@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Nov 17, 2021 at 1:05 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> Kyle Huey <me@kylehuey.com> writes:
>
> > On Wed, Nov 17, 2021 at 11:05 AM Kyle Huey <me@kylehuey.com> wrote:
> >>
> >> On Wed, Nov 17, 2021 at 10:51 AM Kees Cook <keescook@chromium.org> wrote:
> >> >
> >> > On Wed, Nov 17, 2021 at 10:47:13AM -0800, Kyle Huey wrote:
> >> > > rr, a userspace record and replay debugger[0], is completely broken on
> >> > > 5.16rc1. I bisected this to 00b06da29cf9dc633cdba87acd3f57f4df3fd5c7.
> >> > >
> >> > > That patch makes two changes, it blocks sigaction from changing signal
> >> > > handlers once the kernel has decided to force the program to take a
> >> > > signal and it also stops notifying ptracers of the signal in the same
> >> > > circumstances. The latter behavior is just wrong. There's no reason
> >> > > that ptrace should not be able to observe and even change
> >> > > (non-SIGKILL) forced signals.  It should be reverted.
> >> > >
> >> > > This behavior change is also observable in gdb. If you take a program
> >> > > that sets SIGSYS to SIG_IGN and then raises a SIGSYS via
> >> > > SECCOMP_RET_TRAP and run it under gdb on a good kernel gdb will stop
> >> > > when the SIGSYS is raised, let you inspect program state, etc. After
> >> > > the SA_IMMUTABLE change gdb won't stop until the program has already
> >> > > died of SIGSYS.
> >> >
> >> > Ah, hm, this was trying to fix the case where a program trips
> >> > SECCOMP_RET_KILL (which is a "fatal SIGSYS"), and had been unobservable
> >> > before. I guess the fix was too broad...
> >>
> >> Perhaps I don't understand precisely what you mean by this, but gdb's
> >> behavior for a program that is SECCOMP_RET_KILLed was not changed by
> >> this patch (the SIGSYS is not observed until after program exit before
> >> or after this change).
> >
> > Ah, maybe that behavior changed in 5.15 (my "before" here is a 5.14
> > kernel).  I would argue that the debugger seeing the SIGSYS for
> > SECCOMP_RET_KILL is desirable though ...
>
> This is definitely worth discussing, and probably in need of fixing (aka
> something in rr seems to have broken).

I mean this in the nicest possible way: fixing this is not optional.

> We definitely need protection against the race with sigaction.

Sure, no argument here, and that doesn't cause any problems for us.

> The fundamental question becomes does it make sense and is it safe
> to allow a debugger to stop at, and possibly change these signals.

And the answer is yes, because at least some of these signals are
generated by actions of the debugger (e.g. setting a breakpoint).

> Stopping at something SA_IMMUTABLE as long as the signal is allowed to
> continue and kill the process when PTRACE_CONT happens seems harmless.
>
> Allowing the debugger to change the signal, or change it's handling
> I don't know.

This is required to support breakpoints.

> All of this is channeled through the following function.
>
> > static int
> > force_sig_info_to_task(struct kernel_siginfo *info, struct task_struct *t, bool sigdfl)
> > {
> >       unsigned long int flags;
> >       int ret, blocked, ignored;
> >       struct k_sigaction *action;
> >       int sig = info->si_signo;
> >
> >       spin_lock_irqsave(&t->sighand->siglock, flags);
> >       action = &t->sighand->action[sig-1];
> >       ignored = action->sa.sa_handler == SIG_IGN;
> >       blocked = sigismember(&t->blocked, sig);
> >       if (blocked || ignored || sigdfl) {
> >               action->sa.sa_handler = SIG_DFL;
> >               action->sa.sa_flags |= SA_IMMUTABLE;
> >               if (blocked) {
> >                       sigdelset(&t->blocked, sig);
> >                       recalc_sigpending_and_wake(t);
> >               }
> >       }
> >       /*
> >        * Don't clear SIGNAL_UNKILLABLE for traced tasks, users won't expect
> >        * debugging to leave init killable.
> >        */
> >       if (action->sa.sa_handler == SIG_DFL && !t->ptrace)
> >               t->signal->flags &= ~SIGNAL_UNKILLABLE;
> >       ret = send_signal(sig, info, t, PIDTYPE_PID);
> >       spin_unlock_irqrestore(&t->sighand->siglock, flags);
> >
> >       return ret;
> > }
>
> Right now we have 3 conditions that trigger SA_IMMUTABLE.
> - The sigdfl parameter is passed asking that userspace not be able to
>   change the handling of the signal.
>
> - A synchronous exception is taken and the signal is blocked.
>
> - A synchronous exception is taken and the signal is ignored.

Delivering signals to a ptracee in the latter two cases is simply not
optional. As it stands with your change, a program that blocks SIGTRAP
or sets its SIGTRAP handler to SIG_IGN becomes undebuggable.  If a
debugger injects a breakpoint or uses PTRACE_SINGLESTEP on a tracee
the delivery of that signal can't be controlled by the tracee's signal
state.

> Today because of how things are implemented the code most change the
> userspace state to allow the signal to kill the process.  I really want
> to get rid of that, because that has other side effects.  As part of
> getting rid of changing the state it is my plan to get rid of
> SA_IMMUTABLE as well.  If I don't have to allow the debugger to stop and
> observe what is happening with the signal that change is much easier to
> implement.
>
> The classic trigger of sigdfl is a recursive SIGSEGV.
>
> However we have other cases like SECCOMP_RET_KILL where the kernel
> has never allowed userspace to intercept the killing of the
> process.  Things that have messages like: "seccomp tried to change
> syscall nr or ip"
>
> My brain is drawing a blank on how to analyze those.
>
> Kees I am back to asking the question I had before I figured out
> SA_IMMUTABLE.  Are there security concerns with debuggers intercepting
> SECCOMP_RET_KILL.
>
> I think I can modify dequeue_synchronous_signal so that we can perform
> the necessary logic in get_signal rather than hack up the signal
> handling state in force_sig_info_to_task.
>
> Except for the cases like SECCOMP_RET_KILL where the kernel has never
> allowed userspace to intercept the handling.  I don't see any
> fundamental reason why ptrace could not intercept the signal.  The
> handling is overriden to force the process to die, because the way
> userspace is currently configured to handle the signal does not work so
> it is necessary to kill the process.
>
> I think there are cases where the userspace state is known to be
> sufficiently wrong that the kernel can not safely allow anything more
> than inspecting the state.
>
> I can revisit the code to see if the kernel will get confused if
> something more is allowed.  Still I really like the current semantics of
> SA_IMMUTABLE because these are cases where something wrong.  If someone
> miscalculates how things are wrong it could result in the kernel getting
> confused and doing the wrong thing.  Allowing the debugger to intercept
> the signal requires we risk miscalculating what is wrong.
>
> Kyle how exactly is rr broken?  Certainly a historical usage does not
> work.  How does this affect actual real world debugging sessions?

rr is broken across the board because of specific things related to
its handling of exit_group (namely we first block all signals in the
tracee, so that we don't catch a signal during our handling of it,
then we hijack the tracee to do some cleanup before exit_group is
really allowed to execute, and we use e.g. PTRACE_SINGLESTEP that
expects to punch through the signal blocking). But even if I fixed
that, I expect there would be other issues. The expectation that these
signals will be delivered is deeply embedded.

> You noticed this and bisected the change quickly so I fully expect
> this does affect real world debugging sessions.  I just want to know
> exactly how so that exactly what is wrong can be fixed.

I noticed this because we have a test suite we run against new kernel
releases precisely to catch regressions like this.

You don't need rr to reproduce the underlying issue though.  Compile
the following

```
#include <signal.h>
#include <stdio.h>

int main() {
  signal(SIGTRAP, SIG_IGN);
  printf("Hello World\n");
  return 0;
}
```

And try to break on the printf under gdb.  After you fix that (and the
equivalent where SIGTRAP is blocked) rr should be fine.

- Kyle

> As far as I can tell SA_IMMUTABLE has only been backported to v5.15.x
> where in cleaning things up I made SECCOMP_RET_KILL susceptible to races
> with sigaction, and ptrace.  Those races need to be closed or we need to
> decide that we don't actually care if the debugger does things.
>
> Eric
