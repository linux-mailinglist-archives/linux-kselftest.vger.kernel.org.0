Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A780539EDCB
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Jun 2021 06:46:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229526AbhFHEso (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Jun 2021 00:48:44 -0400
Received: from mail-pf1-f171.google.com ([209.85.210.171]:44898 "EHLO
        mail-pf1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbhFHEso (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Jun 2021 00:48:44 -0400
Received: by mail-pf1-f171.google.com with SMTP id u18so14754462pfk.11;
        Mon, 07 Jun 2021 21:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=shODUYCaNFDiwECqxn3wjQe6HiQJ4Xmfy6/QLkqCTj0=;
        b=QKOwrNn5pHgz+CO/6OengGsrAXQu/41qkmyIy8Sd4hqTRJb4WyhwEPIyJ7KTeTmb1f
         tgGNdpezdeaUWAjRN4ouV90wX8AMl2hAztyIV5KFLK4IGrHYPrKWrYApmg/RKq4LkHEw
         g+s1z4Crgb2ovl3x+duG0KHMz/JjHdsF1cXufhJWPzRVyFmi7vsGUnrb+k4jlh0VnLOC
         IAhLhXzgNEhXfuNpfQsNhHHwQnEVQ864qDtVc6WR06mA+9XNkZ/WP4wZbWPcB//HaMtp
         ndreGPmkrEsvkXquouv4PHE7iSKTL5xWlQ+SeuX5PqRh+LfPz/Dr0v6MTgRRhv74iqfV
         UEEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=shODUYCaNFDiwECqxn3wjQe6HiQJ4Xmfy6/QLkqCTj0=;
        b=CavkB6x5CjO1QgkL5oEN6n3/ra33YMsN7d1R9MzMX6/tUa+VPxG4hY7s1mHkeECXsk
         Ghh+Ldgp/FHAHyXgRa5L6RkA/no+ZbNQ/C9mLZmmTKpQpIQNN71aK2TC641UplRk4Vd5
         NKRTcQYdSYfFBC8EipWIteGth1HD1/9HAtAsVPdKFuDQwzPBRfX60w3Az5rWvBYVjXLF
         exz+oRsD8a4vtt6pQWtcfT2TkiidM7ymsnF5QqdE4jHiSnp5CtOrbyg2UvxcPlR0nFgo
         fwd1NNuxzNkFCtoCqqt/OZITe+WMyD1OVvutSyVg7cMZUQVs9707QwgeMFArCwQeMe99
         NWzQ==
X-Gm-Message-State: AOAM5304L/ePaelDu6dZRh4tJuUInO0tdoXlqcdiBohY5X28Zfv2FvDy
        mClo95CAyzP4GoPFXHs0O5M=
X-Google-Smtp-Source: ABdhPJzo/Il7mH42sxJ9pqb+2MljKEc8Fi+ttQDpWQawgD1x5JDzvIavvyCaTIekl88MdUSoxOAf3g==
X-Received: by 2002:a62:60c4:0:b029:2ca:ebf7:cd0d with SMTP id u187-20020a6260c40000b02902caebf7cd0dmr20270348pfb.71.1623127536730;
        Mon, 07 Jun 2021 21:45:36 -0700 (PDT)
Received: from localhost (60-242-147-73.tpgi.com.au. [60.242.147.73])
        by smtp.gmail.com with ESMTPSA id v11sm950423pju.27.2021.06.07.21.45.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 21:45:36 -0700 (PDT)
Date:   Tue, 08 Jun 2021 14:45:31 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v4 00/15] Add futex2 syscalls
To:     =?iso-8859-1?b?QW5kcu+/vQ==?= Almeida <andrealmeid@collabora.com>,
        Davidlohr Bueso <dave@stgolabs.net>
Cc:     acme@kernel.org, Andrey Semashev <andrey.semashev@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        corbet@lwn.net, Darren Hart <dvhart@infradead.org>,
        fweimer@redhat.com, joel@joelfernandes.org, kernel@collabora.com,
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
        <22137ccd-c5e6-9fcc-a176-789558e9ab1e@collabora.com>
        <20210608023302.34yzrm5ktf3qvxhq@offworld>
In-Reply-To: <20210608023302.34yzrm5ktf3qvxhq@offworld>
MIME-Version: 1.0
Message-Id: <1623125574.l2jo2w0x2v.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Excerpts from Davidlohr Bueso's message of June 8, 2021 12:33 pm:
> On Mon, 07 Jun 2021, Andr=C3=AF=C2=BF=C2=BD Almeida wrote:
>=20
>>=C3=80s 22:09 de 04/06/21, Nicholas Piggin escreveu:
>>> Actually one other scalability thing while I remember it:
>>>
>>> futex_wait currently requires that the lock word is tested under the
>>> queue spin lock (to avoid consuming a wakeup). The problem with this is
>>> that the lock word can be a very hot cache line if you have a lot of
>>> concurrency, so accessing it under the queue lock can increase queue
>>> lock hold time.
>>>
>>> I would prefer if the new API was relaxed to avoid this restriction
>>> (e.g., any wait call may consume a wakeup so it's up to userspace to
>>> avoid that if it is a problem).
>>
>>Maybe I'm wrong, but AFAIK the goal of checking the lock word inside the
>>spin lock is to avoid sleeping forever (in other words, wrongly assuming
>>that the lock is taken and missing a wakeup call), not to avoid
>>consuming wakeups. Or at least this is my interpretation of this long
>>comment in futex.c:
>>
>>https://elixir.bootlin.com/linux/v5.12.9/source/kernel/futex.c#L51
>=20
> I think what Nick is referring to is that futex_wait() could return 0
> instead of EAGAIN upon a uval !=3D val condition if the check is done
> without the hb lock. The value could have changed between when userspace
> did the condition check and called into futex(2) to block in the slowpath=
.

I just mean the check could be done after queueing ourselves on the wait=20
queue (and unlocking the waitqueue lock, not checking while holding the
lock). That is the standard pattern used everywhere else by the kernel:

  prepare_to_wait() /* -> lock; add_wait_queue; unlock; */
  check_again();
  schedule();

It can still return EAGAIN if there is a reasonable use for it, but I'd
be wary about user code that cares about this -- it's racy you could=20
arrive right before the value changes or right after it changes, so any
user code checking this I would be suspicious of (I'm willing to see a
use case that really cares).

>=20
> But such spurious scenarios should be pretty rare, and while I agree that
> the cacheline can be hot, I'm not sure how much of a performance issue th=
is
> really is(?),

It's not a spurious anything. The problem is the contention on the
lock word cacheline means it can take a relatively long time just to perfor=
m
that one load instruction. Mandating that it must be done while holding the
lock translates to increased lock hold times.

This matters particularly in situations that have lock stealing,=20
optimistic spinning, reader-writer locks or more exotic kind of things=20
that allow some common types of critical section to go through while others
are blocking. And partiuclarly when such things hash collide on other
futexes that share the same hash lock.

> compared to other issues, certainly not to govern futex2
> design. Changing such semantics would be a _huge_ difference between fute=
x1
> and futex2.

futex1 behaviour should not govern futex2 design. That's the only nice=20
thing you get with an API change, so we should take full advantage of=20
it. I'm not saying make changes for no reason, but I gave a reason, so=20
that should be countered with a better reason to not change.

Thanks,
Nick

>=20
> At least compared, for example, to the hb collisions serializing independ=
ent
> futexes, affecting both performance and determinism. And I agree that a n=
ew
> interface should address this problem - albeit most of the workloads I ha=
ve
> seen in production use but a handful of futexes and larger thread counts.
> One thing that crossed my mind (but have not actually sat down to look at=
)
> would be to use rlhastables for the dynamic resizing, but of course that =
would
> probably add a decent amount of overhead to the simple hashing we current=
ly have.
