Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D30845521D
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Nov 2021 02:20:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242206AbhKRBXy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 17 Nov 2021 20:23:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242199AbhKRBXp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 17 Nov 2021 20:23:45 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2A30C061570
        for <linux-kselftest@vger.kernel.org>; Wed, 17 Nov 2021 17:20:45 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id g14so19400202edz.2
        for <linux-kselftest@vger.kernel.org>; Wed, 17 Nov 2021 17:20:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kylehuey.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=N9zDLh8C4cET9vcP6JDNqTwr8KRqom/U2tw34i8nOWk=;
        b=JmVrz1Q1JKnr3TIhwHYaaONqjgaCaxJbX6wpl2/o1si/vnDnx6hqBqr4EPPBjM+x3F
         LkNmbmLpkML3JJdCnnfcUb5amc+ZxL/ThtJRS6j8oeqHI7RHsaM18dUqbPOhlyTuUKQf
         a5K/CDsgD3d7RvY2tdcKZ+/3vhTMHSWgSoUwA9zVjCqdRfBSqlZ8hNaLievgJvfI9G1W
         jBvGJZz0UsP+lFQrb7M9nYOmorWqaJV7QDlmK2Lkyqlv6ZflnMMzD7N7h8eTrvpBgluK
         4LB6k2+fT7d9zvz0pYEAPBxbYleF+tM4WzRScj0JNUExt5XzvwHmRwCScGK5fRgT/Ijs
         +BgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N9zDLh8C4cET9vcP6JDNqTwr8KRqom/U2tw34i8nOWk=;
        b=tEn6qct3rjjIWpehXux6iORYR1Ijah+SMcGyseaAL7cO1kWZ6TPJIBa+FZjgGoeqPO
         JnqsIgCl3Adar/uodfCaEov5xgpsDWQMwjdJKN1/7Ff+DiqDSUHErWfHE1cVKvJMMp8E
         Fk9QjIapjn2zXDSs1OCvYe9snjeMLzYd6kxhxQILBsPbvybhTuW4YazwhYIC5aOm3HGY
         /57sH2YsJrI5WRVKVfBeIRGFneYENsEHaH4U3c8sZUAhUP4sXsslJaydqRQlRuLQjxeM
         H/DxGmEHsLTGr4cu0gE3lIhI2+tiH7Tuq3LrEOlyVJaQd5D9l12f6lZL3mpGWjOojzwq
         Wy6w==
X-Gm-Message-State: AOAM530/zCPGcAtCP8vn5VpudWYpCuJshwFnV2gu82PT2Ja/r/jAmfdL
        tH4Pb35YMqm1Lb0X8nexeMSmtll7K+oEbrKsmTpG5Q==
X-Google-Smtp-Source: ABdhPJzyZMWRDSNhVRQ+YY93TKx7aUdiyobq666l0LHWxI/JoQTYaZDj9fUjWADvjoy95Rlz9PiMLsZS3aWM6onyeoA=
X-Received: by 2002:a17:906:140b:: with SMTP id p11mr27713464ejc.116.1637198444338;
 Wed, 17 Nov 2021 17:20:44 -0800 (PST)
MIME-Version: 1.0
References: <CAP045AoMY4xf8aC_4QU_-j7obuEPYgTcnQQP3Yxk=2X90jtpjw@mail.gmail.com>
 <202111171049.3F9C5F1@keescook> <CAP045Apg9AUZN_WwDd6AwxovGjCA++mSfzrWq-mZ7kXYS+GCfA@mail.gmail.com>
 <CAP045AqjHRL=bcZeQ-O+-Yh4nS93VEW7Mu-eE2GROjhKOa-VxA@mail.gmail.com>
 <87k0h6334w.fsf@email.froward.int.ebiederm.org> <202111171341.41053845C3@keescook>
 <CAHk-=wgkOGmkTu18hJQaJ4mk8hGZc16=gzGMgGGOd=uwpXsdyw@mail.gmail.com>
 <CAP045ApYXxhiAfmn=fQM7_hD58T-yx724ctWFHO4UAWCD+QapQ@mail.gmail.com> <CAHk-=wiCRbSvUi_TnQkokLeM==_+Tow0GsQXnV3UYwhsxirPwg@mail.gmail.com>
In-Reply-To: <CAHk-=wiCRbSvUi_TnQkokLeM==_+Tow0GsQXnV3UYwhsxirPwg@mail.gmail.com>
From:   Kyle Huey <me@kylehuey.com>
Date:   Wed, 17 Nov 2021 17:20:33 -0800
Message-ID: <CAP045AoqssLTKOqse1t1DG1HgK9h+goG8C3sqgOyOV3Wwq+LDA@mail.gmail.com>
Subject: Re: [REGRESSION] 5.16rc1: SA_IMMUTABLE breaks debuggers
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Andrea Righi <andrea.righi@canonical.com>,
        Shuah Khan <shuah@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-hardening@vger.kernel.org,
        "Robert O'Callahan" <rocallahan@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Nov 17, 2021 at 5:11 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Wed, Nov 17, 2021 at 4:37 PM Kyle Huey <me@kylehuey.com> wrote:
> >
> > This fixes most of the issues with rr, but it still changes the ptrace
> > behavior for the double-SIGSEGV case
>
> Hmm. I think that's because of how "force_sigsgv()" works.
>
> I absolutely detest that function.
>
> So we have signal_setup_done() doing that
>
>         if (failed)
>                 force_sigsegv(ksig->sig);
>
> and then force_sigsegv() has that completely insane
>
>         if (sig == SIGSEGV)
>                 force_fatal_sig(SIGSEGV);
>         else
>                 force_sig(SIGSEGV);
>
> behavior.
>
> And I think I know the _reason_ for that complete insanity: when
> SIGSEGV takes a SIGSEGV, and there is a handler, we need to stop
> trying to send more SIGSEGV's.

Right, in our test we setup a SIGSEGV handler on an alt stack that
doesn't actually exist, and then overflow the regular stack, and that
would loop forever trying to setup SIGSEGV handlers if it weren't for
force_sigsegv and the sigdfl=true stuff.

> But it does mean that with my change, that second SIGSEGV now ends up
> being that SA_IMMUTABLE kind, so yeah, it broke the debugger test -
> where catching the second SIGSEGV is actually somewhat sensible (ok,
> not really, but at least understandable)
>
> End result: I think we want not a boolean, but a three-way choice for
> that force_sig_info_to_task() thing:

with the following clarifications, yes

>  - unconditionally fatal (for things that just want to force an exit
> and used to do do_exit())

no matter what the ptracer wants

>  - ignore valid and unblocked handler (for that SIGSEGV recursion
> case, aka force "sigdfl")

but following the usual ptrace rules

>  - catching signal ok
>
> So my one-liner isn't sufficient. It wants some kind of nasty enum.
>
> At least the enum can be entirely internal to kernel/signal.c, I
> think. No need to expose this all to anything else.
>
>             Linus

Yeah that's one way to solve the problem. I think you're right that
fundamentally the problem here is that what SECCOMP_RET_KILL wants is
not really a signal. To the extent that it wants a signal, what it
really wants is SIGKILL, and the problem here is the code trying to
act like SIGKILL but call it SIGSYS. I assume the ship for fixing that
sailed years ago though.

- Kyle
