Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0CD039EB7E
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Jun 2021 03:32:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230314AbhFHBeo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 7 Jun 2021 21:34:44 -0400
Received: from mail-pl1-f170.google.com ([209.85.214.170]:46684 "EHLO
        mail-pl1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbhFHBeo (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 7 Jun 2021 21:34:44 -0400
Received: by mail-pl1-f170.google.com with SMTP id e1so9721199pld.13;
        Mon, 07 Jun 2021 18:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=+55IUd9faOKlON3AM50/e4sWS1IOtqct+NHUgj6zP5Y=;
        b=I7bynfKgdnBBLvd44eWXaXAGwhr85IJOcgyVPQPxuwzs7bS01hJQT07cImT7sge5FL
         4Yuzb5Jqjvnnt0YXkfj5f1r7wreeQLA33OcE9Z1kjnt6jCr43m35D87oAzIJEcaDcDA6
         wEdukHDSDYIW8PbPkLDPnY5PVoIxA6NDBiF70iL6E06XzIlgwgB89AHt+LWixYqImZhI
         DsMJth2vZ7iYoTCUFNRkn7GtYKgm1RT+OdoblchvleVlsUOxHWQU8FKoWYhZQ6+fFEgD
         KxmpCODf0y2bUOu8LHdJTLyVhRjx6Df44WOnCiu6K71ggkwawRMSHH3PA8bnLL3hnkfP
         m2jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=+55IUd9faOKlON3AM50/e4sWS1IOtqct+NHUgj6zP5Y=;
        b=E0XrtCeHaBfrwFnbdc8PZwSh1ETJZaCkHm8e8wf/5TxvBptpMy19mhNcEvekWeWy0i
         ZvbCqle5PzZpsejVnbREVeGJTvm2vtYakTIKKnVRqX7H5Ze75VgkwkqEQFK9fzQljDkS
         AQ/aeZMPGO7qdhsJKrpCv0zujdAEHH6c6m2GZ+fpb8aaaDiVE77QpQ34HXdWZtpsX0q+
         C2G77f7ogUxEBOnT8nW7TLTa5D2iDBCm7f/r9AI+WphfiWnChNg0VoJQCtPwmdHjkqDg
         MW57JkUaA4NWwwYLn1VbN8yfQas+v/9+EZm64yge3de2hxFkVc9tO9kHQVfX6HB52YD0
         Ubpw==
X-Gm-Message-State: AOAM533zVShJmOmlz+NgOgvzOiZ7huVRDqB/PunifPcTQMO+k11zdRVJ
        0T/T5j8An2RrkvF41DtC8/Q=
X-Google-Smtp-Source: ABdhPJxzNenfqYzlLHZ5eirHgCFBB0+W/ItTE79oTbZKdGJR5F6Mvr6idXXOeD337msTBG0bKOxBqg==
X-Received: by 2002:a17:90a:4298:: with SMTP id p24mr2064361pjg.144.1623115898512;
        Mon, 07 Jun 2021 18:31:38 -0700 (PDT)
Received: from localhost (60-242-147-73.tpgi.com.au. [60.242.147.73])
        by smtp.gmail.com with ESMTPSA id e17sm9043906pfi.131.2021.06.07.18.31.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 18:31:38 -0700 (PDT)
Date:   Tue, 08 Jun 2021 11:31:32 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v4 00/15] Add futex2 syscalls
To:     =?iso-8859-1?b?QW5kcuk=?= Almeida <andrealmeid@collabora.com>
Cc:     acme@kernel.org, Andrey Semashev <andrey.semashev@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
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
        <22137ccd-c5e6-9fcc-a176-789558e9ab1e@collabora.com>
In-Reply-To: <22137ccd-c5e6-9fcc-a176-789558e9ab1e@collabora.com>
MIME-Version: 1.0
Message-Id: <1623115538.zsqgffieb0.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Excerpts from Andr=C3=A9 Almeida's message of June 8, 2021 1:40 am:
> =C3=80s 22:09 de 04/06/21, Nicholas Piggin escreveu:
>> Excerpts from Andr=C3=A9 Almeida's message of June 5, 2021 6:01 am:
>>> =C3=80s 08:36 de 04/06/21, Nicholas Piggin escreveu:
>>>> Excerpts from Andr=C3=A9 Almeida's message of June 4, 2021 5:59 am:
>>>> - Did you consider a wakev interface? An example is a read-write mutex=
=20
>>>> which has read-blocking futexes split (e.g., per-node) for scalability=
=20
>>>> then the writer may unlock and wake all readers with one call. We=20
>>>> actually have some scalability challenges of this nature with certain=20
>>>> large database programs.
>>>>
>>>
>>> Not really, I haven't heard any use case for that until now. It should
>>> be easy to implement it, though, and I think you have an interesting us=
e
>>> case here. Could you point me some of those database programs?
>>=20
>> Not source code unfortunately. I know that's not a very good answer, but=
=20
>> they are far ahead of what most open source apps are doing scalability=20
>> wise today, and they end up rolling their own complex locking. Hopefully
>> the example I give is simple enough to understand.
>>=20
>=20
> I see, that's makes things a bit harder. I understood the use case and
> the wakev can be implemented without affecting the rest of API, so I
> think I'll get back to it later, for now.

Yeah that's fine.

>>>> - Are we really keen on squashing node ID into flags in this day and a=
ge?
>>>> I guess okay but seems like it would be nice to allow a bit more space
>>>> in general for the operations. I don't want to turn it into a whole bi=
g
>>>> multiplexing nightmare again with lots of such flags, or propose
>>>> complexity with no code behind it, but I think we need a bit of leeway
>>>> for unforeseen locking innovations to be added carefully. The pthread
>>>> locking today is still fairly primitive really, I don't think we know
>>>> what will work best for the next 10 years.
>>>
>>> In the interface that I'd proposed, the node ID isn't part of the flags=
.
>>> You have a flag FUTEX_FLAG_NUMA, and when that is used, you pass in
>>> `void *uaddr` a pointer to a `struct futex_numa { int value, int hint
>>> }`, where hint should be the node ID you would like to work on, and
>>> value is just the userspace futex. This is documented in more details i=
n
>>> patch 7 "docs: locking: futex2: Add documentation".
>>>
>>> If you have any feedback about how this NUMA interface looks like, I
>>> would like to hear.
>>>
>>> Also, did something in my writing indicated that the node ID would be
>>> part of the flags? I'll improve this it if so.
>>=20
>> Oh I did miss this, thank you. No it wasn't your writing, I think it was=
=20
>> me trying to read through a lot of messages and got confused with some
>> earlier conversations.
>>=20
>> I'll look a bit more at the NUMA interface.
>>=20
>=20
> Thanks!
>=20
>>>
>>>>
>>>> One scalability issue we are starting to hit and will only get worse i=
s=20
>>>> futex queue spinlock contention. Perhaps this is better addressed in=20
>>>> userspace but the kernel could play a part so I like to leave some doo=
rs
>>>> open. One example is that the wait (or wake) side may like to depend n=
ot
>>>> just on the memory value, but on the success of a cmpxchg to avoid=20
>>>> unqueueing and queueing spuriously, which increases lock contention bu=
t
>>>> also ends up putting the poor task on the back of the list -- yes RT
>>>> priorities can help the realtime case, but non-RT cases can get bad
>>>> outlier latencies if lock stealing is allowed (which can be very good
>>>> for performance).
>>>>
>>>
>>> Sorry, I'm not sure what do you mean here. Are you proposing to have a
>>> cmpxchg in kernel side, so the lock would be taken by the kernel, and
>>> not by the userspace like it's now?
>>=20
>> Yes. Only in slow paths, of course, to reduce starvation / erratic
>> latencies and spurious wait queue manipulations.
>=20
> Right, so if we need to go into the kernel to do the cmpxchg, we can't
> take a free lock without a syscall,

Yes you can.

> and this goes against the futex
> semantics, the "strength" of this interface is to not require context
> switch in uncontended cases.
>=20
> Is not a bad thing itself to go into the kernel to get a lock, other
> operating systems do that and if the kernel has more knowledge about who
> has the lock, it can even make some smart decisions. But this is not
> futex, this probably belongs to another interface (that's probably
> slower in the common case than futex).
>=20
>>=20
>> Actually one other scalability thing while I remember it:
>>=20
>> futex_wait currently requires that the lock word is tested under the=20
>> queue spin lock (to avoid consuming a wakeup). The problem with this is=20
>> that the lock word can be a very hot cache line if you have a lot of
>> concurrency, so accessing it under the queue lock can increase queue
>> lock hold time.
>>=20
>> I would prefer if the new API was relaxed to avoid this restriction
>> (e.g., any wait call may consume a wakeup so it's up to userspace to
>> avoid that if it is a problem).
>=20
> Maybe I'm wrong, but AFAIK the goal of checking the lock word inside the
> spin lock is to avoid sleeping forever (in other words, wrongly assuming
> that the lock is taken and missing a wakeup call), not to avoid
> consuming wakeups. Or at least this is my interpretation of this long
> comment in futex.c:
>=20
> https://elixir.bootlin.com/linux/v5.12.9/source/kernel/futex.c#L51
>=20
> So removing this requirement of checking the futex word with the lock
> taken could led to undesirable behavior.

No, there are two requirements. Obviously you need to avoid the missed
wakeup at minimum. You don't need to check under the lock unless you
want to avoid consuming an extra wakeup though (it can possibly be done
in more complex ways like you detect if you took a wakeup and if so then
look at the queue and see if you can pass it on, or have some extra flag
to signal you are ready for wake up, but those all seem more complex and
fragile and possibly have weird corner cases, better to just set out=20
that userspace should deal with it).

>=20
>>=20
>>>> - The private global futex hash table sucks for various reasons, and
>>>> having 128 waiters per thread makes it orders of magnitude easier for
>>>> userspace to DoS stuff with hash collisions. NUMA doesn't fix that, th=
e
>>>> per process hashing that Thomas suggested does fix the DoS but the
>>>> non-deterministic hash collisions still seem to be a problem for real
>>>> time response, and at the other end of the scale some apps (certain=20
>>>> databases, etc) can have ten thousand futex waiters at once so birthda=
y
>>>> paradox can also lead to guaranteed (low level) variable beahviour=20
>>>> within a single process.
>>>>
>>>> I know the kernel in general is not very robust against this kind of=20
>>>> DoS/nondeterminism, but it's a bit sad to introduce new APIs with the=20
>>>> problem still there. Yes we could address it later, but I think it's=20
>>>> better done first because the solution might influence what the best=20
>>>> syscall API is.
>>>>
>>>> For example the idea of using the address as the handle for the wait=20
>>>> queue _and_ the value is very convenient but hashing is annoying for
>>>> all the above reasons and the shared wait queue case is pretty clunky.=
=20
>>>> It's also constraining in some corner cases to have the wait queue=20
>>>> associated with the address 1:1. For example a type of NUMA mutex migh=
t=20
>>>> want to have per-node waitqueues associated with a lock word, and wake
>>>> local node waiters 99% of the time. Not trivial to do with futexes and
>>>> seems to at least require bouncing of more cache lines, possibly more
>>>> atomics, etc.
>>>>
>>>> Could anything else be done?
>>>
>>> I wasn't aware that userspace doing DoS is something to be concerned
>>> from the kernel point of view. Is this scenario considering a malicious
>>> actor? If so, there are plenty of resources to be denied, so not sure
>>> how futex could be protected of this. Or is this just a program that
>>> uses tons of futexes?
>>=20
>> Both really. AFAIKS one of the efforts that prompted the futex=20
>> modernisation work was the RT latency issues from Thomas in 2016 when=20
>> the per process table was proposed.
>>=20
>=20
> When I first read Thomas proposal for per table process, I thought that
> the main goal there was to solve NUMA locality issues, not RT latency,
> but I think you are right. However, re-reading the thread at [0], it
> seems that the RT problems where not completely solved in that
> interface, maybe the people involved with that patchset can help to shed
> some light on it.
>=20
> Otherwise, this same proposal could be integrated in futex2, given that
> we would only need to provide to userland some extra flags and add some
> `if`s around the hash table code (in a very similar way the NUMA code
> will be implemented in futex2).
>=20
> [0] https://lore.kernel.org/lkml/20160505204230.932454245@linutronix.de/

Right. The accidental collisions within a process (or=20
accidental/deliberate collisions with shared futex) problems remain.

Thanks,
Nick
