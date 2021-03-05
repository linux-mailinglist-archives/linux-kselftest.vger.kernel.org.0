Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB99E32F475
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Mar 2021 21:09:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbhCEUJ1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 5 Mar 2021 15:09:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbhCEUJJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 5 Mar 2021 15:09:09 -0500
Received: from mail-ua1-x931.google.com (mail-ua1-x931.google.com [IPv6:2607:f8b0:4864:20::931])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F23F6C061761
        for <linux-kselftest@vger.kernel.org>; Fri,  5 Mar 2021 12:09:08 -0800 (PST)
Received: by mail-ua1-x931.google.com with SMTP id s7so1178514uag.7
        for <linux-kselftest@vger.kernel.org>; Fri, 05 Mar 2021 12:09:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=posk.io; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=OoEQcJMAXbKGiyGxQKoGUMRplynTrICw/5hDPty3yZg=;
        b=VOVVw2fToUk/FFTb887ylcSaKHUDdOyUATvz5jwVACZgjcjagl7CPvAY+ly7mqfBaa
         NosyHQ8VlJ5++M2+HST5/dlDTiVr9J3pKpmuPWHRczv2vvR8Qi3FL1EZTYNGdBAPuB2W
         VS8sVIIzt+F1Kr4aUA0PtogNNejWAcspzSgzPHiH+ota8U2Pmfh5FT51YVVPeeCAxZLL
         AR8EYtyEQOBb9pr/BQ06SEtTyoWcSuE9aCWyAAYSeSlDyQbpD5nC6RA97ymnLouy0Gt7
         HyvWJedpZ2tHVnqFPD8yreTxGdFQFG0r6s0ryP32gKEgjbzy0BWbZErJigjgQEzRI9M5
         SaYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=OoEQcJMAXbKGiyGxQKoGUMRplynTrICw/5hDPty3yZg=;
        b=D7i7tX9YvNZu3VZoXxYxWrXrbNviaUrUkvLjd55wIXkGzSERi4QKaOElADOC4FZWOF
         wqDBy4tQbzs0ZxmNVkvcm6jimAa870n2RK/vTo047A7cLC22bZWVlVyEPhZh5hbW1ceu
         7wiMhu0m8+h3gPbAZSQDiJBfwZWWogq4Wd8HwYJhmHuZFV/asbF3lr/qHXxBNzHhmMRM
         /nUFsJ8lSSmmTRe0ju0st8dKDsRBUy4XZ0GXGsgcsnOy2J19Rxm93EWCPtvuHV1vyVME
         xKL1dczAcSf9yB5k70QMYbqszXVRaPwW63w34kcy1d9VKoiG7dK4k2TvixCOe41Uk4X8
         4GCg==
X-Gm-Message-State: AOAM530Ook9FDGU+YHfzRmnA5Iw/cS+GhMe9HLEc590kKDvXxMQkIZB7
        wWKNS0i6B1DunegelltuR3iE7YgZJcpsS6J0ZD4Ekg==
X-Google-Smtp-Source: ABdhPJxS5h1EWUlNojwKpAP6JsCTcU4eYmSz+ZPFdFA3w4oqj3bAZTccNG15l+jdS6okRPOdrUvinWVhN5F98cyCmjI=
X-Received: by 2002:ab0:29d2:: with SMTP id i18mr7596987uaq.71.1614974947963;
 Fri, 05 Mar 2021 12:09:07 -0800 (PST)
MIME-Version: 1.0
References: <20210304004219.134051-1-andrealmeid@collabora.com>
 <CAFTs51XAr2b3DmcSM4=qeU5cNuh0mTxUbhG66U6bc63YYzkzYA@mail.gmail.com>
 <bc54423b-753f-44be-4e4f-4535e27ad35c@collabora.com> <CAFTs51VEj7hVfohcNNqOJtJYkDQ_pd76HAmJWWUFKbiMwsewAw@mail.gmail.com>
In-Reply-To: <CAFTs51VEj7hVfohcNNqOJtJYkDQ_pd76HAmJWWUFKbiMwsewAw@mail.gmail.com>
From:   Peter Oskolkov <posk@posk.io>
Date:   Fri, 5 Mar 2021 12:08:54 -0800
Message-ID: <CAFTs51XnZFRHcw9qgpD-ZoQJa=WRU9c0y1ZJB1-xk6=7TmMhNA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 00/13] Add futex2 syscall
To:     =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@collabora.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        kernel@collabora.com, krisman@collabora.com,
        pgriffais@valvesoftware.com, z.figura12@gmail.com,
        joel@joelfernandes.org, malteskarupke@fastmail.fm,
        linux-api@vger.kernel.org, fweimer@redhat.com,
        libc-alpha@sourceware.org, linux-kselftest@vger.kernel.org,
        shuah@kernel.org, acme@kernel.org, Jonathan Corbet <corbet@lwn.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Mar 5, 2021 at 12:03 PM Peter Oskolkov <posk@posk.io> wrote:
>
> Hi Andr=C3=A9!
>
> On Thu, Mar 4, 2021 at 10:58 AM Andr=C3=A9 Almeida <andrealmeid@collabora=
.com> wrote:
> >
> > Hi Peter,
> >
> > =C3=80s 02:44 de 04/03/21, Peter Oskolkov escreveu:
> > > On Wed, Mar 3, 2021 at 5:22 PM Andr=C3=A9 Almeida <andrealmeid@collab=
ora.com> wrote:
> > >>
> > >> Hi,
> > >>
> > >> This patch series introduces the futex2 syscalls.
> > >>
> > >> * FAQ
> > >>
> > >>   ** "And what's about FUTEX_64?"
> > >>
> > >>   By supporting 64 bit futexes, the kernel structure for futex would
> > >>   need to have a 64 bit field for the value, and that could defeat o=
ne of
> > >>   the purposes of having different sized futexes in the first place:
> > >>   supporting smaller ones to decrease memory usage. This might be
> > >>   something that could be disabled for 32bit archs (and even for
> > >>   CONFIG_BASE_SMALL).
> > >>
> > >>   Which use case would benefit for FUTEX_64? Does it worth the trade=
-offs?
> > >
> > > The ability to store a pointer value on 64bit platforms is an
> > > important use case.
> > > Imagine a simple producer/consumer scenario, with the producer updati=
ng
> > > some shared memory data and waking the consumer. Storing the pointer
> > > in the futex makes it so that only one shared memory location needs t=
o be
> > > accessed "atomically", etc. With two atomics synchronization becomes
> > > more involved (=3D slower).
> > >
> >
> > So the idea is to, instead of doing this:
> >
> > T1:
> > atomic_set(&shm_addr, buffer_addr);
> > atomic_set(&futex, 0);
> > futex_wake(&futex, 1);
> >
> > T2:
> > consume(shm_addr);
> >
> > To do that:
> >
> > T1:
> > atomic_set(&futex, buffer_addr);
> > futex_wake(&futex, 1);
> >
> > T2:
> > consume(futex);
> >
> > Right?
>
> More like this:
>
> T1 (producer):
> while (true) {
>     ptr =3D get_new_data();
>     atomic_set(&futex, ptr);
>     futex_wake(&futex, 1);
> }
>
> T1 (consumer):
> some_data *prev =3D NULL;
> while (true) {
>   futex_wait(&futex, prev);
>   some_data *next =3D atomic_get(&futex);
>   if (next =3D=3D prev) continue;  /* spurious wakeup */
>
>   consume_data(next);
>   prev =3D next;
> }

Or an even more complete example:

T1 (producer):
while (true) {
    next =3D get_new_data();
    atomic_set(&futex, next);
    futex_wake(&futex, 1);

   /* wait for the consumer */
   prev =3D next;
   do {
     next =3D atomic_get(&futex);
     futex_wait(&futex, prev);
  } while (next !=3D NULL);

}

T2 (consumer):
some_data *prev =3D NULL;
while (true) {
    futex_wait(&futex, prev);
    some_data *next =3D atomic_get(&futex);
    if (next =3D=3D prev) continue;  /* spurious wakeup */

    consume_data(next);
    prev =3D next;
    atomic_set(&futex, NULL);
    futex_wake(&futex, 1); /* signal we can consumer more */
}

>
>
>
> >
> > I'll try to write a small test to see how the perf numbers looks like.
