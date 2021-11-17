Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84D91454F9C
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Nov 2021 22:54:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240823AbhKQV5P (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 17 Nov 2021 16:57:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232788AbhKQV5P (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 17 Nov 2021 16:57:15 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30F4FC061570
        for <linux-kselftest@vger.kernel.org>; Wed, 17 Nov 2021 13:54:16 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id m24so3366941pls.10
        for <linux-kselftest@vger.kernel.org>; Wed, 17 Nov 2021 13:54:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TyflncBo4THYgrqhCPbCdrMH0wmAnukogB9h7+aZLPc=;
        b=LD3wx/0WsV+K5ZaVvJGk4B58b755LoG9yNHQCbOtNiqYXf1JDa0B+6STmSNAX7UiAb
         a3bbZGG3lI8FB7Pl+jZRC+07aI4FLb75KMMbKB0dR/ZKgf6bHAM460JE2ur0VB+b1BaR
         zFUCpk6hp28mvlZ/CRH8MbCstWvltcN1qAWsc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TyflncBo4THYgrqhCPbCdrMH0wmAnukogB9h7+aZLPc=;
        b=5oFJq8INEn75IFb3jgvid3Wzwux5typsPQzLqThZLD7CPyZJTVjvwApTOu6Jclxiye
         VAbR5I20hGOegXlwrE/D+ETDsrSuQZ/Br6HBGnL+B43wJeg6IBBf9bys8ctZzXZqWAsx
         BjcLsA2VJn1Q0tdWbUfot0rPifqzi07fcuaHdcide0JYOBYUuZuOE9fT4d5psY/uhOoc
         Hg+V9ol4XyJxoXYFoN7YGVOWgUk4eMhjz2teCb26JZF9XRMV8cH3HyDU79jTLO12gQtD
         6HSIhiqZqCiIgZdlzWkUHP/5c15MfXrt7Gsxaf6LqE4qJZn79xQmZFh9twrHUeAI904Z
         mA+Q==
X-Gm-Message-State: AOAM533x+Bjp5gRCOYje8Z4roIBaKWDHhRObSpRGt9QNIuqrzWlz66yG
        IxOKFK42C05fI9k6yIKid3suaw==
X-Google-Smtp-Source: ABdhPJzcvx+Omftengr4Y3I++Ne+CRyHy9ruaviogn9sbmiRhSOCY96nnx7Ca6k41hOfhn1CeyD3VQ==
X-Received: by 2002:a17:90b:4f45:: with SMTP id pj5mr3890617pjb.70.1637186055666;
        Wed, 17 Nov 2021 13:54:15 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id oc10sm6963920pjb.26.2021.11.17.13.54.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Nov 2021 13:54:15 -0800 (PST)
Date:   Wed, 17 Nov 2021 13:54:14 -0800
From:   Kees Cook <keescook@chromium.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Kyle Huey <me@kylehuey.com>,
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
        Robert O'Callahan <rocallahan@gmail.com>
Subject: Re: [REGRESSION] 5.16rc1: SA_IMMUTABLE breaks debuggers
Message-ID: <202111171341.41053845C3@keescook>
References: <CAP045AoMY4xf8aC_4QU_-j7obuEPYgTcnQQP3Yxk=2X90jtpjw@mail.gmail.com>
 <202111171049.3F9C5F1@keescook>
 <CAP045Apg9AUZN_WwDd6AwxovGjCA++mSfzrWq-mZ7kXYS+GCfA@mail.gmail.com>
 <CAP045AqjHRL=bcZeQ-O+-Yh4nS93VEW7Mu-eE2GROjhKOa-VxA@mail.gmail.com>
 <87k0h6334w.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87k0h6334w.fsf@email.froward.int.ebiederm.org>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Nov 17, 2021 at 03:04:31PM -0600, Eric W. Biederman wrote:
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

The SA_IMMUTABLE change was to deal with failures seen in the seccomp
test suite after the recent fatal signal refactoring. Mainly that a
process that should have effectively performed do_exit() was suddenly
visible to the tracer.

> > Ah, maybe that behavior changed in 5.15 (my "before" here is a 5.14
> > kernel).  I would argue that the debugger seeing the SIGSYS for
> > SECCOMP_RET_KILL is desirable though ...
> 
> This is definitely worth discussing, and probably in need of fixing (aka
> something in rr seems to have broken).
> 
> We definitely need protection against the race with sigaction.
> 
> The fundamental question becomes does it make sense and is it safe
> to allow a debugger to stop at, and possibly change these signals.

I have no problem with a debugger getting notified about a fatal
(SECCOMP_RET_KILL*-originated) SIGSYS. But whatever happens, the kernel
needs to make sure the process does not continue. (i.e. signal can't be
changed/removed/etc.)

> Stopping at something SA_IMMUTABLE as long as the signal is allowed to
> continue and kill the process when PTRACE_CONT happens seems harmless.
> 
> Allowing the debugger to change the signal, or change it's handling
> I don't know.

Right -- I'm fine with a visibility change (the seccomp test suite is
just checking for various expected state machine changes across the
various signal/death cases: as long as it _dies_, that's what we want.
If a extra notification appears before it dies, that's okay, it just
needs the test suite to change).

> [...]
> Kees I am back to asking the question I had before I figured out
> SA_IMMUTABLE.  Are there security concerns with debuggers intercepting
> SECCOMP_RET_KILL.

I see no problem with allowing a tracer to observe the signal, but the
signalled process must have no way to continue running. If we end up in
such a state, then a seccomp process with access to clone() and
ptrace() can escape the seccomp sandbox. This is why seccomp had been
using the big do_exit() hammer -- I really want to absolutely never have
a bug manifest with a bypassed SECCOMP_RET_KILL: having a completely
unavoidable "dying" state is needed.

-- 
Kees Cook
