Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 305FF32F45F
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Mar 2021 21:04:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbhCEUDt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 5 Mar 2021 15:03:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbhCEUDq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 5 Mar 2021 15:03:46 -0500
Received: from mail-vk1-xa2f.google.com (mail-vk1-xa2f.google.com [IPv6:2607:f8b0:4864:20::a2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39B3EC06175F
        for <linux-kselftest@vger.kernel.org>; Fri,  5 Mar 2021 12:03:46 -0800 (PST)
Received: by mail-vk1-xa2f.google.com with SMTP id k191so780389vke.2
        for <linux-kselftest@vger.kernel.org>; Fri, 05 Mar 2021 12:03:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=posk.io; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=kiHawXjZWgAjYt2/PWHI9qp4OqUqrMh9Xa8nm6q2QIw=;
        b=MFbpEEPmoFG2NoP7tSwO8q7FKQ0YRUcWQXFKn/uuMGP7rcKL0MOuyM+K+Usrv6Ha0L
         rxzZLQ28Vxp/7vOPOvwEmzliXAAWqL4YRUhor2REng2qYvSJB1jQbSgayaF8VE9ViAFw
         kcfNc/R+zStIAn4fUmx5YOkvyiNM4YVSgyUPaM17qk9BNjQuXX3aOGMJUHka5JMQxSQl
         OgGfeMYBgfnDVN8tYCPBJmvwH7cSnSxhOIO2ZBrVnESZqvqBbedh30Uefo2hcbH6h/ZA
         Ml/5PaD9pQ2ut21mbMwJd9BppCPXyoYA0kf/UIfaBiMTpdzGG1wmy/sFN3vSu4FylzvD
         lK0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=kiHawXjZWgAjYt2/PWHI9qp4OqUqrMh9Xa8nm6q2QIw=;
        b=hz6X7Ifr326VewsXRPWIiUm72QUoJ0ymSB80H1Nw60qIRVlXBOMzD8FkLfKycCYX59
         hw8m4/ksMApExvAlBuai+afQjo9Uc35txh7o7AYi88F1RQP77swKwfUURACYNin7t7yY
         KoPIHQroeYYKC3OzBNhoHS1clXMzfFCw4GEGiS7yd5Ehxj+c8+3kHV8Eb9d6x/3TYjw7
         mmht2PG9csVJ63NjvcNODAuxXP98pnJZQ8SZMy52et8TGMX+rCSWOm+D+kuklTrIMZfn
         qRO94Ekyf2NZdaBk3wCTP5KurDtNNVpCNtj8W9HW8k+rdkZUkgb6CmgXL8gkUOrcj/jF
         M7Qg==
X-Gm-Message-State: AOAM530WVMd9Ho5y/X7wCcA5+2W5z4Zklg2IdEcUOUu8d1xWKx6OXCL3
        5+A2+uZhjxQC1d82fI8kfAS7lOH8V8RQ/nEi0yndhQ==
X-Google-Smtp-Source: ABdhPJz60xVl1ZYaln9nyviiEi9780obcM8gamG9sdIRw5IwIWKNZJrRjnclEsxetkOreKb/2zy6F8jn/4eF3lsgcTI=
X-Received: by 2002:a05:6122:80e:: with SMTP id 14mr8245587vkj.17.1614974625319;
 Fri, 05 Mar 2021 12:03:45 -0800 (PST)
MIME-Version: 1.0
References: <20210304004219.134051-1-andrealmeid@collabora.com>
 <CAFTs51XAr2b3DmcSM4=qeU5cNuh0mTxUbhG66U6bc63YYzkzYA@mail.gmail.com> <bc54423b-753f-44be-4e4f-4535e27ad35c@collabora.com>
In-Reply-To: <bc54423b-753f-44be-4e4f-4535e27ad35c@collabora.com>
From:   Peter Oskolkov <posk@posk.io>
Date:   Fri, 5 Mar 2021 12:03:34 -0800
Message-ID: <CAFTs51VEj7hVfohcNNqOJtJYkDQ_pd76HAmJWWUFKbiMwsewAw@mail.gmail.com>
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

Hi Andr=C3=A9!

On Thu, Mar 4, 2021 at 10:58 AM Andr=C3=A9 Almeida <andrealmeid@collabora.c=
om> wrote:
>
> Hi Peter,
>
> =C3=80s 02:44 de 04/03/21, Peter Oskolkov escreveu:
> > On Wed, Mar 3, 2021 at 5:22 PM Andr=C3=A9 Almeida <andrealmeid@collabor=
a.com> wrote:
> >>
> >> Hi,
> >>
> >> This patch series introduces the futex2 syscalls.
> >>
> >> * FAQ
> >>
> >>   ** "And what's about FUTEX_64?"
> >>
> >>   By supporting 64 bit futexes, the kernel structure for futex would
> >>   need to have a 64 bit field for the value, and that could defeat one=
 of
> >>   the purposes of having different sized futexes in the first place:
> >>   supporting smaller ones to decrease memory usage. This might be
> >>   something that could be disabled for 32bit archs (and even for
> >>   CONFIG_BASE_SMALL).
> >>
> >>   Which use case would benefit for FUTEX_64? Does it worth the trade-o=
ffs?
> >
> > The ability to store a pointer value on 64bit platforms is an
> > important use case.
> > Imagine a simple producer/consumer scenario, with the producer updating
> > some shared memory data and waking the consumer. Storing the pointer
> > in the futex makes it so that only one shared memory location needs to =
be
> > accessed "atomically", etc. With two atomics synchronization becomes
> > more involved (=3D slower).
> >
>
> So the idea is to, instead of doing this:
>
> T1:
> atomic_set(&shm_addr, buffer_addr);
> atomic_set(&futex, 0);
> futex_wake(&futex, 1);
>
> T2:
> consume(shm_addr);
>
> To do that:
>
> T1:
> atomic_set(&futex, buffer_addr);
> futex_wake(&futex, 1);
>
> T2:
> consume(futex);
>
> Right?

More like this:

T1 (producer):
while (true) {
    ptr =3D get_new_data();
    atomic_set(&futex, ptr);
    futex_wake(&futex, 1);
}

T1 (consumer):
some_data *prev =3D NULL;
while (true) {
  futex_wait(&futex, prev);
  some_data *next =3D atomic_get(&futex);
  if (next =3D=3D prev) continue;  /* spurious wakeup */

  consume_data(next);
  prev =3D next;
}



>
> I'll try to write a small test to see how the perf numbers looks like.
