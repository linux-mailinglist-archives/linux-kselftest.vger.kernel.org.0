Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10E2A43FED0
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Oct 2021 16:58:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229501AbhJ2PAe (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 29 Oct 2021 11:00:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbhJ2PAd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 29 Oct 2021 11:00:33 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1B90C061767
        for <linux-kselftest@vger.kernel.org>; Fri, 29 Oct 2021 07:58:04 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id j1so500376plx.4
        for <linux-kselftest@vger.kernel.org>; Fri, 29 Oct 2021 07:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VEe/u6gPdZlKSr0M6oaNVpmJO6541YBOxFo1iZy9jxY=;
        b=XgNVKerM9naMpOzlG/yHOv6MbIBkuVbdK2nh8u3B6CTSDzELhiTjOA/oXBPr38rHdb
         4mKzpTPKz5GByJldq3UbYPi/RKcrp7ssrAvr/1T9GgQ0nRT/INmDXWhMBxNTT8pBD+4I
         q+FxMmeVtJEHyaB6fFMKC8p/Q2AnAHCTUeqS0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VEe/u6gPdZlKSr0M6oaNVpmJO6541YBOxFo1iZy9jxY=;
        b=s8rvRzpn/r9BNQFWSZt1B9maHjvETIILqN2Gla+2LfvGKydnEapb++nQwA01mzQFqg
         eQPEti7KPtuyrurPPI3QpD0OjdFD8tGhxsCHnPev+v+H7d+RmWumMk1PVYg1nt9QesWU
         bLfgGCtJJgrjjC56VjUwL5wm8ZWhCuinlmO6hRrNF7VN+4RyIsdP0sGArnpf8XjDxVY5
         Ai8ApBRymJEV3hSTbcKbmdtVXIbj042/DqWRNZBQK4wAcqlOaq4FBM42CnVNDqMIhlkn
         4P1tfIoBAxANlmoXqHs9PTdZmk7EJcELfx2snjp+eCzGomde9RCuWCSAhMAY34uTh2oq
         rexQ==
X-Gm-Message-State: AOAM533x/4piDao/9EBxLjZAennSa+CpkWbwO8WanhD87L35uPxBVNw3
        UlkyiDsIHljOPnVkZuVtuu0caQ==
X-Google-Smtp-Source: ABdhPJzb9u+2dMEcZaSXa+AiqxQ44lfYwbYDuIySZAxxQm6HTY4y7N4CneHSkWx0kEjeTZP1gPgvWA==
X-Received: by 2002:a17:90a:8592:: with SMTP id m18mr5199470pjn.184.1635519484215;
        Fri, 29 Oct 2021 07:58:04 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id u11sm7009927pfk.151.2021.10.29.07.58.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Oct 2021 07:58:03 -0700 (PDT)
Date:   Fri, 29 Oct 2021 07:58:02 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Andrea Righi <andrea.righi@canonical.com>,
        Shuah Khan <shuah@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        linux-kselftest@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: selftests: seccomp_bpf failure on 5.15
Message-ID: <202110290755.451B036CE9@keescook>
References: <YXrN+Hnl9pSOsWlA@arighi-desktop>
 <202110280955.B18CB67@keescook>
 <878rydm56l.fsf@disp2133>
 <202110281136.5CE65399A7@keescook>
 <8735okls76.fsf@disp2133>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8735okls76.fsf@disp2133>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Oct 28, 2021 at 05:06:53PM -0500, Eric W. Biederman wrote:
> Kees Cook <keescook@chromium.org> writes:
> 
> > On Thu, Oct 28, 2021 at 12:26:26PM -0500, Eric W. Biederman wrote:
> >> Kees Cook <keescook@chromium.org> writes:
> >> 
> >> > On Thu, Oct 28, 2021 at 06:21:12PM +0200, Andrea Righi wrote:
> >> >> The following sub-tests are failing in seccomp_bpf selftest:
> >> >> 
> >> >> 18:56:54 DEBUG| [stdout] # selftests: seccomp: seccomp_bpf
> >> >> ...
> >> >> 18:56:57 DEBUG| [stdout] # #  RUN           TRACE_syscall.ptrace.kill_after ...
> >> >> 18:56:57 DEBUG| [stdout] # # seccomp_bpf.c:2023:kill_after:Expected entry ? PTRACE_EVENTMSG_SYSCALL_ENTRY : PTRACE_EVENTMSG_SYSCALL_EXIT (1) == msg (0)
> >> >> 18:56:57 DEBUG| [stdout] # # seccomp_bpf.c:2023:kill_after:Expected entry ? PTRACE_EVENTMSG_SYSCALL_ENTRY : PTRACE_EVENTMSG_SYSCALL_EXIT (2) == msg (1)
> >> >> 18:56:57 DEBUG| [stdout] # # seccomp_bpf.c:2023:kill_after:Expected entry ? PTRACE_EVENTMSG_SYSCALL_ENTRY : PTRACE_EVENTMSG_SYSCALL_EXIT (1) == msg (2)
> >> >> 18:56:57 DEBUG| [stdout] # # kill_after: Test exited normally instead of by signal (code: 12)
> >> >> 18:56:57 DEBUG| [stdout] # #          FAIL  TRACE_syscall.ptrace.kill_after
> >> >> ...
> >> >> 18:56:57 DEBUG| [stdout] # #  RUN           TRACE_syscall.seccomp.kill_after ...
> >> >> 18:56:57 DEBUG| [stdout] # # seccomp_bpf.c:1547:kill_after:Expected !ptrace_syscall (1) == IS_SECCOMP_EVENT(status) (0)
> >> >> 18:56:57 DEBUG| [stdout] # # kill_after: Test exited normally instead of by signal (code: 0)
> >> >> 18:56:57 DEBUG| [stdout] # #          FAIL  TRACE_syscall.seccomp.kill_after
> >> >> 18:56:57 DEBUG| [stdout] # not ok 80 TRACE_syscall.seccomp.kill_after
> >> >> ...
> >> >> 18:56:57 DEBUG| [stdout] # # FAILED: 85 / 87 tests passed.
> >> >> 18:56:57 DEBUG| [stdout] # # Totals: pass:85 fail:2 xfail:0 xpass:0 skip:0 error:0
> >> >> 18:56:57 DEBUG| [stdout] not ok 1 selftests: seccomp: seccomp_bpf # exit=1
> >> >> 
> >> >> I did some bisecting and found that the failures started to happen with:
> >> >> 
> >> >>  307d522f5eb8 ("signal/seccomp: Refactor seccomp signal and coredump generation")
> >> >> 
> >> >> Not sure if the test needs to be fixed after this commit, or if the
> >> >> commit is actually introducing an issue. I'll investigate more, unless
> >> >> someone knows already what's going on.
> >> >
> >> > Ah thanks for noticing; I will investigate...
> >> 
> >> 
> >> I just did a quick read through of the test and while
> >> I don't understand everything having a failure seems
> >> very weird.
> >> 
> >> I don't understand the comment:
> >> /* Tracer will redirect getpid to getppid, and we should die. */
> >> 
> >> As I think what happens is it the bpf programs loads the signal
> >> number.  Tests to see if the signal number if GETPPID and allows
> >> that system call and causes any other system call to be terminated.
> >
> > The test suite runs a series of seccomp filter vs syscalls under tracing,
> > either with ptrace or with seccomp SECCOMP_RET_TRACE, to validate the
> > expected behavioral states. It seems that what's happened is that the
> > SIGSYS has suddenly become non-killing:
> >
> > #  RUN           TRACE_syscall.ptrace.kill_after ...
> > # seccomp_bpf.c:1555:kill_after:Expected WSTOPSIG(status) & 0x80 (0) == 0x80 (128)
> > # seccomp_bpf.c:1556:kill_after:WSTOPSIG: 31
> > # kill_after: Test exited normally instead of by signal (code: 12)
> > #          FAIL  TRACE_syscall.ptrace.kill_after
> >
> > i.e. the ptracer no longer sees a dead tracee, which would pass through
> > here:
> >
> >                 if (WIFSIGNALED(status) || WIFEXITED(status))
> >                         /* Child is dead. Time to go. */
> >                         return;
> >
> > So the above saw a SIG_TRAP|SIGSYS rather than a killing SIGSYS. i.e.
> > instead of WIFSIGNALED(stauts) being true, it instead catches a
> > PTRACE_EVENT_STOP for SIGSYS, which should be impossible (the process
> > should be getting killed).
> 
> Oh.  This is being ptraced as part of the test?
> 
> Yes.  The signal started being delivered.  As far as that goes that
> sounds correct.
> 
> Ptrace is allowed to intercept even fatal signals.  Everything except
> SIGKILL.
> 
> Is this a condition we don't want even ptrace to be able to catch?
> 
> I think we can arrange it so that even ptrace can't intercept this
> signal.  I need to sit this problem on the back burner for a few
> minutes.  It is an angle I had not considered.
> 
> Is it a problem that the debugger can see the signal if the process does
> not?

Right, I'm trying to understand that too. However, my neighbor just lost
power. :|

What I was in the middle of checking was what ptrace "sees" going
through a fatal SIGSYS; my initial debugging attempts were weird.

-Kees

-- 
Kees Cook
