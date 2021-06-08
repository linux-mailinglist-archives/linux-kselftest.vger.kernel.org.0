Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2581839EB52
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Jun 2021 03:25:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230426AbhFHB1f (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 7 Jun 2021 21:27:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230209AbhFHB1e (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 7 Jun 2021 21:27:34 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1C63C061574;
        Mon,  7 Jun 2021 18:25:28 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id ei4so10914437pjb.3;
        Mon, 07 Jun 2021 18:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=9or9kWeQKVtCH1EkhikcuqwJeODMnwDBrNDPM5zN6nU=;
        b=FU2f2964xr/SgPnmutRsW6uD26YSGVNtLh9+uxsZO/AfzPvIjiC8uJ9ZZoC+5Y8+GJ
         lC0enHqvNWQ2iU+TWuzaMlWTEO2gpkdu6gqV7atUVyigpChnNs4b1iF64OYcY+VxWvPe
         9R/wY7B5JXubweemSLcHlVUMiydHC/eXj6U13s65RJhLguObeVQXadeNmZp6kFB1aMw7
         MiqCiYDuifvX6rhXvKJRKoJnM0QjvfdwwwEDcRYamiricKMzUdOkf4Kb4KSbP/pLVG6+
         WQRZCJJUROcwcGGvAqyAGbrn/clMPck8rfXiWBDN4RJ2sANJYhCHtk+vxsXBS9og8VM1
         x2cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=9or9kWeQKVtCH1EkhikcuqwJeODMnwDBrNDPM5zN6nU=;
        b=ZKNFLmJUUjpYWAyM4Z1fsC5GrDSlfaOC7jY0pOik1Zeeoc1iuIIk82EOW0Iv/eQicK
         SETSlxUYSb0bVxSF3NlSkcreTLTEzXjuLwKk3S4FS4J77MR7xoqdTw6tEG9evFQYuNkZ
         6o/o9m5/1b8y9uvzQFJHqMZa+lQrM2kX5qVQXyGj5+DpqK80fDnsn5F/C2AUmgelH7aQ
         HKSPhNXhUoovSfleUVGlKwaHG0Ir/EYbf6P21JqNrYTZ+P4WESRdqI3IVQnxcu1j6ptK
         1G5EV11QrdykHdmc7PCpJwkQYNihqNPwLsExOSp8QKDQN+fUHgq+cpmx3uMpmw0g/4L/
         ld/g==
X-Gm-Message-State: AOAM533pKn6Jw/joKduXJf3ROG4fEOtPv7NsJi4vUtpgcK0VhgKOImIJ
        pRx0Bdqkbc986RHBEFjNVK4=
X-Google-Smtp-Source: ABdhPJxQ3AWTk/Bqmrt5PUVUAJ7rGKI8NLaqvgU/Pd/kVL8WtarQF9ZlwxF3SWMyS1qxGLYZrKWOfg==
X-Received: by 2002:a17:90a:3484:: with SMTP id p4mr23645127pjb.2.1623115528135;
        Mon, 07 Jun 2021 18:25:28 -0700 (PDT)
Received: from localhost (60-242-147-73.tpgi.com.au. [60.242.147.73])
        by smtp.gmail.com with ESMTPSA id 11sm9506927pge.57.2021.06.07.18.25.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 18:25:27 -0700 (PDT)
Date:   Tue, 08 Jun 2021 11:25:22 +1000
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
        <1622980258.cfsuodze38.astroid@bobo.none>
        <c6d86db8-4f63-6c57-9a67-6268da266afe@gmail.com>
In-Reply-To: <c6d86db8-4f63-6c57-9a67-6268da266afe@gmail.com>
MIME-Version: 1.0
Message-Id: <1623114630.pc8fq7r5y9.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Excerpts from Andrey Semashev's message of June 6, 2021 11:15 pm:
> On 6/6/21 2:57 PM, Nicholas Piggin wrote:
>> Excerpts from Andrey Semashev's message of June 5, 2021 6:56 pm:
>>> On 6/5/21 4:09 AM, Nicholas Piggin wrote:
>>>> Excerpts from Andr=C3=A9 Almeida's message of June 5, 2021 6:01 am:
>>>>> =C3=80s 08:36 de 04/06/21, Nicholas Piggin escreveu:
>>>>
>>>>>> I'll be burned at the stake for suggesting it but it would be great =
if
>>>>>> we could use file descriptors. At least for the shared futex, maybe
>>>>>> private could use a per-process futex allocator. It solves all of th=
e
>>>>>> above, although I'm sure has many of its own problem. It may not pla=
y
>>>>>> so nicely with the pthread mutex API because of the whole static
>>>>>> initialiser problem, but the first futex proposal did use fds. But i=
t's
>>>>>> an example of an alternate API.
>>>>>>
>>>>>
>>>>> FDs and futex doesn't play well, because for futex_wait() you need to
>>>>> tell the kernel the expected value in the futex address to avoid
>>>>> sleeping in a free lock. FD operations (poll, select) don't have this
>>>>> `value` argument, so they could sleep forever, but I'm not sure if yo=
u
>>>>> had taken this in consideration.
>>>>
>>>> I had. The futex wait API would take a fd additional. The only
>>>> difference is the waitqueue that is used when a sleep or wake is
>>>> required is derived from the fd, not from an address.
>>>>
>>>> I think the bigger sticking points would be if it's too heavyweight an
>>>> object to use (which could be somewhat mitigated with a simpler ida
>>>> allocator although that's difficult to do with shared), and whether li=
bc
>>>> could sanely use them due to the static initialiser problem of pthread
>>>> mutexes.
>>>
>>> The static initialization feature is not the only benefit of the curren=
t
>>> futex design, and probably not the most important one. You can work
>>> around the static initialization in userspace, e.g. by initializing fd
>>> to an invalid value and creating a valid fd upon the first use. Althoug=
h
>>> that would still incur a performance penalty and add a new source of
>>> failure.
>>=20
>> Sounds like a serious problem, but maybe it isn't. On the other hand,
>> maybe we don't have to support pthread mutexes as they are anyway
>> because futex already does that fairly well.
>>=20
>>> What is more important is that waiting on fd always requires a kernel
>>> call. This will be terrible for performance of uncontended locks, which
>>> is the majority of time.
>>=20
>> No. As I said just before, it would be the same except the waitqueue is
>> derived from fd rather than address.
>=20
> Sorry, in that case I'm not sure I understand how that would work. You=20
> do need to allocate a fd, do you?

Yes. As I said, imagine a futex_wait API that also takes a fd. The
wait queue is derived from that fd rather than the hash table.

>>> Another important point is that a futex that is not being waited on
>>> consumes zero kernel resources while fd is a limited resource even when
>>> not used. You can have millions futexes in userspace and you are
>>> guaranteed not to exhaust any limit as long as you have memory. That is
>>> an important feature, and the current userspace is relying on it by
>>> assuming that creating mutexes and condition variables is cheap.
>>=20
>> Is it an important feture? Would 1 byte of kernel memory per uncontended
>> futex be okay? 10? 100?
>>=20
>> I do see it's very nice the current design that requires no
>> initialization for uncontended, I'm just asking questions to get an idea
>> of what constraints we're working with. We have a pretty good API
>> already which can support unlimited uncontended futexes, so I'm
>> wondering do we really need another very very similar API that doesn't
>> fix the really difficult problems of the existing one?
>=20
> It does provide the very much needed features that are missing in the=20
> current futex. Namely, more futex sizes and wait for multiple. So the=20
> argument of "why have two similar APIs" is not quite fair. It would be,=20
> if there was feature parity with futex.

It does provide some extra features sure, with some straightforward=20
extension of the existing API. The really interesting or tricky part of
the API is left unchanged though.

My line of thinking is that while we're changing the API anyway, we=20
should see if it can be changed to help those other problems too.

> I believe, the low cost of a futex is an important feature, and was one=20
> of the reasons for its original design and introduction.

It is of course. The first futex proposal did use fds, interestingly.
I didn't look back further into the libc side of that thing, but maybe
I should.

> Otherwise we=20
> would be using eventfds in mutexes.

I don't think so, not even if eventfd came before the futex syscall.

>=20
> One other feature that I didn't mention earlier and which follows from=20
> its "address in memory" design is the ability to use futexes in=20
> process-shared memory. This is important for process-shared pthread=20
> components, too, but has its own value even without this, if you use=20
> futexes directly. With fds, you can't place the fd in a shared memory=20
> since every process needs to have its own fd referring to the same=20
> kernel object, and passing fds cannot be done without a UNIX socket.=20
> This is incompatible with pthreads API design and would require=20
> non-trivial design changes to the applications using futexes directly.
>=20

That may be true. file is a natural object to share such a resource, but=20
the means to share the fd is not so easy. OTOH you could also use a=20
syscall to open the same file and get a new fd.

Are shared pthread mutexes using existing pthread APIs that are today
implemented okay with futex1 system call a good reason to constrain=20
futex2 I wonder? Or do we have an opportunity to make a bigger change
to the API so it suffers less from non deterministic latency (for
example)?

I don't want to limit it to just files vs addresses, fds was an example=20
of something that could solve some of the problems.

Thanks,
Nick
