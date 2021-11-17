Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD62F454DA8
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Nov 2021 20:09:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240360AbhKQTMa (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 17 Nov 2021 14:12:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240357AbhKQTMa (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 17 Nov 2021 14:12:30 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A4C3C061764
        for <linux-kselftest@vger.kernel.org>; Wed, 17 Nov 2021 11:09:31 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id y13so15508009edd.13
        for <linux-kselftest@vger.kernel.org>; Wed, 17 Nov 2021 11:09:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kylehuey.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nAnJBXzy+j+SKp6UpMgT2UvLgTzhaItKFp8lDVP8bOI=;
        b=D/3ogEfrPySNe/eJXcy3nGapEBgOa+bO4XpTO1fHqcR4gIHauBxVp2s2PTCG9AaMaK
         6HWXJWr8+wvWMSmhSClExdjqN7fIaWTvI88IJ4lZYAdC8nYnUZjTmKgMelEW/vM09ccU
         Qks8YqTAJMBzwsuPvYilwCulORTIf0cXhHfvOl1OhxuXmyIY27x1FpiDzKLUaqgkYwKB
         C4v3tbaU8kPkutz5A52B6ixWVsBCyKtWU+GHbDqkM/8L0FIBtcnKvUHfdrsn54sJNHuv
         M4Jx0a+DRZ3mZ/77iFaGAc4PDOLRQcqNNvk+V2hm+kIow9E02xqjp0Qbp8qHiPFiZ+qY
         E0/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nAnJBXzy+j+SKp6UpMgT2UvLgTzhaItKFp8lDVP8bOI=;
        b=Hnp/noo7U/Vhx0ewI7oto+f8L82abc9/EzSpky4TEpk5RGIgYTzbA9x8LHvJ8lA+py
         Iosd2FMxU4yq5lR0FhAvl0qBLuXJ40KHiUQxEoBFBKQsCGXgMLdqDhabTjz4zb7qtGMk
         ClBYMWkbyXyUXCjVI/+yjGZAx2dIMVniIZ+a0BkVAZNX3OCKzQOGf+teAhOYl49FRY94
         zaJMS1zYn17/ur66b155GPE7FO14zI5HBr6pwrEOzEk4Uhsn1m0M0Qz1SEvpe5oi2QrM
         5lVvkkvb4adfAYxQ47FMepwZJah4dWoaye/XeEYgixx+f7EGn1GYCZ9HINRhrgb97L7G
         EeQA==
X-Gm-Message-State: AOAM533MmcSf1WVdFFQxDrE+q7UVwGEe26tf73E2dy+kEuUQ2rTvHGU3
        ctDd2Yw4u0nC+gjukWvPKdFmD0gzlWpBqB3jb7zuOQ==
X-Google-Smtp-Source: ABdhPJwIlcvt3E3+hGdYyhRGnWjeE/5pkW4ELjc8AjM1yuatRjqoO/EXVWvQGxDOJO05Ugr9afaP14IXrq92digDejs=
X-Received: by 2002:a05:6402:1a58:: with SMTP id bf24mr1604937edb.16.1637176169875;
 Wed, 17 Nov 2021 11:09:29 -0800 (PST)
MIME-Version: 1.0
References: <CAP045AoMY4xf8aC_4QU_-j7obuEPYgTcnQQP3Yxk=2X90jtpjw@mail.gmail.com>
 <202111171049.3F9C5F1@keescook> <CAP045Apg9AUZN_WwDd6AwxovGjCA++mSfzrWq-mZ7kXYS+GCfA@mail.gmail.com>
In-Reply-To: <CAP045Apg9AUZN_WwDd6AwxovGjCA++mSfzrWq-mZ7kXYS+GCfA@mail.gmail.com>
From:   Kyle Huey <me@kylehuey.com>
Date:   Wed, 17 Nov 2021 11:09:14 -0800
Message-ID: <CAP045AqjHRL=bcZeQ-O+-Yh4nS93VEW7Mu-eE2GROjhKOa-VxA@mail.gmail.com>
Subject: Re: [REGRESSION] 5.16rc1: SA_IMMUTABLE breaks debuggers
To:     Kees Cook <keescook@chromium.org>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
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

On Wed, Nov 17, 2021 at 11:05 AM Kyle Huey <me@kylehuey.com> wrote:
>
> On Wed, Nov 17, 2021 at 10:51 AM Kees Cook <keescook@chromium.org> wrote:
> >
> > On Wed, Nov 17, 2021 at 10:47:13AM -0800, Kyle Huey wrote:
> > > rr, a userspace record and replay debugger[0], is completely broken on
> > > 5.16rc1. I bisected this to 00b06da29cf9dc633cdba87acd3f57f4df3fd5c7.
> > >
> > > That patch makes two changes, it blocks sigaction from changing signal
> > > handlers once the kernel has decided to force the program to take a
> > > signal and it also stops notifying ptracers of the signal in the same
> > > circumstances. The latter behavior is just wrong. There's no reason
> > > that ptrace should not be able to observe and even change
> > > (non-SIGKILL) forced signals.  It should be reverted.
> > >
> > > This behavior change is also observable in gdb. If you take a program
> > > that sets SIGSYS to SIG_IGN and then raises a SIGSYS via
> > > SECCOMP_RET_TRAP and run it under gdb on a good kernel gdb will stop
> > > when the SIGSYS is raised, let you inspect program state, etc. After
> > > the SA_IMMUTABLE change gdb won't stop until the program has already
> > > died of SIGSYS.
> >
> > Ah, hm, this was trying to fix the case where a program trips
> > SECCOMP_RET_KILL (which is a "fatal SIGSYS"), and had been unobservable
> > before. I guess the fix was too broad...
>
> Perhaps I don't understand precisely what you mean by this, but gdb's
> behavior for a program that is SECCOMP_RET_KILLed was not changed by
> this patch (the SIGSYS is not observed until after program exit before
> or after this change).

Ah, maybe that behavior changed in 5.15 (my "before" here is a 5.14
kernel).  I would argue that the debugger seeing the SIGSYS for
SECCOMP_RET_KILL is desirable though ...

- Kyle
