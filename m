Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1DA539CEBD
	for <lists+linux-kselftest@lfdr.de>; Sun,  6 Jun 2021 13:58:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230112AbhFFMAi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 6 Jun 2021 08:00:38 -0400
Received: from mail-pg1-f173.google.com ([209.85.215.173]:35417 "EHLO
        mail-pg1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbhFFMAh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 6 Jun 2021 08:00:37 -0400
Received: by mail-pg1-f173.google.com with SMTP id o9so8806155pgd.2;
        Sun, 06 Jun 2021 04:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=aPhZd0Ev1Ws/GdwHl8PJdNKfaX6hJwWh4xylt4wxRXc=;
        b=Na4D8qBD3WbOV8ekMSlAia9NMbFTdGHAa+HvQcwfTucGT2H9caXMMBLm45GJVXA1vj
         G58hHRdJjm3gE6MOFk8AlnVMZFnByfSnycUTus1HZCpCh7TG562tLypVdKCdYnLqhQ0Z
         lGEkMsFs8z8c8c7iUSbEP4QAyaLB8cNC4Caf3GsuT2RalMCmOndS7N6eS0t4uhsvuKCm
         Gbl0pv49bjReRXrkgcyuKAwHgTjkjWAY4Z6jsDCSfQVeFkDFW2zA2r42UT3goB1bxP5D
         hwOmQNKFIOYlS33hyLIFQhyxNfdzfIbdLbarBDKrNVUf4qMBRsS+59ZxsePGIITCSwyX
         1z0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=aPhZd0Ev1Ws/GdwHl8PJdNKfaX6hJwWh4xylt4wxRXc=;
        b=aZ5RXldlpTWUe3thjCbMeg1qpZjOL8SC1NVhhDq9EOlqkKCJWahy761subSfJKj3rN
         lvpb3EFtY4KoNEkT/b40Kk/ed6ejtZ9GZDevqUvKpj/A/tr6YFGgDADhXeCSFOCiN9Mf
         vjPsl2Mze3AuAQ5NB6SC3/dd2iURxXmEgz9L7A+/eqssY1VrOKfv8T9FCgtxMKi1luOl
         n5Enu9qg5VUZ07lM2YfuGEjgVNF5tCGY4187/gkHGjXjmTe1zOHYuzxaCOpwuTnUbOJr
         FIXRE6erFYVhipq4XqQMl7bpzzr4VPliiEX5dX10pMbjmOsBw7M6460UnsfIxg6JSA+d
         edyg==
X-Gm-Message-State: AOAM530xwfDFIkzzKmfpv0y+vCHM3svnniDrfbneWJxnDGQdyTqhr1NR
        +LSjHOvYZRHuPd0SpAwMKro=
X-Google-Smtp-Source: ABdhPJy1errmzyynWPa3ewKLZyjUWzm63irnwwd8zEtqQmGGqnOkU/D4lBRwVA3CX9TPyUVedCULLw==
X-Received: by 2002:a05:6a00:810:b029:2ec:3b54:6a89 with SMTP id m16-20020a056a000810b02902ec3b546a89mr13064663pfk.0.1622980654096;
        Sun, 06 Jun 2021 04:57:34 -0700 (PDT)
Received: from localhost (60-242-147-73.tpgi.com.au. [60.242.147.73])
        by smtp.gmail.com with ESMTPSA id s33sm5306006pfw.150.2021.06.06.04.57.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Jun 2021 04:57:33 -0700 (PDT)
Date:   Sun, 06 Jun 2021 21:57:27 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v4 00/15] Add futex2 syscalls
To:     =?iso-8859-1?b?QW5kcuk=?= Almeida <andrealmeid@collabora.com>,
        Andrey Semashev <andrey.semashev@gmail.com>
Cc:     acme@kernel.org, Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        corbet@lwn.net, Davidlohr Bueso <dave@stgolabs.net>,
        Darren Hart <dvhart@infradead.org>, fweimer@redhat.com,
        joel@joelfernandes.org, kernel@collabora.com,
        krisman@collabora.com, libc-alpha@sourceware.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, malteskarupke@fastmail.fm,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        pgriffais@valvesoftware.com, Peter Oskolkov <posk@posk.io>,
        Steven Rostedt <rostedt@goodmis.org>, shuah@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, z.figura12@gmail.com
References: <20210603195924.361327-1-andrealmeid@collabora.com>
        <1622799088.hsuspipe84.astroid@bobo.none>
        <fb85fb20-5421-b095-e68b-955afa105467@collabora.com>
        <1622853816.mokf23xgnt.astroid@bobo.none>
        <6d8e3bb4-0cef-b991-9a16-1f03d10f131d@gmail.com>
In-Reply-To: <6d8e3bb4-0cef-b991-9a16-1f03d10f131d@gmail.com>
MIME-Version: 1.0
Message-Id: <1622980258.cfsuodze38.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Excerpts from Andrey Semashev's message of June 5, 2021 6:56 pm:
> On 6/5/21 4:09 AM, Nicholas Piggin wrote:
>> Excerpts from Andr=C3=A9 Almeida's message of June 5, 2021 6:01 am:
>>> =C3=80s 08:36 de 04/06/21, Nicholas Piggin escreveu:
>>=20
>>>> I'll be burned at the stake for suggesting it but it would be great if
>>>> we could use file descriptors. At least for the shared futex, maybe
>>>> private could use a per-process futex allocator. It solves all of the
>>>> above, although I'm sure has many of its own problem. It may not play
>>>> so nicely with the pthread mutex API because of the whole static
>>>> initialiser problem, but the first futex proposal did use fds. But it'=
s
>>>> an example of an alternate API.
>>>>
>>>
>>> FDs and futex doesn't play well, because for futex_wait() you need to
>>> tell the kernel the expected value in the futex address to avoid
>>> sleeping in a free lock. FD operations (poll, select) don't have this
>>> `value` argument, so they could sleep forever, but I'm not sure if you
>>> had taken this in consideration.
>>=20
>> I had. The futex wait API would take a fd additional. The only
>> difference is the waitqueue that is used when a sleep or wake is
>> required is derived from the fd, not from an address.
>>=20
>> I think the bigger sticking points would be if it's too heavyweight an
>> object to use (which could be somewhat mitigated with a simpler ida
>> allocator although that's difficult to do with shared), and whether libc
>> could sanely use them due to the static initialiser problem of pthread
>> mutexes.
>=20
> The static initialization feature is not the only benefit of the current=20
> futex design, and probably not the most important one. You can work=20
> around the static initialization in userspace, e.g. by initializing fd=20
> to an invalid value and creating a valid fd upon the first use. Although=20
> that would still incur a performance penalty and add a new source of=20
> failure.

Sounds like a serious problem, but maybe it isn't. On the other hand,
maybe we don't have to support pthread mutexes as they are anyway=20
because futex already does that fairly well.

> What is more important is that waiting on fd always requires a kernel=20
> call. This will be terrible for performance of uncontended locks, which=20
> is the majority of time.

No. As I said just before, it would be the same except the waitqueue is=20
derived from fd rather than address.

>=20
> Another important point is that a futex that is not being waited on=20
> consumes zero kernel resources while fd is a limited resource even when=20
> not used. You can have millions futexes in userspace and you are=20
> guaranteed not to exhaust any limit as long as you have memory. That is=20
> an important feature, and the current userspace is relying on it by=20
> assuming that creating mutexes and condition variables is cheap.

Is it an important feture? Would 1 byte of kernel memory per uncontended=20
futex be okay? 10? 100?

I do see it's very nice the current design that requires no=20
initialization for uncontended, I'm just asking questions to get an idea=20
of what constraints we're working with. We have a pretty good API=20
already which can support unlimited uncontended futexes, so I'm=20
wondering do we really need another very very similar API that doesn't
fix the really difficult problems of the existing one?

Thanks,
Nick

> Having futex fd would be useful in some cases to be able to integrate=20
> futexes with IO. I did have use cases where I would have liked to have=20
> FUTEX_FD in the past. These cases arise when you already have a thread=20
> that operates on fds and you want to avoid having a separate thread that=20
> blocks on futexes in a similar fashion. But, IMO, that should be an=20
> optional opt-in feature. By far, not every futex needs to have an fd.=20
> For just waiting on multiple futexes, the native support that futex2=20
> provides is superior.
>=20
> PS: I'm not asking FUTEX_FD to be implemented as part of futex2 API.=20
> futex2 would be great even without it.
